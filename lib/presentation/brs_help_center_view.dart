import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsHelpCenterView extends StatefulWidget {
  const BrsHelpCenterView({super.key});

  @override
  State<BrsHelpCenterView> createState() => _BrsHelpCenterViewState();
}

class _BrsHelpCenterViewState extends State<BrsHelpCenterView> {
  String searchQuery = "";
  List<Map<String, dynamic>> helpCategories = [
    {
      "title": "Getting Started",
      "description": "Learn the basics of using our barber booking app",
      "icon": Icons.play_circle,
      "articles": 12,
      "color": primaryColor,
    },
    {
      "title": "Booking & Scheduling",
      "description": "How to book appointments and manage your schedule",
      "icon": Icons.calendar_today,
      "articles": 8,
      "color": successColor,
    },
    {
      "title": "Payments & Billing",
      "description": "Understanding payments, refunds, and billing",
      "icon": Icons.payment,
      "articles": 6,
      "color": warningColor,
    },
    {
      "title": "Account Settings",
      "description": "Manage your profile and account preferences",
      "icon": Icons.settings,
      "articles": 10,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> popularArticles = [
    {
      "title": "How to book your first appointment",
      "views": 2847,
      "rating": 4.8,
      "category": "Getting Started",
    },
    {
      "title": "Cancelling or rescheduling appointments",
      "views": 1923,
      "rating": 4.6,
      "category": "Booking & Scheduling",
    },
    {
      "title": "Payment methods and security",
      "views": 1654,
      "rating": 4.7,
      "category": "Payments & Billing",
    },
    {
      "title": "Setting up your profile",
      "views": 1432,
      "rating": 4.5,
      "category": "Account Settings",
    },
    {
      "title": "Finding barbers near you",
      "views": 1289,
      "rating": 4.9,
      "category": "Getting Started",
    },
  ];

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Contact Support",
      "description": "Get in touch with our support team",
      "icon": Icons.support_agent,
      "color": primaryColor,
    },
    {
      "title": "Report an Issue",
      "description": "Report bugs or technical problems",
      "icon": Icons.bug_report,
      "color": dangerColor,
    },
    {
      "title": "Feature Request",
      "description": "Suggest new features or improvements",
      "icon": Icons.lightbulb,
      "color": warningColor,
    },
    {
      "title": "Video Tutorials",
      "description": "Watch step-by-step video guides",
      "icon": Icons.play_circle,
      "color": successColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help Center"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spLg,
          children: [
            // Search Bar
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: disabledBoldColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Search help articles...",
                      value: searchQuery,
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Help Categories
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Browse by Category",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.all(spSm),
                  minItemWidth: 200,
                  children: helpCategories.map((category) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: (category["color"] as Color).withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  category["icon"] as IconData,
                                  color: category["color"] as Color,
                                  size: 20,
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${category["articles"]} articles",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
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
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${category["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "Browse Articles",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),

            // Popular Articles
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Row(
                  children: [
                    Text(
                      "Popular Articles",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "View All",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Column(
                  spacing: spSm,
                  children: popularArticles.map((article) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 50,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "${article["title"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: successColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${article["category"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: successColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Icon(
                                      Icons.visibility,
                                      size: 12,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${(article["views"] as int)} views",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Icon(
                                      Icons.star,
                                      size: 12,
                                      color: warningColor,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${article["rating"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: disabledBoldColor,
                            size: 20,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),

            // Quick Actions
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.all(spSm),
                  minItemWidth: 200,
                  children: quickActions.map((action) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        spacing: spSm,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: (action["color"] as Color).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              action["icon"] as IconData,
                              color: action["color"] as Color,
                              size: 24,
                            ),
                          ),
                          Text(
                            "${action["title"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${action["description"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "Get Started",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),

            // Still Need Help Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Icon(
                    Icons.help_center,
                    color: primaryColor,
                    size: 40,
                  ),
                  Text(
                    "Still need help?",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Can't find what you're looking for? Our support team is here to help you 24/7.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Contact Support",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: QButton(
                            label: "Live Chat",
                            size: bs.sm,
                            onPressed: () {},
                          ),
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
