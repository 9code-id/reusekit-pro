import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFaq7View extends StatefulWidget {
  @override
  State<GrlFaq7View> createState() => _GrlFaq7ViewState();
}

class _GrlFaq7ViewState extends State<GrlFaq7View> {
  String searchQuery = "";
  String selectedDifficulty = "all";
  List<String> recentlyViewed = ["3", "7", "12"];
  
  List<Map<String, dynamic>> featuredTopics = [
    {
      "id": "getting-started",
      "title": "Getting Started Guide",
      "description": "Everything you need to know to begin your journey",
      "icon": Icons.rocket_launch,
      "color": successColor,
      "faqCount": 8,
      "avgReadTime": "3 min"
    },
    {
      "id": "troubleshooting",
      "title": "Common Issues",
      "description": "Quick solutions to frequently encountered problems",
      "icon": Icons.build,
      "color": dangerColor,
      "faqCount": 12,
      "avgReadTime": "4 min"
    },
    {
      "id": "advanced-features",
      "title": "Advanced Features",
      "description": "Unlock the full potential with expert-level guides",
      "icon": Icons.settings,
      "color": warningColor,
      "faqCount": 6,
      "avgReadTime": "7 min"
    },
    {
      "id": "billing-account",
      "title": "Billing & Account",
      "description": "Manage your subscription and account settings",
      "icon": Icons.account_balance_wallet,
      "color": infoColor,
      "faqCount": 10,
      "avgReadTime": "2 min"
    },
  ];

  List<Map<String, dynamic>> allFaqs = [
    {
      "id": "1",
      "title": "How do I create my first project?",
      "description": "Step-by-step guide to creating and setting up your first project",
      "difficulty": "Beginner",
      "readTime": "3 min",
      "category": "getting-started",
      "isPopular": true,
      "lastUpdated": "1 day ago"
    },
    {
      "id": "2",
      "title": "Understanding project templates",
      "description": "Learn about different templates and when to use them",
      "difficulty": "Beginner",
      "readTime": "4 min",
      "category": "getting-started",
      "isPopular": false,
      "lastUpdated": "3 days ago"
    },
    {
      "id": "3",
      "title": "Setting up team collaboration",
      "description": "Configure team permissions and collaboration features",
      "difficulty": "Intermediate",
      "readTime": "5 min",
      "category": "getting-started",
      "isPopular": true,
      "lastUpdated": "2 days ago"
    },
    {
      "id": "4",
      "title": "App crashes on startup",
      "description": "Troubleshoot and fix common startup issues",
      "difficulty": "Intermediate",
      "readTime": "4 min",
      "category": "troubleshooting",
      "isPopular": true,
      "lastUpdated": "1 day ago"
    },
    {
      "id": "5",
      "title": "Sync issues between devices",
      "description": "Resolve data synchronization problems",
      "difficulty": "Intermediate",
      "readTime": "3 min",
      "category": "troubleshooting",
      "isPopular": false,
      "lastUpdated": "4 days ago"
    },
    {
      "id": "6",
      "title": "Performance optimization",
      "description": "Improve app performance and reduce loading times",
      "difficulty": "Advanced",
      "readTime": "8 min",
      "category": "troubleshooting",
      "isPopular": false,
      "lastUpdated": "1 week ago"
    },
    {
      "id": "7",
      "title": "API integration guide",
      "description": "Connect external services using our API",
      "difficulty": "Advanced",
      "readTime": "10 min",
      "category": "advanced-features",
      "isPopular": true,
      "lastUpdated": "2 days ago"
    },
    {
      "id": "8",
      "title": "Custom workflows and automation",
      "description": "Create automated workflows for repetitive tasks",
      "difficulty": "Advanced",
      "readTime": "12 min",
      "category": "advanced-features",
      "isPopular": false,
      "lastUpdated": "5 days ago"
    },
    {
      "id": "9",
      "title": "Advanced reporting features",
      "description": "Generate detailed reports and analytics",
      "difficulty": "Advanced",
      "readTime": "6 min",
      "category": "advanced-features",
      "isPopular": false,
      "lastUpdated": "1 week ago"
    },
    {
      "id": "10",
      "title": "Subscription plans comparison",
      "description": "Choose the right plan for your needs",
      "difficulty": "Beginner",
      "readTime": "2 min",
      "category": "billing-account",
      "isPopular": true,
      "lastUpdated": "1 day ago"
    },
    {
      "id": "11",
      "title": "Payment methods and billing",
      "description": "Manage payment options and billing preferences",
      "difficulty": "Beginner",
      "readTime": "3 min",
      "category": "billing-account",
      "isPopular": false,
      "lastUpdated": "2 days ago"
    },
    {
      "id": "12",
      "title": "Account security settings",
      "description": "Protect your account with security features",
      "difficulty": "Intermediate",
      "readTime": "4 min",
      "category": "billing-account",
      "isPopular": true,
      "lastUpdated": "3 days ago"
    },
  ];

