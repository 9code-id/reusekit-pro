import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CshEmailIntegrationView extends StatefulWidget {
  const CshEmailIntegrationView({super.key});

  @override
  State<CshEmailIntegrationView> createState() => _CshEmailIntegrationViewState();
}

class _CshEmailIntegrationViewState extends State<CshEmailIntegrationView> {
  String emailProvider = "Gmail";
  String emailAddress = "";
  String smtpServer = "";
  String smtpPort = "587";
  String imapServer = "";
  String imapPort = "993";
  String password = "";
  bool enableSSL = true;
  bool autoReply = false;
  String autoReplyMessage = "";
  bool createTicketsFromEmail = true;
  bool enableEmailSignature = true;
  String emailSignature = "";
  
  List<Map<String, dynamic>> emailProviders = [
    {"label": "Gmail", "value": "Gmail"},
    {"label": "Outlook", "value": "Outlook"},
    {"label": "Yahoo Mail", "value": "Yahoo Mail"},
    {"label": "Custom SMTP/IMAP", "value": "Custom SMTP/IMAP"},
    {"label": "Exchange Server", "value": "Exchange Server"},
    {"label": "Office 365", "value": "Office 365"},
  ];

  List<Map<String, dynamic>> connectionStats = [
    {
      "title": "Connection Status",
      "value": "Connected",
      "icon": Icons.email,
      "color": successColor,
      "subtitle": "Last check: 1 minute ago"
    },
    {
      "title": "Emails Processed",
      "value": "2,847",
      "icon": Icons.mail_outline,
      "color": primaryColor,
      "subtitle": "Total emails handled today"
    },
    {
      "title": "Tickets Created",
      "value": "156",
      "icon": Icons.confirmation_number,
      "color": infoColor,
      "subtitle": "From email inquiries"
    },
    {
      "title": "Response Rate",
      "value": "94.2%",
      "icon": Icons.reply,
      "color": successColor,
      "subtitle": "Average response rate"
    },
  ];

  List<Map<String, dynamic>> emailTemplates = [
    {
      "name": "Welcome Message",
      "subject": "Welcome to our support",
      "category": "Greeting",
      "usage": 456,
      "lastModified": "2 days ago",
      "isActive": true
    },
    {
      "name": "Ticket Received",
      "subject": "We've received your request",
      "category": "Confirmation",
      "usage": 1247,
      "lastModified": "1 week ago",
      "isActive": true
    },
    {
      "name": "Issue Resolved",
      "subject": "Your issue has been resolved",
      "category": "Resolution",
      "usage": 892,
      "lastModified": "3 days ago",
      "isActive": true
    },
    {
      "name": "Follow-up Survey",
      "subject": "How was your support experience?",
      "category": "Survey",
      "usage": 234,
      "lastModified": "1 day ago",
      "isActive": false
    },
    {
      "name": "Escalation Notice",
      "subject": "Your case has been escalated",
      "category": "Escalation",
      "usage": 67,
      "lastModified": "5 days ago",
      "isActive": true
    },
  ];

  List<Map<String, dynamic>> emailRules = [
    {
      "name": "Priority Detection",
      "description": "Automatically set priority based on email keywords",
      "condition": "Subject contains: URGENT, CRITICAL, EMERGENCY",
      "action": "Set priority to High",
      "enabled": true,
      "category": "Priority"
    },
    {
      "name": "Auto-categorization",
      "description": "Categorize tickets based on email content",
      "condition": "Body contains technical terms",
      "action": "Assign to Technical Support team",
      "enabled": true,
      "category": "Routing"
    },
    {
      "name": "VIP Customer Detection",
      "description": "Identify VIP customers and prioritize their emails",
      "condition": "Sender email in VIP list",
      "action": "Set priority to High and assign to senior agent",
      "enabled": true,
      "category": "VIP"
    },
    {
      "name": "Spam Filter",
      "description": "Filter out spam and promotional emails",
      "condition": "Contains promotional keywords",
      "action": "Mark as spam and do not create ticket",
      "enabled": true,
      "category": "Filter"
    },
    {
      "name": "After Hours Response",
      "description": "Send auto-reply for emails received outside business hours",
      "condition": "Received outside 9 AM - 5 PM",
      "action": "Send after hours auto-reply",
      "enabled": false,
      "category": "Auto-Reply"
    },
  ];

