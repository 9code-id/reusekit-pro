import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaPropertyInquiryView extends StatefulWidget {
  const ReaPropertyInquiryView({super.key});

  @override
  State<ReaPropertyInquiryView> createState() => _ReaPropertyInquiryViewState();
}

class _ReaPropertyInquiryViewState extends State<ReaPropertyInquiryView> {
  String name = "";
  String email = "";
  String phone = "";
  String message = "";
  String inquiryType = "General Information";
  String preferredContact = "Phone";
  String timeSlot = "Morning (9 AM - 12 PM)";
  bool interestedInLoan = false;
  bool interestedInSiteVisit = false;
  bool agreeToTerms = false;
  final formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> inquiryTypes = [
    {"label": "General Information", "value": "General Information"},
    {"label": "Property Details", "value": "Property Details"},
    {"label": "Price Negotiation", "value": "Price Negotiation"},
    {"label": "Site Visit", "value": "Site Visit"},
    {"label": "Legal Documents", "value": "Legal Documents"},
    {"label": "Loan Assistance", "value": "Loan Assistance"},
    {"label": "Investment Query", "value": "Investment Query"},
  ];

  List<Map<String, dynamic>> contactMethods = [
    {"label": "Phone", "value": "Phone"},
    {"label": "Email", "value": "Email"},
    {"label": "WhatsApp", "value": "WhatsApp"},
    {"label": "Video Call", "value": "Video Call"},
  ];

  List<Map<String, dynamic>> timeSlots = [
    {"label": "Morning (9 AM - 12 PM)", "value": "Morning (9 AM - 12 PM)"},
    {"label": "Afternoon (12 PM - 4 PM)", "value": "Afternoon (12 PM - 4 PM)"},
    {"label": "Evening (4 PM - 7 PM)", "value": "Evening (4 PM - 7 PM)"},
    {"label": "Anytime", "value": "Anytime"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Property Inquiry"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              si("Need help? Our support team is available 24/7");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Property Information Card
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        image: DecorationImage(
                          image: NetworkImage("https://picsum.photos/120/120?random=501&keyword=apartment"),
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
                            "Luxury 3BHK Apartment",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Downtown Paradise, Mumbai",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "\₹2.5 Crores",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Personal Information
              Text(
                "Personal Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QTextField(
                label: "Full Name",
                value: name,
                validator: Validator.required,
                onChanged: (value) {
                  name = value;
                  setState(() {});
                },
              ),

              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Email Address",
                      value: email,
                      validator: Validator.email,
                      onChanged: (value) {
                        email = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
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
                ],
              ),

              // Inquiry Details
              Text(
                "Inquiry Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QDropdownField(
                label: "Inquiry Type",
                items: inquiryTypes,
                value: inquiryType,
                onChanged: (value, label) {
                  inquiryType = value;
                  setState(() {});
                },
              ),

              QMemoField(
                label: "Message",
                value: message,
                hint: "Please describe your inquiry in detail",
                validator: Validator.required,
                onChanged: (value) {
                  message = value;
                  setState(() {});
                },
              ),

              // Contact Preferences
              Text(
                "Contact Preferences",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QDropdownField(
                label: "Preferred Contact Method",
                items: contactMethods,
                value: preferredContact,
                onChanged: (value, label) {
                  preferredContact = value;
                  setState(() {});
                },
              ),

              QDropdownField(
                label: "Preferred Time Slot",
                items: timeSlots,
                value: timeSlot,
                onChanged: (value, label) {
                  timeSlot = value;
                  setState(() {});
                },
              ),

              // Additional Services
              Text(
                "Additional Services",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QSwitch(
                items: [
                  {
                    "label": "Interested in Home Loan Assistance",
                    "value": true,
                    "checked": interestedInLoan,
                  }
                ],
                value: [if (interestedInLoan) {"label": "Interested in Home Loan Assistance", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  interestedInLoan = values.isNotEmpty;
                  setState(() {});
                },
              ),

              QSwitch(
                items: [
                  {
                    "label": "Request Property Site Visit",
                    "value": true,
                    "checked": interestedInSiteVisit,
                  }
                ],
                value: [if (interestedInSiteVisit) {"label": "Request Property Site Visit", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  interestedInSiteVisit = values.isNotEmpty;
                  setState(() {});
                },
              ),

              // Quick Action Buttons
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: infoColor.withAlpha(40)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Quick Actions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Call Agent",
                            icon: Icons.phone,
                            size: bs.sm,
                            onPressed: () {
                              si("Connecting to property agent...");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "WhatsApp",
                            icon: Icons.chat,
                            size: bs.sm,
                            onPressed: () {
                              si("Opening WhatsApp...");
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Similar",
                            icon: Icons.search,
                            size: bs.sm,
                            onPressed: () {
                              si("Showing similar properties...");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Save Property",
                            icon: Icons.favorite,
                            size: bs.sm,
                            onPressed: () {
                              ss("Property saved to favorites");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Terms Agreement
              QSwitch(
                items: [
                  {
                    "label": "I agree to the Terms & Conditions and Privacy Policy",
                    "value": true,
                    "checked": agreeToTerms,
                  }
                ],
                value: [if (agreeToTerms) {"label": "I agree to the Terms & Conditions and Privacy Policy", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  agreeToTerms = values.isNotEmpty;
                  setState(() {});
                },
              ),

              // Submit Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Submit Inquiry",
                  icon: Icons.send,
                  size: bs.md,
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      if (!agreeToTerms) {
                        se("Please agree to Terms & Conditions");
                        return;
                      }
                      
                      showLoading();
                      await Future.delayed(Duration(seconds: 2));
                      hideLoading();
                      
                      ss("Inquiry submitted successfully! We'll contact you within 24 hours.");
                      back();
                    }
                  },
                ),
              ),

              SizedBox(height: spLg),
            ],
          ),
        ),
      ),
    );
  }
}
