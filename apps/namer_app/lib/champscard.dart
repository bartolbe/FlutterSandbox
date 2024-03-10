import 'package:namer_app/counter.dart';

import 'package:flutter/material.dart';

enum CardType
{
  Hero,
  Ally,
  Upgrade,
  Villain,
  Minion,
  Scheme,
}

/*
  Class for tracking the information about a card before it's entered play.
*/
class CardInfo {
  final CardType type = CardType.Hero;
  final String name = "I need a hero";

  /*
    Helper function for determining if the counter of type 'counterType' should be active when the card is first added to the game.
  */
  bool defaultIsCounterTypeActive(CounterType counterType)
  {
    switch(type)
    {
      case CardType.Hero:
      case CardType.Ally:
      case CardType.Villain:
      case CardType.Minion:
        return counterType == CounterType.Health;
      case CardType.Scheme:
        return counterType == CounterType.Health;
      case CardType.Upgrade:
        return counterType == CounterType.AllPurpose; // If we're tracking an upgrade in this app, then it's probably got all purpose counters on it.
      default:
        throw UnimplementedError('$type is not a valid CardType');
    }
  }
}

/*
  Class for tracking the active information about a card in game.
*/
class CardInstance {
  final CardInfo info;
  List<Counter> counters = List<Counter>.generate(CounterType.values.length, (index) => Counter(type:CounterType.values[index]));

  CardInstance.fromCardInfo(this.info) {
    for (var counterTypeIndex = 0; counterTypeIndex < CounterType.values.length; counterTypeIndex++) {
      counters[counterTypeIndex].active = info.defaultIsCounterTypeActive(CounterType.values[counterTypeIndex]);
    }
  }
}

class ChampsCard extends StatelessWidget {
  const ChampsCard({
    super.key,
    required this.value,
  });

  final int value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onSecondary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          value.toString(),
          style: style,
        ),
      ),
    );
  }
}