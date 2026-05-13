import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaShowingRequestView extends StatefulWidget {
  const RmaShowingRequestView({Key? key}) : super(key: key);

  @override
  State<RmaShowingRequestView> createState() => _RmaShowingRequestViewState();
}

class _RmaShowingRequestViewState extends State<RmaShowingRequestView> {
  final formKey = GlobalKey<FormState>();
  
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String showingType = "in_person";
  String preferredDate = "";
  String preferredTime = "";
  String alternateDate = "";
  String alternateTime = "";
  String message = "";
  String contactMethod = "phone";
  bool isPreApproved = false;
  bool needsAgent = false;
  bool flexibleTiming = true;
  bool agreeToTerms = false;
  
  List<Map<String, dynamic>> showingTypes = [
    {"label": "In-Person Showing", "value": "in_person"},
    {"label": "Virtual Tour", "value": "virtual"},
    {"label": "Self-Guided Tour", "value": "self_guided"},
    {"label": "Open House", "value": "open_house"},
  ];

  List<Map<String, dynamic>> contactMethods = [
    {"label": "Phone Call", "value": "phone"},
    {"label": "Text Message", "value": "text"},
    {"label": "Email", "value": "email"},
  ];

  Map<String, dynamic> property = {
    "id": "123456",
    "address": "456 Pacific Heights Ave",
    "city": "San Francisco",
    "state": "CA",
    "zipCode": "94109",
    "price": 2400000,
    "beds": 4,
    "baths": 3,
    "sqft": 2500,
    "yearBuilt": 1995,
    "propertyType": "Single Family Home",
    "photos": [
      "https://picsum.photos/400/300?random=1&keyword=luxury",
      "https://picsum.photos/400/300?random=2&keyword=house",
      "https://picsum.photos/400/300?random=3&keyword=interior",
    ],
    "listingAgent": {
      "name": "Sarah Johnson",
      "phone": "(555) 123-4567",
      "email": "sarah@realestate.com",
      "photo": "https://picsum.photos/100/100?random=1&keyword=woman",
    },
    "availability": [
      "Mon-Fri: 9:00 AM - 6:00 PM",
      "Saturday: 10:00 AM - 5:00 PM",
      "Sunday: 12:00 PM - 4:00 PM"
    ],
    "specialInstructions": "Please call 24 hours in advance for showings. Property has security system.",
  };

  List<Map<String, dynamic>> timeSlots = [
    {"label": "9:00 AM", "value": "09:00"},
    {"label": "10:00 AM", "value": "10:00"},
    {"label": "11:00 AM", "value": "11:00"},
    {"label": "12:00 PM", "value": "12:00"},
    {"label": "1:00 PM", "value": "13:00"},
    {"label": "2:00 PM", "value": "14:00"},
    {"label": "3:00 PM", "value": "15:00"},
    {"label": "4:00 PM", "value": "16:00"},
    {"label": "5:00 PM", "value": "17:00"},
    {"label": "6:00 PM", "value": "18:00"},
  ];

  List<Map<String, dynamic>> upcomingShowings = [
    {
      "date": "2024-01-25",
      "time": "2:00 PM",
      "type": "In-Person",
      "client": "Michael Chen",
      "agent": "Sarah Johnson",
      "status": "confirmed",
    },
    {
      "date": "2024-01-25",
      "time": "4:00 PM",
      "type": "Virtual Tour",
      "client": "Jennifer Martinez",
      "agent": "Sarah Johnson",
      "status": "pending",
    },
    {
      "date": "2024-01-26",
      "time": "10:00 AM",
      "type": "In-Person",
      "client": "David Wilson",
      "agent": "Sarah Johnson",
      "status": "confirmed",
    },
  ];

