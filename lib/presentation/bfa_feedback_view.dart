import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaFeedbackView extends StatefulWidget {
  const BfaFeedbackView({super.key});

  @override
  State<BfaFeedbackView> createState() => _BfaFeedbackViewState();
}

class _BfaFeedbackViewState extends State<BfaFeedbackView> {
  String feedbackType = "General Feedback";
  String subject = "";
  String message = "";
  String email = "";
  int rating = 0;
  bool includeSystemInfo = true;
  bool allowContact = true;
  List<String> attachments = [];

  List<Map<String, dynamic>> feedbackTypes = [
    {"label": "General Feedback", "value": "General Feedback"},
    {"label": "Bug Report", "value": "Bug Report"},
    {"label": "Feature Request", "value": "Feature Request"},
    {"label": "Performance Issue", "value": "Performance Issue"},
    {"label": "UI/UX Feedback", "value": "UI/UX Feedback"},
    {"label": "Content Suggestion", "value": "Content Suggestion"},
    {"label": "Security Concern", "value": "Security Concern"},
  ];

  List<Map<String, dynamic>> recentFeedbacks = [
    {
      "type": "Feature Request",
      "subject": "Dark Mode Support",
      "date": "2024-12-20",
      "status": "In Progress",
      "response": "Thanks for the suggestion! Dark mode is planned for Q1 2025."
    },
    {
      "type": "Bug Report",
      "subject": "Login Issue on iOS",
      "date": "2024-12-18",
      "status": "Resolved",
      "response": "This issue has been fixed in version 2.1.3."
    },
    {
      "type": "General Feedback",
      "subject": "Great App!",
      "date": "2024-12-15",
      "status": "Acknowledged",
      "response": "Thank you for your positive feedback!"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send Feedback"),
        actions: [
          Icon(
            Icons.feedback,
            color: primaryColor,
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Feedback Importance Banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(40)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb,
                    color: infoColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Voice Matters",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Help us improve by sharing your thoughts and suggestions",
                          style: TextStyle(
                            fontSize: 14,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Feedback Form
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Submit Feedback",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  QDropdownField(
                    label: "Feedback Type",
                    items: feedbackTypes,
                    value: feedbackType,
                    onChanged: (value, label) {
                      feedbackType = value;
                      setState(() {});
                    },
                  ),

                  QTextField(
                    label: "Subject",
                    value: subject,
                    hint: "Brief summary of your feedback",
                    onChanged: (value) {
                      subject = value;
                      setState(() {});
                    },
                  ),

                  QTextField(
                    label: "Email (Optional)",
                    value: email,
                    hint: "Your email for follow-up responses",
                    onChanged: (value) {
                      email = value;
                      setState(() {});
                    },
                  ),

                  // Rating Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Overall Rating",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: List.generate(5, (index) {
                          return GestureDetector(
                            onTap: () {
                              rating = index + 1;
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              child: Icon(
                                index < rating ? Icons.star : Icons.star_border,
                                color: warningColor,
                                size: 32,
                              ),
                            ),
                          );
                        }),
                      ),
                      if (rating > 0)
                        Text(
                          _getRatingText(rating),
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                    ],
                  ),

                  QMemoField(
                    label: "Your Message",
                    value: message,
                    hint: "Please provide detailed feedback...",
                    onChanged: (value) {
                      message = value;
                      setState(() {});
                    },
                  ),

                  QAttachmentPicker(
                    label: "Attachments (Optional)",
                    value: attachments,
                    hint: "Add screenshots or relevant files",
                    maxAttachments: 5,
                    allowedTypes: ['image', 'document'],
                    onChanged: (value) {
                      attachments = value;
                      setState(() {});
                    },
                  ),

                  QSwitch(
                    items: [
                      {
                        "label": "Include system information (device, OS, app version)",
                        "value": true,
                        "checked": includeSystemInfo,
                      }
                    ],
                    value: [
                      if (includeSystemInfo)
                        {
                          "label": "Include system information (device, OS, app version)",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      includeSystemInfo = values.isNotEmpty;
                      setState(() {});
                    },
                  ),

                  QSwitch(
                    items: [
                      {
                        "label": "Allow contact for follow-up questions",
                        "value": true,
                        "checked": allowContact,
                      }
                    ],
                    value: [
                      if (allowContact)
                        {
                          "label": "Allow contact for follow-up questions",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      allowContact = values.isNotEmpty;
                      setState(() {});
                    },
                  ),

                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Submit Feedback",
                      icon: Icons.send,
                      size: bs.md,
                      onPressed: () {
                        if (subject.isEmpty || message.isEmpty) {
                          se("Please fill in subject and message");
                          return;
                        }
                        // Handle feedback submission
                        ss("Feedback submitted successfully!");
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Recent Feedback
            if (recentFeedbacks.isNotEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Your Recent Feedback",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),

                    ...recentFeedbacks.map((feedback) {
                      Color statusColor = _getStatusColor(feedback["status"] as String);
                      
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: statusColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${feedback["type"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: statusColor,
                                      fontWeight: FontWeight.w600,
                                    ),
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

                            Text(
                              "${feedback["subject"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),

                            Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: statusColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${feedback["status"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: statusColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),

                            if (feedback["response"] != null)
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(radiusXs),
                                  border: Border.all(color: Colors.blue[200]!),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Team Response:",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: infoColor,
                                      ),
                                    ),
                                    SizedBox(height: spXxs),
                                    Text(
                                      "${feedback["response"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: infoColor,
                                      ),
                                    ),
                                  ],
                                ),
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

                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Report Bug",
                          icon: Icons.bug_report,
                          size: bs.sm,
                          onPressed: () {
                            feedbackType = "Bug Report";
                            setState(() {});
                            // Scroll to top to show form
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Suggest Feature",
                          icon: Icons.lightbulb,
                          size: bs.sm,
                          onPressed: () {
                            feedbackType = "Feature Request";
                            setState(() {});
                            // Scroll to top to show form
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

  String _getRatingText(int rating) {
    switch (rating) {
      case 1:
        return "Very Poor";
      case 2:
        return "Poor";
      case 3:
        return "Average";
      case 4:
        return "Good";
      case 5:
        return "Excellent";
      default:
        return "";
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "resolved":
        return successColor;
      case "in progress":
        return warningColor;
      case "acknowledged":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }
}
