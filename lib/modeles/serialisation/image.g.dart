// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Image _$ImageFromJson(Map<String, dynamic> json) {
  return Image(
    json['cle'] as int,
    json['nom'] as String,
    json['url'] as String,
  );
}

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
      'cle': instance._cle,
      'nom': instance._nom,
      'url': instance._url,
    };
