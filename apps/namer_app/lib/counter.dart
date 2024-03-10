import 'package:flutter/material.dart';

enum CounterType
{
  Threat,
  Health,
  AllPurpose,
}

class Counter {
  final CounterType type;
  bool active = false;
  int count = 0;

  Counter({
    required this.type,
  });
    
  Color getColor()
  {
    switch(type)
    {
      case CounterType.Threat:
        return Colors.yellow;
      case CounterType.Health:
        return Colors.red;
      case CounterType.AllPurpose:
        return Colors.green;
      default:
        throw UnimplementedError('$type is not a valid CounterType');
    }
  }
}