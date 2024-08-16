import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class Login extends HiveObject {
  @HiveField(0)
  final String email;

  @HiveField(1)
  final String password;

  @HiveField(2)
  final bool rememberMe;

  Login(this.email, this.password, this.rememberMe);


  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);
  Map<String, dynamic> toJson() => _$LoginToJson(this);
}

@HiveType(typeId: 1)
@JsonSerializable()
class Signup extends HiveObject {
  @HiveField(0)
  final String email;

  @HiveField(1)
  final String password;

  @HiveField(2)
  final String confirmPassword;

  @HiveField(3)
  final String? firstname;

  @HiveField(4)
  final String? lastname;

  Signup(this.email, this.password, this.confirmPassword, this.firstname, this.lastname);

  factory Signup.fromJson(Map<String, dynamic> json) => _$SignupFromJson(json);
  Map<String, dynamic> toJson() => _$SignupToJson(this);
}