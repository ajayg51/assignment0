import 'package:flutter/material.dart';

class CommonScaffold extends StatelessWidget {
  const CommonScaffold({
    super.key,
    required this.child,
    required this.gradientColorList,
  });

  final Widget child;
  final List<Color> gradientColorList;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CommonGradient(
          gradientColorList: gradientColorList,
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