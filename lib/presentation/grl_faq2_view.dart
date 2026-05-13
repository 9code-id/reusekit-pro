import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFaq2View extends StatefulWidget {
  @override
  State<GrlFaq2View> createState() => _GrlFaq2ViewState();
}

class _GrlFaq2ViewState extends State<GrlFaq2View> {
  String selectedTab = "popular";
  String searchQuery = "";
  
  List<Map<String, dynamic>> popularFaqs = [
    {
      "id": 1,
      "question": "How do I create a new account?",
      "answer": "To create a new account, click the 'Sign Up' button on the login page. Fill in your email, create a password, and verify your email address. You'll receive a confirmation email within a few minutes.",
      "category": "Getting Started",
      "views": 3420,
      "rating": 4.8,
      "lastUpdated": "2 days ago",
    },
    {
      "id": 2,
      "question": "What are the system requirements?",
      "answer": "Our app works on iOS 12.0+ and Android 8.0+. For web access, we recommend Chrome 90+, Safari 14+, or Firefox 88+. You'll need at least 2GB RAM and 500MB storage space.",
      "category": "Technical",
      "views": 2156,
      "rating": 4.6,
      "lastUpdated": "1 week ago",
    },
    {
      "id": 3,
      "question": "How do I upgrade my plan?",
      "answer": "Go to Settings > Subscription to view available plans. Select your desired plan and follow the payment process. Your upgrade will be active immediately, and you'll be charged prorated for the current billing period.",
      "category": "Billing",
      "views": 1834,
      "rating": 4.7,
      "lastUpdated": "3 days ago",
    },
    {
      "id": 4,
      "question": "Can I use the app offline?",
      "answer": "Yes, most features work offline. Your data will sync automatically when you reconnect to the internet. However, some features like real-time collaboration require an internet connection.",
      "category": "Features",
      "views": 1643,
      "rating": 4.5,
      "lastUpdated": "5 days ago",
    },
    {
      "id": 5,
      "question": "How do I backup my data?",
      "answer": "Your data is automatically backed up to the cloud every 24 hours. You can also manually backup by going to Settings > Data & Privacy > Backup Now. We keep backups for 30 days.",
      "category": "Data & Privacy",
      "views": 1234,
      "rating": 4.9,
      "lastUpdated": "1 day ago",
    },
  ];

  List<Map<String, dynamic>> recentFaqs = [
    {
      "id": 6,
      "question": "New feature: Dark mode settings",
      "answer": "We've added a dark mode! Go to Settings > Appearance > Theme and choose between Light, Dark, or System (follows your device settings). Dark mode helps reduce eye strain in low-light conditions.",
      "category": "New Features",
      "views": 567,
      "rating": 4.8,
      "lastUpdated": "1 day ago",
      "isNew": true,
    },
    {
      "id": 7,
      "question": "How to use the new AI assistant?",
      "answer": "Our AI assistant can help you with common tasks. Click the chat icon in the bottom right corner, type your question, and get instant answers. The AI learns from your usage patterns to provide better suggestions.",
      "category": "AI Features",
      "views": 423,
      "rating": 4.6,
      "lastUpdated": "2 days ago",
      "isNew": true,
    },
    {
      "id": 8,
      "question": "Updated privacy policy changes",
      "answer": "We've updated our privacy policy to be more transparent about data usage. Key changes include clearer explanations of data collection, new opt-out options, and enhanced security measures. Review the changes in Settings > Privacy.",
      "category": "Privacy",
      "views": 289,
      "rating": 4.4,
      "lastUpdated": "3 days ago",
    },
    {
      "id": 9,
      "question": "How to migrate data from old version?",
      "answer": "If you're upgrading from version 1.x, your data will migrate automatically. For manual migration, export your data from the old app (Settings > Export) and import it in the new version (Settings > Import).",
      "category": "Migration",
      "views": 178,
      "rating": 4.3,
      "lastUpdated": "4 days ago",
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"name": "Getting Started", "count": 12, "icon": Icons.play_arrow, "color": successColor},
    {"name": "Account & Profile", "count": 8, "icon": Icons.person, "color": primaryColor},
    {"name": "Billing & Plans", "count": 6, "icon": Icons.payment, "color": warningColor},
    {"name": "Technical Support", "count": 10, "icon": Icons.build, "color": dangerColor},
    {"name": "Features & Usage", "count": 15, "icon": Icons.star, "color": infoColor},
    {"name": "Data & Privacy", "count": 7, "icon": Icons.security, "color": successColor},
  ];

