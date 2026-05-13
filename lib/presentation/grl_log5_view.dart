import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLog5View extends StatefulWidget {
  @override
  State<GrlLog5View> createState() => _GrlLog5ViewState();
}

class _GrlLog5ViewState extends State<GrlLog5View> {
  String searchQuery = "";
  String selectedEventType = "All";
  String selectedTimeRange = "Today";
  String selectedSeverity = "All";
  bool realTimeMode = true;

  List<Map<String, dynamic>> eventTypes = [
    {"label": "All", "value": "All"},
    {"label": "System Start", "value": "System Start"},
    {"label": "System Stop", "value": "System Stop"},
    {"label": "Service Restart", "value": "Service Restart"},
    {"label": "Configuration Change", "value": "Configuration Change"},
    {"label": "Security Event", "value": "Security Event"},
  ];

  List<Map<String, dynamic>> timeRanges = [
    {"label": "Today", "value": "Today"},
    {"label": "Last 24 hours", "value": "Last 24 hours"},
    {"label": "Last 7 days", "value": "Last 7 days"},
    {"label": "Last 30 days", "value": "Last 30 days"},
  ];

  List<Map<String, dynamic>> severityLevels = [
    {"label": "All", "value": "All"},
    {"label": "Critical", "value": "Critical"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> systemEvents = [
    {
      "id": 1,
      "timestamp": "2024-01-15 11:45:23",
      "type": "System Start",
      "severity": "Medium",
      "source": "System Kernel",
      "message": "System boot completed successfully",
      "details": "Boot time: 45.2 seconds, All services started normally",
      "affected_services": ["Database", "Web Server", "Cache"],
      "user": "SYSTEM"
    },
    {
      "id": 2,
      "timestamp": "2024-01-15 11:32:15",
      "type": "Service Restart",
      "severity": "High",
      "source": "Service Manager",
      "message": "Database service restarted unexpectedly",
      "details": "Service crashed due to memory leak, automatic restart initiated",
      "affected_services": ["Database", "API Gateway"],
      "user": "ServiceManager"
    },
    {
      "id": 3,
      "timestamp": "2024-01-15 11:20:45",
      "type": "Security Event",
      "severity": "Critical",
      "source": "Security Module",
      "message": "Multiple failed login attempts detected",
      "details": "5 failed attempts from IP: 192.168.1.100 in 2 minutes",
      "affected_services": ["Authentication"],
      "user": "admin"
    },
    {
      "id": 4,
      "timestamp": "2024-01-15 11:15:30",
      "type": "Configuration Change",
      "severity": "Low",
      "source": "Config Manager",
      "message": "Database connection pool size updated",
      "details": "Changed from 50 to 100 connections",
      "affected_services": ["Database"],
      "user": "admin"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("System Events"),
        actions: [
          IconButton(
            icon: Icon(realTimeMode ? Icons.pause : Icons.play_arrow),
            onPressed: () {
              realTimeMode = !realTimeMode;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.notification_add),
            onPressed: () {
              // Add alert
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export events
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Real-time Status
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: realTimeMode ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: realTimeMode ? successColor : warningColor,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: realTimeMode ? successColor : warningColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Text(
                    realTimeMode ? "Real-time monitoring active" : "Real-time monitoring paused",
                    style: TextStyle(
                      color: realTimeMode ? successColor : warningColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Last update: ${DateTime.now().toString().substring(11, 19)}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search events...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),

            // Filter Row
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Event Type",
                    items: eventTypes,
                    value: selectedEventType,
                    onChanged: (value, label) {
                      selectedEventType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Severity",
                    items: severityLevels,
                    value: selectedSeverity,
                    onChanged: (value, label) {
                      selectedSeverity = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Time Range",
                    items: timeRanges,
                    value: selectedTimeRange,
                    onChanged: (value, label) {
                      selectedTimeRange = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.tune, color: disabledBoldColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Advanced",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Event Statistics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: [
                _buildStatCard("Total Events", "1,234", Icons.event, primaryColor),
                _buildStatCard("Critical", "12", Icons.priority_high, dangerColor),
                _buildStatCard("High Priority", "45", Icons.warning, warningColor),
                _buildStatCard("Active Services", "23", Icons.check_circle, successColor),
              ],
            ),

            // Events Timeline
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusLg),
                        topRight: Radius.circular(radiusLg),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.timeline, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "System Events Timeline",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${systemEvents.length} Events",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: systemEvents.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final event = systemEvents[index];
                      return _buildEventItem(event);
                    },
                  ),
                ],
              ),
            ),

            // Event Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Export Events",
                    icon: Icons.download,
                    size: bs.md,
                    onPressed: () {
                      // Export events
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Create Alert",
                    icon: Icons.add_alert,
                    size: bs.md,
                    onPressed: () {
                      // Create alert
                    },
                  ),
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
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(icon, color: color, size: 16),
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventItem(Map<String, dynamic> event) {
    Color severityColor = _getSeverityColor(event["severity"]);
    IconData eventIcon = _getEventIcon(event["type"]);
    
    return ExpansionTile(
      tilePadding: EdgeInsets.all(spSm),
      childrenPadding: EdgeInsets.all(spSm),
      leading: Container(
        padding: EdgeInsets.all(spXs),
        decoration: BoxDecoration(
          color: severityColor.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusXs),
        ),
        child: Icon(eventIcon, color: severityColor, size: 18),
      ),
      title: Text(
        "${event["message"]}",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: severityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${event["severity"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: severityColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${event["type"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: infoColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.access_time, size: 12, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${event["timestamp"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(Icons.person, size: 12, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${event["user"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: disabledColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Text(
                    "Source:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${event["source"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              Text(
                "Details:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "${event["details"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                ),
              ),
              Text(
                "Affected Services:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                ),
              ),
              Wrap(
                spacing: spXs,
                children: (event["affected_services"] as List).map((service) => 
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "$service",
                      style: TextStyle(
                        fontSize: 10,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ).toList(),
              ),
              Row(
                children: [
                  QButton(
                    label: "Acknowledge",
                    icon: Icons.check,
                    size: bs.sm,
                    onPressed: () {
                      // Acknowledge event
                    },
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    label: "Details",
                    icon: Icons.visibility,
                    size: bs.sm,
                    onPressed: () {
                      // View full details
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getEventIcon(String type) {
    switch (type) {
      case "System Start":
        return Icons.power_settings_new;
      case "System Stop":
        return Icons.power_off;
      case "Service Restart":
        return Icons.refresh;
      case "Configuration Change":
        return Icons.settings;
      case "Security Event":
        return Icons.security;
      default:
        return Icons.event;
    }
  }
}
