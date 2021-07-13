import 'package:gestion_bibliotheque/modeles/livre.dart';
import 'package:json_annotation/json_annotation.dart';
part 'serialisation/categorie.g.dart';

@JsonSerializable()
class Categorie {
  int _idcategorie;
  String _nom;
  List<Livre> _livreList;

  Categorie(this._idcategorie, this._nom, this._livreList);

  get idcategorie => this._idcategorie;

  set idcategorie(value) => this._idcategorie = value;

  get nom => this._nom;

  set nom(value) => this._nom = value;

  get livreList => this._livreList;

  set livreList(value) => this._livreList = value;

  factory Categorie.fromJson(Map<String, dynamic> json) =>
      _$CategorieFromJson(json);

  Map<String, dynamic> toJson() => _$CategorieToJson(this);
}
