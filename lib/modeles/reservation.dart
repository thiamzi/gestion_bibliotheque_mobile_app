import 'package:json_annotation/json_annotation.dart';
part 'serialisation/reservation.g.dart';

@JsonSerializable()
class Reservation {
  int _numeroReservation;
  String _date;
  String _dateFin;
  bool _regle;
  int _etudiantUserIduser;
  int _livreIdlivre;

  Reservation(this._numeroReservation, this._date, this._dateFin, this._regle,
      this._etudiantUserIduser, this._livreIdlivre);

  get numeroReservation => this._numeroReservation;

  set numeroReservation(value) => this._numeroReservation = value;

  get date => this._date;

  set date(value) => this._date = value;

  get dateFin => this._dateFin;

  set dateFin(value) => this._dateFin = value;

  get regle => this._regle;

  set regle(value) => this._regle = value;

  get etudiantUserIduser => this._etudiantUserIduser;

  set etudiantUserIduser(value) => this._etudiantUserIduser = value;

  get livreIdlivre => this._livreIdlivre;

  set livreIdlivre(value) => this._livreIdlivre = value;

  factory Reservation.fromJson(Map<String, dynamic> json) =>
      _$ReservationFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationToJson(this);
}
