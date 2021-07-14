import 'dart:convert';

import 'package:gestion_bibliotheque/Const/responseStatus.dart';
import 'package:gestion_bibliotheque/modeles/categorie.dart';
import 'package:gestion_bibliotheque/modeles/emprunt.dart';
import 'package:gestion_bibliotheque/modeles/etudiant.dart';
import 'package:gestion_bibliotheque/modeles/livre.dart';
import 'package:gestion_bibliotheque/modeles/reservation.dart';
import 'package:gestion_bibliotheque/services/outils.dart';
import 'package:http/http.dart' as http;

class ApiService {
  String _url = "https://gestion-bibliotheque.herokuapp.com/api/";

///////////////////////////////////LIVRES SERVICE////////////////////////////////////////////////

  Future<List<Livre>> getAllLivres(context) async {
    http.Response response = await http.get(Uri.parse(_url + "alllivres"));
    if (response.statusCode == ResponseStatus.RESPONSE_STATUS_200) {
      Iterable l = json.decode(response.body);
      List<Livre> livres =
          List<Livre>.from(l.map((model) => Livre.fromJson(model)));
      return livres;
    } else if (response.statusCode == ResponseStatus.RESPONSE_STATUS_500) {
      return Outils.snackbar(context, 'Erreur serveur. Ressayer plutard');
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<Livre> getOneLivre(int id, context) async {
    http.Response response = await http.get(Uri.parse(_url + "onelivre/$id"));
    if (response.statusCode == ResponseStatus.RESPONSE_STATUS_200) {
      Map data = jsonDecode(response.body);
      return Livre.fromJson(data);
    } else if (response.statusCode == ResponseStatus.RESPONSE_STATUS_500) {
      return Outils.snackbar(context, 'Erreur serveur. Ressayer plutard');
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

///////////////////////////////////CATEGORIES SERVICE//////////////////////////////////////////////

  Future<List<Categorie>> getAllCategories(context) async {
    http.Response response = await http.get(Uri.parse(_url + "allcategories"));

    if (response.statusCode == ResponseStatus.RESPONSE_STATUS_200) {
      Iterable l = json.decode(response.body);

      List<Categorie> categories =
          List<Categorie>.from(l.map((model) => Categorie.fromJson(model)));

      categories.add(new Categorie(0, "Tous les livres", []));

      return categories;
    } else if (response.statusCode == ResponseStatus.RESPONSE_STATUS_500) {
      return Outils.snackbar(context, 'Erreur serveur. Ressayer plutard');
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<Categorie> getOneCategorie(id, context) async {
    http.Response response =
        await http.get(Uri.parse(_url + "onecategorie/$id"));
    if (response.statusCode == ResponseStatus.RESPONSE_STATUS_200) {
      Map data = jsonDecode(response.body);
      return Categorie.fromJson(data);
    } else if (response.statusCode == ResponseStatus.RESPONSE_STATUS_500) {
      return Outils.snackbar(context, 'Erreur serveur. Ressayer plutard');
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

///////////////////////////////////ETUDIANT SERVICE//////////////////////////////////////////////

  Future<Etudiant> getOneEtudiant(int id, context) async {
    http.Response response =
        await http.get(Uri.parse(_url + "oneetudiant/$id"));
    if (response.statusCode == ResponseStatus.RESPONSE_STATUS_200) {
      Map data = jsonDecode(response.body);
      return Etudiant.fromJson(data);
    } else if (response.statusCode == ResponseStatus.RESPONSE_STATUS_500) {
      return Outils.snackbar(context, 'Erreur serveur. Ressayer plutard');
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<Reservation> getEtudiantReservationEnCours(int id, context) async {
    Reservation reservationEnCours;
    http.Response response =
        await http.get(Uri.parse(_url + "oneetudiant/$id"));
    if (response.statusCode == ResponseStatus.RESPONSE_STATUS_200) {
      Map data = jsonDecode(response.body);

      for (var reservation
          in Etudiant.fromJson(data).reservationList as Iterable<Reservation>) {
        if (!reservation.regle) {
          reservationEnCours = reservation;
        }
      }
      if (reservationEnCours == null) {
        return new Reservation(0, "_date", "_dateFin", false, 0, 0);
      } else {
        return reservationEnCours;
      }
    } else if (response.statusCode == ResponseStatus.RESPONSE_STATUS_500) {
      return Outils.snackbar(context, 'Erreur serveur. Ressayer plutard');
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<Reservation> getOneReservation(int id, context) async {
    http.Response response =
        await http.get(Uri.parse(_url + "onereservation/$id"));
    if (response.statusCode == ResponseStatus.RESPONSE_STATUS_200) {
      Map data = jsonDecode(response.body);
      return Reservation.fromJson(data);
    } else if (response.statusCode == ResponseStatus.RESPONSE_STATUS_500) {
      return Outils.snackbar(context, 'Erreur serveur. Ressayer plutard');
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<Reservation>> getEtudiantReservationsList(int id, context) async {
    List<Reservation> reservationList = [];
    http.Response response =
        await http.get(Uri.parse(_url + "oneetudiant/$id"));
    if (response.statusCode == ResponseStatus.RESPONSE_STATUS_200) {
      Map data = jsonDecode(response.body);

      for (var reservation
          in Etudiant.fromJson(data).reservationList as List<Reservation>) {
        if (reservation.regle) {
          reservationList.add(reservation);
        }
      }
      if (reservationList.length == 0) {
        reservationList
            .add(new Reservation(0, "_date", "_dateFin", false, 0, 0));
        return reservationList;
      } else {
        return reservationList;
      }
    } else if (response.statusCode == ResponseStatus.RESPONSE_STATUS_500) {
      return Outils.snackbar(context, 'Erreur serveur. Ressayer plutard');
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<Emprunt> getEtudiantEmpruntEnCours(int id, context) async {
    Emprunt empruntEnCours;
    http.Response response =
        await http.get(Uri.parse(_url + "oneetudiant/$id"));
    if (response.statusCode == ResponseStatus.RESPONSE_STATUS_200) {
      Map data = jsonDecode(response.body);

      for (var emprunt
          in Etudiant.fromJson(data).empruntList as Iterable<Emprunt>) {
        if (!emprunt.regle) {
          empruntEnCours = emprunt;
        }
      }
      if (empruntEnCours == null) {
        return new Emprunt(0, "_dateDebut", "_delaiRecup", "_dateFin", false,
            false, 0, 0, "_dateremise", false);
      } else {
        return empruntEnCours;
      }
    } else if (response.statusCode == ResponseStatus.RESPONSE_STATUS_500) {
      return Outils.snackbar(context, 'Erreur serveur. Ressayer plutard');
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<Emprunt>> getEtudiantEmpruntsList(int id, context) async {
    List<Emprunt> empruntList = [];
    http.Response response =
        await http.get(Uri.parse(_url + "oneetudiant/$id"));
    if (response.statusCode == ResponseStatus.RESPONSE_STATUS_200) {
      Map data = jsonDecode(response.body);

      for (var emprunt
          in Etudiant.fromJson(data).empruntList as List<Emprunt>) {
        if (emprunt.regle) {
          empruntList.add(emprunt);
        }
      }
      if (empruntList.length == 0) {
        empruntList.add(new Emprunt(0, "_dateDebut", "_delaiRecup", "_dateFin",
            false, false, 0, 0, "_dateremise", false));
        return empruntList;
      } else {
        return empruntList;
      }
    } else if (response.statusCode == ResponseStatus.RESPONSE_STATUS_500) {
      return Outils.snackbar(context, 'Erreur serveur. Ressayer plutard');
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

///////////////////////////////////EMPRUNT SERVICE //////////////////////////////////////////////

  Future<Emprunt> getOneEmprunt(int numero, context) async {
    http.Response response =
        await http.get(Uri.parse(_url + "oneemprunt/$numero"));
    if (response.statusCode == ResponseStatus.RESPONSE_STATUS_200) {
      Map data = jsonDecode(response.body);
      return Emprunt.fromJson(data);
    } else if (response.statusCode == ResponseStatus.RESPONSE_STATUS_500) {
      return Outils.snackbar(context, 'Erreur serveur. Ressayer plutard');
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<Emprunt> emprunter(Emprunt emprunt) {}
}
