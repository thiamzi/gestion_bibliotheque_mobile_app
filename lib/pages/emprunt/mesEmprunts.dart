import 'package:flutter/material.dart';
import 'package:gestion_bibliotheque/modeles/emprunt.dart';
import 'package:gestion_bibliotheque/modeles/etudiant.dart';
import 'package:gestion_bibliotheque/modeles/livre.dart';
import 'package:gestion_bibliotheque/modeles/user.dart';
import 'package:gestion_bibliotheque/services/apiService.dart';
import 'package:gestion_bibliotheque/services/authService.dart';
import 'package:gestion_bibliotheque/services/outils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animations/loading_animations.dart';

class MesEmprunts extends StatefulWidget {
  MesEmprunts({Key key}) : super(key: key);

  @override
  _MesEmpruntsState createState() => _MesEmpruntsState();
}

class _MesEmpruntsState extends State<MesEmprunts> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _loading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: AuthService().getCurrentUser(context),
        builder: (context, user) {
          return Outils.buildTabs(
              context,
              Text("En cours"),
              Text("Historique"),
              FutureBuilder<Emprunt>(
                  future: ApiService()
                      .getEtudiantEmpruntEnCours(user.data.iduser, context),
                  builder: (context, empruntCours) {
                    if (empruntCours.hasData) {
                      if (empruntCours.data.numeroEmprunt == 0) {
                        return Outils.noData();
                      }
                      DateTime debut =
                          DateTime.parse(empruntCours.data.dateDebut);
                      DateTime fin = DateTime.parse(empruntCours.data.dateFin);
                      DateTime delai =
                          DateTime.parse(empruntCours.data.delaiRecup);
                      return FutureBuilder<Etudiant>(
                          future: ApiService().getOneEtudiant(
                              empruntCours.data.etudiantUserIduser, context),
                          builder: (context, etudiant) {
                            if (etudiant.hasData) {
                              return FutureBuilder<Livre>(
                                  future: ApiService().getOneLivre(
                                      empruntCours.data.livreIdlivre, context),
                                  builder: (context, livre) {
                                    if (livre.hasData) {
                                      return new ListView(children: [
                                        Card(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 10, 0, 10),
                                          elevation: 3,
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 10, 0, 0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            10, 0, 10, 0),
                                                    child: ListTile(
                                                        title: Text(
                                                          'N° ${empruntCours.data.numeroEmprunt}',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        subtitle:
                                                            !empruntCours.data
                                                                    .confirmer
                                                                ? Text(
                                                                    "Debut : " +
                                                                        DateFormat('dd-MM-yyyy').format(
                                                                            debut) +
                                                                        " - Recuperation : " +
                                                                        DateFormat('dd-MM-yyyy')
                                                                            .format(delai),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red),
                                                                  )
                                                                : Text(
                                                                    "Debut : " +
                                                                        DateFormat('dd-MM-yyyy').format(
                                                                            debut) +
                                                                        " - date fin : " +
                                                                        DateFormat('dd-MM-yyyy')
                                                                            .format(fin),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red),
                                                                  )),
                                                  ),
                                                  Image.network(
                                                    livre.data.imageCle.url,
                                                    fit: BoxFit.fill,
                                                    height:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            10, 0, 10, 0),
                                                    child: ListTile(
                                                      title: Text(
                                                          livre.data.titre),
                                                      subtitle: Text(
                                                          "Auteur : Mr Top"),
                                                    ),
                                                  ),
                                                  Outils.divider(),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            10, 0, 10, 0),
                                                    child: ListTile(
                                                      title: Text(
                                                          "${etudiant.data.prenom}  ${etudiant.data.nom}"),
                                                      subtitle: Text(
                                                          "N° Dossier : ${etudiant.data.numeroDossier}"),
                                                    ),
                                                  ),
                                                  Outils.divider(),
                                                  !empruntCours.data.confirmer
                                                      ? Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 30, 0, 30),
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              Outils.info(
                                                                  context,
                                                                  "Etes vous sur vouloir annuler ?",
                                                                  () {
                                                                ApiService()
                                                                    .annulerEmprunt(
                                                                        context,
                                                                        empruntCours
                                                                            .data
                                                                            .numeroEmprunt)
                                                                    .whenComplete(
                                                                        () {
                                                                  Navigator
                                                                      .pushNamed(
                                                                    context,
                                                                    '/mesemprunts',
                                                                  );
                                                                }).onError((error,
                                                                        stackTrace) {
                                                                  return Outils
                                                                      .snackbar(
                                                                          context,
                                                                          'Erreur connexion. Veuillez verifier votre connexion');
                                                                });
                                                              });
                                                            },
                                                            child: Text(
                                                              "Annuler",
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          79,
                                                                          84,
                                                                          103,
                                                                          1),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            style: ButtonStyle(
                                                              minimumSize:
                                                                  MaterialStateProperty.all<
                                                                          Size>(
                                                                      Size(150,
                                                                          50)),
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      Colors
                                                                          .white),
                                                              side: MaterialStateProperty
                                                                  .all(BorderSide(
                                                                      color: Color.fromRGBO(
                                                                          79,
                                                                          84,
                                                                          103,
                                                                          1))),
                                                            ),
                                                          ),
                                                        )
                                                      : Row()
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]);
                                    } else if (livre.hasError) {
                                      return Outils.animationZone(
                                          IconButton(
                                              icon: Icon(
                                                Icons.replay_circle_filled,
                                              ),
                                              iconSize: 60,
                                              color: Color.fromRGBO(
                                                  79, 84, 103, 1),
                                              onPressed: () {
                                                Navigator.pushReplacementNamed(
                                                  context,
                                                  "/mesemprunts",
                                                );
                                              }),
                                          "Verifiez votre connexion");
                                    }

                                    return Outils.animationZone(
                                        LoadingBouncingGrid.square(
                                      backgroundColor:
                                          Color.fromRGBO(79, 84, 103, 1),
                                    ));
                                  });
                            } else if (etudiant.hasError) {
                              return Outils.animationZone(
                                  IconButton(
                                      icon: Icon(
                                        Icons.replay_circle_filled,
                                      ),
                                      iconSize: 60,
                                      color: Color.fromRGBO(79, 84, 103, 1),
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          "/mesemprunts",
                                        );
                                      }),
                                  "Verifiez votre connexion");
                            }

                            return Outils.animationZone(
                                LoadingBouncingGrid.square(
                              backgroundColor: Color.fromRGBO(79, 84, 103, 1),
                            ));
                          });
                    } else if (empruntCours.hasError) {
                      return Outils.animationZone(
                          IconButton(
                              icon: Icon(
                                Icons.replay_circle_filled,
                              ),
                              iconSize: 60,
                              color: Color.fromRGBO(79, 84, 103, 1),
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  "/mesemprunts",
                                );
                              }),
                          "Verifiez votre connexion");
                    }

                    return Outils.animationZone(LoadingBouncingGrid.square(
                      backgroundColor: Color.fromRGBO(79, 84, 103, 1),
                    ));
                  }),
              FutureBuilder<List<Emprunt>>(
                  future: ApiService()
                      .getEtudiantEmpruntsList(user.data.iduser, context),
                  builder: (context, empruntsList) {
                    if (empruntsList.hasData) {
                      if (empruntsList.data[0].numeroEmprunt == 0) {
                        return Outils.noData();
                      }
                      return new ListView.separated(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        itemCount: empruntsList.data.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                          color: Color(0xFFF8F9FA),
                          height: 2,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            elevation: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                shape: BoxShape.rectangle,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: ListTile(
                                      onTap: () {
                                        Get.toNamed(
                                            "/detailshistoriqueemprunt",
                                            arguments: empruntsList
                                                .data[index].numeroEmprunt);
                                      },
                                      title: Text(
                                          'N° ${empruntsList.data[index].numeroEmprunt}'),
                                      subtitle: Text(
                                        empruntsList.data[index].dateDebut,
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else if (empruntsList.hasError) {
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
                  }));
        });
  }
}
