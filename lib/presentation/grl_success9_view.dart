import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSuccess9View extends StatefulWidget {
  @override
  State<GrlSuccess9View> createState() => _GrlSuccess9ViewState();
}

class _GrlSuccess9ViewState extends State<GrlSuccess9View> {
  List<Map<String, dynamic>> milestones = [
    {
      "title": "Project Started",
      "date": "Mar 15, 2024",
      "status": "completed",
    },
    {
      "title": "First Milestone",
      "date": "Apr 2, 2024",
      "status": "completed",
    },
    {
      "title": "Mid-Point Review",
      "date": "May 10, 2024",
      "status": "completed",
    },
    {
      "title": "Final Delivery",
      "date": "Jun 22, 2024",
      "status": "completed",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Journey Complete"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            SizedBox(height: spLg),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowLg],
              ),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          successColor,
                          successColor.withAlpha(180),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Icon(
                      Icons.flag,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Journey Complete!",
                    style: TextStyle(
                      fontSize: fsH1,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "You've successfully reached the finish line. What an incredible journey it has been!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                ],
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
                    "Your Journey Timeline",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Column(
                    children: milestones.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> milestone = entry.value;
                      bool isLast = index == milestones.length - 1;

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                              if (!isLast)
                                Container(
                                  width: 2,
                                  height: 40,
                                  color: successColor.withAlpha(100),
                                ),
                            ],
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(
                                bottom: isLast ? 0 : spSm,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${milestone["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${milestone["date"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: infoColor.withAlpha(50),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.timeline,
                          color: infoColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "3 Months",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Duration",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: warningColor.withAlpha(50),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.track_changes,
                          color: warningColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "4/4",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Milestones",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spXl),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Start New Journey",
                size: bs.md,
                onPressed: () {
                  // Navigate to new project
                },
              ),
            ),
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              child: QButton(
                label: "View Summary",
                color: disabledBoldColor,
                size: bs.md,
                onPressed: () {
                  // Show summary
                },
              ),
            ),
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Close",
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
