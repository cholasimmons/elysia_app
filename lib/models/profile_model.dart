import 'package:elysia_app/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

enum DocumentType { passport, nrc }
enum Gender { male, female, other }
enum SubscriptionType { free, premium, elite }

@JsonSerializable()
class Profile {
  final int id;
  final String? bio;
  final String? userId;
  final User user;
  final String documentId;
  @JsonKey(fromJson: _documentTypeFromJson, toJson: _documentTypeToJson)
  final DocumentType documentType;
  final String? photoId;
  @JsonKey(fromJson: _genderFromJson, toJson: _genderToJson)
  final Gender gender;
  final String firstname;
  final String lastname;
  final String? phone;
  final String email;
  final int supportLevel;
  @JsonKey(fromJson: _subscriptionTypeFromJson, toJson: _subscriptionTypeToJson)
  final SubscriptionType subscriptionType;
  final Object? subscription;
  final String? isComment;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Profile({required this.id, this.bio, this.userId, required this.user, required this.documentId, required this.documentType,
      this.photoId, required this.gender, required this.firstname, required this.lastname, this.phone, required this.email, required this.supportLevel,
    required this.subscriptionType, this.subscription, required this.isActive, this.isComment, required this.createdAt, this.updatedAt});

  factory Profile.fromJson(Map<String, dynamic> data) => _$ProfileFromJson(data);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  // Custom JSON conversion methods for Enums
  static DocumentType _documentTypeFromJson(String value) =>
      DocumentType.values.firstWhere((e) => e.toString().split('.').last == value.toLowerCase());
  static String _documentTypeToJson(DocumentType type) => type.toString().split('.').last.toUpperCase();

  static Gender _genderFromJson(String value) =>
      Gender.values.firstWhere((e) => e.toString().split('.').last == value.toLowerCase());
  static String _genderToJson(Gender gender) => gender.toString().split('.').last.toUpperCase();

  static SubscriptionType _subscriptionTypeFromJson(String value) =>
      SubscriptionType.values.firstWhere((e) => e.toString().split('.').last == value.toLowerCase());
  static String _subscriptionTypeToJson(SubscriptionType type) => type.toString().split('.').last.toUpperCase();
}