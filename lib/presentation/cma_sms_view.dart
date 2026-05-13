import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaSmsView extends StatefulWidget {
  const CmaSmsView({super.key});

  @override
  State<CmaSmsView> createState() => _CmaSmsViewState();
}

class _CmaSmsViewState extends State<CmaSmsView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedTemplate = "welcome";
  
  List<Map<String, dynamic>> smsMessages = [
    {
      "id": 1,
      "recipient": "+1 (555) 123-4567",
      "contact_name": "John Smith",
      "message": "Welcome to our service! Your account has been activated successfully.",
      "status": "delivered",
      "sent_at": DateTime.now().subtract(Duration(minutes: 30)),
      "template": "welcome",
      "character_count": 72,
      "cost": 0.045,
      "delivery_report": "Delivered at 14:30",
    },
    {
      "id": 2,
      "recipient": "+1 (555) 987-6543",
      "contact_name": "Sarah Johnson",
      "message": "Your appointment is confirmed for tomorrow at 2:00 PM. See you then!",
      "status": "sent",
      "sent_at": DateTime.now().subtract(Duration(minutes: 15)),
      "template": "appointment",
      "character_count": 78,
      "cost": 0.048,
      "delivery_report": "Pending delivery",
    },
    {
      "id": 3,
      "recipient": "+1 (555) 456-7890",
      "contact_name": "Mike Davis",
      "message": "Payment received! Thank you for your purchase. Order #12345 is processing.",
      "status": "failed",
      "sent_at": DateTime.now().subtract(Duration(hours: 2)),
      "template": "payment",
      "character_count": 82,
      "cost": 0.049,
      "delivery_report": "Failed - Invalid number",
    },
    {
      "id": 4,
      "recipient": "+1 (555) 789-0123",
      "contact_name": "Emma Wilson",
      "message": "Flash Sale! 50% off all items. Use code FLASH50. Valid until midnight.",
      "status": "delivered",
      "sent_at": DateTime.now().subtract(Duration(hours: 4)),
      "template": "promotion",
      "character_count": 76,
      "cost": 0.047,
      "delivery_report": "Delivered at 10:45",
    },
    {
      "id": 5,
      "recipient": "+1 (555) 321-6547",
      "contact_name": "Robert Brown",
      "message": "Reminder: Your subscription expires in 3 days. Renew now to continue service.",
      "status": "pending",
      "sent_at": DateTime.now(),
      "template": "reminder",
      "character_count": 84,
      "cost": 0.050,
      "delivery_report": "Queued for delivery",
    },
  ];

  List<Map<String, dynamic>> smsTemplates = [
    {"label": "Welcome Message", "value": "welcome"},
    {"label": "Appointment Reminder", "value": "appointment"},
    {"label": "Payment Confirmation", "value": "payment"},
    {"label": "Promotional Offer", "value": "promotion"},
    {"label": "Service Reminder", "value": "reminder"},
    {"label": "Custom Message", "value": "custom"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Messages", "value": "all"},
    {"label": "Delivered", "value": "delivered"},
    {"label": "Sent", "value": "sent"},
    {"label": "Pending", "value": "pending"},
    {"label": "Failed", "value": "failed"},
  ];

  String recipientNumber = "";
  String messageContent = "";
  String scheduledTime = "";
  bool scheduleMessage = false;

  List<Map<String, dynamic>> get filteredMessages {
    return smsMessages.where((message) {
      bool matchesSearch = searchQuery.isEmpty || 
          (message["contact_name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (message["recipient"] as String).contains(searchQuery) ||
          (message["message"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "all" || message["status"] == selectedStatus;
      
      return matchesSearch && matchesStatus;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "delivered":
        return successColor;
      case "sent":
        return infoColor;
      case "pending":
        return warningColor;
      case "failed":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case "delivered":
        return Icons.check_circle;
      case "sent":
        return Icons.send;
      case "pending":
        return Icons.schedule;
      case "failed":
        return Icons.error;
      default:
        return Icons.help;
    }
  }

  Widget _buildMessagesTab() {
    return Column(
      spacing: spMd,
      children: [
        // Quick Stats
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: [
            _buildStatCard("Total Messages", "${smsMessages.length}", Icons.sms, primaryColor),
            _buildStatCard("Delivered", "${smsMessages.where((m) => m["status"] == "delivered").length}", Icons.check_circle, successColor),
            _buildStatCard("Failed", "${smsMessages.where((m) => m["status"] == "failed").length}", Icons.error, dangerColor),
            _buildStatCard("Total Cost", "\$${smsMessages.fold(0.0, (sum, m) => sum + (m["cost"] as double)).toStringAsFixed(2)}", Icons.attach_money, warningColor),
          ],
        ),

        // Search and Filter
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search messages...",
                value: searchQuery,
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Filter by Status",
                items: statusOptions,
                value: selectedStatus,
                onChanged: (value, label) {
                  selectedStatus = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),

        // Messages List
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Icon(Icons.sms, color: primaryColor, size: 20),
                    SizedBox(width: spSm),
                    Text(
                      "SMS Messages",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Send SMS",
                      icon: Icons.add,
                      size: bs.sm,
                      onPressed: () {
                        currentTab = 1;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              Divider(height: 1),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filteredMessages.length,
                separatorBuilder: (context, index) => Divider(height: 1),
                itemBuilder: (context, index) {
                  final message = filteredMessages[index];
                  return _buildMessageCard(message);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSendTab() {
    return Column(
      spacing: spMd,
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Row(
                children: [
                  Icon(Icons.send, color: primaryColor, size: 24),
                  SizedBox(width: spSm),
                  Text(
                    "Send SMS Message",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              
              QTextField(
                label: "Recipient Phone Number",
                value: recipientNumber,
                hint: "+1 (555) 123-4567",
                onChanged: (value) {
                  recipientNumber = value;
                  setState(() {});
                },
              ),
              
              QDropdownField(
                label: "Message Template",
                items: smsTemplates,
                value: selectedTemplate,
                onChanged: (value, label) {
                  selectedTemplate = value;
                  setState(() {});
                },
              ),
              
              QMemoField(
                label: "Message Content",
                value: messageContent,
                hint: "Type your message here...",
                onChanged: (value) {
                  messageContent = value;
                  setState(() {});
                },
              ),
              
              // Character counter
              if (messageContent.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: messageContent.length > 160 ? dangerColor.withAlpha(30) : infoColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        messageContent.length > 160 ? Icons.warning : Icons.info,
                        color: messageContent.length > 160 ? dangerColor : infoColor,
                        size: 16,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${messageContent.length}/160 characters",
                        style: TextStyle(
                          fontSize: 12,
                          color: messageContent.length > 160 ? dangerColor : infoColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Est. cost: \$${(messageContent.length / 160 * 0.045).toStringAsFixed(3)}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: messageContent.length > 160 ? dangerColor : infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              
              // Schedule option
              Row(
                children: [
                  QSwitch(
                    items: [
                      {
                        "label": "Schedule message",
                        "value": true,
                        "checked": scheduleMessage,
                      }
                    ],
                    value: [
                      if (scheduleMessage)
                        {
                          "label": "Schedule message",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      scheduleMessage = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
              
              if (scheduleMessage)
                QTimePicker(
                  label: "Schedule Time",
                  value: scheduledTime.isNotEmpty ? TimeOfDay.fromDateTime(DateTime.parse(scheduledTime)) : null,
                  onChanged: (value) {
                    scheduledTime = value!.kkmm;
                    setState(() {});
                  },
                ),
              
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Save Draft",
                      color: disabledBoldColor,
                      size: bs.md,
                      onPressed: () {
                        ss("Message saved as draft");
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: scheduleMessage ? "Schedule Send" : "Send Now",
                      size: bs.md,
                      onPressed: () {
                        if (scheduleMessage) {
                          ss("SMS scheduled successfully");
                        } else {
                          ss("SMS sent successfully");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAnalyticsTab() {
    return Column(
      spacing: spMd,
      children: [
        // SMS Analytics
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: [
            _buildMetricCard("Delivery Rate", "${(smsMessages.where((m) => m["status"] == "delivered").length / smsMessages.length * 100).toStringAsFixed(1)}%", Icons.check_circle, successColor),
            _buildMetricCard("Failure Rate", "${(smsMessages.where((m) => m["status"] == "failed").length / smsMessages.length * 100).toStringAsFixed(1)}%", Icons.error, dangerColor),
            _buildMetricCard("Avg. Characters", "${(smsMessages.fold(0, (sum, m) => sum + (m["character_count"] as int)) / smsMessages.length).toStringAsFixed(0)}", Icons.text_fields, infoColor),
            _buildMetricCard("Cost per SMS", "\$${(smsMessages.fold(0.0, (sum, m) => sum + (m["cost"] as double)) / smsMessages.length).toStringAsFixed(3)}", Icons.attach_money, warningColor),
          ],
        ),

        // Recent Activity
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Recent SMS Activity",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ...smsMessages.take(5).map((message) => _buildActivityRow(message)),
            ],
          ),
        ),

        // Template Usage
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Template Usage Statistics",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ...smsTemplates.map((template) => _buildTemplateUsageRow(template)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
              Icon(Icons.trending_up, color: successColor, size: 16),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  title,
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
    );
  }

  Widget _buildMessageCard(Map<String, dynamic> message) {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: getStatusColor("${message["status"]}").withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  getStatusIcon("${message["status"]}"),
                  color: getStatusColor("${message["status"]}"),
                  size: 16,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${message["contact_name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${message["recipient"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${message["status"]}".toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: getStatusColor("${message["status"]}"),
                    ),
                  ),
                  Text(
                    "\$${(message["cost"] as double).toStringAsFixed(3)}",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${message["message"]}",
              style: TextStyle(
                fontSize: 13,
                color: primaryColor,
              ),
            ),
          ),
          
          Row(
            children: [
              Text(
                "${message["character_count"]} chars",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "${(message["sent_at"] as DateTime).dMMMykkss}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityRow(Map<String, dynamic> message) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(spXs),
          decoration: BoxDecoration(
            color: getStatusColor("${message["status"]}").withAlpha(30),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Icon(
            getStatusIcon("${message["status"]}"),
            color: getStatusColor("${message["status"]}"),
            size: 16,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${message["contact_name"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                "${message["delivery_report"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        Text(
          "${(message["sent_at"] as DateTime).dMMMy}",
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTemplateUsageRow(Map<String, dynamic> template) {
    int usage = smsMessages.where((m) => m["template"] == template["value"]).length;
    double percentage = usage / smsMessages.length * 100;
    
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${template["label"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                "$usage messages sent",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "${percentage.toStringAsFixed(1)}%",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              width: 60,
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: FractionallySizedBox(
                widthFactor: percentage / 100,
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "SMS Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Messages", icon: Icon(Icons.sms)),
        Tab(text: "Send SMS", icon: Icon(Icons.send)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildMessagesTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildSendTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildAnalyticsTab(),
        ),
      ],
      onInit: (tabController) {},
    );
  }
}
