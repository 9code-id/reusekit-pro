import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmFeedbackView extends StatefulWidget {
  const TpmFeedbackView({super.key});

  @override
  State<TpmFeedbackView> createState() => _TpmFeedbackViewState();
}

class _TpmFeedbackViewState extends State<TpmFeedbackView> {
  int currentTab = 0;
  
  // Submit Feedback Form
  String feedbackType = "Bug Report";
  String subject = "";
  String description = "";
  String priority = "Medium";
  String module = "Project Management";
  List<String> attachments = [];
  int overallRating = 5;
  int easeOfUseRating = 5;
  int performanceRating = 5;
  int designRating = 5;
  
  List<Map<String, dynamic>> feedbackTypes = [
    {"label": "Bug Report", "value": "Bug Report"},
    {"label": "Feature Request", "value": "Feature Request"},
    {"label": "Improvement", "value": "Improvement"},
    {"label": "General Feedback", "value": "General Feedback"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Critical", "value": "Critical"},
  ];

  List<Map<String, dynamic>> moduleOptions = [
    {"label": "Project Management", "value": "Project Management"},
    {"label": "Team Collaboration", "value": "Team Collaboration"},
    {"label": "Reporting", "value": "Reporting"},
    {"label": "User Interface", "value": "User Interface"},
    {"label": "Performance", "value": "Performance"},
    {"label": "Mobile App", "value": "Mobile App"},
  ];

  List<Map<String, dynamic>> previousFeedback = [
    {
      "id": "FB-001",
      "type": "Feature Request",
      "subject": "Dark mode support",
      "status": "Under Review",
      "submitted_date": "2024-06-15T10:30:00Z",
      "priority": "Medium",
      "votes": 24,
      "responses": 3,
    },
    {
      "id": "FB-002",
      "type": "Bug Report",
      "subject": "Export function not working",
      "status": "Fixed",
      "submitted_date": "2024-06-10T14:20:00Z",
      "priority": "High",
      "votes": 8,
      "responses": 5,
    },
    {
      "id": "FB-003",
      "type": "Improvement",
      "subject": "Better mobile navigation",
      "status": "In Progress",
      "submitted_date": "2024-06-08T09:15:00Z",
      "priority": "Low",
      "votes": 12,
      "responses": 2,
    },
    {
      "id": "FB-004",
      "type": "General Feedback",
      "subject": "Love the new dashboard!",
      "status": "Acknowledged",
      "submitted_date": "2024-06-05T16:45:00Z",
      "priority": "Low",
      "votes": 18,
      "responses": 1,
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Under Review":
        return warningColor;
      case "In Progress":
        return infoColor;
      case "Fixed":
        return successColor;
      case "Acknowledged":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildRatingStars(int rating, Function(int) onRatingChanged) {
    return Row(
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () => onRatingChanged(index + 1),
          child: Icon(
            Icons.star,
            color: index < rating ? warningColor : disabledColor,
            size: 24,
          ),
        );
      }),
    );
  }

  String _getTimeAgo(String dateString) {
    DateTime date = DateTime.parse(dateString);
    Duration difference = DateTime.now().difference(date);
    
    if (difference.inDays > 0) {
      return "${difference.inDays}d ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours}h ago";
    } else {
      return "${difference.inMinutes}m ago";
    }
  }

  Widget _buildSubmitFeedbackTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(
                color: primaryColor.withAlpha(20),
                width: 1,
              ),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Icon(
                  Icons.feedback,
                  size: 40,
                  color: primaryColor,
                ),
                Text(
                  "We Value Your Feedback",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Help us improve by sharing your thoughts, reporting issues, or suggesting new features",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Feedback Form
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
            hint: "Brief description of your feedback",
            validator: Validator.required,
            onChanged: (value) {
              subject = value;
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

          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Priority",
                  items: priorityOptions,
                  value: priority,
                  onChanged: (value, label) {
                    priority = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Module",
                  items: moduleOptions,
                  value: module,
                  onChanged: (value, label) {
                    module = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          QAttachmentPicker(
            label: "Attachments (Optional)",
            value: attachments,
            hint: "Add screenshots or files to support your feedback",
            maxAttachments: 5,
            onChanged: (value) {
              attachments = value;
              setState(() {});
            },
          ),

          // Rating Section
          Text(
            "Rate Your Experience",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Overall Experience",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    _buildRatingStars(overallRating, (rating) {
                      overallRating = rating;
                      setState(() {});
                    }),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Ease of Use",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    _buildRatingStars(easeOfUseRating, (rating) {
                      easeOfUseRating = rating;
                      setState(() {});
                    }),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Performance",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    _buildRatingStars(performanceRating, (rating) {
                      performanceRating = rating;
                      setState(() {});
                    }),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Design & Interface",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    _buildRatingStars(designRating, (rating) {
                      designRating = rating;
                      setState(() {});
                    }),
                  ],
                ),
              ],
            ),
          ),

          QButton(
            label: "Submit Feedback",
            size: bs.md,
            onPressed: () {
              ss("Feedback submitted successfully!");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPreviousFeedbackTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${previousFeedback.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Feedback",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${previousFeedback.where((f) => f["status"] == "Fixed").length}",
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
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${previousFeedback.map((f) => f["votes"] as int).reduce((a, b) => a + b)}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Total Votes",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Feedback List
          Text(
            "Your Previous Feedback",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Column(
            spacing: spSm,
            children: previousFeedback.map((feedback) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "#${feedback["id"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(feedback["status"] as String).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${feedback["status"]}",
                            style: TextStyle(
                              color: _getStatusColor(feedback["status"] as String),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          _getTimeAgo(feedback["submitted_date"] as String),
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${feedback["subject"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: secondaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "${feedback["type"]}",
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Row(
                      children: [
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
                        SizedBox(width: spMd),
                        Icon(
                          Icons.chat_bubble,
                          size: 16,
                          color: infoColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${feedback["responses"]} responses",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Feedback",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Submit Feedback", icon: Icon(Icons.add_comment)),
        Tab(text: "My Feedback", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildSubmitFeedbackTab(),
        _buildPreviousFeedbackTab(),
      ],
    );
  }
}
