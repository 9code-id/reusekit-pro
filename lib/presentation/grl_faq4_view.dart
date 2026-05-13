import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFaq4View extends StatefulWidget {
  @override
  State<GrlFaq4View> createState() => _GrlFaq4ViewState();
}

class _GrlFaq4ViewState extends State<GrlFaq4View> {
  String selectedView = "faq";
  String searchQuery = "";
  
  List<Map<String, dynamic>> quickAnswers = [
    {
      "id": 1,
      "question": "How do I reset my password?",
      "quickAnswer": "Go to login page → 'Forgot Password' → Enter email → Check inbox",
      "fullAnswer": "To reset your password, navigate to the login page and click on 'Forgot Password'. Enter your registered email address and click 'Send Reset Link'. Check your email inbox (and spam folder) for a password reset email. Click the link in the email and follow the instructions to create a new password.",
      "category": "Account",
      "icon": Icons.lock_reset,
      "helpful": 234,
      "steps": [
        "Go to the login page",
        "Click 'Forgot Password' link",
        "Enter your registered email address",
        "Click 'Send Reset Link'",
        "Check your email inbox",
        "Click the reset link in the email",
        "Create a new secure password",
        "Confirm your new password"
      ]
    },
    {
      "id": 2,
      "question": "How do I upgrade my plan?",
      "quickAnswer": "Settings → Billing → Choose Plan → Complete Payment",
      "fullAnswer": "To upgrade your subscription plan, go to Settings from the main menu, then select Billing & Subscription. You'll see all available plans with their features. Choose your desired plan and click 'Upgrade Now'. Complete the payment process using your preferred payment method.",
      "category": "Billing",
      "icon": Icons.upgrade,
      "helpful": 189,
      "steps": [
        "Open Settings menu",
        "Navigate to Billing & Subscription",
        "Review available plans",
        "Select your desired plan",
        "Click 'Upgrade Now'",
        "Choose payment method",
        "Complete the payment",
        "Enjoy your new features"
      ]
    },
    {
      "id": 3,
      "question": "App not loading - what to do?",
      "quickAnswer": "Close app → Clear cache → Restart device → Update app",
      "fullAnswer": "If the app isn't loading properly, try these troubleshooting steps in order: Force close the app completely, clear the app cache from your device settings, restart your device, check for app updates in the store, and ensure you have a stable internet connection.",
      "category": "Technical",
      "icon": Icons.refresh,
      "helpful": 156,
      "steps": [
        "Force close the app completely",
        "Go to device Settings",
        "Find the app in Apps/Applications",
        "Clear cache and data",
        "Restart your device",
        "Check for app updates",
        "Ensure stable internet connection",
        "Reopen the app"
      ]
    },
    {
      "id": 4,
      "question": "How to sync data across devices?",
      "quickAnswer": "Login same account → Enable sync → Wait for sync completion",
      "fullAnswer": "To sync your data across multiple devices, ensure you're logged into the same account on all devices. Go to Settings > Sync & Backup, enable automatic sync, and wait for the initial sync to complete. This may take a few minutes depending on your data size.",
      "category": "Data",
      "icon": Icons.sync,
      "helpful": 198,
      "steps": [
        "Login to same account on all devices",
        "Go to Settings > Sync & Backup",
        "Enable 'Automatic Sync'",
        "Wait for initial sync to complete",
        "Verify data appears on all devices",
        "Enable sync notifications (optional)"
      ]
    },
  ];

  List<Map<String, dynamic>> videoTutorials = [
    {
      "id": 1,
      "title": "Getting Started Guide",
      "description": "Complete walkthrough for new users",
      "duration": "5:42",
      "thumbnail": "https://picsum.photos/300/180?random=1&keyword=tutorial",
      "category": "Beginner",
      "views": 12500,
      "rating": 4.8,
    },
    {
      "id": 2,
      "title": "Advanced Features Overview",
      "description": "Learn about pro features and shortcuts",
      "duration": "8:15",
      "thumbnail": "https://picsum.photos/300/180?random=2&keyword=advanced",
      "category": "Advanced",
      "views": 8900,
      "rating": 4.7,
    },
    {
      "id": 3,
      "title": "Troubleshooting Common Issues",
      "description": "Solutions to frequently reported problems",
      "duration": "6:30",
      "thumbnail": "https://picsum.photos/300/180?random=3&keyword=support",
      "category": "Support",
      "views": 6750,
      "rating": 4.6,
    },
    {
      "id": 4,
      "title": "Data Management & Privacy",
      "description": "How to manage your data and privacy settings",
      "duration": "4:20",
      "thumbnail": "https://picsum.photos/300/180?random=4&keyword=privacy",
      "category": "Privacy",
      "views": 5430,
      "rating": 4.9,
    },
  ];

  List<Map<String, dynamic>> get filteredQuickAnswers {
    if (searchQuery.isEmpty) return quickAnswers;
    
    return quickAnswers.where((item) {
      String question = (item["question"] as String).toLowerCase();
      String quickAnswer = (item["quickAnswer"] as String).toLowerCase();
      String category = (item["category"] as String).toLowerCase();
      String search = searchQuery.toLowerCase();
      
      return question.contains(search) || 
             quickAnswer.contains(search) ||
             category.contains(search);
    }).toList();
  }

