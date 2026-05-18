
import '../../../domain/entities/Appointment_entity.dart';

class AppointmentContractListState {
  final List<AppointmentEntity> appointments;
  final List<AppointmentEntity> filteredAppointments;
  final bool isLoading;
  final String? errorMessage;
  final String searchQuery;
  final String? selectedContractId;
  final AppointmentEntity? selectedContract;

  AppointmentContractListState({
    this.appointments = const [],
    this.filteredAppointments = const [],
    this.isLoading = false,
    this.errorMessage,
    this.searchQuery = '',
    this.selectedContractId,
    this.selectedContract,
  });

  AppointmentContractListState copyWith({
    List<AppointmentEntity>? appointments,
    List<AppointmentEntity>? filteredAppointments,
    bool? isLoading,
    String? errorMessage,
    String? searchQuery,
    String? selectedContractId,
    AppointmentEntity? selectedContract,
  }) {
    return AppointmentContractListState(
      appointments: appointments ?? this.appointments,
      filteredAppointments: filteredAppointments ?? this.filteredAppointments,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedContractId: selectedContractId ?? this.selectedContractId,
      selectedContract: selectedContract ?? this.selectedContract,
    );
  }

  factory AppointmentContractListState.initial() => AppointmentContractListState();
}
