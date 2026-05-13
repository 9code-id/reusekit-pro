import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaTicketBookingView extends StatefulWidget {
  const EmaTicketBookingView({super.key});

  @override
  State<EmaTicketBookingView> createState() => _EmaTicketBookingViewState();
}

class _EmaTicketBookingViewState extends State<EmaTicketBookingView> {
  final formKey = GlobalKey<FormState>();
  int currentStep = 0;
  
  // Personal Information
  String fullName = "";
  String email = "";
  String phone = "";
  String dateOfBirth = "";
  
  // Additional Information
  String specialRequests = "";
  bool agreeToTerms = false;
  bool subscribeNewsletter = false;
  String emergencyContact = "";
  String emergencyPhone = "";
  
  // Booking Details
  Map<String, dynamic> bookingDetails = {
    "eventName": "Grand Concert 2025",
    "venue": "Madison Square Garden",
    "date": "2025-07-15",
    "time": "19:30",
    "ticketType": "VIP Experience Package",
    "quantity": 2,
    "section": "VIP Section A",
    "seats": ["A-R5-S12", "A-R5-S13"],
    "total": 1200.0,
    "addOns": ["VIP Parking", "Official T-Shirt"],
    "promoCode": "EARLY2025",
    "discount": 100.0,
  };

  List<Map<String, dynamic>> steps = [
    {
      "title": "Personal Info",
      "description": "Your contact details",
      "icon": Icons.person,
    },
    {
      "title": "Additional Info", 
      "description": "Emergency contact & preferences",
      "icon": Icons.info,
    },
    {
      "title": "Review & Confirm",
      "description": "Review your booking details",
      "icon": Icons.check_circle,
    },
  ];

  List<Map<String, dynamic>> termsConditions = [
    {
      "title": "Ticket Terms",
      "items": [
        "Tickets are non-refundable except as stated in refund policy",
        "Entry may be refused if ticket is damaged or illegible",
        "No readmission once you leave the venue",
        "Tickets cannot be resold at higher than face value",
      ]
    },
    {
      "title": "Event Terms",
      "items": [
        "Event may be subject to cancellation or postponement",
        "Program and artists subject to change without notice",
        "Photography and recording devices may be prohibited",
        "Age restrictions may apply for certain events",
      ]
    },
    {
      "title": "Venue Terms",
      "items": [
        "Venue reserves the right to refuse entry",
        "Security screening may be required",
        "Outside food and beverages may be prohibited",
        "Parking fees are separate and not included",
      ]
    },
  ];

  bool validateCurrentStep() {
    switch (currentStep) {
      case 0:
        return fullName.isNotEmpty && 
               email.isNotEmpty && 
               phone.isNotEmpty &&
               dateOfBirth.isNotEmpty;
      case 1:
        return emergencyContact.isNotEmpty && 
               emergencyPhone.isNotEmpty &&
               agreeToTerms;
      case 2:
        return true;
      default:
        return false;
    }
  }

  void nextStep() {
    if (validateCurrentStep()) {
      if (currentStep < steps.length - 1) {
        currentStep++;
        setState(() {});
      } else {
        proceedToPayment();
      }
    } else {
      se("Please fill in all required fields");
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      currentStep--;
      setState(() {});
    }
  }

