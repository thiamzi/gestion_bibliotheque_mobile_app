import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:gestion_bibliotheque/modeles/userdetails.dart';
import 'package:gestion_bibliotheque/services/authService.dart';
import 'package:gestion_bibliotheque/services/outils.dart';

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
  bool _loading = false;

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
          padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
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
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 145, 77, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 1),
                      child: Text(
                        'Bienvenue',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Container(
                    padding: EdgeInsets.all(6),
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.width * 0.35,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Color.fromRGBO(255, 145, 77, 1),
                            width: 7,
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
                _loading
                    ? Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: CircularProgressIndicator(
                          color: Color(0xFFF8F9FA),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                this._loading = true;
                              });
                              handleSubmitted(
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

  void handleSubmitted(username, password, context) async {
    Userdetails response;
    setState(() {
      this._loading=true;
    });
    await AuthService()
        .authenticateUser(username, password, context)
        .then((value) {
      response = value;
    }).whenComplete(() {
      if (response != null) {
        AuthService().saveAndRedirectToHome(context, response);
      }else{
        setState(() {
          this._loading=false;
        });
      }
    }).onError((error, stackTrace) {
      setState(() {
        this._loading=false;
      });
      return Outils.snackbar(
          context, 'Erreur connexion. Veuillez verifier votre connexion');
    });
  }
}
