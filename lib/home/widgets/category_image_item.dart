import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryImageItem extends StatelessWidget {
  const CategoryImageItem({
    Key? key,
    required this.imageUrl,
    required void Function() onTap,
  })  : _onTap = onTap,
        super(key: key);

  final String imageUrl;

  final void Function() _onTap;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        color: Colors.grey.shade100,
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => const SizedBox(),
                errorWidget: (_, __, ___) => const SizedBox(),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black26,
                      Colors.black87,
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: _buildTappableArea(),
            ),
          ],
        ),
      ),
    );
  }

  Material _buildTappableArea() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _onTap,
      ),
    );
  }
}

class CategoryImageItemShimmer extends StatelessWidget {
  const CategoryImageItemShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        color: Colors.grey.shade100,
        clipBehavior: Clip.antiAlias,
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade100,
          highlightColor: Colors.white70,
          child: Container(color: Colors.white),
        ),
      ),
    );
  }
}
