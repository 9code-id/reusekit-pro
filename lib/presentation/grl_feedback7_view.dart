import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFeedback7View extends StatefulWidget {
  @override
  State<GrlFeedback7View> createState() => _GrlFeedback7ViewState();
}

class _GrlFeedback7ViewState extends State<GrlFeedback7View> {
  String selectedService = "";
  DateTime serviceDate = DateTime.now();
  String staffMember = "";
  int overallRating = 0;
  Map<String, int> serviceRatings = {};
  String positiveExperience = "";
  String improvementSuggestions = "";
  bool returnCustomer = false;
  String customerName = "";
  String contactNumber = "";
  
  List<Map<String, dynamic>> services = [
    {
      "id": "haircut",
      "name": "Haircut & Styling",
      "icon": Icons.content_cut,
      "duration": "45 min",
      "price": 35.0,
    },
    {
      "id": "coloring",
      "name": "Hair Coloring",
      "icon": Icons.palette,
      "duration": "2 hours",
      "price": 85.0,
    },
    {
      "id": "massage",
      "name": "Relaxation Massage",
      "icon": Icons.spa,
      "duration": "60 min",
      "price": 65.0,
    },
    {
      "id": "facial",
      "name": "Facial Treatment",
      "icon": Icons.face,
      "duration": "90 min",
      "price": 75.0,
    },
    {
      "id": "manicure",
      "name": "Manicure & Pedicure",
      "icon": Icons.back_hand,
      "duration": "75 min",
      "price": 45.0,
    },
  ];
  
