import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestion_bibliotheque/Const/responseStatus.dart';
import 'package:gestion_bibliotheque/modeles/user.dart';
import 'package:gestion_bibliotheque/modeles/userdetails.dart';
import 'package:gestion_bibliotheque/services/outils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthService {
  String _url = "https://gestion-bibliotheque.herokuapp.com/api/";

  Future<Userdetails> authenticateUser(
      String username, String password, context) async {
    http.Response response = await http.post(
      _url + "login",
      body: jsonEncode(<String, String>{
        'email': username,
        'password': password,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == ResponseStatus.RESPONSE_STATUS_200) {
      Map<String, dynamic> payload = Jwt.parseJwt(response.body);
      if (Userdetails.fromJson(payload).isEtudiant == null) {
        return Outils.erreur(context, 'Erreur authentification',
            'Email ou mot de passe incorrecte');
      }

      return Userdetails.fromJson(payload);
    } else if (response.statusCode == ResponseStatus.RESPONSE_STATUS_401) {
      return Outils.erreur(context, 'Erreur authentification',
          'Email ou mot de passe incorrecte');
    } else if (response.statusCode == ResponseStatus.RESPONSE_STATUS_500) {
      return Outils.snackbar(context, 'Erreur serveur. Ressayer plutard');
    } else {
      throw Exception("erreur");
    }
  }



  void saveAndRedirectToHome(context, Userdetails response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    getOneUser(response.sub, context).then((User user) async {
      if (user != null) {
        await prefs.setStringList("user", [
          user.iduser.toString(),
          user.email,
          user.password,
          user.role,
        ]).whenComplete(() {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/accueil',
            ModalRoute.withName('/accueil'),
          );
        });
      }
    });
  }

  static deconnexion(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');

    Get.offAllNamed(
      '/connexion',
    );
  }

  Future<User> getOneUser(String email, context) async {
    http.Response response = await http.get(Uri.parse(_url + "oneuser/$email"));
    if (response.statusCode == ResponseStatus.RESPONSE_STATUS_200) {
      Map data = jsonDecode(response.body);
      return User.fromJson(data);
    } else if (response.statusCode == ResponseStatus.RESPONSE_STATUS_500) {
      return Outils.snackbar(context, 'Erreur serveur. Ressayer plutard');
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<User> getCurrentUser(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs == null) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/connexion',
        ModalRoute.withName('/connexion'),
      );
    }
    List<String> donnees = prefs.getStringList("user");
    print("user=============================$donnees");
    if (donnees != null) {
      return User(int.parse(donnees.elementAt(0)), donnees.elementAt(1),
          donnees.elementAt(2), donnees.elementAt(3));
    } else {
      return null;
    }
  }

  Future<User> upadtePassword(User user, context) async {
    Outils.loading(context);
    http.Response response = await http.put(
      _url + "updatepassword",
      body: jsonEncode(user.toJson()),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == ResponseStatus.RESPONSE_STATUS_200) {
      return Outils.snackbar(context, "Mot de passe modifie avec succes");
    } else if (response.statusCode == ResponseStatus.RESPONSE_STATUS_500) {
      return Outils.snackbar(context, 'Erreur serveur. Ressayer plutard');
    } else {
      throw Exception("erreur");
    }
  }
}
