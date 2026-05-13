import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFaq9View extends StatefulWidget {
  @override
  State<GrlFaq9View> createState() => _GrlFaq9ViewState();
}

class _GrlFaq9ViewState extends State<GrlFaq9View> {
  String searchQuery = "";
  int selectedTabIndex = 0;
  List<String> recentSearches = ["password reset", "billing", "account setup"];
  
  List<Map<String, dynamic>> tabs = [
    {"title": "Getting Started", "icon": Icons.rocket_launch},
    {"title": "Account Help", "icon": Icons.person},
    {"title": "Troubleshooting", "icon": Icons.build_circle},
    {"title": "Advanced", "icon": Icons.settings},
  ];

  List<Map<String, dynamic>> gettingStartedContent = [
    {
      "type": "welcome",
      "title": "Welcome to Our Platform!",
      "description": "Get started with these essential guides to make the most of your experience.",
      "icon": Icons.waving_hand,
      "color": successColor,
    },
    {
      "type": "checklist",
      "title": "Quick Setup Checklist",
      "items": [
        {"task": "Create your account", "completed": true},
        {"task": "Verify your email", "completed": true},
        {"task": "Complete your profile", "completed": false},
        {"task": "Set up notifications", "completed": false},
        {"task": "Connect social accounts", "completed": false},
      ],
    },
    {
      "type": "tutorial",
      "title": "Interactive Tutorial",
      "description": "Take a 5-minute guided tour of the main features",
      "duration": "5 min",
      "progress": 0.3,
      "icon": Icons.play_circle,
    },
    {
      "type": "tips",
      "title": "Pro Tips for New Users",
      "tips": [
        "Use keyboard shortcuts to navigate faster",
        "Set up your workspace to match your workflow",
        "Enable notifications for important updates",
        "Join our community for tips and tricks",
      ],
    },
  ];

  List<Map<String, dynamic>> accountHelpContent = [
    {
      "question": "How do I change my password?",
      "steps": [
        "Go to Account Settings",
        "Click on 'Security' tab",
        "Select 'Change Password'",
        "Enter your current password",
        "Set your new password",
        "Confirm the changes",
      ],
      "category": "Security",
      "difficulty": "Easy",
    },
    {
      "question": "How do I update my profile information?",
      "steps": [
        "Navigate to your Profile page",
        "Click 'Edit Profile' button",
        "Update your information",
        "Upload a new profile picture if needed",
        "Save your changes",
      ],
      "category": "Profile",
      "difficulty": "Easy",
    },
    {
      "question": "How do I manage notification preferences?",
      "steps": [
        "Open Settings menu",
        "Go to 'Notifications' section",
        "Choose which notifications to receive",
        "Select delivery method (email, push, SMS)",
        "Set frequency preferences",
        "Save your settings",
      ],
      "category": "Notifications",
      "difficulty": "Medium",
    },
  ];

  List<Map<String, dynamic>> troubleshootingContent = [
    {
      "issue": "App won't load or crashes frequently",
      "severity": "high",
      "solutions": [
        "Clear your browser cache and cookies",
        "Update to the latest version",
        "Disable browser extensions temporarily",
        "Try using a different browser",
        "Check your internet connection",
        "Contact support if issue persists",
      ],
      "estimatedTime": "10-15 minutes",
    },
    {
      "issue": "Cannot upload files or images",
      "severity": "medium",
      "solutions": [
        "Check file size (max 10MB)",
        "Verify file format is supported",
        "Ensure stable internet connection",
        "Try compressing large files",
        "Clear browser cache",
        "Use a different device or browser",
      ],
      "estimatedTime": "5-10 minutes",
    },
    {
      "issue": "Notifications not working",
      "severity": "low",
      "solutions": [
        "Check notification settings in your account",
        "Verify email address is correct",
        "Check spam/junk folder",
        "Enable browser notifications",
        "Update your mobile app",
        "Re-subscribe to notifications",
      ],
      "estimatedTime": "5 minutes",
    },
  ];

