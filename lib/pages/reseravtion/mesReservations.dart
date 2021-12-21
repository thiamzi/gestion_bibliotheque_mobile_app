import 'package:flutter/material.dart';
import 'package:gestion_bibliotheque/modeles/emprunt.dart';
import 'package:gestion_bibliotheque/modeles/etudiant.dart';
import 'package:gestion_bibliotheque/modeles/livre.dart';
import 'package:gestion_bibliotheque/modeles/reservation.dart';
import 'package:gestion_bibliotheque/modeles/user.dart';
import 'package:gestion_bibliotheque/services/apiService.dart';
import 'package:gestion_bibliotheque/services/authService.dart';
import 'package:gestion_bibliotheque/services/outils.dart';
import 'package:get/get.dart';
import 'package:loading_animations/loading_animations.dart';

class MesReservations extends StatefulWidget {
  MesReservations({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MesReservationsState createState() => _MesReservationsState();
}

class _MesReservationsState extends State<MesReservations> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _loadingE = false;
  bool _loadingA = false;

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
              Text("Historique réservations"),
              FutureBuilder<Reservation>(
                  future: ApiService()
                      .getEtudiantReservationEnCours(user.data.iduser, context),
                  builder: (context, reservationCours) {
                    if (reservationCours.hasData) {
                      if (reservationCours.data.numeroReservation == 0) {
                        return Outils.noData();
                      }
                      return FutureBuilder<Etudiant>(
                          future: ApiService().getOneEtudiant(
                              reservationCours.data.etudiantUserIduser,
                              context),
                          builder: (context, etudiant) {
                            if (etudiant.hasData) {
                              return FutureBuilder<Livre>(
                                  future: ApiService().getOneLivre(
                                      reservationCours.data.livreIdlivre,
                                      context),
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
                                                        'N° ${reservationCours.data.numeroReservation}',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      subtitle: Text(
                                                        "Debut : ${reservationCours.data.date} - Fin : ${reservationCours.data.dateFin} ",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                    ),
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
                                                  _loadingA
                                                      ? Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 30, 0, 30),
                                                          child: CircularProgressIndicator(
                                                              color: Color(
                                                                  0xFF303030)))
                                                      : Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 30, 0, 30),
                                                          child: ElevatedButton(
                                                            onPressed: () {

                                                              Outils.info(
                                                                  context,
                                                                  "Etes vous sur vouloir annuler ?",
                                                                  () {
                                                                    setState(() {
                                                                      _loadingA =
                                                                      true;
                                                                    });
                                                                ApiService()
                                                                    .annulerReservation(
                                                                        context,
                                                                        reservationCours
                                                                            .data
                                                                            .numeroReservation)
                                                                    .whenComplete(
                                                                        () {
                                                                  Get.appUpdate();
                                                                }).onError((error,
                                                                        stackTrace) {
                                                                  setState(() {
                                                                    _loadingA =
                                                                        false;
                                                                  });
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
                                                        ),
                                                  _loadingE
                                                      ? Padding(
                                                      padding: EdgeInsets
                                                          .fromLTRB(
                                                          0, 0, 0, 30),
                                                      child: CircularProgressIndicator(
                                                          color: Color(
                                                              0xFF303030)))
                                                      :  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 0, 30),
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Outils.info(context,
                                                            "Etes vous sur vouloir emprunter ?",
                                                            () {
                                                              setState(() {
                                                                _loadingE =
                                                                true;
                                                              });
                                                          if (Outils.nonRegle(etudiant
                                                                      .data
                                                                      .empruntList
                                                                  as List<
                                                                      Emprunt>) ==
                                                              false) {
                                                            var numero = Outils
                                                                .genererNumero();
                                                            ApiService()
                                                                .emprunter(
                                                              context,
                                                              new Emprunt(
                                                                numero,
                                                                null,
                                                                null,
                                                                null,
                                                                false,
                                                                false,
                                                                user.data
                                                                    .iduser,
                                                                livre.data
                                                                    .idlivre,
                                                              ),
                                                            )
                                                                .whenComplete(
                                                                    () {
                                                              Get.toNamed(
                                                                '/mesemprunts',
                                                              );
                                                            }).onError((error,
                                                                    stackTrace) {
                                                              setState(() {
                                                                _loadingE =
                                                                false;
                                                              });
                                                              return Outils
                                                                  .snackbar(
                                                                      context,
                                                                      'Erreur connexion. Veuillez verifier votre connexion');
                                                            });
                                                          } else {
                                                            setState(() {
                                                              _loadingE =
                                                              false;
                                                            });
                                                            Outils.erreur(
                                                                context,
                                                                "Erreur emprunt",
                                                                "Vous avez deja un emprunt en cours");
                                                          }
                                                        });
                                                      },
                                                      child: Text(
                                                        "Emprunter",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
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
                                                            MaterialStateProperty
                                                                .all<Size>(Size(
                                                                    150, 50)),
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    Colors
                                                                        .white),
                                                        side: MaterialStateProperty
                                                            .all(BorderSide(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        79,
                                                                        84,
                                                                        103,
                                                                        1))),
                                                      ),
                                                    ),
                                                  ),
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
                                                Get.appUpdate();
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
                                        Get.appUpdate();
                                      }),
                                  "Verifiez votre connexion");
                            }

                            return Outils.animationZone(
                                LoadingBouncingGrid.square(
                              backgroundColor: Color.fromRGBO(79, 84, 103, 1),
                            ));
                          });
                    } else if (reservationCours.hasError) {
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
                  }),
              FutureBuilder<List<Reservation>>(
                  future: ApiService()
                      .getEtudiantReservationsList(user.data.iduser, context),
                  builder: (context, reservationList) {
                    if (reservationList.hasData) {
                      if (reservationList.data[0].numeroReservation == 0) {
                        return Outils.noData();
                      }
                      return new ListView.separated(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        itemCount: reservationList.data.length,
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
                                            "/detailshistoriquereservation",
                                            arguments: reservationList
                                                .data[index].numeroReservation);
                                      },
                                      title: Text(
                                          'N° ${reservationList.data[index].numeroReservation}'),
                                      subtitle: Text(
                                        reservationList.data[index].date,
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
                    } else if (reservationList.hasError) {
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
