import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFaq6View extends StatefulWidget {
  @override
  State<GrlFaq6View> createState() => _GrlFaq6ViewState();
}

class _GrlFaq6ViewState extends State<GrlFaq6View> {
  String selectedCategory = "all";
  String searchQuery = "";
  String sortBy = "popular";
  List<String> bookmarkedFaqs = ["2", "5", "8"];
  
  List<Map<String, dynamic>> categories = [
    {"id": "all", "name": "All", "icon": Icons.apps, "count": 15},
    {"id": "basics", "name": "Basics", "icon": Icons.school, "count": 4},
    {"id": "account", "name": "Account", "icon": Icons.person, "count": 3},
    {"id": "premium", "name": "Premium", "icon": Icons.star, "count": 3},
    {"id": "technical", "name": "Technical", "icon": Icons.settings, "count": 3},
    {"id": "mobile", "name": "Mobile", "icon": Icons.phone_android, "count": 2},
  ];

  List<Map<String, dynamic>> faqs = [
    {
      "id": "1",
      "category": "basics",
      "question": "How do I get started with the platform?",
      "answer": "Getting started is simple! First, create your account by clicking 'Sign Up' and verifying your email. Then, complete your profile setup by adding your basic information. Finally, explore our guided tutorial that walks you through all the key features. The onboarding process takes about 5-10 minutes and will help you understand how to make the most of our platform.",
      "tags": ["getting started", "tutorial", "onboarding"],
      "views": 15420,
      "likes": 892,
      "difficulty": "Beginner",
      "lastUpdated": "2 days ago",
      "readTime": "3 min"
    },
    {
      "id": "2",
      "category": "account",
      "question": "How do I reset my password?",
      "answer": "To reset your password, go to the login page and click 'Forgot Password'. Enter your email address and we'll send you a secure reset link. Click the link in your email (check spam folder if needed) and create a new password. For security, passwords must be at least 8 characters long and include numbers and special characters.",
      "tags": ["password", "reset", "security", "login"],
      "views": 12350,
      "likes": 567,
      "difficulty": "Beginner",
      "lastUpdated": "1 week ago",
      "readTime": "2 min"
    },
    {
      "id": "3",
      "category": "premium",
      "question": "What's included in the Premium plan?",
      "answer": "Premium plan includes unlimited projects, advanced analytics, priority support, custom branding, API access, team collaboration tools, automated backups, and access to premium templates. You also get early access to new features and can export data in multiple formats. Premium subscribers receive dedicated account management and 24/7 phone support.",
      "tags": ["premium", "features", "subscription", "benefits"],
      "views": 8930,
      "likes": 445,
      "difficulty": "Beginner",
      "lastUpdated": "3 days ago",
      "readTime": "4 min"
    },
    {
      "id": "4",
      "category": "technical",
      "question": "API rate limits and authentication",
      "answer": "Our API has rate limits of 1000 requests per hour for free accounts and 10,000 for premium accounts. Authentication uses API keys which can be generated in your dashboard under Settings > API Keys. Include the key in the Authorization header: 'Bearer YOUR_API_KEY'. Rate limit resets every hour, and we provide headers showing your current usage and reset time.",
      "tags": ["api", "rate limits", "authentication", "technical"],
      "views": 6720,
      "likes": 234,
      "difficulty": "Advanced",
      "lastUpdated": "5 days ago",
      "readTime": "6 min"
    },
    {
      "id": "5",
      "category": "basics",
      "question": "How do I invite team members?",
      "answer": "To invite team members, go to Settings > Team Management. Click 'Invite Member' and enter their email address. Choose their role (Admin, Editor, or Viewer) and set permissions. They'll receive an invitation email with a secure link to join your team. You can manage member permissions and remove access at any time from the team dashboard.",
      "tags": ["team", "collaboration", "invitation", "permissions"],
      "views": 5430,
      "likes": 312,
      "difficulty": "Intermediate",
      "lastUpdated": "1 day ago",
      "readTime": "3 min"
    },
    {
      "id": "6",
      "category": "mobile",
      "question": "Is there a mobile app available?",
      "answer": "Yes! Our mobile app is available for both iOS and Android. Download it from the App Store or Google Play Store. The mobile app includes most desktop features including project creation, editing, real-time sync, and push notifications. Some advanced features like bulk operations and detailed analytics are desktop-only but will be added to mobile soon.",
      "tags": ["mobile", "app", "ios", "android", "download"],
      "views": 4650,
      "likes": 278,
      "difficulty": "Beginner",
      "lastUpdated": "1 week ago",
      "readTime": "2 min"
    },
    {
      "id": "7",
      "category": "account",
      "question": "How do I delete my account?",
      "answer": "Account deletion is permanent and cannot be undone. Go to Settings > Account > Delete Account. You'll need to confirm by typing 'DELETE' and entering your password. All your data, projects, and files will be permanently removed within 30 days. Before deletion, you can export your data from the Data Export section. Premium subscriptions will be canceled immediately.",
      "tags": ["delete", "account", "permanent", "data"],
      "views": 3280,
      "likes": 89,
      "difficulty": "Advanced",
      "lastUpdated": "2 weeks ago",
      "readTime": "3 min"
    },
    {
      "id": "8",
      "category": "technical",
      "question": "Data backup and recovery options",
      "answer": "We automatically backup your data every 24 hours with 30-day retention for free accounts and 90-day retention for premium accounts. You can also create manual backups anytime from Settings > Data Management. Backups include all projects, files, and settings. Recovery takes 2-4 hours and can be initiated from your dashboard or by contacting support.",
      "tags": ["backup", "recovery", "data", "automatic"],
      "views": 2890,
      "likes": 156,
      "difficulty": "Intermediate",
      "lastUpdated": "4 days ago",
      "readTime": "4 min"
    },
    {
      "id": "9",
      "category": "premium",
      "question": "How do I upgrade to Premium?",
      "answer": "To upgrade to Premium, go to Settings > Billing > Upgrade Plan. Choose between monthly or annual billing (annual saves 20%). Select your payment method and complete the secure checkout process. Your upgrade is immediate and you'll have access to all premium features right away. We accept all major credit cards, PayPal, and bank transfers.",
      "tags": ["upgrade", "premium", "billing", "payment"],
      "views": 2560,
      "likes": 134,
      "difficulty": "Beginner",
      "lastUpdated": "6 days ago",
      "readTime": "2 min"
    },
    {
      "id": "10",
      "category": "mobile",
      "question": "Mobile app sync issues",
      "answer": "If you're experiencing sync issues on mobile, try these steps: 1) Check your internet connection, 2) Force close and reopen the app, 3) Log out and log back in, 4) Clear app cache (Android) or reinstall (iOS), 5) Ensure you have the latest app version. Sync typically takes 30-60 seconds. Contact support if issues persist after trying these steps.",
      "tags": ["mobile", "sync", "troubleshooting", "issues"],
      "views": 1920,
      "likes": 78,
      "difficulty": "Intermediate",
      "lastUpdated": "3 days ago",
      "readTime": "3 min"
    }
  ];

