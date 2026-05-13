import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaEmailUpdatesView extends StatefulWidget {
  const LtaEmailUpdatesView({super.key});

  @override
  State<LtaEmailUpdatesView> createState() => _LtaEmailUpdatesViewState();
}

class _LtaEmailUpdatesViewState extends State<LtaEmailUpdatesView> {
  List<Map<String, dynamic>> emailUpdates = [
    {
      "id": "EMAIL-001",
      "recipient": "john.smith@email.com",
      "customerName": "John Smith",
      "subject": "Package Delivered Successfully - LTA123456789",
      "content": "Dear John Smith,\n\nWe're pleased to inform you that your package with tracking number LTA123456789 has been successfully delivered.\n\nDelivery Details:\n- Date: March 20, 2024\n- Time: 4:30 PM\n- Location: 123 Main Street\n\nThank you for choosing LTA Logistics!",
      "status": "Delivered",
      "timestamp": "2024-03-20T16:30:00",
      "emailType": "delivery_confirmation",
      "trackingNumber": "LTA123456789",
      "openRate": true,
      "clickRate": false,
      "bounced": false,
    },
    {
      "id": "EMAIL-002",
      "recipient": "maria.garcia@email.com",
      "customerName": "Maria Garcia",
      "subject": "Delivery Delay Notification - LTA123456790",
      "content": "Dear Maria Garcia,\n\nWe apologize for the inconvenience, but your package with tracking number LTA123456790 has been delayed due to severe weather conditions.\n\nNew estimated delivery: March 22, 2024\nReason: Weather delay\n\nWe're working hard to ensure your package reaches you as soon as possible. You can track your package at: https://track.lta.com/LTA123456790\n\nFor any questions, please contact our support team.\n\nBest regards,\nLTA Logistics Team",
      "status": "Delivered",
      "timestamp": "2024-03-20T14:15:00",
      "emailType": "delivery_delay",
      "trackingNumber": "LTA123456790",
      "openRate": true,
      "clickRate": true,
      "bounced": false,
    },
    {
      "id": "EMAIL-003",
      "recipient": "invalid.email@domain.com",
      "customerName": "David Wilson",
      "subject": "Payment Confirmation - LTA123456791",
      "content": "Dear David Wilson,\n\nThank you for your payment of \$125.50 for shipment LTA123456791.\n\nPayment Details:\n- Amount: \$125.50\n- Date: March 20, 2024\n- Reference: PAY-789456\n\nYour receipt is attached to this email.\n\nBest regards,\nLTA Billing Team",
      "status": "Bounced",
      "timestamp": "2024-03-20T11:45:00",
      "emailType": "payment_confirmation",
      "trackingNumber": "LTA123456791",
      "openRate": false,
      "clickRate": false,
      "bounced": true,
      "bounceReason": "Invalid email address",
    },
    {
      "id": "EMAIL-004",
      "recipient": "emma.thompson@email.com",
      "customerName": "Emma Thompson",
      "subject": "Package Out for Delivery - LTA123456792",
      "content": "Dear Emma Thompson,\n\nGood news! Your package with tracking number LTA123456792 is out for delivery and will arrive today.\n\nEstimated delivery time: 2:00 PM - 6:00 PM\nDriver: Mike Johnson\nDriver contact: +1234567890\n\nPlease ensure someone is available to receive the package.\n\nBest regards,\nLTA Logistics Team",
      "status": "Pending",
      "timestamp": "2024-03-20T08:00:00",
      "emailType": "out_for_delivery",
      "trackingNumber": "LTA123456792",
      "openRate": false,
      "clickRate": false,
      "bounced": false,
    },
    {
      "id": "EMAIL-005",
      "recipient": "robert.brown@email.com",
      "customerName": "Robert Brown",
      "subject": "Weekly Delivery Summary",
      "content": "Dear Robert Brown,\n\nHere's your weekly delivery summary:\n\n- Total packages shipped: 5\n- Packages delivered: 4\n- Packages in transit: 1\n- Total shipping cost: \$45.75\n\nUpcoming deliveries:\n- LTA123456795: Expected March 21, 2024\n\nThank you for your continued business!\n\nBest regards,\nLTA Customer Service",
      "status": "Delivered",
      "timestamp": "2024-03-19T17:00:00",
      "emailType": "weekly_summary",
      "trackingNumber": "",
      "openRate": true,
      "clickRate": false,
      "bounced": false,
    }
  ];

