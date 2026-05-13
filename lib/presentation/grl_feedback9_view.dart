import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFeedback9View extends StatefulWidget {
  @override
  State<GrlFeedback9View> createState() => _GrlFeedback9ViewState();
}

class _GrlFeedback9ViewState extends State<GrlFeedback9View> {
  String selectedPlatform = "";
  String appVersion = "";
  String deviceModel = "";
  String osVersion = "";
  String issueCategory = "";
  String issueTitle = "";
  String issueDescription = "";
  String stepsToReproduce = "";
  String expectedBehavior = "";
  String actualBehavior = "";
  String frequency = "";
  String severity = "Medium";
  List<String> screenshots = [];
  List<String> logFiles = [];
  String userEmail = "";
  bool allowContact = false;
  bool betaTester = false;
  
  List<Map<String, dynamic>> platforms = [
    {
      "id": "mobile_ios",
      "name": "iOS Mobile App",
      "icon": Icons.phone_iphone,
      "color": Colors.blue,
    },
    {
      "id": "mobile_android",
      "name": "Android Mobile App",
      "icon": Icons.phone_android,
      "color": Colors.green,
    },
    {
      "id": "web_browser",
      "name": "Web Browser",
      "icon": Icons.web,
      "color": Colors.orange,
    },
    {
      "id": "desktop_windows",
      "name": "Windows Desktop",
      "icon": Icons.desktop_windows,
      "color": Colors.blue,
    },
    {
      "id": "desktop_mac",
      "name": "Mac Desktop",
      "icon": Icons.desktop_mac,
      "color": Colors.grey,
    },
    {
      "id": "tablet",
      "name": "Tablet",
      "icon": Icons.tablet,
      "color": Colors.purple,
    },
  ];
  
  List<Map<String, dynamic>> issueCategories = [
    {"label": "App Crashes", "value": "crashes"},
    {"label": "Performance Issues", "value": "performance"},
    {"label": "Login/Authentication", "value": "auth"},
    {"label": "User Interface", "value": "ui"},
    {"label": "Data Sync", "value": "sync"},
    {"label": "Network Connectivity", "value": "network"},
    {"label": "Feature Request", "value": "feature"},
    {"label": "Security Concern", "value": "security"},
    {"label": "Accessibility", "value": "accessibility"},
    {"label": "Other", "value": "other"},
  ];
  
  List<Map<String, dynamic>> frequencyOptions = [
    {"label": "Every time", "value": "always"},
    {"label": "Often", "value": "often"},
    {"label": "Sometimes", "value": "sometimes"},
    {"label": "Rarely", "value": "rarely"},
    {"label": "First time", "value": "once"},
  ];
  
