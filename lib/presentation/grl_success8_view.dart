import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSuccess8View extends StatefulWidget {
  @override
  State<GrlSuccess8View> createState() => _GrlSuccess8ViewState();
}

class _GrlSuccess8ViewState extends State<GrlSuccess8View> {
  List<Map<String, dynamic>> teamMembers = [
    {
      "name": "Sarah Johnson",
      "role": "Project Lead",
      "avatar": "https://picsum.photos/50/50?random=1&keyword=woman",
    },
    {
      "name": "Mike Chen",
      "role": "Developer",
      "avatar": "https://picsum.photos/50/50?random=2&keyword=man",
    },
    {
      "name": "Emma Davis",
      "role": "Designer",
      "avatar": "https://picsum.photos/50/50?random=3&keyword=woman",
    },
    {
      "name": "Alex Wilson",
      "role": "QA Engineer",
      "avatar": "https://picsum.photos/50/50?random=4&keyword=man",
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
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
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
              child: Column(
                children: [
                  Icon(
                    Icons.group_work,
                    size: 80,
                    color: Colors.white,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Team Success!",
                    style: TextStyle(
                      fontSize: fsH1,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Amazing teamwork leads to outstanding results",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(230),
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
                    "Team Contributors",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Column(
                    spacing: spSm,
                    children: teamMembers.map((member) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusLg),
                                boxShadow: [shadowSm],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(radiusLg),
                                child: Image.network(
                                  "${member["avatar"]}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${member["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${member["role"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.star,
                              color: warningColor,
                              size: 20,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: warningColor.withAlpha(50),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.emoji_events,
                    color: warningColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Team Achievement Unlocked: Perfect Collaboration",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: warningColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Celebrate Together",
                size: bs.md,
                onPressed: () {
                  ss("Team celebration scheduled!");
                },
              ),
            ),
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Share Success",
                color: disabledBoldColor,
                size: bs.md,
                onPressed: () {
                  ss("Success shared with team!");
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
