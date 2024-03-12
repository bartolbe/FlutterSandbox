import 'package:flutter/material.dart';

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
        return Colors.orange;
      default:
        throw UnimplementedError('$type is not a valid CounterType');
    }
  }
}

class StatusWidget extends StatelessWidget {
  const StatusWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {
      print("Status");
    },
    child: Icon(Icons.arrow_upward));
  }
}