  void _submitRequest() async {
    if (formKey.currentState!.validate()) {
      if (!agreeToTerms) {
        se("Please agree to the terms and conditions");
        return;
      }
      
      if (preferredDate.isEmpty) {
        se("Please select a preferred date");
        return;
      }
      
      if (preferredTime.isEmpty) {
        se("Please select a preferred time");
        return;
      }
      
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss("Showing request submitted successfully! The agent will contact you within 2 hours to confirm.");
      
      // Reset form
      setState(() {
        firstName = "";
        lastName = "";
        email = "";
        phone = "";
        message = "";
        preferredDate = "";
        preferredTime = "";
        alternateDate = "";
        alternateTime = "";
        agreeToTerms = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request Showing"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Property Information
              Container(
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
                        Container(
                          width: 100,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusSm),
                            image: DecorationImage(
                              image: NetworkImage("${(property["photos"] as List)[0]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${property["address"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${property["city"]}, ${property["state"]} ${property["zipCode"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "\$${((property["price"] as int).toDouble() / 1000).toStringAsFixed(0)}K",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${property["beds"]}bd • ${property["baths"]}ba • ${property["sqft"]} sqft",
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
                    
                    // Listing Agent
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusSm),
                              image: DecorationImage(
                                image: NetworkImage("${(property["listingAgent"] as Map)["photo"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Listing Agent",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${(property["listingAgent"] as Map)["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          QButton(
                            icon: Icons.phone,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Showing Type
              Container(
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
                    Text(
                      "Showing Type",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QDropdownField(
                      label: "How would you like to view this property?",
                      items: showingTypes,
                      value: showingType,
                      onChanged: (value, label) {
                        showingType = value;
                        setState(() {});
                      },
                    ),
                    if (showingType == "virtual")
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info,
                              color: infoColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "Virtual tours are conducted via video call and typically last 30-45 minutes.",
                                style: TextStyle(
                                  fontSize: 12,
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

              // Contact Information
              Container(
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
                    Text(
                      "Your Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "First Name",
                            value: firstName,
                            validator: Validator.required,
                            onChanged: (value) {
                              firstName = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Last Name",
                            value: lastName,
                            validator: Validator.required,
                            onChanged: (value) {
                              lastName = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QTextField(
                      label: "Email Address",
                      value: email,
                      validator: Validator.email,
                      onChanged: (value) {
                        email = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Phone Number",
                            value: phone,
                            validator: Validator.required,
                            onChanged: (value) {
                              phone = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Preferred Contact",
                            items: contactMethods,
                            value: contactMethod,
                            onChanged: (value, label) {
                              contactMethod = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Showing Schedule
              Container(
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
                    Text(
                      "Preferred Schedule",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QDatePicker(
                            label: "Preferred Date",
                            value: preferredDate.isNotEmpty ? DateTime.parse(preferredDate) : DateTime.now(),
                            onChanged: (value) {
                              preferredDate = value.toIso8601String().split('T')[0];
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Preferred Time",
                            items: timeSlots,
                            value: preferredTime,
                            onChanged: (value, label) {
                              preferredTime = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Alternate Options (Optional)",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QDatePicker(
                            label: "Alternate Date",
                            value: alternateDate.isNotEmpty ? DateTime.parse(alternateDate) : DateTime.now(),
                            onChanged: (value) {
                              alternateDate = value.toIso8601String().split('T')[0];
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Alternate Time",
                            items: timeSlots,
                            value: alternateTime,
                            onChanged: (value, label) {
                              alternateTime = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QSwitch(
                      label: "",
                      items: [
                        {
                          "label": "I'm flexible with timing if needed",
                          "value": true,
                          "checked": flexibleTiming,
                        }
                      ],
                      value: flexibleTiming ? [{"label": "I'm flexible with timing if needed", "value": true, "checked": true}] : [],
                      onChanged: (values, ids) {
                        flexibleTiming = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Property Availability
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: infoColor.withAlpha(50)),
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: infoColor,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Property Availability",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    ...(property["availability"] as List).map((schedule) {
                      return Text(
                        "• $schedule",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      );
                    }).toList(),
                    if (property["specialInstructions"] != null)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Special Instructions:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "${property["specialInstructions"]}",
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
              ),

              // Additional Information
              Container(
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
                    Text(
                      "Additional Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QSwitch(
                      label: "",
                      items: [
                        {
                          "label": "I'm pre-approved for financing",
                          "value": true,
                          "checked": isPreApproved,
                        }
                      ],
                      value: isPreApproved ? [{"label": "I'm pre-approved for financing", "value": true, "checked": true}] : [],
                      onChanged: (values, ids) {
                        isPreApproved = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      label: "",
                      items: [
                        {
                          "label": "I need a buyer's agent",
                          "value": true,
                          "checked": needsAgent,
                        }
                      ],
                      value: needsAgent ? [{"label": "I need a buyer's agent", "value": true, "checked": true}] : [],
                      onChanged: (values, ids) {
                        needsAgent = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Special Requests or Questions",
                      value: message,
                      hint: "Any specific areas you'd like to focus on, questions about the property, or special accommodations needed...",
                      onChanged: (value) {
                        message = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Upcoming Showings
              Container(
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
                    Text(
                      "Other Scheduled Showings",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "These times are already booked:",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    ...upcomingShowings.map((showing) {
                      Color statusColor;
                      switch (showing["status"]) {
                        case "confirmed":
                          statusColor = successColor;
                          break;
                        case "pending":
                          statusColor = warningColor;
                          break;
                        default:
                          statusColor = disabledBoldColor;
                      }
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          border: Border.all(color: disabledColor),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${DateTime.parse(showing["date"]).dMMMy} at ${showing["time"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${showing["type"]} - ${showing["client"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXxs),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${showing["status"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: statusColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),

              // Terms and Submit
              QSwitch(
                label: "",
                items: [
                  {
                    "label": "I agree to the terms and conditions and privacy policy",
                    "value": true,
                    "checked": agreeToTerms,
                  }
                ],
                value: agreeToTerms ? [{"label": "I agree to the terms and conditions and privacy policy", "value": true, "checked": true}] : [],
                onChanged: (values, ids) {
                  agreeToTerms = values.isNotEmpty;
                  setState(() {});
                },
              ),

              Container(
                width: double.infinity,
                child: QButton(
                  label: "Request Showing",
                  size: bs.md,
                  onPressed: _submitRequest,
                ),
              ),

              // Contact Information
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: successColor.withAlpha(50)),
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: successColor,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "What happens next?",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "• The listing agent will receive your request immediately\n• You'll get a confirmation within 2 hours\n• The agent will contact you to finalize details\n• You'll receive showing instructions 24 hours before",
                      style: TextStyle(
                        color: disabledBoldColor,
                        height: 1.5,
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
}
