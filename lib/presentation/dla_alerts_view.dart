import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaAlertsView extends StatefulWidget {
  const DlaAlertsView({super.key});

  @override
  State<DlaAlertsView> createState() => _DlaAlertsViewState();
}

class _DlaAlertsViewState extends State<DlaAlertsView> {
  String selectedSeverity = "all";
  String selectedCategory = "all";
  String selectedStatus = "all";
  
  final List<Map<String, dynamic>> severityOptions = [
    {"label": "All Severity", "value": "all"},
    {"label": "Critical", "value": "critical"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  final List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Delivery Issues", "value": "delivery"},
    {"label": "Vehicle Problems", "value": "vehicle"},
    {"label": "Route Delays", "value": "route"},
    {"label": "System Errors", "value": "system"},
    {"label": "Weather Conditions", "value": "weather"},
    {"label": "Security", "value": "security"},
  ];

  final List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Acknowledged", "value": "acknowledged"},
    {"label": "Resolved", "value": "resolved"},
    {"label": "Escalated", "value": "escalated"},
  ];

  final List<Map<String, dynamic>> alerts = [
    {
      "id": "ALT-001",
      "title": "Vehicle Breakdown - DL-VH-089",
      "description": "Vehicle DL-VH-089 has broken down on Jakarta-Bandung route. Driver reported engine issues.",
      "severity": "critical",
      "category": "vehicle",
      "status": "active",
      "timestamp": "2024-06-17T15:30:00",
      "location": "Jakarta-Bandung Toll Road KM 45",
      "affectedDeliveries": 8,
      "assignedTo": "Maintenance Team Alpha",
      "estimatedResolution": "2024-06-17T18:00:00",
    },
    {
      "id": "ALT-002",
      "title": "Route Congestion Alert",
      "description": "Heavy traffic detected on Surabaya Ring Road. Multiple deliveries affected with delays up to 2 hours.",
      "severity": "high",
      "category": "route",
      "status": "acknowledged",
      "timestamp": "2024-06-17T14:45:00",
      "location": "Surabaya Ring Road",
      "affectedDeliveries": 15,
      "assignedTo": "Route Optimization Team",
      "estimatedResolution": "2024-06-17T17:30:00",
    },
    {
      "id": "ALT-003",
      "title": "Weather Warning - Heavy Rain",
      "description": "Heavy rainfall warning issued for Central Java region. Potential delivery delays and safety concerns.",
      "severity": "medium",
      "category": "weather",
      "status": "active",
      "timestamp": "2024-06-17T13:20:00",
      "location": "Central Java Region",
      "affectedDeliveries": 25,
      "assignedTo": "Operations Team",
      "estimatedResolution": "2024-06-18T06:00:00",
    },
    {
      "id": "ALT-004",
      "title": "System Database Connection Error",
      "description": "Intermittent database connection issues affecting order tracking system. Some tracking updates may be delayed.",
      "severity": "high",
      "category": "system",
      "status": "escalated",
      "timestamp": "2024-06-17T12:15:00",
      "location": "Data Center Jakarta",
      "affectedDeliveries": 0,
      "assignedTo": "IT Infrastructure Team",
      "estimatedResolution": "2024-06-17T16:00:00",
    },
    {
      "id": "ALT-005",
      "title": "Delivery Address Verification Failed",
      "description": "Multiple deliveries failed address verification. Customer contact required for address confirmation.",
      "severity": "medium",
      "category": "delivery",
      "status": "acknowledged",
      "timestamp": "2024-06-17T11:30:00",
      "location": "Various Locations",
      "affectedDeliveries": 6,
      "assignedTo": "Customer Service Team",
      "estimatedResolution": "2024-06-17T17:00:00",
    },
    {
      "id": "ALT-006",
      "title": "Fuel Level Low - Multiple Vehicles",
      "description": "5 vehicles reporting low fuel levels. Immediate refueling required to maintain delivery schedules.",
      "severity": "low",
      "category": "vehicle",
      "status": "resolved",
      "timestamp": "2024-06-17T10:45:00",
      "location": "Various Locations",
      "affectedDeliveries": 12,
      "assignedTo": "Fleet Management",
      "estimatedResolution": "2024-06-17T12:00:00",
    },
    {
      "id": "ALT-007",
      "title": "Unauthorized Access Attempt",
      "description": "Multiple failed login attempts detected from unusual IP addresses. Security protocols activated.",
      "severity": "high",
      "category": "security",
      "status": "resolved",
      "timestamp": "2024-06-17T09:20:00",
      "location": "System Wide",
      "affectedDeliveries": 0,
      "assignedTo": "Security Team",
      "estimatedResolution": "2024-06-17T10:30:00",
    },
  ];

