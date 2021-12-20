// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../livre.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Livre _$LivreFromJson(Map<String, dynamic> json) {
  return Livre(
    json['idlivre'] as int,
    json['titre'] as String,
    json['auteur'] as String,
    json['description'] as String,
    json['exmplaire'] as int,
    json['nbdisponible'] as int,
    json['imageCle'] == null
        ? null
        : Image.fromJson(json['imageCle'] as Map<String, dynamic>),
    json['dateCreation'] as String,
    json['categorieIdcategorie'] as int,
    (json['empruntList'] as List)
        ?.map((e) =>
            e == null ? null : Emprunt.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['reservationList'] as List)
        ?.map((e) =>
            e == null ? null : Reservation.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$LivreToJson(Livre instance) => <String, dynamic>{
      'idlivre': instance._idlivre,
      'titre': instance._titre,
      'auteur': instance._auteur,
      'description': instance._description,
      'exmplaire': instance._exmplaire,
      'nbdisponible': instance._nbdisponible,
      'imageCle': instance._imageCle,
      'dateCreation': instance._dateCreation,
      'categorieIdcategorie': instance._categorieIdcategorie,
      'reservationList': instance._reservationList,
      'empruntList': instance._empruntList,
    };
