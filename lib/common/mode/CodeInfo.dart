

import 'package:json_annotation/json_annotation.dart';




part 'CodeInfo.g.dart';


@JsonSerializable()
class CodeInfo {

  @JsonKey(name: "text")
  String text;
  @JsonKey(name: "format")
  String format;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "phone_no")
  String phoneNo;

  CodeInfo(this.text, this.format, {this.name, this.phoneNo});

  factory CodeInfo.fromJson(Map<String, dynamic> json) => _$CodeInfoFromJson(json);
  Map<String, dynamic> toJson() => _$CodeInfoToJson(this);

  static bool islike(CodeInfo abs, CodeInfo base){

    return abs.text == base.text && abs.format == base.format;


  }


}