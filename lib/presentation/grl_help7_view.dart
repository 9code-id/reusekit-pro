import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHelp7View extends StatefulWidget {
  @override
  State<GrlHelp7View> createState() => _GrlHelp7ViewState();
}

class _GrlHelp7ViewState extends State<GrlHelp7View> {
  String searchQuery = "";
  String selectedCategory = "all";
  
  List<Map<String, dynamic>> articleCategories = [
    {"label": "All Articles", "value": "all"},
    {"label": "Getting Started", "value": "getting_started"},
    {"label": "Account", "value": "account"},
    {"label": "Technical", "value": "technical"},
    {"label": "Billing", "value": "billing"},
    {"label": "Features", "value": "features"},
  ];

  List<Map<String, dynamic>> knowledgeArticles = [
    {
      "id": 1,
      "title": "How to Set Up Your Account",
      "category": "getting_started",
      "content": "Welcome to our platform! Setting up your account is easy and takes just a few minutes. Follow these simple steps to get started...",
      "tags": ["setup", "account", "getting started", "beginner"],
      "views": 5234,
      "helpful": 152,
      "notHelpful": 8,
      "lastUpdated": DateTime.now().subtract(Duration(days: 5)),
      "readTime": "3 min read",
      "difficulty": "Beginner",
      "author": "Support Team"
    },
    {
      "id": 2,
      "title": "Understanding Your Dashboard",
      "category": "features",
      "content": "Your dashboard is the central hub of your account. Here's a comprehensive guide to understanding all the features and how to use them effectively...",
      "tags": ["dashboard", "features", "navigation", "overview"],
      "views": 4567,
      "helpful": 134,
      "notHelpful": 12,
      "lastUpdated": DateTime.now().subtract(Duration(days: 2)),
      "readTime": "5 min read",
      "difficulty": "Intermediate",
      "author": "Product Team"
    },
    {
      "id": 3,
      "title": "Troubleshooting Common Issues",
      "category": "technical",
      "content": "Experiencing technical difficulties? This guide covers the most common issues users face and provides step-by-step solutions...",
      "tags": ["troubleshooting", "issues", "technical", "help"],
      "views": 3892,
      "helpful": 98,
      "notHelpful": 23,
      "lastUpdated": DateTime.now().subtract(Duration(days: 1)),
      "readTime": "7 min read",
      "difficulty": "Advanced",
      "author": "Technical Team"
    },
    {
      "id": 4,
      "title": "Managing Your Subscription",
      "category": "billing",
      "content": "Learn how to manage your subscription, update payment methods, and understand your billing cycle...",
      "tags": ["subscription", "billing", "payment", "account"],
      "views": 3456,
      "helpful": 89,
      "notHelpful": 5,
      "lastUpdated": DateTime.now().subtract(Duration(days: 3)),
      "readTime": "4 min read",
      "difficulty": "Beginner",
      "author": "Billing Team"
    },
    {
      "id": 5,
      "title": "Security Best Practices",
      "category": "account",
      "content": "Keep your account secure with these essential security practices and tips...",
      "tags": ["security", "safety", "account", "best practices"],
      "views": 2876,
      "helpful": 76,
      "notHelpful": 3,
      "lastUpdated": DateTime.now().subtract(Duration(days: 7)),
      "readTime": "6 min read",
      "difficulty": "Intermediate",
      "author": "Security Team"
    },
    {
      "id": 6,
      "title": "Advanced Features Guide",
      "category": "features",
      "content": "Unlock the full potential of our platform with these advanced features and pro tips...",
      "tags": ["advanced", "features", "pro tips", "power user"],
      "views": 2123,
      "helpful": 67,
      "notHelpful": 8,
      "lastUpdated": DateTime.now().subtract(Duration(days: 4)),
      "readTime": "10 min read",
      "difficulty": "Advanced",
      "author": "Product Team"
    },
  ];

