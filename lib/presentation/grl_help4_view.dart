import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHelp4View extends StatefulWidget {
  @override
  State<GrlHelp4View> createState() => _GrlHelp4ViewState();
}

class _GrlHelp4ViewState extends State<GrlHelp4View> {
  String searchQuery = "";
  String selectedCategory = "all";
  
  List<Map<String, dynamic>> faqCategories = [
    {"label": "All", "value": "all"},
    {"label": "Account", "value": "account"},
    {"label": "Billing", "value": "billing"},
    {"label": "Technical", "value": "technical"},
    {"label": "Features", "value": "features"},
    {"label": "Privacy", "value": "privacy"},
  ];

  List<Map<String, dynamic>> faqs = [
    {
      "id": 1,
      "question": "How do I reset my password?",
      "answer": "To reset your password:\n\n1. Go to the login page\n2. Click 'Forgot Password'\n3. Enter your email address\n4. Check your email for a reset link\n5. Follow the instructions in the email\n\nIf you don't receive the email within 5 minutes, please check your spam folder or contact support.",
      "category": "account",
      "helpful": 156,
      "notHelpful": 12,
      "views": 2341,
      "tags": ["password", "reset", "login", "account"]
    },
    {
      "id": 2,
      "question": "How do I cancel my subscription?",
      "answer": "You can cancel your subscription anytime:\n\n1. Go to Settings > Billing\n2. Click 'Manage Subscription'\n3. Select 'Cancel Subscription'\n4. Choose your reason (optional)\n5. Confirm cancellation\n\nYour subscription will remain active until the end of your current billing period. You can reactivate it anytime before it expires.",
      "category": "billing",
      "helpful": 203,
      "notHelpful": 8,
      "views": 1876,
      "tags": ["subscription", "cancel", "billing", "account"]
    },
    {
      "id": 3,
      "question": "Why is my upload failing?",
      "answer": "Upload failures can happen for several reasons:\n\n**File Size**: Make sure your file is under 500MB\n**File Format**: We support most common formats (JPEG, PNG, PDF, DOC, etc.)\n**Internet Connection**: Check your connection stability\n**Browser Cache**: Try clearing your browser cache\n\nIf the problem persists, try uploading from a different browser or device.",
      "category": "technical",
      "helpful": 89,
      "notHelpful": 23,
      "views": 967,
      "tags": ["upload", "file", "error", "technical"]
    },
    {
      "id": 4,
      "question": "How do I enable two-factor authentication?",
      "answer": "To secure your account with 2FA:\n\n1. Go to Settings > Security\n2. Click 'Enable Two-Factor Authentication'\n3. Download an authenticator app (Google Authenticator, Authy, etc.)\n4. Scan the QR code with your app\n5. Enter the 6-digit code from your app\n6. Save your backup codes in a safe place\n\nWe highly recommend enabling 2FA for better account security.",
      "category": "account",
      "helpful": 134,
      "notHelpful": 5,
      "views": 1423,
      "tags": ["2fa", "security", "authentication", "account"]
    },
    {
      "id": 5,
      "question": "What payment methods do you accept?",
      "answer": "We accept the following payment methods:\n\n**Credit Cards**: Visa, MasterCard, American Express, Discover\n**Digital Wallets**: PayPal, Apple Pay, Google Pay\n**Bank Transfers**: ACH transfers (US only)\n**Cryptocurrencies**: Bitcoin, Ethereum (for annual plans)\n\nAll payments are processed securely through our encrypted payment system.",
      "category": "billing",
      "helpful": 178,
      "notHelpful": 7,
      "views": 2156,
      "tags": ["payment", "billing", "credit card", "paypal"]
    },
    {
      "id": 6,
      "question": "How do I delete my account?",
      "answer": "To permanently delete your account:\n\n⚠️ **Warning**: This action is irreversible and will delete all your data.\n\n1. Go to Settings > Account\n2. Scroll to 'Danger Zone'\n3. Click 'Delete Account'\n4. Enter your password for confirmation\n5. Type 'DELETE' to confirm\n6. Click 'Permanently Delete Account'\n\nYour account and all associated data will be deleted within 30 days.",
      "category": "account",
      "helpful": 67,
      "notHelpful": 15,
      "views": 543,
      "tags": ["delete", "account", "privacy", "data"]
    }
  ];

