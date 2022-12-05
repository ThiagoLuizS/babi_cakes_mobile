import 'package:flutter/material.dart';

class ShimmerComponent extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const ShimmerComponent({Key? key, required this.child, this.isLoading = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const shimmerGradient = LinearGradient(
      colors: [
        Color(0xFFEBEBF4),
        Color(0xFFF4F4F4),
        Color(0xFFEBEBF4),
      ],
      stops: [
        0.1,
        0.3,
        0.4,
      ],
      begin: Alignment(-1.0, -0.3),
      end: Alignment(1.0, 0.3),
      tileMode: TileMode.clamp,
    );

    return isLoading ? ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return shimmerGradient.createShader(bounds);
      },
      child: child,
    ) : child;
  }
}
