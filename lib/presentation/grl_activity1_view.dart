import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlActivity1View extends StatefulWidget {
  @override
  State<GrlActivity1View> createState() => _GrlActivity1ViewState();
}

class _GrlActivity1ViewState extends State<GrlActivity1View> {
  String selectedFilter = "All";
  String selectedPeriod = "Today";
  
  List<Map<String, dynamic>> activities = [
    {
      "id": "ACT-001",
      "type": "User Login",
      "user": "John Doe",
      "action": "Logged into system",
      "timestamp": "2024-03-15T15:45:00",
      "location": "New York, NY",
      "device": "MacBook Pro",
      "ip_address": "192.168.1.101",
      "status": "Success",
      "details": "Successful login with 2FA verification",
      "session_duration": "2h 15m",
      "category": "Authentication"
    },
    {
      "id": "ACT-002",
      "type": "Data Export",
      "user": "Sarah Wilson",
      "action": "Exported customer data",
      "timestamp": "2024-03-15T14:30:00",
      "location": "San Francisco, CA",
      "device": "Windows Desktop",
      "ip_address": "192.168.1.102",
      "status": "Success",
      "details": "Exported 1,250 customer records to CSV format",
      "file_size": "2.4 MB",
      "category": "Data Management"
    },
    {
      "id": "ACT-003",
      "type": "Security Alert",
      "user": "System Monitor",
      "action": "Detected suspicious activity",
      "timestamp": "2024-03-15T13:20:00",
      "location": "Unknown",
      "device": "Unknown",
      "ip_address": "45.123.789.012",
      "status": "Blocked",
      "details": "Multiple failed login attempts blocked automatically",
      "attempts": 5,
      "category": "Security"
    },
    {
      "id": "ACT-004",
      "type": "File Upload",
      "user": "Mike Johnson",
      "action": "Uploaded project files",
      "timestamp": "2024-03-15T12:45:00",
      "location": "Chicago, IL",
      "device": "iPad Pro",
      "ip_address": "192.168.1.103",
      "status": "Success",
      "details": "Uploaded 15 design files to project repository",
      "file_count": 15,
      "category": "File Management"
    },
    {
      "id": "ACT-005",
      "type": "Settings Change",
      "user": "Emily Davis",
      "action": "Updated notification preferences",
      "timestamp": "2024-03-15T11:30:00",
      "location": "Boston, MA",
      "device": "iPhone 15",
      "ip_address": "192.168.1.104",
      "status": "Success",
      "details": "Modified email and SMS notification settings",
      "changes": 3,
      "category": "Configuration"
    },
    {
      "id": "ACT-006",
      "type": "API Request",
      "user": "Integration Service",
      "action": "Payment API called",
      "timestamp": "2024-03-15T10:15:00",
      "location": "Cloud Server",
      "device": "API Gateway",
      "ip_address": "10.0.0.5",
      "status": "Success",
      "details": "Payment processing completed successfully",
      "response_time": "450ms",
      "category": "Integration"
    },
    {
      "id": "ACT-007",
      "type": "Database Query",
      "user": "Analytics System",
      "action": "Generated monthly report",
      "timestamp": "2024-03-15T09:00:00",
      "location": "Data Center",
      "device": "Database Server",
      "ip_address": "10.0.0.10",
      "status": "Success",
      "details": "Processed 50,000 records for monthly analytics",
      "records_processed": 50000,
      "category": "Analytics"
    }
  ];

