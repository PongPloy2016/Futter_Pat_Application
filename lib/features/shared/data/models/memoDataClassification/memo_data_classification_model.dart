import 'package:json_annotation/json_annotation.dart';

part 'memo_data_classification_model.g.dart';

@JsonSerializable()
class MemoDataClassificationModel {
  bool isSuccess;
  String message;
  Data data;

  MemoDataClassificationModel({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory MemoDataClassificationModel.fromJson(Map<String, dynamic> json) =>
      _$MemoDataClassificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$MemoDataClassificationModelToJson(this);
}

@JsonSerializable()
class Data {
  int total;
  int count;
  List<MemoData> data;

  Data({
    required this.total,
    required this.count,
    required this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class MemoData {
  bool isActive;
  String createdDate;
  int createdBy;
  int memoDataClassId;
  String description;
  bool isSecret;

  MemoData({
    required this.isActive,
    required this.createdDate,
    required this.createdBy,
    required this.memoDataClassId,
    required this.description,
    required this.isSecret,
  });

  factory MemoData.fromJson(Map<String, dynamic> json) =>
      _$MemoDataFromJson(json);
  Map<String, dynamic> toJson() => _$MemoDataToJson(this);
}
