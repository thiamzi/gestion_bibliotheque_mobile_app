// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['iduser'] as int,
    json['email'] as String,
    json['password'] as String,
    json['role'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'iduser': instance._iduser,
      'email': instance._email,
      'password': instance._password,
      'role': instance._role,
    };
