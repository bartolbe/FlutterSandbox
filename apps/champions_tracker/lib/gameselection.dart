import 'package:champions_tracker/main.dart';
import 'package:champions_tracker/champscard.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    print("Joey build${appState.gameSetup.cardInfo}");

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (appState.gameSetup.cardInfo != null)
            FutureBuilder<ChampsCardInfo>(
              future: appState.gameSetup.cardInfo!,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text("${snapshot.data!.name} (${snapshot.data!.type})");
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                //return const CircularProgressIndicator();
                return Text("Loading");
              },
            ),

          ElevatedButton(onPressed: () {
              appState.gameSetup.cardInfo = fetchChampsCard("21096");
              appState.updateState();
            },
            child: Icon(Icons.router)),
        ],
      ),
    );
  }
}