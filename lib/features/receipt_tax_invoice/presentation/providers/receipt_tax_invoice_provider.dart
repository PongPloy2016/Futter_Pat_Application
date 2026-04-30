import 'package:flutter_pat_application/features/receipt_tax_invoice/data/models/TaxInvoice_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/receipt_tax_invoice_request_entity.dart';
import '../../domain/usecases/request_receipt_tax_invoice_usecase.dart';
import '../../../../core/di/injection.dart';

class ReceiptTaxInvoiceState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final List<TaxInvoiceModel> expenseTypes;

  ReceiptTaxInvoiceState({
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
    List<TaxInvoiceModel>? expenseTypes,
  }) : expenseTypes = expenseTypes ?? [];

  ReceiptTaxInvoiceState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    List<TaxInvoiceModel>? expenseTypes,
  }) {
    return ReceiptTaxInvoiceState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
      expenseTypes: expenseTypes ?? this.expenseTypes,
    );
  }
}

class ReceiptTaxInvoiceNotifier extends StateNotifier<ReceiptTaxInvoiceState> {
  final RequestReceiptTaxInvoiceUseCase requestUseCase;

  ReceiptTaxInvoiceNotifier(this.requestUseCase)
    : super(ReceiptTaxInvoiceState());

  // โหลดข้อมูล Dropdown
  Future<void> fetchExpenseTypes() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // ใช้ UseCase เดิมมาดึงข้อมูล (หรือถ้ามี UseCase แยกก็จะดีกว่า)
      final types = await requestUseCase.execute(
        ReceiptTaxInvoiceRequestEntity(),
      );
      state = state.copyWith(isLoading: false, expenseTypes: types);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // ส่งคำขอใบเสร็จ
  Future<void> submitRequest(int typeId, String monthYear) async {
    state = state.copyWith(isLoading: true, isSuccess: false, error: null);
    try {
      final request = ReceiptTaxInvoiceRequestEntity(
        typeId: typeId,
        monthYear: monthYear,
      );
      await requestUseCase.execute(request);
      state = state.copyWith(
        isLoading: false,
        isSuccess: true, // ตัวนี้จะสั่งให้ Navigator เปลี่ยนหน้า
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final receiptTaxInvoiceProvider =
    StateNotifierProvider<ReceiptTaxInvoiceNotifier, ReceiptTaxInvoiceState>((
      ref,
    ) {
      return ReceiptTaxInvoiceNotifier(sl<RequestReceiptTaxInvoiceUseCase>());
    });
