import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFaq5View extends StatefulWidget {
  @override
  State<GrlFaq5View> createState() => _GrlFaq5ViewState();
}

class _GrlFaq5ViewState extends State<GrlFaq5View> {
  String searchQuery = "";
  List<int> expandedFaqs = [];
  
  List<Map<String, dynamic>> faqSections = [
    {
      "title": "Getting Started",
      "icon": Icons.rocket_launch,
      "color": successColor,
      "faqs": [
        {
          "id": 1,
          "question": "How do I create my first project?",
          "answer": "Creating your first project is easy! Click the 'New Project' button on your dashboard, choose a template or start from scratch, give your project a name, and you're ready to go. Our step-by-step wizard will guide you through the initial setup process.",
          "tags": ["project", "create", "start"],
          "difficulty": "Beginner",
          "estimatedTime": "2 minutes"
        },
        {
          "id": 2,
          "question": "What are the system requirements?",
          "answer": "Our platform works on most modern devices. For web: Chrome 90+, Safari 14+, Firefox 88+, or Edge 90+. For mobile: iOS 13+ or Android 8+. You'll need at least 4GB RAM and a stable internet connection for optimal performance.",
          "tags": ["requirements", "system", "compatibility"],
          "difficulty": "Beginner",
          "estimatedTime": "1 minute"
        },
        {
          "id": 3,
          "question": "How do I navigate the interface?",
          "answer": "The main navigation is located in the sidebar on the left. The top bar contains search and user settings. Use keyboard shortcuts (Ctrl+K for quick search, Ctrl+N for new project) to navigate faster. Hover over icons to see tooltips with descriptions.",
          "tags": ["navigation", "interface", "shortcuts"],
          "difficulty": "Beginner",
          "estimatedTime": "3 minutes"
        }
      ]
    },
    {
      "title": "Account & Security",
      "icon": Icons.security,
      "color": primaryColor,
      "faqs": [
        {
          "id": 4,
          "question": "How do I enable two-factor authentication?",
          "answer": "Go to Settings > Security > Two-Factor Authentication. Choose your preferred method (SMS, authenticator app, or email). Follow the setup wizard to scan the QR code with your authenticator app or enter your phone number for SMS verification.",
          "tags": ["2fa", "security", "authentication"],
          "difficulty": "Intermediate",
          "estimatedTime": "5 minutes"
        },
        {
          "id": 5,
          "question": "Can I change my username?",
          "answer": "Yes, you can change your username once every 30 days. Go to Settings > Profile > Edit Username. Enter your new username (must be unique and 3-20 characters). Note that changing your username will update all your public profile links.",
          "tags": ["username", "profile", "change"],
          "difficulty": "Beginner",
          "estimatedTime": "2 minutes"
        },
        {
          "id": 6,
          "question": "How do I delete my account?",
          "answer": "Account deletion is permanent and cannot be undone. Go to Settings > Account > Delete Account. You'll need to confirm by typing 'DELETE' and entering your password. All your data will be permanently removed within 30 days.",
          "tags": ["delete", "account", "permanent"],
          "difficulty": "Advanced",
          "estimatedTime": "3 minutes"
        }
      ]
    },
    {
      "title": "Billing & Subscription",
      "icon": Icons.payment,
      "color": warningColor,
      "faqs": [
        {
          "id": 7,
          "question": "What payment methods do you accept?",
          "answer": "We accept all major credit cards (Visa, MasterCard, American Express, Discover), PayPal, Apple Pay, Google Pay, and bank transfers for enterprise accounts. All payments are processed securely through our encrypted payment gateway.",
          "tags": ["payment", "methods", "billing"],
          "difficulty": "Beginner",
          "estimatedTime": "1 minute"
        },
        {
          "id": 8,
          "question": "How do I upgrade or downgrade my plan?",
          "answer": "Go to Settings > Billing > Manage Plan. Choose your new plan and confirm the change. Upgrades take effect immediately, while downgrades take effect at the next billing cycle. You'll receive a prorated refund or charge based on the timing.",
          "tags": ["upgrade", "downgrade", "plan"],
          "difficulty": "Intermediate",
          "estimatedTime": "3 minutes"
        },
        {
          "id": 9,
          "question": "How do refunds work?",
          "answer": "We offer a 30-day money-back guarantee for new subscriptions. Contact support with your refund request and reason. Refunds are processed within 5-10 business days to your original payment method. Partial refunds may apply for annual plans.",
          "tags": ["refund", "money-back", "guarantee"],
          "difficulty": "Intermediate",
          "estimatedTime": "2 minutes"
        }
      ]
    },
    {
      "title": "Technical Support",
      "icon": Icons.build,
      "color": dangerColor,
      "faqs": [
        {
          "id": 10,
          "question": "The app is running slowly. What should I do?",
          "answer": "Try these troubleshooting steps: 1) Clear your browser cache, 2) Disable browser extensions, 3) Check your internet connection, 4) Close other tabs/applications, 5) Try incognito/private mode, 6) Update your browser. If issues persist, contact our technical support team.",
          "tags": ["slow", "performance", "troubleshooting"],
          "difficulty": "Intermediate",
          "estimatedTime": "5 minutes"
        },
        {
          "id": 11,
          "question": "How do I export my data?",
          "answer": "Go to Settings > Data Export. Choose your export format (JSON, CSV, or PDF), select date range and data types. Large exports are processed in the background and you'll receive an email when ready. Exports are available for download for 7 days.",
          "tags": ["export", "data", "backup"],
          "difficulty": "Intermediate",
          "estimatedTime": "4 minutes"
        },
        {
          "id": 12,
          "question": "Can I recover deleted items?",
          "answer": "Deleted items are moved to the trash where they remain for 30 days. Go to Trash in your sidebar to view and restore deleted items. After 30 days, items are permanently deleted and cannot be recovered. Premium users have 90-day recovery period.",
          "tags": ["recover", "delete", "trash"],
          "difficulty": "Beginner",
          "estimatedTime": "2 minutes"
        }
      ]
    }
  ];

