import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:reusekit/core/theme/theme_config.dart';

class ResponsiveGridView extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets? padding;
  final int? minItemWidth;
  final bool shrinkWrap;
  const ResponsiveGridView({
    super.key,
    this.padding,
    this.minItemWidth,
    this.shrinkWrap = false,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      child: Container(
        padding: padding ?? EdgeInsets.all(spMd),
        child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
          final mediaWidth = MediaQuery.maybeOf(context)?.size.width;
          final availableWidth =
              constraints.maxWidth.isFinite && constraints.maxWidth > 0
                  ? constraints.maxWidth
                  : mediaWidth != null && mediaWidth.isFinite && mediaWidth > 0
                      ? mediaWidth
                      : 1.0;

          var wantedWidth = (minItemWidth ?? 460).toDouble();
          if (wantedWidth <= 0) {
            wantedWidth = 1.0;
          }
          if (wantedWidth > availableWidth) {
            wantedWidth = availableWidth;
          }

          final crossAxisCount =
              (availableWidth / wantedWidth).floor().clamp(1, 1000).toInt();
          return StaggeredGrid.count(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: spSm,
            mainAxisSpacing: spSm,
            children: children,
          );
        }),
      ),
    );
  }
}
