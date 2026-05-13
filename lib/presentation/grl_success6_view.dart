import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSuccess6View extends StatefulWidget {
  @override
  State<GrlSuccess6View> createState() => _GrlSuccess6ViewState();
}

class _GrlSuccess6ViewState extends State<GrlSuccess6View> {
  List<Map<String, dynamic>> metrics = [
    {
      "label": "Completion Time",
      "value": "2h 30m",
      "improvement": "+15% faster",
      "icon": Icons.timer,
    },
    {
      "label": "Accuracy Rate",
      "value": "98.5%",
      "improvement": "+5% better",
      "icon": Icons.check_circle,
    },
    {
      "label": "Quality Score",
      "value": "9.8/10",
      "improvement": "Perfect rating",
      "icon": Icons.grade,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              successColor.withAlpha(5),
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: sp3xl),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: successColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                SizedBox(width: spSm),
                Text(
                  "Success",
                  style: TextStyle(
                    fontSize: fsH1,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),
            Text(
              "Task Completed Successfully",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fsH4,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Great job! You've successfully completed your task with excellent performance metrics.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
                height: 1.5,
              ),
            ),
            SizedBox(height: spXl),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Performance Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Column(
                    spacing: spMd,
                    children: metrics.map((metric) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: successColor.withAlpha(30),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                metric["icon"] as IconData,
                                color: successColor,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${metric["label"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${metric["value"]}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: successColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${metric["improvement"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: successColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              child: QButton(
                label: "View Details",
                size: bs.md,
                onPressed: () {
                  // Navigate to details
                },
              ),
            ),
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Back to Dashboard",
                color: disabledBoldColor,
                size: bs.md,
                onPressed: () {
                  back();
                },
              ),
            ),
            SizedBox(height: spSm),
          ],
        ),
      ),
    );
  }
}
