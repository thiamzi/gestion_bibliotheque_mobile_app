import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestion_bibliotheque/pages/connexion.dart';
import 'package:gestion_bibliotheque/services/authService.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:cool_alert/cool_alert.dart';

class Outils {
  static AppBar buildAppBar([Widget bottom, Widget iconb3]) {
    return AppBar(
      leading: iconb3 == null ? null : iconb3,
      elevation: 2,
      backgroundColor: Color.fromRGBO(79, 84, 103, 1),
      title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(
          "images/profile.png",
          height: 53,
        ),
      ]),
      actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.info_outline,
              size: 25,
              color: Colors.white,
            ),
            onPressed: null),
      ],
      bottom: bottom,
    );
  }

  static Widget divider() {
    Divider div = Divider(
      height: 1,
      thickness: 1,
      indent: 12,
      endIndent: 12,
    );
    return div;
  }

  static double deconnexionPading(context) {
    double m = MediaQuery.of(context).size.height;
    if (m >= 470 && m <= 500) {
      return m * 0.12;
    }
    if (m >= 501 && m <= 530) {
      return m * 0.15;
    }
    if (m >= 531 && m <= 560) {
      return m * 0.19;
    }
    if (m >= 561 && m <= 590) {
      return m * 0.21;
    }
    if (m >= 591 && m <= 620) {
      return m * 0.24;
    }
    if (m >= 621 && m <= 650) {
      return m * 0.3;
    }
    if (m >= 651 && m <= 680) {
      return m * 0.33;
    }
    if (m >= 681 && m <= 710) {
      return m * 0.36;
    }
    if (m >= 711 && m <= 730) {
      return m * 0.39;
    }
    if (m >= 731 && m <= 760) {
      return m * 0.42;
    }
    if (m >= 761 && m <= 790) {
      return m * 0.45;
    }
    if (m >= 791 && m <= 820) {
      return m * 0.48;
    }
    if (m >= 821 && m <= 850) {
      return m * 0.51;
    }
    if (m >= 851 && m <= 880) {
      return m * 0.54;
    }
    if (m >= 881 && m <= 910) {
      return m * 0.57;
    }
    if (m >= 911 && m <= 940) {
      return m * 0.6;
    }
    if (m >= 941 && m <= 970) {
      return m * 0.63;
    }
    if (m >= 971 && m <= 1000) {
      return m * 0.66;
    }
    if (m >= 1001) {
      return m * 0.7;
    }
  }

  static Drawer builDrawer(context) {
    return Drawer(
      elevation: 10,
      child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Color.fromRGBO(79, 84, 103, 1),
          ),
          child: FutureBuilder<String>(
            future: AuthService().getUserEmail(context),
            builder: (context, email) {
              if (!email.hasData) {}
              return ListView(
                children: <Widget>[
                  DrawerHeader(
                      child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 45,
                        backgroundImage: AssetImage(
                          'images/person.PNG',
                        ),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                      Text(
                        email.data,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, "/accueil");
                        },
                        icon: Icon(
                          Icons.home,
                          color: Colors.orange.shade400,
                          size: 25,
                        ),
                        label: Text(
                          "Accueil",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        style: ButtonStyle(alignment: Alignment.centerLeft),
                      ),
                      divider(),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, "/monprofile",
                              arguments: email.data);
                        },
                        icon: Icon(
                          Icons.person,
                          color: Colors.orange.shade400,
                          size: 25,
                        ),
                        label: Text(
                          "Mon profile",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        style: ButtonStyle(alignment: Alignment.centerLeft),
                      ),
                      divider(),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, "/mesemprunts",
                              arguments: email.data);
                        },
                        icon: Icon(
                          Icons.list,
                          color: Colors.orange.shade400,
                          size: 25,
                        ),
                        label: Text(
                          "Mes emprunts",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        style: ButtonStyle(alignment: Alignment.centerLeft),
                      ),
                      divider(),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, "/mesreservations",
                              arguments: email.data);
                        },
                        icon: Icon(
                          Icons.list,
                          color: Colors.orange.shade400,
                          size: 25,
                        ),
                        label: Text(
                          "Mes reservations ",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        style: ButtonStyle(alignment: Alignment.centerLeft),
                      ),
                      divider(),
                    ],
                  ),
                  Divider(
                    height: deconnexionPading(context),
                    color: Color.fromRGBO(79, 84, 103, 1),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          AuthService.deconnexion(context);
                        },
                        icon: Icon(
                          Icons.logout,
                          color: Colors.orange.shade400,
                          size: 25,
                        ),
                        label: Text(
                          "Deconnexion",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        style: ButtonStyle(
                          alignment: Alignment.bottomLeft,
                        ),
                      ),
                      divider(),
                    ],
                  )
                ],
              );
            },
          )),
    );
  }

  static Future info(context, message, methode1(), [merthode2()]) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(
              message,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            children: <Widget>[
              Divider(
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SimpleDialogOption(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green),
                            minimumSize:
                                MaterialStateProperty.all<Size>(Size(90, 35))),
                        child: Text(
                          "Confirmer",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          methode1();
                          Navigator.pop(context);
                        }),
                  ),
                  SimpleDialogOption(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                          minimumSize:
                              MaterialStateProperty.all<Size>(Size(90, 35)),
                        ),
                        child: Text(
                          "Annuler",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                ],
              )
            ],
          );
        });
  }

  AppBar buildAppBarBottom(
      [String titre, IconButton iconb1, IconButton iconb2]) {
    return AppBar(
      elevation: 1,
      excludeHeaderSemantics: true,
      backgroundColor: Color.fromRGBO(79, 84, 103, 1),
      title: Text(
        titre,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        if (iconb1 != null) iconb1,
        if (iconb2 != null) iconb2,
      ],
      automaticallyImplyLeading: false,
      shape: Border.fromBorderSide(BorderSide(
          color: Colors.black26, width: 0, style: BorderStyle.solid)),
    );
  }

  SliverAppBar buildSliverBar(
      [String titre, IconButton iconb1, IconButton iconb2]) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Color.fromRGBO(79, 84, 103, 1),
      leading: Text(""),
      leadingWidth: 0,
      title: Text(
        titre,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: <Widget>[
        if (iconb1 != null) iconb1,
        if (iconb2 != null) iconb2,
      ],
    );
  }

  AppBar buildAppBarForSearch([Widget widget]) {
    return AppBar(
        backgroundColor: Color.fromRGBO(79, 84, 103, 1),
        leading: Text(""),
        leadingWidth: 0,
        title: widget,
        shape: Border.fromBorderSide(
          BorderSide(color: Colors.black26, width: 0, style: BorderStyle.solid),
        ));
  }

  static DefaultTabController buildTabs(
      context, Text tablabel1, Text tablabel2, Widget widj1, Widget widj2) {
    return DefaultTabController(
        length: 2,
        child: new Scaffold(
          backgroundColor: Color(0xFFF8F9FA),
          drawer: builDrawer(context),
          appBar: buildAppBar(TabBar(
              indicatorColor: Colors.white,
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              tabs: [tablabel1, tablabel2])),
          body: TabBarView(
            children: [widj1, widj2],
          ),
        ));
  }

  static Column animationZone(Widget widget, [String message]) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget,
          ],
        ),
        if (message != null)
          Text(
            "Verifiez votre connexion",
            style: TextStyle(color: Colors.black),
          )
      ],
    );
  }

  static Column noData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.data_usage_rounded,
              size: 50,
              color: Color.fromRGBO(79, 84, 103, 1),
            )
          ],
        ),
        Text(
          "pas encore de donnees",
          style: TextStyle(color: Colors.black),
        )
      ],
    );
  }

  static Future loading(context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return LoadingFlipping.circle();
        });
  }

  ////////////////////////////////GESTION ERREUR///////////////////////////////////////////////

  static success(String message, context) {
    Navigator.of(context, rootNavigator: true).pop(Connexion());
    CoolAlert.show(
      context: context,
      backgroundColor: Color.fromRGBO(79, 84, 103, 1),
      type: CoolAlertType.success,
      title: 'Succes',
      text: message,
      confirmBtnColor: Color.fromRGBO(79, 84, 103, 1),
      loopAnimation: true,
    );
  }

  static errur401(context) {
    Navigator.of(context, rootNavigator: true).pop(Connexion());
    CoolAlert.show(
      context: context,
      backgroundColor: Color.fromRGBO(79, 84, 103, 1),
      type: CoolAlertType.error,
      title: 'Erreur authentification',
      text: 'Adresse email ou mot de passe incorrecte',
      confirmBtnColor: Color.fromRGBO(79, 84, 103, 1),
      loopAnimation: true,
    );
  }

  static errur500(context) {
    Navigator.of(context, rootNavigator: true).pop(Connexion());
    CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      backgroundColor: Color.fromRGBO(79, 84, 103, 1),
      title: 'Erreur serveur',
      text: 'Probleme au niveau du serveur. Ressayer plutard',
      confirmBtnColor: Color.fromRGBO(79, 84, 103, 1),
      loopAnimation: true,
    );
  }

  static errurNet(context) {
    Navigator.of(context, rootNavigator: true).pop(Connexion());
    CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      backgroundColor: Color.fromRGBO(79, 84, 103, 1),
      title: 'Erreur connexion',
      text: 'Veuillez verifier votre connexion',
      confirmBtnColor: Color.fromRGBO(79, 84, 103, 1),
      loopAnimation: true,
    );
  }
}
