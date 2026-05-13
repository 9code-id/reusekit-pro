import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSuccess4View extends StatefulWidget {
  @override
  State<GrlSuccess4View> createState() => _GrlSuccess4ViewState();
}

class _GrlSuccess4ViewState extends State<GrlSuccess4View> {
  List<Map<String, dynamic>> nextSteps = [
    {
      "title": "Review Results",
      "description": "Check your completed work in detail",
      "icon": Icons.visibility,
    },
    {
      "title": "Download Report",
      "description": "Get a detailed summary of your progress",
      "icon": Icons.download,
    },
    {
      "title": "Share with Team",
      "description": "Let your team know about the completion",
      "icon": Icons.share,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            SizedBox(height: sp3xl),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                ),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: successColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    Icons.check,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: spXl),
            Text(
              "Mission Accomplished!",
              style: TextStyle(
                fontSize: fsH1,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Your task has been completed successfully and all objectives have been met.",
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
                    "What's Next?",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Column(
                    spacing: spSm,
                    children: nextSteps.map((step) {
                      return Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              step["icon"] as IconData,
                              color: primaryColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${step["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${step["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
                label: "Done",
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
