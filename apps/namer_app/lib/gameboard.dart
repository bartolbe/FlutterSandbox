import 'package:namer_app/main.dart';
import 'package:namer_app/participant.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return ListView(
      children: [
          ParticipantWidget(participant: appState.Villain),
          for (ParticipantInstance hero in appState.Heroes)
            ParticipantWidget(participant: hero),
      ],
    );
  }
}