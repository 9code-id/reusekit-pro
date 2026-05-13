import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaHelpSupportView extends StatefulWidget {
  const FwaHelpSupportView({super.key});

  @override
  State<FwaHelpSupportView> createState() => _FwaHelpSupportViewState();
}

class _FwaHelpSupportViewState extends State<FwaHelpSupportView> {
  String searchQuery = "";
  String selectedCategory = "all";
  
  List<Map<String, dynamic>> helpCategories = [
    {"label": "All Topics", "value": "all"},
    {"label": "Getting Started", "value": "getting_started"},
    {"label": "Account & Profile", "value": "account"},
    {"label": "Features", "value": "features"},
    {"label": "Troubleshooting", "value": "troubleshooting"},
    {"label": "Billing", "value": "billing"},
    {"label": "Privacy & Security", "value": "privacy"}
  ];

  List<Map<String, dynamic>> helpArticles = [
    {
      "id": "1",
      "title": "How to create your first project",
      "category": "getting_started",
      "content": "Step-by-step guide to creating your first project...",
      "views": 1250,
      "helpful": 85,
      "tags": ["beginner", "project", "tutorial"]
    },
    {
      "id": "2", 
      "title": "Setting up your profile",
      "category": "account",
      "content": "Learn how to customize your profile settings...",
      "views": 980,
      "helpful": 78,
      "tags": ["profile", "settings", "account"]
    },
    {
      "id": "3",
      "title": "Understanding premium features",
      "category": "features", 
      "content": "Explore all the premium features available...",
      "views": 756,
      "helpful": 92,
      "tags": ["premium", "features", "upgrade"]
    },
    {
      "id": "4",
      "title": "Troubleshooting login issues",
      "category": "troubleshooting",
      "content": "Common solutions for login problems...",
      "views": 2100,
      "helpful": 88,
      "tags": ["login", "troubleshooting", "authentication"]
    },
    {
      "id": "5",
      "title": "Managing your subscription",
      "category": "billing",
      "content": "How to upgrade, downgrade, or cancel subscription...",
      "views": 1450,
      "helpful": 82,
      "tags": ["billing", "subscription", "payment"]
    },
    {
      "id": "6",
      "title": "Data privacy and security",
      "category": "privacy",
      "content": "Understanding how we protect your data...",
      "views": 890,
      "helpful": 95,
      "tags": ["privacy", "security", "data"]
    }
  ];

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Contact Support",
      "subtitle": "Get help from our team",
      "icon": Icons.support_agent,
      "color": primaryColor,
      "action": "contact"
    },
    {
      "title": "Live Chat",
      "subtitle": "Chat with support agent",
      "icon": Icons.chat,
      "color": successColor,
      "action": "chat"
    },
    {
      "title": "Report Bug",
      "subtitle": "Report technical issues",
      "icon": Icons.bug_report,
      "color": dangerColor,
      "action": "bug_report"
    },
    {
      "title": "Feature Request",
      "subtitle": "Suggest new features",
      "icon": Icons.lightbulb,
      "color": warningColor,
      "action": "feature_request"
    }
  ];

  List<Map<String, dynamic>> get filteredArticles {
    var filtered = helpArticles.where((article) {
      bool matchesCategory = selectedCategory == "all" || 
                           article["category"] == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty ||
                         article["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                         (article["tags"] as List).any((tag) => 
                           tag.toString().toLowerCase().contains(searchQuery.toLowerCase()));
      return matchesCategory && matchesSearch;
    }).toList();
    
    // Sort by views (most popular first)
    filtered.sort((a, b) => (b["views"] as int).compareTo(a["views"] as int));
    return filtered;
  }

  void _handleQuickAction(String action) {
    switch (action) {
      case "contact":
        si("Opening contact support form...");
        break;
      case "chat":
        si("Starting live chat session...");
        break;
      case "bug_report":
        si("Opening bug report form...");
        break;
      case "feature_request":
        si("Opening feature request form...");
        break;
    }
  }

  void _openArticle(Map<String, dynamic> article) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${article["title"]}"),
        content: SingleChildScrollView(
          child: Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.visibility, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text(
                    "${article["views"]} views",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.thumb_up, size: 16, color: successColor),
                  SizedBox(width: spXs),
                  Text(
                    "${article["helpful"]}% helpful",
                    style: TextStyle(
                      fontSize: 14,
                      color: successColor,
                    ),
                  ),
                ],
              ),
              Divider(),
              Text("${article["content"]}"),
              SizedBox(height: spSm),
              Wrap(
                spacing: spXs,
                children: (article["tags"] as List).map((tag) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "$tag",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ss("Marked as helpful");
            },
            child: Text("Helpful"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help & Support"),
        actions: [
          IconButton(
            icon: Icon(Icons.headset_mic),
            onPressed: () => _handleQuickAction("contact"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search
            Row(
              children: [
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
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {
                    si("Searching for: $searchQuery");
                  },
                ),
              ],
            ),

            // Category Filter
            QDropdownField(
              label: "Category",
              items: helpCategories,
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            // Quick Actions
            Container(
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
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: quickActions.map((action) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: Border.all(color: disabledOutlineBorderColor),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: InkWell(
                          onTap: () => _handleQuickAction("${action["action"]}"),
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Column(
                            spacing: spSm,
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: (action["color"] as Color).withAlpha(20),
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
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "${action["subtitle"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                                textAlign: TextAlign.center,
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

            // Help Articles
            Container(
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
                      Expanded(
                        child: Text(
                          "Help Articles",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "${filteredArticles.length} articles",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  if (filteredArticles.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spLg),
                      alignment: Alignment.center,
                      child: Column(
                        spacing: spSm,
                        children: [
                          Icon(Icons.search_off, size: 48, color: disabledColor),
                          Text(
                            "No articles found",
                            style: TextStyle(
                              fontSize: 16,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Try adjusting your search or category filter",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  else
                    ...filteredArticles.map((article) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: Border.all(color: disabledOutlineBorderColor),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: InkWell(
                          onTap: () => _openArticle(article),
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.help_outline,
                                  color: primaryColor,
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
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Row(
                                      children: [
                                        Icon(Icons.visibility, size: 14, color: disabledBoldColor),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${article["views"]} views",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Icon(Icons.thumb_up, size: 14, color: successColor),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${article["helpful"]}%",
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
                ],
              ),
            ),

            // Additional Support
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: infoColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Still need help?",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Our support team is available 24/7 to help you with any questions or issues you might have.",
                    style: TextStyle(
                      fontSize: 14,
                      color: infoColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Contact Support",
                          onPressed: () => _handleQuickAction("contact"),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Live Chat",
                          onPressed: () => _handleQuickAction("chat"),
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