  List<Map<String, dynamic>> emailTemplates = [
    {
      "id": "TEMP-001",
      "name": "Package Delivered",
      "emailType": "delivery_confirmation",
      "subject": "Package Delivered Successfully - {tracking_number}",
      "content": "Dear {customer_name},\n\nWe're pleased to inform you that your package with tracking number {tracking_number} has been successfully delivered.\n\nDelivery Details:\n- Date: {delivery_date}\n- Time: {delivery_time}\n- Location: {delivery_address}\n\nThank you for choosing LTA Logistics!\n\nBest regards,\nLTA Logistics Team",
      "isActive": true,
      "usageCount": 245,
    },
    {
      "id": "TEMP-002",
      "name": "Out for Delivery",
      "emailType": "out_for_delivery",
      "subject": "Package Out for Delivery - {tracking_number}",
      "content": "Dear {customer_name},\n\nGood news! Your package with tracking number {tracking_number} is out for delivery and will arrive today.\n\nEstimated delivery time: {delivery_window}\nDriver: {driver_name}\nDriver contact: {driver_phone}\n\nPlease ensure someone is available to receive the package.\n\nTrack your package: {tracking_url}\n\nBest regards,\nLTA Logistics Team",
      "isActive": true,
      "usageCount": 198,
    },
    {
      "id": "TEMP-003",
      "name": "Delivery Delay",
      "emailType": "delivery_delay",
      "subject": "Delivery Delay Notification - {tracking_number}",
      "content": "Dear {customer_name},\n\nWe apologize for the inconvenience, but your package with tracking number {tracking_number} has been delayed.\n\nNew estimated delivery: {new_delivery_date}\nReason: {delay_reason}\n\nWe're working hard to ensure your package reaches you as soon as possible. You can track your package at: {tracking_url}\n\nFor any questions, please contact our support team.\n\nBest regards,\nLTA Logistics Team",
      "isActive": true,
      "usageCount": 87,
    },
    {
      "id": "TEMP-004",
      "name": "Payment Confirmation",
      "emailType": "payment_confirmation",
      "subject": "Payment Confirmation - {tracking_number}",
      "content": "Dear {customer_name},\n\nThank you for your payment of {payment_amount} for shipment {tracking_number}.\n\nPayment Details:\n- Amount: {payment_amount}\n- Date: {payment_date}\n- Reference: {payment_reference}\n\nYour receipt is attached to this email.\n\nBest regards,\nLTA Billing Team",
      "isActive": true,
      "usageCount": 134,
    }
  ];

