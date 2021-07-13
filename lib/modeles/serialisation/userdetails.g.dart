// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../userdetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Userdetails _$UserdetailsFromJson(Map<String, dynamic> json) {
  return Userdetails(
    json['exp'] as int,
    json['iat'] as int,
    json['sub'] as String,
    json['isAdmin'] as bool,
    json['isAgent'] as bool,
    json['isBibliothecaire'] as bool,
    json['isEtudiant'] as bool,
  );
}

Map<String, dynamic> _$UserdetailsToJson(Userdetails instance) =>
    <String, dynamic>{
      'exp': instance._exp,
      'iat': instance._iat,
      'sub': instance._sub,
      'isAdmin': instance._isAdmin,
      'isAgent': instance._isAgent,
      'isBibliothecaire': instance._isBibliothecaire,
      'isEtudiant': instance._isEtudiant,
    };
