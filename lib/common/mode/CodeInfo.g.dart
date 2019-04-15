// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CodeInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CodeInfo _$CodeInfoFromJson(Map<String, dynamic> json) {
  return CodeInfo(json['text'] as String, json['format'] as String,
      name: json['name'] as String, phoneNo: json['phone_no'] as String);
}

Map<String, dynamic> _$CodeInfoToJson(CodeInfo instance) => <String, dynamic>{
      'text': instance.text,
      'format': instance.format,
      'name': instance.name,
      'phone_no': instance.phoneNo
    };