  void proceedToPayment() {
    //navigateTo('EmaPaymentView')
    ss("Proceeding to payment...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Details"),
        actions: [
          QButton(
            icon: Icons.help,
            size: bs.sm,
            onPressed: () {
              //navigateTo('BookingHelpView')
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress Stepper
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: disabledOutlineBorderColor),
              ),
            ),
            child: Row(
              children: List.generate(steps.length, (index) {
                bool isActive = index == currentStep;
                bool isCompleted = index < currentStep;
                
                return Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isCompleted 
                            ? successColor 
                            : isActive 
                              ? primaryColor 
                              : disabledColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          isCompleted ? Icons.check : steps[index]["icon"],
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      if (index < steps.length - 1) ...[
                        Expanded(
                          child: Container(
                            height: 2,
                            margin: EdgeInsets.symmetric(horizontal: spXs),
                            color: isCompleted 
                              ? successColor 
                              : disabledOutlineBorderColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }),
            ),
          ),

          // Step Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Step Title
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: primaryColor.withAlpha(50)),
                    ),
                    child: Column(
                      spacing: spXs,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Step ${currentStep + 1}: ${steps[currentStep]["title"]}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${steps[currentStep]["description"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Step Content
                  if (currentStep == 0) ...[
                    // Personal Information Step
                    Form(
                      key: formKey,
                      child: Column(
                        spacing: spMd,
                        children: [
                          QTextField(
                            label: "Full Name *",
                            value: fullName,
                            hint: "Enter your full name as per ID",
                            validator: Validator.required,
                            onChanged: (value) {
                              fullName = value;
                              setState(() {});
                            },
                          ),

                          QTextField(
                            label: "Email Address *",
                            value: email,
                            hint: "Enter your email address",
                            validator: Validator.email,
                            onChanged: (value) {
                              email = value;
                              setState(() {});
                            },
                          ),

                          QTextField(
                            label: "Phone Number *",
                            value: phone,
                            hint: "Enter your phone number",
                            validator: Validator.required,
                            onChanged: (value) {
                              phone = value;
                              setState(() {});
                            },
                          ),

                          QDatePicker(
                            label: "Date of Birth *",
                            value: dateOfBirth.isNotEmpty ? DateTime.parse(dateOfBirth) : null,
                            onChanged: (value) {
                              dateOfBirth = value.toString().split(' ')[0];
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                  ] else if (currentStep == 1) ...[
                    // Additional Information Step
                    Column(
                      spacing: spMd,
                      children: [
                        QTextField(
                          label: "Emergency Contact Name *",
                          value: emergencyContact,
                          hint: "Name of emergency contact person",
                          onChanged: (value) {
                            emergencyContact = value;
                            setState(() {});
                          },
                        ),

                        QTextField(
                          label: "Emergency Contact Phone *",
                          value: emergencyPhone,
                          hint: "Phone number of emergency contact",
                          onChanged: (value) {
                            emergencyPhone = value;
                            setState(() {});
                          },
                        ),

                        QMemoField(
                          label: "Special Requests",
                          value: specialRequests,
                          hint: "Dietary requirements, accessibility needs, etc.",
                          onChanged: (value) {
                            specialRequests = value;
                            setState(() {});
                          },
                        ),

                        // Terms and Conditions
                        Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(radiusMd),
                            border: Border.all(color: disabledOutlineBorderColor),
                          ),
                          child: Column(
                            spacing: spSm,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Terms & Conditions",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                height: 150,
                                child: SingleChildScrollView(
                                  child: Column(
                                    spacing: spSm,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: termsConditions.map((section) {
                                      return Column(
                                        spacing: spXs,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${section["title"]}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                          ...(section["items"] as List).map((item) {
                                            return Row(
                                              spacing: spXs,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("•", style: TextStyle(fontSize: 12)),
                                                Expanded(
                                                  child: Text(
                                                    "$item",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: disabledBoldColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Checkboxes
                        QSwitch(
                          items: [
                            {
                              "label": "I agree to the terms and conditions *",
                              "value": true,
                              "checked": agreeToTerms,
                            }
                          ],
                          value: agreeToTerms ? [{"label": "I agree to the terms and conditions *", "value": true, "checked": true}] : [],
                          onChanged: (values, ids) {
                            agreeToTerms = values.isNotEmpty;
                            setState(() {});
                          },
                        ),

                        QSwitch(
                          items: [
                            {
                              "label": "Subscribe to newsletter for event updates",
                              "value": true,
                              "checked": subscribeNewsletter,
                            }
                          ],
                          value: subscribeNewsletter ? [{"label": "Subscribe to newsletter for event updates", "value": true, "checked": true}] : [],
                          onChanged: (values, ids) {
                            subscribeNewsletter = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ] else if (currentStep == 2) ...[
                    // Review & Confirm Step
                    Column(
                      spacing: spMd,
                      children: [
                        // Event Details
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            border: Border.all(color: disabledOutlineBorderColor),
                            boxShadow: [shadowMd],
                          ),
                          child: Column(
                            spacing: spSm,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Event Details",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Text("Event:"),
                                  Spacer(),
                                  Text(
                                    "${bookingDetails["eventName"]}",
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Venue:"),
                                  Spacer(),
                                  Text("${bookingDetails["venue"]}"),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Date & Time:"),
                                  Spacer(),
                                  Text("${DateTime.parse("${bookingDetails["date"]}").dMMMy} at ${bookingDetails["time"]}"),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Ticket Type:"),
                                  Spacer(),
                                  Text("${bookingDetails["ticketType"]}"),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Quantity:"),
                                  Spacer(),
                                  Text("${bookingDetails["quantity"]} tickets"),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Section:"),
                                  Spacer(),
                                  Text("${bookingDetails["section"]}"),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Seats:"),
                                  Spacer(),
                                  Text("${(bookingDetails["seats"] as List).join(", ")}"),
                                ],
                              ),
                              if ((bookingDetails["addOns"] as List).isNotEmpty) ...[
                                Row(
                                  children: [
                                    Text("Add-ons:"),
                                    Spacer(),
                                    Text("${(bookingDetails["addOns"] as List).join(", ")}"),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),

                        // Personal Information Summary
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            border: Border.all(color: disabledOutlineBorderColor),
                            boxShadow: [shadowMd],
                          ),
                          child: Column(
                            spacing: spSm,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Personal Information",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Text("Name:"),
                                  Spacer(),
                                  Text(
                                    fullName,
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Email:"),
                                  Spacer(),
                                  Text(email),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Phone:"),
                                  Spacer(),
                                  Text(phone),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Emergency Contact:"),
                                  Spacer(),
                                  Text("$emergencyContact ($emergencyPhone)"),
                                ],
                              ),
                              if (specialRequests.isNotEmpty) ...[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Special Requests:"),
                                    SizedBox(height: spXs),
                                    Text(
                                      specialRequests,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),

                        // Price Summary
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusMd),
                            border: Border.all(color: primaryColor.withAlpha(50)),
                          ),
                          child: Column(
                            spacing: spSm,
                            children: [
                              Text(
                                "Payment Summary",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Divider(color: primaryColor.withAlpha(50)),
                              if (bookingDetails["promoCode"] != null && (bookingDetails["discount"] as double) > 0) ...[
                                Row(
                                  children: [
                                    Text("Discount (${bookingDetails["promoCode"]}):"),
                                    Spacer(),
                                    Text(
                                      "-\$${(bookingDetails["discount"] as double).currency}",
                                      style: TextStyle(color: successColor),
                                    ),
                                  ],
                                ),
                              ],
                              Row(
                                children: [
                                  Text(
                                    "Total Amount:",
                                    style: TextStyle(
                                      fontSize: fsH5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "\$${(bookingDetails["total"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: fsH5,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Important Notes
                        Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusMd),
                            border: Border.all(color: warningColor.withAlpha(50)),
                          ),
                          child: Column(
                            spacing: spXs,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.info, color: warningColor, size: 20),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Important Notes",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: warningColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "• Tickets will be sent to your email after payment confirmation",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "• Please arrive 30 minutes before event start time",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "• Bring a valid ID for entry verification",
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
                  ],
                ],
              ),
            ),
          ),

          // Navigation Buttons
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: disabledOutlineBorderColor),
              ),
            ),
            child: Row(
              spacing: spSm,
              children: [
                if (currentStep > 0) ...[
                  Expanded(
                    child: QButton(
                      label: "Previous",
                      size: bs.sm,
                      onPressed: previousStep,
                    ),
                  ),
                ],
                Expanded(
                  flex: currentStep == 0 ? 1 : 1,
                  child: QButton(
                    label: currentStep == steps.length - 1 ? "Proceed to Payment" : "Next",
                    size: bs.sm,
                    onPressed: validateCurrentStep() ? nextStep : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
