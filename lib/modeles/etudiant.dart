import 'package:gestion_bibliotheque/modeles/emprunt.dart';
import 'package:gestion_bibliotheque/modeles/reservation.dart';
import 'package:gestion_bibliotheque/modeles/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'serialisation/etudiant.g.dart';

@JsonSerializable()
class Etudiant {
  int _userIduser;
  String _numeroDossier;
  String _nom;
  String _prenom;
  String _dateNaissance;
  String _dateCreation;
  User _user;
  List<Emprunt> _empruntList;
  List<Reservation> _reservationList;

  Etudiant(
      this._userIduser,
      this._numeroDossier,
      this._nom,
      this._prenom,
      this._dateNaissance,
      this._dateCreation,
      this._user,
      this._empruntList,
      this._reservationList);

  get userIduser => this._userIduser;

  set userIduser(value) => this._userIduser = value;

  get numeroDossier => this._numeroDossier;

  set numeroDossier(value) => this._numeroDossier = value;

  get nom => this._nom;

  set nom(value) => this._nom = value;

  get prenom => this._prenom;

  set prenom(value) => this._prenom = value;

  get dateNaissance => this._dateNaissance;

  set dateNaissance(value) => this._dateNaissance = value;

  get dateCreation => this._dateCreation;

  set dateCreation(value) => this._dateCreation = value;

  get user => this._user;

  set user(value) => this._user = value;

  get empruntList => this._empruntList;

  set empruntList(value) => this._empruntList = value;

  get reservationList => this._reservationList;

  set reservationList(value) => this._reservationList = value;

  factory Etudiant.fromJson(Map<String, dynamic> json) =>
      _$EtudiantFromJson(json);

  Map<String, dynamic> toJson() => _$EtudiantToJson(this);
}