  List<Map<String, dynamic>> get filteredTutorials {
    if (searchQuery.isEmpty) return videoTutorials;
    
    return videoTutorials.where((item) {
      String title = (item["title"] as String).toLowerCase();
      String description = (item["description"] as String).toLowerCase();
      String category = (item["category"] as String).toLowerCase();
      String search = searchQuery.toLowerCase();
      
      return title.contains(search) || 
             description.contains(search) ||
             category.contains(search);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quick Help"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // navigateTo(HelpHistoryView());
            },
          ),
          IconButton(
            icon: Icon(Icons.contact_support),
            onPressed: () {
              // navigateTo(ContactSupportView());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                stops: [0.0, 1.0],
              ),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.flash_on,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Quick Help & Tutorials",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search help topics...",
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

          // View Toggle
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedView = "faq";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spMd),
                      decoration: BoxDecoration(
                        color: selectedView == "faq" ? primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                        border: Border.all(
                          color: selectedView == "faq" ? primaryColor : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.quiz,
                            size: 18,
                            color: selectedView == "faq" ? Colors.white : primaryColor,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Quick Answers",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: selectedView == "faq" ? Colors.white : primaryColor,
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
                      selectedView = "videos";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spMd),
                      decoration: BoxDecoration(
                        color: selectedView == "videos" ? primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                        border: Border.all(
                          color: selectedView == "videos" ? primaryColor : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.play_circle,
                            size: 18,
                            color: selectedView == "videos" ? Colors.white : primaryColor,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Video Tutorials",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: selectedView == "videos" ? Colors.white : primaryColor,
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
            child: selectedView == "faq" ? _buildQuickAnswers() : _buildVideoTutorials(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAnswers() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (searchQuery.isNotEmpty) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${filteredQuickAnswers.length} quick answers found",
                style: TextStyle(
                  fontSize: 14,
                  color: infoColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: spMd),
          ],

          if (filteredQuickAnswers.isEmpty)
            _buildEmptyState()
          else
            ...filteredQuickAnswers.map((answer) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(answer["category"]).withAlpha(20),
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
                            color: _getCategoryColor(answer["category"]),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            answer["icon"],
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                answer["question"],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                answer["category"],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _getCategoryColor(answer["category"]),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.thumb_up,
                              size: 14,
                              color: successColor,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "${answer["helpful"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Quick Answer
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.flash_on,
                              color: warningColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Quick Answer:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: warningColor.withAlpha(50)),
                          ),
                          child: Text(
                            answer["quickAnswer"],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: warningColor,
                            ),
                          ),
                        ),
                        SizedBox(height: spMd),
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "View Steps",
                                onPressed: () {
                                  _showDetailedSteps(answer);
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            GestureDetector(
                              onTap: () {
                                _showFullAnswer(answer);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spMd,
                                  vertical: spSm,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: primaryColor),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "Full Answer",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )).toList(),
        ],
      ),
    );
  }

  Widget _buildVideoTutorials() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (searchQuery.isNotEmpty) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${filteredTutorials.length} video tutorials found",
                style: TextStyle(
                  fontSize: 14,
                  color: infoColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: spMd),
          ],

          if (filteredTutorials.isEmpty)
            _buildEmptyState()
          else
            ...filteredTutorials.map((tutorial) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Thumbnail
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusLg),
                          topRight: Radius.circular(radiusLg),
                        ),
                        child: Image.network(
                          tutorial["thumbnail"],
                          width: double.infinity,
                          height: 160,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(100),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusLg),
                              topRight: Radius.circular(radiusLg),
                            ),
                          ),
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.all(spMd),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(200),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.play_arrow,
                                color: primaryColor,
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: spSm,
                        right: spSm,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(180),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            tutorial["duration"],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Content
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
                                color: _getTutorialCategoryColor(tutorial["category"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                tutorial["category"],
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: _getTutorialCategoryColor(tutorial["category"]),
                                ),
                              ),
                            ),
                            Spacer(),
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
                                  "${tutorial["rating"]}",
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
                          tutorial["title"],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          tutorial["description"],
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
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
                              "${tutorial["views"]} views",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            QButton(
                              label: "Watch Now",
                              onPressed: () {
                                // navigateTo(VideoPlayerView(tutorial: tutorial));
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
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
              "Try different keywords or browse all content",
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

  void _showDetailedSteps(Map<String, dynamic> answer) {
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
                border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
              ),
              child: Row(
                children: [
                  Icon(answer["icon"], color: primaryColor),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Step-by-Step Guide",
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
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      answer["question"],
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    ...(answer["steps"] as List).asMap().entries.map((entry) {
                      int index = entry.key;
                      String step = entry.value;
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spMd),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  "${index + 1}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Text(
                                step,
                                style: TextStyle(
                                  fontSize: 16,
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

  void _showFullAnswer(Map<String, dynamic> answer) {
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
                  Icon(answer["icon"], color: primaryColor),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Detailed Answer",
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
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      answer["question"],
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      answer["fullAnswer"],
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: Colors.black87,
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

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Account":
        return primaryColor;
      case "Billing":
        return warningColor;
      case "Technical":
        return dangerColor;
      case "Data":
        return infoColor;
      default:
        return successColor;
    }
  }

  Color _getTutorialCategoryColor(String category) {
    switch (category) {
      case "Beginner":
        return successColor;
      case "Advanced":
        return dangerColor;
      case "Support":
        return warningColor;
      case "Privacy":
        return infoColor;
      default:
        return primaryColor;
    }
  }
}
