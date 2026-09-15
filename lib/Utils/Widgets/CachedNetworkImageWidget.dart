import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String? image;
  final double? height;
  final double? width;

  const CachedNetworkImageWidget(
      {super.key, required this.image, this.height, this.width, this.fit});

  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    if (image == null || image == '' || image == 'null') {
      return Container(
        height: height,
        width: width,
        color: Colors.grey[850],
        child: const Center(child: Icon(Icons.image_not_supported, color: Colors.white54)),
      );
    }
    return CachedNetworkImage(
      imageUrl: image!,
      height: height,
      width: width,
      placeholder: (context, url) => const Center(child: CircularProgressIndicator.adaptive()),
      errorWidget: (context, url, error) => Container(
        height: height,
        width: width,
        color: Colors.grey[850],
        child: const Center(child: Icon(Icons.broken_image, color: Colors.white54)),
      ),
      fit: fit ?? BoxFit.cover,
    );
  }
}
