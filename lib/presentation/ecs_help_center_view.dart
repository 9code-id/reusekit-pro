import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsHelpCenterView extends StatefulWidget {
  const EcsHelpCenterView({super.key});

  @override
  State<EcsHelpCenterView> createState() => _EcsHelpCenterViewState();
}

class _EcsHelpCenterViewState extends State<EcsHelpCenterView> {
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> helpCategories = [
    {
      "id": 1,
      "title": "Account & Profile",
      "description": "Manage your account settings and profile",
      "icon": Icons.person,
      "color": 0xFF2196F3,
      "article_count": 12,
      "articles": [
        "How to create an account",
        "Update profile information",
        "Change password",
        "Delete account",
      ],
    },
    {
      "id": 2,
      "title": "Orders & Shipping",
      "description": "Everything about orders and delivery",
      "icon": Icons.local_shipping,
      "color": 0xFF4CAF50,
      "article_count": 18,
      "articles": [
        "Track your order",
        "Shipping options",
        "Delivery issues",
        "Order cancellation",
      ],
    },
    {
      "id": 3,
      "title": "Payment & Billing",
      "description": "Payment methods and billing questions",
      "icon": Icons.payment,
      "color": 0xFFFF9800,
      "article_count": 15,
      "articles": [
        "Add payment method",
        "Payment failed",
        "Refund process",
        "Billing address",
      ],
    },
    {
      "id": 4,
      "title": "Returns & Refunds",
      "description": "Return policies and refund procedures",
      "icon": Icons.replay,
      "color": 0xFFE91E63,
      "article_count": 10,
      "articles": [
        "Return policy",
        "How to return items",
        "Refund timeline",
        "Exchange process",
      ],
    },
    {
      "id": 5,
      "title": "App Features",
      "description": "Learn how to use app features",
      "icon": Icons.phone_android,
      "color": 0xFF9C27B0,
      "article_count": 8,
      "articles": [
        "Search products",
        "Create wishlist",
        "Use filters",
        "App notifications",
      ],
    },
    {
      "id": 6,
      "title": "Troubleshooting",
      "description": "Common issues and solutions",
      "icon": Icons.build,
      "color": 0xFF607D8B,
      "article_count": 14,
      "articles": [
        "App crashes",
        "Login problems",
        "Payment errors",
        "Image loading issues",
      ],
    },
  ];

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Live Chat",
      "subtitle": "Chat with our support team",
      "icon": Icons.chat,
      "color": 0xFF4CAF50,
      "action": "chat",
    },
    {
      "title": "Call Support",
      "subtitle": "Speak with a representative",
      "icon": Icons.phone,
      "color": 0xFF2196F3,
      "action": "call",
    },
    {
      "title": "Email Support",
      "subtitle": "Send us an email",
      "icon": Icons.email,
      "color": 0xFFFF9800,
      "action": "email",
    },
    {
      "title": "Video Tutorials",
      "subtitle": "Watch how-to videos",
      "icon": Icons.play_circle,
      "color": 0xFF9C27B0,
      "action": "videos",
    },
  ];

  List<Map<String, dynamic>> popularArticles = [
    {
      "title": "How to track your order",
      "views": "15.2K views",
      "helpful": 89,
      "category": "Orders & Shipping",
    },
    {
      "title": "Return and refund policy",
      "views": "12.8K views",
      "helpful": 92,
      "category": "Returns & Refunds",
    },
    {
      "title": "Payment methods accepted",
      "views": "10.5K views",
      "helpful": 87,
      "category": "Payment & Billing",
    },
    {
      "title": "How to change your password",
      "views": "8.9K views",
      "helpful": 94,
      "category": "Account & Profile",
    },
    {
      "title": "Delivery time and options",
      "views": "7.3K views",
      "helpful": 85,
      "category": "Orders & Shipping",
    },
  ];

  List<Map<String, dynamic>> get filteredCategories {
    if (searchQuery.isEmpty) return helpCategories;
    return helpCategories.where((category) {
      return category["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
             category["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
             (category["articles"] as List).any((article) => 
               article.toString().toLowerCase().contains(searchQuery.toLowerCase()));
    }).toList();
  }

  void _performQuickAction(String action) {
    switch (action) {
      case "chat":
        si("Opening live chat...");
        break;
      case "call":
        si("Opening phone dialer...");
        break;
      case "email":
        si("Opening email composer...");
        break;
      case "videos":
        si("Opening video tutorials...");
        break;
    }
  }

  Widget _buildHelpCategoryCard(Map<String, dynamic> category) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: GestureDetector(
        onTap: () => si("Navigate to ${category["title"]} articles"),
        child: Container(
          padding: EdgeInsets.all(spSm),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(category["color"] as int).withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  category["icon"] as IconData,
                  color: Color(category["color"] as int),
                  size: 24,
                ),
              ),

              SizedBox(width: spSm),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${category["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "${category["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${category["article_count"]} articles",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(category["color"] as int),
                        fontWeight: FontWeight.w500,
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
      ),
    );
  }

  Widget _buildQuickActionCard(Map<String, dynamic> action) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(right: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: GestureDetector(
        onTap: () => _performQuickAction(action["action"] as String),
        child: Container(
          padding: EdgeInsets.all(spSm),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(action["color"] as int).withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  action["icon"] as IconData,
                  color: Color(action["color"] as int),
                  size: 20,
                ),
              ),
              
              SizedBox(height: spSm),
              
              Text(
                "${action["title"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: 2),
              
              Text(
                "${action["subtitle"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularArticleCard(Map<String, dynamic> article) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: GestureDetector(
        onTap: () => si("Opening article: ${article["title"]}"),
        child: Container(
          padding: EdgeInsets.all(spSm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "${article["title"]}",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: disabledBoldColor,
                    size: 14,
                  ),
                ],
              ),
              
              SizedBox(height: spSm),
              
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${article["category"]}",
                      style: TextStyle(
                        color: infoColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(
                        Icons.visibility,
                        color: disabledColor,
                        size: 12,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "${article["views"]}",
                        style: TextStyle(
                          color: disabledColor,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(
                        Icons.thumb_up,
                        color: successColor,
                        size: 12,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "${article["helpful"]}%",
                        style: TextStyle(
                          color: successColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor,
                    primaryColor.withAlpha(180),
                  ],
                ),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "How can we help you?",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Find answers to common questions or get in touch with our support team",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Search
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search help articles",
                    value: searchQuery,
                    hint: "Search for help topics...",
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
                  onPressed: () => si("Searching for: $searchQuery"),
                ),
              ],
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

            SizedBox(height: spSm),

            QHorizontalScroll(
              children: quickActions.map((action) => _buildQuickActionCard(action)).toList(),
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

            SizedBox(height: spSm),

            if (filteredCategories.isEmpty)
              Center(
                child: Column(
                  children: [
                    SizedBox(height: spXl),
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No Results Found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try searching with different keywords",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              Column(
                children: filteredCategories.map((category) => _buildHelpCategoryCard(category)).toList(),
              ),

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

            SizedBox(height: spSm),

            Column(
              children: popularArticles.map((article) => _buildPopularArticleCard(article)).toList(),
            ),

            SizedBox(height: spMd),

            // Contact Info
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.contact_support,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Still need help?",
                          style: TextStyle(
                            color: infoColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Our support team is available 24/7 to assist you. Contact us via live chat, phone, or email for personalized help.",
                    style: TextStyle(
                      color: infoColor,
                      fontSize: 12,
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
