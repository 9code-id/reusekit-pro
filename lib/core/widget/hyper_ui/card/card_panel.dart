import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CardPanel extends StatelessWidget {
  const CardPanel({
    required this.children,
    super.key,
    this.padding,
  });
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: spMd,
          ),
      decoration: BoxDecoration(
        border: Border.all(
          color: disabledOutlineBorderColor,
        ),
        color: Colors.grey[100],
        borderRadius: BorderRadius.all(
          Radius.circular(radiusMd),
        ),
      ),
      child: Column(
        children: children,
      ),
    );
  }
}
