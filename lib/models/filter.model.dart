import 'package:json_annotation/json_annotation.dart';

part 'filter.model.g.dart';

@JsonSerializable()
class FilterModel {
  String response;

  FilterModel({required this.response});

  factory FilterModel.fromJson(Map<String, dynamic> json) =>
      _$FilterModelFromJson(json);

  Map<String, dynamic> toJson() => _$FilterModelToJson(this);
}