  List<Map<String, dynamic>> get filteredActivities {
    return activities.where((activity) {
      bool matchesFilter = selectedFilter == "All" || 
                          activity["category"] == selectedFilter;
      return matchesFilter;
    }).toList();
  }

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Authentication", "value": "Authentication"},
    {"label": "Data Management", "value": "Data Management"},
    {"label": "Security", "value": "Security"},
    {"label": "File Management", "value": "File Management"},
    {"label": "Configuration", "value": "Configuration"},
    {"label": "Integration", "value": "Integration"},
    {"label": "Analytics", "value": "Analytics"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case "Success":
        return successColor;
      case "Blocked":
        return dangerColor;
      case "Failed":
        return dangerColor;
      case "Warning":
        return warningColor;
      default:
        return disabledColor;
    }
  }

  Color getCategoryColor(String category) {
    switch (category) {
      case "Authentication":
        return primaryColor;
      case "Data Management":
        return infoColor;
      case "Security":
        return dangerColor;
      case "File Management":
        return successColor;
      case "Configuration":
        return warningColor;
      case "Integration":
        return secondaryColor;
      case "Analytics":
        return primaryColor;
      default:
        return disabledColor;
    }
  }

  IconData getActivityIcon(String type) {
    switch (type) {
      case "User Login":
        return Icons.login;
      case "Data Export":
        return Icons.download;
      case "Security Alert":
        return Icons.security;
      case "File Upload":
        return Icons.upload;
      case "Settings Change":
        return Icons.settings;
      case "API Request":
        return Icons.api;
      case "Database Query":
        return Icons.storage;
      default:
        return Icons.event;
    }
  }

  String formatTimestamp(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> categoryStats = {};
    Map<String, int> statusStats = {};
    
    for (var activity in filteredActivities) {
      categoryStats[activity["category"]] = 
          (categoryStats[activity["category"]] ?? 0) + 1;
      statusStats[activity["status"]] = 
          (statusStats[activity["status"]] ?? 0) + 1;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Activity Monitor"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "System Activity Dashboard",
              style: TextStyle(
                fontSize: fsH4,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.timeline, color: primaryColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "Total Activities",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${filteredActivities.length}",
                        style: TextStyle(
                          fontSize: fsH2,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: successColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "Successful",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${statusStats["Success"] ?? 0}",
                        style: TextStyle(
                          fontSize: fsH2,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.block, color: dangerColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "Blocked/Failed",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${(statusStats["Blocked"] ?? 0) + (statusStats["Failed"] ?? 0)}",
                        style: TextStyle(
                          fontSize: fsH2,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.category, color: infoColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "Categories",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${categoryStats.keys.length}",
                        style: TextStyle(
                          fontSize: fsH2,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Filter by Category",
                    items: filterOptions,
                    value: selectedFilter,
                    onChanged: (value, label) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QDropdownField(
                    label: "Filter by Period",
                    items: periodOptions,
                    value: selectedPeriod,
                    onChanged: (value, label) {
                      selectedPeriod = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Text(
                  "Recent Activities",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredActivities.length} activities",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),

            Column(
              spacing: spSm,
              children: filteredActivities.map((activity) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: getCategoryColor(activity["category"]),
                      ),
                    ),
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: getCategoryColor(activity["category"]).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              getActivityIcon(activity["type"]),
                              color: getCategoryColor(activity["category"]),
                              size: 20,
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
                                      "${activity["id"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: getStatusColor(activity["status"]).withAlpha(30),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "${activity["status"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: getStatusColor(activity["status"]),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${activity["user"]} ${activity["action"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: getCategoryColor(activity["category"]).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${activity["category"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: getCategoryColor(activity["category"]),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.info, size: 16, color: primaryColor),
                                SizedBox(width: spSm),
                                Text(
                                  "Activity Details:",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${activity["details"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Row(
                        children: [
                          Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            formatTimestamp(activity["timestamp"]),
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "${activity["location"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),

                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.devices, size: 16, color: infoColor),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "Device: ${activity["device"]} • IP: ${activity["ip_address"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                ),
                              ),
                            ),
                            QButton(
                              icon: Icons.more_vert,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),

                      if (activity.containsKey("session_duration") ||
                          activity.containsKey("file_size") ||
                          activity.containsKey("attempts") ||
                          activity.containsKey("file_count") ||
                          activity.containsKey("changes") ||
                          activity.containsKey("response_time") ||
                          activity.containsKey("records_processed"))
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.analytics, size: 16, color: successColor),
                              SizedBox(width: spSm),
                              Text(
                                activity.containsKey("session_duration") ? "Duration: ${activity["session_duration"]}" :
                                activity.containsKey("file_size") ? "File Size: ${activity["file_size"]}" :
                                activity.containsKey("attempts") ? "Attempts: ${activity["attempts"]}" :
                                activity.containsKey("file_count") ? "Files: ${activity["file_count"]}" :
                                activity.containsKey("changes") ? "Changes: ${activity["changes"]}" :
                                activity.containsKey("response_time") ? "Response: ${activity["response_time"]}" :
                                "Records: ${activity["records_processed"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
