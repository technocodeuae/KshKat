import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BaseShimmerWidget extends StatelessWidget {
  final Widget? child;

  const BaseShimmerWidget({this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: child!,
    );
  }
}
