import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reusekit/core.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    required this.label,
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.color,
  });
  final String label;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Function? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {},
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Row(
        children: [
          if (prefixIcon != null) ...[
            Icon(
              prefixIcon,
              size: iconSm,
              color: color,
            ),
            SizedBox(width: spMd),
          ],
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: fsLg,
                color: color,
              ),
            ),
          ),
          if (suffixIcon != null) ...[
            SizedBox(width: spSm),
            Icon(
              suffixIcon,
              size: iconMd,
            ),
          ],
          if (suffixIcon == null) ...[
            SizedBox(width: spMd),
            Icon(
              Icons.chevron_right,
              size: iconSm,
              color: color,
            ),
          ],
        ],
      ),
    );
  }
}
