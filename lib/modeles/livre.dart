import 'package:gestion_bibliotheque/modeles/emprunt.dart';
import 'package:gestion_bibliotheque/modeles/image.dart';
import 'package:gestion_bibliotheque/modeles/reservation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'serialisation/livre.g.dart';

@JsonSerializable()
class Livre {
  int _idlivre;
  String _titre;
  String _auteur;
  String _description;
  int _exmplaire;
  int _nbdisponible;
  Image _imageCle;
  String _dateCreation;
  int _categorieIdcategorie;
  List<Reservation> _reservationList;
  List<Emprunt> _empruntList;

  Livre(
      this._idlivre,
      this._titre,
      this._auteur,
      this._description,
      this._exmplaire,
      this._nbdisponible,
      this._imageCle,
      this._dateCreation,
      this._categorieIdcategorie,
      this._empruntList,
      this._reservationList);

  get idlivre => this._idlivre;

  set idlivre(value) => this._idlivre = value;

  get titre => this._titre;

  set titre(value) => this._titre = value;

  get auteur => this._auteur;

  set auteur(value) => this._auteur = value;

  get description => this._description;

  set description(value) => this._description = value;

  get exmplaire => this._exmplaire;

  set exmplaire(value) => this._exmplaire = value;

  get nbdisponible => this._nbdisponible;

  set nbdisponible(value) => this._nbdisponible = value;

  get imageCle => this._imageCle;

  set imageCle(value) => this._imageCle = value;

  get dateCreation => this._dateCreation;

  set dateCreation(value) => this._dateCreation = value;

  get categorieIdcategorie => this._categorieIdcategorie;

  set categorieIdcategorie(value) => this._categorieIdcategorie = value;

  get reservationList => this._reservationList;

  set reservationList(value) => this._reservationList = value;

  get empruntList => this._empruntList;

  set empruntList(value) => this._empruntList = value;

  factory Livre.fromJson(Map<String, dynamic> json) => _$LivreFromJson(json);

  Map<String, dynamic> toJson() => _$LivreToJson(this);
}
