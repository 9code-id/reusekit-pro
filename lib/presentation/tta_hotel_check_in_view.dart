import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaHotelCheckInView extends StatefulWidget {
  const TtaHotelCheckInView({super.key});

  @override
  State<TtaHotelCheckInView> createState() => _TtaHotelCheckInViewState();
}

class _TtaHotelCheckInViewState extends State<TtaHotelCheckInView> {
  String guestName = "";
  String confirmationNumber = "";
  String specialRequests = "";
  String arrivalTime = "14:00";
  bool expressCheckIn = false;
  bool needAssistance = false;
  String roomNumber = "205";
  String keyCardType = "digital";

  List<Map<String, dynamic>> timeOptions = [
    {"label": "10:00 AM", "value": "10:00"},
    {"label": "11:00 AM", "value": "11:00"},
    {"label": "12:00 PM", "value": "12:00"},
    {"label": "1:00 PM", "value": "13:00"},
    {"label": "2:00 PM", "value": "14:00"},
    {"label": "3:00 PM", "value": "15:00"},
    {"label": "4:00 PM", "value": "16:00"},
    {"label": "5:00 PM", "value": "17:00"},
  ];

  List<Map<String, dynamic>> keyCardOptions = [
    {"label": "Digital Key Card", "value": "digital"},
    {"label": "Physical Key Card", "value": "physical"},
  ];

  List<Map<String, dynamic>> hotelServices = [
    {
      "title": "Room Service",
      "subtitle": "24/7 available",
      "icon": Icons.room_service,
      "color": primaryColor,
    },
    {
      "title": "Spa & Wellness",
      "subtitle": "Open 6AM - 10PM",
      "icon": Icons.spa,
      "color": successColor,
    },
    {
      "title": "Fitness Center",
      "subtitle": "Open 24/7",
      "icon": Icons.fitness_center,
      "color": warningColor,
    },
    {
      "title": "Concierge",
      "subtitle": "Available 8AM - 8PM",
      "icon": Icons.support_agent,
      "color": infoColor,
    },
  ];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hotel Check-In"),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {
              ss("QR code scanner opened");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome to Grand Hotel",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Complete your check-in process",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withAlpha(230),
                      ),
                    ),
                  ],
                ),
              ),

              // Quick Check-In Options
              Row(
                children: [
                  Expanded(
                    child: QSwitch(
                      items: [
                        {
                          "label": "Express Check-In",
                          "value": true,
                          "checked": expressCheckIn,
                        }
                      ],
                      value: [
                        if (expressCheckIn)
                          {
                            "label": "Express Check-In",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        setState(() {
                          expressCheckIn = values.isNotEmpty;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QSwitch(
                      items: [
                        {
                          "label": "Need Assistance",
                          "value": true,
                          "checked": needAssistance,
                        }
                      ],
                      value: [
                        if (needAssistance)
                          {
                            "label": "Need Assistance",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        setState(() {
                          needAssistance = values.isNotEmpty;
                        });
                      },
                    ),
                  ),
                ],
              ),

              // Guest Information
              Text(
                "Guest Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QTextField(
                label: "Guest Name",
                value: guestName,
                validator: Validator.required,
                onChanged: (value) {
                  guestName = value;
                  setState(() {});
                },
              ),

              QTextField(
                label: "Confirmation Number",
                value: confirmationNumber,
                validator: Validator.required,
                onChanged: (value) {
                  confirmationNumber = value;
                  setState(() {});
                },
              ),

              // Check-In Details
              Text(
                "Check-In Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QDropdownField(
                label: "Expected Arrival Time",
                items: timeOptions,
                value: arrivalTime,
                onChanged: (value, label) {
                  arrivalTime = value;
                  setState(() {});
                },
              ),

              QDropdownField(
                label: "Key Card Type",
                items: keyCardOptions,
                value: keyCardType,
                onChanged: (value, label) {
                  keyCardType = value;
                  setState(() {});
                },
              ),

              // Room Information
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.hotel,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Room ${roomNumber}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Superior King Room",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "2nd Floor • City View",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "Ready",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Special Requests
              QMemoField(
                label: "Special Requests",
                value: specialRequests,
                hint: "Any special requests or preferences...",
                onChanged: (value) {
                  specialRequests = value;
                  setState(() {});
                },
              ),

              // Hotel Services
              Text(
                "Available Services",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 150,
                children: hotelServices.map((service) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: disabledOutlineBorderColor),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: (service["color"] as Color).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            service["icon"] as IconData,
                            color: service["color"] as Color,
                            size: 24,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${service["title"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${service["subtitle"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              // Check-In Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Complete Check-In",
                  size: bs.md,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      ss("Check-in completed successfully!");
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