  List<Map<String, dynamic>> recentEmails = [
    {
      "from": "customer@example.com",
      "subject": "Login issues with my account",
      "timestamp": "5 minutes ago",
      "status": "processed",
      "ticketId": "TK-12847",
      "priority": "medium",
      "assigned": "Sarah Johnson"
    },
    {
      "from": "support@vendor.com",
      "subject": "URGENT: Server downtime notification",
      "timestamp": "12 minutes ago",
      "status": "processed",
      "ticketId": "TK-12846",
      "priority": "high",
      "assigned": "Mike Chen"
    },
    {
      "from": "billing@company.com",
      "subject": "Invoice inquiry - Payment issue",
      "timestamp": "23 minutes ago",
      "status": "processed",
      "ticketId": "TK-12845",
      "priority": "low",
      "assigned": "Emily Davis"
    },
    {
      "from": "feedback@client.org",
      "subject": "Thank you for excellent service",
      "timestamp": "1 hour ago",
      "status": "archived",
      "ticketId": null,
      "priority": "low",
      "assigned": null
    },
    {
      "from": "spam.sender@fake.com",
      "subject": "You've won a million dollars!!!",
      "timestamp": "2 hours ago",
      "status": "filtered",
      "ticketId": null,
      "priority": null,
      "assigned": null
    },
  ];

  void _testConnection() async {
    if (emailAddress.isEmpty || password.isEmpty) {
      se("Please enter email credentials");
      return;
    }

    showLoading();
    
    // Simulate connection test
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    
    ss("Email connection test successful!");
  }

