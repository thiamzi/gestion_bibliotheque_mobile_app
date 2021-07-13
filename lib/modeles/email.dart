import 'package:json_annotation/json_annotation.dart';
part 'serialisation/email.g.dart';

@JsonSerializable()
class Email {
  String _objet;
  String _destinataire;
  String _message;
  String _numero;
  String _password;

  Email(this._objet, this._destinataire, this._message, this._numero,
      this._password);

  get objet => this._objet;

  set objet(value) => this._objet = value;

  get destinataire => this._destinataire;

  set destinataire(value) => this._destinataire = value;

  get message => this._message;

  set message(value) => this._message = value;

  get numero => this._numero;

  set numero(value) => this._numero = value;

  get password => this._password;

  set password(value) => this._password = value;

  factory Email.fromJson(Map<String, dynamic> json) => _$EmailFromJson(json);

  Map<String, dynamic> toJson() => _$EmailToJson(this);
}
