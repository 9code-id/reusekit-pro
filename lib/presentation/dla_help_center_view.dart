import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaHelpCenterView extends StatefulWidget {
  const DlaHelpCenterView({Key? key}) : super(key: key);

  @override
  State<DlaHelpCenterView> createState() => _DlaHelpCenterViewState();
}

class _DlaHelpCenterViewState extends State<DlaHelpCenterView> {
  String searchQuery = "";
  String selectedCategory = "All";

  List<Map<String, dynamic>> helpArticles = [
    {
      "id": "HA001",
      "title": "Getting Started with Delivery App",
      "category": "Getting Started",
      "readTime": "5 min read",
      "popularity": 95,
      "lastUpdated": "2024-01-10T00:00:00",
      "content": "Welcome to the delivery app! This comprehensive guide will help you get started with your first deliveries. Learn about navigation, customer communication, and reporting features.",
      "tags": ["beginner", "setup", "basics"],
      "helpful": 89,
      "views": 1245,
    },
    {
      "id": "HA002",
      "title": "Optimizing Your Delivery Routes",
      "category": "Route Planning",
      "readTime": "8 min read",
      "popularity": 87,
      "lastUpdated": "2024-01-12T00:00:00",
      "content": "Learn advanced techniques for route optimization to maximize efficiency and reduce delivery times. Includes tips on traffic patterns, customer preferences, and fuel efficiency.",
      "tags": ["efficiency", "routes", "optimization"],
      "helpful": 76,
      "views": 987,
    },
    {
      "id": "HA003",
      "title": "Customer Communication Best Practices",
      "category": "Customer Service",
      "readTime": "6 min read",
      "popularity": 92,
      "lastUpdated": "2024-01-08T00:00:00",
      "content": "Master the art of professional customer communication. Learn when and how to contact customers, handle difficult situations, and maintain high satisfaction ratings.",
      "tags": ["communication", "customer service", "professionalism"],
      "helpful": 94,
      "views": 1156,
    },
    {
      "id": "HA004",
      "title": "Safety Protocols for Delivery Drivers",
      "category": "Safety",
      "readTime": "10 min read",
      "popularity": 88,
      "lastUpdated": "2024-01-05T00:00:00",
      "content": "Comprehensive safety guidelines covering vehicle safety, personal protection, dangerous weather conditions, and emergency procedures. Your safety is our priority.",
      "tags": ["safety", "emergency", "protocols"],
      "helpful": 82,
      "views": 823,
    },
    {
      "id": "HA005",
      "title": "Understanding Performance Metrics",
      "category": "Performance",
      "readTime": "7 min read",
      "popularity": 79,
      "lastUpdated": "2024-01-15T00:00:00",
      "content": "Learn how performance metrics are calculated and how to improve your ratings. Understand delivery completion rates, customer feedback, and efficiency scores.",
      "tags": ["metrics", "performance", "improvement"],
      "helpful": 71,
      "views": 654,
    },
    {
      "id": "HA006",
      "title": "Vehicle Maintenance Checklist",
      "category": "Vehicle Management",
      "readTime": "4 min read",
      "popularity": 84,
      "lastUpdated": "2024-01-11T00:00:00",
      "content": "Daily, weekly, and monthly vehicle maintenance checklist to keep your delivery vehicle in optimal condition. Prevent breakdowns and ensure safety.",
      "tags": ["maintenance", "vehicle", "checklist"],
      "helpful": 78,
      "views": 756,
    },
  ];

