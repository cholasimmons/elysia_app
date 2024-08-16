// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      id: (json['id'] as num).toInt(),
      bio: json['bio'] as String?,
      userId: json['userId'] as String?,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      documentId: json['documentId'] as String,
      documentType:
          Profile._documentTypeFromJson(json['documentType'] as String),
      photoId: json['photoId'] as String?,
      gender: Profile._genderFromJson(json['gender'] as String),
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      phone: json['phone'] as String?,
      email: json['email'] as String,
      supportLevel: (json['supportLevel'] as num).toInt(),
      subscriptionType:
          Profile._subscriptionTypeFromJson(json['subscriptionType'] as String),
      subscription: json['subscription'],
      isActive: json['isActive'] as bool,
      isComment: json['isComment'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'id': instance.id,
      'bio': instance.bio,
      'userId': instance.userId,
      'user': instance.user,
      'documentId': instance.documentId,
      'documentType': Profile._documentTypeToJson(instance.documentType),
      'photoId': instance.photoId,
      'gender': Profile._genderToJson(instance.gender),
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'phone': instance.phone,
      'email': instance.email,
      'supportLevel': instance.supportLevel,
      'subscriptionType':
          Profile._subscriptionTypeToJson(instance.subscriptionType),
      'subscription': instance.subscription,
      'isComment': instance.isComment,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
