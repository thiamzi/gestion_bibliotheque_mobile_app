// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../etudiant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Etudiant _$EtudiantFromJson(Map<String, dynamic> json) {
  return Etudiant(
    json['userIduser'] as int,
    json['numeroDossier'] as String,
    json['nom'] as String,
    json['prenom'] as String,
    json['dateNaissance'] as String,
    json['dateCreation'] as String,
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
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

Map<String, dynamic> _$EtudiantToJson(Etudiant instance) => <String, dynamic>{
      'userIduser': instance._userIduser,
      'numeroDossier': instance._numeroDossier,
      'nom': instance._nom,
      'prenom': instance._prenom,
      'dateNaissance': instance._dateNaissance,
      'dateCreation': instance._dateCreation,
      'user': instance._user,
      'empruntList': instance._empruntList,
      'reservationList': instance._reservationList,
    };