  List<Map<String, dynamic>> quickGuides = [
    {
      "id": "QG001",
      "title": "How to Mark a Delivery as Complete",
      "steps": [
        "Navigate to active delivery in your route",
        "Take photo proof of delivery if required",
        "Get customer signature or confirmation",
        "Tap 'Mark as Delivered' button",
        "Add any delivery notes if needed",
        "Confirm completion"
      ],
      "estimatedTime": "2 minutes",
      "difficulty": "Easy",
    },
    {
      "id": "QG002",
      "title": "Reporting a Package Damage",
      "steps": [
        "Stop delivery process immediately",
        "Take photos of damaged package",
        "Document damage details in app",
        "Contact customer to inform about damage",
        "Contact dispatch for next steps",
        "Complete incident report"
      ],
      "estimatedTime": "5 minutes",
      "difficulty": "Medium",
    },
    {
      "id": "QG003",
      "title": "Handling Customer Not Available",
      "steps": [
        "Attempt delivery at scheduled time",
        "Wait 5 minutes for customer response",
        "Try calling customer phone number",
        "Leave delivery notice if applicable",
        "Mark delivery as failed in app",
        "Schedule retry or return to depot"
      ],
      "estimatedTime": "10 minutes",
      "difficulty": "Easy",
    },
    {
      "id": "QG004",
      "title": "Emergency Contact Procedures",
      "steps": [
        "Assess the emergency situation",
        "Ensure personal safety first",
        "Call 911 if immediate danger",
        "Contact emergency dispatch center",
        "Provide location and situation details",
        "Follow dispatcher instructions",
        "Complete incident documentation"
      ],
      "estimatedTime": "Varies",
      "difficulty": "Critical",
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
               "${article["content"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
               (article["tags"] as List).any((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()));
      }).toList();
    }

    // Sort by popularity
    filtered.sort((a, b) => (b["popularity"] as int).compareTo(a["popularity"] as int));

    return filtered;
  }

  List<Map<String, dynamic>> get filteredGuides {
    if (searchQuery.isEmpty) return quickGuides;
    
    return quickGuides.where((guide) {
      return "${guide["title"]}".toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Easy":
        return successColor;
      case "Medium":
        return warningColor;
      case "Hard":
        return dangerColor;
      case "Critical":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  List<String> get categories {
    Set<String> categorySet = helpArticles.map((article) => article["category"] as String).toSet();
    List<String> categories = ["All"] + categorySet.toList();
    categories.sort();
    return categories;
  }

  void _showArticleDetails(Map<String, dynamic> article) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${article["title"]}",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, color: disabledBoldColor),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${article["category"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: spXs),
                Icon(Icons.schedule, color: disabledBoldColor, size: 14),
                SizedBox(width: spXs),
                Text(
                  "${article["readTime"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                Icon(Icons.visibility, color: disabledBoldColor, size: 14),
                SizedBox(width: spXs),
                Text(
                  "${article["views"]} views",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${article["content"]}",
                      style: TextStyle(
                        fontSize: 15,
                        color: primaryColor,
                        height: 1.6,
                      ),
                    ),
                    SizedBox(height: spLg),
                    Text(
                      "Tags:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (article["tags"] as List).map((tag) => Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                          border: Border.all(color: infoColor.withAlpha(100)),
                        ),
                        child: Text(
                          "#$tag",
                          style: TextStyle(
                            fontSize: 11,
                            color: infoColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )).toList(),
                    ),
                    SizedBox(height: spLg),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Was this article helpful?",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          QButton(
                            icon: Icons.thumb_up,
                            size: bs.sm,
                            onPressed: () => ss("Marked as helpful"),
                          ),
                          SizedBox(width: spXs),
                          QButton(
                            icon: Icons.thumb_down,
                            size: bs.sm,
                            onPressed: () => ss("Feedback sent"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(Icons.update, color: disabledBoldColor, size: 14),
                        SizedBox(width: spXs),
                        Text(
                          "Last updated: ${DateTime.parse("${article["lastUpdated"]}").dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showGuideDetails(Map<String, dynamic> guide) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${guide["title"]}",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, color: disabledBoldColor),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getDifficultyColor("${guide["difficulty"]}").withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${guide["difficulty"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: _getDifficultyColor("${guide["difficulty"]}"),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Icon(Icons.schedule, color: disabledBoldColor, size: 14),
                SizedBox(width: spXs),
                Text(
                  "${guide["estimatedTime"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Step-by-Step Instructions:",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...(guide["steps"] as List).asMap().entries.map((entry) {
                      int index = entry.key;
                      String step = entry.value;
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                          border: Border(
                            left: BorderSide(
                              width: 3,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Center(
                                child: Text(
                                  "${index + 1}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                step,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Help Center",
      selectedIndex: 0,
      tabs: [
        Tab(text: "Articles", icon: Icon(Icons.article)),
        Tab(text: "Quick Guides", icon: Icon(Icons.list)),
      ],
      tabChildren: [
        _buildArticlesTab(),
        _buildGuidesTab(),
      ],
    );
  }

  Widget _buildArticlesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QTextField(
            label: "Search articles...",
            value: searchQuery,
            hint: "Title, content, or tags",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QCategoryPicker(
            label: "Category",
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
          SizedBox(height: spMd),
          Row(
            children: [
              Text(
                "${filteredArticles.length} articles",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "Sorted by popularity",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...filteredArticles.map((article) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: primaryColor,
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
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: successColor, size: 12),
                          SizedBox(width: 2),
                          Text(
                            "${article["popularity"]}%",
                            style: TextStyle(
                              fontSize: 10,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${article["category"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "${article["content"]}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(Icons.schedule, color: disabledBoldColor, size: 14),
                    SizedBox(width: spXs),
                    Text(
                      "${article["readTime"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.thumb_up, color: successColor, size: 14),
                    SizedBox(width: spXs),
                    Text(
                      "${article["helpful"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.visibility, color: disabledBoldColor, size: 14),
                    SizedBox(width: spXs),
                    Text(
                      "${article["views"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Read Article",
                    size: bs.sm,
                    onPressed: () => _showArticleDetails(article),
                  ),
                ),
              ],
            ),
          )).toList(),
          if (filteredArticles.isEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(
                    Icons.article,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "No articles found",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Try adjusting your search or category filter",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildGuidesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QTextField(
            label: "Search quick guides...",
            value: searchQuery,
            hint: "Guide title or topic",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor),
            ),
            child: Row(
              children: [
                Icon(Icons.flash_on, color: infoColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Quick step-by-step guides for common delivery tasks and situations.",
                    style: TextStyle(
                      color: infoColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          ...filteredGuides.map((guide) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: _getDifficultyColor("${guide["difficulty"]}"),
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
                        "${guide["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getDifficultyColor("${guide["difficulty"]}").withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${guide["difficulty"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: _getDifficultyColor("${guide["difficulty"]}"),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(Icons.list, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${(guide["steps"] as List).length} steps",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.schedule, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${guide["estimatedTime"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "View Guide",
                    icon: Icons.play_arrow,
                    size: bs.sm,
                    onPressed: () => _showGuideDetails(guide),
                  ),
                ),
              ],
            ),
          )).toList(),
          if (filteredGuides.isEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "No guides found",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Try adjusting your search terms",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
