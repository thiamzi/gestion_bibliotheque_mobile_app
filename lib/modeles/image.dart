import 'package:json_annotation/json_annotation.dart';
part 'serialisation/image.g.dart';

@JsonSerializable()
class Image {
  int _cle;
  String _nom;
  String _url;

  Image(this._cle, this._nom, this._url);

  get cle => this._cle;

  set cle(value) => this._cle = value;

  get nom => this._nom;

  set nom(value) => this._nom = value;

  get url => this._url;

  set url(value) => this._url = value;

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);
}
