import 'package:json_annotation/json_annotation.dart';

part 'predictResponse.model.g.dart';

@JsonSerializable()
class ResponseApi {
  double response;

  ResponseApi({required this.response});

  factory ResponseApi.fromJson(Map<String, dynamic> json) =>
      _$ResponseApiFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseApiToJson(this);
}
