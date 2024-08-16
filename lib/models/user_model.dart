import 'package:elysia_app/models/profile_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@HiveType(typeId: 6)
@JsonSerializable()
class User extends HiveObject{
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String firstname;

  @HiveField(2)
  final String lastname;

  @HiveField(3)
  final String username;

  @HiveField(4)
  final String email;

  @HiveField(5)
  final bool emailVerified;

  @HiveField(6)
  final String? phone;

  @HiveField(7)
  final List<String> roles;

  @HiveField(8)
  final String? profileId;

  @HiveField(9)
  final Profile? profile;

  @HiveField(10)
  final String? isComment;

  @HiveField(11)
  final bool isActive;

  @HiveField(12)
  final DateTime createdAt;

  @HiveField(13)
  final DateTime? updatedAt;


  User({required this.id, required this.firstname, required this.lastname, required this.username,
    required this.email, required this.emailVerified, this.phone, required this.roles, this.profileId, this.profile,
      this.isComment, required this.isActive, required this.createdAt, this.updatedAt});

  factory User.fromJson(Map<String, dynamic> data) => _$UserFromJson(data);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}


// @HiveType(typeId: 7)
// @JsonSerializable()
// class Profile extends HiveObject {
//   @HiveField(0)
//   final int id;
//
//   Profile({required this.id});
//
//   factory Profile.fromJson(Map<String, dynamic> data) => _$ProfileFromJson(data);
//   Map<String, dynamic> toJson() => _$ProfileToJson(this);
// }