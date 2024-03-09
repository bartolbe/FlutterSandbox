import 'package:namer_app/gameselection.dart';
import 'package:namer_app/gameboard.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChampsCard extends StatelessWidget {
  const ChampsCard({
    super.key,
    required this.value,
  });

  final int value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onSecondary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          value.toString(),
          style: style,
        ),
      ),
    );
  }
}