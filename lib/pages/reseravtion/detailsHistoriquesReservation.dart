import 'package:flutter/material.dart';
import 'package:gestion_bibliotheque/modeles/etudiant.dart';
import 'package:gestion_bibliotheque/modeles/livre.dart';
import 'package:gestion_bibliotheque/modeles/reservation.dart';
import 'package:gestion_bibliotheque/services/apiService.dart';
import 'package:gestion_bibliotheque/services/outils.dart';
import 'package:intl/intl.dart';
import 'package:loading_animations/loading_animations.dart';

class DetailsHistoriqueReservation extends StatefulWidget {
  DetailsHistoriqueReservation({Key key}) : super(key: key);

  @override
  _DetailsHistoriqueReservationState createState() =>
      _DetailsHistoriqueReservationState();
}

class _DetailsHistoriqueReservationState
    extends State<DetailsHistoriqueReservation> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int numeroReservation = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF8F9FA),
      appBar:
          Outils.buildAppBar(Outils.buildAppBarBottom("Details reservation")),
      body: FutureBuilder<Reservation>(
          future: ApiService().getOneReservation(numeroReservation, context),
          builder: (context, reservation) {
            if (reservation.hasData) {
              DateTime debut = DateTime.parse(reservation.data.date);
              DateTime fin = DateTime.parse(reservation.data.dateFin);
              return FutureBuilder<Etudiant>(
                  future: ApiService().getOneEtudiant(
                      reservation.data.etudiantUserIduser, context),
                  builder: (context, etudiant) {
                    if (etudiant.hasData) {
                      return FutureBuilder<Livre>(
                          future: ApiService().getOneLivre(
                              reservation.data.livreIdlivre, context),
                          builder: (context, livre) {
                            if (livre.hasData) {
                              return new ListView(children: [
                                Card(
                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  elevation: 3,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: ListTile(
                                                title: Text(
                                                  'N° ${reservation.data.numeroReservation}',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                subtitle: Text(
                                                  "Debut : " +
                                                      DateFormat('dd-MM-yyyy')
                                                          .format(debut) +
                                                      " - date fin : " +
                                                      DateFormat('dd-MM-yyyy')
                                                          .format(fin),
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                )),
                                          ),
                                          Image.network(
                                            livre.data.imageCle.url,
                                            fit: BoxFit.fill,
                                            height: MediaQuery.of(context)
                                                .size
                                                .width,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: ListTile(
                                              title: Text(livre.data.titre),
                                              subtitle: Text("Auteur : Mr Top"),
                                            ),
                                          ),
                                          Outils.divider(),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: ListTile(
                                              title: Text(
                                                  "${etudiant.data.prenom}  ${etudiant.data.nom}"),
                                              subtitle: Text(
                                                  "Email : ${etudiant.data.user.email}"),
                                            ),
                                          ),
                                          Outils.divider(),
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
                                      color: Color.fromRGBO(79, 84, 103, 1),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          "/detailshistoriquereservation",
                                          arguments: numeroReservation,
                                        );
                                      }),
                                  "Verifiez votre connexion");
                            }

                            return Outils.animationZone(
                                LoadingBouncingGrid.square(
                              backgroundColor: Color.fromRGBO(79, 84, 103, 1),
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
                                Navigator.pushNamed(
                                  context,
                                  "/detailshistoriquereservation",
                                  arguments: numeroReservation,
                                );
                              }),
                          "Verifiez votre connexion");
                    }

                    return Outils.animationZone(LoadingBouncingGrid.square(
                      backgroundColor: Color.fromRGBO(79, 84, 103, 1),
                    ));
                  });
            } else if (reservation.hasError) {
              return Outils.animationZone(
                  IconButton(
                      icon: Icon(
                        Icons.replay_circle_filled,
                      ),
                      iconSize: 60,
                      color: Color.fromRGBO(79, 84, 103, 1),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          "/detailshistoriquereservation",
                          arguments: numeroReservation,
                        );
                      }),
                  "Verifiez votre connexion");
            }

            return Outils.animationZone(LoadingBouncingGrid.square(
              backgroundColor: Color.fromRGBO(79, 84, 103, 1),
            ));
          }),
    );
  }
}
