// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'province_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProvinceAdapter extends TypeAdapter<Province> {
  @override
  final int typeId = 3;

  @override
  Province read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Province(
      name: fields[0] as String,
      capital: fields[1] as String,
      image: fields[2] as String?,
      districts: (fields[3] as List).cast<District>(),
    );
  }

  @override
  void write(BinaryWriter writer, Province obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.capital)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.districts);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProvinceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DistrictAdapter extends TypeAdapter<District> {
  @override
  final int typeId = 4;

  @override
  District read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return District(
      name: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, District obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DistrictAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Province _$ProvinceFromJson(Map<String, dynamic> json) => Province(
      name: json['name'] as String,
      capital: json['capital'] as String,
      image: json['image'] as String?,
      districts: (json['districts'] as List<dynamic>)
          .map((e) => District.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProvinceToJson(Province instance) => <String, dynamic>{
      'name': instance.name,
      'capital': instance.capital,
      'image': instance.image,
      'districts': instance.districts,
    };

District _$DistrictFromJson(Map<String, dynamic> json) => District(
      name: json['name'] as String,
    );

Map<String, dynamic> _$DistrictToJson(District instance) => <String, dynamic>{
      'name': instance.name,
    };
