import 'package:assignment0/utils/extensions.dart';
import 'package:flutter/material.dart';

class BoilerPlateTile extends StatelessWidget {
  const BoilerPlateTile({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(),
        color: Colors.white.withOpacity(0.2),
      ),
      child: child.padAll(value: 12),
    );
  }
}
