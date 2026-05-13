//#TEMPLATE reuseable_statistic
import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class QStatistic extends StatelessWidget {
  const QStatistic({
    required this.label,
    required this.value,
    required this.icon,
    super.key,
    this.color,
  });
  final String label;
  final num value;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(spMd),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: fsMd,
                    ),
                  ),
                  SizedBox(
                    height: spXs,
                  ),
                  Text(
                    '$value',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: fsXl,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: color ?? primaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(radiusMd),
                ),
              ),
              child: Icon(
                icon,
                size: iconXs,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//#END