  List<Map<String, dynamic>> serviceAspects = [
    {
      "id": "punctuality",
      "name": "Punctuality",
      "description": "Service started on time"
    },
    {
      "id": "cleanliness",
      "name": "Cleanliness",
      "description": "Hygiene and cleanliness standards"
    },
    {
      "id": "staff_professionalism",
      "name": "Staff Professionalism",
      "description": "Courtesy and expertise of staff"
    },
    {
      "id": "service_quality",
      "name": "Service Quality",
      "description": "Quality of the service provided"
    },
    {
      "id": "value_for_money",
      "name": "Value for Money",
      "description": "Price vs. service quality"
    },
    {
      "id": "ambiance",
      "name": "Ambiance",
      "description": "Atmosphere and environment"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service Feedback"),
        actions: [
          IconButton(
            icon: Icon(Icons.event_note),
            onPressed: () {
              // navigateTo(AppointmentHistoryView());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Header
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
                children: [
                  Icon(
                    Icons.rate_review,
                    color: Colors.white,
                    size: 48,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "How was your service today?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Your feedback helps us provide better service",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Service Information
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
                    "Service Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  // Service Selection
                  QDropdownField(
                    label: "Service Received",
                    items: services.map((service) => {
                      "label": service["name"],
                      "value": service["id"],
                    }).toList(),
                    value: selectedService,
                    onChanged: (value, label) {
                      selectedService = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Service Date
                  QDatePicker(
                    label: "Service Date",
                    value: serviceDate,
                    onChanged: (value) {
                      serviceDate = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Staff Member
                  QTextField(
                    label: "Staff Member Name (optional)",
                    value: staffMember,
                    hint: "Who provided your service?",
                    onChanged: (value) {
                      staffMember = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Overall Rating
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
                    "Overall Experience",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "How would you rate your overall experience?",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(5, (index) {
                      int rating = index + 1;
                      return GestureDetector(
                        onTap: () {
                          overallRating = rating;
                          setState(() {});
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spMd),
                              decoration: BoxDecoration(
                                color: overallRating >= rating
                                    ? warningColor
                                    : Colors.grey.shade200,
                                shape: BoxShape.circle,
                                boxShadow: overallRating >= rating
                                    ? [shadowSm]
                                    : [],
                              ),
                              child: Icon(
                                Icons.star,
                                color: overallRating >= rating
                                    ? Colors.white
                                    : Colors.grey.shade400,
                                size: 32,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "$rating",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: overallRating >= rating
                                    ? warningColor
                                    : Colors.grey.shade400,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                  
                  if (overallRating > 0) ...[
                    SizedBox(height: spMd),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: _getRatingColor(overallRating).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        _getRatingText(overallRating),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _getRatingColor(overallRating),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Detailed Ratings
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
                    "Rate Specific Aspects",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Help us understand what we did well and what we can improve",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  ...serviceAspects.map((aspect) => Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          aspect["name"],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          aspect["description"],
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(5, (index) {
                            int rating = index + 1;
                            return GestureDetector(
                              onTap: () {
                                serviceRatings[aspect["id"]] = rating;
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: (serviceRatings[aspect["id"]] ?? 0) >= rating
                                      ? primaryColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(
                                    color: (serviceRatings[aspect["id"]] ?? 0) >= rating
                                        ? primaryColor
                                        : Colors.grey.shade300,
                                  ),
                                ),
                                child: Icon(
                                  Icons.star,
                                  color: (serviceRatings[aspect["id"]] ?? 0) >= rating
                                      ? Colors.white
                                      : Colors.grey.shade400,
                                  size: 20,
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  )).toList(),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Written Feedback
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
                    "Tell Us More",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  // Positive Experience
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.thumb_up,
                              color: successColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "What did we do well?",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        QMemoField(
                          label: "Positive Experience",
                          value: positiveExperience,
                          hint: "Share what you enjoyed about your visit...",
                          onChanged: (value) {
                            positiveExperience = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Improvement Suggestions
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.lightbulb,
                              color: warningColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "How can we improve?",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        QMemoField(
                          label: "Improvement Suggestions",
                          value: improvementSuggestions,
                          hint: "Any suggestions for improvement...",
                          onChanged: (value) {
                            improvementSuggestions = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Customer Information
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
                    "Your Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Optional - helps us follow up and provide better service",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  QTextField(
                    label: "Your Name",
                    value: customerName,
                    hint: "Your full name",
                    onChanged: (value) {
                      customerName = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  QTextField(
                    label: "Contact Number",
                    value: contactNumber,
                    hint: "Your phone number",
                    onChanged: (value) {
                      contactNumber = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  QSwitch(
                    items: [
                      {
                        "label": "I'm a returning customer",
                        "value": true,
                        "checked": returnCustomer,
                      }
                    ],
                    value: [if (returnCustomer) {"label": "I'm a returning customer", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      returnCustomer = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Thank You Message
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: infoColor.withAlpha(40),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.favorite,
                    color: infoColor,
                    size: 24,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Thank you for choosing us!",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Your feedback helps us serve you better next time.",
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
            
            // Submit Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Submit Feedback",
                size: bs.md,
                onPressed: overallRating > 0
                    ? () {
                        _submitFeedback();
                      }
                    : null,
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
        return "We're sorry you had a poor experience";
      case 2:
        return "We'll work harder to improve";
      case 3:
        return "Thank you for your feedback";
      case 4:
        return "We're glad you had a good experience";
      case 5:
        return "Fantastic! We're thrilled you loved it";
      default:
        return "";
    }
  }

  Color _getRatingColor(int rating) {
    if (rating <= 2) return dangerColor;
    if (rating == 3) return warningColor;
    return successColor;
  }

  void _submitFeedback() {
    if (overallRating == 0) {
      se("Please provide an overall rating");
      return;
    }
    
    showLoading();
    
    // Simulate API call
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Thank you for your valuable feedback!");
      
      // Reset form
      selectedService = "";
      serviceDate = DateTime.now();
      staffMember = "";
      overallRating = 0;
      serviceRatings = {};
      positiveExperience = "";
      improvementSuggestions = "";
      returnCustomer = false;
      customerName = "";
      contactNumber = "";
      setState(() {});
    });
  }
}
