import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class QTabBar extends StatefulWidget {
  final String? title;
  final List<Widget>? actions;
  final List<Tab>? tabs;
  final List<Widget>? tabChildren;
  final Function(TabController? tabController)? onInit;
  final int selectedIndex;
  final bool withoutAppBar;
  QTabBar(
      {super.key,
      this.title,
      this.actions,
      this.tabs,
      this.tabChildren,
      this.onInit,
      this.selectedIndex = 0,
      this.withoutAppBar = false});

  @override
  State<QTabBar> createState() => _QTabBarState();
}

class _QTabBarState extends State<QTabBar> with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = widget.tabs != null
        ? TabController(
            length: widget.tabs!.length,
            vsync: this,
            initialIndex: widget.selectedIndex,
          )
        : null;
    widget.onInit?.call(tabController);
  }

  @override
  void dispose() {
    super.dispose();
    tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.withoutAppBar) {
      return Scaffold(
        body: Column(
          children: [
            widget.tabs != null
                ? Container(
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    child: TabBar(
                      controller: tabController,
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      tabs: widget.tabs!,
                      unselectedLabelColor: disabledColor,
                      labelColor: Colors.white,
                      indicatorColor: warningColor,
                      indicatorSize: TabBarIndicatorSize.tab,
                    ),
                  )
                : const SizedBox.shrink(),
            Expanded(
              child: widget.tabChildren != null
                  ? TabBarView(
                      controller: tabController,
                      children: widget.tabChildren!,
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: widget.title != null
            ? Text(
                widget.title!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        actions: widget.actions,
        bottom: widget.tabs != null
            ? TabBar(
                controller: tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                tabs: widget.tabs!,
                unselectedLabelColor: disabledColor,
                labelColor: Colors.white,
                indicatorColor: warningColor,
                indicatorSize: TabBarIndicatorSize.tab,
              )
            : null,
      ),
      body: widget.tabChildren != null
          ? TabBarView(
              controller: tabController,
              children: widget.tabChildren!,
            )
          : const SizedBox.shrink(),
    );
  }
}
