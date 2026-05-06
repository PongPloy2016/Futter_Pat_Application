import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/payment_history_entity.dart';
import '../../domain/usecases/get_payment_history_usecase.dart';
import '../../../../core/di/injection.dart';

class PaymentHistoryState {
  final List<PaymentHistoryEntity> allInvoices;
  final List<PaymentHistoryEntity> filteredInvoices;
  final List<PaymentHistoryEntity> rentInvoices;
  final List<PaymentHistoryEntity> waterInvoices;
  final List<PaymentHistoryEntity> electricityInvoices;
  final List<PaymentHistoryEntity> phoneInvoices;
  final bool isLoading;
  final String? error;
  final String searchQuery;

  PaymentHistoryState({
    this.allInvoices = const [],
    this.filteredInvoices = const [],
    this.rentInvoices = const [],
    this.waterInvoices = const [],
    this.electricityInvoices = const [],
    this.phoneInvoices = const [],
    this.isLoading = false,
    this.error,
    this.searchQuery = '',
  });

  PaymentHistoryState copyWith({
    List<PaymentHistoryEntity>? allInvoices,
    List<PaymentHistoryEntity>? filteredInvoices,
    List<PaymentHistoryEntity>? rentInvoices,
    List<PaymentHistoryEntity>? waterInvoices,
    List<PaymentHistoryEntity>? electricityInvoices,
    List<PaymentHistoryEntity>? phoneInvoices,
    bool? isLoading,
    String? error,
    String? searchQuery,
  }) {
    return PaymentHistoryState(
      allInvoices: allInvoices ?? this.allInvoices,
      filteredInvoices: filteredInvoices ?? this.filteredInvoices,
      rentInvoices: rentInvoices ?? this.rentInvoices,
      waterInvoices: waterInvoices ?? this.waterInvoices,
      electricityInvoices: electricityInvoices ?? this.electricityInvoices,
      phoneInvoices: phoneInvoices ?? this.phoneInvoices,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class PaymentHistoryNotifier extends StateNotifier<PaymentHistoryState> {
  final paymentHistoryStateUseCase getInvoiceUseCase;

  PaymentHistoryNotifier(this.getInvoiceUseCase) : super(PaymentHistoryState()) {
    fetchInvoices();
  }

  Future<void> fetchInvoices() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final invoices = await getInvoiceUseCase.execute();
      
      state = state.copyWith(
        isLoading: false,
        allInvoices: invoices,
        filteredInvoices: invoices,
        rentInvoices: invoices.where((i) => i.type == 'rent').toList(),
        waterInvoices: invoices.where((i) => i.type == 'water').toList(),
        electricityInvoices: invoices.where((i) => i.type == 'electricity').toList(),
        phoneInvoices: invoices.where((i) => i.type == 'phone').toList(),
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final invoiceProvider = StateNotifierProvider<PaymentHistoryNotifier, PaymentHistoryState>(
  (ref) => PaymentHistoryNotifier(sl<paymentHistoryStateUseCase>()),
);
