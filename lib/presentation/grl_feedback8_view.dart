import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFeedback8View extends StatefulWidget {
  @override
  State<GrlFeedback8View> createState() => _GrlFeedback8ViewState();
}

class _GrlFeedback8ViewState extends State<GrlFeedback8View> {
  String selectedEventType = "";
  String eventName = "";
  DateTime eventDate = DateTime.now();
  String venue = "";
  int overallSatisfaction = 0;
  Map<String, int> eventRatings = {};
  String highlightMoments = "";
  String improvementAreas = "";
  String organizationFeedback = "";
  bool attendAgain = false;
  bool recommendEvent = false;
  String attendeeEmail = "";
  String attendeePhone = "";
  List<String> eventPhotos = [];
  
  List<Map<String, dynamic>> eventTypes = [
    {
      "id": "conference",
      "name": "Conference",
      "icon": Icons.business_center,
      "color": Colors.blue,
    },
    {
      "id": "workshop",
      "name": "Workshop",
      "icon": Icons.build,
      "color": Colors.orange,
    },
    {
      "id": "seminar",
      "name": "Seminar",
      "icon": Icons.school,
      "color": Colors.green,
    },
    {
      "id": "networking",
      "name": "Networking Event",
      "icon": Icons.people,
      "color": Colors.purple,
    },
    {
      "id": "product_launch",
      "name": "Product Launch",
      "icon": Icons.rocket_launch,
      "color": Colors.red,
    },
    {
      "id": "training",
      "name": "Training Session",
      "icon": Icons.cast_for_education,
      "color": Colors.teal,
    },
  ];
  
