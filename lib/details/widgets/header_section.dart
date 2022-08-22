import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({
    Key? key,
    required this.imageUrl,
    required void Function() onTap,
  })  : _onTap = onTap,
        super(key: key);

  final String imageUrl;

  final void Function() _onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: _buildBackgroundImage(context),
        ),
        _buildTextContent(context),
      ],
    );
  }

  Widget _buildTextContent(BuildContext context) {
    final theme = Theme.of(context);
    final topPadding = MediaQuery.of(context).padding.top;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: topPadding + 24,
          ),
          SizedBox(
            width: 100,
            child: Container(
              padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.black,
                    size: 32,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '4.5',
                    style: theme.textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: _onTap,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 1),
                      blurRadius: 8,
                      color: Colors.black12,
                    ),
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Icon(
                    Icons.play_arrow,
                    size: 50,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (_, __) => const SizedBox(),
            errorWidget: (_, __, ___) => const SizedBox(),
          ),
        ),
      ],
    );
  }
}