  List<Map<String, dynamic>> get currentFaqs {
    return selectedTab == "popular" ? popularFaqs : recentFaqs;
  }

  List<Map<String, dynamic>> get filteredFaqs {
    if (searchQuery.isEmpty) return currentFaqs;
    
    return currentFaqs.where((faq) {
      String question = (faq["question"] as String).toLowerCase();
      String answer = (faq["answer"] as String).toLowerCase();
      String category = (faq["category"] as String).toLowerCase();
      String search = searchQuery.toLowerCase();
      
      return question.contains(search) || 
             answer.contains(search) || 
             category.contains(search);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help Center"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              // navigateTo(BookmarkedFaqsView());
            },
          ),
          IconButton(
            icon: Icon(Icons.feedback),
            onPressed: () {
              // navigateTo(FeedbackView());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Header with Search
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
                Text(
                  "How can we help you?",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Search our knowledge base or browse by category",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
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
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search for answers...",
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
                      Container(
                        padding: EdgeInsets.all(spSm),
                        child: Icon(
                          Icons.search,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Tab Navigation
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "popular";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spMd),
                      decoration: BoxDecoration(
                        color: selectedTab == "popular" ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: selectedTab == "popular" ? primaryColor : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.trending_up,
                            size: 18,
                            color: selectedTab == "popular" ? Colors.white : primaryColor,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Most Popular",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: selectedTab == "popular" ? Colors.white : primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "recent";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spMd),
                      decoration: BoxDecoration(
                        color: selectedTab == "recent" ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: selectedTab == "recent" ? primaryColor : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 18,
                            color: selectedTab == "recent" ? Colors.white : primaryColor,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Recently Added",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: selectedTab == "recent" ? Colors.white : primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: searchQuery.isEmpty && selectedTab == "popular" 
                ? _buildPopularContent()
                : _buildFaqList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Quick Stats
          Container(
            margin: EdgeInsets.symmetric(horizontal: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: infoColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Over 10,000 questions answered this month",
                    style: TextStyle(
                      fontSize: 14,
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Categories Grid
          Padding(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Browse by Category",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ResponsiveGridView(
                  minItemWidth: 200,
                  children: categories.map((category) => GestureDetector(
                    onTap: () {
                      // navigateTo(CategoryFaqsView(category: category["name"]));
                    },
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Column(
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
                                  category["icon"],
                                  color: category["color"],
                                  size: 20,
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: (category["color"] as Color).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${category["count"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: category["color"],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spMd),
                          Text(
                            "${category["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${category["count"]} articles",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
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
          
          SizedBox(height: spLg),
          
          // Top FAQs
          _buildFaqList(),
        ],
      ),
    );
  }

  Widget _buildFaqList() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (searchQuery.isNotEmpty) ...[
            Text(
              "${filteredFaqs.length} results for \"$searchQuery\"",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spMd),
          ] else ...[
            Text(
              selectedTab == "popular" ? "Most Popular Questions" : "Recently Added",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
          ],
          
          if (filteredFaqs.isEmpty)
            _buildEmptyState()
          else
            ...filteredFaqs.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> faq = entry.value;
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  children: [
                    // FAQ Header
                    GestureDetector(
                      onTap: () {
                        // navigateTo(FaqDetailView(faq: faq));
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                if (selectedTab == "popular")
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor,
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
                                if (faq["isNew"] == true)
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
                                      "NEW",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                if (selectedTab == "popular" || faq["isNew"] == true)
                                  SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${faq["category"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 14,
                                      color: warningColor,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "${faq["rating"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: warningColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${faq["question"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${faq["answer"]}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
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
                                  Icons.visibility,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${faq["views"]} views",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Icon(
                                  Icons.update,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${faq["lastUpdated"]}",
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
                  ],
                ),
              );
            }).toList(),
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
              "No matching results",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "Try a different search term or browse our categories",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
