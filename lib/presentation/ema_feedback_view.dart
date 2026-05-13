import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaFeedbackView extends StatefulWidget {
  const EmaFeedbackView({super.key});

  @override
  State<EmaFeedbackView> createState() => _EmaFeedbackViewState();
}

class _EmaFeedbackViewState extends State<EmaFeedbackView> {
  String feedbackText = "";
  String selectedCategory = "General";
  String selectedRating = "5";
  List<String> attachments = [];
  bool isAnonymous = false;
  bool allowContact = true;
  
  List<Map<String, dynamic>> categories = [
    {
      "label": "General",
      "value": "General",
      "icon": Icons.feedback,
      "description": "Overall experience and suggestions",
    },
    {
      "label": "Assessment",
      "value": "Assessment",
      "icon": Icons.assignment,
      "description": "About EMA questionnaires and tools",
    },
    {
      "label": "Technical",
      "value": "Technical",
      "icon": Icons.bug_report,
      "description": "App issues and technical problems",
    },
    {
      "label": "Feature Request",
      "value": "Feature Request",
      "icon": Icons.lightbulb,
      "description": "New features and improvements",
    },
  ];

  List<Map<String, dynamic>> recentFeedback = [
    {
      "id": 1,
      "title": "Assessment Timing",
      "category": "Assessment",
      "rating": 4,
      "status": "Under Review",
      "date": "2025-06-15",
      "response": "Thank you for your feedback. We're reviewing the timing options.",
    },
    {
      "id": 2,
      "title": "App Performance",
      "category": "Technical",
      "rating": 3,
      "status": "Resolved",
      "date": "2025-06-10",
      "response": "This issue has been fixed in the latest update.",
    },
    {
      "id": 3,
      "title": "New Feature Idea",
      "category": "Feature Request",
      "rating": 5,
      "status": "In Progress",
      "date": "2025-06-08",
      "response": "Great suggestion! We're working on implementing this feature.",
    },
  ];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback & Support"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // navigateTo('FeedbackHistoryView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Header Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(15),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: primaryColor.withAlpha(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.feedback,
                          color: primaryColor,
                          size: 32,
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "Share Your Feedback",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Help us improve your EMA experience",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${recentFeedback.length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Submitted",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 30,
                          color: disabledOutlineBorderColor,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${recentFeedback.where((f) => f["status"] == "Resolved").length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Resolved",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 30,
                          color: disabledOutlineBorderColor,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${(recentFeedback.map((f) => f["rating"] as int).fold(0, (sum, rating) => sum + rating) / recentFeedback.length).toStringAsFixed(1)}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Avg Rating",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
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

              // Category Selection
              Text(
                "Feedback Category",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ResponsiveGridView(
                minItemWidth: 200,
                children: categories.map((category) {
                  bool isSelected = category["value"] == selectedCategory;
                  
                  return GestureDetector(
                    onTap: () {
                      selectedCategory = category["value"];
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor.withAlpha(15) : Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        ),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: spSm,
                        children: [
                          Icon(
                            category["icon"],
                            size: 32,
                            color: isSelected ? primaryColor : disabledBoldColor,
                          ),
                          Text(
                            "${category["label"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? primaryColor : Colors.black,
                            ),
                          ),
                          Text(
                            "${category["description"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

              // Rating
              QDropdownField(
                label: "Overall Rating",
                items: [
                  {"label": "⭐ 1 - Poor", "value": "1"},
                  {"label": "⭐⭐ 2 - Fair", "value": "2"},
                  {"label": "⭐⭐⭐ 3 - Good", "value": "3"},
                  {"label": "⭐⭐⭐⭐ 4 - Very Good", "value": "4"},
                  {"label": "⭐⭐⭐⭐⭐ 5 - Excellent", "value": "5"},
                ],
                value: selectedRating,
                validator: Validator.required,
                onChanged: (value, label) {
                  selectedRating = value;
                  setState(() {});
                },
              ),

              // Feedback Text
              QMemoField(
                label: "Your Feedback",
                value: feedbackText,
                hint: "Please share your thoughts, suggestions, or report any issues...",
                validator: Validator.required,
                onChanged: (value) {
                  feedbackText = value;
                  setState(() {});
                },
              ),

              // Attachments
              QAttachmentPicker(
                label: "Attachments (Optional)",
                value: attachments,
                hint: "Add screenshots or files to support your feedback",
                maxAttachments: 5,
                allowedTypes: ['image', 'document'],
                onChanged: (value) {
                  attachments = value;
                  setState(() {});
                },
              ),

              // Privacy Options
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(15),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: infoColor.withAlpha(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Privacy Options",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Submit anonymously",
                          "value": true,
                          "checked": isAnonymous,
                        }
                      ],
                      value: [if (isAnonymous) {"label": "Submit anonymously", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        setState(() {
                          isAnonymous = values.isNotEmpty;
                        });
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Allow follow-up contact",
                          "value": true,
                          "checked": allowContact,
                        }
                      ],
                      value: [if (allowContact) {"label": "Allow follow-up contact", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        setState(() {
                          allowContact = values.isNotEmpty;
                        });
                      },
                    ),
                  ],
                ),
              ),

              // Submit Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Submit Feedback",
                  size: bs.md,
                  onPressed: () {
                    _submitFeedback();
                  },
                ),
              ),

              // Recent Feedback
              Text(
                "Recent Feedback",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Column(
                spacing: spSm,
                children: recentFeedback.map((feedback) {
                  Color statusColor = _getStatusColor(feedback["status"]);
                  Color ratingColor = _getRatingColor(feedback["rating"]);
                  
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: statusColor,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "${feedback["title"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${feedback["category"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(15),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${feedback["status"]}",
                                style: TextStyle(
                                  color: statusColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  Icons.star,
                                  size: 16,
                                  color: index < (feedback["rating"] as int) 
                                      ? ratingColor 
                                      : disabledColor,
                                );
                              }),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${feedback["rating"]}/5",
                              style: TextStyle(
                                color: ratingColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${feedback["date"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),

                        if (feedback["response"] != null)
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(15),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "Response:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "${feedback["response"]}",
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
                  );
                }).toList(),
              ),

              // Contact Information
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(15),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: warningColor.withAlpha(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Need Immediate Help?",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "For urgent issues or immediate support, please contact:",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.email,
                          color: primaryColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "support@ema-research.com",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: primaryColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "+1 (555) 123-4567",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
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

  void _submitFeedback() {
    if (!formKey.currentState!.validate()) {
      se("Please fill in all required fields");
      return;
    }

    if (feedbackText.trim().isEmpty) {
      se("Please provide your feedback");
      return;
    }

    showLoading();

    // Simulate API call
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      
      Map<String, dynamic> newFeedback = {
        "id": recentFeedback.length + 1,
        "title": selectedCategory == "General" ? "General Feedback" : selectedCategory,
        "category": selectedCategory,
        "rating": int.parse(selectedRating),
        "status": "Under Review",
        "date": DateTime.now().toString().split(' ')[0],
        "response": null,
      };

      setState(() {
        recentFeedback.insert(0, newFeedback);
        feedbackText = "";
        selectedRating = "5";
        attachments.clear();
        isAnonymous = false;
        allowContact = true;
      });

      ss("Feedback submitted successfully! We'll review it and get back to you.");
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Resolved":
        return successColor;
      case "In Progress":
        return warningColor;
      case "Under Review":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getRatingColor(int rating) {
    if (rating >= 4) return successColor;
    if (rating >= 3) return warningColor;
    return dangerColor;
  }
}
