import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSuccess5View extends StatefulWidget {
  @override
  State<GrlSuccess5View> createState() => _GrlSuccess5ViewState();
}

class _GrlSuccess5ViewState extends State<GrlSuccess5View> {
  List<Map<String, dynamic>> rewards = [
    {
      "title": "Points Earned",
      "value": "250",
      "icon": Icons.stars,
      "color": warningColor,
    },
    {
      "title": "Streak Days",
      "value": "15",
      "icon": Icons.local_fire_department,
      "color": dangerColor,
    },
    {
      "title": "Level Up",
      "value": "Pro",
      "icon": Icons.trending_up,
      "color": successColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Congratulations"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            SizedBox(height: spLg),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    successColor,
                    successColor.withAlpha(200),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
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
            SizedBox(height: spLg),
            Text(
              "Outstanding!",
              style: TextStyle(
                fontSize: fsH1,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "You've achieved something remarkable. Your dedication and effort have paid off!",
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
                children: [
                  Text(
                    "Your Rewards",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: rewards.map((reward) {
                      return Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (reward["color"] as Color).withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: (reward["color"] as Color).withAlpha(50),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: reward["color"] as Color,
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Icon(
                                  reward["icon"] as IconData,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${reward["value"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: reward["color"] as Color,
                                ),
                              ),
                              Text(
                                "${reward["title"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
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
            SizedBox(height: spXl),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    infoColor.withAlpha(10),
                    infoColor.withAlpha(5),
                  ],
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: infoColor.withAlpha(50),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    color: infoColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Keep Going!",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Maintain your momentum and continue achieving great things.",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spXl),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Claim Rewards",
                size: bs.md,
                onPressed: () {
                  ss("Rewards claimed successfully!");
                },
              ),
            ),
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Continue Journey",
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
