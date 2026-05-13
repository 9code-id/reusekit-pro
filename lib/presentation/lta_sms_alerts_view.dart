import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaSmsAlertsView extends StatefulWidget {
  const LtaSmsAlertsView({super.key});

  @override
  State<LtaSmsAlertsView> createState() => _LtaSmsAlertsViewState();
}

class _LtaSmsAlertsViewState extends State<LtaSmsAlertsView> {
  List<Map<String, dynamic>> smsAlerts = [
    {
      "id": "SMS-001",
      "phoneNumber": "+1234567890",
      "customerName": "John Smith",
      "message": "Your package #LTA123456789 has been delivered successfully.",
      "status": "Delivered",
      "timestamp": "2024-03-20T16:30:00",
      "messageType": "delivery_confirmation",
      "cost": 0.05,
      "retryCount": 0,
      "trackingNumber": "LTA123456789",
    },
    {
      "id": "SMS-002",
      "phoneNumber": "+1234567891",
      "customerName": "Maria Garcia",
      "message": "Delivery delay: Your package #LTA123456790 will arrive tomorrow due to weather conditions.",
      "status": "Delivered",
      "timestamp": "2024-03-20T14:15:00",
      "messageType": "delivery_delay",
      "cost": 0.05,
      "retryCount": 0,
      "trackingNumber": "LTA123456790",
    },
    {
      "id": "SMS-003",
      "phoneNumber": "+1234567892",
      "customerName": "David Wilson",
      "message": "Payment received: \$125.50 for shipment #LTA123456791. Thank you!",
      "status": "Failed",
      "timestamp": "2024-03-20T11:45:00",
      "messageType": "payment_confirmation",
      "cost": 0.05,
      "retryCount": 2,
      "trackingNumber": "LTA123456791",
      "errorMessage": "Invalid phone number format",
    },
    {
      "id": "SMS-004",
      "phoneNumber": "+1234567893",
      "customerName": "Emma Thompson",
      "message": "Your package #LTA123456792 is out for delivery and will arrive today between 2-6 PM.",
      "status": "Pending",
      "timestamp": "2024-03-20T08:00:00",
      "messageType": "out_for_delivery",
      "cost": 0.05,
      "retryCount": 0,
      "trackingNumber": "LTA123456792",
    },
    {
      "id": "SMS-005",
      "phoneNumber": "+1234567894",
      "customerName": "Robert Brown",
      "message": "Package pickup scheduled for tomorrow 9:00 AM. Please have items ready.",
      "status": "Delivered",
      "timestamp": "2024-03-19T17:00:00",
      "messageType": "pickup_reminder",
      "cost": 0.05,
      "retryCount": 0,
      "trackingNumber": "LTA123456795",
    }
  ];

  List<Map<String, dynamic>> smsTemplates = [
    {
      "id": "TEMP-001",
      "name": "Package Delivered",
      "messageType": "delivery_confirmation",
      "template": "Your package #{tracking_number} has been delivered successfully to {delivery_address}. Thank you for choosing LTA Logistics!",
      "isActive": true,
      "usageCount": 150,
    },
    {
      "id": "TEMP-002", 
      "name": "Out for Delivery",
      "messageType": "out_for_delivery",
      "template": "Your package #{tracking_number} is out for delivery and will arrive today between {delivery_window}. Track: {tracking_url}",
      "isActive": true,
      "usageCount": 89,
    },
    {
      "id": "TEMP-003",
      "name": "Delivery Delay",
      "messageType": "delivery_delay",
      "template": "Delivery delay: Your package #{tracking_number} will arrive on {new_delivery_date} due to {delay_reason}. We apologize for the inconvenience.",
      "isActive": true,
      "usageCount": 45,
    },
    {
      "id": "TEMP-004",
      "name": "Payment Confirmation",
      "messageType": "payment_confirmation",
      "template": "Payment received: {amount} for shipment #{tracking_number}. Your receipt: {receipt_url}. Thank you!",
      "isActive": true,
      "usageCount": 67,
    },
    {
      "id": "TEMP-005",
      "name": "Pickup Reminder",
      "messageType": "pickup_reminder",
      "template": "Package pickup scheduled for {pickup_date} at {pickup_time}. Please have items ready. Contact: {driver_phone}",
      "isActive": true,
      "usageCount": 32,
    }
  ];

