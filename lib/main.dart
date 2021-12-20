import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_bibliotheque/StartUpViewModel.dart';
import 'package:gestion_bibliotheque/pages/acceuil.dart';
import 'package:gestion_bibliotheque/pages/connexion.dart';
import 'package:gestion_bibliotheque/pages/detailsLivre.dart';
import 'package:gestion_bibliotheque/pages/emprunt/detailsHistoriqueEmprunt.dart';
import 'package:gestion_bibliotheque/pages/emprunt/mesEmprunts.dart';
import 'package:gestion_bibliotheque/pages/monProfile.dart';
import 'package:gestion_bibliotheque/pages/recherche.dart';
import 'package:gestion_bibliotheque/pages/reseravtion/detailsHistoriquesReservation.dart';
import 'package:gestion_bibliotheque/pages/reseravtion/mesReservations.dart';
import 'package:gestion_bibliotheque/startup.dart';
import 'package:get/get.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown,
    // DeviceOrientation.landscapeLeft,
    // DeviceOrientation.landscapeRight


  ]);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestion Bibliotheque',
      home: StartUpView(),
      theme: ThemeData(
        backgroundColor: Color(0xFFF8F9FA),
      ),
      routes: {
        "/accueil": (context) {
          return Acceuil();
        },
        "/connexion": (context) {
          return Connexion();
        },
        "/monprofile": (context) {
          return MonProfile();
        },
        "/mesemprunts": (context) {
          return MesEmprunts();
        },
        "/mesreservations": (context) {
          return MesReservations();
        },
        "/detailshistoriqueemprunt": (context) {
          return DetailsHistoriqueEmprunt();
        },
        "/detailshistoriquereservation": (context) {
          return DetailsHistoriqueReservation();
        },
        "/detailslivre": (context) {
          return DetailsLivre();
        },
        "/recherche": (context) {
          return Recherche();
        },
      },
    );
  }
}
