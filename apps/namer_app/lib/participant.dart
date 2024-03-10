import 'package:namer_app/champscard.dart';

import 'package:flutter/material.dart';

enum ParticipantType
{
  hero,
  villain,
}

/*
  A class to represent either a player or the villain.
*/
class ParticipantInstance {
  final ParticipantType type;
  final String name;

  CardInstance identity;
  List<CardInfo> availableCards;
  List<CardInstance> activeCards = [];

  ParticipantInstance({ required this.type, required this.name, required this.availableCards  }) 
    : identity = CardInstance.fromCardInfo(CardInfo(type: type == ParticipantType.hero ? CardType.hero : CardType.villain, name: name));

  /*
    Add a card to the available card pool. Called during setup.
  */
  void addAvailableCard(CardInfo info) {
    availableCards.add(info);
  }

  /*
    Add an active card to play. Called during gameplay.
  */
  void addActiveCard(int activeCardIndex) {
    activeCards.add(CardInstance.fromCardInfo(availableCards[activeCardIndex]));
  }
}

class ParticipantWidget extends StatelessWidget {
  const ParticipantWidget({
    required this.participant,
  });

  final ParticipantInstance participant;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardWidget(card: participant.identity),
        for (var activeCard in participant.activeCards)
          CardWidget(card: activeCard),
      ],
    );
  }
}