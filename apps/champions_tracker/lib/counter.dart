import 'package:champions_tracker/main.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum CounterType
{
  threat,
  health,
  allPurpose,
}

/*
  A class for managing the information about a counter.
*/
class CounterInstance {
  final CounterType type;
  int count = 0;

  CounterInstance({
    required this.type,
  });
    
  /*
    Helper function for getting the color corresponding to this counter's type.
  */
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

/*
  The widget for representing a counter.
*/
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
      // Color the counter to match it's type.
      color: counter.getColor(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            // To save space only add the decrement button, and the current count display, if the count is greater than zero.
            if (counter.count > 0)
              Row(
                children: [
                  // Add the decrement button.
                  ElevatedButton(onPressed: () {
                      decrement();
                      appState.updateState();
                    },
                    child: Icon(Icons.arrow_downward)),
                  SizedBox(width: 10),
                  // Add the count display.
                  Text(
                    counter.count.toString(),
                    style: style,
                  ),
                  SizedBox(width: 10),
                ]
              ),
            // Add the increment button.
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