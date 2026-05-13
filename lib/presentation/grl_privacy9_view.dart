import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPrivacy9View extends StatefulWidget {
  @override
  State<GrlPrivacy9View> createState() => _GrlPrivacy9ViewState();
}

class _GrlPrivacy9ViewState extends State<GrlPrivacy9View> {
  String selectedLanguage = "en";
  bool autoTranslate = true;
  bool showOriginalText = false;
  String selectedRegion = "global";
  
  List<Map<String, dynamic>> languageOptions = [
    {"label": "English", "value": "en"},
    {"label": "Español", "value": "es"},
    {"label": "Français", "value": "fr"},
    {"label": "Deutsch", "value": "de"},
    {"label": "中文", "value": "zh"},
    {"label": "日本語", "value": "ja"},
    {"label": "한국어", "value": "ko"},
    {"label": "Português", "value": "pt"},
    {"label": "Русский", "value": "ru"},
    {"label": "العربية", "value": "ar"},
  ];
  
  List<Map<String, dynamic>> regionOptions = [
    {"label": "Global", "value": "global"},
    {"label": "European Union", "value": "eu"},
    {"label": "United States", "value": "us"},
    {"label": "Canada", "value": "ca"},
    {"label": "Asia Pacific", "value": "apac"},
    {"label": "Latin America", "value": "latam"},
  ];

  List<Map<String, dynamic>> privacyDocuments = [
    {
      "title": "Privacy Policy",
      "description": "Our commitment to protecting your personal information",
      "lastUpdated": DateTime.now().subtract(Duration(days: 15)),
      "version": "3.2",
      "language": "en",
      "regions": ["global", "us", "ca"],
      "wordCount": 3245,
      "readingTime": "12 min",
      "status": "current",
      "icon": Icons.policy,
    },
    {
      "title": "Cookie Policy",
      "description": "How we use cookies and similar tracking technologies",
      "lastUpdated": DateTime.now().subtract(Duration(days: 8)),
      "version": "2.1",
      "language": "en",
      "regions": ["global", "eu", "us"],
      "wordCount": 1867,
      "readingTime": "7 min",
      "status": "current",
      "icon": Icons.cookie,
    },
    {
      "title": "Data Processing Agreement",
      "description": "Terms for data processing and handling",
      "lastUpdated": DateTime.now().subtract(Duration(days: 45)),
      "version": "1.8",
      "language": "en",
      "regions": ["eu", "global"],
      "wordCount": 4521,
      "readingTime": "16 min",
      "status": "current",
      "icon": Icons.assignment,
    },
    {
      "title": "Children's Privacy Notice",
      "description": "Special protections for users under 18",
      "lastUpdated": DateTime.now().subtract(Duration(days: 22)),
      "version": "2.0",
      "language": "en",
      "regions": ["global", "us", "eu"],
      "wordCount": 1234,
      "readingTime": "5 min",
      "status": "current",
      "icon": Icons.child_care,
    },
    {
      "title": "GDPR Rights Guide",
      "description": "Your rights under European data protection law",
      "lastUpdated": DateTime.now().subtract(Duration(days: 30)),
      "version": "1.5",
      "language": "en",
      "regions": ["eu"],
      "wordCount": 2789,
      "readingTime": "10 min",
      "status": "current",
      "icon": Icons.gavel,
    },
    {
      "title": "CCPA Privacy Rights",
      "description": "California Consumer Privacy Act disclosures",
      "lastUpdated": DateTime.now().subtract(Duration(days: 18)),
      "version": "2.3",
      "language": "en",
      "regions": ["us"],
      "wordCount": 2456,
      "readingTime": "9 min",
      "status": "current",
      "icon": Icons.balance,
    },
  ];

