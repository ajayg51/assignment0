import 'package:flutter/material.dart';

extension NumExt on num {
  Widget get horizontalSpace => SizedBox(width: toDouble());

  Widget get verticalSpace => SizedBox(height: toDouble());
}

extension PadExt on Widget {
  Widget padAll({required double value}) => Padding(
        padding: EdgeInsets.all(value),
        child: this,
      );

  Widget padSymmetric({
    double? horizontalPad,
    double? verticalPad,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPad ?? 0,
          vertical: verticalPad ?? 0,
        ),
        child: this,
      );

  Widget get toSliverBox {
    return SliverToBoxAdapter(child: this);
  }
}