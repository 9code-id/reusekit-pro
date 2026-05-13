import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmAdminPanelView extends StatefulWidget {
  const TpmAdminPanelView({super.key});

  @override
  State<TpmAdminPanelView> createState() => _TpmAdminPanelViewState();
}

class _TpmAdminPanelViewState extends State<TpmAdminPanelView> {
  int currentTab = 0;
  
  List<Map<String, dynamic>> systemStats = [
    {
      "title": "Total Users",
      "value": 15847,
      "change": 12.5,
      "icon": Icons.people,
      "color": primaryColor,
    },
    {
      "title": "Active Projects",
      "value": 3421,
      "change": 8.2,
      "icon": Icons.folder,
      "color": successColor,
    },
    {
      "title": "Monthly Revenue",
      "value": 45692.50,
      "change": -3.1,
      "icon": Icons.attach_money,
      "color": warningColor,
    },
    {
      "title": "Support Tickets",
      "value": 127,
      "change": -15.4,
      "icon": Icons.support_agent,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "id": 1,
      "type": "user_registration",
      "user": "john.doe@company.com",
      "action": "New user registered",
      "timestamp": "2025-06-19 14:30:00",
      "details": "Professional plan signup",
    },
    {
      "id": 2,
      "type": "subscription",
      "user": "jane.smith@startup.io",
      "action": "Upgraded to Enterprise",
      "timestamp": "2025-06-19 13:45:00",
      "details": "Annual billing selected",
    },
    {
      "id": 3,
      "type": "support_ticket",
      "user": "mike.wilson@tech.com",
      "action": "Support ticket created",
      "timestamp": "2025-06-19 12:15:00",
      "details": "API integration issues",
    },
    {
      "id": 4,
      "type": "system_alert",
      "user": "System",
      "action": "High CPU usage detected",
      "timestamp": "2025-06-19 11:30:00",
      "details": "Server load at 85%",
    },
    {
      "id": 5,
      "type": "payment_failed",
      "user": "sarah.jones@agency.com",
      "action": "Payment failed",
      "timestamp": "2025-06-19 10:45:00",
      "details": "Credit card expired",
    },
  ];

