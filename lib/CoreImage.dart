import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CoreImage extends StatefulWidget {
  final BorderRadius borderRadius;
  final double height;
  final double width;
  final String url;
  final BoxFit boxFit;
  final bool isPlaceHolder;

  const CoreImage({
    super.key,
    required this.borderRadius,
    required this.height,
    required this.width,
    required this.url,
    this.boxFit = BoxFit.cover,
    this.isPlaceHolder = true,
  });

  @override
  State<CoreImage> createState() => CoreImageState();
}

class CoreImageState extends State<CoreImage> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.borderRadius,
      child: widget.url.isNotEmpty
          ? FadeInImage.assetNetwork(
              placeholder: 'assets/images/jaylogo.png',
              image: widget.url,
              height: widget.height,
              width: widget.width,
              fit: widget.boxFit,
            )
          : Image.asset(
              'assets/images/jaylogo.png',
              height: widget.height,
              width: widget.width,
              fit: widget.boxFit,
            ),
    );
  }
}
