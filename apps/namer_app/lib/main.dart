import 'package:namer_app/champscard.dart';
import 'package:namer_app/gameselection.dart';
import 'package:namer_app/gameboard.dart';
import 'package:namer_app/participant.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

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
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var villain = ParticipantInstance(
    type: ParticipantType.villain,
    name: "Rhino",
    availableCards: [
      CardInfo(
        type: CardType.minion,
        name: "Hydra Mercenary",
      ),
      CardInfo(
        type: CardType.minion,
        name: "Sandman",
      ),
      CardInfo(
        type: CardType.scheme,
        name: "Breakin' and Takin'",
      ),
    ],
  );
  var heroes = [
    ParticipantInstance (
      type: ParticipantType.hero,
      name: "Spider-Man",
      availableCards: [
        CardInfo(
        type: CardType.ally,
        name: "Black Cat",
      ),
        CardInfo(
        type: CardType.ally,
        name: "Miles Morales",
      ),
        CardInfo(
        type: CardType.upgrade,
        name: "Web-Shooter",
      ),
      ],
    ),
    ParticipantInstance(
      type: ParticipantType.hero,
      name: "Captain Marvel",
      availableCards: [
        CardInfo(
        type: CardType.ally,
        name: "Spectrum",
      ),
        CardInfo(
        type: CardType.ally,
        name: "She-Hulk",
      ),
        CardInfo(
        type: CardType.upgrade,
        name: "Cosmic Flight",
      ),
      ],
    ),
    ParticipantInstance(
      type: ParticipantType.hero,
      name: "Black Panther",
      availableCards: [
        CardInfo(
        type: CardType.minion,
        name: "Sandman",
      ),
        CardInfo(
        type: CardType.minion,
        name: "Sandman",
      ),
        CardInfo(
        type: CardType.minion,
        name: "Sandman",
      ),
      ],
    ),
  ];

  void updateState() {
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GameSelection();
      case 1:
        page = GameBoard();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text('Favorites'),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
