// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../emprunt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Emprunt _$EmpruntFromJson(Map<String, dynamic> json) {
  return Emprunt(
    json['numeroEmprunt'] as int,
    json['dateDebut'] as String,
    json['delai_recup'] as String,
    json['dateFin'] as String,
    json['regle'] as bool,
    json['confirmer'] as bool,
    json['etudiantUserIduser'] as int,
    json['livreIdlivre'] as int,
  );
}

Map<String, dynamic> _$EmpruntToJson(Emprunt instance) => <String, dynamic>{
      'numeroEmprunt': instance._numeroEmprunt,
      'dateDebut': instance._dateDebut,
      'delai_recup': instance._delaiRecup,
      'dateFin': instance._dateFin,
      'regle': instance._regle,
      'confirmer': instance._confirmer,
      'etudiantUserIduser': instance._etudiantUserIduser,
      'livreIdlivre': instance._livreIdlivre,
    };
