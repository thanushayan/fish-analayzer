import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'foodPredict.model.g.dart';
 

@JsonSerializable(explicitToJson: true)
class FoodPredict {
  int species;
  int fishCount;
  int fishStage;

  FoodPredict(
      {required this.species,
      required this.fishCount,
      required this.fishStage});

  factory FoodPredict.fromJson(Map<String, dynamic> json) =>
      _$FoodPredictFromJson(json);

  Map<String, dynamic> toJson() => _$FoodPredictToJson(this);
}
