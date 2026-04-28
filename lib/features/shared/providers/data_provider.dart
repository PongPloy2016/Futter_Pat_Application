import 'package:flutter_pat_application/features/shared/data/models/equipmentItemModel/mockup_memo_model.dart';
import 'package:flutter_pat_application/features/shared/data/models/equipmentItemModel/reqMemoList.dart';
import 'package:riverpod/riverpod.dart';

import '../data/repositories/rfid_meno_list_repository.dart';

// Provider for the repository
final userProvider = Provider<RFIDMenoListRepository>((ref) {
  return RFIDMenoListRepository();
});

// FutureProvider to get the memo list
final userDataProvider = FutureProvider<MockupMemoModel>((ref) async {
  final repository = ref.watch(userProvider); // Watch the repository
  final reqMemoList = ReqMemoList(
    // Create a request object
    order: 'asc',
    orderBy: 'memoCode',
    page: 1,
    limit: 10,
  );
  return await repository.getMenoList(
    reqMemoList,
  ); // Fetch data from the repository
});
