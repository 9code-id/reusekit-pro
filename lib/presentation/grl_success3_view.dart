import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSuccess3View extends StatefulWidget {
  @override
  State<GrlSuccess3View> createState() => _GrlSuccess3ViewState();
}

class _GrlSuccess3ViewState extends State<GrlSuccess3View> {
  List<Map<String, dynamic>> achievementData = [
    {
      "title": "Task Completed",
      "description": "Successfully finished your assigned task",
      "icon": Icons.task_alt,
      "color": successColor,
    },
    {
      "title": "Time Saved",
      "description": "Completed 2 hours ahead of schedule",
      "icon": Icons.schedule,
      "color": infoColor,
    },
    {
      "title": "Quality Score",
      "description": "Achieved 98% accuracy rating",
      "icon": Icons.star,
      "color": warningColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Achievement Unlocked"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            SizedBox(height: spLg),
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: successColor.withAlpha(100),
                  width: 3,
                ),
              ),
              child: Icon(
                Icons.emoji_events,
                size: 80,
                color: successColor,
              ),
            ),
            SizedBox(height: spLg),
            Text(
              "Excellent Work!",
              style: TextStyle(
                fontSize: fsH1,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "You've successfully completed all requirements with outstanding performance.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
                height: 1.5,
              ),
            ),
            SizedBox(height: spXl),
            Column(
              spacing: spSm,
              children: achievementData.map((achievement) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: (achievement["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          achievement["icon"] as IconData,
                          color: achievement["color"] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${achievement["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${achievement["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spXl),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Share Achievement",
                size: bs.md,
                onPressed: () {
                  ss("Achievement shared successfully!");
                },
              ),
            ),
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Continue",
                color: disabledBoldColor,
                size: bs.md,
                onPressed: () {
                  back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