  List<Map<String, dynamic>> get filteredFaqs {
    List<Map<String, dynamic>> filtered = allFaqs;
    
    if (selectedDifficulty != "all") {
      filtered = filtered.where((faq) => 
          (faq["difficulty"] as String).toLowerCase() == selectedDifficulty.toLowerCase()
      ).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((faq) {
        String title = (faq["title"] as String).toLowerCase();
        String description = (faq["description"] as String).toLowerCase();
        String search = searchQuery.toLowerCase();
        
        return title.contains(search) || description.contains(search);
      }).toList();
    }
    
    return filtered;
  }

  List<Map<String, dynamic>> get popularFaqs {
    return allFaqs.where((faq) => faq["isPopular"] == true).toList();
  }

  List<Map<String, dynamic>> get recentlyViewedFaqs {
    return allFaqs.where((faq) => recentlyViewed.contains(faq["id"])).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help Documentation"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              _showRecentlyViewed();
            },
          ),
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              // navigateTo(ContactSupportView());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(200)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.menu_book,
                      color: Colors.white,
                      size: 28,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Documentation Center",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Find answers, guides, and tutorials",
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
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: spMd),
                        child: Icon(
                          Icons.search,
                          color: disabledBoldColor,
                          size: 20,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search documentation...",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: spMd),
                          ),
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      if (searchQuery.isNotEmpty)
                        GestureDetector(
                          onTap: () {
                            searchQuery = "";
                            setState(() {});
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: spMd),
                            child: Icon(
                              Icons.clear,
                              color: disabledBoldColor,
                              size: 20,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Filter Bar
          if (searchQuery.isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              child: Row(
                children: [
                  Text(
                    "Filter by difficulty:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: QHorizontalScroll(
                      children: ["all", "beginner", "intermediate", "advanced"].map((difficulty) {
                        bool isSelected = selectedDifficulty == difficulty;
                        return GestureDetector(
                          onTap: () {
                            selectedDifficulty = difficulty;
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: spSm),
                            padding: EdgeInsets.symmetric(
                              horizontal: spMd,
                              vertical: spSm,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : Colors.white,
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              ),
                            ),
                            child: Text(
                              difficulty.toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : primaryColor,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

          // Content
          Expanded(
            child: searchQuery.isEmpty ? _buildMainContent() : _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Featured Topics
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Browse by Topic",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ResponsiveGridView(
                  minItemWidth: 200,
                  children: featuredTopics.map((topic) => GestureDetector(
                    onTap: () {
                      _showTopicDetail(topic);
                    },
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowMd],
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spMd),
                                decoration: BoxDecoration(
                                  color: (topic["color"] as Color).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Icon(
                                  topic["icon"],
                                  color: topic["color"],
                                  size: 24,
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: (topic["color"] as Color).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${topic["faqCount"]} articles",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: topic["color"],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spMd),
                          Text(
                            topic["title"],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            topic["description"],
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              height: 1.4,
                            ),
                          ),
                          SizedBox(height: spMd),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Avg ${topic["avgReadTime"]} read",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward,
                                size: 16,
                                color: primaryColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),

          // Popular Articles
          Container(
            margin: EdgeInsets.symmetric(horizontal: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      color: successColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Popular Articles",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                ...popularFaqs.take(3).map((faq) => Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  child: GestureDetector(
                    onTap: () {
                      _viewFaq(faq);
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: successColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                faq["title"],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${faq["readTime"]} • ${faq["difficulty"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: successColor,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                )).toList(),
                if (popularFaqs.length > 3) ...[
                  SizedBox(height: spSm),
                  GestureDetector(
                    onTap: () {
                      _showAllPopular();
                    },
                    child: Text(
                      "View all ${popularFaqs.length} popular articles →",
                      style: TextStyle(
                        fontSize: 14,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Recently Viewed
          if (recentlyViewedFaqs.isNotEmpty) ...[
            SizedBox(height: spMd),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.history,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Recently Viewed",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          _showRecentlyViewed();
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            color: infoColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  QHorizontalScroll(
                    children: recentlyViewedFaqs.map((faq) => Container(
                      width: 250,
                      margin: EdgeInsets.only(right: spMd),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          _viewFaq(faq);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getDifficultyColor(faq["difficulty"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    faq["difficulty"],
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: _getDifficultyColor(faq["difficulty"]),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.access_time,
                                  size: 12,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  faq["readTime"],
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spMd),
                            Text(
                              faq["title"],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              faq["description"],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )).toList(),
                  ),
                ],
              ),
            ),
          ],

          SizedBox(height: spLg),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${filteredFaqs.length} results found for \"$searchQuery\"",
              style: TextStyle(
                fontSize: 14,
                color: infoColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          
          SizedBox(height: spMd),
          
          if (filteredFaqs.isEmpty)
            _buildEmptyState()
          else
            ...filteredFaqs.map((faq) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: GestureDetector(
                onTap: () {
                  _viewFaq(faq);
                },
                child: Padding(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getCategoryColor(faq["category"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              _getCategoryName(faq["category"]),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: _getCategoryColor(faq["category"]),
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getDifficultyColor(faq["difficulty"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              faq["difficulty"],
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: _getDifficultyColor(faq["difficulty"]),
                              ),
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            faq["readTime"],
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spMd),
                      Text(
                        faq["title"],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        faq["description"],
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: spMd),
                      Row(
                        children: [
                          Text(
                            "Updated ${faq["lastUpdated"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: primaryColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )).toList(),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
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
              "No results found",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "Try different keywords or browse our topics",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spMd),
            QButton(
              label: "Browse Topics",
              onPressed: () {
                searchQuery = "";
                selectedDifficulty = "all";
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  void _viewFaq(Map<String, dynamic> faq) {
    if (!recentlyViewed.contains(faq["id"])) {
      recentlyViewed.insert(0, faq["id"]);
      if (recentlyViewed.length > 5) {
        recentlyViewed.removeLast();
      }
      setState(() {});
    }
    // navigateTo(FaqDetailView(faq: faq));
  }

  void _showTopicDetail(Map<String, dynamic> topic) {
    List<Map<String, dynamic>> topicFaqs = allFaqs
        .where((faq) => faq["category"] == topic["id"])
        .toList();
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiusLg),
            topRight: Radius.circular(radiusLg),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: spSm),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: (topic["color"] as Color).withAlpha(20),
                border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
              ),
              child: Row(
                children: [
                  Icon(topic["icon"], color: topic["color"]),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          topic["title"],
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${topicFaqs.length} articles available",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, color: disabledBoldColor),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(spMd),
                itemCount: topicFaqs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> faq = topicFaqs[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        _viewFaq(faq);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getDifficultyColor(faq["difficulty"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  faq["difficulty"],
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: _getDifficultyColor(faq["difficulty"]),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Text(
                                faq["readTime"],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            faq["title"],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            faq["description"],
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAllPopular() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiusLg),
            topRight: Radius.circular(radiusLg),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: spSm),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
              ),
              child: Row(
                children: [
                  Icon(Icons.trending_up, color: successColor),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Popular Articles (${popularFaqs.length})",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, color: disabledBoldColor),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(spMd),
                itemCount: popularFaqs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> faq = popularFaqs[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        _viewFaq(faq);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "#${index + 1}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getDifficultyColor(faq["difficulty"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  faq["difficulty"],
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: _getDifficultyColor(faq["difficulty"]),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Text(
                                faq["readTime"],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            faq["title"],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            faq["description"],
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRecentlyViewed() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiusLg),
            topRight: Radius.circular(radiusLg),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: spSm),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
              ),
              child: Row(
                children: [
                  Icon(Icons.history, color: infoColor),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Recently Viewed (${recentlyViewedFaqs.length})",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      recentlyViewed.clear();
                      setState(() {});
                      Navigator.pop(context);
                      ss("History cleared");
                    },
                    child: Text(
                      "Clear All",
                      style: TextStyle(
                        fontSize: 14,
                        color: dangerColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: spMd),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, color: disabledBoldColor),
                  ),
                ],
              ),
            ),
            Expanded(
              child: recentlyViewedFaqs.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.history,
                            size: 48,
                            color: disabledColor,
                          ),
                          SizedBox(height: spMd),
                          Text(
                            "No recent articles",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Your reading history will appear here",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(spMd),
                      itemCount: recentlyViewedFaqs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> faq = recentlyViewedFaqs[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: spMd),
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(color: disabledOutlineBorderColor),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              _viewFaq(faq);
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        faq["title"],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${faq["difficulty"]} • ${faq["readTime"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: primaryColor,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCategoryName(String categoryId) {
    switch (categoryId) {
      case "getting-started":
        return "Getting Started";
      case "troubleshooting":
        return "Troubleshooting";
      case "advanced-features":
        return "Advanced";
      case "billing-account":
        return "Billing";
      default:
        return "General";
    }
  }

  Color _getCategoryColor(String categoryId) {
    switch (categoryId) {
      case "getting-started":
        return successColor;
      case "troubleshooting":
        return dangerColor;
      case "advanced-features":
        return warningColor;
      case "billing-account":
        return infoColor;
      default:
        return primaryColor;
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case "beginner":
        return successColor;
      case "intermediate":
        return warningColor;
      case "advanced":
        return dangerColor;
      default:
        return primaryColor;
    }
  }
}
