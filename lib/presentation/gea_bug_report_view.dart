import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaBugReportView extends StatefulWidget {
  const GeaBugReportView({super.key});

  @override
  State<GeaBugReportView> createState() => _GeaBugReportViewState();
}

class _GeaBugReportViewState extends State<GeaBugReportView> {
  final formKey = GlobalKey<FormState>();
  
  String bugTitle = "";
  String bugDescription = "";
  String selectedCategory = "ui";
  String selectedPriority = "medium";
  String selectedDevice = "mobile";
  String stepsToReproduce = "";
  String expectedBehavior = "";
  String actualBehavior = "";
  String additionalInfo = "";
  List<String> attachments = [];
  bool includeSystemInfo = true;
  bool allowContact = true;
  String contactEmail = "";

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "User Interface", "value": "ui"},
    {"label": "Performance", "value": "performance"},
    {"label": "Functionality", "value": "functionality"},
    {"label": "Crash/Freeze", "value": "crash"},
    {"label": "Data/Sync", "value": "data"},
    {"label": "Security", "value": "security"},
    {"label": "Other", "value": "other"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "Low", "value": "low"},
    {"label": "Medium", "value": "medium"},
    {"label": "High", "value": "high"},
    {"label": "Critical", "value": "critical"},
  ];

  List<Map<String, dynamic>> deviceOptions = [
    {"label": "Mobile (Android)", "value": "mobile"},
    {"label": "Mobile (iOS)", "value": "ios"},
    {"label": "Desktop (Windows)", "value": "windows"},
    {"label": "Desktop (macOS)", "value": "macos"},
    {"label": "Desktop (Linux)", "value": "linux"},
    {"label": "Web Browser", "value": "web"},
  ];

  Map<String, dynamic> systemInfo = {
    "appVersion": "2.5.0",
    "osVersion": "Android 14",
    "deviceModel": "Pixel 7 Pro",
    "screenResolution": "1440x3120",
    "availableRAM": "8 GB",
    "storageSpace": "256 GB",
    "networkType": "WiFi",
    "timestamp": DateTime.now().toIso8601String(),
  };

  Widget _buildBugReportForm() {
    return Form(
      key: formKey,
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: infoColor,
                  size: 24,
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Help us fix bugs faster",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Please provide as much detail as possible to help our team identify and resolve the issue quickly.",
                        style: TextStyle(
                          fontSize: 13,
                          color: infoColor.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          Text(
            "Bug Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          QTextField(
            label: "Bug Title",
            value: bugTitle,
            validator: Validator.required,
            hint: "Brief description of the issue",
            onChanged: (value) {
              bugTitle = value;
              setState(() {});
            },
          ),
          
          QMemoField(
            label: "Bug Description",
            value: bugDescription,
            validator: Validator.required,
            hint: "Detailed description of what went wrong",
            onChanged: (value) {
              bugDescription = value;
              setState(() {});
            },
          ),
          
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryOptions,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QDropdownField(
                  label: "Priority",
                  items: priorityOptions,
                  value: selectedPriority,
                  onChanged: (value, label) {
                    selectedPriority = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          QDropdownField(
            label: "Device/Platform",
            items: deviceOptions,
            value: selectedDevice,
            onChanged: (value, label) {
              selectedDevice = value;
              setState(() {});
            },
          ),
          
          Text(
            "Steps to Reproduce",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          QMemoField(
            label: "Steps to Reproduce",
            value: stepsToReproduce,
            validator: Validator.required,
            hint: "1. Go to...\n2. Click on...\n3. Notice that...",
            onChanged: (value) {
              stepsToReproduce = value;
              setState(() {});
            },
          ),
          
          QMemoField(
            label: "Expected Behavior",
            value: expectedBehavior,
            validator: Validator.required,
            hint: "What should have happened?",
            onChanged: (value) {
              expectedBehavior = value;
              setState(() {});
            },
          ),
          
          QMemoField(
            label: "Actual Behavior",
            value: actualBehavior,
            validator: Validator.required,
            hint: "What actually happened instead?",
            onChanged: (value) {
              actualBehavior = value;
              setState(() {});
            },
          ),
          
          QMemoField(
            label: "Additional Information",
            value: additionalInfo,
            hint: "Any other relevant details, error messages, or context",
            onChanged: (value) {
              additionalInfo = value;
              setState(() {});
            },
          ),
          
          Text(
            "Attachments",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          QMultiImagePicker(
            label: "Screenshots/Videos",
            value: attachments,
            hint: "Add screenshots or screen recordings to help explain the issue",
            maxImages: 5,
            onChanged: (value) {
              attachments = value;
              setState(() {});
            },
          ),
          
          Text(
            "System Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          QSwitch(
            items: [
              {
                "label": "Include system information with this report",
                "value": true,
                "checked": includeSystemInfo,
              }
            ],
            value: [
              if (includeSystemInfo)
                {
                  "label": "Include system information with this report",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              includeSystemInfo = values.isNotEmpty;
              setState(() {});
            },
          ),
          
          if (includeSystemInfo) ...[
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "System Information Preview",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...systemInfo.entries.map((entry) => 
                    Padding(
                      padding: EdgeInsets.only(bottom: spXs),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "${entry.key}:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              "${entry.value}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).toList(),
                ],
              ),
            ),
          ],
          
          Text(
            "Contact Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          QSwitch(
            items: [
              {
                "label": "Allow our team to contact me for follow-up questions",
                "value": true,
                "checked": allowContact,
              }
            ],
            value: [
              if (allowContact)
                {
                  "label": "Allow our team to contact me for follow-up questions",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              allowContact = values.isNotEmpty;
              setState(() {});
            },
          ),
          
          if (allowContact) ...[
            QTextField(
              label: "Contact Email",
              value: contactEmail,
              validator: Validator.email,
              hint: "your.email@domain.com",
              onChanged: (value) {
                contactEmail = value;
                setState(() {});
              },
            ),
          ],
          
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: warningColor.withAlpha(50)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.warning,
                  color: warningColor,
                  size: 20,
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Privacy Notice",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Bug reports may contain sensitive information. Please review your submission before sending. We handle all reports confidentially according to our privacy policy.",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Save as Draft",
                  size: bs.md,
                  onPressed: () {
                    // Save draft
                    ss("Bug report saved as draft");
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                flex: 2,
                child: QButton(
                  label: "Submit Bug Report",
                  size: bs.md,
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      showLoading();
                      await Future.delayed(Duration(seconds: 2));
                      hideLoading();
                      ss("Bug report submitted successfully");
                      back();
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickReportOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Report",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Common issues that can be reported quickly",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spMd),
        
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  // Quick report - App crash
                  bugTitle = "App crashes unexpectedly";
                  selectedCategory = "crash";
                  selectedPriority = "high";
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error,
                        color: dangerColor,
                        size: 24,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "App Crash",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "The app crashes or freezes unexpectedly",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              Divider(height: 1),
              GestureDetector(
                onTap: () {
                  // Quick report - Performance issue
                  bugTitle = "App is running slowly";
                  selectedCategory = "performance";
                  selectedPriority = "medium";
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  child: Row(
                    children: [
                      Icon(
                        Icons.speed,
                        color: warningColor,
                        size: 24,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Performance Issue",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "App is slow, laggy, or unresponsive",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              Divider(height: 1),
              GestureDetector(
                onTap: () {
                  // Quick report - Feature not working
                  bugTitle = "Feature is not working properly";
                  selectedCategory = "functionality";
                  selectedPriority = "medium";
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  child: Row(
                    children: [
                      Icon(
                        Icons.build,
                        color: infoColor,
                        size: 24,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Feature Not Working",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "A feature doesn't work as expected",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              Divider(height: 1),
              GestureDetector(
                onTap: () {
                  // Quick report - UI issue
                  bugTitle = "User interface display issue";
                  selectedCategory = "ui";
                  selectedPriority = "low";
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  child: Row(
                    children: [
                      Icon(
                        Icons.design_services,
                        color: successColor,
                        size: 24,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "UI/Display Issue",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Layout problems or visual glitches",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report a Bug"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (bugTitle.isEmpty) ...[
              _buildQuickReportOptions(),
              SizedBox(height: spXl),
              Text(
                "Or create a detailed report",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
            ],
            _buildBugReportForm(),
          ],
        ),
      ),
    );
  }
}
