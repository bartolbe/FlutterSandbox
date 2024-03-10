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
        return counterType == CounterType.threat;
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
      counters[counterTypeIndex].count = info.defaultIsCounterTypeActive(CounterType.values[counterTypeIndex]) ? 1 : 0;
    }
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    required this.card,
    required this.commandWidget,
  });

  final CardInstance card;
  final Widget? commandWidget;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseStyle = card.info.type == CardType.villain || card.info.type == CardType.hero ? theme.textTheme.displayMedium : theme.textTheme.displaySmall;
    final style = baseStyle!.copyWith(
      color: theme.colorScheme.onSecondary,
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              color: card.info.type == CardType.hero || card.info.type == CardType.ally || card.info.type == CardType.upgrade ? Colors.blue : Colors.orange,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  card.info.name,
                  style: style,
                ),
              ),
            ),
            if (commandWidget != null)
              commandWidget!,
          ],
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