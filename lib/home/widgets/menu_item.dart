import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key? key,
    required this.imageUrl,
    required this.mealName,
    required this.rating,
    required this.categoryName,
    required void Function() onTap,
  })  : _onTap = onTap,
        super(key: key);

  final String imageUrl;
  final String mealName;
  final double rating;
  final String categoryName;

  final void Function() _onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: _onTap,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 190,
            width: screenWidth,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (_, __) => const SizedBox(),
              errorWidget: (_, __, ___) => const SizedBox(),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  mealName,
                  style: theme.textTheme.caption!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.red.shade900,
                    ),
                    Text(
                      '$rating',
                      style: theme.textTheme.caption!
                          .copyWith(color: Colors.red.shade900),
                    ),
                    Text(
                      categoryName,
                      style: theme.textTheme.caption,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
