import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaCallSupportView extends StatefulWidget {
  const BfaCallSupportView({super.key});

  @override
  State<BfaCallSupportView> createState() => _BfaCallSupportViewState();
}

class _BfaCallSupportViewState extends State<BfaCallSupportView> {
  final formKey = GlobalKey<FormState>();
  String selectedCategory = "General Inquiry";
  String priority = "Medium";
  String name = "";
  String email = "";
  String phone = "";
  String subject = "";
  String description = "";
  bool preferCallback = false;
  String preferredTime = "Morning";
  List<String> attachments = [];

  List<Map<String, dynamic>> categoryItems = [
    {"label": "General Inquiry", "value": "General Inquiry"},
    {"label": "Account Issues", "value": "Account Issues"},
    {"label": "Payment Problems", "value": "Payment Problems"},
    {"label": "Technical Support", "value": "Technical Support"},
    {"label": "Premium Features", "value": "Premium Features"},
    {"label": "Credit Report Issues", "value": "Credit Report Issues"},
    {"label": "Budget Planning", "value": "Budget Planning"},
    {"label": "Retirement Planning", "value": "Retirement Planning"},
    {"label": "Data Privacy", "value": "Data Privacy"},
    {"label": "App Performance", "value": "App Performance"},
    {"label": "Feature Request", "value": "Feature Request"},
    {"label": "Complaint", "value": "Complaint"},
  ];

  List<Map<String, dynamic>> priorityItems = [
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Critical", "value": "Critical"},
  ];

  List<Map<String, dynamic>> timeSlotItems = [
    {"label": "Morning (9 AM - 12 PM)", "value": "Morning"},
    {"label": "Afternoon (12 PM - 5 PM)", "value": "Afternoon"},
    {"label": "Evening (5 PM - 8 PM)", "value": "Evening"},
  ];

  List<Map<String, dynamic>> supportChannels = [
    {
      "title": "Phone Support",
      "subtitle": "1-800-BFA-HELP",
      "description": "Available 24/7 for immediate assistance",
      "icon": Icons.phone,
      "color": successColor,
      "available": true,
    },
    {
      "title": "Live Chat",
      "subtitle": "Online chat support",
      "description": "Average response time: 2-3 minutes",
      "icon": Icons.chat,
      "color": infoColor,
      "available": true,
    },
    {
      "title": "Email Support",
      "subtitle": "support@bfa.com",
      "description": "Response within 24 hours",
      "icon": Icons.email,
      "color": primaryColor,
      "available": true,
    },
    {
      "title": "Video Call",
      "subtitle": "Screen sharing support",
      "description": "Schedule a video consultation",
      "icon": Icons.video_call,
      "color": warningColor,
      "available": false,
    },
  ];

  List<Map<String, dynamic>> faqData = [
    {
      "question": "How do I reset my password?",
      "answer": "Go to Settings > Account Security > Change Password and follow the prompts.",
      "category": "Account",
    },
    {
      "question": "Why is my credit score not updating?",
      "answer": "Credit scores are updated monthly. Check back after your next billing cycle.",
      "category": "Credit",
    },
    {
      "question": "How do I cancel my premium subscription?",
      "answer": "Visit Settings > Subscription > Manage Plan > Cancel Subscription.",
      "category": "Billing",
    },
    {
      "question": "Can I export my budget data?",
      "answer": "Yes, go to Budget Planner > Export Data > Choose format (PDF/Excel).",
      "category": "Features",
    },
  ];

