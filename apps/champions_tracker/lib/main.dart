import 'package:champions_tracker/champscard.dart';
import 'package:champions_tracker/pagemanager.dart';
import 'package:champions_tracker/participant.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

/*
  Hard-coded placeholder villain and hero participants. These will be replaced with a way to define the heroes and villains for the game in the game selection screen.
*/
var placeholderVillain = ParticipantInstance(
  type: ParticipantType.villain,
  name: "Rhino",
  availableCards: [
    ChampsCardInfo(
      type: ChampsCardType.minion,
      name: "Hydra Mercenary",
    ),
    ChampsCardInfo(
      type: ChampsCardType.minion,
      name: "Sandman",
    ),
    ChampsCardInfo(
      type: ChampsCardType.scheme,
      name: "Breakin' and Takin'",
    ),
  ],
);

var placeholderHeroes = [
  ParticipantInstance (
    type: ParticipantType.hero,
    name: "Spider-Man",
    availableCards: [
      ChampsCardInfo(
      type: ChampsCardType.ally,
      name: "Black Cat",
    ),
      ChampsCardInfo(
      type: ChampsCardType.ally,
      name: "Miles Morales",
    ),
      ChampsCardInfo(
      type: ChampsCardType.upgrade,
      name: "Web-Shooter",
    ),
    ],
  ),
  ParticipantInstance(
    type: ParticipantType.hero,
    name: "Captain Marvel",
    availableCards: [
      ChampsCardInfo(
      type: ChampsCardType.ally,
      name: "Spectrum",
    ),
      ChampsCardInfo(
      type: ChampsCardType.ally,
      name: "She-Hulk",
    ),
      ChampsCardInfo(
      type: ChampsCardType.upgrade,
      name: "Cosmic Flight",
    ),
    ],
  ),
  ParticipantInstance(
    type: ParticipantType.hero,
    name: "Black Panther",
    availableCards: [
      ChampsCardInfo(
      type: ChampsCardType.minion,
      name: "Sandman",
    ),
      ChampsCardInfo(
      type: ChampsCardType.minion,
      name: "Sandman",
    ),
      ChampsCardInfo(
      type: ChampsCardType.minion,
      name: "Sandman",
    ),
    ],
  ),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: PageManager(),
      ),
    );
  }
}

class GameSetup {
  Future<ChampsCardInfo>? cardInfo;
}

class ActiveGame {
  var villain = placeholderVillain;
  var heroes = placeholderHeroes;
}

class MyAppState extends ChangeNotifier {
  GameSetup gameSetup = GameSetup();
  ActiveGame activeGame = ActiveGame();

  void updateState() {
    notifyListeners();
  }
}