  List<Map<String, dynamic>> advancedContent = [
    {
      "title": "API Documentation",
      "description": "Complete guide to using our REST API",
      "type": "documentation",
      "icon": Icons.code,
      "difficulty": "Advanced",
      "topics": ["Authentication", "Endpoints", "Rate Limits", "SDKs"],
    },
    {
      "title": "Webhook Configuration",
      "description": "Set up webhooks for real-time notifications",
      "type": "guide",
      "icon": Icons.webhook,
      "difficulty": "Advanced",
      "topics": ["Setup", "Security", "Testing", "Debugging"],
    },
    {
      "title": "Custom Integrations",
      "description": "Build custom integrations with third-party tools",
      "type": "tutorial",
      "icon": Icons.integration_instructions,
      "difficulty": "Expert",
      "topics": ["OAuth", "SSO", "Data Sync", "Custom Fields"],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Support Center"),
        actions: [
          IconButton(
            icon: Icon(Icons.headset_mic),
            onPressed: () => ss("Live support requested"),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [primaryColor, primaryColor.withAlpha(179)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "How can we help you today?",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spMd),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: TextField(
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      hintText: "Search for help topics, guides, or FAQs...",
                      prefixIcon: Icon(Icons.search, color: primaryColor),
                      suffixIcon: searchQuery.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.clear, color: disabledBoldColor),
                              onPressed: () {
                                searchQuery = "";
                                setState(() {});
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: spMd, vertical: spMd),
                    ),
                  ),
                ),
                if (recentSearches.isNotEmpty && searchQuery.isEmpty) ...[
                  SizedBox(height: spMd),
                  Text(
                    "Recent Searches",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withAlpha(230),
                    ),
                  ),
                  SizedBox(height: spSm),
                  Wrap(
                    spacing: spSm,
                    children: recentSearches.map((search) => GestureDetector(
                      onTap: () {
                        searchQuery = search;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(color: Colors.white.withAlpha(102)),
                        ),
                        child: Text(
                          search,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )).toList(),
                  ),
                ],
              ],
            ),
          ),
          
          // Tab Bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(tabs.length, (index) {
                  final tab = tabs[index];
                  bool isSelected = selectedTabIndex == index;
                  
                  return GestureDetector(
                    onTap: () {
                      selectedTabIndex = index;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spMd),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor.withAlpha(26) : Colors.transparent,
                        border: Border(
                          bottom: BorderSide(
                            color: isSelected ? primaryColor : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            tab["icon"],
                            size: 20,
                            color: isSelected ? primaryColor : disabledBoldColor,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            tab["title"],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                              color: isSelected ? primaryColor : disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          
          // Content
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTabIndex) {
      case 0:
        return _buildGettingStartedTab();
      case 1:
        return _buildAccountHelpTab();
      case 2:
        return _buildTroubleshootingTab();
      case 3:
        return _buildAdvancedTab();
      default:
        return Container();
    }
  }

  Widget _buildGettingStartedTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: gettingStartedContent.map((content) {
          switch (content["type"]) {
            case "welcome":
              return _buildWelcomeCard(content);
            case "checklist":
              return _buildChecklistCard(content);
            case "tutorial":
              return _buildTutorialCard(content);
            case "tips":
              return _buildTipsCard(content);
            default:
              return Container();
          }
        }).toList(),
      ),
    );
  }

  Widget _buildWelcomeCard(Map<String, dynamic> content) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [content["color"], content["color"].withAlpha(153)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Row(
        children: [
          Icon(
            content["icon"],
            size: 40,
            color: Colors.white,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  content["title"],
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  content["description"],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(230),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistCard(Map<String, dynamic> content) {
    List<Map<String, dynamic>> items = content["items"];
    int completedCount = items.where((item) => item["completed"] == true).length;
    double progress = completedCount / items.length;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                content["title"],
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                "$completedCount/${items.length} completed",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            color: successColor,
          ),
          SizedBox(height: spMd),
          ...items.map((item) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            child: Row(
              children: [
                Icon(
                  item["completed"] ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: item["completed"] ? successColor : disabledBoldColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    item["task"],
                    style: TextStyle(
                      fontSize: 14,
                      color: item["completed"] ? disabledBoldColor : primaryColor,
                      decoration: item["completed"] ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildTutorialCard(Map<String, dynamic> content) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  content["icon"],
                  color: primaryColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      content["title"],
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      content["description"],
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                content["duration"],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: warningColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          LinearProgressIndicator(
            value: content["progress"],
            backgroundColor: Colors.grey[300],
            color: primaryColor,
          ),
          SizedBox(height: spSm),
          Text(
            "${((content["progress"] as double) * 100).toInt()}% completed",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Continue Tutorial",
                  size: bs.sm,
                  onPressed: () => ss("Tutorial continued"),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.restart_alt,
                size: bs.sm,
                onPressed: () => ss("Tutorial restarted"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTipsCard(Map<String, dynamic> content) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content["title"],
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          ...(content["tips"] as List).asMap().entries.map((entry) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: infoColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Center(
                    child: Text(
                      "${entry.key + 1}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    entry.value,
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildAccountHelpTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: accountHelpContent.map((content) => _buildStepByStepCard(content)).toList(),
      ),
    );
  }

  Widget _buildStepByStepCard(Map<String, dynamic> content) {
    Color difficultyColor = content["difficulty"] == "Easy" ? successColor : 
                           content["difficulty"] == "Medium" ? warningColor : dangerColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  content["question"],
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: difficultyColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  content["difficulty"],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: difficultyColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "Category: ${content["category"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...(content["steps"] as List).asMap().entries.map((entry) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      "${entry.key + 1}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Text(
                    entry.value,
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildTroubleshootingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: troubleshootingContent.map((content) => _buildTroubleshootingCard(content)).toList(),
      ),
    );
  }

  Widget _buildTroubleshootingCard(Map<String, dynamic> content) {
    Color severityColor = content["severity"] == "high" ? dangerColor :
                         content["severity"] == "medium" ? warningColor : successColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border.all(color: severityColor.withAlpha(102)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: severityColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  Icons.warning,
                  color: severityColor,
                  size: 16,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  content["issue"],
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                content["estimatedTime"],
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "Solutions:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...(content["solutions"] as List).asMap().entries.map((entry) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  margin: EdgeInsets.only(top: 9),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    entry.value,
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildAdvancedTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: advancedContent.map((content) => _buildAdvancedCard(content)).toList(),
      ),
    );
  }

  Widget _buildAdvancedCard(Map<String, dynamic> content) {
    Color difficultyColor = content["difficulty"] == "Advanced" ? warningColor : dangerColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  content["icon"],
                  color: primaryColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      content["title"],
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      content["description"],
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: difficultyColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  content["difficulty"],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: difficultyColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "Topics covered:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Wrap(
            spacing: spSm,
            runSpacing: spXs,
            children: (content["topics"] as List).map((topic) => Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(51),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                topic,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: infoColor,
                ),
              ),
            )).toList(),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Read ${content["type"]}",
                  size: bs.sm,
                  onPressed: () => ss("${content["title"]} opened"),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.bookmark_border,
                size: bs.sm,
                onPressed: () => ss("${content["title"]} bookmarked"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
