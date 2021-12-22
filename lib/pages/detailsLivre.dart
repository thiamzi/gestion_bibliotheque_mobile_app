import 'package:flutter/material.dart';
import 'package:gestion_bibliotheque/modeles/categorie.dart';
import 'package:gestion_bibliotheque/modeles/emprunt.dart';
import 'package:gestion_bibliotheque/modeles/etudiant.dart';
import 'package:gestion_bibliotheque/modeles/livre.dart';
import 'package:gestion_bibliotheque/modeles/reservation.dart';
import 'package:gestion_bibliotheque/modeles/user.dart';
import 'package:gestion_bibliotheque/services/apiService.dart';
import 'package:gestion_bibliotheque/services/authService.dart';
import 'package:gestion_bibliotheque/services/outils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animations/loading_animations.dart';

class DetailsLivre extends StatefulWidget {
  DetailsLivre({Key key}) : super(key: key);

  @override
  _DetailsLivreState createState() => _DetailsLivreState();
}

class _DetailsLivreState extends State<DetailsLivre> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _loadingE = false;
  bool _loadingR = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int idLivre = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFF8F9FA),
        appBar: Outils.buildAppBar(
            Outils.buildAppBarBottom("Details livre"),
            IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                })),
        body: FutureBuilder<User>(
            future: AuthService().getCurrentUser(context),
            builder: (context, user) {
              return FutureBuilder<Etudiant>(
                  future:
                      ApiService().getOneEtudiant(user.data.iduser, context),
                  builder: (context, etudiant) {
                    if (etudiant.hasData) {
                      return FutureBuilder<Livre>(
                          future: ApiService().getOneLivre(idLivre, context),
                          builder: (context, livre) {
                            if (livre.hasData) {
                              DateTime date =
                                  DateTime.parse(livre.data.dateCreation);
                              return FutureBuilder<Categorie>(
                                  future: ApiService().getOneCategorie(
                                      livre.data.categorieIdcategorie, context),
                                  builder: (context, categorie) {
                                    if (categorie.hasData) {
                                      return ListView(children: [
                                        Card(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 10, 0, 0),
                                          elevation: 3,
                                          child: Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 0, 10, 0),
                                                  child: ListTile(
                                                    title: Text(
                                                      livre.data.titre,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    subtitle: Text("Auteur : " +
                                                        livre.data.auteur),
                                                  ),
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
                                                    title: Text(
                                                        'Categorie : ${categorie.data.nom}'),
                                                    subtitle: Text(
                                                        "${DateFormat('dd-MM-yyyy').format(date)} à ${DateFormat('kk:mm').format(date)}"),
                                                  ),
                                                ),
                                                Outils.divider(),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 0, 10, 0),
                                                  child: ListTile(
                                                    title: Text(
                                                        'Nombre de fois emprunte : ' +
                                                            livre
                                                                .data
                                                                .empruntList
                                                                .length
                                                                .toString()),
                                                    subtitle: Text(
                                                        "Nonbre exemplaires : " +
                                                            livre.data.exmplaire
                                                                .toString() +
                                                            " - disponibles : " +
                                                            livre.data
                                                                .nbdisponible
                                                                .toString()),
                                                  ),
                                                ),
                                                Outils.divider(),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      20, 20, 20, 20),
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        shape:
                                                            BoxShape.rectangle,
                                                      ),
                                                      child: Text(livre
                                                          .data.description)),
                                                ),
                                                Outils.divider(),
                                                this._loadingR
                                                    ? Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 30, 0, 30),
                                                        child:
                                                            CircularProgressIndicator(
                                                          color:
                                                              Color(0xFF303030),
                                                        ),
                                                      )
                                                    : Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 30, 0, 30),
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            try {
                                                              Outils.info(
                                                                  context,
                                                                  "Etes vous sur vouloir reserver ?",
                                                                  () {
                                                                if (Outils.nonRegle(etudiant
                                                                            .data
                                                                            .reservationList
                                                                        as List<
                                                                            Reservation>) ==
                                                                    false) {
                                                                  setState(() {
                                                                    this._loadingR =
                                                                        true;
                                                                  });
                                                                  var numero =
                                                                      Outils
                                                                          .genererNumero();
                                                                  ApiService()
                                                                      .reserver(
                                                                    context,
                                                                    new Reservation(
                                                                      numero,
                                                                      null,
                                                                      null,
                                                                      false,
                                                                      user.data
                                                                          .iduser,
                                                                      livre.data
                                                                          .idlivre,
                                                                    ),
                                                                  )
                                                                      .then(
                                                                          (value) {
                                                                    setState(
                                                                        () {
                                                                      this._loadingR =
                                                                          false;
                                                                    });
                                                                  });
                                                                } else {
                                                                  Outils.erreur(
                                                                      context,
                                                                      "Erreur reservation",
                                                                      "Vous avez deja une reservation en cours");
                                                                }
                                                              });
                                                            } catch (err) {
                                                              setState(() {
                                                                this._loadingR =
                                                                    false;
                                                              });
                                                              return Outils
                                                                  .snackbar(
                                                                      context,
                                                                      'Erreur connexion. Veuillez verifier votre connexion');
                                                            }
                                                          },
                                                          child: Text(
                                                            "Reserver",
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
                                                                MaterialStateProperty
                                                                    .all<Size>(
                                                                        Size(
                                                                            150,
                                                                            50)),
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
                                                this._loadingE
                                                    ? Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 0, 0, 30),
                                                        child:
                                                            CircularProgressIndicator(
                                                          color:
                                                              Color(0xFF303030),
                                                        ),
                                                      )
                                                    : Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 0, 0, 30),
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            try {
                                                              Outils.info(
                                                                  context,
                                                                  "Etes vous sur vouloir emprunter ?",
                                                                  () {
                                                                if (Outils.nonRegle(etudiant
                                                                            .data
                                                                            .empruntList
                                                                        as List<
                                                                            Emprunt>) ==
                                                                    false) {
                                                                  setState(() {
                                                                    this._loadingE =
                                                                        true;
                                                                  });
                                                                  var numero =
                                                                      Outils
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
                                                                      .then(
                                                                          (value) {
                                                                    setState(
                                                                        () {
                                                                      this._loadingE =
                                                                          false;
                                                                    });
                                                                  }).onError((error,
                                                                          stackTrace) {
                                                                    setState(
                                                                        () {
                                                                      this._loadingE =
                                                                          false;
                                                                    });
                                                                  });
                                                                } else {
                                                                  setState(() {
                                                                    this._loadingE =
                                                                        false;
                                                                  });

                                                                  Outils.erreur(
                                                                      context,
                                                                      "Erreur emprunt",
                                                                      "Vous avez deja un emprunt en cours");
                                                                }
                                                              });
                                                            } catch (err) {
                                                              setState(() {
                                                                this._loadingE =
                                                                    false;
                                                              });
                                                              return Outils
                                                                  .snackbar(
                                                                      context,
                                                                      'Erreur connexion. Veuillez verifier votre connexion');
                                                            }
                                                          },
                                                          child: Text(
                                                            "Emprunter",
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
                                                                MaterialStateProperty
                                                                    .all<Size>(
                                                                        Size(
                                                                            150,
                                                                            50)),
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
                                        Card(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 4, 0, 5),
                                          elevation: 2,
                                          child: Container(
                                            color: Colors.white,
                                            child: ListTile(
                                              title: Text(
                                                'Autres livres de la meme categorie',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.7,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: categorie
                                                    .data.livreList.length,
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 0, 10),
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Center(
                                                        child: Card(
                                                      margin: EdgeInsets.all(0),
                                                      elevation: 3,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.pushNamed(
                                                              context,
                                                              "/detailslivre",
                                                              arguments:
                                                                  categorie
                                                                      .data
                                                                      .livreList[
                                                                          index]
                                                                      .idlivre);
                                                        },
                                                        child: Container(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets.only(left: 5),
                                                                child: ListTile(
                                                                  title: Text(
                                                                    categorie
                                                                        .data
                                                                        .livreList[
                                                                            index]
                                                                        .titre,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  subtitle: Text("Auteur : " +
                                                                      categorie
                                                                          .data
                                                                          .livreList[
                                                                              index]
                                                                          .auteur),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            20),
                                                                child: Image.network(
                                                                    categorie
                                                                        .data
                                                                        .livreList[
                                                                            index]
                                                                        .imageCle
                                                                        .url,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.5,
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )),
                                                  );
                                                }))
                                      ]);
                                    } else if (categorie.hasError) {
                                      return Text("");
                                    }
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [],
                                    );
                                  });
                            } else if (livre.hasError) {
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
