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
          var wantedWidth = minItemWidth ?? 460;
          var deviceWidth = constraints.biggest.width;
          if (wantedWidth > deviceWidth) {
            wantedWidth = deviceWidth.toInt();
          }

          final crossAxisCount =
              (constraints.maxWidth / wantedWidth).floor().clamp(1, 1000);
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
