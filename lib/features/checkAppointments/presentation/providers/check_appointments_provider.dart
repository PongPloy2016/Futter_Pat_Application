import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/check_appointment_entity.dart';
import '../../domain/usecases/get_check_appointments_usecase.dart';
import '../../../../core/di/injection.dart';

class CheckAppointmentsState {
  final List<CheckAppointmentEntity> allAppointments;
  final List<CheckAppointmentEntity> allFiltered;
  final List<CheckAppointmentEntity> pendingFiltered;
  final bool isLoading;
  final String? error;
  final String searchQuery;

  CheckAppointmentsState({
    this.allAppointments = const [],
    this.allFiltered = const [],
    this.pendingFiltered = const [],
    this.isLoading = false,
    this.error,
    this.searchQuery = '',
  });

  CheckAppointmentsState copyWith({
    List<CheckAppointmentEntity>? allAppointments,
    List<CheckAppointmentEntity>? allFiltered,
    List<CheckAppointmentEntity>? pendingFiltered,
    bool? isLoading,
    String? error,
    String? searchQuery,
  }) {
    return CheckAppointmentsState(
      allAppointments: allAppointments ?? this.allAppointments,
      allFiltered: allFiltered ?? this.allFiltered,
      pendingFiltered: pendingFiltered ?? this.pendingFiltered,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class CheckAppointmentsNotifier extends StateNotifier<CheckAppointmentsState> {
  final GetCheckAppointmentsUseCase getCheckAppointmentsUseCase;

  CheckAppointmentsNotifier(this.getCheckAppointmentsUseCase)
      : super(CheckAppointmentsState()) {
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final appointments = await getCheckAppointmentsUseCase.execute();
      state = state.copyWith(
        isLoading: false,
        allAppointments: appointments,
      );
      _applyFilters();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void search(String query) {
    state = state.copyWith(searchQuery: query);
    _applyFilters();
  }

  void _applyFilters() {
    final lowerQuery = state.searchQuery.toLowerCase();

    final filteredAll = state.allAppointments.where((app) {
      return lowerQuery.isEmpty ||
          app.contractNumber.toLowerCase().contains(lowerQuery) ||
          app.queueNumber.toLowerCase().contains(lowerQuery);
    }).toList();

    final filteredPending = filteredAll.where((app) {
      return app.status == CheckAppointmentStatus.pending;
    }).toList();

    state = state.copyWith(
      allFiltered: filteredAll,
      pendingFiltered: filteredPending,
    );
  }
}

final checkAppointmentsProvider =
    StateNotifierProvider<CheckAppointmentsNotifier, CheckAppointmentsState>(
  (ref) => CheckAppointmentsNotifier(sl<GetCheckAppointmentsUseCase>()),
);
