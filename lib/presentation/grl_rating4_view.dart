import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlRating4View extends StatefulWidget {
  @override
  State<GrlRating4View> createState() => _GrlRating4ViewState();
}

class _GrlRating4ViewState extends State<GrlRating4View> {
  double overallRating = 0.0;
  String feedback = "";
  List<String> selectedIssues = [];
  String contactInfo = "";
  bool allowContact = false;

  List<Map<String, dynamic>> issueCategories = [
    {
      "title": "Product Quality",
      "issues": [
        "Defective product",
        "Poor build quality",
        "Not as described",
        "Missing parts",
        "Damaged packaging",
      ],
    },
    {
      "title": "Service Issues",
      "issues": [
        "Rude staff",
        "Slow response",
        "Unhelpful support",
        "Long wait times",
        "Poor communication",
      ],
    },
    {
      "title": "Delivery Problems",
      "issues": [
        "Late delivery",
        "Wrong address",
        "Package damaged",
        "Missing items",
        "Poor packaging",
      ],
    },
    {
      "title": "Other Issues",
      "issues": [
        "Billing problems",
        "Website issues",
        "Return policy",
        "Refund delays",
        "Account problems",
      ],
    },
  ];

  List<Map<String, dynamic>> improvementSuggestions = [
    {
      "category": "Quality Control",
      "suggestion": "Implement better quality checks before shipping",
      "priority": "high",
      "votes": 89,
    },
    {
      "category": "Customer Service",
      "suggestion": "Reduce response time for support tickets",
      "priority": "medium",
      "votes": 67,
    },
    {
      "category": "Delivery",
      "suggestion": "Provide real-time tracking updates",
      "priority": "high",
      "votes": 134,
    },
    {
      "category": "Website",
      "suggestion": "Improve search functionality",
      "priority": "low",
      "votes": 45,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback & Complaints"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Message
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.feedback,
                    color: infoColor,
                    size: 24,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "We Value Your Feedback",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Help us improve by sharing your experience",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Overall Experience Rating
            Text(
              "How would you rate your overall experience?",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: spSm),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () {
                          overallRating = index + 1.0;
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              Icon(
                                overallRating > index ? Icons.star : Icons.star_border,
                                size: 32,
                                color: _getRatingColor(index + 1),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${index + 1}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: overallRating > index ? _getRatingColor(index + 1) : disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    _getRatingDescription(overallRating),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _getRatingColor(overallRating.toInt()),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Issue Categories (if rating is low)
            if (overallRating <= 3.0 && overallRating > 0) ...[
              Text(
                "What specific issues did you encounter?",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: spSm),

              ...issueCategories.map((category) => Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: ExpansionTile(
                  title: Text(
                    "${category["title"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: (category["issues"] as List<String>).map((issue) => CheckboxListTile(
                    title: Text(
                      issue,
                      style: TextStyle(fontSize: 14),
                    ),
                    value: selectedIssues.contains(issue),
                    onChanged: (value) {
                      if (value == true) {
                        selectedIssues.add(issue);
                      } else {
                        selectedIssues.remove(issue);
                      }
                      setState(() {});
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.symmetric(horizontal: spMd),
                  )).toList(),
                ),
              )).toList(),

              SizedBox(height: spMd),
            ],

            // Detailed Feedback
            Text(
              "Tell us more about your experience",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: spSm),

            QMemoField(
              label: "Your feedback",
              value: feedback,
              hint: "Please describe your experience in detail. What went well? What could be improved?",
              onChanged: (value) {
                feedback = value;
                setState(() {});
              },
            ),

            SizedBox(height: spMd),

            // Contact Information
            Text(
              "Contact Information (Optional)",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: spSm),

            QTextField(
              label: "Email or Phone",
              value: contactInfo,
              hint: "For follow-up communication",
              onChanged: (value) {
                contactInfo = value;
                setState(() {});
              },
            ),

            SizedBox(height: spSm),

            Row(
              children: [
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Allow us to contact you for follow-up",
                        "value": true,
                        "checked": allowContact,
                      }
                    ],
                    value: [
                      if (allowContact)
                        {
                          "label": "Allow us to contact you for follow-up",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      allowContact = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Improvement Suggestions
            Text(
              "Community Improvement Suggestions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: spSm),

            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.lightbulb,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Vote for improvements you'd like to see",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...improvementSuggestions.map((suggestion) => Container(
                    margin: EdgeInsets.only(top: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getPriorityColor(suggestion["priority"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${suggestion["priority"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: _getPriorityColor(suggestion["priority"]),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${suggestion["category"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${suggestion["suggestion"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Vote for suggestion
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: primaryColor.withAlpha(50)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.thumb_up,
                                  size: 12,
                                  color: primaryColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${suggestion["votes"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Selected Issues Summary
            if (selectedIssues.isNotEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: warningColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.warning,
                          color: warningColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Issues Selected",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Wrap(
                      spacing: spSm,
                      runSpacing: spXs,
                      children: selectedIssues.map((issue) => Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                        decoration: BoxDecoration(
                          color: warningColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          issue,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      )).toList(),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spMd),
            ],

            // Submit Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Submit Feedback",
                onPressed: overallRating > 0 || feedback.isNotEmpty ? _submitFeedback : null,
              ),
            ),

            SizedBox(height: spSm),

            // Privacy Notice
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.privacy_tip,
                    size: 16,
                    color: disabledBoldColor,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Your feedback is anonymous unless you choose to provide contact information. We use this data to improve our services.",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
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

  Color _getRatingColor(int rating) {
    switch (rating) {
      case 5:
        return successColor;
      case 4:
        return primaryColor;
      case 3:
        return warningColor;
      case 2:
        return Colors.orange;
      case 1:
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getRatingDescription(double rating) {
    if (rating == 0) return "Please rate your experience";
    if (rating >= 5.0) return "Excellent - Exceeded expectations";
    if (rating >= 4.0) return "Good - Met expectations";
    if (rating >= 3.0) return "Average - Some improvements needed";
    if (rating >= 2.0) return "Poor - Several issues encountered";
    return "Very Poor - Major problems";
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return primaryColor;
    }
  }

  void _submitFeedback() async {
    // Validate input
    if (overallRating == 0 && feedback.isEmpty) {
      se("Please provide a rating or feedback");
      return;
    }

    if (allowContact && contactInfo.isEmpty) {
      se("Please provide contact information or disable follow-up");
      return;
    }

    // Show loading
    showLoading();

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    hideLoading();

    // Show success message
    ss("Thank you for your feedback! We'll review it and work on improvements.");

    // Reset form
    overallRating = 0.0;
    feedback = "";
    selectedIssues.clear();
    contactInfo = "";
    allowContact = false;
    setState(() {});

    // Navigate back or to thank you page
    // back();
  }
}
