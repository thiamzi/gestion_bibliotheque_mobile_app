import 'package:flutter/material.dart';
import 'package:gestion_bibliotheque/modeles/emprunt.dart';
import 'package:gestion_bibliotheque/modeles/etudiant.dart';
import 'package:gestion_bibliotheque/modeles/livre.dart';
import 'package:gestion_bibliotheque/services/apiService.dart';
import 'package:gestion_bibliotheque/services/outils.dart';
import 'package:intl/intl.dart';
import 'package:loading_animations/loading_animations.dart';

class DetailsHistoriqueEmprunt extends StatefulWidget {
  DetailsHistoriqueEmprunt({Key key}) : super(key: key);

  @override
  _DetailsHistoriqueEmpruntState createState() =>
      _DetailsHistoriqueEmpruntState();
}

class _DetailsHistoriqueEmpruntState extends State<DetailsHistoriqueEmprunt> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int numeroEmprunt = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF8F9FA),
      appBar: Outils.buildAppBar(Outils().buildAppBarBottom("Details emprunt")),
      body: FutureBuilder<Emprunt>(
          future: ApiService().getOneEmprunt(numeroEmprunt, context),
          builder: (context, emprunt) {
            if (emprunt.hasData) {
              DateTime debut = DateTime.parse(emprunt.data.dateDebut);
              DateTime fin = DateTime.parse(emprunt.data.dateFin);
              return FutureBuilder<Etudiant>(
                  future: ApiService()
                      .getOneEtudiant(emprunt.data.etudiantUserIduser, context),
                  builder: (context, etudiant) {
                    if (etudiant.hasData) {
                      return FutureBuilder<Livre>(
                          future: ApiService()
                              .getOneLivre(emprunt.data.livreIdlivre, context),
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
                                                  'N° ${emprunt.data.numeroEmprunt}',
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
                                          "/detailshistoriqueemprunt",
                                          arguments: numeroEmprunt,
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
                                  "/detailshistoriqueemprunt",
                                  arguments: numeroEmprunt,
                                );
                              }),
                          "Verifiez votre connexion");
                    }

                    return Outils.animationZone(LoadingBouncingGrid.square(
                      backgroundColor: Color.fromRGBO(79, 84, 103, 1),
                    ));
                  });
            } else if (emprunt.hasError) {
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
                          "/detailshistoriqueemprunt",
                          arguments: numeroEmprunt,
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
