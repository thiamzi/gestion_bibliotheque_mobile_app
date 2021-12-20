import 'package:flutter/material.dart';
import 'package:gestion_bibliotheque/modeles/etudiant.dart';
import 'package:gestion_bibliotheque/modeles/user.dart';
import 'package:gestion_bibliotheque/services/apiService.dart';
import 'package:gestion_bibliotheque/services/authService.dart';
import 'package:gestion_bibliotheque/services/outils.dart';
import 'package:get/get.dart';
import 'package:loading_animations/loading_animations.dart';

class MonProfile extends StatefulWidget {
  MonProfile({Key key}) : super(key: key);

  @override
  _MonProfileState createState() => _MonProfileState();
}

class _MonProfileState extends State<MonProfile> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  User upadteUser;

  @override
  void initState() {
    super.initState();
  }

  Future changerMdp(context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return PasswordForm(user: upadteUser);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFF8F9FA),
        appBar: Outils.buildAppBar(
          Outils.buildAppBarBottom(
            "Mon profile",
            IconButton(
                icon: Icon(
                  Icons.edit_outlined,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (upadteUser != null) {
                    changerMdp(context);
                  } else {
                    Outils.snackbar(context, "Veuillez patientez...", false);
                  }
                }),
          ),
        ),
        drawer: Outils.builDrawer(context),
        body: FutureBuilder<User>(
            future: AuthService().getCurrentUser(context),
            builder: (context, user) {
              return FutureBuilder<Etudiant>(
                  future:
                      ApiService().getOneEtudiant(user.data.iduser, context),
                  builder: (context, etudiant) {
                    if (etudiant.hasData) {
                      upadteUser = user.data;
                      return ListView(children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                color: Color.fromRGBO(79, 84, 103, 1),
                                child: Text("Nom",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                              ListTile(
                                minLeadingWidth: 0,
                                tileColor: Colors.white,
                                title: Text(
                                  etudiant.data.nom,
                                ),
                              ),
                              Divider(
                                height: 10,
                                color: Color(0xFFF8F9FA),
                              ),
                              Card(
                                color: Color.fromRGBO(79, 84, 103, 1),
                                child: Text(" Prenom ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                              ListTile(
                                tileColor: Colors.white,
                                minLeadingWidth: 0,
                                title: Text(
                                  etudiant.data.prenom,
                                ),
                              ),
                              Divider(
                                height: 10,
                                color: Color(0xFFF8F9FA),
                              ),
                              Card(
                                color: Color.fromRGBO(79, 84, 103, 1),
                                child: Text(" Numero dossier ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                              ListTile(
                                minLeadingWidth: 0,
                                tileColor: Colors.white,
                                title: Text(
                                  etudiant.data.numeroDossier.toString(),
                                ),
                              ),
                              Divider(
                                height: 10,
                                color: Color(0xFFF8F9FA),
                              ),
                              Card(
                                color: Color.fromRGBO(79, 84, 103, 1),
                                child: Text(" Adresse email ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                              ListTile(
                                minLeadingWidth: 0,
                                tileColor: Colors.white,
                                title: Text(
                                  etudiant.data.user.email,
                                ),
                              ),
                              Divider(
                                height: 10,
                                color: Color(0xFFF8F9FA),
                              ),
                              Card(
                                color: Color.fromRGBO(79, 84, 103, 1),
                                child: Text(" Date naissance ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                              ListTile(
                                minLeadingWidth: 0,
                                tileColor: Colors.white,
                                title: Text(
                                  etudiant.data.dateNaissance,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              )
                            ],
                          ),
                        )
                      ]);
                    } else if (etudiant.hasError) {
                      return Outils.animationZone(
                          IconButton(
                              icon: Icon(
                                Icons.replay_circle_filled,
                              ),
                              iconSize: 60,
                              color: Color.fromRGBO(79, 84, 103, 1),
                              onPressed: () {
                                Get.appUpdate();
                              }),
                          "Verifiez votre connexion");
                    }

                    return Outils.animationZone(LoadingBouncingGrid.square(
                      backgroundColor: Color.fromRGBO(79, 84, 103, 1),
                    ));
                  });
            }));
  }
}

class PasswordForm extends StatefulWidget {
  PasswordForm({this.user});
  final User user;
  @override
  PasswordFormState createState() {
    return PasswordFormState();
  }
}

class PasswordFormState extends State<PasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final controlMdp = TextEditingController();
  final controlCmdp = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controlMdp.dispose();
    controlCmdp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SimpleDialog(
            title: Text(
              "Changer mot de passe",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            children: <Widget>[
              Divider(
                thickness: 1,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: controlMdp,
                        validator: (String value) {
                          if (value.isEmpty || value == null) {
                            return "Champ requis";
                          } else if (value.length < 7) {
                            return "Mot de passe trop court";
                          }
                          return null;
                        },
                        autofocus: true,
                        obscureText: true,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.lock,
                            size: 20,
                            color: Color.fromRGBO(79, 84, 103, 1),
                          ),
                          labelText: "Mot de passe",
                          contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: controlCmdp,
                      autofocus: true,
                      obscureText: true,
                      validator: (String value) {
                        if (value != controlMdp.text &&
                            value.isNotEmpty &&
                            value != null) {
                          return "Les mots de passe correspondent pas";
                        } else if (value.isEmpty || value == null) {
                          return "Champ requis";
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Confirmer mot de passe",
                        contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        suffixIcon: Icon(
                          Icons.lock,
                          size: 20,
                          color: Color.fromRGBO(79, 84, 103, 1),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              widget.user.password = controlMdp.text;
                              AuthService()
                                  .upadtePassword(widget.user, context)
                                  .whenComplete(() {
                                controlCmdp.text = "";
                                controlMdp.text = "";
                              }).onError((error, stackTrace) {
                                return Outils.snackbar(context,
                                    'Erreur connexion. Veuillez verifier votre connexion');
                              });
                            } else {}
                          },
                          child: Text(
                            "Valider",
                            style: TextStyle(
                                color: Color.fromRGBO(79, 84, 103, 1),
                                fontWeight: FontWeight.bold),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            side: MaterialStateProperty.all(BorderSide(
                                color: Color.fromRGBO(79, 84, 103, 1))),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 30, 0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Fermer",
                            style: TextStyle(
                                color: Color.fromRGBO(79, 84, 103, 1),
                                fontWeight: FontWeight.bold),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            side: MaterialStateProperty.all(BorderSide(
                                color: Color.fromRGBO(79, 84, 103, 1))),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ]));
  }
}
