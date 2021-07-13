import 'package:json_annotation/json_annotation.dart';
part 'serialisation/emprunt.g.dart';

@JsonSerializable()
class Emprunt {
  int _numeroEmprunt;
  String _dateDebut;
  String _delai_recup;
  String _dateFin;
  String _dateremise;
  bool _regle;
  bool _confirmer;
  int _etudiantUserIduser;
  int _livreIdlivre;
  bool _aSupp;

  Emprunt(
      this._numeroEmprunt,
      this._dateDebut,
      this._delai_recup,
      this._dateFin,
      this._regle,
      this._confirmer,
      this._etudiantUserIduser,
      this._livreIdlivre,
      this._dateremise,
      this._aSupp);

  get numeroEmprunt => this._numeroEmprunt;

  set numeroEmprunt(value) => this._numeroEmprunt = value;

  get dateDebut => this._dateDebut;

  set dateDebut(value) => this._dateDebut = value;

  get delaiRecup => this._delai_recup;

  set delaiRecup(value) => this._delai_recup = value;

  get dateFin => this._dateFin;

  set dateFin(value) => this._dateFin = value;

  get dateremise => this._dateremise;

  set dateremise(value) => this._dateremise = value;

  get regle => this._regle;

  set regle(value) => this._regle = value;

  get confirmer => this._confirmer;

  set confirmer(value) => this._confirmer = value;

  get etudiantUserIduser => this._etudiantUserIduser;

  set etudiantUserIduser(value) => this._etudiantUserIduser = value;

  get livreIdlivre => this._livreIdlivre;

  set livreIdlivre(value) => this._livreIdlivre = value;

  get aSupp => this._aSupp;

  set aSupp(value) => this._aSupp = value;

  factory Emprunt.fromJson(Map<String, dynamic> json) =>
      _$EmpruntFromJson(json);

  Map<String, dynamic> toJson() => _$EmpruntToJson(this);
}