  List<Map<String, dynamic>> trendingTopics = [
    {"title": "Account Setup", "count": 156},
    {"title": "Password Reset", "count": 134},
    {"title": "Billing Issues", "count": 98},
    {"title": "Feature Requests", "count": 87},
    {"title": "Technical Support", "count": 76},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredArticles = knowledgeArticles.where((article) {
      bool matchesCategory = selectedCategory == "all" || article["category"] == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty || 
          article["title"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          (article["tags"] as List).any((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()));
      
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Knowledge Base"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              // navigateTo(BookmarkedArticlesView());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              children: [
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search knowledge base...",
                      prefixIcon: Icon(Icons.search, color: primaryColor),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                    ),
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                
                // Category Filter
                QHorizontalScroll(
                  children: articleCategories.map((category) => GestureDetector(
                    onTap: () {
                      selectedCategory = category["value"];
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: spSm),
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: selectedCategory == category["value"] ? primaryColor : Colors.grey[200],
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "${category["label"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: selectedCategory == category["value"] ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
          
          // Results Counter
          if (searchQuery.isNotEmpty || selectedCategory != "all")
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
              ),
              child: Text(
                "${filteredArticles.length} article(s) found",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: infoColor,
                ),
              ),
            ),
          
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (searchQuery.isEmpty && selectedCategory == "all")
                    ...[
                      // Trending Topics
                      Text(
                        "Trending Topics",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spMd),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          children: trendingTopics.map((topic) => Container(
                            margin: EdgeInsets.only(bottom: spMd),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    Icons.trending_up,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Expanded(
                                  child: Text(
                                    "${topic["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: warningColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${topic["count"]} searches",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: warningColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )).toList(),
                        ),
                      ),
                      SizedBox(height: spMd),
                    ],
                  
                  // Articles Section
                  Row(
                    children: [
                      Text(
                        selectedCategory == "all" ? "All Articles" : "Articles",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      if (filteredArticles.isNotEmpty)
                        Text(
                          "${filteredArticles.length} articles",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  if (filteredArticles.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd * 2),
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spMd),
                          Text(
                            "No articles found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Try adjusting your search or category filter",
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spMd),
                          QButton(
                            label: "Contact Support",
                            size: bs.sm,
                            onPressed: () {
                              // navigateTo(ContactSupportView());
                            },
                          ),
                        ],
                      ),
                    )
                  else
                    ...filteredArticles.map((article) => Container(
                      margin: EdgeInsets.only(bottom: spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Article Header
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: _getCategoryColor(article["category"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    _getCategoryIcon(article["category"]),
                                    color: _getCategoryColor(article["category"]),
                                    size: 20,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${article["title"]}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: spSm),
                                      Text(
                                        "${article["content"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    ss("Article bookmarked!");
                                  },
                                  child: Icon(
                                    Icons.bookmark_border,
                                    color: disabledBoldColor,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spMd),
                            
                            // Tags
                            Wrap(
                              spacing: spSm,
                              runSpacing: spSm,
                              children: (article["tags"] as List).take(3).map<Widget>((tag) => Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "#$tag",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )).toList(),
                            ),
                            
                            SizedBox(height: spMd),
                            
                            // Article Metadata
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 12,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${article["author"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Icon(
                                  Icons.schedule,
                                  size: 12,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${article["readTime"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spMd),
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
                            
                            SizedBox(height: spMd),
                            
                            // Stats and Actions
                            Row(
                              children: [
                                Icon(
                                  Icons.visibility,
                                  size: 14,
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
                                SizedBox(width: spMd),
                                Icon(
                                  Icons.thumb_up,
                                  size: 14,
                                  color: successColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${article["helpful"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "Updated ${_getTimeAgo(article["lastUpdated"])}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spMd),
                            
                            // Read Article Button
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: "Read Article",
                                size: bs.sm,
                                onPressed: () {
                                  // navigateTo(ArticleDetailView(article: article));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'getting_started':
        return successColor;
      case 'account':
        return primaryColor;
      case 'technical':
        return dangerColor;
      case 'billing':
        return warningColor;
      case 'features':
        return infoColor;
      default:
        return primaryColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'getting_started':
        return Icons.rocket_launch;
      case 'account':
        return Icons.person;
      case 'technical':
        return Icons.build;
      case 'billing':
        return Icons.payment;
      case 'features':
        return Icons.apps;
      default:
        return Icons.article;
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Beginner':
        return successColor;
      case 'Intermediate':
        return warningColor;
      case 'Advanced':
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 0) {
      return "${difference.inDays} days ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours} hours ago";
    } else {
      return "${difference.inMinutes} minutes ago";
    }
  }
}
