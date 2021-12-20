import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DynamicLinkService {
  redirectUser(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List user = (prefs.getStringList('user') ?? null);
    print("user==========================>$user");
    if (user == null) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/connexion', ModalRoute.withName('/connexion'));
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, '/accueil', ModalRoute.withName('/accueil'));
    }
  }
}
