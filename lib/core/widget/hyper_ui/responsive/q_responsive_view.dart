import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:reusekit/core.dart';

class QResponsiveView extends StatelessWidget {
  final List<Widget> children;
  final int minimumCrossAxisCount;
  final List<int> crossAxisCounts;
  final EdgeInsetsGeometry? padding;
  const QResponsiveView({
    super.key,
    required this.children,
    this.minimumCrossAxisCount = 1,
    this.crossAxisCounts = const [],
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: padding ?? EdgeInsets.all(spXl),
        child: LayoutBuilder(
          builder: (context, constraints) {
            var crossAxisCount = 4;
            var screenWidth = constraints.maxWidth;

            if (screenWidth < bpMobile) {
              crossAxisCount = minimumCrossAxisCount;
            } else if (screenWidth < bpTablet) {
              crossAxisCount = 2;
            } else if (screenWidth < bpDesktop) {
              crossAxisCount = 3;
            } else {
              crossAxisCount = 4;
            }

            return StaggeredGrid.count(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: spXl,
              crossAxisSpacing: spXl,
              children: List.generate(children.length, (index) {
                var widget = children[index];

                var customCrossAxisCount = 1;
                if (index < crossAxisCounts.length) {
                  customCrossAxisCount = crossAxisCounts[index];
                }

                return StaggeredGridTile.fit(
                  crossAxisCellCount:
                      customCrossAxisCount.clamp(1, crossAxisCount),
                  child: widget,
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
