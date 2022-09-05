import 'package:flutter/material.dart';

class StepsSubpage extends StatelessWidget {
  const StepsSubpage({
    Key? key,
    required this.steps,
  }) : super(key: key);

  final String steps;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        steps,
        style: theme.textTheme.bodyText2!.copyWith(
          fontSize: 20,
        ),
      ),
    );
  }
}
