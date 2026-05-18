import 'package:flutter/material.dart';

class LogoCreatePinWidget extends StatelessWidget {
  const LogoCreatePinWidget({super.key, this.width, this.height, this.scale});
  final int? width;
  final int? height;
  final int? scale;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Image.asset(
      "lib/assets/images/pat_logo_image.png",
      width: width?.toDouble(),
      height: height?.toDouble(),
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.image_not_supported, size: 100),
    );

    // Image.asset(
    //   fit: BoxFit.fill ,
    //   'lib/assets/images/bmta_logo_icon.png',
    //   width: screenWidth * 0.5,
    //   height: screenWidth * 0.5,
    //   scale: 2.5
    // );
  }
}
