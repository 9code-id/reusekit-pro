import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAbout4View extends StatefulWidget {
  @override
  State<GrlAbout4View> createState() => _GrlAbout4ViewState();
}

class _GrlAbout4ViewState extends State<GrlAbout4View> {
  String selectedContactMethod = 'email';
  bool isBusinessInquiry = false;
  
  String fullName = '';
  String email = '';
  String phone = '';
  String company = '';
  String message = '';
  String subject = '';
  String inquiryType = 'general';
  
  List<Map<String, dynamic>> contactMethods = [
    {
      "id": "email",
      "title": "Email Support",
      "description": "Get help via email within 24 hours",
      "icon": Icons.email,
      "value": "support@company.com",
      "response_time": "24 hours",
      "color": primaryColor,
    },
    {
      "id": "phone",
      "title": "Phone Support",
      "description": "Speak with our team directly",
      "icon": Icons.phone,
      "value": "+1 (555) 123-4567",
      "response_time": "Immediate",
      "color": successColor,
    },
    {
      "id": "chat",
      "title": "Live Chat",
      "description": "Chat with our support team",
      "icon": Icons.chat,
      "value": "Available 9AM-6PM EST",
      "response_time": "< 5 minutes",
      "color": infoColor,
    },
    {
      "id": "social",
      "title": "Social Media",
      "description": "Connect with us on social platforms",
      "icon": Icons.share,
      "value": "@company_handle",
      "response_time": "4-8 hours",
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> inquiryTypes = [
    {
      "label": "General Inquiry",
      "value": "general",
    },
    {
      "label": "Technical Support",
      "value": "technical",
    },
    {
      "label": "Billing Question",
      "value": "billing",
    },
    {
      "label": "Partnership",
      "value": "partnership",
    },
    {
      "label": "Press & Media",
      "value": "press",
    },
    {
      "label": "Career Opportunity",
      "value": "career",
    },
  ];

  List<Map<String, dynamic>> officeLocations = [
    {
      "city": "San Francisco",
      "address": "123 Tech Street, Suite 400\nSan Francisco, CA 94105",
      "phone": "+1 (415) 555-0123",
      "type": "Headquarters",
      "hours": "Mon-Fri: 9AM-6PM PST",
    },
    {
      "city": "New York",
      "address": "456 Business Ave, Floor 15\nNew York, NY 10001",
      "phone": "+1 (212) 555-0456",
      "type": "East Coast Office",
      "hours": "Mon-Fri: 9AM-6PM EST",
    },
    {
      "city": "London",
      "address": "789 Innovation Way\nLondon, UK EC1A 1BB",
      "phone": "+44 20 7123 4567",
      "type": "European Office",
      "hours": "Mon-Fri: 9AM-5PM GMT",
    },
  ];

  List<Map<String, dynamic>> faqs = [
    {
      "question": "How quickly do you respond to inquiries?",
      "answer": "We respond to most inquiries within 24 hours during business days. For urgent matters, please call our support line.",
    },
    {
      "question": "Do you offer phone support?",
      "answer": "Yes, our phone support is available Monday through Friday, 9AM-6PM EST. For international customers, we also offer callback services.",
    },
    {
      "question": "Can I schedule a demo or consultation?",
      "answer": "Absolutely! We offer free consultations and product demos. Please select 'Partnership' as your inquiry type to schedule a meeting.",
    },
    {
      "question": "Where are your offices located?",
      "answer": "We have offices in San Francisco (HQ), New York, and London. Remote support is available globally.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Us"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
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
                  Row(
                    children: [
                      Icon(
                        Icons.support_agent,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Text(
                          "Get in Touch",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Have questions or need assistance? We're here to help! Choose your preferred method of contact below.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(230),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Contact Methods
            Text(
              "Contact Methods",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: contactMethods.map((method) {
                final isSelected = selectedContactMethod == method["id"];
                return GestureDetector(
                  onTap: () {
                    selectedContactMethod = method["id"];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: isSelected ? (method["color"] as Color).withAlpha(20) : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                      border: Border.all(
                        color: isSelected ? (method["color"] as Color) : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: (method["color"] as Color).withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Icon(
                                method["icon"] as IconData,
                                color: method["color"] as Color,
                                size: 24,
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${method["response_time"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "${method["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${method["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${method["value"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: method["color"] as Color,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Contact Form
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spMd),
                      Text(
                        "Send us a Message",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Business Inquiry Toggle
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "This is a business inquiry",
                              "value": true,
                              "checked": isBusinessInquiry,
                            }
                          ],
                          value: [
                            if (isBusinessInquiry)
                              {
                                "label": "This is a business inquiry",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            isBusinessInquiry = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Form Fields
                  QTextField(
                    label: "Full Name",
                    value: fullName,
                    validator: Validator.required,
                    onChanged: (value) {
                      fullName = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
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
                      SizedBox(width: spMd),
                      Expanded(
                        child: QTextField(
                          label: "Phone Number",
                          value: phone,
                          onChanged: (value) {
                            phone = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  if (isBusinessInquiry)
                    Column(
                      children: [
                        QTextField(
                          label: "Company Name",
                          value: company,
                          validator: Validator.required,
                          onChanged: (value) {
                            company = value;
                            setState(() {});
                          },
                        ),
                        SizedBox(height: spMd),
                      ],
                    ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Inquiry Type",
                          items: inquiryTypes,
                          value: inquiryType,
                          onChanged: (value, label) {
                            inquiryType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  QTextField(
                    label: "Subject",
                    value: subject,
                    validator: Validator.required,
                    onChanged: (value) {
                      subject = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  QMemoField(
                    label: "Message",
                    value: message,
                    hint: "Please provide details about your inquiry...",
                    validator: Validator.required,
                    onChanged: (value) {
                      message = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Send Message",
                      size: bs.md,
                      onPressed: () {
                        ss("Message sent successfully!");
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Office Locations
            Text(
              "Office Locations",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ...officeLocations.map((office) => Container(
              margin: EdgeInsets.only(bottom: spMd),
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
                        Icons.location_city,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Text(
                          "${office["city"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${office["type"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${office["address"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${office["phone"]}",
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
                        Icons.access_time,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${office["hours"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )).toList(),
            
            SizedBox(height: spMd),
            
            // FAQ Section
            Text(
              "Frequently Asked Questions",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ...faqs.map((faq) => Container(
              margin: EdgeInsets.only(bottom: spMd),
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
                        Icons.help,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${faq["question"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${faq["answer"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }
}
