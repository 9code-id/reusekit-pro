import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaContactSupportView extends StatefulWidget {
  const FwaContactSupportView({super.key});

  @override
  State<FwaContactSupportView> createState() => _FwaContactSupportViewState();
}

class _FwaContactSupportViewState extends State<FwaContactSupportView> {
  final formKey = GlobalKey<FormState>();
  
  String name = "";
  String email = "";
  String subject = "";
  String message = "";
  String priority = "medium";
  String category = "general";
  List<String> attachments = [];
  bool notifyByEmail = true;
  
  List<Map<String, dynamic>> priorityOptions = [
    {"label": "Low", "value": "low"},
    {"label": "Medium", "value": "medium"},
    {"label": "High", "value": "high"},
    {"label": "Urgent", "value": "urgent"}
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "General Inquiry", "value": "general"},
    {"label": "Technical Issue", "value": "technical"},
    {"label": "Billing Question", "value": "billing"},
    {"label": "Feature Request", "value": "feature"},
    {"label": "Bug Report", "value": "bug"},
    {"label": "Account Issue", "value": "account"}
  ];

  List<Map<String, dynamic>> supportChannels = [
    {
      "title": "Live Chat",
      "subtitle": "Get instant help from our team",
      "icon": Icons.chat,
      "color": successColor,
      "available": true,
      "responseTime": "< 2 minutes"
    },
    {
      "title": "Phone Support",
      "subtitle": "+1 (555) 123-4567",
      "icon": Icons.phone,
      "color": infoColor,
      "available": true,
      "responseTime": "Available 24/7"
    },
    {
      "title": "Email Support",
      "subtitle": "support@company.com",
      "icon": Icons.email,
      "color": warningColor,
      "available": true,
      "responseTime": "< 4 hours"
    },
    {
      "title": "Community Forum",
      "subtitle": "Get help from community",
      "icon": Icons.forum,
      "color": primaryColor,
      "available": true,
      "responseTime": "< 24 hours"
    }
  ];

  void _submitTicket() async {
    if (!formKey.currentState!.validate()) return;
    
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    ss("Support ticket submitted successfully! Ticket ID: #SP${DateTime.now().millisecondsSinceEpoch}");
    
    // Clear form
    name = "";
    email = "";
    subject = "";
    message = "";
    attachments.clear();
    setState(() {});
  }

  void _openSupportChannel(Map<String, dynamic> channel) {
    String title = "${channel["title"]}";
    switch (title) {
      case "Live Chat":
        si("Opening live chat...");
        break;
      case "Phone Support":
        si("Calling ${channel["subtitle"]}...");
        break;
      case "Email Support":
        si("Opening email client...");
        break;
      case "Community Forum":
        si("Opening community forum...");
        break;
    }
  }

  Color _getPriorityColor(String priorityValue) {
    switch (priorityValue) {
      case "low":
        return successColor;
      case "medium":
        return warningColor;
      case "high":
        return dangerColor;
      case "urgent":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Support"),
        actions: [
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: () {
              si("Opening live chat...");
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
              // Support Channels
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
                      "Quick Support Options",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Need immediate help? Try these options",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: supportChannels.map((channel) {
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            border: Border.all(color: disabledOutlineBorderColor),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: InkWell(
                            onTap: () => _openSupportChannel(channel),
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Column(
                              spacing: spSm,
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: (channel["color"] as Color).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    channel["icon"] as IconData,
                                    color: channel["color"] as Color,
                                    size: 24,
                                  ),
                                ),
                                Text(
                                  "${channel["title"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "${channel["subtitle"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: (channel["color"] as Color).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${channel["responseTime"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: channel["color"] as Color,
                                    ),
                                  ),
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

              // Support Ticket Form
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
                      "Submit Support Ticket",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Fill out the form below and we'll get back to you soon",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
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
                          child: QDropdownField(
                            label: "Category",
                            items: categoryOptions,
                            value: category,
                            onChanged: (value, label) {
                              category = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Priority",
                            items: priorityOptions,
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
                      hint: "Please describe your issue in detail...",
                      validator: Validator.required,
                      onChanged: (value) {
                        message = value;
                        setState(() {});
                      },
                    ),
                    QAttachmentPicker(
                      label: "Attachments (Optional)",
                      value: attachments,
                      hint: "Attach screenshots, logs, or documents",
                      maxAttachments: 5,
                      onChanged: (value) {
                        attachments = value;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Notify me by email when there's an update",
                          "value": true,
                          "checked": notifyByEmail,
                        }
                      ],
                      value: [
                        if (notifyByEmail)
                          {"label": "Notify me by email when there's an update", "value": true, "checked": true}
                      ],
                      onChanged: (values, ids) {
                        notifyByEmail = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Submit Ticket",
                        icon: Icons.send,
                        onPressed: _submitTicket,
                      ),
                    ),
                  ],
                ),
              ),

              // Expected Response Times
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
                      "Expected Response Times",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ...priorityOptions.map((priorityItem) {
                      String priorityValue = "${priorityItem["value"]}";
                      String responseTime;
                      
                      switch (priorityValue) {
                        case "low":
                          responseTime = "24-48 hours";
                          break;
                        case "medium":
                          responseTime = "4-12 hours";
                          break;
                        case "high":
                          responseTime = "1-4 hours";
                          break;
                        case "urgent":
                          responseTime = "< 1 hour";
                          break;
                        default:
                          responseTime = "24 hours";
                      }
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: Border.all(color: disabledOutlineBorderColor),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: _getPriorityColor(priorityValue),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${priorityItem["label"]} Priority",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Text(
                              responseTime,
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),

              // Additional Information
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
                        Icon(Icons.info, color: infoColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Before submitting a ticket",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "• Check our FAQ section for quick answers\n• Include detailed steps to reproduce the issue\n• Attach relevant screenshots or error messages\n• Provide your account information if applicable",
                      style: TextStyle(
                        fontSize: 14,
                        color: infoColor,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QButton(
                      label: "View FAQ",
                      size: bs.sm,
                      onPressed: () {
                        si("Opening FAQ section...");
                      },
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
