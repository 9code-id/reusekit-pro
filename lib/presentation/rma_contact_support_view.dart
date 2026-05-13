import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaContactSupportView extends StatefulWidget {
  const RmaContactSupportView({super.key});

  @override
  State<RmaContactSupportView> createState() => _RmaContactSupportViewState();
}

class _RmaContactSupportViewState extends State<RmaContactSupportView> {
  String selectedCategory = "general";
  String subject = "";
  String message = "";
  String email = "";
  String phone = "";
  String priority = "medium";

  List<Map<String, dynamic>> categories = [
    {"label": "General Inquiry", "value": "general"},
    {"label": "Technical Support", "value": "technical"},
    {"label": "Billing & Payments", "value": "billing"},
    {"label": "Property Listings", "value": "listings"},
    {"label": "Account Issues", "value": "account"},
    {"label": "Feature Request", "value": "feature"},
  ];

  List<Map<String, dynamic>> priorityLevels = [
    {"label": "Low", "value": "low"},
    {"label": "Medium", "value": "medium"},
    {"label": "High", "value": "high"},
    {"label": "Urgent", "value": "urgent"},
  ];

  List<Map<String, dynamic>> supportChannels = [
    {
      "title": "Live Chat",
      "description": "Get instant help from our support team",
      "availability": "24/7 Available",
      "icon": Icons.chat,
      "color": Colors.green,
      "action": "Start Chat"
    },
    {
      "title": "Phone Support",
      "description": "Speak directly with our experts",
      "availability": "Mon-Fri 9AM-6PM",
      "icon": Icons.phone,
      "color": Colors.blue,
      "action": "Call Now"
    },
    {
      "title": "Email Support",
      "description": "Send us detailed questions",
      "availability": "Response within 24h",
      "icon": Icons.email,
      "color": Colors.orange,
      "action": "Send Email"
    },
    {
      "title": "Video Call",
      "description": "Schedule a screen sharing session",
      "availability": "By Appointment",
      "icon": Icons.video_call,
      "color": Colors.purple,
      "action": "Schedule"
    },
  ];

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Reset Password",
      "description": "Having trouble logging in?",
      "icon": Icons.lock_reset,
      "category": "account"
    },
    {
      "title": "Report Bug",
      "description": "Found something not working?",
      "icon": Icons.bug_report,
      "category": "technical"
    },
    {
      "title": "Billing Question",
      "description": "Questions about charges?",
      "icon": Icons.receipt,
      "category": "billing"
    },
    {
      "title": "Feature Request",
      "description": "Suggest new features",
      "icon": Icons.lightbulb,
      "category": "feature"
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
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "We're Here to Help",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Get the support you need for your real estate management",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(230),
                    ),
                  ),
                  SizedBox(height: spLg),
                  Row(
                    children: [
                      Expanded(
                        child: _buildHeaderStat(
                          "Avg Response",
                          "< 2 hours",
                          Icons.schedule,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildHeaderStat(
                          "Resolution Rate",
                          "98.5%",
                          Icons.check_circle,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildHeaderStat(
                          "Satisfaction",
                          "4.9/5",
                          Icons.star,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Support Channels
            Text(
              "Choose Your Preferred Support Channel",
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
              children: supportChannels.map((channel) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (channel["color"] as Color).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              channel["icon"] as IconData,
                              color: channel["color"] as Color,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${channel["title"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${channel["availability"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${channel["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spMd),
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "${channel["action"]}",
                          size: bs.sm,
                          onPressed: () {
                            ss("${channel["action"]} initiated successfully!");
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spLg),

            // Quick Actions
            Text(
              "Quick Actions",
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
              children: quickActions.map((action) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          action["icon"] as IconData,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${action["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${action["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          selectedCategory = action["category"];
                          ss("Quick action selected: ${action["title"]}");
                          setState(() {});
                        },
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: disabledBoldColor,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spLg),

            // Contact Form
            Text(
              "Send us a Message",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: spMd,
                  children: [
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
                            onChanged: (value) {
                              phone = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Category",
                            items: categories,
                            value: selectedCategory,
                            onChanged: (value, label) {
                              selectedCategory = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Priority",
                            items: priorityLevels,
                            value: priority,
                            onChanged: (value, label) {
                              priority = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
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
                      label: "Message",
                      value: message,
                      validator: Validator.required,
                      hint: "Please describe your issue or question in detail...",
                      onChanged: (value) {
                        message = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Send Message",
                        size: bs.md,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            ss("Support message sent successfully! We'll respond within 24 hours.");
                            // Reset form
                            email = "";
                            phone = "";
                            subject = "";
                            message = "";
                            selectedCategory = "general";
                            priority = "medium";
                            setState(() {});
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderStat(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }
}