  void _saveConfiguration() async {
    if (emailAddress.isEmpty) {
      se("Please enter email address");
      return;
    }

    showLoading();
    
    // Simulate saving configuration
    await Future.delayed(Duration(seconds: 1));
    
    hideLoading();
    
    ss("Email integration configuration saved successfully!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Email Integration"),
        actions: [
          IconButton(
            icon: Icon(Icons.sync),
            onPressed: () {
              ss("Email synchronization started");
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              ss("Email settings opened");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Connection Overview
            Text(
              "Email Integration Overview",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.all(0),
              minItemWidth: 200,
              children: connectionStats.map((stat) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (stat["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              stat["icon"] as IconData,
                              size: 20,
                              color: stat["color"] as Color,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${stat["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${stat["value"]}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${stat["subtitle"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Email Configuration
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email Configuration",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QDropdownField(
                    label: "Email Provider",
                    items: emailProviders,
                    value: emailProvider,
                    onChanged: (value, label) {
                      emailProvider = value;
                      setState(() {});
                    },
                  ),
                  QTextField(
                    label: "Email Address",
                    value: emailAddress,
                    hint: "support@yourcompany.com",
                    onChanged: (value) {
                      emailAddress = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "SMTP Server",
                          value: smtpServer,
                          hint: "smtp.gmail.com",
                          onChanged: (value) {
                            smtpServer = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QTextField(
                          label: "SMTP Port",
                          value: smtpPort,
                          hint: "587",
                          onChanged: (value) {
                            smtpPort = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "IMAP Server",
                          value: imapServer,
                          hint: "imap.gmail.com",
                          onChanged: (value) {
                            imapServer = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QTextField(
                          label: "IMAP Port",
                          value: imapPort,
                          hint: "993",
                          onChanged: (value) {
                            imapPort = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QTextField(
                    label: "Password / App Password",
                    value: password,
                    hint: "Enter your email password",
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Enable SSL/TLS encryption",
                        "value": "ssl",
                        "checked": enableSSL,
                      }
                    ],
                    value: enableSSL
                        ? [{"label": "Enable SSL/TLS encryption", "value": "ssl", "checked": true}]
                        : [],
                    onChanged: (values, ids) {
                      enableSSL = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Email Processing Rules
            Text(
              "Email Processing Rules",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: emailRules.map((rule) {
                  int index = emailRules.indexOf(rule);
                  bool isEnabled = rule["enabled"] as bool;
                  Color categoryColor = rule["category"] == "Priority"
                      ? dangerColor
                      : rule["category"] == "Routing"
                          ? primaryColor
                          : rule["category"] == "VIP"
                              ? warningColor
                              : rule["category"] == "Filter"
                                  ? infoColor
                                  : successColor;

                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: index < emailRules.length - 1
                            ? BorderSide(
                                color: disabledOutlineBorderColor,
                                width: 1,
                              )
                            : BorderSide.none,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${rule["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: categoryColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${rule["category"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: categoryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${rule["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Condition: ${rule["condition"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "Action: ${rule["action"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: isEnabled,
                          onChanged: (value) {
                            setState(() {
                              emailRules[index]["enabled"] = value;
                            });
                          },
                          activeColor: successColor,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            // Email Templates
            Text(
              "Email Templates",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: emailTemplates.map((template) {
                  int index = emailTemplates.indexOf(template);
                  bool isActive = template["isActive"] as bool;

                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: index < emailTemplates.length - 1
                            ? BorderSide(
                                color: disabledOutlineBorderColor,
                                width: 1,
                              )
                            : BorderSide.none,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${template["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isActive
                                          ? successColor.withAlpha(20)
                                          : disabledColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      isActive ? "Active" : "Inactive",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: isActive ? successColor : disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${template["subject"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Text(
                                    "${template["category"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "Used ${template["usage"]} times",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "Modified ${template["lastModified"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          spacing: spXs,
                          children: [
                            QButton(
                              icon: Icons.edit,
                              size: bs.sm,
                              onPressed: () {
                                ss("Editing template: ${template["name"]}");
                              },
                            ),
                            QButton(
                              icon: isActive ? Icons.pause : Icons.play_arrow,
                              size: bs.sm,
                              onPressed: () {
                                String action = isActive ? "deactivated" : "activated";
                                ss("Template ${action}");
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            // Recent Email Activity
            Text(
              "Recent Email Activity",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: recentEmails.map((email) {
                  int index = recentEmails.indexOf(email);
                  Color statusColor = email["status"] == "processed"
                      ? successColor
                      : email["status"] == "filtered"
                          ? dangerColor
                          : warningColor;

                  Color priorityColor = email["priority"] == "high"
                      ? dangerColor
                      : email["priority"] == "medium"
                          ? warningColor
                          : successColor;

                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: index < recentEmails.length - 1
                            ? BorderSide(
                                color: disabledOutlineBorderColor,
                                width: 1,
                              )
                            : BorderSide.none,
                      ),
                    ),
                    child: Column(
                      spacing: spXs,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${email["subject"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${email["status"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: statusColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "From: ${email["from"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${email["timestamp"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        if (email["ticketId"] != null) ...[
                          Row(
                            children: [
                              Text(
                                "Ticket: ${email["ticketId"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              if (email["priority"] != null)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: priorityColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${email["priority"]} priority",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: priorityColor,
                                    ),
                                  ),
                                ),
                              Spacer(),
                              if (email["assigned"] != null)
                                Text(
                                  "Assigned to: ${email["assigned"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Test Connection",
                    icon: Icons.wifi_protected_setup,
                    size: bs.md,
                    onPressed: _testConnection,
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Save Configuration",
                    icon: Icons.save,
                    size: bs.md,
                    onPressed: _saveConfiguration,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