  List<int> expandedFaqs = [];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredFaqs = faqs.where((faq) {
      bool matchesCategory = selectedCategory == "all" || faq["category"] == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty || 
          faq["question"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          (faq["tags"] as List).any((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()));
      
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Frequently Asked Questions"),
      ),
      body: Column(
        children: [
          // Search and Filter
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
                      hintText: "Search FAQs...",
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
                  children: faqCategories.map((category) => GestureDetector(
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
                "${filteredFaqs.length} result(s) found",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: infoColor,
                ),
              ),
            ),
          
          // FAQ List
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  if (filteredFaqs.isEmpty)
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
                            "No FAQs found",
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
                    ...filteredFaqs.map((faq) {
                      bool isExpanded = expandedFaqs.contains(faq["id"]);
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          children: [
                            // Question Header
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
                                decoration: BoxDecoration(
                                  color: isExpanded ? primaryColor.withAlpha(20) : Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(radiusLg),
                                    topRight: Radius.circular(radiusLg),
                                    bottomLeft: Radius.circular(isExpanded ? 0 : radiusLg),
                                    bottomRight: Radius.circular(isExpanded ? 0 : radiusLg),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(spSm),
                                      decoration: BoxDecoration(
                                        color: _getCategoryColor(faq["category"]).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Icon(
                                        _getCategoryIcon(faq["category"]),
                                        color: _getCategoryColor(faq["category"]),
                                        size: 16,
                                      ),
                                    ),
                                    SizedBox(width: spMd),
                                    Expanded(
                                      child: Text(
                                        "${faq["question"]}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: isExpanded ? primaryColor : Colors.black,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      isExpanded ? Icons.expand_less : Icons.expand_more,
                                      color: isExpanded ? primaryColor : disabledBoldColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            
                            // Answer Content
                            if (isExpanded)
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(spMd),
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: primaryColor.withAlpha(50),
                                      width: 1,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(radiusLg),
                                    bottomRight: Radius.circular(radiusLg),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${faq["answer"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                        height: 1.5,
                                      ),
                                    ),
                                    
                                    SizedBox(height: spMd),
                                    
                                    // Tags
                                    Wrap(
                                      spacing: spSm,
                                      runSpacing: spSm,
                                      children: (faq["tags"] as List).map<Widget>((tag) => Container(
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
                                        SizedBox(width: spXs),
                                        Text(
                                          "${faq["helpful"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: successColor,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          "Was this helpful?",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        GestureDetector(
                                          onTap: () {
                                            ss("Thank you for your feedback!");
                                          },
                                          child: Icon(
                                            Icons.thumb_up,
                                            size: 16,
                                            color: successColor,
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        GestureDetector(
                                          onTap: () {
                                            ss("Thanks for letting us know. We'll improve this answer.");
                                          },
                                          child: Icon(
                                            Icons.thumb_down,
                                            size: 16,
                                            color: dangerColor,
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
                    }).toList(),
                  
                  // Still Need Help?
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryColor, primaryColor.withAlpha(180)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.help_center,
                          color: Colors.white,
                          size: 32,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "Still need help?",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Can't find what you're looking for? Our support team is here to help.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(height: spMd),
                        QButton(
                          label: "Contact Support",
                          onPressed: () {
                            // navigateTo(ContactSupportView());
                          },
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
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'account':
        return primaryColor;
      case 'billing':
        return warningColor;
      case 'technical':
        return dangerColor;
      case 'features':
        return successColor;
      case 'privacy':
        return infoColor;
      default:
        return primaryColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'account':
        return Icons.person;
      case 'billing':
        return Icons.payment;
      case 'technical':
        return Icons.build;
      case 'features':
        return Icons.apps;
      case 'privacy':
        return Icons.security;
      default:
        return Icons.help;
    }
  }
}
