import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_bibliotheque/StartUpViewModel.dart';
import 'package:stacked/stacked.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) =>
          ViewModelBuilder<StartUpViewModel>.nonReactive(
        viewModelBuilder: () => StartUpViewModel(),
        onModelReady: (model) => model.handleStartUpLogic(context),
        builder: (context, model, child) => Scaffold(
          backgroundColor:  Color.fromRGBO(79, 84, 103, 1),
          body: SafeArea(
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(bottom: 35),
                child: Center(
                  child: Container(
                    color: Colors.green.withOpacity(1),
                    child: Image.asset(
                      "images/logo.png",
                      fit: BoxFit.cover,
                      height: 200,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
