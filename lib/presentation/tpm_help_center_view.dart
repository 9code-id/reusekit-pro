import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmHelpCenterView extends StatefulWidget {
  const TpmHelpCenterView({super.key});

  @override
  State<TpmHelpCenterView> createState() => _TpmHelpCenterViewState();
}

class _TpmHelpCenterViewState extends State<TpmHelpCenterView> {
  String searchQuery = "";
  List<Map<String, dynamic>> categories = [
    {
      "id": "getting_started",
      "title": "Getting Started",
      "description": "Learn the basics of using our platform",
      "icon": Icons.rocket_launch,
      "color": primaryColor,
      "article_count": 12,
    },
    {
      "id": "project_management",
      "title": "Project Management",
      "description": "Master project planning and execution",
      "icon": Icons.assignment,
      "color": successColor,
      "article_count": 18,
    },
    {
      "id": "team_collaboration",
      "title": "Team Collaboration",
      "description": "Work effectively with your team",
      "icon": Icons.groups,
      "color": infoColor,
      "article_count": 15,
    },
    {
      "id": "reporting",
      "title": "Reporting & Analytics",
      "description": "Generate insights from your data",
      "icon": Icons.analytics,
      "color": warningColor,
      "article_count": 9,
    },
    {
      "id": "billing",
      "title": "Billing & Subscriptions",
      "description": "Manage your account and payments",
      "icon": Icons.payment,
      "color": dangerColor,
      "article_count": 7,
    },
    {
      "id": "integrations",
      "title": "Integrations",
      "description": "Connect with external tools",
      "icon": Icons.extension,
      "color": secondaryColor,
      "article_count": 11,
    },
  ];

  List<Map<String, dynamic>> popularArticles = [
    {
      "id": "1",
      "title": "How to create your first project",
      "category": "Getting Started",
      "views": 2847,
      "helpful_votes": 156,
    },
    {
      "id": "2",
      "title": "Setting up team permissions",
      "category": "Team Collaboration",
      "views": 1923,
      "helpful_votes": 98,
    },
    {
      "id": "3",
      "title": "Creating custom reports",
      "category": "Reporting & Analytics",
      "views": 1654,
      "helpful_votes": 87,
    },
    {
      "id": "4",
      "title": "Integrating with Slack",
      "category": "Integrations",
      "views": 1432,
      "helpful_votes": 76,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help Center"),
        actions: [
          IconButton(
            icon: Icon(Icons.headset_mic),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spLg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: primaryColor.withAlpha(20),
                  width: 1,
                ),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Icon(
                    Icons.help_center,
                    size: 48,
                    color: primaryColor,
                  ),
                  Text(
                    "How can we help you today?",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Find answers to your questions or get in touch with our support team",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search articles...",
                    value: searchQuery,
                    hint: "What can we help you with?",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            // Categories
            Text(
              "Browse by Category",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 280,
              children: categories.map((category) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (category["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              category["icon"] as IconData,
                              color: category["color"] as Color,
                              size: 24,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Text(
                              "${category["article_count"]} articles",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${category["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${category["description"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "View Articles",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Popular Articles
            Text(
              "Popular Articles",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              spacing: spSm,
              children: popularArticles.map((article) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.article,
                          color: infoColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${article["title"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "${article["category"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "•",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${(article["views"] as int)} views",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Quick Actions
            Text(
              "Need More Help?",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spSm,
                      children: [
                        Icon(
                          Icons.chat,
                          color: successColor,
                          size: 32,
                        ),
                        Text(
                          "Live Chat",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Chat with our support team",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                        QButton(
                          label: "Start Chat",
                          size: bs.sm,
                          onPressed: () {},
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spSm,
                      children: [
                        Icon(
                          Icons.email,
                          color: warningColor,
                          size: 32,
                        ),
                        Text(
                          "Email Support",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Send us a detailed message",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                        QButton(
                          label: "Send Email",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
