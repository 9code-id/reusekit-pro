import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmArrivalNotificationsView extends StatefulWidget {
  const FsmArrivalNotificationsView({super.key});

  @override
  State<FsmArrivalNotificationsView> createState() => _FsmArrivalNotificationsViewState();
}

class _FsmArrivalNotificationsViewState extends State<FsmArrivalNotificationsView> {
  int selectedTab = 0;
  bool autoNotifications = true;
  bool gpsTracking = true;
  bool customerNotifications = true;
  bool managerNotifications = true;
  int arrivalRadius = 500;
  int notificationTiming = 15;

  List<Map<String, dynamic>> upcomingArrivals = [
    {
      "id": "1",
      "customerName": "Sarah Johnson",
      "address": "1234 Oak Street, Downtown",
      "appointmentTime": "2:30 PM",
      "estimatedArrival": "2:25 PM",
      "distance": "0.8 miles",
      "notificationSent": false,
      "phone": "+1 (555) 123-4567",
      "serviceType": "HVAC Maintenance",
      "priority": "High",
      "notes": "Please call upon arrival - gate code 1234"
    },
    {
      "id": "2",
      "customerName": "Mike Rodriguez",
      "address": "5678 Pine Avenue, Riverside",
      "appointmentTime": "4:00 PM",
      "estimatedArrival": "3:58 PM",
      "distance": "2.3 miles",
      "notificationSent": true,
      "phone": "+1 (555) 987-6543",
      "serviceType": "Plumbing Repair",
      "priority": "Medium",
      "notes": "Customer prefers text notifications"
    },
    {
      "id": "3",
      "customerName": "Lisa Chen",
      "address": "9012 Maple Drive, Northside",
      "appointmentTime": "5:15 PM",
      "estimatedArrival": "5:10 PM",
      "distance": "4.7 miles",
      "notificationSent": false,
      "phone": "+1 (555) 456-7890",
      "serviceType": "Electrical Inspection",
      "priority": "Low",
      "notes": "Ring doorbell - home office in basement"
    }
  ];

