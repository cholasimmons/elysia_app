import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'province_model.g.dart';

@HiveType(typeId: 3)
@JsonSerializable() // Removed after we replaced with Hive
class Province extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String capital;

  @HiveField(2)
  final String? image;

  @HiveField(3)
  final List<District> districts;

  Province({required this.name, required this.capital, this.image, required this.districts});

  factory Province.fromJson(Map<String, dynamic> json) => _$ProvinceFromJson(json);
  Map<String, dynamic> toJson() => _$ProvinceToJson(this);
}

@HiveType(typeId: 4)
@JsonSerializable()
class District extends HiveObject{
  @HiveField(0)
  final String name;

  District({required this.name});

  factory District.fromJson(Map<String, dynamic> json) =>_$DistrictFromJson(json);
  Map<String, dynamic> toJson() => _$DistrictToJson(this);
}
