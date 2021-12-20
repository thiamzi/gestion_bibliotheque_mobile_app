import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestion_bibliotheque/modeles/base_model.dart';
import 'package:gestion_bibliotheque/services/DynamicLinkService.dart';
import 'package:stacked/stacked.dart';

class StartUpViewModel extends BaseModel{
  final DynamicLinkService _dynamicLinkService = DynamicLinkService();

  Future handleStartUpLogic(BuildContext context) async {
    await Future.delayed(Duration(seconds: 5));
    await _dynamicLinkService.redirectUser(context);
  }
}
