import 'package:flutter/material.dart';

class CommonAppbar extends StatelessWidget {
  const CommonAppbar({
    super.key,
    required this.bannerAssetPath,
  });
  final String bannerAssetPath;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      bannerAssetPath,
      fit: BoxFit.contain,
    );
  }
}