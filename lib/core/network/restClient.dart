import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter_pat_application/features/shared/data/models/memoDataClassification/memo_data_classification_model.dart';

// Include the generated part file here
part 'restClient.g.dart'; // This should match the name of your generated file

@RestApi(baseUrl: 'https://rfidmock.free.beeceptor.com')
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  // @GET('/GetMemoDataClassification')
  // Future<Response<MemoDataClassificationModel>> getMemoDataClassification();
}