  List<Map<String, dynamic>> keyTopics = [
    {
      "topic": "Data Collection",
      "description": "What information we collect and how",
      "sections": ["Personal Information", "Usage Data", "Device Information", "Location Data"],
      "icon": Icons.bookmark,
      "color": Colors.blue,
    },
    {
      "topic": "Data Usage",
      "description": "How we use your information",
      "sections": ["Service Provision", "Personalization", "Analytics", "Marketing"],
      "icon": Icons.trending_up,
      "color": Colors.green,
    },
    {
      "topic": "Data Sharing",
      "description": "When and with whom we share data",
      "sections": ["Service Providers", "Legal Requirements", "Business Transfers", "Consent"],
      "icon": Icons.share,
      "color": Colors.orange,
    },
    {
      "topic": "Your Rights",
      "description": "What you can do with your data",
      "sections": ["Access", "Correction", "Deletion", "Portability", "Objection"],
      "icon": Icons.account_balance,
      "color": Colors.purple,
    },
    {
      "topic": "Security Measures",
      "description": "How we protect your information",
      "sections": ["Encryption", "Access Controls", "Monitoring", "Incident Response"],
      "icon": Icons.security,
      "color": Colors.red,
    },
    {
      "topic": "Contact & Support",
      "description": "How to reach us about privacy",
      "sections": ["Privacy Officer", "Support Channels", "Complaint Process", "Response Times"],
      "icon": Icons.support_agent,
      "color": Colors.teal,
    },
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case 'current':
        return successColor;
      case 'outdated':
        return warningColor;
      case 'draft':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Documentation"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor,
                    primaryColor.withAlpha(180),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(40),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.library_books,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Privacy Documentation Center",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Access privacy policies and documentation",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
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
            
            // Language and Region Settings
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.language,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Document Preferences",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Language",
                          items: languageOptions,
                          value: selectedLanguage,
                          onChanged: (value, label) {
                            selectedLanguage = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Region",
                          items: regionOptions,
                          value: selectedRegion,
                          onChanged: (value, label) {
                            selectedRegion = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  // Translation Options
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Translation Options",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                        
                        Row(
                          children: [
                            Expanded(
                              child: QSwitch(
                                items: [
                                  {
                                    "label": "Auto-translate documents",
                                    "value": true,
                                    "checked": autoTranslate,
                                  }
                                ],
                                value: [
                                  if (autoTranslate)
                                    {
                                      "label": "Auto-translate documents",
                                      "value": true,
                                      "checked": true
                                    }
                                ],
                                onChanged: (values, ids) {
                                  autoTranslate = values.isNotEmpty;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                        
                        Row(
                          children: [
                            Expanded(
                              child: QSwitch(
                                items: [
                                  {
                                    "label": "Show original text alongside translation",
                                    "value": true,
                                    "checked": showOriginalText,
                                  }
                                ],
                                value: [
                                  if (showOriginalText)
                                    {
                                      "label": "Show original text alongside translation",
                                      "value": true,
                                      "checked": true
                                    }
                                ],
                                onChanged: (values, ids) {
                                  showOriginalText = values.isNotEmpty;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Key Privacy Topics
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.topic,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Key Privacy Topics",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  
                  Text(
                    "Quick access to important privacy information",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: keyTopics.map((topic) {
                      Color topicColor = topic["color"] as Color;
                      List<String> sections = topic["sections"] as List<String>;
                      
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: topicColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: topicColor.withAlpha(60),
                          ),
                        ),
                        child: Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: topicColor.withAlpha(40),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    topic["icon"] as IconData,
                                    color: topicColor,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${topic["topic"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: topicColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            Text(
                              "${topic["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                            ),
                            
                            Column(
                              spacing: spXs,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: sections.map((section) {
                                return Row(
                                  children: [
                                    Container(
                                      width: 4,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: topicColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Expanded(
                                      child: Text(
                                        section,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                            
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: "Learn More",
                                size: bs.sm,
                                onPressed: () {
                                  // Navigate to topic details
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            
            // Privacy Documents
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.description,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Privacy Documents",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${privacyDocuments.length} Documents",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  ...privacyDocuments.map((document) {
                    DateTime lastUpdated = document["lastUpdated"] as DateTime;
                    Color statusColor = getStatusColor(document["status"]);
                    List<String> regions = document["regions"] as List<String>;
                    
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spSm,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  document["icon"] as IconData,
                                  color: primaryColor,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${document["title"]}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spSm,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: statusColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "v${document["version"]}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: statusColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${document["description"]}",
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
                          
                          // Document Stats
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: disabledColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Last Updated",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "${lastUpdated.dMMMy}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 20,
                                  color: disabledColor,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Length",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "${document["wordCount"]} words • ${document["readingTime"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 20,
                                  color: disabledColor,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Regions",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        regions.join(", ").toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Read Document",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to document view
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: QButton(
                                  label: "Download PDF",
                                  size: bs.sm,
                                  onPressed: () {
                                    si("Document download started");
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            
            // Quick Actions
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.flash_on,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Quick Actions",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Navigate to search
                          },
                          child: Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: infoColor,
                                  size: 24,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "Search Docs",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Navigate to changelog
                          },
                          child: Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.history,
                                  color: warningColor,
                                  size: 24,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "Change Log",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: warningColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Navigate to glossary
                          },
                          child: Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.menu_book,
                                  color: successColor,
                                  size: 24,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "Glossary",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Help & Support
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: infoColor.withAlpha(40),
                ),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.help,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Need Help Understanding Our Policies?",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Our privacy team is available to answer questions about our policies and your rights. Contact us for personalized assistance.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Contact Privacy Team",
                          size: bs.sm,
                          onPressed: () {
                            // Navigate to contact form
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Schedule Call",
                          size: bs.sm,
                          onPressed: () {
                            // Navigate to scheduling
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