  List<Map<String, dynamic>> filteredEmails = [];
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedEmailType = "All";
  int selectedTab = 0;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Delivered", "value": "Delivered"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Bounced", "value": "Bounced"},
  ];

  List<Map<String, dynamic>> emailTypeOptions = [
    {"label": "All", "value": "All"},
    {"label": "Delivery Confirmation", "value": "delivery_confirmation"},
    {"label": "Out for Delivery", "value": "out_for_delivery"},
    {"label": "Delivery Delay", "value": "delivery_delay"},
    {"label": "Payment Confirmation", "value": "payment_confirmation"},
    {"label": "Weekly Summary", "value": "weekly_summary"},
  ];

  @override
  void initState() {
    super.initState();
    _filterEmails();
  }

  void _filterEmails() {
    filteredEmails = emailUpdates.where((email) {
      bool matchesSearch = email["customerName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          email["recipient"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          email["subject"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          email["trackingNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || email["status"] == selectedStatus;
      bool matchesType = selectedEmailType == "All" || email["emailType"] == selectedEmailType;
      
      return matchesSearch && matchesStatus && matchesType;
    }).toList();

    setState(() {});
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Delivered": return successColor;
      case "Pending": return warningColor;
      case "Bounced": return dangerColor;
      default: return disabledColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "Delivered": return Icons.mark_email_read;
      case "Pending": return Icons.schedule_send;
      case "Bounced": return Icons.email;
      default: return Icons.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Email Updates",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Email History", icon: Icon(Icons.email)),
        Tab(text: "Templates", icon: Icon(Icons.message)),
        Tab(text: "Send Email", icon: Icon(Icons.send)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildEmailHistoryTab(),
        _buildTemplatesTab(),
        _buildSendEmailTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildEmailHistoryTab() {
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
                  label: "Search Emails",
                  value: searchQuery,
                  hint: "Search by customer, email, subject, or tracking number",
                  onChanged: (value) {
                    searchQuery = value;
                    _filterEmails();
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
                          _filterEmails();
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Email Type",
                        items: emailTypeOptions,
                        value: selectedEmailType,
                        onChanged: (value, label) {
                          selectedEmailType = value;
                          _filterEmails();
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
              _buildStatCard("Total Emails", emailUpdates.length.toString(), Icons.email, primaryColor),
              _buildStatCard("Delivered", emailUpdates.where((e) => e["status"] == "Delivered").length.toString(), Icons.mark_email_read, successColor),
              _buildStatCard("Open Rate", "${((emailUpdates.where((e) => e["openRate"]).length / emailUpdates.length) * 100).toInt()}%", Icons.visibility, infoColor),
              _buildStatCard("Bounced", emailUpdates.where((e) => e["bounced"]).length.toString(), Icons.email, dangerColor),
            ],
          ),
          SizedBox(height: spMd),

          // Email History List
          if (filteredEmails.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(Icons.email_outlined, size: 64, color: disabledColor),
                  SizedBox(height: spSm),
                  Text(
                    "No email updates found",
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
              itemCount: filteredEmails.length,
              itemBuilder: (context, index) {
                final email = filteredEmails[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: ExpansionTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: _getStatusColor(email["status"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        _getStatusIcon(email["status"]),
                        color: _getStatusColor(email["status"]),
                      ),
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${email["customerName"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getStatusColor(email["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${email["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _getStatusColor(email["status"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: spXs),
                        Text("${email["recipient"]} • ${email["emailType"].toString().replaceAll('_', ' ').toUpperCase()}"),
                        SizedBox(height: spXs),
                        Text(
                          "${email["subject"]}",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(Icons.schedule, size: 16, color: disabledColor),
                            SizedBox(width: spXs),
                            Text(
                              "${DateTime.parse(email["timestamp"]).dMMMy}",
                              style: TextStyle(color: disabledColor, fontSize: 12),
                            ),
                            if (email["trackingNumber"].isNotEmpty) ...[
                              SizedBox(width: spSm),
                              Icon(Icons.local_shipping, size: 16, color: disabledColor),
                              SizedBox(width: spXs),
                              Text(
                                "${email["trackingNumber"]}",
                                style: TextStyle(color: disabledColor, fontSize: 12),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Email engagement metrics
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  _buildEngagementMetric("Opened", email["openRate"], Icons.visibility),
                                  SizedBox(width: spMd),
                                  _buildEngagementMetric("Clicked", email["clickRate"], Icons.link),
                                  SizedBox(width: spMd),
                                  _buildEngagementMetric("Bounced", email["bounced"], Icons.email),
                                ],
                              ),
                            ),
                            SizedBox(height: spSm),

                            // Email content
                            Text(
                              "Email Content:",
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
                                color: disabledColor.withAlpha(5),
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(color: disabledColor.withAlpha(30)),
                              ),
                              child: Text(
                                "${email["content"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: disabledBoldColor,
                                  height: 1.4,
                                ),
                              ),
                            ),

                            if (email["bounced"] && email.containsKey("bounceReason"))
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
                                        "Bounce reason: ${email["bounceReason"]}",
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
                                Expanded(
                                  child: QButton(
                                    label: "View Full Email",
                                    size: bs.sm,
                                    onPressed: () {
                                      si("Viewing full email: ${email["id"]}");
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                if (email["status"] == "Bounced")
                                  QButton(
                                    label: "Resend",
                                    size: bs.sm,
                                    onPressed: () {
                                      si("Resending email: ${email["id"]}");
                                    },
                                  ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.copy,
                                  size: bs.sm,
                                  onPressed: () {
                                    si("Email content copied");
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
                  "Email Templates",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Manage automated email templates for different notification types.",
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
              _buildStatCard("Total Templates", emailTemplates.length.toString(), Icons.message, primaryColor),
              _buildStatCard("Active Templates", emailTemplates.where((t) => t["isActive"]).length.toString(), Icons.check_circle, successColor),
              _buildStatCard("Total Usage", "${emailTemplates.fold(0, (sum, t) => sum + (t["usageCount"] as int))}", Icons.trending_up, infoColor),
              _buildStatCard("Avg Open Rate", "78%", Icons.visibility, warningColor),
            ],
          ),
          SizedBox(height: spMd),

          // Templates List
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: emailTemplates.length,
            itemBuilder: (context, index) {
              final template = emailTemplates[index];
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: ExpansionTile(
                  leading: Icon(
                    template["isActive"] ? Icons.email : Icons.drafts,
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
                      Text("${template["emailType"].toString().replaceAll('_', ' ').toUpperCase()}"),
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
                            "Subject: ${template["subject"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Email Content:",
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
                              "${template["content"]}",
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
                                  si("Using template for new email");
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
                si("Creating new email template");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSendEmailTab() {
    String recipient = "";
    String subject = "";
    String content = "";
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
              "Send Email Update",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),

            QTextField(
              label: "Recipient Email",
              value: recipient,
              hint: "Enter customer email address",
              onChanged: (value) {
                recipient = value;
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
                {"label": "None - Custom Email", "value": ""},
                ...emailTemplates.where((t) => t["isActive"]).map((t) => 
                  {"label": "${t["name"]}", "value": t["id"]}).toList(),
              ],
              value: selectedTemplate,
              onChanged: (value, label) {
                selectedTemplate = value;
                if (value.isNotEmpty) {
                  final template = emailTemplates.firstWhere((t) => t["id"] == value);
                  subject = template["subject"];
                  content = template["content"];
                  setState(() {});
                }
              },
            ),
            SizedBox(height: spSm),

            QTextField(
              label: "Subject",
              value: subject,
              hint: "Enter email subject",
              onChanged: (value) {
                subject = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),

            QMemoField(
              label: "Email Content",
              value: content,
              hint: "Enter your email content...",
              onChanged: (value) {
                content = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),

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
                    "{customer_name}, {tracking_number}, {delivery_address}, {delivery_date}, {delivery_time}, {tracking_url}",
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
                    label: sendImmediate ? "Send Email Now" : "Schedule Email",
                    size: bs.md,
                    onPressed: () {
                      if (recipient.isNotEmpty && subject.isNotEmpty && content.isNotEmpty) {
                        if (sendImmediate) {
                          ss("Email sent successfully to $recipient");
                        } else {
                          ss("Email scheduled for $scheduleDate at $scheduleTime");
                        }
                        // Clear form
                        recipient = "";
                        subject = "";
                        content = "";
                        trackingNumber = "";
                        selectedTemplate = "";
                        setState(() {});
                      } else {
                        se("Please fill in all required fields");
                      }
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Preview",
                  size: bs.md,
                  onPressed: () {
                    if (subject.isNotEmpty && content.isNotEmpty) {
                      si("Email Preview Ready");
                    } else {
                      se("Please enter subject and content to preview");
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

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Analytics Overview
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Sent", emailUpdates.length.toString(), Icons.send, primaryColor),
              _buildStatCard("Delivery Rate", "80%", Icons.mark_email_read, successColor),
              _buildStatCard("Open Rate", "75%", Icons.visibility, infoColor),
              _buildStatCard("Click Rate", "12%", Icons.link, warningColor),
            ],
          ),
          SizedBox(height: spMd),

          // Email Type Performance
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
                  "Performance by Email Type",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                ..._buildEmailTypeStats(),
              ],
            ),
          ),
          SizedBox(height: spMd),

          // Bounce Analysis
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
                  "Bounce Analysis",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                _buildMetricItem("Hard Bounces", "2", Icons.error, dangerColor),
                _buildMetricItem("Soft Bounces", "1", Icons.warning, warningColor),
                _buildMetricItem("Invalid Addresses", "1", Icons.alternate_email, dangerColor),
                _buildMetricItem("Mailbox Full", "0", Icons.inventory, infoColor),
              ],
            ),
          ),
        ],
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

  Widget _buildEngagementMetric(String label, bool isTrue, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: isTrue ? successColor : disabledColor,
          size: 16,
        ),
        SizedBox(width: spXs),
        Text(
          label,
          style: TextStyle(
            color: isTrue ? successColor : disabledColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildEmailTypeStats() {
    Map<String, int> typeCounts = {};
    for (var email in emailUpdates) {
      String type = email["emailType"];
      typeCounts[type] = (typeCounts[type] ?? 0) + 1;
    }

    return typeCounts.entries.map((entry) {
      double percentage = (entry.value / emailUpdates.length) * 100;
      return Container(
        margin: EdgeInsets.only(bottom: spSm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(entry.key.replaceAll('_', ' ').toUpperCase()),
                Text("${entry.value} (${percentage.toStringAsFixed(1)}%)"),
              ],
            ),
            SizedBox(height: spXs),
            LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: disabledColor.withAlpha(30),
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildMetricItem(String title, String value, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
