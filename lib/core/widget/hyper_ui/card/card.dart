//#TEMPLATE reuseable_card
// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class QCard extends StatelessWidget {
  const QCard({
    required this.children,
    super.key,
    this.title,
    this.subtitle,
    this.padding,
    this.spacing,
    this.actions = const [],
    this.footers = const [],
    this.flex = 0,
    this.headerColor,
    this.color,
  });
  final String? title;
  final String? subtitle;
  final EdgeInsetsGeometry? padding;
  final List<Widget> children;
  final List<Widget> actions;
  final List<Widget> footers;
  final int flex;
  final double? spacing;
  final Color? headerColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final body = Container(
      width: double.infinity,
      padding: padding ?? EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(radiusXl),
          bottomRight: Radius.circular(radiusXl),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spacing ?? spSm,
        children: [
          if (children.isNotEmpty) ...children,
          if (footers.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: footers,
            ),
        ],
      ),
    );

    var child = Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(radiusXl),
        ),
        border: Border.all(
          width: 0.2,
          color: Color(0x19000000),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 24,
            offset: Offset(0, 11),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: spSm,
                vertical: spXs,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$title',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: fsXl,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (subtitle != null)
                          Text(
                            '$subtitle',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: fsMd,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (actions.isNotEmpty)
                    SizedBox(
                      height: 32,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: actions,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
          if (flex > 0) Expanded(flex: flex, child: body) else body,
        ],
      ),
    );
    if (flex == 0) return child;
    return Expanded(
      flex: flex,
      child: child,
    );
  }
}
//#END
