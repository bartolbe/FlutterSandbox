import 'package:namer_app/counter.dart';
import 'package:namer_app/participant.dart';

import 'package:flutter/material.dart';

enum ChampsCardType
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
class ChampsCardInfo {
  final ChampsCardType type;
  final String name;

  const ChampsCardInfo({
    required this.type,
    required this.name,
  });

  /*
    Helper function for determining if the counter of type 'counterType' should be active when the card is first added to the game.
  */
  bool defaultIsCounterTypeActive(CounterType counterType)
  {
    switch(type) {
      case ChampsCardType.hero:
      case ChampsCardType.ally:
      case ChampsCardType.villain:
      case ChampsCardType.minion:
        return counterType == CounterType.health;
      case ChampsCardType.scheme:
        return counterType == CounterType.threat;
      case ChampsCardType.upgrade:
        return counterType == CounterType.allPurpose; // If we're tracking an upgrade in this app, then it's probably got all purpose counters on it.
      default:
        throw UnimplementedError('$type is not a valid CardType');
    }
  }

  /*
    Helper function for getting the type of participant that this card corresponds to.
  */
  ParticipantType getParticipantType()
  {
    switch(type) {
      case ChampsCardType.hero:
      case ChampsCardType.ally:
      case ChampsCardType.upgrade:
        return ParticipantType.hero;
      case ChampsCardType.villain:
      case ChampsCardType.minion:
      case ChampsCardType.scheme:
        return ParticipantType.villain;
      default:
        throw UnimplementedError('$type is not a valid CardType');
    }
  }

  bool isIdentity()
  {
    switch(type) {
      case ChampsCardType.hero:
      case ChampsCardType.villain:
        return true;
      case ChampsCardType.ally:
      case ChampsCardType.upgrade:
      case ChampsCardType.minion:
      case ChampsCardType.scheme:
        return false;
      default:
        throw UnimplementedError('$type is not a valid CardType');
    }
  }
}

/*
  Class for tracking the active information about a card in game.
*/
class ChampsCardInstance {
  final ChampsCardInfo info;

  // In addition to the data that defines a card before it enters play, a card in play must keep track of the counters added to it.
  List<CounterInstance> counters = List<CounterInstance>.generate(CounterType.values.length, (index) => CounterInstance(type:CounterType.values[index]));

  /*
    A constructor for creating a card instance from card info.
  */
  ChampsCardInstance.fromCardInfo(this.info) {
    for (var counterTypeIndex = 0; counterTypeIndex < CounterType.values.length; counterTypeIndex++) {
      // Set each counter's count to 1 if the counter is enabled by default, and 0 otherwise (ex. minions and allies start with health, while schemes start with threat).
      counters[counterTypeIndex].count = info.defaultIsCounterTypeActive(CounterType.values[counterTypeIndex]) ? 1 : 0;
    }
  }
}

/*
  The widget for displaying a card instance.
*/
class ChampsCardWidget extends StatelessWidget {
  const ChampsCardWidget({
    required this.card,
    required this.commandWidget,
  });

  final ChampsCardInstance card;

  // Different card types may have different ways that they can manipulate the game state. The command widget handles these, and is passed to the card widget from the participant widget.
  final Widget? commandWidget;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Set the style to be larger for the identiy, and smaller for it's other active cards.
    final baseStyle = card.info.isIdentity() ? theme.textTheme.displayMedium : theme.textTheme.displaySmall;
    final style = baseStyle!.copyWith(
      color: theme.colorScheme.onSecondary,
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the name of the card in a flutter card matching the color of the participant type.
            Card(
              color: getCardColor(card.info.getParticipantType()),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  card.info.name,
                  style: style,
                ),
              ),
            ),
            // If the participant passed a command widget, render it.
            if (commandWidget != null)
              commandWidget!,
          ],
        ),
        Row(
          // Display each of the card's counters in a row.
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