// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../email.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Email _$EmailFromJson(Map<String, dynamic> json) {
  return Email(
    json['objet'] as String,
    json['destinataire'] as String,
    json['message'] as String,
    json['numero'] as String,
    json['password'] as String,
  );
}

Map<String, dynamic> _$EmailToJson(Email instance) => <String, dynamic>{
      'objet': instance._objet,
      'destinataire': instance._destinataire,
      'message': instance._message,
      'numero': instance._numero,
      'password': instance._password,
    };
