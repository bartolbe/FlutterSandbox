import 'package:champions_tracker/main.dart';
import 'package:champions_tracker/participant.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
  The widget class to display the active game.
*/
class GameBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return ListView(
      children: [
          // Display the villain participant.
          ParticipantWidget(participant: appState.activeGame.villain),

          // Display each of the hero participants with a divider.
          for (ParticipantInstance hero in appState.activeGame.heroes)
            Column(
              children: [
                const Divider(
                  height: 20,
                  thickness: 5,
                ),
                ParticipantWidget(participant: hero),
              ],
            ),
      ],
    );
  }
}