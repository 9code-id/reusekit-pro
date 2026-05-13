import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaAgentContactView extends StatefulWidget {
  const RmaAgentContactView({Key? key}) : super(key: key);

  @override
  State<RmaAgentContactView> createState() => _RmaAgentContactViewState();
}

class _RmaAgentContactViewState extends State<RmaAgentContactView> {
  final formKey = GlobalKey<FormState>();
  
  String contactType = "inquiry";
  String urgency = "normal";
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String preferredContact = "email";
  String propertyType = "";
  String priceRange = "";
  String timeframe = "";
  String location = "";
  String message = "";
  bool isPreApproved = false;
  bool agreeToTerms = false;
  
  List<Map<String, dynamic>> contactTypes = [
    {"label": "General Inquiry", "value": "inquiry"},
    {"label": "Buy a Home", "value": "buy"},
    {"label": "Sell a Home", "value": "sell"},
    {"label": "Investment Property", "value": "investment"},
    {"label": "Market Analysis", "value": "analysis"},
  ];

  List<Map<String, dynamic>> urgencyLevels = [
    {"label": "Normal", "value": "normal"},
    {"label": "Urgent - Today", "value": "urgent"},
    {"label": "ASAP - This Week", "value": "asap"},
  ];

  List<Map<String, dynamic>> preferredContactMethods = [
    {"label": "Email", "value": "email"},
    {"label": "Phone Call", "value": "phone"},
    {"label": "Text Message", "value": "text"},
    {"label": "Video Call", "value": "video"},
  ];

  List<Map<String, dynamic>> propertyTypes = [
    {"label": "Single Family Home", "value": "single_family"},
    {"label": "Condominium", "value": "condo"},
    {"label": "Townhouse", "value": "townhouse"},
    {"label": "Multi-Family", "value": "multi_family"},
    {"label": "Luxury Home", "value": "luxury"},
  ];

  List<Map<String, dynamic>> priceRanges = [
    {"label": "Under \$500K", "value": "under_500k"},
    {"label": "\$500K - \$750K", "value": "500k_750k"},
    {"label": "\$750K - \$1M", "value": "750k_1m"},
    {"label": "\$1M - \$2M", "value": "1m_2m"},
    {"label": "Over \$2M", "value": "over_2m"},
  ];

  List<Map<String, dynamic>> timeframes = [
    {"label": "Immediately", "value": "immediate"},
    {"label": "Within 1 Month", "value": "1_month"},
    {"label": "Within 3 Months", "value": "3_months"},
    {"label": "Within 6 Months", "value": "6_months"},
    {"label": "Just Looking", "value": "looking"},
  ];

  List<Map<String, dynamic>> locations = [
    {"label": "Downtown", "value": "downtown"},
    {"label": "Westside", "value": "westside"},
    {"label": "Northside", "value": "northside"},
    {"label": "Eastside", "value": "eastside"},
    {"label": "Suburbs", "value": "suburbs"},
  ];

  Map<String, dynamic> agent = {
    "name": "Sarah Johnson",
    "title": "Senior Real Estate Agent",
    "photo": "https://picsum.photos/150/150?random=1&keyword=woman",
    "rating": 4.9,
    "reviews": 127,
    "phone": "(555) 123-4567",
    "email": "sarah@realestate.com",
    "responseTime": "< 1 hour",
    "specialties": ["First-Time Buyers", "Luxury Homes"],
  };

  void _submitForm() async {
    if (formKey.currentState!.validate()) {
      if (!agreeToTerms) {
        se("Please agree to the terms and conditions");
        return;
      }
      
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss("Message sent successfully! Sarah will contact you within ${agent["responseTime"]}.");
      
      // Reset form
      setState(() {
        firstName = "";
        lastName = "";
        email = "";
        phone = "";
        message = "";
        agreeToTerms = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Agent"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Agent Info Card
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
                        borderRadius: BorderRadius.circular(radiusMd),
                        image: DecorationImage(
                          image: NetworkImage("${agent["photo"]}"),
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
                            "${agent["name"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${agent["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 16,
                                color: warningColor,
                              ),
                              SizedBox(width: spXxs),
                              Text(
                                "${agent["rating"]} (${agent["reviews"]} reviews)",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Responds within ${agent["responseTime"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        QButton(
                          icon: Icons.phone,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                        SizedBox(height: spXs),
                        QButton(
                          icon: Icons.message,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Contact Type & Urgency
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
                      "Contact Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QDropdownField(
                      label: "What can Sarah help you with?",
                      items: contactTypes,
                      value: contactType,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        contactType = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Urgency Level",
                            items: urgencyLevels,
                            value: urgency,
                            onChanged: (value, label) {
                              urgency = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Preferred Contact",
                            items: preferredContactMethods,
                            value: preferredContact,
                            onChanged: (value, label) {
                              preferredContact = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Personal Information
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
                    QTextField(
                      label: "Phone Number",
                      value: phone,
                      validator: Validator.required,
                      onChanged: (value) {
                        phone = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Property Details (conditional)
              if (contactType == "buy" || contactType == "sell" || contactType == "investment")
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
                        "Property Preferences",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      QDropdownField(
                        label: "Property Type",
                        items: propertyTypes,
                        value: propertyType,
                        onChanged: (value, label) {
                          propertyType = value;
                          setState(() {});
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: QDropdownField(
                              label: "Price Range",
                              items: priceRanges,
                              value: priceRange,
                              onChanged: (value, label) {
                                priceRange = value;
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QDropdownField(
                              label: "Timeframe",
                              items: timeframes,
                              value: timeframe,
                              onChanged: (value, label) {
                                timeframe = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      QDropdownField(
                        label: "Preferred Location",
                        items: locations,
                        value: location,
                        onChanged: (value, label) {
                          location = value;
                          setState(() {});
                        },
                      ),
                      if (contactType == "buy")
                        QSwitch(
                          label: "Pre-approved for financing",
                          items: [
                            {
                              "label": "Yes, I'm pre-approved",
                              "value": true,
                              "checked": isPreApproved,
                            }
                          ],
                          value: isPreApproved ? [{"label": "Yes, I'm pre-approved", "value": true, "checked": true}] : [],
                          onChanged: (values, ids) {
                            isPreApproved = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                    ],
                  ),
                ),

              // Message
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
                      "Additional Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QMemoField(
                      label: "Message",
                      value: message,
                      hint: "Tell Sarah about your specific needs, questions, or any additional information that would be helpful...",
                      validator: Validator.required,
                      onChanged: (value) {
                        message = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Quick Response Options
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
                          Icons.access_time,
                          color: infoColor,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Quick Response Options",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Need faster assistance? Use these options for immediate help:",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Call Now",
                            icon: Icons.phone,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Text Message",
                            icon: Icons.sms,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Schedule Call",
                            icon: Icons.calendar_today,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Terms and Conditions
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

              // Submit Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Send Message to Sarah",
                  size: bs.md,
                  onPressed: _submitForm,
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
                      "• Sarah will receive your message immediately\n• You'll get a response within ${agent["responseTime"]}\n• She'll reach out via your preferred contact method\n• No obligation - just helpful information and guidance",
                      style: TextStyle(
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              // Alternative Contact Methods
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
                      "Direct Contact Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: disabledBoldColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Phone",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${agent["phone"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          label: "Call",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.email,
                          color: disabledBoldColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${agent["email"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          label: "Email",
                          size: bs.sm,
                          onPressed: () {},
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
}
