// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memo_data_classification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemoDataClassificationModel _$MemoDataClassificationModelFromJson(
  Map<String, dynamic> json,
) => MemoDataClassificationModel(
  isSuccess: json['isSuccess'] as bool,
  message: json['message'] as String,
  data: Data.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MemoDataClassificationModelToJson(
  MemoDataClassificationModel instance,
) => <String, dynamic>{
  'isSuccess': instance.isSuccess,
  'message': instance.message,
  'data': instance.data,
};

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  total: (json['total'] as num).toInt(),
  count: (json['count'] as num).toInt(),
  data: (json['data'] as List<dynamic>)
      .map((e) => MemoData.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'total': instance.total,
  'count': instance.count,
  'data': instance.data,
};

MemoData _$MemoDataFromJson(Map<String, dynamic> json) => MemoData(
  isActive: json['isActive'] as bool,
  createdDate: json['createdDate'] as String,
  createdBy: (json['createdBy'] as num).toInt(),
  memoDataClassId: (json['memoDataClassId'] as num).toInt(),
  description: json['description'] as String,
  isSecret: json['isSecret'] as bool,
);

Map<String, dynamic> _$MemoDataToJson(MemoData instance) => <String, dynamic>{
  'isActive': instance.isActive,
  'createdDate': instance.createdDate,
  'createdBy': instance.createdBy,
  'memoDataClassId': instance.memoDataClassId,
  'description': instance.description,
  'isSecret': instance.isSecret,
};