  List<Map<String, dynamic>> ratingAspects = [
    {
      "id": "content_quality",
      "name": "Content Quality",
      "description": "Relevance and value of the content presented"
    },
    {
      "id": "speakers",
      "name": "Speakers/Presenters",
      "description": "Quality and expertise of speakers"
    },
    {
      "id": "organization",
      "name": "Event Organization",
      "description": "Planning, coordination, and execution"
    },
    {
      "id": "venue_facilities",
      "name": "Venue & Facilities",
      "description": "Location, amenities, and comfort"
    },
    {
      "id": "networking_opportunities",
      "name": "Networking Opportunities",
      "description": "Chances to connect with other attendees"
    },
    {
      "id": "materials_resources",
      "name": "Materials & Resources",
      "description": "Quality of handouts, presentations, and resources"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Feedback"),
        actions: [
          IconButton(
            icon: Icon(Icons.event),
            onPressed: () {
              // navigateTo(EventHistoryView());
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              _shareEventExperience();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Header
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
                    Icons.event_seat,
                    color: Colors.white,
                    size: 48,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Share Your Event Experience",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Help us improve future events with your valuable feedback",
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
            
            // Event Details
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
                    "Event Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  // Event Type Selection
                  Text(
                    "Event Type",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: eventTypes.map((type) => GestureDetector(
                      onTap: () {
                        selectedEventType = type["id"];
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: selectedEventType == type["id"]
                              ? (type["color"] as Color).withAlpha(20)
                              : Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: selectedEventType == type["id"]
                                ? type["color"] as Color
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              type["icon"] as IconData,
                              color: selectedEventType == type["id"]
                                  ? type["color"] as Color
                                  : disabledBoldColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              type["name"],
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: selectedEventType == type["id"]
                                    ? type["color"] as Color
                                    : disabledBoldColor,
                              ),
                            ),
                            if (selectedEventType == type["id"]) ...[
                              SizedBox(width: spSm),
                              Icon(
                                Icons.check_circle,
                                color: type["color"] as Color,
                                size: 16,
                              ),
                            ],
                          ],
                        ),
                      ),
                    )).toList(),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Event Name
                  QTextField(
                    label: "Event Name",
                    value: eventName,
                    hint: "Name of the event you attended",
                    validator: Validator.required,
                    onChanged: (value) {
                      eventName = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Event Date
                  QDatePicker(
                    label: "Event Date",
                    value: eventDate,
                    onChanged: (value) {
                      eventDate = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Venue
                  QTextField(
                    label: "Venue/Location",
                    value: venue,
                    hint: "Where the event took place",
                    onChanged: (value) {
                      venue = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Overall Satisfaction
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
                    "Overall Event Satisfaction",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Rate your overall experience at this event",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  // Rating Stars
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(5, (index) {
                      int rating = index + 1;
                      return GestureDetector(
                        onTap: () {
                          overallSatisfaction = rating;
                          setState(() {});
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spMd),
                              decoration: BoxDecoration(
                                color: overallSatisfaction >= rating
                                    ? warningColor
                                    : Colors.grey.shade200,
                                shape: BoxShape.circle,
                                boxShadow: overallSatisfaction >= rating
                                    ? [shadowSm]
                                    : [],
                              ),
                              child: Icon(
                                Icons.star,
                                color: overallSatisfaction >= rating
                                    ? Colors.white
                                    : Colors.grey.shade400,
                                size: 28,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              _getRatingLabel(rating),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: overallSatisfaction >= rating
                                    ? warningColor
                                    : Colors.grey.shade400,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                  
                  if (overallSatisfaction > 0) ...[
                    SizedBox(height: spMd),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: _getSatisfactionColor(overallSatisfaction).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        _getSatisfactionText(overallSatisfaction),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: _getSatisfactionColor(overallSatisfaction),
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
                    "Rate Event Aspects",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Please rate different aspects of the event",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  ...ratingAspects.map((aspect) => Container(
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
                        SizedBox(height: spXs),
                        Text(
                          aspect["description"],
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(5, (index) {
                            int rating = index + 1;
                            return GestureDetector(
                              onTap: () {
                                eventRatings[aspect["id"]] = rating;
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: (eventRatings[aspect["id"]] ?? 0) >= rating
                                      ? primaryColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(
                                    color: (eventRatings[aspect["id"]] ?? 0) >= rating
                                        ? primaryColor
                                        : Colors.grey.shade300,
                                  ),
                                ),
                                child: Icon(
                                  Icons.star,
                                  color: (eventRatings[aspect["id"]] ?? 0) >= rating
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
            
            // Qualitative Feedback
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
                    "Your Detailed Feedback",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  // Highlight Moments
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
                              Icons.highlight,
                              color: successColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Event Highlights",
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
                          label: "What were the best parts of the event?",
                          value: highlightMoments,
                          hint: "Share your favorite moments, sessions, or speakers...",
                          onChanged: (value) {
                            highlightMoments = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Improvement Areas
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
                              Icons.trending_up,
                              color: warningColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Areas for Improvement",
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
                          label: "What could be improved?",
                          value: improvementAreas,
                          hint: "Suggest improvements for future events...",
                          onChanged: (value) {
                            improvementAreas = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Organization Feedback
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.business,
                              color: infoColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Organizer Feedback",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        QMemoField(
                          label: "Feedback for the organizers",
                          value: organizationFeedback,
                          hint: "Any specific feedback for the event organizers...",
                          onChanged: (value) {
                            organizationFeedback = value;
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
            
            // Future Engagement
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
                    "Future Engagement",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  QSwitch(
                    items: [
                      {
                        "label": "I would attend similar events in the future",
                        "value": "attend_again",
                        "checked": attendAgain,
                      }
                    ],
                    value: [if (attendAgain) {"label": "I would attend similar events in the future", "value": "attend_again", "checked": true}],
                    onChanged: (values, ids) {
                      attendAgain = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  QSwitch(
                    items: [
                      {
                        "label": "I would recommend this event to colleagues",
                        "value": "recommend",
                        "checked": recommendEvent,
                      }
                    ],
                    value: [if (recommendEvent) {"label": "I would recommend this event to colleagues", "value": "recommend", "checked": true}],
                    onChanged: (values, ids) {
                      recommendEvent = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Contact Information
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
                    "Contact Information (Optional)",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "For follow-up questions or future event invitations",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  QTextField(
                    label: "Email Address",
                    value: attendeeEmail,
                    hint: "your.email@example.com",
                    onChanged: (value) {
                      attendeeEmail = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  QTextField(
                    label: "Phone Number",
                    value: attendeePhone,
                    hint: "+1 (555) 123-4567",
                    onChanged: (value) {
                      attendeePhone = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Event Photos
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
                  Row(
                    children: [
                      Icon(
                        Icons.photo_camera,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Share Event Photos",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Share your favorite photos from the event (optional)",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  QMultiImagePicker(
                    label: "Event Photos",
                    value: eventPhotos,
                    maxImages: 5,
                    hint: "Add photos from the event",
                    onChanged: (value) {
                      eventPhotos = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Submit Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Submit Event Feedback",
                size: bs.md,
                onPressed: overallSatisfaction > 0 && eventName.isNotEmpty
                    ? () {
                        _submitEventFeedback();
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getRatingLabel(int rating) {
    switch (rating) {
      case 1: return "Poor";
      case 2: return "Fair";
      case 3: return "Good";
      case 4: return "Very Good";
      case 5: return "Excellent";
      default: return "";
    }
  }

  String _getSatisfactionText(int satisfaction) {
    switch (satisfaction) {
      case 1: return "We're sorry the event didn't meet your expectations";
      case 2: return "We'll work to improve future events";
      case 3: return "Thank you for your feedback";
      case 4: return "We're glad you had a positive experience";
      case 5: return "Fantastic! We're thrilled you loved the event";
      default: return "";
    }
  }

  Color _getSatisfactionColor(int satisfaction) {
    if (satisfaction <= 2) return dangerColor;
    if (satisfaction == 3) return warningColor;
    return successColor;
  }

  void _shareEventExperience() {
    if (overallSatisfaction == 0) {
      se("Please provide your feedback first");
      return;
    }
    
    si("Event experience ready to share!");
  }

  void _submitEventFeedback() {
    if (overallSatisfaction == 0) {
      se("Please provide an overall satisfaction rating");
      return;
    }
    
    if (eventName.isEmpty) {
      se("Please enter the event name");
      return;
    }
    
    showLoading();
    
    // Simulate API call
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Thank you for your detailed event feedback!");
      
      // Reset form
      selectedEventType = "";
      eventName = "";
      eventDate = DateTime.now();
      venue = "";
      overallSatisfaction = 0;
      eventRatings = {};
      highlightMoments = "";
      improvementAreas = "";
      organizationFeedback = "";
      attendAgain = false;
      recommendEvent = false;
      attendeeEmail = "";
      attendeePhone = "";
      eventPhotos = [];
      setState(() {});
    });
  }
}
