// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reservation _$ReservationFromJson(Map<String, dynamic> json) {
  return Reservation(
    json['numeroReservation'] as int,
    json['date'] as String,
    json['dateFin'] as String,
    json['regle'] as bool,
    json['etudiantUserIduser'] as int,
    json['livreIdlivre'] as int,
  );
}

Map<String, dynamic> _$ReservationToJson(Reservation instance) =>
    <String, dynamic>{
      'numeroReservation': instance._numeroReservation,
      'date': instance._date,
      'dateFin': instance._dateFin,
      'regle': instance._regle,
      'etudiantUserIduser': instance._etudiantUserIduser,
      'livreIdlivre': instance._livreIdlivre,
    };
