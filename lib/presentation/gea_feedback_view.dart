import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaFeedbackView extends StatefulWidget {
  const GeaFeedbackView({super.key});

  @override
  State<GeaFeedbackView> createState() => _GeaFeedbackViewState();
}

class _GeaFeedbackViewState extends State<GeaFeedbackView> {
  final formKey = GlobalKey<FormState>();
  String feedbackType = "Bug Report";
  String subject = "";
  String description = "";
  String email = "";
  List<String> attachments = [];
  int rating = 5;
  bool isUrgent = false;

  List<Map<String, dynamic>> feedbackTypeItems = [
    {"label": "Bug Report", "value": "Bug Report"},
    {"label": "Feature Request", "value": "Feature Request"},
    {"label": "General Feedback", "value": "General Feedback"},
    {"label": "Performance Issue", "value": "Performance Issue"},
    {"label": "UI/UX Feedback", "value": "UI/UX Feedback"},
    {"label": "Other", "value": "Other"},
  ];

  List<Map<String, dynamic>> recentFeedback = [
    {
      "id": "FB001",
      "type": "Bug Report",
      "subject": "App crashes on startup",
      "status": "In Progress",
      "date": "2024-12-10",
      "priority": "High",
    },
    {
      "id": "FB002", 
      "type": "Feature Request",
      "subject": "Add dark mode support",
      "status": "Under Review",
      "date": "2024-12-08",
      "priority": "Medium",
    },
    {
      "id": "FB003",
      "type": "General Feedback",
      "subject": "Great app overall!",
      "status": "Resolved",
      "date": "2024-12-05",
      "priority": "Low",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback & Support"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // View feedback history
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
              // Feedback Form Section
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Submit Feedback",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QDropdownField(
                      label: "Feedback Type",
                      items: feedbackTypeItems,
                      value: feedbackType,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        feedbackType = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Subject",
                      value: subject,
                      hint: "Brief description of your feedback",
                      validator: Validator.required,
                      onChanged: (value) {
                        subject = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Email Address",
                      value: email,
                      hint: "We'll use this to follow up with you",
                      validator: Validator.email,
                      onChanged: (value) {
                        email = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Description",
                      value: description,
                      hint: "Please provide detailed information about your feedback",
                      validator: Validator.required,
                      onChanged: (value) {
                        description = value;
                        setState(() {});
                      },
                    ),
                    // Rating Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "Overall Rating",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Row(
                          children: List.generate(5, (index) {
                            return GestureDetector(
                              onTap: () {
                                rating = index + 1;
                                setState(() {});
                              },
                              child: Icon(
                                index < rating ? Icons.star : Icons.star_border,
                                color: warningColor,
                                size: 28,
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                    // Priority Toggle
                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Mark as Urgent",
                                "value": true,
                                "checked": isUrgent,
                              }
                            ],
                            value: [
                              if (isUrgent)
                                {
                                  "label": "Mark as Urgent",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              isUrgent = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QAttachmentPicker(
                      label: "Attachments",
                      value: attachments,
                      hint: "Add screenshots or relevant files",
                      maxAttachments: 5,
                      onChanged: (value) {
                        attachments = value;
                        setState(() {});
                      },
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Submit Feedback",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            _submitFeedback();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Recent Feedback Section
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Recent Feedback",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        QButton(
                          label: "View All",
                          size: bs.sm,
                          onPressed: () {
                            // Navigate to feedback history
                          },
                        ),
                      ],
                    ),
                    ...recentFeedback.map((feedback) {
                      Color statusColor = _getStatusColor("${feedback["status"]}");
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: statusColor,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${feedback["subject"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: statusColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${feedback["status"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: statusColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "ID: ${feedback["id"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${feedback["type"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${feedback["date"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),

              // Quick Actions Section
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Quick Actions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: [
                        _buildQuickActionCard(
                          "FAQ",
                          "Browse frequently asked questions",
                          Icons.help,
                          primaryColor,
                        ),
                        _buildQuickActionCard(
                          "Contact Support",
                          "Get direct help from our team",
                          Icons.support_agent,
                          infoColor,
                        ),
                        _buildQuickActionCard(
                          "Feature Requests",
                          "Suggest new features",
                          Icons.lightbulb,
                          warningColor,
                        ),
                        _buildQuickActionCard(
                          "Report Bug",
                          "Report technical issues",
                          Icons.bug_report,
                          dangerColor,
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

  Widget _buildQuickActionCard(String title, String description, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        // Handle quick action
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: color.withAlpha(30),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spXs,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "In Progress":
        return warningColor;
      case "Under Review":
        return infoColor;
      case "Resolved":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _submitFeedback() {
    // Simulate feedback submission
    ss("Feedback submitted successfully! We'll get back to you soon.");
    
    // Reset form
    subject = "";
    description = "";
    email = "";
    attachments = [];
    rating = 5;
    isUrgent = false;
    setState(() {});
  }
}