  List<Map<String, dynamic>> get allFaqs {
    List<Map<String, dynamic>> allFaqs = [];
    for (var section in faqSections) {
      for (var faq in section["faqs"]) {
        allFaqs.add({
          ...faq,
          "sectionTitle": section["title"],
          "sectionColor": section["color"],
        });
      }
    }
    return allFaqs;
  }

  List<Map<String, dynamic>> get filteredFaqs {
    if (searchQuery.isEmpty) return allFaqs;
    
    return allFaqs.where((faq) {
      String question = (faq["question"] as String).toLowerCase();
      String answer = (faq["answer"] as String).toLowerCase();
      List<String> tags = (faq["tags"] as List).cast<String>();
      String sectionTitle = (faq["sectionTitle"] as String).toLowerCase();
      String search = searchQuery.toLowerCase();
      
      return question.contains(search) || 
             answer.contains(search) ||
             sectionTitle.contains(search) ||
             tags.any((tag) => tag.toLowerCase().contains(search));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Support Center"),
        actions: [
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: () {
              // navigateTo(LiveChatView());
            },
          ),
          IconButton(
            icon: Icon(Icons.phone),
            onPressed: () {
              // navigateTo(ContactUsView());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Header Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(200)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.help_center,
                  color: Colors.white,
                  size: 48,
                ),
                SizedBox(height: spMd),
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
                  "Search our comprehensive FAQ database",
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
                            hintText: "Search FAQs, keywords, or topics...",
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

          // Quick Stats
          if (searchQuery.isEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Text(
                            "${allFaqs.length}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Total FAQs",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Text(
                            "${faqSections.length}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Categories",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Text(
                            "24/7",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
                            ),
                          ),
                          Text(
                            "Support",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Content
          Expanded(
            child: searchQuery.isEmpty ? _buildSectionView() : _buildSearchResults(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // navigateTo(ContactSupportView());
        },
        backgroundColor: primaryColor,
        icon: Icon(Icons.support_agent, color: Colors.white),
        label: Text(
          "Contact Support",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSectionView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: faqSections.map((section) {
          return Container(
            margin: EdgeInsets.only(bottom: spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Section Header
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: (section["color"] as Color).withAlpha(20),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radiusLg),
                      topRight: Radius.circular(radiusLg),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: section["color"],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          section["icon"],
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              section["title"],
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${(section["faqs"] as List).length} questions",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // FAQs List
                ...(section["faqs"] as List).map((faq) {
                  bool isExpanded = expandedFaqs.contains(faq["id"]);
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (isExpanded) {
                            expandedFaqs.remove(faq["id"]);
                          } else {
                            expandedFaqs.add(faq["id"]);
                          }
                          setState(() {});
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spMd),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      faq["question"],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spSm,
                                            vertical: 2,
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
                                        SizedBox(width: spSm),
                                        Icon(
                                          Icons.access_time,
                                          size: 12,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          faq["estimatedTime"],
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
                              Icon(
                                isExpanded ? Icons.expand_less : Icons.expand_more,
                                color: primaryColor,
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      if (isExpanded) ...[
                        Divider(
                          color: disabledOutlineBorderColor,
                          height: 1,
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spMd),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                faq["answer"],
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.6,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: spMd),
                              
                              // Tags
                              Wrap(
                                spacing: spXs,
                                children: (faq["tags"] as List).map((tag) => Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "#$tag",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )).toList(),
                              ),
                              
                              SizedBox(height: spMd),
                              
                              // Feedback
                              Row(
                                children: [
                                  Text(
                                    "Was this helpful?",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      ss("Thanks for your feedback!");
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: successColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.thumb_up,
                                            size: 12,
                                            color: successColor,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            "Yes",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: successColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  GestureDetector(
                                    onTap: () {
                                      sw("We'll improve this answer");
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: dangerColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.thumb_down,
                                            size: 12,
                                            color: dangerColor,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            "No",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: dangerColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                      
                      if (faq["id"] != (section["faqs"] as List).last["id"])
                        Divider(
                          color: disabledOutlineBorderColor,
                          height: 1,
                        ),
                    ],
                  );
                }).toList(),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSearchResults() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Results Header
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
            ...filteredFaqs.map((faq) {
              bool isExpanded = expandedFaqs.contains(faq["id"]);
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  border: isExpanded 
                      ? Border.all(color: primaryColor, width: 2)
                      : Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (isExpanded) {
                          expandedFaqs.remove(faq["id"]);
                        } else {
                          expandedFaqs.add(faq["id"]);
                        }
                        setState(() {});
                      },
                      child: Container(
                        width: double.infinity,
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
                                    color: (faq["sectionColor"] as Color).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    faq["sectionTitle"],
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: faq["sectionColor"],
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  isExpanded ? Icons.expand_less : Icons.expand_more,
                                  color: primaryColor,
                                  size: 24,
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              faq["question"],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            if (!isExpanded) ...[
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
                          ],
                        ),
                      ),
                    ),
                    
                    if (isExpanded) ...[
                      Divider(color: disabledOutlineBorderColor, height: 1),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              faq["answer"],
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.6,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: spMd),
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
                                SizedBox(width: spSm),
                                Icon(
                                  Icons.access_time,
                                  size: 12,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  faq["estimatedTime"],
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
                    ],
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
              "No results found",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "Try different keywords or browse our categories",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spMd),
            QButton(
              label: "Clear Search",
              onPressed: () {
                searchQuery = "";
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
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
