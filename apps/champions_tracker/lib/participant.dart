import 'package:champions_tracker/main.dart';
import 'package:champions_tracker/champscard.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ParticipantType
{
  hero,
  villain,
}

/*
  Helper function for getting the card type of the identity corresponding to this participatn.
*/
ChampsCardType getIdentityCardType(ParticipantType participantType) {
  switch(participantType) {
    case ParticipantType.hero:
      return ChampsCardType.hero;
    case ParticipantType.villain:
      return ChampsCardType.villain;
    default:
      throw UnimplementedError('$participantType is not a valid ParticipantType');
  }
}

/*
  Helper function for getting the card color corresponding to a participant type.
*/
Color getCardColor(ParticipantType participantType) {
  switch(participantType) {
    case ParticipantType.hero:
      return Colors.blue;
    case ParticipantType.villain:
      return Colors.orange;
    default:
      throw UnimplementedError('$participantType is not a valid ParticipantType');
  }
}

/*
  A class to represent either a player or the villain.
*/
class ParticipantInstance {
  final ParticipantType type;
  final String name;

  ChampsCardInstance identity; // The card representing the hero or villain themselves.
  List<ChampsCardInfo> availableCards; // The set of available cards that the participant could add to play.
  List<ChampsCardInstance> activeCards = []; // The active cards that the participant has added to play.

  ParticipantInstance({ required this.type, required this.name, required this.availableCards  }) 
    : identity = ChampsCardInstance.fromCardInfo(ChampsCardInfo(type:getIdentityCardType(type), name: name));

  /*
    Add an active card to play. Called during gameplay.
  */
  void addActiveCard(ChampsCardInfo cardInfo) {
    activeCards.add(ChampsCardInstance.fromCardInfo(cardInfo));
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
        // Add the card widget for the identity.
        ChampsCardWidget(card:
          participant.identity,
          // The identity includes the ability to add cards from it's set of available cards.
          commandWidget: AddCardWidget(participant: participant)
        ),

        // Add a card widget for each card in play.
        for (var activeCard in participant.activeCards)
          ChampsCardWidget(
            card: activeCard,
            commandWidget: Row(
            children: [
              SizedBox(width: 10),
              // Cards in play belonging to the participant include the ability to remove themselves from the game.
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
  ChampsCardInfo? cardInfo;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Row(
      children: [
        SizedBox(width: 10),
        // Add a dropdown menu which selects from options consisting of the names of all available cards for this participant.
        DropdownMenu<ChampsCardInfo>(
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
              widget.participant.addActiveCard(cardInfo!);
              appState.updateState();
            }
          },
        ),
      ],
    );
  }
}