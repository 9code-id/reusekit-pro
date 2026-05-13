import 'package:flutter/material.dart';

class QHorizontalScroll extends StatefulWidget {
  final List<Widget> children;
  final EdgeInsets? padding;
  const QHorizontalScroll({
    super.key,
    required this.children,
    this.padding,
  });

  @override
  State<QHorizontalScroll> createState() => _QHorizontalScrollState();
}

class _QHorizontalScrollState extends State<QHorizontalScroll> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: widget.padding ?? EdgeInsets.zero,
        clipBehavior: Clip.none,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.children,
        ),
      ),
    );
  }
}
