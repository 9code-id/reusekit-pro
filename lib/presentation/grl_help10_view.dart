import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHelp10View extends StatefulWidget {
  @override
  State<GrlHelp10View> createState() => _GrlHelp10ViewState();
}

class _GrlHelp10ViewState extends State<GrlHelp10View> {
  double overallRating = 0.0;
  double responseTimeRating = 0.0;
  double helpfulnessRating = 0.0;
  double resolutionRating = 0.0;
  String feedbackText = "";
  String contactMethod = "live_chat";
  String agentName = "";
  bool wouldRecommend = false;
  List<String> improvementAreas = [];
  
  final formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> contactMethods = [
    {"label": "Live Chat", "value": "live_chat"},
    {"label": "Phone Support", "value": "phone_support"},
    {"label": "Email Support", "value": "email_support"},
    {"label": "Support Ticket", "value": "support_ticket"},
    {"label": "Knowledge Base", "value": "knowledge_base"},
  ];

  List<Map<String, dynamic>> improvementOptions = [
    {"label": "Faster response times", "value": "response_time"},
    {"label": "More knowledgeable agents", "value": "agent_knowledge"},
    {"label": "Better documentation", "value": "documentation"},
    {"label": "24/7 availability", "value": "availability"},
    {"label": "Multiple language support", "value": "languages"},
    {"label": "Better self-service options", "value": "self_service"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback & Rating"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
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
                        Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 32,
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Rate Your Experience",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Help us improve our support services",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.feedback,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Your feedback is valuable to us",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Support Method
              Text(
                "Support Experience Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QDropdownField(
                label: "Which support method did you use?",
                items: contactMethods,
                value: contactMethod,
                validator: Validator.required,
                onChanged: (value, label) {
                  contactMethod = value;
                  setState(() {});
                },
              ),

              QTextField(
                label: "Agent Name (Optional)",
                value: agentName,
                hint: "If you remember the support agent's name",
                onChanged: (value) {
                  agentName = value;
                  setState(() {});
                },
              ),

              // Overall Rating
              Text(
                "Rate Your Experience",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

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
                      "Overall Satisfaction",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Poor",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Row(
                          children: List.generate(5, (index) => GestureDetector(
                            onTap: () {
                              overallRating = (index + 1).toDouble();
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: spXs),
                              child: Icon(
                                Icons.star,
                                size: 32,
                                color: index < overallRating.toInt() 
                                    ? warningColor 
                                    : disabledColor,
                              ),
                            ),
                          )),
                        ),
                        Text(
                          "Excellent",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    if (overallRating > 0)
                      Container(
                        margin: EdgeInsets.only(top: spMd),
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: _getRatingColor(overallRating).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _getRatingIcon(overallRating),
                              color: _getRatingColor(overallRating),
                              size: 16,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              _getRatingText(overallRating),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: _getRatingColor(overallRating),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              // Detailed Ratings
              Text(
                "Detailed Ratings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    // Response Time
                    _buildRatingRow(
                      "Response Time",
                      "How quickly did we respond?",
                      responseTimeRating,
                      (rating) {
                        responseTimeRating = rating;
                        setState(() {});
                      },
                    ),
                    
                    Divider(),
                    
                    // Helpfulness
                    _buildRatingRow(
                      "Helpfulness",
                      "How helpful was our support?",
                      helpfulnessRating,
                      (rating) {
                        helpfulnessRating = rating;
                        setState(() {});
                      },
                    ),
                    
                    Divider(),
                    
                    // Problem Resolution
                    _buildRatingRow(
                      "Problem Resolution",
                      "Did we solve your issue?",
                      resolutionRating,
                      (rating) {
                        resolutionRating = rating;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Recommendation
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
                      "Would you recommend our support to others?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Yes, I would recommend",
                                "value": "yes",
                                "checked": wouldRecommend,
                              }
                            ],
                            value: wouldRecommend 
                                ? [{"label": "Yes, I would recommend", "value": "yes", "checked": true}] 
                                : [],
                            onChanged: (values, ids) {
                              wouldRecommend = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Improvement Areas
              Text(
                "Areas for Improvement",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

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
                      "What areas could we improve? (Select all that apply)",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Wrap(
                      spacing: spSm,
                      runSpacing: spSm,
                      children: improvementOptions.map((option) => GestureDetector(
                        onTap: () {
                          if (improvementAreas.contains(option["value"])) {
                            improvementAreas.remove(option["value"]);
                          } else {
                            improvementAreas.add(option["value"]);
                          }
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spMd,
                            vertical: spSm,
                          ),
                          decoration: BoxDecoration(
                            color: improvementAreas.contains(option["value"]) 
                                ? primaryColor 
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${option["label"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: improvementAreas.contains(option["value"]) 
                                  ? Colors.white 
                                  : disabledBoldColor,
                            ),
                          ),
                        ),
                      )).toList(),
                    ),
                  ],
                ),
              ),

              // Written Feedback
              QMemoField(
                label: "Additional Comments",
                value: feedbackText,
                hint: "Please share any additional thoughts or suggestions...",
                onChanged: (value) {
                  feedbackText = value;
                  setState(() {});
                },
              ),

              // Submit Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Submit Feedback",
                  onPressed: () {
                    _submitFeedback();
                  },
                ),
              ),

              // Thank You Note
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: successColor,
                      size: 24,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Thank You!",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Your feedback helps us provide better support for everyone.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                      ),
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

  Widget _buildRatingRow(String title, String subtitle, double rating, Function(double) onRatingChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spSm),
        Row(
          children: List.generate(5, (index) => GestureDetector(
            onTap: () => onRatingChanged((index + 1).toDouble()),
            child: Container(
              margin: EdgeInsets.only(right: spSm),
              child: Icon(
                Icons.star,
                size: 24,
                color: index < rating.toInt() 
                    ? warningColor 
                    : disabledColor,
              ),
            ),
          )),
        ),
      ],
    );
  }

  Color _getRatingColor(double rating) {
    if (rating >= 4) return successColor;
    if (rating >= 3) return warningColor;
    if (rating >= 2) return infoColor;
    return dangerColor;
  }

  IconData _getRatingIcon(double rating) {
    if (rating >= 4) return Icons.sentiment_very_satisfied;
    if (rating >= 3) return Icons.sentiment_satisfied;
    if (rating >= 2) return Icons.sentiment_neutral;
    return Icons.sentiment_dissatisfied;
  }

  String _getRatingText(double rating) {
    if (rating >= 4) return "Excellent experience!";
    if (rating >= 3) return "Good experience";
    if (rating >= 2) return "Average experience";
    return "Below expectations";
  }

  void _submitFeedback() async {
    if (overallRating == 0) {
      se("Please provide an overall rating before submitting");
      return;
    }

    showLoading();
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    
    ss("Thank you for your feedback! Your input helps us improve our services.");
    
    // Reset form
    overallRating = 0.0;
    responseTimeRating = 0.0;
    helpfulnessRating = 0.0;
    resolutionRating = 0.0;
    feedbackText = "";
    contactMethod = "live_chat";
    agentName = "";
    wouldRecommend = false;
    improvementAreas.clear();
    setState(() {});
  }
}
