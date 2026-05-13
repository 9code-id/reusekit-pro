import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsCustomerFeedbackView extends StatefulWidget {
  const BrsCustomerFeedbackView({super.key});

  @override
  State<BrsCustomerFeedbackView> createState() => _BrsCustomerFeedbackViewState();
}

class _BrsCustomerFeedbackViewState extends State<BrsCustomerFeedbackView> {
  String feedbackType = "General";
  String selectedRating = "5";
  String subject = "";
  String description = "";
  String visitId = "";
  bool isAnonymous = false;
  
  final formKey = GlobalKey<FormState>();
  
  List<Map<String, dynamic>> feedbackTypes = [
    {"label": "General", "value": "General"},
    {"label": "Service Quality", "value": "Service Quality"},
    {"label": "Staff Behavior", "value": "Staff Behavior"},
    {"label": "Cleanliness", "value": "Cleanliness"},
    {"label": "Pricing", "value": "Pricing"},
    {"label": "Booking Experience", "value": "Booking Experience"},
    {"label": "App/Website", "value": "App/Website"},
    {"label": "Suggestion", "value": "Suggestion"},
  ];

  List<Map<String, dynamic>> ratings = [
    {"label": "⭐ (1 - Very Poor)", "value": "1"},
    {"label": "⭐⭐ (2 - Poor)", "value": "2"},
    {"label": "⭐⭐⭐ (3 - Average)", "value": "3"},
    {"label": "⭐⭐⭐⭐ (4 - Good)", "value": "4"},
    {"label": "⭐⭐⭐⭐⭐ (5 - Excellent)", "value": "5"},
  ];

  List<Map<String, dynamic>> recentFeedback = [
    {
      "id": "FB001",
      "type": "Service Quality",
      "rating": 5,
      "subject": "Amazing haircut experience",
      "date": "2024-06-10",
      "status": "Reviewed",
      "response": "Thank you for your wonderful feedback! We're delighted you loved your haircut."
    },
    {
      "id": "FB002", 
      "type": "Cleanliness",
      "rating": 4,
      "subject": "Very clean facility",
      "date": "2024-05-28",
      "status": "Reviewed",
      "response": "We appreciate your feedback about our cleanliness standards. We'll continue maintaining high hygiene."
    },
    {
      "id": "FB003",
      "type": "Suggestion",
      "rating": 4,
      "subject": "Online booking improvement",
      "date": "2024-05-15",
      "status": "Under Review",
      "response": null
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Feedback"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // Feedback Form
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Share Your Feedback",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    
                    // Feedback Type
                    QDropdownField(
                      label: "Feedback Type",
                      items: feedbackTypes,
                      value: feedbackType,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        feedbackType = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    
                    // Rating
                    QDropdownField(
                      label: "Overall Rating",
                      items: ratings,
                      value: selectedRating,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        selectedRating = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    
                    // Subject
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
                    SizedBox(height: spSm),
                    
                    // Visit ID (Optional)
                    QTextField(
                      label: "Visit/Booking ID (Optional)",
                      value: visitId,
                      hint: "e.g., BK2024001",
                      onChanged: (value) {
                        visitId = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    
                    // Description
                    QMemoField(
                      label: "Detailed Feedback",
                      value: description,
                      hint: "Please provide detailed feedback to help us improve our services...",
                      validator: Validator.required,
                      onChanged: (value) {
                        description = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    
                    // Anonymous Option
                    QSwitch(
                      label: "Submit anonymously",
                      items: [
                        {
                          "label": "Submit feedback without revealing my identity",
                          "value": true,
                          "checked": isAnonymous,
                        }
                      ],
                      value: isAnonymous ? [
                        {
                          "label": "Submit feedback without revealing my identity",
                          "value": true,
                          "checked": true
                        }
                      ] : [],
                      onChanged: (values, ids) {
                        isAnonymous = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spMd),
                    
                    // Submit Button
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
              SizedBox(height: spMd),

              // Feedback Guidelines
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: infoColor,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: infoColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Feedback Guidelines",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "• Be specific about your experience\n• Include visit/booking ID for faster resolution\n• Use respectful language\n• Provide constructive suggestions\n• We review all feedback within 24-48 hours",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spMd),

              // Recent Feedback History
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Recent Feedback",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    
                    ...recentFeedback.map((feedback) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spMd),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: disabledOutlineBorderColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${feedback["subject"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spSm,
                                              vertical: spXs,
                                            ),
                                            decoration: BoxDecoration(
                                              color: primaryColor.withAlpha(100),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${feedback["type"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: spSm),
                                          Row(
                                            children: List.generate(5, (index) {
                                              return Icon(
                                                index < (feedback["rating"] as int) 
                                                    ? Icons.star 
                                                    : Icons.star_border,
                                                size: 14,
                                                color: warningColor,
                                              );
                                            }),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: feedback["status"] == "Reviewed" 
                                            ? successColor.withAlpha(100)
                                            : warningColor.withAlpha(100),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${feedback["status"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: feedback["status"] == "Reviewed" 
                                              ? successColor
                                              : warningColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${DateTime.parse(feedback["date"]).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            
                            if (feedback["response"] != null) ...[
                              SizedBox(height: spSm),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(
                                    color: successColor.withAlpha(100),
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.reply,
                                          size: 16,
                                          color: successColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "Management Response",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: successColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${feedback["response"]}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: primaryColor,
                                        height: 1.3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
              SizedBox(height: spMd),

              // Contact Support
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: primaryColor,
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      "Need Immediate Assistance?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "For urgent matters, please contact our support team directly",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Call Support",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Live Chat",
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

  void _submitFeedback() async {
    showLoading();
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    
    // Clear form
    feedbackType = "General";
    selectedRating = "5";
    subject = "";
    description = "";
    visitId = "";
    isAnonymous = false;
    setState(() {});
    
    ss("Thank you! Your feedback has been submitted successfully.");
  }
}
