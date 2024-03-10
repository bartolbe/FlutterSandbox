import 'package:namer_app/main.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum CounterType
{
  threat,
  health,
  allPurpose,
}

class CounterInstance {
  final CounterType type;
  int count = 0;

  CounterInstance({
    required this.type,
  });
    
  Color getColor()
  {
    switch(type)
    {
      case CounterType.threat:
        return Colors.yellow;
      case CounterType.health:
        return Colors.red;
      case CounterType.allPurpose:
        return Colors.green;
      default:
        throw UnimplementedError('$type is not a valid CounterType');
    }
  }
}

class CounterWidget extends StatelessWidget {
  const CounterWidget({
    required this.counter,
  });

  final CounterInstance counter;

  void decrement() {
    if (counter.count > 0) {
      counter.count--;
    }
  }

  void increment() {
    counter.count++;
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onSecondary,
    );

    return Card(
      color: counter.getColor(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            if (counter.count > 0)
            Row(
              children: [
                ElevatedButton(onPressed: () {
                    decrement();
                    appState.updateState();
                  },
                  child: Icon(Icons.arrow_downward)),
                SizedBox(width: 10),
                Text(
                  counter.count.toString(),
                  style: style,
                ),
                SizedBox(width: 10),
              ]
            ),
            ElevatedButton(onPressed: () {
                increment();
                appState.updateState();
              },
              child: Icon(Icons.arrow_upward)),
          ],
        ),
      ),
    );
  }
}