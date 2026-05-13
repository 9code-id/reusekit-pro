import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFaq3View extends StatefulWidget {
  @override
  State<GrlFaq3View> createState() => _GrlFaq3ViewState();
}

class _GrlFaq3ViewState extends State<GrlFaq3View> {
  String selectedCategory = "all";
  String searchQuery = "";
  List<String> bookmarkedFaqs = ["1", "3", "5"];
  
  List<Map<String, dynamic>> faqCategories = [
    {
      "id": "all",
      "name": "All Topics",
      "icon": Icons.apps,
      "color": primaryColor,
    },
    {
      "id": "account",
      "name": "Account",
      "icon": Icons.person,
      "color": successColor,
    },
    {
      "id": "billing",
      "name": "Billing",
      "icon": Icons.payment,
      "color": warningColor,
    },
    {
      "id": "technical",
      "name": "Technical", 
      "icon": Icons.settings,
      "color": dangerColor,
    },
    {
      "id": "features",
      "name": "Features",
      "icon": Icons.star,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> allFaqs = [
    {
      "id": "1",
      "category": "account",
      "question": "How do I change my email address?",
      "answer": "To change your email address, go to Settings > Account Settings > Email. Enter your new email address and click 'Update'. You'll receive a verification email at your new address to confirm the change.",
      "tags": ["email", "account", "settings"],
      "difficulty": "Easy",
      "readTime": "2 min",
      "lastUpdated": "2 days ago"
    },
    {
      "id": "2", 
      "category": "account",
      "question": "How do I enable two-factor authentication?",
      "answer": "Two-factor authentication adds an extra layer of security to your account. Go to Settings > Security > Two-Factor Authentication. Choose between SMS, authenticator app, or email verification. Follow the setup wizard to complete the process.",
      "tags": ["security", "2fa", "authentication"],
      "difficulty": "Medium",
      "readTime": "5 min",
      "lastUpdated": "1 week ago"
    },
    {
      "id": "3",
      "category": "billing",
      "question": "How do refunds work?",
      "answer": "Refunds are processed within 5-10 business days depending on your payment method. Go to Settings > Billing > Transaction History to request a refund. Refunds are available within 30 days of purchase for eligible items.",
      "tags": ["refund", "billing", "payment"],
      "difficulty": "Easy",
      "readTime": "3 min",
      "lastUpdated": "3 days ago"
    },
    {
      "id": "4",
      "category": "billing",
      "question": "Can I change my billing cycle?",
      "answer": "Yes, you can switch between monthly and annual billing at any time. Go to Settings > Billing > Subscription Details. Changes take effect at the next billing cycle. Annual plans offer significant savings.",
      "tags": ["billing cycle", "subscription", "pricing"],
      "difficulty": "Easy",
      "readTime": "2 min",
      "lastUpdated": "5 days ago"
    },
    {
      "id": "5",
      "category": "technical",
      "question": "Why is the app running slowly?",
      "answer": "App performance can be affected by several factors: 1) Clear app cache, 2) Update to latest version, 3) Restart your device, 4) Check available storage space, 5) Close other running apps. If issues persist, contact our technical support team.",
      "tags": ["performance", "slow", "troubleshooting"],
      "difficulty": "Medium",
      "readTime": "4 min",
      "lastUpdated": "1 day ago"
    },
    {
      "id": "6",
      "category": "technical",
      "question": "How do I export my data?",
      "answer": "You can export your data in multiple formats (JSON, CSV, PDF). Go to Settings > Data Management > Export Data. Choose your preferred format and date range. Large exports may take several minutes to process.",
      "tags": ["export", "data", "backup"],
      "difficulty": "Medium",
      "readTime": "3 min",
      "lastUpdated": "1 week ago"
    },
    {
      "id": "7",
      "category": "features",
      "question": "How do I use keyboard shortcuts?",
      "answer": "Press Ctrl+? (or Cmd+? on Mac) to view all available keyboard shortcuts. Common shortcuts include: Ctrl+N (new), Ctrl+S (save), Ctrl+F (search), Ctrl+Z (undo). Shortcuts can significantly improve your workflow efficiency.",
      "tags": ["shortcuts", "keyboard", "productivity"],
      "difficulty": "Easy",
      "readTime": "2 min",
      "lastUpdated": "2 weeks ago"
    },
    {
      "id": "8",
      "category": "features",
      "question": "Can I collaborate with team members?",
      "answer": "Yes! Our collaboration features include: shared workspaces, real-time editing, comments, @mentions, and permission controls. Invite team members via email or share links. Pro plans support unlimited collaborators.",
      "tags": ["collaboration", "team", "sharing"],
      "difficulty": "Medium",
      "readTime": "4 min",
      "lastUpdated": "4 days ago"
    },
  ];

  List<Map<String, dynamic>> get filteredFaqs {
    List<Map<String, dynamic>> filtered = allFaqs;
    
    if (selectedCategory != "all") {
      filtered = filtered.where((faq) => faq["category"] == selectedCategory).toList();
    }
    
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
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQ Hub"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              _showBookmarkedFaqs();
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
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
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
                            hintText: "Search FAQs, topics, or keywords...",
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
                
                if (searchQuery.isNotEmpty) ...[
                  SizedBox(height: spMd),
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
                ]
              ],
            ),
          ),

