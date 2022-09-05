import 'package:flutter/material.dart';

class IngredientItem extends StatelessWidget {
  const IngredientItem({
    Key? key,
    this.ingredient,
    this.measurement,
  }) : super(key: key);

  final String? ingredient;
  final String? measurement;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _buildAvatar(),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              ingredient ?? 'Null',
              style: theme.textTheme.bodyText2!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              measurement ?? 'Null',
              style: theme.textTheme.caption!.copyWith(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }

  ClipRRect _buildAvatar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0), //or 15.0
      child: Container(
        height: 70.0,
        width: 70.0,
        color: Colors.grey.shade400,
        child: const Align(
          alignment: Alignment.center,
          child: Text(
            'No image\nprovided',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
