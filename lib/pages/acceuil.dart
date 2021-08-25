import 'package:flutter/material.dart';
import 'package:gestion_bibliotheque/modeles/categorie.dart';
import 'package:gestion_bibliotheque/modeles/livre.dart';
import 'package:gestion_bibliotheque/services/apiService.dart';
import 'package:gestion_bibliotheque/services/outils.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Acceuil extends StatefulWidget {
  Acceuil({Key key}) : super(key: key);

  @override
  _AceuilState createState() => _AceuilState();
}

class _AceuilState extends State<Acceuil> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  int radioVal = 0;
  Arg arg;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List user = (prefs.getStringList('user') ?? null);
    if (user == null) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/connexion', ModalRoute.withName('/connexion'));
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context).settings.arguments != null) {
      arg = ModalRoute.of(context).settings.arguments as Arg;
      radioVal = arg.radioval;
    }

    if (radioVal != 0) {
      return Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xFFF8F9FA),
          drawer: Outils.builDrawer(context),
          appBar: Outils.buildAppBar(Outils.buildAppBarBottom(
            arg.catgorieName,
            IconButton(
                icon: Icon(
                  Icons.category_outlined,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () => showDialog(
                    context: context,
                    useSafeArea: true,
                    builder: (ctx) {
                      return MyDialog(radioVal);
                    })),
            IconButton(
                icon: Icon(
                  Icons.search_outlined,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pushNamed(context, "/recherche")),
          )),
          body: FutureBuilder<Categorie>(
              future: ApiService().getOneCategorie(radioVal, context),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      itemCount: snapshot.data.livreList.length,
                      itemBuilder: (context, index) {
                        DateTime date = DateTime.parse(
                            snapshot.data.livreList[index].dateCreation);
                        return Card(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          elevation: 3,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/detailslivre",
                                  arguments:
                                      snapshot.data.livreList[index].idlivre);
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 00, 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                shape: BoxShape.rectangle,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: ListTile(
                                      title: Text(
                                        snapshot.data.livreList[index].titre,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text("Auteur : " +
                                          snapshot
                                              .data.livreList[index].auteur),
                                    ),
                                  ),
                                  Image.network(
                                    snapshot.data.livreList[index].imageCle.url,
                                    fit: BoxFit.contain,
                                    height: MediaQuery.of(context).size.width,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: ListTile(
                                      subtitle: Text(DateFormat(
                                              "Ajoute le " + 'dd-MM-yyyy')
                                          .format(date)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
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
                            Navigator.pushNamed(context, "/",
                                arguments: Arg(
                                  radioVal,
                                  arg.catgorieName,
                                ));
                          }),
                      "Verifiez votre connexion");
                }

                return Outils.animationZone(LoadingBouncingGrid.square(
                  backgroundColor: Color.fromRGBO(79, 84, 103, 1),
                ));
              }));
    } else {
      return Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xFFF8F9FA),
          drawer: Outils.builDrawer(context),
          appBar: Outils.buildAppBar(AppBar(
            elevation: 1,
            excludeHeaderSemantics: true,
            backgroundColor: Color.fromRGBO(79, 84, 103, 1),
            title: Text(
              "Tous les livres",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.category_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () => showDialog(
                      context: context,
                      useSafeArea: true,
                      builder: (ctx) {
                        return MyDialog(radioVal);
                      })),
              IconButton(
                  icon: Icon(
                    Icons.search_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pushNamed(context, "/recherche")),
            ],
            automaticallyImplyLeading: false,
            shape: Border.fromBorderSide(BorderSide(
                color: Colors.black12, width: 0, style: BorderStyle.solid)),
          )),
          body: FutureBuilder<List<Livre>>(
              future: ApiService().getAllLivres(context),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        DateTime date =
                            DateTime.parse(snapshot.data[index].dateCreation);

                        return Card(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          elevation: 3,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/detailslivre",
                                  arguments: snapshot.data[index].idlivre);
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 00, 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                shape: BoxShape.rectangle,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: ListTile(
                                      title: Text(
                                        snapshot.data[index].titre,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text("Auteur : " +
                                          snapshot.data[index].auteur),
                                    ),
                                  ),
                                  Image.network(
                                    snapshot.data[index].imageCle.url,
                                    fit: BoxFit.contain,
                                    height: MediaQuery.of(context).size.width,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: ListTile(
                                      subtitle: Text(DateFormat(
                                              "Ajoute le " + 'dd-MM-yyyy')
                                          .format(date)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
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
                            Navigator.pushNamed(context, "/");
                          }),
                      "Verifiez votre connexion");
                }

                return Outils.animationZone(LoadingBouncingGrid.square(
                  backgroundColor: Color.fromRGBO(79, 84, 103, 1),
                ));
              }));
    }
  }
}

class MyDialog extends StatefulWidget {
  const MyDialog(this.idcategorie);

  final int idcategorie;
  @override
  State createState() => new MyDialogState();
}

class MyDialogState extends State<MyDialog> {
  int selectedId = 0;

  String categorieName = '';

  @override
  void initState() {
    super.initState();
    selectedId = widget.idcategorie;
  }

  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Annuler",
            style:
                TextStyle(color: Color.fromRGBO(79, 84, 103, 1), fontSize: 15),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, "/",
                arguments: new Arg(selectedId, categorieName));
          },
          child: Text(
            "Valider",
            style:
                TextStyle(color: Color.fromRGBO(79, 84, 103, 1), fontSize: 15),
          ),
        ),
      ],
      elevation: 4,
      title: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: Text(
            "Choisir une categorie",
            style: TextStyle(
              color: Color.fromRGBO(79, 84, 103, 1),
            ),
            textAlign: TextAlign.center,
          )),
      content: FutureBuilder<List<Categorie>>(
        future: ApiService().getAllCategories(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Divider(
                    height: 1,
                    thickness: 1,
                    indent: 1,
                  ),
                  Expanded(
                    child: new ListView.separated(
                      itemCount: snapshot.data.length,
                      separatorBuilder: (BuildContext ctx, int index) =>
                          const Divider(color: Color(0xFFF8F9FA), height: 0),
                      itemBuilder: (BuildContext ctx, int index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: ListTile(
                              onTap: null,
                              title: Text(snapshot.data[index].nom),
                              trailing: Radio(
                                value: snapshot.data[index].idcategorie,
                                groupValue: selectedId,
                                onChanged: (val) {
                                  setState(() {
                                    selectedId = val;
                                    categorieName = snapshot.data[index].nom;
                                  });
                                },
                                activeColor: Color.fromRGBO(79, 84, 103, 1),
                              )),
                        );
                      },
                    ),
                  ),
                ]);
          } else if (snapshot.hasError) {
            return Outils.animationZone(
                IconButton(
                    icon: Icon(
                      Icons.replay_circle_filled,
                    ),
                    iconSize: 60,
                    color: Color.fromRGBO(79, 84, 103, 1),
                    onPressed: () {
                      showDialog(
                          context: context,
                          useSafeArea: true,
                          builder: (ctx) {
                            return MyDialog(selectedId);
                          });
                    }),
                "Verifiez votre connexion");
          }

          return Outils.animationZone(LoadingFlipping.circle(
            borderColor: Color.fromRGBO(79, 84, 103, 1),
          ));
        },
      ),
    );
  }
}

class Arg {
  int radioval;
  String catgorieName;

  Arg(this.radioval, this.catgorieName);
}
