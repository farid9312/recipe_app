import 'package:flutter/material.dart';

class NutritionsSubpage extends StatelessWidget {
  const NutritionsSubpage({
    Key? key,
    this.nutrition,
  }) : super(key: key);

  final String? nutrition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildBody(
    BuildContext context,
  ) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        nutrition ?? "There are no nutritions data provided!",
        style: theme.textTheme.bodyText2!.copyWith(
          fontSize: 20,
        ),
      ),
    );
  }
}
