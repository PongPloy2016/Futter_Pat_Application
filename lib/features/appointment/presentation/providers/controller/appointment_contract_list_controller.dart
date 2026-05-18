import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/di/injection.dart';
import '../../../domain/entities/Appointment_entity.dart';
import '../../../domain/usecases/get_appointment_usecase.dart';
import '../state/appointment_contract_list_state.dart';

class AppointmentContractListController
    extends StateNotifier<AppointmentContractListState> {
  final GetAppointmentUseCase getAppointmentUseCase;

  AppointmentContractListController(this.getAppointmentUseCase)
      : super(AppointmentContractListState.initial()) {
    loadAppointments();
  }

  Future<void> loadAppointments() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final appointments = await getAppointmentUseCase.execute();
      state = state.copyWith(
        appointments: appointments,
        filteredAppointments: _filterAppointments(appointments, state.searchQuery),
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  void setSearchQuery(String query) {
    final normalizedQuery = query.trim().toLowerCase();
    state = state.copyWith(
      searchQuery: normalizedQuery,
      filteredAppointments: _filterAppointments(state.appointments, normalizedQuery),
    );
    
    // Check if selected contract is still in filtered list
    if (state.selectedContractId != null) {
        final isStillVisible = state.filteredAppointments.any(
            (c) => c?.contractId == state.selectedContractId
        );
        if (!isStillVisible) {
            state = state.copyWith(
                selectedContractId: null,
                selectedContract: null,
            );
        }
    }
  }

  void selectContract(AppointmentEntity? contract) {
    state = state.copyWith(
      selectedContractId: contract?.contractId,
      selectedContract: contract,
    );
  }

  List<AppointmentEntity> _filterAppointments(
    List<AppointmentEntity> appointments,
    String query,
  ) {
    if (query.isEmpty) {
      return appointments;
    }

    return appointments.where((contract) {
      final searchableText = '${contract.contractId} ${contract.contractName}'
          .toLowerCase();
      return searchableText.contains(query);
    }).toList();
  }
}



final appointmentContractListProvider =
    StateNotifierProvider<AppointmentContractListController, AppointmentContractListState>((
  ref,
) {
  return AppointmentContractListController(sl<GetAppointmentUseCase>());
});
