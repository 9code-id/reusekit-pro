import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaCommunityGuidelinesView extends StatefulWidget {
  const SmaCommunityGuidelinesView({super.key});

  @override
  State<SmaCommunityGuidelinesView> createState() => _SmaCommunityGuidelinesViewState();
}

class _SmaCommunityGuidelinesViewState extends State<SmaCommunityGuidelinesView> {
  int selectedCategory = 0;
  
  final List<Map<String, dynamic>> categories = [
    {"label": "All Guidelines", "value": "all"},
    {"label": "Content Rules", "value": "content"},
    {"label": "Behavior", "value": "behavior"},
    {"label": "Safety", "value": "safety"},
    {"label": "Privacy", "value": "privacy"},
  ];

  final List<Map<String, dynamic>> guidelines = [
    {
      "category": "content",
      "title": "Content Standards",
      "description": "Share authentic, respectful content that adds value to our community",
      "rules": [
        "Post original content or properly credit sources",
        "Use appropriate hashtags and descriptions",
        "Avoid spam, repetitive, or promotional content",
        "Respect intellectual property rights"
      ],
      "icon": Icons.content_copy,
      "color": Colors.blue,
    },
    {
      "category": "behavior",
      "title": "Community Behavior",
      "description": "Treat all community members with respect and kindness",
      "rules": [
        "Be respectful in comments and interactions",
        "No harassment, bullying, or hate speech",
        "Constructive criticism is welcome, attacks are not",
        "Support fellow community members"
      ],
      "icon": Icons.people,
      "color": Colors.green,
    },
    {
      "category": "safety",
      "title": "Safety & Security",
      "description": "Keep our community safe for everyone",
      "rules": [
        "Report inappropriate content or behavior",
        "Don't share personal information publicly",
        "Be cautious with external links and downloads",
        "Follow platform security recommendations"
      ],
      "icon": Icons.security,
      "color": Colors.orange,
    },
    {
      "category": "privacy",
      "title": "Privacy Guidelines",
      "description": "Respect privacy and personal boundaries",
      "rules": [
        "Don't share others' personal information",
        "Respect privacy settings and boundaries",
        "Ask permission before tagging others",
        "Be mindful of what you share publicly"
      ],
      "icon": Icons.privacy_tip,
      "color": Colors.purple,
    },
  ];

  List<Map<String, dynamic>> get filteredGuidelines {
    if (selectedCategory == 0) return guidelines;
    String categoryValue = categories[selectedCategory]["value"];
    return guidelines.where((g) => g["category"] == categoryValue).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Community Guidelines"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              // Navigate to help
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.gavel,
                    color: Colors.white,
                    size: 32,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Community Guidelines",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Help us maintain a positive, safe, and welcoming community for everyone",
                    style: TextStyle(
                      color: Colors.white.withAlpha(200),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Category Filter
            QCategoryPicker(
              items: categories,
              value: categories[selectedCategory]["value"],
              onChanged: (index, label, value, item) {
                selectedCategory = index;
                setState(() {});
              },
            ),
            
            SizedBox(height: spLg),
            
            // Guidelines List
            ...filteredGuidelines.map((guideline) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: guideline["color"] as Color,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (guideline["color"] as Color).withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            guideline["icon"] as IconData,
                            color: guideline["color"] as Color,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${guideline["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${guideline["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Rules List
                    ...(guideline["rules"] as List).asMap().entries.map((entry) {
                      int index = entry.key;
                      String rule = entry.value;
                      
                      return Padding(
                        padding: EdgeInsets.only(bottom: spSm),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              margin: EdgeInsets.only(top: 2),
                              decoration: BoxDecoration(
                                color: guideline["color"] as Color,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  "${index + 1}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                rule,
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              );
            }).toList(),
            
            // Reporting Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              margin: EdgeInsets.only(top: spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: warningColor.withAlpha(100),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.report_problem,
                        color: warningColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Report Violations",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "If you see content or behavior that violates our community guidelines, please report it immediately. Your reports help us maintain a safe environment for everyone.",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Report Content",
                          icon: Icons.flag,
                          size: bs.sm,
                          onPressed: () {
                            // Navigate to report form
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Contact Support",
                          icon: Icons.support_agent,
                          size: bs.sm,
                          onPressed: () {
                            // Navigate to support
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Footer
            Center(
              child: Column(
                children: [
                  Text(
                    "Last updated: March 2024",
                    style: TextStyle(
                      color: disabledColor,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Thank you for helping us build a better community!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
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
