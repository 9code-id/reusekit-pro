import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reusekit/core.dart';

class ListItem2 extends StatelessWidget {
  const ListItem2({
    required this.label,
    super.key,
    this.separator = true,
    this.value,
    this.onTap,
    this.color,
  });
  final String label;
  final String? value;
  final Function? onTap;
  final Color? color;
  final bool separator;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Clipboard.setData(ClipboardData(text: value ?? ''));
      },
      onTap: onTap == null
          ? null
          : () {
              Clipboard.setData(ClipboardData(text: value ?? ''));
              if (onTap != null) {
                onTap!();
              }
            },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: spSm,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: fsMd,
                      color: color,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '$value',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: fsMd,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: separator ? 1.0 : 0.0,
            color: disabledColor.withValues(alpha: 0.4),
          ),
        ],
      ),
    );
  }
}
