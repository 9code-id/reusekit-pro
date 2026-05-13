import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBooking4View extends StatefulWidget {
  @override
  State<GrlBooking4View> createState() => _GrlBooking4ViewState();
}

class _GrlBooking4ViewState extends State<GrlBooking4View> {
  String selectedService = "";
  String selectedDate = "";
  String selectedTime = "";
  String selectedTherapist = "";
  String specialRequests = "";
  String customerName = "";
  String customerEmail = "";
  String customerPhone = "";
  bool hasAllergies = false;
  String allergies = "";

  List<Map<String, dynamic>> spaServices = [
    {
      "name": "Relaxation Massage",
      "duration": "60 min",
      "price": 85.0,
      "description": "Full body massage with aromatic oils"
    },
    {
      "name": "Deep Tissue Massage",
      "duration": "90 min", 
      "price": 120.0,
      "description": "Intensive massage for muscle tension relief"
    },
    {
      "name": "Hot Stone Therapy",
      "duration": "75 min",
      "price": 95.0,
      "description": "Warm stone massage for ultimate relaxation"
    },
    {
      "name": "Aromatherapy Facial",
      "duration": "45 min",
      "price": 65.0,
      "description": "Rejuvenating facial with essential oils"
    },
    {
      "name": "Couples Massage",
      "duration": "60 min",
      "price": 160.0,
      "description": "Side-by-side massage for two people"
    },
    {
      "name": "Body Scrub & Wrap",
      "duration": "90 min",
      "price": 110.0,
      "description": "Exfoliating scrub with nourishing body wrap"
    }
  ];

  List<Map<String, dynamic>> therapists = [
    {
      "name": "Sarah Johnson",
      "specialty": "Deep Tissue & Swedish Massage",
      "experience": "8 years",
      "rating": 4.9
    },
    {
      "name": "Maria Rodriguez",
      "specialty": "Aromatherapy & Facial Treatments",
      "experience": "6 years",
      "rating": 4.8
    },
    {
      "name": "Lisa Chen",
      "specialty": "Hot Stone & Couples Therapy",
      "experience": "10 years",
      "rating": 4.9
    },
    {
      "name": "Emma Thompson",
      "specialty": "Body Treatments & Wellness",
      "experience": "7 years",
      "rating": 4.7
    }
  ];

  List<String> timeSlots = [
    "9:00 AM", "10:00 AM", "11:00 AM", "12:00 PM",
    "1:00 PM", "2:00 PM", "3:00 PM", "4:00 PM",
    "5:00 PM", "6:00 PM", "7:00 PM", "8:00 PM"
  ];

