import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSuccess10View extends StatefulWidget {
  @override
  State<GrlSuccess10View> createState() => _GrlSuccess10ViewState();
}

class _GrlSuccess10ViewState extends State<GrlSuccess10View> {
  List<Map<String, dynamic>> socialActions = [
    {
      "title": "Share on Social Media",
      "description": "Let your network know about your success",
      "icon": Icons.share,
      "color": infoColor,
    },
    {
      "title": "Send to Team",
      "description": "Share this achievement with your team",
      "icon": Icons.group,
      "color": primaryColor,
    },
    {
      "title": "Email Report",
      "description": "Send detailed report to stakeholders",
      "icon": Icons.email,
      "color": successColor,
    },
    {
      "title": "Save Certificate",
      "description": "Download completion certificate",
      "icon": Icons.download,
      "color": warningColor,
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
              Colors.white,
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
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        successColor.withAlpha(20),
                        successColor.withAlpha(5),
                        Colors.transparent,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                ),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        successColor,
                        successColor.withAlpha(200),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowXl],
                  ),
                  child: Icon(
                    Icons.celebration,
                    size: 70,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: spXl),
            Text(
              "Spectacular Success!",
              style: TextStyle(
                fontSize: fsH1,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "You've achieved something truly remarkable. This success deserves to be celebrated and shared!",
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
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Share Your Success",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Column(
                    spacing: spSm,
                    children: socialActions.map((action) {
                      return GestureDetector(
                        onTap: () {
                          ss("${action["title"]} completed!");
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (action["color"] as Color).withAlpha(5),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: (action["color"] as Color).withAlpha(30),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: (action["color"] as Color).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  action["icon"] as IconData,
                                  color: action["color"] as Color,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${action["title"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${action["description"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: disabledBoldColor,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    successColor.withAlpha(10),
                    successColor.withAlpha(5),
                  ],
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: successColor.withAlpha(50),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.auto_awesome,
                    color: successColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Your success story inspires others to achieve greatness!",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: successColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Celebrate Success",
                size: bs.md,
                onPressed: () {
                  ss("Let's celebrate this amazing achievement!");
                },
              ),
            ),
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Back to Home",
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
