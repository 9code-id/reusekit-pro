import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHelp1View extends StatefulWidget {
  @override
  State<GrlHelp1View> createState() => _GrlHelp1ViewState();
}

class _GrlHelp1ViewState extends State<GrlHelp1View> {
  String searchQuery = "";
  
  List<Map<String, dynamic>> helpCategories = [
    {
      "title": "Getting Started",
      "icon": Icons.play_arrow,
      "color": successColor,
      "articles": 12,
      "description": "Basic setup and first steps"
    },
    {
      "title": "Account & Settings",
      "icon": Icons.settings,
      "color": primaryColor,
      "articles": 8,
      "description": "Manage your profile and preferences"
    },
    {
      "title": "Billing & Payments",
      "icon": Icons.payment,
      "color": warningColor,
      "articles": 15,
      "description": "Payment methods and billing issues"
    },
    {
      "title": "Technical Support",
      "icon": Icons.build,
      "color": infoColor,
      "articles": 24,
      "description": "Technical troubleshooting guides"
    },
    {
      "title": "Privacy & Security",
      "icon": Icons.security,
      "color": dangerColor,
      "articles": 9,
      "description": "Data protection and security features"
    },
    {
      "title": "Mobile App",
      "icon": Icons.smartphone,
      "color": successColor,
      "articles": 18,
      "description": "Mobile app specific help"
    },
  ];

  List<Map<String, dynamic>> popularArticles = [
    {
      "title": "How to reset your password",
      "views": 2450,
      "category": "Account & Settings",
      "difficulty": "Easy"
    },
    {
      "title": "Understanding your billing cycle",
      "views": 1890,
      "category": "Billing & Payments",
      "difficulty": "Medium"
    },
    {
      "title": "Setting up two-factor authentication",
      "views": 1654,
      "category": "Privacy & Security",
      "difficulty": "Medium"
    },
    {
      "title": "Troubleshooting connection issues",
      "views": 1432,
      "category": "Technical Support",
      "difficulty": "Advanced"
    },
  ];

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Contact Support",
      "subtitle": "Get help from our team",
      "icon": Icons.support_agent,
      "color": primaryColor,
    },
    {
      "title": "Live Chat",
      "subtitle": "Chat with an agent",
      "icon": Icons.chat,
      "color": successColor,
    },
    {
      "title": "Report Issue",
      "subtitle": "Report a bug or problem",
      "icon": Icons.bug_report,
      "color": dangerColor,
    },
    {
      "title": "Feature Request",
      "subtitle": "Suggest new features",
      "icon": Icons.lightbulb,
      "color": warningColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help Center"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Banner
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.help_center,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome to Help Center",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Find answers, get support, and learn more",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  QTextField(
                    label: "Search for help...",
                    value: searchQuery,
                    hint: "What can we help you with?",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Quick Actions
            Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ResponsiveGridView(
              minItemWidth: 200,
              children: quickActions.map((action) => Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (action["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        action["icon"],
                        color: action["color"],
                        size: 24,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "${action["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${action["subtitle"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Access",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Help Categories
            Text(
              "Browse by Category",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ...helpCategories.map((category) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: (category["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        category["icon"],
                        color: category["color"],
                        size: 28,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${category["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${category["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${category["articles"]} articles",
                            style: TextStyle(
                              fontSize: 12,
                              color: category["color"],
                              fontWeight: FontWeight.w600,
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
            )).toList(),
            
            SizedBox(height: spMd),
            
            // Popular Articles
            Text(
              "Popular Articles",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ...popularArticles.map((article) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getDifficultyColor(article["difficulty"]),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${article["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: _getDifficultyColor(article["difficulty"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${article["difficulty"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: _getDifficultyColor(article["difficulty"]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.folder,
                        size: 16,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${article["category"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Icon(
                        Icons.visibility,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${article["views"]} views",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Read",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            )).toList(),
            
            SizedBox(height: spMd),
            
            // Still Need Help
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: infoColor.withAlpha(60),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.help_outline,
                    color: infoColor,
                    size: 48,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Still need help?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: infoColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Can't find what you're looking for? Our support team is here to help you 24/7.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Contact Support",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Live Chat",
                          size: bs.sm,
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

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Easy':
        return successColor;
      case 'Medium':
        return warningColor;
      case 'Advanced':
        return dangerColor;
      default:
        return primaryColor;
    }
  }
}
