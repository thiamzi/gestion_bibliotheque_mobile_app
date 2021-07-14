import 'package:flutter/material.dart';
import 'package:gestion_bibliotheque/services/authService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Connexion extends StatefulWidget {
  Connexion({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ConnexiontState createState() => _ConnexiontState();
}

class _ConnexiontState extends State<Connexion> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String sub = (prefs.getString('sub') ?? "");
    if (sub == "") {
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, '/accueil', ModalRoute.withName('/accueil'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFF8F9FA),
        body: ConnexionForm());
  }
}

class ConnexionForm extends StatefulWidget {
  @override
  ConnexionFormState createState() {
    return ConnexionFormState();
  }
}

class ConnexionFormState extends State<ConnexionForm> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.fromLTRB(30, 30, 30, 30),
          decoration: BoxDecoration(
            color: Color.fromRGBO(79, 84, 103, 1),
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle,
          ),
          child: ListView(children: [
            (Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Container(
                    padding: EdgeInsets.all(6),
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.width * 0.4,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Color(0xFFFD7E14),
                            width: 5,
                            style: BorderStyle.solid)),
                    child: Image.asset(
                      'images/profile.png',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: email,
                    validator: (String value) {
                      if (value.isEmpty || value == null) {
                        return "Champ requis";
                      }
                      return null;
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Adresse Email',
                      labelStyle: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                      suffixIcon: Icon(
                        Icons.person,
                        size: 25,
                        color: Color.fromRGBO(79, 84, 103, 1),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      filled: true,
                      fillColor: Color(0xFFF8F9FA),
                    ),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: password,
                    obscureText: true,
                    validator: (String value) {
                      if (value.isEmpty || value == null) {
                        return "Champ requis";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.lock,
                        size: 20,
                        color: Color.fromRGBO(79, 84, 103, 1),
                      ),
                      labelText: 'Mot de passe',
                      labelStyle: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      filled: true,
                      fillColor: Color(0xFFF8F9FA),
                    ),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xFF303030),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Text(
                    'Mot de passe oublie ?',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.blue,
                      fontSize: 17,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        AuthService().handleSubmitted(
                            email.text, password.text, context);
                      } else {}
                    },
                    child: Text(
                      "Connexion",
                      style: TextStyle(
                          color: Color(0xFF303030),
                          fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(150, 50)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFFF8F9FA),
                      ),
                    ),
                  ),
                )
              ],
            )),
          ]),
        ));
  }
}