  List<Map<String, dynamic>> get filteredFaqs {
    List<Map<String, dynamic>> filtered = faqs;
    
    // Filter by category
    if (selectedCategory != "all") {
      filtered = filtered.where((faq) => faq["category"] == selectedCategory).toList();
    }
    
    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((faq) {
        String question = (faq["question"] as String).toLowerCase();
        String answer = (faq["answer"] as String).toLowerCase();
        List<String> tags = (faq["tags"] as List).cast<String>();
        String search = searchQuery.toLowerCase();
        
        return question.contains(search) || 
               answer.contains(search) ||
               tags.any((tag) => tag.toLowerCase().contains(search));
      }).toList();
    }
    
    // Sort results
    switch (sortBy) {
      case "popular":
        filtered.sort((a, b) => (b["views"] as int).compareTo(a["views"] as int));
        break;
      case "helpful":
        filtered.sort((a, b) => (b["likes"] as int).compareTo(a["likes"] as int));
        break;
      case "recent":
        filtered.sort((a, b) => _getDateFromString(b["lastUpdated"]).compareTo(_getDateFromString(a["lastUpdated"])));
        break;
    }
    
    return filtered;
  }

  DateTime _getDateFromString(String dateString) {
    // Simple date parsing for demo purposes
    if (dateString.contains("day")) {
      int days = int.tryParse(dateString.split(" ")[0]) ?? 0;
      return DateTime.now().subtract(Duration(days: days));
    } else if (dateString.contains("week")) {
      int weeks = int.tryParse(dateString.split(" ")[0]) ?? 0;
      return DateTime.now().subtract(Duration(days: weeks * 7));
    }
    return DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Knowledge Base"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              _showBookmarkedFaqs();
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              _showMoreOptions();
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
              children: [
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(color: disabledOutlineBorderColor),
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
                            hintText: "Search knowledge base...",
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
                
                SizedBox(height: spMd),
                
                // Filters Row
                Row(
                  children: [
                    // Sort Dropdown
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          border: Border.all(color: disabledOutlineBorderColor),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.sort,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: DropdownButton<String>(
                                value: sortBy,
                                isExpanded: true,
                                underline: SizedBox(),
                                style: TextStyle(fontSize: 14),
                                items: [
                                  DropdownMenuItem(value: "popular", child: Text("Most Popular")),
                                  DropdownMenuItem(value: "helpful", child: Text("Most Helpful")),
                                  DropdownMenuItem(value: "recent", child: Text("Most Recent")),
                                ],
                                onChanged: (value) {
                                  if (value != null) {
                                    sortBy = value;
                                    setState(() {});
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    SizedBox(width: spSm),
                    
                    // Results Count
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "${filteredFaqs.length} results",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Category Filter
          Container(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> category = categories[index];
                bool isSelected = selectedCategory == category["id"];
                
                return GestureDetector(
                  onTap: () {
                    selectedCategory = category["id"];
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          category["icon"],
                          size: 18,
                          color: isSelected ? Colors.white : primaryColor,
                        ),
                        SizedBox(height: 4),
                        Text(
                          category["name"],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // FAQ List
          Expanded(
            child: filteredFaqs.isEmpty 
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.all(spMd),
                    itemCount: filteredFaqs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> faq = filteredFaqs[index];
                      bool isBookmarked = bookmarkedFaqs.contains(faq["id"]);
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowMd],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // FAQ Header
                            GestureDetector(
                              onTap: () {
                                _showFaqDetail(faq);
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
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            _toggleBookmark(faq["id"]);
                                          },
                                          child: Icon(
                                            isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                                            color: isBookmarked ? warningColor : disabledBoldColor,
                                            size: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spMd),
                                    Text(
                                      faq["question"],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: spSm),
                                    Text(
                                      faq["answer"],
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            
                            // FAQ Footer
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(spMd),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(radiusLg),
                                  bottomRight: Radius.circular(radiusLg),
                                ),
                              ),
                              child: Column(
                                children: [
                                  // Tags
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Wrap(
                                          spacing: spXs,
                                          children: (faq["tags"] as List).take(3).map((tag) => Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spSm,
                                              vertical: 2,
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
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )).toList(),
                                        ),
                                      ),
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
                                            fontWeight: FontWeight.w600,
                                            color: _getDifficultyColor(faq["difficulty"]),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  SizedBox(height: spSm),
                                  
                                  // Stats
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.visibility,
                                        size: 14,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${faq["views"]} views",
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
                                      SizedBox(width: 4),
                                      Text(
                                        "${faq["likes"]} helpful",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: successColor,
                                        ),
                                      ),
                                      SizedBox(width: spMd),
                                      Icon(
                                        Icons.access_time,
                                        size: 14,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        faq["readTime"],
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                        color: primaryColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(spLg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              "Try adjusting your search terms or filters",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spMd),
            QButton(
              label: "Reset Filters",
              onPressed: () {
                searchQuery = "";
                selectedCategory = "all";
                sortBy = "popular";
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  void _toggleBookmark(String faqId) {
    if (bookmarkedFaqs.contains(faqId)) {
      bookmarkedFaqs.remove(faqId);
      ss("Removed from bookmarks");
    } else {
      bookmarkedFaqs.add(faqId);
      si("Added to bookmarks");
    }
    setState(() {});
  }

  void _showFaqDetail(Map<String, dynamic> faq) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
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
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _getCategoryColor(faq["category"]),
                      ),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      _toggleBookmark(faq["id"]);
                    },
                    child: Icon(
                      bookmarkedFaqs.contains(faq["id"]) ? Icons.bookmark : Icons.bookmark_border,
                      color: bookmarkedFaqs.contains(faq["id"]) ? warningColor : disabledBoldColor,
                    ),
                  ),
                  SizedBox(width: spSm),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, color: disabledBoldColor),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      faq["question"],
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      faq["answer"],
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: spLg),
                    
                    // Meta Information
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Article Information",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spMd),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Views",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${faq["views"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Helpful",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${faq["likes"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Updated",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      faq["lastUpdated"],
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Tags
                    Text(
                      "Tags",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Wrap(
                      spacing: spSm,
                      runSpacing: spSm,
                      children: (faq["tags"] as List).map((tag) => Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spMd,
                          vertical: spSm,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "#$tag",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )).toList(),
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

  void _showBookmarkedFaqs() {
    List<Map<String, dynamic>> bookmarked = faqs
        .where((faq) => bookmarkedFaqs.contains(faq["id"]))
        .toList();
    
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
                  Icon(Icons.bookmark, color: warningColor),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Bookmarked FAQs (${bookmarked.length})",
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
              child: bookmarked.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.bookmark_border,
                            size: 48,
                            color: disabledColor,
                          ),
                          SizedBox(height: spMd),
                          Text(
                            "No bookmarked FAQs",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Bookmark helpful articles for quick access",
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
                      itemCount: bookmarked.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> faq = bookmarked[index];
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
                              _showFaqDetail(faq);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  faq["question"],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spSm),
                                Text(
                                  faq["answer"],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
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

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: spMd),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Row(
              children: [
                Text(
                  "More Options",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, color: disabledBoldColor),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      // navigateTo(ContactSupportView());
                    },
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.support_agent, color: primaryColor),
                          SizedBox(height: spSm),
                          Text(
                            "Contact Support",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
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
                      Navigator.pop(context);
                      // navigateTo(FeedbackView());
                    },
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.feedback, color: successColor),
                          SizedBox(height: spSm),
                          Text(
                            "Send Feedback",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }

  String _getCategoryName(String categoryId) {
    switch (categoryId) {
      case "basics":
        return "Basics";
      case "account":
        return "Account";
      case "premium":
        return "Premium";
      case "technical":
        return "Technical";
      case "mobile":
        return "Mobile";
      default:
        return "General";
    }
  }

  Color _getCategoryColor(String categoryId) {
    switch (categoryId) {
      case "basics":
        return successColor;
      case "account":
        return primaryColor;
      case "premium":
        return warningColor;
      case "technical":
        return dangerColor;
      case "mobile":
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
