


import 'package:flutter_pat_application/features/auth/data/models/reqlogin.dart';
import 'package:flutter_pat_application/features/auth/data/models/res_login_model.dart';
import 'package:flutter_pat_application/features/shared/data/models/equipmentItemModel/mockup_memo_model.dart';
import 'package:flutter_pat_application/features/shared/data/models/equipmentItemModel/reqMemoList.dart';
import 'package:flutter_pat_application/features/shared/data/models/memoDataClassification/memo_data_classification_model.dart';
import 'package:flutter/material.dart';



abstract class AuthRepoInterface {
  Future<ResLoginModel> getLoginUser(Reqlogin reqLogin);
  Future<ResLoginModel> getlogin();
}

abstract class MemoListRepoInterface {
  Future<MockupMemoModel> getMenoList(ReqMemoList reqLogin);
}


abstract class MemoDataClassificationRepoInterface {
  Future<MemoDataClassificationModel> getMemoDataClassification(BuildContext context);
}
abstract class MemoDataSerachSuppliseRepoInterface {


  Future<MemoDataClassificationModel> getMockupBuilding();
}
