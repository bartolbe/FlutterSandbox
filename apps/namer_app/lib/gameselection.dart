import 'package:namer_app/main.dart';
import 'package:namer_app/participant.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(appState.Villain.name),
          for (Participant hero in appState.Heroes)
            Text(hero.name),
        ],
      ),
    );
  }
}