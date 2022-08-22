import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MenuOptionItem extends StatelessWidget {
  const MenuOptionItem({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.totalItems,
    required void Function() onTap,
  })  : _onTap = onTap,
        super(key: key);

  final String title;
  final String imageUrl;
  final int totalItems;

  final void Function() _onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: _onTap,
      child: Stack(
        children: <Widget>[
          SizedBox(
            width: screenWidth - 24,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.only(left: 32.0, right: 18),
              child: Card(
                color: Colors.grey.shade50,
                elevation: 5,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    bottomLeft: Radius.circular(32),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: theme.textTheme.bodyText2!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$totalItems items',
                        style: theme.textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: SizedBox(
              height: 70,
              width: 70,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                imageBuilder: (context, imageProvider) {
                  return _buildAvatar(imageProvider: imageProvider);
                },
                placeholder: (_, __) => _buildAvatar(imageProvider: null),
                errorWidget: (_, __, ___) => _buildAvatar(imageProvider: null),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              height: 30,
              width: 30,
              margin: const EdgeInsets.all(4.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    blurRadius: 8,
                    color: Colors.black12,
                  ),
                ],
              ),
              child: const Icon(
                Icons.chevron_right,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  CircleAvatar _buildAvatar({required ImageProvider<dynamic>? imageProvider}) {
    return CircleAvatar(
      radius: 80,
      foregroundColor: Colors.grey.shade700,
      backgroundColor: Colors.grey.shade200,
      backgroundImage: imageProvider != null
          ? imageProvider as ImageProvider<Object>?
          : null,
      child: null,
    );
  }
}
