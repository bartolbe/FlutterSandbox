import 'package:namer_app/champscard.dart';

enum ParticipantType
{
  Hero,
  Villain,
}

/*
  A class to represent either a player or the villain.
*/
class Participant {
  final ParticipantType type;
  final String name;

  List<CardInfo> availableCards;
  List<CardInstance> activeCards = [];

  Participant({
    required this.type,
    required this.name,
    required this.availableCards
  });

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