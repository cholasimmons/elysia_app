// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginAdapter extends TypeAdapter<Login> {
  @override
  final int typeId = 0;

  @override
  Login read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Login(
      fields[0] as String,
      fields[1] as String,
      fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Login obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.rememberMe);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SignupAdapter extends TypeAdapter<Signup> {
  @override
  final int typeId = 1;

  @override
  Signup read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Signup(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String?,
      fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Signup obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.confirmPassword)
      ..writeByte(3)
      ..write(obj.firstname)
      ..writeByte(4)
      ..write(obj.lastname);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login _$LoginFromJson(Map<String, dynamic> json) => Login(
      json['email'] as String,
      json['password'] as String,
      json['rememberMe'] as bool,
    );

Map<String, dynamic> _$LoginToJson(Login instance) => <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'rememberMe': instance.rememberMe,
    };

Signup _$SignupFromJson(Map<String, dynamic> json) => Signup(
      json['email'] as String,
      json['password'] as String,
      json['confirmPassword'] as String,
      json['firstname'] as String?,
      json['lastname'] as String?,
    );

Map<String, dynamic> _$SignupToJson(Signup instance) => <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
    };