  List<Map<String, dynamic>> severityLevels = [
    {"label": "Low", "value": "Low", "color": Colors.green, "description": "Minor inconvenience"},
    {"label": "Medium", "value": "Medium", "color": Colors.orange, "description": "Affects some functionality"},
    {"label": "High", "value": "High", "color": Colors.red, "description": "Major functionality broken"},
    {"label": "Critical", "value": "Critical", "color": Colors.red.shade900, "description": "App unusable"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bug Report"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              _showReportingTips();
            },
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveDraft();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [dangerColor, dangerColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.bug_report,
                    color: Colors.white,
                    size: 48,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Report a Bug or Issue",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Help us fix issues and improve the app",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Platform and Environment
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
                    "Platform & Environment",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  // Platform Selection
                  Text(
                    "Where did you encounter this issue?",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: platforms.map((platform) => GestureDetector(
                      onTap: () {
                        selectedPlatform = platform["id"];
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: selectedPlatform == platform["id"]
                              ? (platform["color"] as Color).withAlpha(20)
                              : Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: selectedPlatform == platform["id"]
                                ? platform["color"] as Color
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              platform["icon"] as IconData,
                              color: selectedPlatform == platform["id"]
                                  ? platform["color"] as Color
                                  : disabledBoldColor,
                              size: 24,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              platform["name"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: selectedPlatform == platform["id"]
                                    ? platform["color"] as Color
                                    : disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )).toList(),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // System Information
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "App Version",
                          value: appVersion,
                          hint: "e.g., 2.1.0",
                          onChanged: (value) {
                            appVersion = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTextField(
                          label: "Device Model",
                          value: deviceModel,
                          hint: "e.g., iPhone 13",
                          onChanged: (value) {
                            deviceModel = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  QTextField(
                    label: "OS Version",
                    value: osVersion,
                    hint: "e.g., iOS 16.0, Android 12, Windows 11",
                    onChanged: (value) {
                      osVersion = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Issue Details
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
                    "Issue Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  // Issue Category
                  QDropdownField(
                    label: "Issue Category",
                    items: issueCategories,
                    value: issueCategory,
                    onChanged: (value, label) {
                      issueCategory = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Issue Title
                  QTextField(
                    label: "Issue Title",
                    value: issueTitle,
                    hint: "Brief summary of the issue",
                    validator: Validator.required,
                    onChanged: (value) {
                      issueTitle = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Issue Description
                  QMemoField(
                    label: "Detailed Description",
                    value: issueDescription,
                    hint: "Describe the issue in detail. What happened? When did it occur?",
                    validator: Validator.required,
                    onChanged: (value) {
                      issueDescription = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Reproduction Steps
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
                  Row(
                    children: [
                      Icon(
                        Icons.repeat,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Reproduction Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  // Steps to Reproduce
                  QMemoField(
                    label: "Steps to Reproduce",
                    value: stepsToReproduce,
                    hint: "1. Open the app\n2. Navigate to...\n3. Tap on...\n4. Notice the issue...",
                    onChanged: (value) {
                      stepsToReproduce = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Expected vs Actual Behavior
                  Row(
                    children: [
                      Expanded(
                        child: QMemoField(
                          label: "Expected Behavior",
                          value: expectedBehavior,
                          hint: "What should happen?",
                          onChanged: (value) {
                            expectedBehavior = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QMemoField(
                          label: "Actual Behavior",
                          value: actualBehavior,
                          hint: "What actually happens?",
                          onChanged: (value) {
                            actualBehavior = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Frequency
                  QDropdownField(
                    label: "How often does this happen?",
                    items: frequencyOptions,
                    value: frequency,
                    onChanged: (value, label) {
                      frequency = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Severity and Priority
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
                    "Severity Level",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "How severely does this issue affect your use of the app?",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  ...severityLevels.map((level) => GestureDetector(
                    onTap: () {
                      severity = level["value"];
                      setState(() {});
                    },
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: severity == level["value"]
                            ? (level["color"] as Color).withAlpha(20)
                            : Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: severity == level["value"]
                              ? level["color"] as Color
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: level["color"] as Color,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.priority_high,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  level["label"],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: severity == level["value"]
                                        ? level["color"] as Color
                                        : Colors.black,
                                  ),
                                ),
                                Text(
                                  level["description"],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (severity == level["value"])
                            Icon(
                              Icons.check_circle,
                              color: level["color"] as Color,
                              size: 24,
                            ),
                        ],
                      ),
                    ),
                  )).toList(),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Attachments
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
                  Row(
                    children: [
                      Icon(
                        Icons.attach_file,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Supporting Files",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Screenshots, screen recordings, and log files help us understand the issue better",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  // Screenshots
                  QMultiImagePicker(
                    label: "Screenshots",
                    value: screenshots,
                    maxImages: 5,
                    hint: "Add screenshots showing the issue",
                    onChanged: (value) {
                      screenshots = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Log Files
                  QAttachmentPicker(
                    label: "Log Files",
                    value: logFiles,
                    hint: "Upload crash logs or error logs",
                    maxAttachments: 3,
                    onChanged: (value) {
                      logFiles = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Contact Information
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
                    "Contact & Follow-up",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  QTextField(
                    label: "Email Address",
                    value: userEmail,
                    hint: "your.email@example.com",
                    validator: Validator.email,
                    onChanged: (value) {
                      userEmail = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  QSwitch(
                    items: [
                      {
                        "label": "Allow developers to contact me for more details",
                        "value": "contact",
                        "checked": allowContact,
                      }
                    ],
                    value: [if (allowContact) {"label": "Allow developers to contact me for more details", "value": "contact", "checked": true}],
                    onChanged: (values, ids) {
                      allowContact = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  QSwitch(
                    items: [
                      {
                        "label": "I'm interested in beta testing new features",
                        "value": "beta",
                        "checked": betaTester,
                      }
                    ],
                    value: [if (betaTester) {"label": "I'm interested in beta testing new features", "value": "beta", "checked": true}],
                    onChanged: (values, ids) {
                      betaTester = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Guidelines
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Tips for Better Bug Reports",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  _buildTipItem("Be specific about what you were trying to do"),
                  _buildTipItem("Include step-by-step instructions"),
                  _buildTipItem("Attach screenshots or screen recordings"),
                  _buildTipItem("Mention if this worked before"),
                  _buildTipItem("Try reproducing the issue before reporting"),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Submit Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Save Draft",
                    size: bs.md,
                    color: Colors.grey.shade600,
                    onPressed: () {
                      _saveDraft();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: "Submit Bug Report",
                    size: bs.md,
                    onPressed: issueTitle.isNotEmpty && issueDescription.isNotEmpty && userEmail.isNotEmpty
                        ? () {
                            _submitBugReport();
                          }
                        : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            color: infoColor,
            size: 16,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: infoColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showReportingTips() {
    si("Bug reporting tips are displayed in the guidelines section below");
  }

  void _saveDraft() {
    if (issueTitle.isEmpty && issueDescription.isEmpty) {
      se("Please enter at least a title or description to save draft");
      return;
    }
    
    si("Bug report draft saved successfully!");
  }

  void _submitBugReport() {
    if (issueTitle.isEmpty) {
      se("Please enter an issue title");
      return;
    }
    
    if (issueDescription.isEmpty) {
      se("Please provide a detailed description");
      return;
    }
    
    if (userEmail.isEmpty) {
      se("Please provide your email address for follow-up");
      return;
    }
    
    showLoading();
    
    // Simulate API call
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Bug report submitted successfully! We'll investigate the issue.");
      
      // Reset form
      selectedPlatform = "";
      appVersion = "";
      deviceModel = "";
      osVersion = "";
      issueCategory = "";
      issueTitle = "";
      issueDescription = "";
      stepsToReproduce = "";
      expectedBehavior = "";
      actualBehavior = "";
      frequency = "";
      severity = "Medium";
      screenshots = [];
      logFiles = [];
      userEmail = "";
      allowContact = false;
      betaTester = false;
      setState(() {});
    });
  }
}
