// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 6;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as int,
      firstname: fields[1] as String,
      lastname: fields[2] as String,
      username: fields[3] as String,
      email: fields[4] as String,
      emailVerified: fields[5] as bool,
      phone: fields[6] as String?,
      roles: (fields[7] as List).cast<String>(),
      profileId: fields[8] as String?,
      profile: fields[9] as Profile?,
      isComment: fields[10] as String?,
      isActive: fields[11] as bool,
      createdAt: fields[12] as DateTime,
      updatedAt: fields[13] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstname)
      ..writeByte(2)
      ..write(obj.lastname)
      ..writeByte(3)
      ..write(obj.username)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.emailVerified)
      ..writeByte(6)
      ..write(obj.phone)
      ..writeByte(7)
      ..write(obj.roles)
      ..writeByte(8)
      ..write(obj.profileId)
      ..writeByte(9)
      ..write(obj.profile)
      ..writeByte(10)
      ..write(obj.isComment)
      ..writeByte(11)
      ..write(obj.isActive)
      ..writeByte(12)
      ..write(obj.createdAt)
      ..writeByte(13)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num).toInt(),
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      emailVerified: json['emailVerified'] as bool,
      phone: json['phone'] as String?,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      profileId: json['profileId'] as String?,
      profile: json['profile'] == null
          ? null
          : Profile.fromJson(json['profile'] as Map<String, dynamic>),
      isComment: json['isComment'] as String?,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'username': instance.username,
      'email': instance.email,
      'emailVerified': instance.emailVerified,
      'phone': instance.phone,
      'roles': instance.roles,
      'profileId': instance.profileId,
      'profile': instance.profile,
      'isComment': instance.isComment,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
