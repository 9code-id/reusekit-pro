import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaNotificationsView extends StatefulWidget {
  const LtaNotificationsView({super.key});

  @override
  State<LtaNotificationsView> createState() => _LtaNotificationsViewState();
}

class _LtaNotificationsViewState extends State<LtaNotificationsView> {
  List<Map<String, dynamic>> notifications = [
    {
      "id": "NOTIF-001",
      "title": "Package Delivered Successfully",
      "message": "Your package #LTA123456789 has been delivered to John Smith at 123 Main Street.",
      "type": "delivery",
      "timestamp": "2024-03-20T16:30:00",
      "isRead": false,
      "priority": "Medium",
      "recipient": "john.smith@email.com",
      "trackingNumber": "LTA123456789",
      "icon": Icons.local_shipping,
      "color": "success",
    },
    {
      "id": "NOTIF-002",
      "title": "Delivery Delayed",
      "message": "Package #LTA123456790 delivery has been delayed due to weather conditions. New ETA: March 22, 2024",
      "type": "delay",
      "timestamp": "2024-03-20T14:15:00",
      "isRead": false,
      "priority": "High",
      "recipient": "maria.garcia@email.com",
      "trackingNumber": "LTA123456790",
      "icon": Icons.warning,
      "color": "warning",
    },
    {
      "id": "NOTIF-003",
      "title": "Payment Received",
      "message": "Payment of \$125.50 has been received for shipment #LTA123456791",
      "type": "payment",
      "timestamp": "2024-03-20T11:45:00",
      "isRead": true,
      "priority": "Low",
      "recipient": "david.wilson@email.com",
      "trackingNumber": "LTA123456791",
      "icon": Icons.payment,
      "color": "info",
    },
    {
      "id": "NOTIF-004",
      "title": "Address Verification Required",
      "message": "Customer Emma Thompson has requested address change for package #LTA123456792. Verification required.",
      "type": "verification",
      "timestamp": "2024-03-20T18:20:00",
      "isRead": false,
      "priority": "High",
      "recipient": "emma.thompson@email.com",
      "trackingNumber": "LTA123456792",
      "icon": Icons.location_on,
      "color": "danger",
    },
    {
      "id": "NOTIF-005",
      "title": "New Support Ticket",
      "message": "New support ticket #TKT-001 created by Robert Brown regarding lost package inquiry.",
      "type": "support",
      "timestamp": "2024-03-20T09:30:00",
      "isRead": true,
      "priority": "Medium",
      "recipient": "robert.brown@email.com",
      "trackingNumber": "LTA123456793",
      "icon": Icons.support_agent,
      "color": "primary",
    },
    {
      "id": "NOTIF-006",
      "title": "Route Optimization Complete",
      "message": "Daily route optimization completed. 12 routes optimized, saving 45 minutes total drive time.",
      "type": "system",
      "timestamp": "2024-03-20T06:00:00",
      "isRead": true,
      "priority": "Low",
      "recipient": "system@lta.com",
      "trackingNumber": "",
      "icon": Icons.route,
      "color": "info",
    }
  ];

  List<Map<String, dynamic>> notificationTemplates = [
    {
      "id": "TEMP-001",
      "name": "Package Delivered",
      "type": "delivery",
      "subject": "Your package has been delivered",
      "content": "Dear {customer_name},\n\nYour package with tracking number {tracking_number} has been successfully delivered.\n\nDelivery Details:\n- Date: {delivery_date}\n- Time: {delivery_time}\n- Location: {delivery_address}\n\nThank you for choosing LTA Logistics!",
      "isActive": true,
    },
    {
      "id": "TEMP-002",
      "name": "Delivery Delayed",
      "type": "delay",
      "subject": "Delivery delay notification - {tracking_number}",
      "content": "Dear {customer_name},\n\nWe apologize for the inconvenience. Your package {tracking_number} has been delayed.\n\nReason: {delay_reason}\nNew estimated delivery: {new_delivery_date}\n\nWe're working hard to deliver your package as soon as possible.",
      "isActive": true,
    },
    {
      "id": "TEMP-003",
      "name": "Package Out for Delivery",
      "type": "delivery",
      "subject": "Your package is out for delivery",
      "content": "Dear {customer_name},\n\nGood news! Your package {tracking_number} is out for delivery and will arrive today.\n\nEstimated delivery time: {estimated_time}\nDriver: {driver_name}\n\nPlease ensure someone is available to receive the package.",
      "isActive": true,
    }
  ];

  List<Map<String, dynamic>> filteredNotifications = [];
  String searchQuery = "";
  String selectedType = "All";
  String selectedPriority = "All";
  bool showUnreadOnly = false;
  int selectedTab = 0;

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All", "value": "All"},
    {"label": "Delivery", "value": "delivery"},
    {"label": "Delay", "value": "delay"},
    {"label": "Payment", "value": "payment"},
    {"label": "Verification", "value": "verification"},
    {"label": "Support", "value": "support"},
    {"label": "System", "value": "system"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All", "value": "All"},
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Critical", "value": "Critical"},
  ];

