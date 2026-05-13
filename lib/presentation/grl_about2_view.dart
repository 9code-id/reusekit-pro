import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAbout2View extends StatefulWidget {
  @override
  State<GrlAbout2View> createState() => _GrlAbout2ViewState();
}

class _GrlAbout2ViewState extends State<GrlAbout2View> {
  int selectedMissionIndex = 0;
  
  List<Map<String, dynamic>> missions = [
    {
      "title": "Innovation",
      "description": "We push the boundaries of what's possible, constantly exploring new technologies and methodologies to create groundbreaking solutions.",
      "icon": Icons.lightbulb,
      "color": warningColor,
    },
    {
      "title": "Quality",
      "description": "Excellence is not negotiable. We maintain the highest standards in everything we do, from code quality to customer service.",
      "icon": Icons.diamond,
      "color": infoColor,
    },
    {
      "title": "Impact",
      "description": "We measure our success by the positive impact we create in our users' lives and the communities we serve.",
      "icon": Icons.favorite,
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "year": "2024",
      "title": "Global Expansion",
      "description": "Launched in 25 new countries, reaching over 1 million users worldwide.",
      "icon": Icons.public,
    },
    {
      "year": "2023",
      "title": "Industry Recognition",
      "description": "Won 'Best Innovation Award' at the Tech Excellence Summit.",
      "icon": Icons.emoji_events,
    },
    {
      "year": "2022",
      "title": "Product Launch",
      "description": "Successfully launched our flagship platform with 99.9% uptime.",
      "icon": Icons.rocket_launch,
    },
    {
      "year": "2021",
      "title": "Company Founded",
      "description": "Started our journey with a vision to transform the industry.",
      "icon": Icons.foundation,
    },
  ];

  List<Map<String, dynamic>> values = [
    {
      "title": "Transparency",
      "description": "Open communication and honest relationships",
      "icon": Icons.visibility,
      "percentage": 95,
    },
    {
      "title": "Collaboration",
      "description": "Working together to achieve common goals",
      "icon": Icons.handshake,
      "percentage": 90,
    },
    {
      "title": "Excellence",
      "description": "Striving for perfection in every detail",
      "icon": Icons.star,
      "percentage": 98,
    },
    {
      "title": "Integrity",
      "description": "Doing the right thing, even when no one is watching",
      "icon": Icons.security,
      "percentage": 100,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Our Story"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company Overview
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [successColor, successColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.apartment,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "TechCorp Solutions",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Est. 2021 • San Francisco, CA",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(230),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Empowering businesses with cutting-edge technology solutions that drive growth, efficiency, and innovation. We're not just building software - we're crafting the future of digital transformation.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Mission Tabs
            Text(
              "Our Mission & Values",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Mission Selector
            QHorizontalScroll(
              children: List.generate(missions.length, (index) {
                final mission = missions[index];
                final isSelected = selectedMissionIndex == index;
                return GestureDetector(
                  onTap: () {
                    selectedMissionIndex = index;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: isSelected ? (mission["color"] as Color) : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          mission["icon"] as IconData,
                          color: isSelected ? Colors.white : (mission["color"] as Color),
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${mission["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : (mission["color"] as Color),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            
            SizedBox(height: spMd),
            
            // Selected Mission Content
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (missions[selectedMissionIndex]["color"] as Color).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          missions[selectedMissionIndex]["icon"] as IconData,
                          color: missions[selectedMissionIndex]["color"] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Text(
                        "${missions[selectedMissionIndex]["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: missions[selectedMissionIndex]["color"] as Color,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "${missions[selectedMissionIndex]["description"]}",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Core Values
            Text(
              "Core Values",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ...values.map((value) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        value["icon"] as IconData,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${value["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${value["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${value["percentage"]}%",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  LinearProgressIndicator(
                    value: (value["percentage"] as int) / 100,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ],
              ),
            )).toList(),
            
            SizedBox(height: spMd),
            
            // Timeline
            Text(
              "Our Journey",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ...achievements.asMap().entries.map((entry) {
              final index = entry.key;
              final achievement = entry.value;
              final isLast = index == achievements.length - 1;
              
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          achievement["icon"] as IconData,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      if (!isLast)
                        Container(
                          width: 2,
                          height: 60,
                          color: disabledColor,
                          margin: EdgeInsets.symmetric(vertical: spSm),
                        ),
                    ],
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: isLast ? 0 : spMd),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${achievement["year"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${achievement["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${achievement["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
            
            SizedBox(height: spMd),
            
            // Call to Action
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.handshake,
                    color: Colors.white,
                    size: 48,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Join Our Journey",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Be part of something bigger. Let's create the future together.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(230),
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Learn More",
                          size: bs.md,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
