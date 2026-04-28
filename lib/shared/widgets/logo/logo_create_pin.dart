import 'package:flutter/material.dart';

class LogoCreatePinWidget extends StatelessWidget {
  const LogoCreatePinWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Image.asset(
      "lib/assets/images/pat_logo_image.png",
      width: 150,
      height: 150,
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
