import 'package:flutter/material.dart';
import 'package:gestion_bibliotheque/modeles/livre.dart';
import 'package:gestion_bibliotheque/services/apiService.dart';
import 'package:gestion_bibliotheque/services/outils.dart';
import 'package:loading_animations/loading_animations.dart';

class Recherche extends StatefulWidget {
  Recherche({Key key}) : super(key: key);

  @override
  _RechercheState createState() => _RechercheState();
}

class _RechercheState extends State<Recherche> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final searchControl = TextEditingController();
  String valueSearch;
  List<Livre> liste = [];
  List<Livre> tmp = [];

  @override
  void initState() {
    liste.clear();
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    searchControl.dispose();
    super.dispose();
  }

  onChange(String value) {
    setState(() {
      List<Livre> results = [];
      for (var livre in tmp) {
        if (livre.auteur.toLowerCase().contains(value.toLowerCase()) ||
            livre.titre.toLowerCase().contains(value..toLowerCase())) {
          results.add(livre);
        }
      }

      liste = results;

      if (results.length == 0 || value == '') {
        liste.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFF8F9FA),
        appBar: Outils.buildAppBar(
            Outils.buildAppBarForSearch(
              Padding(
                padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                child: TextFormField(
                  controller: searchControl,
                  onChanged: onChange,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      size: 25,
                      color: Color(0xFFF8F9FA),
                    ),
                    labelStyle: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFF8F9FA),
                        width: 5,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white70,
                        width: 100,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                  ),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFF303030),
                  ),
                ),
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                })),
        body: FutureBuilder<List<Livre>>(
            future: ApiService().getAllLivres(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                tmp = snapshot.data;

                return ListView.builder(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                    itemCount: liste.length,
                    itemBuilder: (context, index) {
                      if (liste.length != 0) {
                        return Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: ListTile(
                                  onTap: () {
                                    searchControl.text = "";
                                    Navigator.pushNamed(
                                        context, "/detailslivre",
                                        arguments: liste[index].idlivre);
                                  },
                                  title: Text(liste[index].titre),
                                  subtitle: Text(
                                    liste[index].auteur,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Column();
                      }
                    });
              } else if (snapshot.hasError) {
                return Outils.animationZone(
                    IconButton(
                        icon: Icon(
                          Icons.replay_circle_filled,
                        ),
                        iconSize: 60,
                        color: Color.fromRGBO(79, 84, 103, 1),
                        onPressed: () {
                          Navigator.pushNamed(context, "/recherche");
                        }),
                    "Verifiez votre connexion");
              }

              return Outils.animationZone(LoadingBouncingGrid.square(
                backgroundColor: Color.fromRGBO(79, 84, 103, 1),
              ));
            }));
  }
}
