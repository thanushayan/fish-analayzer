// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'foodPredict.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodPredict _$FoodPredictFromJson(Map<String, dynamic> json) => FoodPredict(
      species: json['species'] as int,
      fishCount: json['fishCount'] as int,
      fishStage: json['fishStage'] as int,
    );

Map<String, dynamic> _$FoodPredictToJson(FoodPredict instance) =>
    <String, dynamic>{
      'species': instance.species,
      'fishCount': instance.fishCount,
      'fishStage': instance.fishStage,
    };