  double get totalPrice {
    var service = spaServices.firstWhere((s) => s["name"] == selectedService, orElse: () => {"price": 0.0});
    return (service["price"] as double);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Spa Appointment Booking"),
      ),      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.spa, color: primaryColor, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Wellness & Beauty Services",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Book your perfect spa experience with our certified therapists",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Service Selection
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Select Service",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 280,
                    children: spaServices.map((service) {
                      bool isSelected = selectedService == service["name"];
                      return GestureDetector(
                        onTap: () {
                          selectedService = service["name"];
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor.withAlpha(20) : Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spSm,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${service["name"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: isSelected ? primaryColor : Colors.black,
                                      ),
                                    ),
                                  ),
                                  if (isSelected)
                                    Icon(
                                      Icons.check_circle,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                ],
                              ),
                              Text(
                                "${service["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${service["duration"]}",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "\$${(service["price"] as double).currency}",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Date & Time Selection
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Select Date & Time",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  QDatePicker(
                    label: "Preferred Date",
                    value: selectedDate.isNotEmpty ? DateTime.parse(selectedDate) : DateTime.now(),
                    onChanged: (value) {
                      selectedDate = value.toString().split(' ')[0];
                      setState(() {});
                    },
                  ),
                  Text(
                    "Available Time Slots",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: timeSlots.map((time) {
                      bool isSelected = selectedTime == time;
                      return GestureDetector(
                        onTap: () {
                          selectedTime = time;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                            ),
                          ),
                          child: Text(
                            time,
                            style: TextStyle(
                              color: isSelected ? Colors.white : disabledBoldColor,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Therapist Selection
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Choose Therapist",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    spacing: spSm,
                    children: therapists.map((therapist) {
                      bool isSelected = selectedTherapist == therapist["name"];
                      return GestureDetector(
                        onTap: () {
                          selectedTherapist = therapist["name"];
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor.withAlpha(20) : Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                            ),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: primaryColor.withAlpha(30),
                                child: Icon(
                                  Icons.person,
                                  color: primaryColor,
                                  size: 30,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Text(
                                      "${therapist["name"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: isSelected ? primaryColor : Colors.black,
                                      ),
                                    ),
                                    Text(
                                      "${therapist["specialty"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.star, color: Colors.amber, size: 16),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${therapist["rating"]}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Text(
                                          "${therapist["experience"]} experience",
                                          style: TextStyle(
                                            color: disabledBoldColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: primaryColor,
                                  size: 24,
                                ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Customer Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Customer Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  QTextField(
                    label: "Full Name",
                    value: customerName,
                    hint: "Enter your full name",
                    onChanged: (value) {
                      customerName = value;
                      setState(() {});
                    },
                  ),
                  QTextField(
                    label: "Email Address",
                    value: customerEmail,
                    hint: "Enter your email address",
                    onChanged: (value) {
                      customerEmail = value;
                      setState(() {});
                    },
                  ),
                  QTextField(
                    label: "Phone Number",
                    value: customerPhone,
                    hint: "Enter your phone number",
                    onChanged: (value) {
                      customerPhone = value;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "I have allergies or medical conditions",
                        "value": true,
                        "checked": hasAllergies,
                      }
                    ],
                    value: [
                      if (hasAllergies)
                        {
                          "label": "I have allergies or medical conditions",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      hasAllergies = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  if (hasAllergies)
                    QMemoField(
                      label: "Allergies & Medical Conditions",
                      value: allergies,
                      hint: "Please describe any allergies or medical conditions",
                      onChanged: (value) {
                        allergies = value;
                        setState(() {});
                      },
                    ),
                  QMemoField(
                    label: "Special Requests",
                    value: specialRequests,
                    hint: "Any special requests or preferences (optional)",
                    onChanged: (value) {
                      specialRequests = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Booking Summary
            if (selectedService.isNotEmpty)
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Booking Summary",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Service:", style: TextStyle(fontWeight: FontWeight.w600)),
                        Text(selectedService),
                      ],
                    ),
                    if (selectedDate.isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Date:", style: TextStyle(fontWeight: FontWeight.w600)),
                          Text(selectedDate),
                        ],
                      ),
                    if (selectedTime.isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Time:", style: TextStyle(fontWeight: FontWeight.w600)),
                          Text(selectedTime),
                        ],
                      ),
                    if (selectedTherapist.isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Therapist:", style: TextStyle(fontWeight: FontWeight.w600)),
                          Text(selectedTherapist),
                        ],
                      ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Amount:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "\$${totalPrice.currency}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            // Book Appointment Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Book Appointment",
                size: bs.md,
                onPressed: () {
                  if (selectedService.isEmpty) {
                    se("Please select a service");
                    return;
                  }
                  if (selectedDate.isEmpty) {
                    se("Please select a date");
                    return;
                  }
                  if (selectedTime.isEmpty) {
                    se("Please select a time");
                    return;
                  }
                  if (selectedTherapist.isEmpty) {
                    se("Please select a therapist");
                    return;
                  }
                  if (customerName.isEmpty || customerEmail.isEmpty || customerPhone.isEmpty) {
                    se("Please fill in all customer information");
                    return;
                  }

                  ss("Spa appointment booked successfully!");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