  @override
  void initState() {
    super.initState();
    _filterNotifications();
  }

  void _filterNotifications() {
    filteredNotifications = notifications.where((notif) {
      bool matchesSearch = notif["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          notif["message"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          notif["trackingNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesType = selectedType == "All" || notif["type"] == selectedType;
      bool matchesPriority = selectedPriority == "All" || notif["priority"] == selectedPriority;
      bool matchesReadStatus = !showUnreadOnly || !notif["isRead"];
      
      return matchesSearch && matchesType && matchesPriority && matchesReadStatus;
    }).toList();

    setState(() {});
  }

  Color _getNotificationColor(String colorName) {
    switch (colorName) {
      case "success": return successColor;
      case "warning": return warningColor;
      case "danger": return dangerColor;
      case "info": return infoColor;
      case "primary": return primaryColor;
      default: return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical": return dangerColor;
      case "High": return warningColor;
      case "Medium": return infoColor;
      case "Low": return successColor;
      default: return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Notifications",
      selectedIndex: selectedTab,      tabs: [
        Tab(text: "All Notifications", icon: Icon(Icons.notifications)),
        Tab(text: "Templates", icon: Icon(Icons.message)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildNotificationsTab(),
        _buildTemplatesTab(),
        _buildSettingsTab(),
      ],
    );
  }

  Widget _buildNotificationsTab() {
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
                  label: "Search Notifications",
                  value: searchQuery,
                  hint: "Search by title, message, or tracking number",
                  onChanged: (value) {
                    searchQuery = value;
                    _filterNotifications();
                  },
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Type",
                        items: typeOptions,
                        value: selectedType,
                        onChanged: (value, label) {
                          selectedType = value;
                          _filterNotifications();
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Priority",
                        items: priorityOptions,
                        value: selectedPriority,
                        onChanged: (value, label) {
                          selectedPriority = value;
                          _filterNotifications();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                QSwitch(
                  label: "Show Unread Only",
                  items: [
                    {
                      "label": "Show Unread Only",
                      "value": true,
                      "checked": showUnreadOnly,
                    }
                  ],
                  value: [if (showUnreadOnly) {"label": "Show Unread Only", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    showUnreadOnly = values.isNotEmpty;
                    _filterNotifications();
                  },
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
              _buildStatCard("Total Notifications", notifications.length.toString(), Icons.notifications, primaryColor),
              _buildStatCard("Unread", notifications.where((n) => !n["isRead"]).length.toString(), Icons.mark_chat_unread, warningColor),
              _buildStatCard("High Priority", notifications.where((n) => n["priority"] == "High").length.toString(), Icons.priority_high, dangerColor),
              _buildStatCard("Today", notifications.where((n) => DateTime.parse(n["timestamp"]).day == DateTime.now().day).length.toString(), Icons.today, infoColor),
            ],
          ),
          SizedBox(height: spMd),

          // Quick Actions
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
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Mark All Read",
                        size: bs.sm,
                        onPressed: () {
                          for (var notif in notifications) {
                            notif["isRead"] = true;
                          }
                          setState(() {});
                          ss("All notifications marked as read");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Clear Read",
                        size: bs.sm,
                        onPressed: () {
                          notifications.removeWhere((notif) => notif["isRead"]);
                          _filterNotifications();
                          ss("Read notifications cleared");
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),

          // Notifications List
          if (filteredNotifications.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(Icons.notifications_off, size: 64, color: disabledColor),
                  SizedBox(height: spSm),
                  Text(
                    "No notifications found",
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
              itemCount: filteredNotifications.length,
              itemBuilder: (context, index) {
                final notif = filteredNotifications[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: !notif["isRead"] ? Border.all(color: primaryColor, width: 2) : null,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: _getNotificationColor(notif["color"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            notif["icon"],
                            color: _getNotificationColor(notif["color"]),
                          ),
                        ),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${notif["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (!notif["isRead"])
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getPriorityColor(notif["priority"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${notif["priority"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: _getPriorityColor(notif["priority"]),
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: spXs),
                            Text(
                              "${notif["message"]}",
                              style: TextStyle(color: disabledBoldColor),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.schedule, size: 16, color: disabledColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${DateTime.parse(notif["timestamp"]).dMMMy}",
                                  style: TextStyle(color: disabledColor, fontSize: 12),
                                ),
                                if (notif["trackingNumber"].isNotEmpty) ...[
                                  SizedBox(width: spSm),
                                  Icon(Icons.local_shipping, size: 16, color: disabledColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${notif["trackingNumber"]}",
                                    style: TextStyle(color: disabledColor, fontSize: 12),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Row(
                          children: [
                            if (!notif["isRead"])
                              Expanded(
                                child: QButton(
                                  label: "Mark as Read",
                                  size: bs.sm,
                                  onPressed: () {
                                    notif["isRead"] = true;
                                    setState(() {});
                                    si("Notification marked as read");
                                  },
                                ),
                              ),
                            if (!notif["isRead"]) SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () {
                                  if (!notif["isRead"]) {
                                    notif["isRead"] = true;
                                    setState(() {});
                                  }
                                  si("Viewing notification details: ${notif["id"]}");
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.delete,
                              size: bs.sm,
                              onPressed: () {
                                notifications.removeWhere((n) => n["id"] == notif["id"]);
                                _filterNotifications();
                                si("Notification deleted");
                              },
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
          // Template Management
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
                  "Notification Templates",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Manage automated notification templates for different events.",
                  style: TextStyle(color: disabledBoldColor),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),

          // Templates List
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: notificationTemplates.length,
            itemBuilder: (context, index) {
              final template = notificationTemplates[index];
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: ExpansionTile(
                  leading: Icon(
                    template["isActive"] ? Icons.notifications_active : Icons.notifications_off,
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
                      Text("${template["type"].toString().toUpperCase()}"),
                      SizedBox(width: spSm),
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
                                icon: Icons.copy,
                                size: bs.sm,
                                onPressed: () {
                                  si("Template copied: ${template["name"]}");
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
                si("Creating new notification template");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    bool emailNotifications = true;
    bool smsNotifications = false;
    bool pushNotifications = true;
    bool systemNotifications = true;
    String deliveryFrequency = "Immediate";
    String quietHoursStart = "22:00";
    String quietHoursEnd = "07:00";

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Notification Channels
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
                  "Notification Channels",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                
                QSwitch(
                  label: "Email Notifications",
                  items: [
                    {
                      "label": "Enable email notifications",
                      "value": true,
                      "checked": emailNotifications,
                    }
                  ],
                  value: [if (emailNotifications) {"label": "Enable email notifications", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    emailNotifications = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                
                QSwitch(
                  label: "SMS Notifications",
                  items: [
                    {
                      "label": "Enable SMS notifications",
                      "value": true,
                      "checked": smsNotifications,
                    }
                  ],
                  value: [if (smsNotifications) {"label": "Enable SMS notifications", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    smsNotifications = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                
                QSwitch(
                  label: "Push Notifications",
                  items: [
                    {
                      "label": "Enable push notifications",
                      "value": true,
                      "checked": pushNotifications,
                    }
                  ],
                  value: [if (pushNotifications) {"label": "Enable push notifications", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    pushNotifications = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                
                QSwitch(
                  label: "System Notifications",
                  items: [
                    {
                      "label": "Enable system notifications",
                      "value": true,
                      "checked": systemNotifications,
                    }
                  ],
                  value: [if (systemNotifications) {"label": "Enable system notifications", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    systemNotifications = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),

          // Delivery Settings
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
                  "Delivery Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                
                QDropdownField(
                  label: "Delivery Frequency",
                  items: [
                    {"label": "Immediate", "value": "Immediate"},
                    {"label": "Every 15 minutes", "value": "15min"},
                    {"label": "Every hour", "value": "1hour"},
                    {"label": "Daily digest", "value": "daily"},
                  ],
                  value: deliveryFrequency,
                  onChanged: (value, label) {
                    deliveryFrequency = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Expanded(
                      child: QTimePicker(
                        label: "Quiet Hours Start",
                        value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 $quietHoursStart:00")),
                        onChanged: (value) {
                          quietHoursStart = value!.kkmm;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTimePicker(
                        label: "Quiet Hours End",
                        value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 $quietHoursEnd:00")),
                        onChanged: (value) {
                          quietHoursEnd = value!.kkmm;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),

          // Advanced Settings
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
                  "Advanced Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                
                _buildSettingItem(
                  "Auto-mark as read",
                  "Automatically mark notifications as read after 7 days",
                  Icons.auto_delete,
                  true,
                ),
                _buildSettingItem(
                  "Sound notifications",
                  "Play sound for high priority notifications",
                  Icons.volume_up,
                  true,
                ),
                _buildSettingItem(
                  "Desktop notifications",
                  "Show desktop notifications on web browser",
                  Icons.desktop_mac,
                  false,
                ),
                _buildSettingItem(
                  "Group similar notifications",
                  "Group notifications of the same type",
                  Icons.group_work,
                  true,
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),

          // Save Settings
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Settings",
              size: bs.md,
              onPressed: () {
                ss("Notification settings saved successfully!");
              },
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

  Widget _buildSettingItem(String title, String description, IconData icon, bool isEnabled) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Icon(icon, color: disabledBoldColor),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: isEnabled,
            onChanged: (value) {
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
