import 'package:champions_tracker/main.dart';
import 'package:champions_tracker/participant.dart';
import 'package:champions_tracker/champscard.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
  The (mostly unimplemented) widget class for setting up the configuration that the game will run.
*/
class GameSelection extends StatefulWidget {
  @override
  State<GameSelection> createState() => _GameSelectionState();
}

class _GameSelectionState extends State<GameSelection> {
  Future<ChampsCardInfo>? cardInfo;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    print("Joey build$cardInfo");

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (cardInfo != null)
            FutureBuilder<ChampsCardInfo>(
              future: cardInfo!,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text("${snapshot.data!.name} (${snapshot.data!.type})");
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),

          ElevatedButton(onPressed: () {
              print("Joey");
              print(cardInfo);
              cardInfo = fetchChampsCard("21096");
              print(cardInfo);
            },
            child: Icon(Icons.router)),
        ],
      ),
    );
  }
}