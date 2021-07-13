import 'package:json_annotation/json_annotation.dart';
part 'serialisation/user.g.dart';

@JsonSerializable()
class User {
  int _iduser;
  String _email;
  String _password;
  String _role;

  User(this._iduser, this._email, this._password, this._role);

  get iduser => this._iduser;

  set iduser(value) => this._iduser = value;

  get email => this._email;

  set email(value) => this._email = value;

  get password => this._password;

  set password(value) => this._password = value;

  get role => this._role;

  set role(value) => this._role = value;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
