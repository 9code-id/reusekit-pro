import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaFeedbackView extends StatefulWidget {
  const RmaFeedbackView({super.key});

  @override
  State<RmaFeedbackView> createState() => _RmaFeedbackViewState();
}

class _RmaFeedbackViewState extends State<RmaFeedbackView> {
  String feedbackType = "general";
  String title = "";
  String description = "";
  String email = "";
  double overallRating = 5.0;
  double usabilityRating = 5.0;
  double performanceRating = 5.0;
  double supportRating = 5.0;
  String featureRequest = "";
  List<String> selectedTags = [];
  List<String> attachments = [];

  List<Map<String, dynamic>> feedbackTypes = [
    {"label": "General Feedback", "value": "general"},
    {"label": "Bug Report", "value": "bug"},
    {"label": "Feature Request", "value": "feature"},
    {"label": "Performance Issue", "value": "performance"},
    {"label": "UI/UX Feedback", "value": "ui_ux"},
    {"label": "Content Suggestion", "value": "content"},
  ];

  List<String> feedbackTags = [
    "Easy to Use",
    "Fast Performance",
    "Great Design",
    "Helpful Features",
    "Reliable",
    "Intuitive",
    "Comprehensive",
    "Professional",
    "Time-saving",
    "Accurate Data",
    "Mobile Friendly",
    "Good Support"
  ];

  List<Map<String, dynamic>> recentFeedback = [
    {
      "type": "Feature Request",
      "title": "Advanced Property Search Filters",
      "description": "Add more filtering options for property searches",
      "rating": 4,
      "date": "2024-01-15",
      "status": "In Progress",
      "votes": 23
    },
    {
      "type": "Bug Report",
      "title": "Export Function Not Working",
      "description": "PDF export fails on large datasets",
      "rating": 3,
      "date": "2024-01-14",
      "status": "Fixed",
      "votes": 12
    },
    {
      "type": "UI/UX Feedback",
      "title": "Improve Dashboard Layout",
      "description": "Make the dashboard more intuitive and organized",
      "rating": 5,
      "date": "2024-01-13",
      "status": "Under Review",
      "votes": 34
    },
    {
      "type": "General Feedback",
      "title": "Love the New Calculator Features",
      "description": "The mortgage calculators are very helpful",
      "rating": 5,
      "date": "2024-01-12",
      "status": "Implemented",
      "votes": 18
    },
  ];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback & Suggestions"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Share Your Feedback",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Help us improve your real estate management experience",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(230),
                    ),
                  ),
                  SizedBox(height: spLg),
                  Row(
                    children: [
                      Expanded(
                        child: _buildHeaderStat(
                          "Total Feedback",
                          "1,247",
                          Icons.feedback,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildHeaderStat(
                          "Implemented",
                          "89%",
                          Icons.check_circle,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildHeaderStat(
                          "Avg Rating",
                          "4.8/5",
                          Icons.star,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Feedback Form
            Text(
              "Submit New Feedback",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      label: "Title",
                      value: title,
                      validator: Validator.required,
                      hint: "Brief title for your feedback",
                      onChanged: (value) {
                        title = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Description",
                      value: description,
                      validator: Validator.required,
                      hint: "Please provide detailed feedback...",
                      onChanged: (value) {
                        description = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Email (Optional)",
                      value: email,
                      hint: "For follow-up communications",
                      onChanged: (value) {
                        email = value;
                        setState(() {});
                      },
                    ),
                    
                    // Overall Rating
                    Text(
                      "Overall Rating",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return GestureDetector(
                            onTap: () {
                              overallRating = (index + 1).toDouble();
                              setState(() {});
                            },
                            child: Icon(
                              Icons.star,
                              color: index < overallRating ? Colors.amber : disabledColor,
                              size: 32,
                            ),
                          );
                        }),
                        SizedBox(width: spSm),
                        Text(
                          "${overallRating.toInt()}/5",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),

                    // Detailed Ratings
                    Text(
                      "Detailed Ratings",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    _buildRatingRow("Usability", usabilityRating, (rating) {
                      usabilityRating = rating;
                      setState(() {});
                    }),
                    _buildRatingRow("Performance", performanceRating, (rating) {
                      performanceRating = rating;
                      setState(() {});
                    }),
                    _buildRatingRow("Support", supportRating, (rating) {
                      supportRating = rating;
                      setState(() {});
                    }),

                    // Tags Selection
                    Text(
                      "What did you like? (Select all that apply)",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Wrap(
                      spacing: spSm,
                      runSpacing: spSm,
                      children: feedbackTags.map((tag) {
                        bool isSelected = selectedTags.contains(tag);
                        return GestureDetector(
                          onTap: () {
                            if (isSelected) {
                              selectedTags.remove(tag);
                            } else {
                              selectedTags.add(tag);
                            }
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : Colors.grey[100],
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              ),
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(
                                fontSize: 12,
                                color: isSelected ? Colors.white : disabledBoldColor,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    // Feature Request
                    if (feedbackType == "feature")
                      QMemoField(
                        label: "Feature Request Details",
                        value: featureRequest,
                        hint: "Describe the feature you'd like to see...",
                        onChanged: (value) {
                          featureRequest = value;
                          setState(() {});
                        },
                      ),

                    SizedBox(height: spSm),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Submit Feedback",
                        size: bs.md,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            ss("Thank you for your feedback! It has been submitted successfully.");
                            // Reset form
                            title = "";
                            description = "";
                            email = "";
                            featureRequest = "";
                            selectedTags.clear();
                            overallRating = 5.0;
                            usabilityRating = 5.0;
                            performanceRating = 5.0;
                            supportRating = 5.0;
                            feedbackType = "general";
                            setState(() {});
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: spLg),

            // Recent Feedback
            Text(
              "Recent Community Feedback",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ...recentFeedback.map((feedback) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(feedback["status"]).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${feedback["type"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: _getStatusColor(feedback["status"]),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(feedback["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${feedback["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: _getStatusColor(feedback["status"]),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${feedback["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${feedback["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            color: index < (feedback["rating"] as int) ? Colors.amber : disabledColor,
                            size: 16,
                          );
                        }),
                        SizedBox(width: spSm),
                        Text(
                          "•",
                          style: TextStyle(color: disabledColor),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          Icons.thumb_up,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${feedback["votes"]} votes",
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
                            color: disabledColor,
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
    );
  }

  Widget _buildHeaderStat(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingRow(String label, double rating, Function(double) onRatingChanged) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ),
        ...List.generate(5, (index) {
          return GestureDetector(
            onTap: () => onRatingChanged((index + 1).toDouble()),
            child: Icon(
              Icons.star,
              color: index < rating ? Colors.amber : disabledColor,
              size: 24,
            ),
          );
        }),
        SizedBox(width: spSm),
        Text(
          "${rating.toInt()}/5",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Implemented":
        return successColor;
      case "In Progress":
        return warningColor;
      case "Fixed":
        return successColor;
      case "Under Review":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }
}
