import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsContactSupportView extends StatefulWidget {
  const BrsContactSupportView({super.key});

  @override
  State<BrsContactSupportView> createState() => _BrsContactSupportViewState();
}

class _BrsContactSupportViewState extends State<BrsContactSupportView> {
  String selectedIssueType = "General Inquiry";
  String subject = "";
  String description = "";
  String email = "";
  String phone = "";
  String priority = "Medium";
  List<String> attachments = [];

  List<Map<String, dynamic>> issueTypes = [
    {"label": "General Inquiry", "value": "General Inquiry"},
    {"label": "Booking Issue", "value": "Booking Issue"},
    {"label": "Payment Problem", "value": "Payment Problem"},
    {"label": "Technical Bug", "value": "Technical Bug"},
    {"label": "Account Access", "value": "Account Access"},
    {"label": "Barber Complaint", "value": "Barber Complaint"},
    {"label": "App Feedback", "value": "App Feedback"},
    {"label": "Feature Request", "value": "Feature Request"},
  ];

  List<Map<String, dynamic>> priorityLevels = [
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Urgent", "value": "Urgent"},
  ];

  List<Map<String, dynamic>> supportChannels = [
    {
      "title": "Live Chat",
      "description": "Get instant help from our support team",
      "icon": Icons.chat,
      "color": primaryColor,
      "available": true,
      "responseTime": "< 5 minutes",
    },
    {
      "title": "Email Support",
      "description": "Send us a detailed message",
      "icon": Icons.email,
      "color": infoColor,
      "available": true,
      "responseTime": "< 24 hours",
    },
    {
      "title": "Phone Support",
      "description": "Speak directly with our team",
      "icon": Icons.phone,
      "color": successColor,
      "available": true,
      "responseTime": "Business hours",
    },
    {
      "title": "Video Call",
      "description": "Screen sharing and live assistance",
      "icon": Icons.video_call,
      "color": warningColor,
      "available": false,
      "responseTime": "By appointment",
    },
  ];

  List<Map<String, dynamic>> commonTopics = [
    {
      "title": "How to cancel a booking",
      "icon": Icons.cancel,
      "color": dangerColor,
    },
    {
      "title": "Payment not processed",
      "icon": Icons.payment,
      "color": warningColor,
    },
    {
      "title": "Can't find my barber",
      "icon": Icons.search,
      "color": infoColor,
    },
    {
      "title": "App crashes frequently",
      "icon": Icons.bug_report,
      "color": dangerColor,
    },
    {
      "title": "Update profile information",
      "icon": Icons.person,
      "color": successColor,
    },
    {
      "title": "Notification settings",
      "icon": Icons.notifications,
      "color": primaryColor,
    },
  ];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Support"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spLg,
          children: [
            // Support Channels
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Choose How to Contact Us",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.all(spSm),
                  minItemWidth: 200,
                  children: supportChannels.map((channel) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                        border: (channel["available"] as bool) 
                            ? null 
                            : Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Column(
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: (channel["available"] as bool)
                                      ? (channel["color"] as Color).withAlpha(30)
                                      : disabledColor.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  channel["icon"] as IconData,
                                  color: (channel["available"] as bool)
                                      ? channel["color"] as Color
                                      : disabledBoldColor,
                                  size: 20,
                                ),
                              ),
                              Spacer(),
                              if (!(channel["available"] as bool))
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: disabledColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "Coming Soon",
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "${channel["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: (channel["available"] as bool)
                                      ? primaryColor
                                      : disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${channel["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Response: ${channel["responseTime"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: (channel["available"] as bool)
                                      ? successColor
                                      : disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: (channel["available"] as bool) ? "Contact Now" : "Unavailable",
                              size: bs.sm,
                              onPressed: (channel["available"] as bool) ? () {} : null,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),

            // Quick Help Topics
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Common Help Topics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QHorizontalScroll(
                  children: commonTopics.map((topic) {
                    return Container(
                      width: 150,
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        spacing: spSm,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: (topic["color"] as Color).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              topic["icon"] as IconData,
                              color: topic["color"] as Color,
                              size: 20,
                            ),
                          ),
                          Text(
                            "${topic["title"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "Get Help",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),

            // Contact Form
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Send Us a Message",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spSm,
                      children: [
                        Row(
                          spacing: spSm,
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
                        
                        QDropdownField(
                          label: "Issue Type",
                          items: issueTypes,
                          value: selectedIssueType,
                          validator: Validator.required,
                          onChanged: (value, label) {
                            selectedIssueType = value;
                            setState(() {});
                          },
                        ),
                        
                        QDropdownField(
                          label: "Priority Level",
                          items: priorityLevels,
                          value: priority,
                          validator: Validator.required,
                          onChanged: (value, label) {
                            priority = value;
                            setState(() {});
                          },
                        ),
                        
                        QTextField(
                          label: "Subject",
                          value: subject,
                          validator: Validator.required,
                          onChanged: (value) {
                            subject = value;
                            setState(() {});
                          },
                        ),
                        
                        QMemoField(
                          label: "Description",
                          value: description,
                          hint: "Please describe your issue in detail...",
                          validator: Validator.required,
                          onChanged: (value) {
                            description = value;
                            setState(() {});
                          },
                        ),
                        
                        QAttachmentPicker(
                          label: "Attachments",
                          value: attachments,
                          hint: "Add screenshots or documents (optional)",
                          maxAttachments: 5,
                          allowedTypes: ['image', 'document'],
                          onChanged: (value) {
                            attachments = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Send Message",
                      size: bs.md,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          showLoading();
                          // Simulate sending
                          Future.delayed(Duration(seconds: 2), () {
                            hideLoading();
                            ss("Support request sent successfully! We'll get back to you soon.");
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Support Hours
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Support Hours",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Live Chat & Phone",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Monday - Friday: 9:00 AM - 6:00 PM",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Saturday: 10:00 AM - 4:00 PM",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Email Support",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "24/7 Response",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Usually within 24 hours",
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
              ),
            ),

            // Emergency Contact
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.emergency,
                        color: dangerColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Emergency Support",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "For urgent issues that require immediate attention, please call our emergency support line:",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: dangerColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "+1 (555) 123-HELP",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Call Now",
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
    );
  }
}
