import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAbout10View extends StatefulWidget {
  @override
  State<GrlAbout10View> createState() => _GrlAbout10ViewState();
}

class _GrlAbout10ViewState extends State<GrlAbout10View> {
  String selectedLanguage = 'en';
  String selectedRegion = 'global';
  bool subscribeNewsletter = false;
  String name = '';
  String email = '';
  String message = '';
  
  List<Map<String, dynamic>> languages = [
    {"label": "English", "value": "en"},
    {"label": "Español", "value": "es"},
    {"label": "Français", "value": "fr"},
    {"label": "Deutsch", "value": "de"},
    {"label": "中文", "value": "zh"},
    {"label": "日本語", "value": "ja"},
  ];
  
  List<Map<String, dynamic>> regions = [
    {"label": "Global", "value": "global"},
    {"label": "North America", "value": "na"},
    {"label": "Europe", "value": "eu"},
    {"label": "Asia Pacific", "value": "ap"},
    {"label": "Latin America", "value": "la"},
    {"label": "Middle East & Africa", "value": "mea"},
  ];
  
  List<Map<String, dynamic>> companyStats = [
    {
      "title": "Years of Excellence",
      "value": "15+",
      "icon": Icons.timeline,
      "color": "primary",
    },
    {
      "title": "Global Offices",
      "value": "25",
      "icon": Icons.business,
      "color": "success",
    },
    {
      "title": "Happy Clients",
      "value": "10K+",
      "icon": Icons.people,
      "color": "info",
    },
    {
      "title": "Projects Delivered",
      "value": "500+",
      "icon": Icons.check_circle,
      "color": "warning",
    },
  ];
  
  List<Map<String, dynamic>> socialMedia = [
    {
      "platform": "LinkedIn",
      "icon": Icons.business,
      "followers": "50K+",
      "url": "linkedin.com/company/ourcompany",
    },
    {
      "platform": "Twitter",
      "icon": Icons.alternate_email,
      "followers": "25K+",
      "url": "twitter.com/ourcompany",
    },
    {
      "platform": "Instagram",
      "icon": Icons.camera_alt,
      "followers": "15K+",
      "url": "instagram.com/ourcompany",
    },
    {
      "platform": "YouTube",
      "icon": Icons.play_circle,
      "followers": "100K+",
      "url": "youtube.com/ourcompany",
    },
  ];
  
  List<Map<String, dynamic>> quickLinks = [
    {"title": "About Us", "icon": Icons.info, "category": "company"},
    {"title": "Our Services", "icon": Icons.work, "category": "services"},
    {"title": "Portfolio", "icon": Icons.folder, "category": "work"},
    {"title": "Careers", "icon": Icons.person_add, "category": "jobs"},
    {"title": "Blog", "icon": Icons.article, "category": "resources"},
    {"title": "Contact", "icon": Icons.contact_mail, "category": "support"},
    {"title": "Privacy Policy", "icon": Icons.privacy_tip, "category": "legal"},
    {"title": "Terms of Service", "icon": Icons.description, "category": "legal"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Company Overview"),
        actions: [
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {
              _showLanguageSelector();
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Company information shared successfully!");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company Hero Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.business,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "TechSolutions Inc.",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Innovating Tomorrow's Technology Today",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "We are a leading technology company specializing in digital transformation, cloud solutions, and innovative software development. Our mission is to empower businesses worldwide with cutting-edge technology solutions.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Company Stats
            ResponsiveGridView(
              padding: EdgeInsets.all(0),
              minItemWidth: 200,
              children: companyStats.map((stat) => Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      stat["icon"],
                      color: _getStatColor(stat["color"]),
                      size: 40,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${stat["value"]}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: _getStatColor(stat["color"]),
                      ),
                    ),
                    Text(
                      "${stat["title"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Quick Links
            Text(
              "Quick Links",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ResponsiveGridView(
              padding: EdgeInsets.all(0),
              minItemWidth: 200,
              children: quickLinks.map((link) => GestureDetector(
                onTap: () {
                  ss("Navigating to ${link["title"]}");
                },
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: _getCategoryColor(link["category"]),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: _getCategoryColor(link["category"]).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          link["icon"],
                          color: _getCategoryColor(link["category"]),
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Text(
                          "${link["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                    ],
                  ),
                ),
              )).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Social Media
            Text(
              "Follow Us",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            QHorizontalScroll(
              children: socialMedia.map((social) => Container(
                width: 160,
                margin: EdgeInsets.only(right: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        social["icon"],
                        color: primaryColor,
                        size: 30,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${social["platform"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${social["followers"]} followers",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QButton(
                      label: "Follow",
                      size: bs.sm,
                      onPressed: () {
                        ss("Following ${social["platform"]}!");
                      },
                    ),
                  ],
                ),
              )).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Settings & Preferences
            Container(
              width: double.infinity,
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
                    "Preferences",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  QDropdownField(
                    label: "Language",
                    items: languages,
                    value: selectedLanguage,
                    onChanged: (value, label) {
                      selectedLanguage = value;
                      setState(() {});
                      ss("Language updated to $label");
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  QDropdownField(
                    label: "Region",
                    items: regions,
                    value: selectedRegion,
                    onChanged: (value, label) {
                      selectedRegion = value;
                      setState(() {});
                      ss("Region updated to $label");
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  QSwitch(
                    items: [
                      {
                        "label": "Subscribe to Newsletter",
                        "value": true,
                        "checked": subscribeNewsletter,
                      }
                    ],
                    value: [
                      if (subscribeNewsletter)
                        {
                          "label": "Subscribe to Newsletter",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      subscribeNewsletter = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Contact Form
            Container(
              width: double.infinity,
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
                    "Get in Touch",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  QTextField(
                    label: "Your Name",
                    value: name,
                    hint: "Enter your full name",
                    onChanged: (value) {
                      name = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  QTextField(
                    label: "Email Address",
                    value: email,
                    hint: "Enter your email address",
                    onChanged: (value) {
                      email = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  QMemoField(
                    label: "Message",
                    value: message,
                    hint: "Tell us how we can help you...",
                    onChanged: (value) {
                      message = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Send Message",
                      onPressed: () {
                        if (name.isNotEmpty && email.isNotEmpty && message.isNotEmpty) {
                          ss("Message sent successfully! We'll get back to you soon.");
                          name = '';
                          email = '';
                          message = '';
                          setState(() {});
                        } else {
                          se("Please fill in all required fields");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Company Info Footer
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "TechSolutions Inc.",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "1234 Innovation Drive, Tech City, TC 12345",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: 16,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "+1 (555) 123-4567",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Icon(
                        Icons.email,
                        size: 16,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "info@techsolutions.com",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.web,
                        size: 16,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "www.techsolutions.com",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Divider(color: primaryColor.withAlpha(100)),
                  
                  SizedBox(height: spSm),
                  
                  Text(
                    "© 2024 TechSolutions Inc. All rights reserved.",
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
    );
  }
  
  void _showLanguageSelector() {
    // Language selector modal would be implemented here
    ss("Language selector opened");
  }
  
  Color _getStatColor(String colorType) {
    switch (colorType) {
      case 'primary':
        return primaryColor;
      case 'success':
        return successColor;
      case 'info':
        return infoColor;
      case 'warning':
        return warningColor;
      default:
        return primaryColor;
    }
  }
  
  Color _getCategoryColor(String category) {
    switch (category) {
      case 'company':
        return primaryColor;
      case 'services':
        return successColor;
      case 'work':
        return infoColor;
      case 'jobs':
        return warningColor;
      case 'resources':
        return primaryColor;
      case 'support':
        return successColor;
      case 'legal':
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }
}
