import 'package:flutter/material.dart';

enum CounterType
{
  Threat,
  Health,
  AllPurpose,
}

class CounterInstance {
  final CounterType type;
  bool active = false;
  int count = 0;

  CounterInstance({
    required this.type,
  });
    
  Color getColor()
  {
    switch(type)
    {
      case CounterType.Threat:
        return Colors.yellow;
      case CounterType.Health:
        return Colors.red;
      case CounterType.AllPurpose:
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onSecondary,
    );

    return Card(
      color: counter.getColor(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          counter.active ? counter.count.toString() : 'X',
          style: style,
        ),
      ),
    );
  }
}