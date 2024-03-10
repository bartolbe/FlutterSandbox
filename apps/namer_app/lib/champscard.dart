import 'package:namer_app/counter.dart';

import 'package:flutter/material.dart';

enum CardType
{
  hero,
  ally,
  upgrade,
  villain,
  minion,
  scheme,
}

/*
  Class for tracking the information about a card before it's entered play.
*/
class CardInfo {
  final CardType type;
  final String name;

  const CardInfo({
    required this.type,
    required this.name,
  });

  /*
    Helper function for determining if the counter of type 'counterType' should be active when the card is first added to the game.
  */
  bool defaultIsCounterTypeActive(CounterType counterType)
  {
    switch(type)
    {
      case CardType.hero:
      case CardType.ally:
      case CardType.villain:
      case CardType.minion:
        return counterType == CounterType.health;
      case CardType.scheme:
        return counterType == CounterType.health;
      case CardType.upgrade:
        return counterType == CounterType.allPurpose; // If we're tracking an upgrade in this app, then it's probably got all purpose counters on it.
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
  List<CounterInstance> counters = List<CounterInstance>.generate(CounterType.values.length, (index) => CounterInstance(type:CounterType.values[index]));

  CardInstance.fromCardInfo(this.info) {
    for (var counterTypeIndex = 0; counterTypeIndex < CounterType.values.length; counterTypeIndex++) {
      counters[counterTypeIndex].active = info.defaultIsCounterTypeActive(CounterType.values[counterTypeIndex]);
    }
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    required this.card,
  });

  final CardInstance card;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onSecondary,
    );

    return Column(
      children: [
        Card(
          color: theme.colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              card.info.name,
              style: style,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (CounterInstance counter in card.counters)
              CounterWidget(counter: counter),
          ],
        ),
      ],
    );
  }
}