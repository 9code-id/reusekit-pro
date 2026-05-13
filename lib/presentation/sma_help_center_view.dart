import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaHelpCenterView extends StatefulWidget {
  const SmaHelpCenterView({super.key});

  @override
  State<SmaHelpCenterView> createState() => _SmaHelpCenterViewState();
}

class _SmaHelpCenterViewState extends State<SmaHelpCenterView> {
  String searchQuery = "";
  String selectedCategory = "All";

  List<String> categories = [
    "All",
    "Account & Profile",
    "Privacy & Security",
    "Posts & Content",
    "Messages & Chat",
    "Technical Issues",
    "Billing & Payments",
    "Community Guidelines",
  ];

  List<Map<String, dynamic>> helpArticles = [
    {
      "id": "1",
      "title": "How to reset your password",
      "category": "Account & Profile",
      "description": "Step-by-step guide to reset your password if you've forgotten it",
      "views": 15420,
      "helpful": 89,
      "tags": ["password", "login", "account"],
    },
    {
      "id": "2",
      "title": "Managing your privacy settings",
      "category": "Privacy & Security",
      "description": "Control who can see your posts, profile, and personal information",
      "views": 12890,
      "helpful": 92,
      "tags": ["privacy", "settings", "security"],
    },
    {
      "id": "3",
      "title": "How to delete or edit your posts",
      "category": "Posts & Content",
      "description": "Learn how to manage your published content",
      "views": 8750,
      "helpful": 85,
      "tags": ["posts", "delete", "edit"],
    },
    {
      "id": "4",
      "title": "Reporting inappropriate content",
      "category": "Community Guidelines",
      "description": "How to report posts, comments, or users that violate our guidelines",
      "views": 7340,
      "helpful": 91,
      "tags": ["report", "inappropriate", "guidelines"],
    },
    {
      "id": "5",
      "title": "Troubleshooting login issues",
      "category": "Technical Issues",
      "description": "Common solutions for when you can't access your account",
      "views": 6890,
      "helpful": 78,
      "tags": ["login", "troubleshooting", "access"],
    },
    {
      "id": "6",
      "title": "Understanding message encryption",
      "category": "Messages & Chat",
      "description": "How we protect your private conversations",
      "views": 5230,
      "helpful": 88,
      "tags": ["messages", "encryption", "privacy"],
    },
    {
      "id": "7",
      "title": "Managing subscription and billing",
      "category": "Billing & Payments",
      "description": "How to view, change, or cancel your subscription",
      "views": 4560,
      "helpful": 82,
      "tags": ["billing", "subscription", "payment"],
    },
    {
      "id": "8",
      "title": "Two-factor authentication setup",
      "category": "Privacy & Security",
      "description": "Add an extra layer of security to your account",
      "views": 3890,
      "helpful": 94,
      "tags": ["2fa", "security", "authentication"],
    },
    {
      "id": "9",
      "title": "Blocking and unblocking users",
      "category": "Privacy & Security",
      "description": "How to block users and manage your blocked list",
      "views": 3450,
      "helpful": 87,
      "tags": ["block", "users", "privacy"],
    },
    {
      "id": "10",
      "title": "App crashes and performance issues",
      "category": "Technical Issues",
      "description": "Solutions for common app stability problems",
      "views": 2980,
      "helpful": 75,
      "tags": ["crash", "performance", "app"],
    },
  ];

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Contact Support",
      "description": "Get personal help from our support team",
      "icon": Icons.support_agent,
      "color": primaryColor,
    },
    {
      "title": "Report a Bug",
      "description": "Found a technical issue? Let us know",
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
      "title": "Community Forum",
      "description": "Connect with other users and get tips",
      "icon": Icons.forum,
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> get filteredArticles {
    List<Map<String, dynamic>> filtered = helpArticles;
    
    if (selectedCategory != "All") {
      filtered = filtered.where((article) => article["category"] == selectedCategory).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((article) {
        return "${article["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
               "${article["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
               (article["tags"] as List).any((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()));
      }).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help Center"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Welcome Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(40)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Icon(Icons.help_center, color: primaryColor, size: 48),
                  Text(
                    "How can we help you?",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Search our knowledge base or browse by category to find answers to your questions",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar
            QTextField(
              label: "Search help articles",
              value: searchQuery,
              hint: "What do you need help with?",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Quick Actions
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Text(
                      "Quick Actions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    minItemWidth: 200,
                    children: quickActions.map((action) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spMd),
                        decoration: BoxDecoration(
                          color: action["color"].withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: action["color"].withAlpha(30)),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              ss("Opening ${action["title"]}");
                            },
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Padding(
                              padding: EdgeInsets.all(spMd),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        action["icon"],
                                        color: action["color"],
                                        size: 24,
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: Text(
                                          "${action["title"]}",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: action["color"],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spSm),
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
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Category Filter
            QCategoryPicker(
              label: "Browse by Category",
              items: categories.map((category) => {
                "label": category,
                "value": category,
              }).toList(),
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            // Results Count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${filteredArticles.length} ${filteredArticles.length == 1 ? 'article' : 'articles'} found",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                if (searchQuery.isNotEmpty || selectedCategory != "All")
                  TextButton(
                    onPressed: () {
                      searchQuery = "";
                      selectedCategory = "All";
                      setState(() {});
                    },
                    child: Text(
                      "Clear filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ),
              ],
            ),

            // Help Articles
            if (filteredArticles.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXl),
                child: Column(
                  spacing: spMd,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: disabledColor,
                    ),
                    Text(
                      "No articles found",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search terms or browse different categories",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredArticles.map((article) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        ss("Opening: ${article["title"]}");
                      },
                      borderRadius: BorderRadius.circular(radiusMd),
                      child: Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            // Header
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${article["category"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios, size: 16, color: disabledBoldColor),
                              ],
                            ),

                            // Title
                            Text(
                              "${article["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            // Description
                            Text(
                              "${article["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                            ),

                            // Tags
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (article["tags"] as List).map((tag) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: disabledColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "#$tag",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),

                            // Stats
                            Row(
                              children: [
                                Icon(Icons.visibility, size: 14, color: disabledColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${(article["views"] as int) > 1000 ? '${((article["views"] as int) / 1000).toStringAsFixed(1)}K' : '${article["views"]}'} views",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Icon(Icons.thumb_up, size: 14, color: successColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${article["helpful"]}% helpful",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),

            // Contact Support
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(40)),
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(Icons.headset_mic, color: infoColor, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Still need help?",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Can't find what you're looking for? Our support team is here to help you with any questions or issues.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Live Chat",
                          icon: Icons.chat,
                          size: bs.sm,
                          onPressed: () {
                            ss("Starting live chat...");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Email Support",
                          icon: Icons.email,
                          size: bs.sm,
                          onPressed: () {
                            ss("Opening email form...");
                          },
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