  List<Map<String, dynamic>> systemAlerts = [
    {
      "id": 1,
      "type": "warning",
      "title": "High Memory Usage",
      "message": "Database server memory usage is at 92%",
      "timestamp": "2025-06-19 15:00:00",
      "resolved": false,
    },
    {
      "id": 2,
      "type": "info",
      "title": "Scheduled Maintenance",
      "message": "System maintenance scheduled for tonight at 2 AM",
      "timestamp": "2025-06-19 14:00:00",
      "resolved": false,
    },
    {
      "id": 3,
      "type": "error",
      "title": "API Rate Limit Exceeded",
      "message": "User 'enterprise_client_001' exceeded API rate limits",
      "timestamp": "2025-06-19 13:30:00",
      "resolved": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Admin Panel",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Dashboard", icon: Icon(Icons.dashboard)),
        Tab(text: "Users", icon: Icon(Icons.people)),
        Tab(text: "System", icon: Icon(Icons.settings)),
        Tab(text: "Reports", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildDashboardTab(),
        _buildUsersTab(),
        _buildSystemTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSystemStatsGrid(),
          _buildQuickActionsCard(),
          _buildRecentActivitiesCard(),
          _buildSystemAlertsCard(),
        ],
      ),
    );
  }

  Widget _buildSystemStatsGrid() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: systemStats.map((stat) => _buildStatCard(stat)).toList(),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    bool isPositive = (stat["change"] as num) >= 0;
    Color changeColor = isPositive ? successColor : dangerColor;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (stat["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  stat["icon"],
                  color: stat["color"],
                  size: 24,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: changeColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.trending_up : Icons.trending_down,
                      color: changeColor,
                      size: 12,
                    ),
                    Text(
                      "${(stat["change"] as num).abs().toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 10,
                        color: changeColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            stat["title"] == "Monthly Revenue" 
                ? "\$${((stat["value"] as num).toDouble()).currency}"
                : "${stat["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: stat["color"],
            ),
          ),
          Text(
            "${stat["title"]}",
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

  Widget _buildQuickActionsCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildQuickActionButton(
                "Manage Users",
                Icons.people_outline,
                () => si("Opening user management"),
              ),
              _buildQuickActionButton(
                "System Settings",
                Icons.settings,
                () => si("Opening system settings"),
              ),
              _buildQuickActionButton(
                "Backup Data",
                Icons.backup,
                () => si("Starting data backup"),
              ),
              _buildQuickActionButton(
                "View Logs",
                Icons.description,
                () => si("Opening system logs"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(String title, IconData icon, VoidCallback onPressed) {
    return Container(
      child: QButton(
        label: title,
        icon: icon,
        size: bs.sm,
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildRecentActivitiesCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Recent Activities",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {
                  si("Opening full activity log");
                },
              ),
            ],
          ),
          ...recentActivities.take(5).map((activity) => _buildActivityItem(activity)),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    IconData activityIcon;
    Color activityColor;
    
    switch (activity["type"]) {
      case "user_registration":
        activityIcon = Icons.person_add;
        activityColor = successColor;
        break;
      case "subscription":
        activityIcon = Icons.upgrade;
        activityColor = primaryColor;
        break;
      case "support_ticket":
        activityIcon = Icons.support_agent;
        activityColor = warningColor;
        break;
      case "system_alert":
        activityIcon = Icons.warning;
        activityColor = dangerColor;
        break;
      case "payment_failed":
        activityIcon = Icons.payment;
        activityColor = dangerColor;
        break;
      default:
        activityIcon = Icons.info;
        activityColor = infoColor;
    }
    
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: activityColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              activityIcon,
              color: activityColor,
              size: 16,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${activity["action"]}",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${activity["user"]} • ${activity["details"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${DateTime.parse(activity["timestamp"]).dMMMy}",
                  style: TextStyle(
                    fontSize: 10,
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

  Widget _buildSystemAlertsCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "System Alerts",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "${systemAlerts.where((alert) => !alert["resolved"]).length} active",
                style: TextStyle(
                  fontSize: 12,
                  color: dangerColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          ...systemAlerts.map((alert) => _buildAlertItem(alert)),
        ],
      ),
    );
  }

  Widget _buildAlertItem(Map<String, dynamic> alert) {
    Color alertColor;
    IconData alertIcon;
    
    switch (alert["type"]) {
      case "error":
        alertColor = dangerColor;
        alertIcon = Icons.error;
        break;
      case "warning":
        alertColor = warningColor;
        alertIcon = Icons.warning;
        break;
      case "info":
        alertColor = infoColor;
        alertIcon = Icons.info;
        break;
      default:
        alertColor = disabledBoldColor;
        alertIcon = Icons.circle;
    }
    
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(
          color: alert["resolved"] ? disabledOutlineBorderColor : alertColor.withAlpha(50),
        ),
        borderRadius: BorderRadius.circular(radiusSm),
        color: alert["resolved"] ? disabledColor.withAlpha(10) : alertColor.withAlpha(5),
      ),
      child: Row(
        children: [
          Icon(
            alertIcon,
            color: alert["resolved"] ? disabledBoldColor : alertColor,
            size: 16,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${alert["title"]}",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: alert["resolved"] ? disabledBoldColor : primaryColor,
                        ),
                      ),
                    ),
                    if (alert["resolved"]) ...[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Resolved",
                          style: TextStyle(
                            fontSize: 10,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  "${alert["message"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${DateTime.parse(alert["timestamp"]).dMMMy}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          if (!alert["resolved"]) ...[
            QButton(
              label: "Resolve",
              size: bs.sm,
              onPressed: () {
                alert["resolved"] = true;
                setState(() {});
                ss("Alert marked as resolved");
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildUsersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          Container(
            padding: EdgeInsets.all(spLg),
            child: Column(
              children: [
                Icon(
                  Icons.people,
                  size: 48,
                  color: primaryColor,
                ),
                SizedBox(height: spSm),
                Text(
                  "User Management",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Detailed user management will be available here",
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

  Widget _buildSystemTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          Container(
            padding: EdgeInsets.all(spLg),
            child: Column(
              children: [
                Icon(
                  Icons.settings,
                  size: 48,
                  color: primaryColor,
                ),
                SizedBox(height: spSm),
                Text(
                  "System Configuration",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "System settings and configuration options",
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

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          Container(
            padding: EdgeInsets.all(spLg),
            child: Column(
              children: [
                Icon(
                  Icons.analytics,
                  size: 48,
                  color: primaryColor,
                ),
                SizedBox(height: spSm),
                Text(
                  "Analytics & Reports",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Detailed analytics and reporting dashboard",
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
}
