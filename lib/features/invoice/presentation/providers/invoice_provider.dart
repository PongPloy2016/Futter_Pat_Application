import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/invoice_entity.dart';
import '../../domain/usecases/get_invoice_usecase.dart';
import '../../../../core/di/injection.dart';

class InvoiceState {
  final List<InvoiceEntity> allInvoices;
  final List<InvoiceEntity> filteredInvoices;
  final List<InvoiceEntity> rentInvoices;
  final List<InvoiceEntity> waterInvoices;
  final List<InvoiceEntity> electricityInvoices;
  final List<InvoiceEntity> phoneInvoices;
  final bool isLoading;
  final String? error;
  final String searchQuery;

  InvoiceState({
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

  InvoiceState copyWith({
    List<InvoiceEntity>? allInvoices,
    List<InvoiceEntity>? filteredInvoices,
    List<InvoiceEntity>? rentInvoices,
    List<InvoiceEntity>? waterInvoices,
    List<InvoiceEntity>? electricityInvoices,
    List<InvoiceEntity>? phoneInvoices,
    bool? isLoading,
    String? error,
    String? searchQuery,
  }) {
    return InvoiceState(
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

class InvoiceNotifier extends StateNotifier<InvoiceState> {
  final GetInvoiceUseCase getInvoiceUseCase;

  InvoiceNotifier(this.getInvoiceUseCase) : super(InvoiceState()) {
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

final invoiceProvider = StateNotifierProvider<InvoiceNotifier, InvoiceState>(
  (ref) => InvoiceNotifier(sl<GetInvoiceUseCase>()),
);
