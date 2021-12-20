// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../categorie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Categorie _$CategorieFromJson(Map<String, dynamic> json) {
  return Categorie(
    json['idcategorie'] as int,
    json['nom'] as String,
    (json['livreList'] as List)
        ?.map(
            (e) => e == null ? null : Livre.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CategorieToJson(Categorie instance) => <String, dynamic>{
      'idcategorie': instance._idcategorie,
      'nom': instance._nom,
      'livreList': instance._livreList,
    };