  List<Map<String, dynamic>> get filteredAlerts {
    return alerts.where((alert) {
      bool matchesSeverity = selectedSeverity == "all" || alert["severity"] == selectedSeverity;
      bool matchesCategory = selectedCategory == "all" || alert["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "all" || alert["status"] == selectedStatus;
      
      return matchesSeverity && matchesCategory && matchesStatus;
    }).toList();
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "critical":
        return dangerColor;
      case "high":
        return warningColor;
      case "medium":
        return infoColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return dangerColor;
      case "acknowledged":
        return warningColor;
      case "escalated":
        return primaryColor;
      case "resolved":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "delivery":
        return Icons.local_shipping;
      case "vehicle":
        return Icons.directions_car;
      case "route":
        return Icons.route;
      case "system":
        return Icons.computer;
      case "weather":
        return Icons.cloud;
      case "security":
        return Icons.security;
      default:
        return Icons.warning;
    }
  }

  Widget _buildAlertFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
            "Alert Filters",
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
                  label: "Severity",
                  items: severityOptions,
                  value: selectedSeverity,
                  onChanged: (value, label) {
                    selectedSeverity = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryOptions,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Status",
            items: statusOptions,
            value: selectedStatus,
            onChanged: (value, label) {
              selectedStatus = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAlertSummary() {
    int criticalCount = alerts.where((a) => a["severity"] == "critical" && a["status"] != "resolved").length;
    int highCount = alerts.where((a) => a["severity"] == "high" && a["status"] != "resolved").length;
    int activeCount = alerts.where((a) => a["status"] == "active").length;
    int totalAffected = alerts.where((a) => a["status"] != "resolved").fold(0, (sum, a) => sum + (a["affectedDeliveries"] as int));

    return Container(
      padding: EdgeInsets.all(spSm),
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
            "Alert Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildSummaryCard("Critical Alerts", "$criticalCount", Icons.error, dangerColor),
              _buildSummaryCard("High Priority", "$highCount", Icons.warning, warningColor),
              _buildSummaryCard("Active Alerts", "$activeCount", Icons.notification_important, primaryColor),
              _buildSummaryCard("Affected Deliveries", "$totalAffected", Icons.local_shipping, infoColor),
            ],
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
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color,
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

  Widget _buildAlertsList() {
    if (filteredAlerts.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spLg),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(
              Icons.check_circle,
              size: 64,
              color: successColor,
            ),
            SizedBox(height: spSm),
            Text(
              "No alerts found",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "No alerts match your current filters",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      spacing: spSm,
      children: filteredAlerts.map((alert) => _buildAlertItem(alert)).toList(),
    );
  }

  Widget _buildAlertItem(Map<String, dynamic> alert) {
    Color severityColor = _getSeverityColor(alert["severity"] as String);
    Color statusColor = _getStatusColor(alert["status"] as String);
    IconData categoryIcon = _getCategoryIcon(alert["category"] as String);
    DateTime timestamp = DateTime.parse(alert["timestamp"] as String);
    String timeAgo = _getTimeAgo(timestamp);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: severityColor,
            width: 4,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radiusMd),
          onTap: () {
            si("Opening alert details: ${alert["title"]}");
          },
          child: Container(
            padding: EdgeInsets.all(spSm),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: severityColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        categoryIcon,
                        color: severityColor,
                        size: 20,
                      ),
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
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: severityColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${alert["severity"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: severityColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "ID: ${alert["id"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Text(
                        "${alert["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 14,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${alert["location"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${alert["status"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    if ((alert["affectedDeliveries"] as int) > 0)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${alert["affectedDeliveries"]} deliveries affected",
                          style: TextStyle(
                            fontSize: 10,
                            color: warningColor,
                          ),
                        ),
                      ),
                    Spacer(),
                    Text(
                      timeAgo,
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Assigned to: ${alert["assignedTo"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                    if (alert["status"] != "resolved")
                      QButton(
                        label: alert["status"] == "active" ? "Acknowledge" : "Update",
                        size: bs.sm,
                        onPressed: () {
                          if (alert["status"] == "active") {
                            alert["status"] = "acknowledged";
                            setState(() {});
                            ss("Alert acknowledged");
                          } else {
                            si("Updating alert status");
                          }
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return "${difference.inDays}d ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours}h ago";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes}m ago";
    } else {
      return "Just now";
    }
  }

  Widget _buildAlertActions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        spacing: spSm,
        children: [
          Expanded(
            child: QButton(
              label: "Acknowledge All",
              icon: Icons.done_all,
              size: bs.sm,
              onPressed: () {
                for (var alert in alerts) {
                  if (alert["status"] == "active") {
                    alert["status"] = "acknowledged";
                  }
                }
                setState(() {});
                ss("All active alerts acknowledged");
              },
            ),
          ),
          Expanded(
            child: QButton(
              label: "Create Report",
              icon: Icons.report,
              color: disabledBoldColor,
              size: bs.sm,
              onPressed: () {
                si("Creating alert summary report");
              },
            ),
          ),
          QButton(
            icon: Icons.settings,
            size: bs.sm,
            onPressed: () {
              si("Opening alert settings");
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("System Alerts"),
        actions: [
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () {
              si("Refreshing alerts");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildAlertFilters(),
            _buildAlertSummary(),
            _buildAlertActions(),
            _buildAlertsList(),
          ],
        ),
      ),
    );
  }
}