  List<Map<String, dynamic>> filteredAlerts = [];
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedMessageType = "All";
  int selectedTab = 0;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Delivered", "value": "Delivered"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Failed", "value": "Failed"},
  ];

  List<Map<String, dynamic>> messageTypeOptions = [
    {"label": "All", "value": "All"},
    {"label": "Delivery Confirmation", "value": "delivery_confirmation"},
    {"label": "Out for Delivery", "value": "out_for_delivery"},
    {"label": "Delivery Delay", "value": "delivery_delay"},
    {"label": "Payment Confirmation", "value": "payment_confirmation"},
    {"label": "Pickup Reminder", "value": "pickup_reminder"},
  ];

  @override
  void initState() {
    super.initState();
    _filterAlerts();
  }

  void _filterAlerts() {
    filteredAlerts = smsAlerts.where((alert) {
      bool matchesSearch = alert["customerName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          alert["phoneNumber"].toString().contains(searchQuery) ||
                          alert["trackingNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || alert["status"] == selectedStatus;
      bool matchesType = selectedMessageType == "All" || alert["messageType"] == selectedMessageType;
      
      return matchesSearch && matchesStatus && matchesType;
    }).toList();

    setState(() {});
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Delivered": return successColor;
      case "Pending": return warningColor;
      case "Failed": return dangerColor;
      default: return disabledColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "Delivered": return Icons.check_circle;
      case "Pending": return Icons.schedule;
      case "Failed": return Icons.error;
      default: return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "SMS Alerts",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "SMS History", icon: Icon(Icons.sms)),
        Tab(text: "Templates", icon: Icon(Icons.message)),
        Tab(text: "Send SMS", icon: Icon(Icons.send)),
      ],
      tabChildren: [
        _buildSmsHistoryTab(),
        _buildTemplatesTab(),
        _buildSendSmsTab(),
      ],
    );
  }

  Widget _buildSmsHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Filters
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                QTextField(
                  label: "Search SMS",
                  value: searchQuery,
                  hint: "Search by customer, phone, or tracking number",
                  onChanged: (value) {
                    searchQuery = value;
                    _filterAlerts();
                  },
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Status",
                        items: statusOptions,
                        value: selectedStatus,
                        onChanged: (value, label) {
                          selectedStatus = value;
                          _filterAlerts();
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Message Type",
                        items: messageTypeOptions,
                        value: selectedMessageType,
                        onChanged: (value, label) {
                          selectedMessageType = value;
                          _filterAlerts();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),

          // Statistics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total SMS", smsAlerts.length.toString(), Icons.sms, primaryColor),
              _buildStatCard("Delivered", smsAlerts.where((s) => s["status"] == "Delivered").length.toString(), Icons.check_circle, successColor),
              _buildStatCard("Failed", smsAlerts.where((s) => s["status"] == "Failed").length.toString(), Icons.error, dangerColor),
              _buildStatCard("Total Cost", "\$${smsAlerts.fold(0.0, (sum, s) => sum + (s["cost"] as double)).toStringAsFixed(2)}", Icons.attach_money, infoColor),
            ],
          ),
          SizedBox(height: spMd),

          // SMS History List
          if (filteredAlerts.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(Icons.sms_failed, size: 64, color: disabledColor),
                  SizedBox(height: spSm),
                  Text(
                    "No SMS alerts found",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Try adjusting your search criteria",
                    style: TextStyle(color: disabledColor),
                  ),
                ],
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredAlerts.length,
              itemBuilder: (context, index) {
                final alert = filteredAlerts[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: _getStatusColor(alert["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            _getStatusIcon(alert["status"]),
                            color: _getStatusColor(alert["status"]),
                          ),
                        ),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${alert["customerName"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getStatusColor(alert["status"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${alert["status"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: _getStatusColor(alert["status"]),
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: spXs),
                            Text("${alert["phoneNumber"]} • ${alert["messageType"].toString().replaceAll('_', ' ').toUpperCase()}"),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.schedule, size: 16, color: disabledColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${DateTime.parse(alert["timestamp"]).dMMMy}",
                                  style: TextStyle(color: disabledColor, fontSize: 12),
                                ),
                                SizedBox(width: spSm),
                                Icon(Icons.attach_money, size: 16, color: disabledColor),
                                SizedBox(width: spXs),
                                Text(
                                  "\$${(alert["cost"] as double).toStringAsFixed(3)}",
                                  style: TextStyle(color: disabledColor, fontSize: 12),
                                ),
                                if (alert["retryCount"] > 0) ...[
                                  SizedBox(width: spSm),
                                  Icon(Icons.refresh, size: 16, color: warningColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${alert["retryCount"]} retries",
                                    style: TextStyle(color: warningColor, fontSize: 12),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${alert["message"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            if (alert["status"] == "Failed" && alert.containsKey("errorMessage"))
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(top: spSm),
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: dangerColor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.error, color: dangerColor, size: 16),
                                    SizedBox(width: spXs),
                                    Expanded(
                                      child: Text(
                                        "Error: ${alert["errorMessage"]}",
                                        style: TextStyle(
                                          color: dangerColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(Icons.local_shipping, size: 16, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "Tracking: ${alert["trackingNumber"]}",
                                  style: TextStyle(color: disabledBoldColor, fontSize: 12),
                                ),
                                Spacer(),
                                if (alert["status"] == "Failed")
                                  QButton(
                                    label: "Retry",
                                    size: bs.sm,
                                    onPressed: () {
                                      alert["status"] = "Pending";
                                      alert["retryCount"] = (alert["retryCount"] as int) + 1;
                                      setState(() {});
                                      si("SMS retry queued for ${alert["customerName"]}");
                                    },
                                  ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.copy,
                                  size: bs.sm,
                                  onPressed: () {
                                    si("SMS message copied to clipboard");
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildTemplatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Template Management Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SMS Templates",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Manage automated SMS templates for different notification types.",
                  style: TextStyle(color: disabledBoldColor),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),

          // Template Statistics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Templates", smsTemplates.length.toString(), Icons.message, primaryColor),
              _buildStatCard("Active Templates", smsTemplates.where((t) => t["isActive"]).length.toString(), Icons.check_circle, successColor),
              _buildStatCard("Total Usage", "${smsTemplates.fold(0, (sum, t) => sum + (t["usageCount"] as int))}", Icons.trending_up, infoColor),
              _buildStatCard("Avg Message Length", "85 chars", Icons.text_fields, warningColor),
            ],
          ),
          SizedBox(height: spMd),

          // Templates List
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: smsTemplates.length,
            itemBuilder: (context, index) {
              final template = smsTemplates[index];
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: ExpansionTile(
                  leading: Icon(
                    template["isActive"] ? Icons.sms : Icons.sms_failed,
                    color: template["isActive"] ? successColor : disabledColor,
                  ),
                  title: Text(
                    "${template["name"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      Text("${template["messageType"].toString().replaceAll('_', ' ').toUpperCase()}"),
                      SizedBox(width: spSm),
                      Text("Used ${template["usageCount"]} times"),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: template["isActive"] ? successColor.withAlpha(20) : disabledColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          template["isActive"] ? "Active" : "Inactive",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: template["isActive"] ? successColor : disabledColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Message Template:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: disabledColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${template["template"]}",
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Text(
                                "Characters: ${(template["template"] as String).length}/160",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: (template["template"] as String).length > 160 ? dangerColor : successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "Cost per SMS: \$0.05",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: template["isActive"] ? "Deactivate" : "Activate",
                                  size: bs.sm,
                                  onPressed: () {
                                    template["isActive"] = !template["isActive"];
                                    setState(() {});
                                    ss("Template ${template["isActive"] ? 'activated' : 'deactivated'}");
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.edit,
                                size: bs.sm,
                                onPressed: () {
                                  si("Editing template: ${template["name"]}");
                                },
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.send,
                                size: bs.sm,
                                onPressed: () {
                                  si("Using template for new SMS");
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Create New Template",
              size: bs.md,
              onPressed: () {
                si("Creating new SMS template");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSendSmsTab() {
    String phoneNumber = "";
    String message = "";
    String selectedTemplate = "";
    String trackingNumber = "";
    bool sendImmediate = true;
    String scheduleDate = "";
    String scheduleTime = "";

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Send SMS Alert",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),

            QTextField(
              label: "Phone Number",
              value: phoneNumber,
              hint: "Enter customer phone number (+1234567890)",
              onChanged: (value) {
                phoneNumber = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),

            QTextField(
              label: "Tracking Number (Optional)",
              value: trackingNumber,
              hint: "Enter tracking number for context",
              onChanged: (value) {
                trackingNumber = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),

            QDropdownField(
              label: "Use Template (Optional)",
              items: [
                {"label": "None - Custom Message", "value": ""},
                ...smsTemplates.where((t) => t["isActive"]).map((t) => 
                  {"label": "${t["name"]}", "value": t["id"]}).toList(),
              ],
              value: selectedTemplate,
              onChanged: (value, label) {
                selectedTemplate = value;
                if (value.isNotEmpty) {
                  final template = smsTemplates.firstWhere((t) => t["id"] == value);
                  message = template["template"];
                  setState(() {});
                }
              },
            ),
            SizedBox(height: spSm),

            QMemoField(
              label: "Message",
              value: message,
              hint: "Enter your SMS message (max 160 characters for standard rate)",
              onChanged: (value) {
                message = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),

            // Character count and cost estimate
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: message.length > 160 ? warningColor.withAlpha(10) : infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    message.length > 160 ? Icons.warning : Icons.info,
                    color: message.length > 160 ? warningColor : infoColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Characters: ${message.length}/160 • Estimated cost: \$${(message.length > 160 ? ((message.length / 160).ceil() * 0.05) : 0.05).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: message.length > 160 ? warningColor : infoColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Scheduling Options
            QSwitch(
              label: "Send Options",
              items: [
                {
                  "label": "Send Immediately",
                  "value": true,
                  "checked": sendImmediate,
                }
              ],
              value: [if (sendImmediate) {"label": "Send Immediately", "value": true, "checked": true}],
              onChanged: (values, ids) {
                sendImmediate = values.isNotEmpty;
                setState(() {});
              },
            ),

            if (!sendImmediate) ...[
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QDatePicker(
                      label: "Schedule Date",
                      value: scheduleDate.isNotEmpty ? DateTime.parse(scheduleDate) : DateTime.now(),
                      onChanged: (value) {
                        scheduleDate = value.toIso8601String().split('T')[0];
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTimePicker(
                      label: "Schedule Time",
                      value: scheduleTime.isNotEmpty 
                          ? TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 $scheduleTime:00"))
                          : TimeOfDay.now(),
                      onChanged: (value) {
                        scheduleTime = value!.kkmm;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],

            SizedBox(height: spMd),

            // Available Variables Info
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Available Variables:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "{tracking_number}, {customer_name}, {delivery_address}, {delivery_date}, {delivery_time}",
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Send Button
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: sendImmediate ? "Send SMS Now" : "Schedule SMS",
                    size: bs.md,
                    onPressed: () {
                      if (phoneNumber.isNotEmpty && message.isNotEmpty) {
                        if (sendImmediate) {
                          ss("SMS sent successfully to $phoneNumber");
                        } else {
                          ss("SMS scheduled for $scheduleDate at $scheduleTime");
                        }
                        // Clear form
                        phoneNumber = "";
                        message = "";
                        trackingNumber = "";
                        selectedTemplate = "";
                        setState(() {});
                      } else {
                        se("Please fill in phone number and message");
                      }
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Preview",
                  size: bs.md,
                  onPressed: () {
                    if (message.isNotEmpty) {
                      si("SMS Preview: $message");
                    } else {
                      se("Please enter a message to preview");
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
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
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
