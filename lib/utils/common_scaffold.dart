import 'package:flutter/material.dart';

class CommonScaffold extends StatelessWidget {
  const CommonScaffold({
    super.key,
    this.isWhiteBackground,
    required this.child,
    required this.gradientColorList,
  });

  final Widget child;
  final List<Color> gradientColorList;
  final bool? isWhiteBackground;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CommonGradient(
          gradientColorList: isWhiteBackground == true
              ? [
                  Colors.white,
                  Colors.white,
                ]
              : gradientColorList,
          child: child,
        ),
      ),
    );
  }
}

class CommonGradient extends StatelessWidget {
  const CommonGradient({
    super.key,
    required this.child,
    required this.gradientColorList,
  });

  final Widget child;
  final List<Color> gradientColorList;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: gradientColorList,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