  List<Map<String, dynamic>> notificationHistory = [
    {
      "id": "1",
      "customerName": "Robert Smith",
      "sentTime": "11:45 AM",
      "arrivalTime": "12:00 PM",
      "actualArrival": "11:58 AM",
      "method": "SMS",
      "status": "Delivered",
      "response": "Thank you for the heads up!",
      "date": "2024-03-15"
    },
    {
      "id": "2",
      "customerName": "Emma Davis",
      "sentTime": "09:30 AM",
      "arrivalTime": "09:45 AM",
      "actualArrival": "09:47 AM",
      "method": "Phone Call",
      "status": "Answered",
      "response": "Great, I'll be ready",
      "date": "2024-03-15"
    },
    {
      "id": "3",
      "customerName": "David Wilson",
      "sentTime": "02:15 PM",
      "arrivalTime": "02:30 PM",
      "actualArrival": "02:28 PM",
      "method": "Email",
      "status": "Read",
      "response": "Received",
      "date": "2024-03-14"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Arrival Notifications",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Upcoming", icon: Icon(Icons.upcoming)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildUpcomingTab(),
        _buildSettingsTab(),
        _buildHistoryTab(),
      ],
    );
  }

  Widget _buildUpcomingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Status Overview
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: autoNotifications ? successColor.withAlpha(20) : warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(
                color: autoNotifications ? successColor : warningColor,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: autoNotifications ? successColor : warningColor,
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Icon(
                    autoNotifications ? Icons.notifications_active : Icons.notifications_off,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        autoNotifications ? "Auto Notifications ON" : "Auto Notifications OFF",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        autoNotifications 
                          ? "Customers will be notified automatically"
                          : "Manual notifications required",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Quick Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 160,
            children: [
              _buildStatCard("Next Arrival", "2:25 PM", Icons.schedule, primaryColor),
              _buildStatCard("Pending", "${upcomingArrivals.where((a) => !(a["notificationSent"] as bool)).length}", Icons.pending, warningColor),
              _buildStatCard("Sent Today", "8", Icons.send, successColor),
              _buildStatCard("On Time Rate", "96%", Icons.check_circle, infoColor),
            ],
          ),

          // Upcoming Arrivals List
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.upcoming, color: primaryColor),
                    SizedBox(width: spSm),
                    Text(
                      "Upcoming Arrivals",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Refresh",
                      icon: Icons.refresh,
                      size: bs.sm,
                      onPressed: () {
                        ss("Location updated");
                      },
                    ),
                  ],
                ),
                ...upcomingArrivals.map((arrival) => _buildArrivalCard(arrival)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Notification Settings
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Notification Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildSwitchItem("Auto Notifications", "Automatically notify customers when approaching", autoNotifications, (value) {
                  autoNotifications = value;
                  setState(() {});
                }),
                _buildSwitchItem("GPS Tracking", "Use GPS to detect arrival proximity", gpsTracking, (value) {
                  gpsTracking = value;
                  setState(() {});
                }),
                _buildSwitchItem("Customer Notifications", "Send notifications to customers", customerNotifications, (value) {
                  customerNotifications = value;
                  setState(() {});
                }),
                _buildSwitchItem("Manager Notifications", "Notify managers of technician arrivals", managerNotifications, (value) {
                  managerNotifications = value;
                  setState(() {});
                }),
              ],
            ),
          ),

          // Timing Settings
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Timing Configuration",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildSliderSetting("Arrival Radius", "Distance from location to trigger notification", arrivalRadius, 100, 1000, "meters", (value) {
                  arrivalRadius = value.round();
                  setState(() {});
                }),
                _buildSliderSetting("Notification Timing", "Minutes before estimated arrival", notificationTiming, 5, 60, "minutes", (value) {
                  notificationTiming = value.round();
                  setState(() {});
                }),
              ],
            ),
          ),

          // Notification Methods
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Notification Methods",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildMethodCard("SMS Text", "Primary notification method", Icons.message, true),
                _buildMethodCard("Phone Call", "For urgent or no-response cases", Icons.phone, true),
                _buildMethodCard("Email", "Follow-up confirmation", Icons.email, false),
                _buildMethodCard("Push Notification", "In-app notifications", Icons.notifications, true),
              ],
            ),
          ),

          // Templates
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Text(
                      "Message Templates",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Edit",
                      size: bs.sm,
                      onPressed: () {
                        ss("Opening template editor");
                      },
                    ),
                  ],
                ),
                _buildTemplateCard("Standard Arrival", "Hi [Customer], your technician will arrive in approximately [Time] minutes for your [Service] appointment."),
                _buildTemplateCard("Delayed Arrival", "Hi [Customer], your technician is running slightly behind and will arrive at approximately [NewTime] for your [Service] appointment."),
                _buildTemplateCard("Early Arrival", "Hi [Customer], your technician is ahead of schedule and can arrive early at [EarlyTime] if convenient for your [Service] appointment."),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Daily Summary
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Today's Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 140,
                  children: [
                    _buildSummaryCard("Sent", "12", Icons.send, successColor),
                    _buildSummaryCard("Delivered", "11", Icons.check, primaryColor),
                    _buildSummaryCard("Read", "9", Icons.mark_email_read, infoColor),
                    _buildSummaryCard("Responses", "7", Icons.reply, warningColor),
                  ],
                ),
              ],
            ),
          ),

          // Filter Options
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Filter History",
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
                      child: QButton(
                        label: "Today",
                        size: bs.sm,
                        onPressed: () {
                          ss("Filtering today's notifications");
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "This Week",
                        size: bs.sm,
                        onPressed: () {
                          ss("Filtering this week");
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Custom",
                        size: bs.sm,
                        onPressed: () {
                          ss("Custom date range");
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Notification History List
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.history, color: primaryColor),
                    SizedBox(width: spSm),
                    Text(
                      "Recent Notifications",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                ...notificationHistory.map((notification) => _buildHistoryCard(notification)),
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
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, color: color, size: 32),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArrivalCard(Map<String, dynamic> arrival) {
    bool notificationSent = arrival["notificationSent"] as bool;
    Color statusColor = notificationSent ? successColor : warningColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: statusColor.withAlpha(30)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  notificationSent ? Icons.check : Icons.schedule,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${arrival["customerName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${arrival["serviceType"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getPriorityColor(arrival["priority"] as String).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${arrival["priority"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: _getPriorityColor(arrival["priority"] as String),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.location_on, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${arrival["address"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.schedule, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Appointment: ${arrival["appointmentTime"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(Icons.navigation, color: primaryColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "ETA: ${arrival["estimatedArrival"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          if (!notificationSent)
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Send Notification",
                    icon: Icons.send,
                    size: bs.sm,
                    onPressed: () {
                      arrival["notificationSent"] = true;
                      setState(() {});
                      ss("Notification sent to ${arrival["customerName"]}");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.phone,
                  size: bs.sm,
                  onPressed: () {
                    ss("Calling ${arrival["customerName"]}");
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildSwitchItem(String title, String subtitle, bool value, Function(bool) onChanged) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildSliderSetting(String title, String subtitle, int value, double min, double max, String unit, Function(double) onChanged) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "$value $unit",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Slider(
            value: value.toDouble(),
            min: min,
            max: max,
            divisions: ((max - min) / (max > 100 ? 50 : 5)).round(),
            onChanged: onChanged,
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildMethodCard(String title, String subtitle, IconData icon, bool enabled) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: enabled ? successColor.withAlpha(10) : disabledColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: enabled ? successColor.withAlpha(30) : disabledColor.withAlpha(30),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: enabled ? successColor : disabledColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: enabled ? primaryColor : disabledBoldColor,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: enabled,
            onChanged: (value) {
              ss(enabled ? "Method disabled" : "Method enabled");
            },
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateCard(String title, String template) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            template,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, color: color, size: 24),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> notification) {
    Color statusColor = _getStatusColor(notification["status"] as String);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: statusColor.withAlpha(30)),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  _getStatusIcon(notification["status"] as String),
                  color: Colors.white,
                  size: 14,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${notification["customerName"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "${notification["method"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.schedule, color: disabledBoldColor, size: 14),
              SizedBox(width: spXs),
              Text(
                "Sent: ${notification["sentTime"]} | Arrived: ${notification["actualArrival"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if ((notification["response"] as String).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.reply, color: infoColor, size: 14),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${notification["response"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: infoColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high': return dangerColor;
      case 'medium': return warningColor;
      case 'low': return successColor;
      default: return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered': return successColor;
      case 'answered': return primaryColor;
      case 'read': return infoColor;
      case 'failed': return dangerColor;
      default: return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'delivered': return Icons.check;
      case 'answered': return Icons.phone;
      case 'read': return Icons.mark_email_read;
      case 'failed': return Icons.error;
      default: return Icons.info;
    }
  }
}