  int selectedTabIndex = 0;

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Low":
        return successColor;
      case "Medium":
        return warningColor;
      case "High":
        return primaryColor;
      case "Critical":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Customer Support",
      selectedIndex: selectedTabIndex,
      tabs: [
        Tab(text: "Contact", icon: Icon(Icons.contact_support)),
        Tab(text: "Channels", icon: Icon(Icons.support_agent)),
        Tab(text: "FAQ", icon: Icon(Icons.help)),
      ],
      tabChildren: [
        _buildContactForm(),
        _buildSupportChannels(),
        _buildFAQSection(),
      ],
    );
  }

  Widget _buildContactForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Form(
        key: formKey,
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor.withAlpha(20), successColor.withAlpha(20)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Icon(
                    Icons.headset_mic,
                    size: 48,
                    color: primaryColor,
                  ),
                  Text(
                    "How can we help you?",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Fill out the form below and our support team will get back to you as soon as possible.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            
            Text(
              "Contact Information",
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
                    validator: Validator.required,
                    onChanged: (value) {
                      phone = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            Text(
              "Issue Details",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categoryItems,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QDropdownField(
                    label: "Priority",
                    items: priorityItems,
                    value: priority,
                    onChanged: (value, label) {
                      priority = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: _getPriorityColor(priority).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: _getPriorityColor(priority).withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info,
                    color: _getPriorityColor(priority),
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      priority == "Critical" 
                        ? "Critical issues receive immediate attention within 1 hour"
                        : priority == "High"
                        ? "High priority issues are handled within 4 hours"
                        : priority == "Medium"
                        ? "Medium priority issues are resolved within 24 hours"
                        : "Low priority issues are addressed within 48 hours",
                      style: TextStyle(
                        fontSize: 12,
                        color: _getPriorityColor(priority),
                      ),
                    ),
                  ),
                ],
              ),
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
              validator: Validator.required,
              hint: "Please provide detailed information about your issue...",
              onChanged: (value) {
                description = value;
                setState(() {});
              },
            ),
            
            QAttachmentPicker(
              label: "Attachments",
              value: attachments,
              hint: "Add screenshots or documents to help us understand your issue",
              maxAttachments: 5,
              onChanged: (value) {
                attachments = value;
                setState(() {});
              },
            ),
            
            Text(
              "Callback Preferences",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            QSwitch(
              items: [
                {
                  "label": "Request callback from support team",
                  "value": true,
                  "checked": preferCallback,
                }
              ],
              value: [
                if (preferCallback)
                  {
                    "label": "Request callback from support team",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                preferCallback = values.isNotEmpty;
                setState(() {});
              },
            ),
            
            if (preferCallback) ...[
              QDropdownField(
                label: "Preferred Time",
                items: timeSlotItems,
                value: preferredTime,
                onChanged: (value, label) {
                  preferredTime = value;
                  setState(() {});
                },
              ),
            ],
            
            Container(
              width: double.infinity,
              child: QButton(
                label: "Submit Support Request",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // Handle form submission
                    ss("Support request submitted successfully!");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportChannels() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [infoColor.withAlpha(20), primaryColor.withAlpha(20)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Icon(
                  Icons.support_agent,
                  size: 48,
                  color: primaryColor,
                ),
                Text(
                  "Multiple Ways to Reach Us",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Choose the support channel that works best for you",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          
          Text(
            "Available Support Channels",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          ...supportChannels.map((channel) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border.all(
                  color: channel["available"] 
                    ? (channel["color"] as Color).withAlpha(50)
                    : disabledColor,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(radiusMd),
                  onTap: channel["available"] ? () {
                    // Handle channel selection
                    si("Connecting to ${channel["title"]}...");
                  } : null,
                  child: Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: channel["available"] 
                              ? (channel["color"] as Color).withAlpha(20)
                              : disabledColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            channel["icon"],
                            color: channel["available"] 
                              ? channel["color"]
                              : disabledBoldColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${channel["title"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: channel["available"] 
                                        ? primaryColor
                                        : disabledBoldColor,
                                    ),
                                  ),
                                  if (!channel["available"]) ...[
                                    SizedBox(width: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: disabledColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "Coming Soon",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${channel["subtitle"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: channel["available"] 
                                    ? channel["color"]
                                    : disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${channel["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (channel["available"])
                          Icon(
                            Icons.arrow_forward_ios,
                            color: disabledBoldColor,
                            size: 16,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
          
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: successColor.withAlpha(50)),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      color: successColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Support Hours",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "• Phone Support: 24/7 availability\n• Live Chat: Monday - Friday, 8 AM - 10 PM EST\n• Email Support: Responses within 24 hours\n• Emergency Support: Available for critical issues",
                  style: TextStyle(
                    color: successColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQSection() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [warningColor.withAlpha(20), infoColor.withAlpha(20)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Icon(
                  Icons.help_center,
                  size: 48,
                  color: primaryColor,
                ),
                Text(
                  "Frequently Asked Questions",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Find quick answers to common questions",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          
          QTextField(
            label: "Search FAQ",
            value: "",
            hint: "Type your question or keyword...",
            onChanged: (value) {
              setState(() {});
            },
          ),
          
          Text(
            "Popular Questions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          ...faqData.map((faq) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: ExpansionTile(
                title: Text(
                  "${faq["question"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: spXs),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${faq["category"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: infoColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Text(
                      "${faq["answer"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          
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
                Icon(
                  Icons.contact_support,
                  color: primaryColor,
                  size: 32,
                ),
                Text(
                  "Still need help?",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "If you can't find the answer you're looking for, our support team is here to help.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: spSm),
                QButton(
                  label: "Contact Support",
                  size: bs.sm,
                  onPressed: () {
                    selectedTabIndex = 0;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
