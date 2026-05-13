import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaSubmitStoryView extends StatefulWidget {
  const NmaSubmitStoryView({super.key});

  @override
  State<NmaSubmitStoryView> createState() => _NmaSubmitStoryViewState();
}

class _NmaSubmitStoryViewState extends State<NmaSubmitStoryView> {
  final formKey = GlobalKey<FormState>();
  
  String storyTitle = "";
  String storyCategory = "General News";
  String priority = "Medium";
  String location = "";
  String storyContent = "";
  String sourceInformation = "";
  List<String> uploadedImages = [];
  List<String> uploadedVideos = [];
  List<String> attachments = [];
  String tags = "";
  bool agreeToTerms = false;
  bool allowContact = true;
  bool isBreakingNews = false;
  bool isWitnessAccount = false;
  bool requestAnonymity = false;

  List<String> categories = [
    "General News",
    "Breaking News",
    "Local Government",
    "Community Events",
    "Business & Economy",
    "Education",
    "Healthcare",
    "Environment",
    "Transportation",
    "Safety & Crime",
    "Sports & Recreation",
    "Arts & Culture",
  ];

  List<String> priorities = [
    "Low",
    "Medium",
    "High",
    "Urgent",
  ];

  List<Map<String, dynamic>> submissionTips = [
    {
      "icon": Icons.fact_check,
      "title": "Verify Facts",
      "description": "Double-check all information before submitting",
      "color": successColor,
    },
    {
      "icon": Icons.camera_alt,
      "title": "Include Media",
      "description": "Photos and videos help tell your story better",
      "color": infoColor,
    },
    {
      "icon": Icons.location_on,
      "title": "Provide Location",
      "description": "Specific locations help readers understand context",
      "color": warningColor,
    },
    {
      "icon": Icons.schedule,
      "title": "Be Timely",
      "description": "Submit stories as soon as possible after events",
      "color": primaryColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Submit Story"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              // Show submission guidelines
            },
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with tips
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withAlpha(180)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Share Your Story",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Help keep your community informed by sharing news, events, and important information.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(220),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spMd),

              // Quick tips
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Submission Tips",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ResponsiveGridView(
                      minItemWidth: 200,
                      children: submissionTips.map((tip) {
                        return Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: (tip["color"] as Color).withAlpha(100),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                tip["icon"] as IconData,
                                size: 16,
                                color: tip["color"] as Color,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${tip["title"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${tip["description"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spMd),

              // Story Type Selection
              Text(
                "Story Type",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Column(
                children: [
                  QSwitch(
                    items: [
                      {
                        "label": "Breaking News",
                        "value": true,
                        "checked": isBreakingNews,
                      }
                    ],
                    value: isBreakingNews ? [{"label": "Breaking News", "value": true, "checked": true}] : [],
                    onChanged: (values, ids) {
                      isBreakingNews = values.isNotEmpty;
                      if (isBreakingNews) {
                        priority = "Urgent";
                        storyCategory = "Breaking News";
                      }
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QSwitch(
                    items: [
                      {
                        "label": "Eyewitness Account",
                        "value": true,
                        "checked": isWitnessAccount,
                      }
                    ],
                    value: isWitnessAccount ? [{"label": "Eyewitness Account", "value": true, "checked": true}] : [],
                    onChanged: (values, ids) {
                      isWitnessAccount = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
              SizedBox(height: spMd),

              // Basic Information
              Text(
                "Basic Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              QTextField(
                label: "Story Title",
                value: storyTitle,
                hint: "Write a clear, descriptive headline",
                validator: Validator.required,
                onChanged: (value) {
                  storyTitle = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),

              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Category",
                      items: categories.map((category) => {
                        "label": category,
                        "value": category,
                      }).toList(),
                      value: storyCategory,
                      onChanged: (value, label) {
                        storyCategory = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Priority",
                      items: priorities.map((priority) => {
                        "label": priority,
                        "value": priority,
                      }).toList(),
                      value: priority,
                      onChanged: (value, label) {
                        priority = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),

              QTextField(
                label: "Location",
                value: location,
                hint: "Where did this happen? (Street, building, area)",
                validator: Validator.required,
                onChanged: (value) {
                  location = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),

              // Story Content
              Text(
                "Story Content",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              QMemoField(
                label: "Story Description",
                value: storyContent,
                hint: "Tell the full story - what happened, when, who was involved, and why it matters. Include as much detail as possible.",
                validator: Validator.required,
                onChanged: (value) {
                  storyContent = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),

              QMemoField(
                label: "Source Information",
                value: sourceInformation,
                hint: "How did you learn about this? Are you a witness? Did someone tell you? Include any relevant source details.",
                onChanged: (value) {
                  sourceInformation = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),

              // Media Upload
              Text(
                "Media & Attachments",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              QMultiImagePicker(
                label: "Photos",
                value: uploadedImages,
                hint: "Add photos that support your story",
                maxImages: 5,
                onChanged: (value) {
                  uploadedImages = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),

              QAttachmentPicker(
                label: "Video/Audio Files",
                value: attachments,
                hint: "Upload video or audio files (if any)",
                maxAttachments: 3,
                allowedTypes: ['video', 'audio'],
                onChanged: (value) {
                  attachments = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),

              // Additional Information
              Text(
                "Additional Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              QTextField(
                label: "Tags",
                value: tags,
                hint: "Add relevant tags separated by commas (e.g., traffic, emergency, downtown)",
                onChanged: (value) {
                  tags = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),

              // Privacy Settings
              Text(
                "Privacy & Contact Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              Column(
                children: [
                  QSwitch(
                    items: [
                      {
                        "label": "Allow editors to contact me for clarification",
                        "value": true,
                        "checked": allowContact,
                      }
                    ],
                    value: allowContact ? [{"label": "Allow editors to contact me for clarification", "value": true, "checked": true}] : [],
                    onChanged: (values, ids) {
                      allowContact = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QSwitch(
                    items: [
                      {
                        "label": "Request anonymity (don't publish my name)",
                        "value": true,
                        "checked": requestAnonymity,
                      }
                    ],
                    value: requestAnonymity ? [{"label": "Request anonymity (don't publish my name)", "value": true, "checked": true}] : [],
                    onChanged: (values, ids) {
                      requestAnonymity = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
              SizedBox(height: spMd),

              // Terms and Conditions
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Terms and Conditions",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "By submitting this story, you confirm that:",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Column(
                      children: [
                        _buildTermItem("The information provided is accurate to the best of your knowledge"),
                        _buildTermItem("You have the right to share any photos or media included"),
                        _buildTermItem("You understand this content may be edited for clarity and accuracy"),
                        _buildTermItem("You agree to our community guidelines and editorial standards"),
                      ],
                    ),
                    SizedBox(height: spSm),
                    QSwitch(
                      items: [
                        {
                          "label": "I agree to the terms and conditions",
                          "value": true,
                          "checked": agreeToTerms,
                        }
                      ],
                      value: agreeToTerms ? [{"label": "I agree to the terms and conditions", "value": true, "checked": true}] : [],
                      onChanged: (values, ids) {
                        agreeToTerms = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: spMd),

              // Submission Preview
              if (storyTitle.isNotEmpty) ...[
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Submission Preview",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getPriorityColor(priority).withAlpha(100),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$priority Priority",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: _getPriorityColor(priority),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        storyTitle,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      if (location.isNotEmpty)
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 14,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              location,
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      if (storyContent.isNotEmpty) ...[
                        SizedBox(height: spSm),
                        Text(
                          storyContent,
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      if (uploadedImages.isNotEmpty) ...[
                        SizedBox(height: spSm),
                        Text(
                          "${uploadedImages.length} image(s) attached",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: spMd),
              ],

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Save Draft",
                      size: bs.md,
                      onPressed: () {
                        // Save draft logic
                        ss("Draft saved successfully");
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    flex: 2,
                    child: QButton(
                      label: isBreakingNews ? "Submit Breaking News" : "Submit Story",
                      size: bs.md,
                      onPressed: agreeToTerms && storyTitle.isNotEmpty && storyContent.isNotEmpty && location.isNotEmpty
                          ? () async {
                              if (formKey.currentState!.validate()) {
                                showLoading();
                                
                                // Simulate submission
                                await Future.delayed(Duration(seconds: 2));
                                
                                hideLoading();
                                ss("Story submitted successfully! Our editorial team will review it shortly.");
                                
                                // Clear form
                                storyTitle = "";
                                storyContent = "";
                                location = "";
                                sourceInformation = "";
                                tags = "";
                                uploadedImages.clear();
                                attachments.clear();
                                agreeToTerms = false;
                                isBreakingNews = false;
                                isWitnessAccount = false;
                                requestAnonymity = false;
                                allowContact = true;
                                storyCategory = "General News";
                                priority = "Medium";
                                setState(() {});
                              }
                            }
                          : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),

              // Help section
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.help_outline,
                          size: 20,
                          color: primaryColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Need Help?",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "If you have questions about submitting your story or need guidance on what information to include, our editorial team is here to help.",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Contact Editorial",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "View Guidelines",
                            size: bs.sm,
                            onPressed: () {},
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
      ),
    );
  }

  Widget _buildTermItem(String text) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 6),
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Urgent":
        return dangerColor;
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }
}
