import 'package:namer_app/champscard.dart';
import 'package:namer_app/gameselection.dart';
import 'package:namer_app/gameboard.dart';

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
  var Villain = Participant(
    type: ParticipantType.Villain,
    name: "Rhino",
    availableCards: [
      CardInfo(),
      CardInfo(),
      CardInfo(),
    ],
  );
  var Heroes = [
    Participant (
      type: ParticipantType.Hero,
      name: "Spider-Man",
      availableCards: [
        CardInfo(),
        CardInfo(),
        CardInfo(),
      ],
    ),
    Participant(
      type: ParticipantType.Hero,
      name: "Captain Marvel",
      availableCards: [
        CardInfo(),
        CardInfo(),
        CardInfo(),
      ],
    ),
    Participant(
      type: ParticipantType.Hero,
      name: "Black Panther",
      availableCards: [
        CardInfo(),
        CardInfo(),
        CardInfo(),
      ],
    ),
  ];
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
        break;
      case 1:
        page = GameBoard();
        break;
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
