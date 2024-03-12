import 'package:champions_tracker/main.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum StatusType
{
  stunned,
  confused,
  tough,
}

/*
  A class for managing the information about a counter.
*/
class StatusInstance {
  final StatusType type;
  int count = 0;

  StatusInstance({
    required this.type,
  });
    
  /*
    Helper function for getting the color corresponding to this counter's type.
  */
  Color getColor()
  {
    switch(type)
    {
      case StatusType.stunned:
        return Colors.green;
      case StatusType.confused:
        return Colors.purple;
      case StatusType.tough:
        return Colors.deepOrange;
      default:
        throw UnimplementedError('$type is not a valid StatusType');
    }
  }

  String getNameCharacter()
  {
    switch(type)
    {
      case StatusType.stunned:
        return "S";
      case StatusType.confused:
        return "C";
      case StatusType.tough:
        return "T";
      default:
        throw UnimplementedError('$type is not a valid StatusType');
    }
  }
}

class StatusWidget extends StatelessWidget {
  const StatusWidget({
    required this.status,
  });

  final StatusInstance status;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: status.getColor(),
      ),
      onPressed: () {
        status.count++;
        if (status.count > 2) {
          status.count = 0;
        }
        appState.updateState();
      },
      child: Text("${status.getNameCharacter()}: ${status.count}")
    );
  }
}