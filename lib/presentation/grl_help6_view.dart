import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHelp6View extends StatefulWidget {
  @override
  State<GrlHelp6View> createState() => _GrlHelp6ViewState();
}

class _GrlHelp6ViewState extends State<GrlHelp6View> {
  String selectedTopic = "general";
  String selectedUrgency = "normal";
  String name = "";
  String email = "";
  String phone = "";
  String subject = "";
  String message = "";
  bool preferredContactEmail = true;
  bool preferredContactPhone = false;
  
  final formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> supportTopics = [
    {"label": "General Inquiry", "value": "general"},
    {"label": "Technical Issue", "value": "technical"},
    {"label": "Billing & Payments", "value": "billing"},
    {"label": "Account Problems", "value": "account"},
    {"label": "Feature Request", "value": "feature"},
    {"label": "Bug Report", "value": "bug"},
    {"label": "Partnership", "value": "partnership"},
    {"label": "Other", "value": "other"},
  ];

  List<Map<String, dynamic>> urgencyLevels = [
    {"label": "Normal (2-3 business days)", "value": "normal"},
    {"label": "High (Within 24 hours)", "value": "high"},
    {"label": "Urgent (Within 4 hours)", "value": "urgent"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Support"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Contact Methods
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
                      "We're Here to Help",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Choose how you'd like to get in touch with us",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // navigateTo(LiveChatView());
                            },
                            child: Container(
                              padding: EdgeInsets.all(spMd),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.chat,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  SizedBox(height: spSm),
                                  Text(
                                    "Live Chat",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "Instant help",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // navigateTo(PhoneSupportView());
                            },
                            child: Container(
                              padding: EdgeInsets.all(spMd),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  SizedBox(height: spSm),
                                  Text(
                                    "Call Us",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "24/7 support",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.email,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                SizedBox(height: spSm),
                                Text(
                                  "Email Form",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Current",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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

              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Full Name",
                      value: name,
                      hint: "Enter your full name",
                      validator: Validator.required,
                      onChanged: (value) {
                        name = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: QTextField(
                      label: "Email Address",
                      value: email,
                      hint: "Enter your email",
                      validator: Validator.email,
                      onChanged: (value) {
                        email = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              QTextField(
                label: "Phone Number (Optional)",
                value: phone,
                hint: "Enter your phone number",
                onChanged: (value) {
                  phone = value;
                  setState(() {});
                },
              ),

              // Preferred Contact Method
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: infoColor.withAlpha(50),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Preferred Contact Method",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Email",
                                "value": "email",
                                "checked": preferredContactEmail,
                              }
                            ],
                            value: preferredContactEmail 
                                ? [{"label": "Email", "value": "email", "checked": true}] 
                                : [],
                            onChanged: (values, ids) {
                              preferredContactEmail = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Phone",
                                "value": "phone",
                                "checked": preferredContactPhone,
                              }
                            ],
                            value: preferredContactPhone 
                                ? [{"label": "Phone", "value": "phone", "checked": true}] 
                                : [],
                            onChanged: (values, ids) {
                              preferredContactPhone = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Support Topic
              Text(
                "Support Request Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QDropdownField(
                label: "Topic",
                items: supportTopics,
                value: selectedTopic,
                validator: Validator.required,
                onChanged: (value, label) {
                  selectedTopic = value;
                  setState(() {});
                },
              ),

              QDropdownField(
                label: "Urgency Level",
                items: urgencyLevels,
                value: selectedUrgency,
                validator: Validator.required,
                onChanged: (value, label) {
                  selectedUrgency = value;
                  setState(() {});
                },
              ),

              // Urgency Info
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: _getUrgencyColor(selectedUrgency).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      color: _getUrgencyColor(selectedUrgency),
                      size: 16,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        _getUrgencyMessage(selectedUrgency),
                        style: TextStyle(
                          fontSize: 12,
                          color: _getUrgencyColor(selectedUrgency),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              QTextField(
                label: "Subject",
                value: subject,
                hint: "Brief description of your issue",
                validator: Validator.required,
                onChanged: (value) {
                  subject = value;
                  setState(() {});
                },
              ),

              QMemoField(
                label: "Detailed Message",
                value: message,
                hint: "Please provide as much detail as possible about your request or issue...",
                validator: Validator.required,
                onChanged: (value) {
                  message = value;
                  setState(() {});
                },
              ),

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
                      "Other Ways to Reach Us",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: primaryColor,
                          size: 16,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "+1 (555) 123-4567",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(
                          Icons.email,
                          color: primaryColor,
                          size: 16,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "support@company.com",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: primaryColor,
                          size: 16,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Mon-Fri: 9AM-6PM EST",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Submit Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Send Message",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      _sendMessage();
                    }
                  },
                ),
              ),

              // Response Time Info
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
                      Icons.schedule,
                      color: successColor,
                      size: 24,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "We'll get back to you soon!",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Our team typically responds within 24 hours during business days.",
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

  Color _getUrgencyColor(String urgency) {
    switch (urgency) {
      case 'urgent':
        return dangerColor;
      case 'high':
        return warningColor;
      case 'normal':
        return successColor;
      default:
        return primaryColor;
    }
  }

  String _getUrgencyMessage(String urgency) {
    switch (urgency) {
      case 'urgent':
        return "We'll prioritize your request and respond within 4 hours during business hours.";
      case 'high':
        return "We'll respond to your request within 24 hours.";
      case 'normal':
        return "We'll respond to your request within 2-3 business days.";
      default:
        return "Standard response time applies.";
    }
  }

  void _sendMessage() async {
    showLoading();
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    
    ss("Your message has been sent successfully! We'll get back to you soon.");
    
    // Reset form
    name = "";
    email = "";
    phone = "";
    subject = "";
    message = "";
    selectedTopic = "general";
    selectedUrgency = "normal";
    setState(() {});
  }
}
