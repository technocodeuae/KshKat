import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageAssetCircleWidget extends StatefulWidget {
  final String? imageUrl;
  final double? imageHeight;
  final double? imageWidth;
  final double? imageBorderRadius;
  final bool imageBorderRadiusTopLeft;
  final bool imageBorderRadiusTopRight;
  final bool imageBorderRadiusBottomLeft;
  final bool imageBorderRadiusBottomRight;
  final bool isCache;
  final BoxFit boxFit;

  const ImageAssetCircleWidget({
    this.boxFit = BoxFit.cover,
    required this.imageUrl,
    this.imageHeight,
    this.imageWidth,
    this.isCache = false,
    this.imageBorderRadius =0.0,
    this.imageBorderRadiusTopLeft = true,
    this.imageBorderRadiusTopRight = true,
    this.imageBorderRadiusBottomLeft = true,
    this.imageBorderRadiusBottomRight = true,
  });

  @override
  _CustomImageDemoState createState() => _CustomImageDemoState();
}

class _CustomImageDemoState extends State<ImageAssetCircleWidget>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<ImageAssetCircleWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            widget.imageBorderRadiusTopLeft ? widget.imageBorderRadius! : 0.0,
          ),
          topRight: Radius.circular(
            widget.imageBorderRadiusTopRight ? widget.imageBorderRadius! : 0.0,
          ),
          bottomLeft: Radius.circular(
            widget.imageBorderRadiusBottomLeft
                ? widget.imageBorderRadius!
                : 0.0,
          ),
          bottomRight: Radius.circular(
            widget.imageBorderRadiusBottomRight
                ? widget.imageBorderRadius!
                : 0.0,
          ),
        ),
        child: Container(
            width: widget.imageWidth,
            height: widget.imageHeight,
            child: Image.asset(
              widget.imageUrl!,
              height: widget.imageHeight,
              width: widget.imageWidth,
              fit: widget.boxFit,
            )));
  }

  @override
  bool get wantKeepAlive => true;
}