          // Category Filter
          Container(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              itemCount: faqCategories.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> category = faqCategories[index];
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
                      color: isSelected ? category["color"] : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                      border: Border.all(
                        color: isSelected ? category["color"] : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          category["icon"],
                          size: 20,
                          color: isSelected ? Colors.white : category["color"],
                        ),
                        SizedBox(height: 4),
                        Text(
                          category["name"],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : category["color"],
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
                          boxShadow: [shadowSm],
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // FAQ Header
                            Padding(
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
                                  GestureDetector(
                                    onTap: () {
                                      _showFaqDetail(faq);
                                    },
                                    child: Text(
                                      faq["question"],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
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
                              child: Row(
                                children: [
                                  // Tags
                                  Expanded(
                                    child: Wrap(
                                      spacing: spXs,
                                      children: (faq["tags"] as List).take(2).map((tag) => Container(
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
                                  
                                  // Difficulty Badge
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
                                  
                                  SizedBox(width: spSm),
                                  
                                  // Read Time
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigateTo(SubmitQuestionView());
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.question_answer,
          color: Colors.white,
        ),
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
              searchQuery.isNotEmpty ? Icons.search_off : Icons.help_outline,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              searchQuery.isNotEmpty ? "No results found" : "No FAQs available",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              searchQuery.isNotEmpty 
                  ? "Try different keywords or browse by category"
                  : "Check back later for helpful articles",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            if (searchQuery.isNotEmpty) ...[
              SizedBox(height: spMd),
              QButton(
                label: "Clear Search",
                onPressed: () {
                  searchQuery = "";
                  selectedCategory = "all";
                  setState(() {});
                },
              ),
            ],
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
            // Handle
            Container(
              margin: EdgeInsets.symmetric(vertical: spSm),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "FAQ Details",
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
            
            // Content
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
                    SizedBox(height: spMd),
                    
                    // Meta Info
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
                          Row(
                            children: [
                              Text(
                                "Category: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                _getCategoryName(faq["category"]),
                                style: TextStyle(
                                  color: _getCategoryColor(faq["category"]),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "Last updated: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                faq["lastUpdated"],
                                style: TextStyle(color: disabledBoldColor),
                              ),
                            ],
                          ),
                        ],
                      ),
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
    List<Map<String, dynamic>> bookmarked = allFaqs
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

  String _getCategoryName(String categoryId) {
    switch (categoryId) {
      case "account":
        return "Account";
      case "billing":
        return "Billing";
      case "technical":
        return "Technical";
      case "features":
        return "Features";
      default:
        return "General";
    }
  }

  Color _getCategoryColor(String categoryId) {
    switch (categoryId) {
      case "account":
        return successColor;
      case "billing":
        return warningColor;
      case "technical":
        return dangerColor;
      case "features":
        return infoColor;
      default:
        return primaryColor;
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case "easy":
        return successColor;
      case "medium":
        return warningColor;
      case "hard":
        return dangerColor;
      default:
        return primaryColor;
    }
  }
}
