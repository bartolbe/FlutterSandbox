import 'package:champions_tracker/main.dart';
import 'package:champions_tracker/participant.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
  The (mostly unimplemented) widget class for setting up the configuration that the game will run.
*/
class GameSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("TODO: Implement this page"),
          Text(appState.villain.name),
          for (ParticipantInstance hero in appState.heroes)
            Text(hero.name),
        ],
      ),
    );
  }
}