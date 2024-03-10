import 'package:namer_app/main.dart';
import 'package:namer_app/champscard.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    var appState = context.watch<MyAppState>();

    return Column(
      children: [
        CardWidget(card:
          participant.identity,
          commandWidget: AddCardWidget(participant: participant)
        ),
        for (var activeCard in participant.activeCards)
          CardWidget(
            card: activeCard,
            commandWidget: Row(
            children: [
              SizedBox(width: 10),
              ElevatedButton(child:Text("Remove"), onPressed:() {
                participant.activeCards.remove(activeCard);
                appState.updateState();
              },),
            ],
          )
          ),
      ],
    );
  }
}

/*
  A widget for handling the interaction and logic for adding a card to the active cards from a selection of available card info.
*/
class AddCardWidget extends StatefulWidget {
  const AddCardWidget({
    required this.participant,
  });

  final ParticipantInstance participant;

  @override
  State<AddCardWidget> createState() => _AddCardWidgetState();
}

class _AddCardWidgetState extends State<AddCardWidget> {
  CardInfo? cardInfo;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Row(
      children: [
        SizedBox(width: 10),
        // Add a dropdown menu which selects from options consisting of the names of all available cards for this participant.
        DropdownMenu<CardInfo>(
          dropdownMenuEntries: [
            for (var availableCard in widget.participant.availableCards)
              DropdownMenuEntry(value: availableCard, label: availableCard.name)
          ],
          onSelected: (selectedCardInfo) {
            cardInfo = selectedCardInfo;
          },
        ),
        SizedBox(width: 10),
        // Add a button that addes the selected card info to the game as a card instance.
        ElevatedButton(
          child: Text("Add Card"), 
          onPressed:() {
            if (cardInfo != null) {
              widget.participant.activeCards.add(CardInstance.fromCardInfo(cardInfo!));
              appState.updateState();
            }
          },
        ),
      ],
    );
  }
}