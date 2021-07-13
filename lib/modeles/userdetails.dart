import 'package:json_annotation/json_annotation.dart';
part 'serialisation/userdetails.g.dart';

@JsonSerializable()
class Userdetails {
  int _exp;
  int _iat;
  String _sub;
  bool _isAdmin;
  bool _isAgent;
  bool _isBibliothecaire;
  bool _isEtudiant;

  Userdetails(this._exp, this._iat, this._sub, this._isAdmin, this._isAgent,
      this._isBibliothecaire, this._isEtudiant);

  get exp => this._exp;

  set exp(value) => this._exp = value;

  get iat => this._iat;

  set iat(value) => this._iat = value;

  get sub => this._sub;

  set sub(value) => this._sub = value;

  get isAdmin => this._isAdmin;

  set isAdmin(value) => this._isAdmin = value;

  get isAgent => this._isAgent;

  set isAgent(value) => this._isAgent = value;

  get isBibliothecaire => this._isBibliothecaire;

  set isBibliothecaire(value) => this._isBibliothecaire = value;

  get isEtudiant => this._isEtudiant;

  set isEtudiant(value) => this._isEtudiant = value;

  factory Userdetails.fromJson(Map<String, dynamic> json) =>
      _$UserdetailsFromJson(json);

  Map<String, dynamic> toJson() => _$UserdetailsToJson(this);
}
