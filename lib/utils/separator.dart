import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  const Separator({
    super.key,
    this.color,
  });
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: color ?? Colors.grey,
          ),
        ),
      ],
    );
  }
}