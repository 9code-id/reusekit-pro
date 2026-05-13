import 'package:flutter/material.dart';

class QBottomBar extends StatefulWidget {
  final String? title;
  final List<Widget>? actions;
  final List<BottomNavigationBarItem> items;
  final List<Widget> children;
  final Function(int index)? onTap;
  final int selectedIndex;

  QBottomBar({
    super.key,
    this.title,
    this.actions,
    required this.items,
    required this.children,
    this.onTap,
    this.selectedIndex = 0,
  });

  @override
  State<QBottomBar> createState() => _QBottomBarState();
}

class _QBottomBarState extends State<QBottomBar> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
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
      ),
      body: IndexedStack(
        index: currentIndex,
        children: widget.children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
          widget.onTap?.call(index);
        },
        items: widget.items,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
