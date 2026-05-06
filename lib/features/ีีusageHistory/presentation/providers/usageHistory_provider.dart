import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/usageHistory_entity.dart';
import '../../domain/usecases/get_usageHistory_usecase.dart';
import '../../../../core/di/injection.dart';

class UsageHistoryState {
  final List<UsageHistoryEntity> waterInvoices;
  final List<UsageHistoryEntity> electricInvoices;
  final List<UsageHistoryEntity> phoneInvoices;
  final bool isLoading;
  final String? error;

  UsageHistoryState({
    this.waterInvoices = const [],
    this.electricInvoices = const [],
    this.phoneInvoices = const [],
    this.isLoading = false,
    this.error,
  });

  UsageHistoryState copyWith({
    List<UsageHistoryEntity>? waterInvoices,
    List<UsageHistoryEntity>? electricInvoices,
    List<UsageHistoryEntity>? phoneInvoices,
    bool? isLoading,
    String? error,
  }) {
    return UsageHistoryState(
      waterInvoices: waterInvoices ?? this.waterInvoices,
      electricInvoices: electricInvoices ?? this.electricInvoices,
      phoneInvoices: phoneInvoices ?? this.phoneInvoices,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class UsageHistoryNotifier extends StateNotifier<UsageHistoryState> {
  final UsageHistoryUseCase getInvoiceUseCase;

  UsageHistoryNotifier(this.getInvoiceUseCase) : super(UsageHistoryState()) {
    fetchInvoices();
  }

  Future<void> fetchInvoices() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final invoices = await getInvoiceUseCase.execute();
      
      state = state.copyWith(
        isLoading: false,
        waterInvoices: invoices.where((i) => i.type == 'water').toList(),
        electricInvoices: invoices.where((i) => i.type == 'electricity').toList(),
        phoneInvoices: invoices.where((i) => i.type == 'phone').toList(),
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final usageHistoryProvider = StateNotifierProvider<UsageHistoryNotifier, UsageHistoryState>(
  (ref) => UsageHistoryNotifier(sl<UsageHistoryUseCase>()),
);
