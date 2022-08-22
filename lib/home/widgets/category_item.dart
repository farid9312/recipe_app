import 'package:flutter/material.dart';

import 'category_image_item.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.label,
    required this.imageUrl,
    required void Function() onPressed,
  })  : _onPressed = onPressed,
        super(key: key);

  final String label;
  final String imageUrl;

  final void Function() _onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 100,
      width: 100,
      child: InkWell(
        onTap: _onPressed,
        customBorder: const CircleBorder(),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.grey.shade200,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: CategoryImageItem(
                      imageUrl: imageUrl,
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.caption!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
