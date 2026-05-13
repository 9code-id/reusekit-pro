import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlActivity2View extends StatefulWidget {
  @override
  State<GrlActivity2View> createState() => _GrlActivity2ViewState();
}

class _GrlActivity2ViewState extends State<GrlActivity2View> {
  String selectedType = "All";
  String selectedUser = "All";
  
  List<Map<String, dynamic>> userActions = [
    {
      "id": "UA-001",
      "user_name": "John Doe",
      "user_role": "Admin",
      "action_type": "Create",
      "target": "New User Account",
      "description": "Created user account for Sarah Wilson with manager privileges",
      "timestamp": "2024-03-15T15:30:00",
      "ip_address": "192.168.1.101",
      "location": "New York Office",
      "success": true,
      "affected_records": 1,
      "changes": {
        "username": "sarah.wilson",
        "role": "Manager",
        "department": "Sales",
        "permissions": ["read", "write", "manage_team"]
      }
    },
    {
      "id": "UA-002",
      "user_name": "Sarah Wilson",
      "user_role": "Manager",
      "action_type": "Update",
      "target": "Product Inventory",
      "description": "Updated stock levels for 25 products in Electronics category",
      "timestamp": "2024-03-15T14:45:00",
      "ip_address": "192.168.1.102",
      "location": "San Francisco Office",
      "success": true,
      "affected_records": 25,
      "changes": {
        "category": "Electronics",
        "updated_items": 25,
        "total_quantity_added": 150,
        "value_adjustment": 12500.75
      }
    },
    {
      "id": "UA-003",
      "user_name": "Mike Johnson",
      "user_role": "Developer",
      "action_type": "Delete",
      "target": "Legacy Code Files",
      "description": "Removed outdated code files from project repository",
      "timestamp": "2024-03-15T13:20:00",
      "ip_address": "192.168.1.103",
      "location": "Remote",
      "success": true,
      "affected_records": 18,
      "changes": {
        "project": "Mobile App v2.0",
        "files_removed": 18,
        "total_size_freed": "2.4 MB",
        "commit_hash": "a1b2c3d4"
      }
    },
    {
      "id": "UA-004",
      "user_name": "Emily Davis",
      "user_role": "HR Manager",
      "action_type": "View",
      "target": "Employee Records",
      "description": "Accessed employee performance reports for quarterly review",
      "timestamp": "2024-03-15T12:10:00",
      "ip_address": "192.168.1.104",
      "location": "Chicago Office",
      "success": true,
      "affected_records": 150,
      "changes": {
        "report_type": "Performance Review",
        "employees_reviewed": 150,
        "department": "All",
        "review_period": "Q1 2024"
      }
    },
    {
      "id": "UA-005",
      "user_name": "David Brown",
      "user_role": "Financial Analyst",
      "action_type": "Export",
      "target": "Financial Reports",
      "description": "Exported monthly financial data for board presentation",
      "timestamp": "2024-03-15T11:30:00",
      "ip_address": "192.168.1.105",
      "location": "Boston Office",
      "success": true,
      "affected_records": 1,
      "changes": {
        "report_format": "Excel",
        "data_period": "March 2024",
        "file_size": "1.8 MB",
        "export_type": "Detailed Financial Summary"
      }
    },
    {
      "id": "UA-006",
      "user_name": "Lisa Chen",
      "user_role": "Marketing Manager",
      "action_type": "Create",
      "target": "Marketing Campaign",
      "description": "Created new spring promotion campaign with budget allocation",
      "timestamp": "2024-03-15T10:15:00",
      "ip_address": "192.168.1.106",
      "location": "Los Angeles Office",
      "success": true,
      "affected_records": 1,
      "changes": {
        "campaign_name": "Spring Sale 2024",
        "budget": 25000.00,
        "duration": "30 days",
        "target_audience": "Premium Customers"
      }
    },
    {
      "id": "UA-007",
      "user_name": "Robert Lee",
      "user_role": "Support Agent",
      "action_type": "Update",
      "target": "Customer Tickets",
      "description": "Resolved 12 customer support tickets and updated status",
      "timestamp": "2024-03-15T09:45:00",
      "ip_address": "192.168.1.107",
      "location": "Remote",
      "success": true,
      "affected_records": 12,
      "changes": {
        "tickets_resolved": 12,
        "average_resolution_time": "45 minutes",
        "customer_satisfaction": 4.8,
        "priority_levels": ["High: 3", "Medium: 6", "Low: 3"]
      }
    }
  ];

  List<Map<String, dynamic>> get filteredActions {
    return userActions.where((action) {
      bool matchesType = selectedType == "All" || 
                        action["action_type"] == selectedType;
      bool matchesUser = selectedUser == "All" || 
                        action["user_name"] == selectedUser;
      return matchesType && matchesUser;
    }).toList();
  }

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All", "value": "All"},
    {"label": "Create", "value": "Create"},
    {"label": "Update", "value": "Update"},
    {"label": "Delete", "value": "Delete"},
    {"label": "View", "value": "View"},
    {"label": "Export", "value": "Export"},
  ];

  List<Map<String, dynamic>> get userOptions {
    List<String> uniqueUsers = userActions.map((action) => action["user_name"] as String).toSet().toList();
    return [
      {"label": "All", "value": "All"},
      ...uniqueUsers.map((user) => {"label": user, "value": user}).toList()
    ];
  }

  Color getActionTypeColor(String actionType) {
    switch (actionType) {
      case "Create":
        return successColor;
      case "Update":
        return primaryColor;
      case "Delete":
        return dangerColor;
      case "View":
        return infoColor;
      case "Export":
        return warningColor;
      default:
        return disabledColor;
    }
  }

  Color getRoleColor(String role) {
    switch (role) {
      case "Admin":
        return dangerColor;
      case "Manager":
        return warningColor;
      case "Developer":
        return primaryColor;
      case "HR Manager":
        return infoColor;
      case "Financial Analyst":
        return successColor;
      case "Marketing Manager":
        return secondaryColor;
      case "Support Agent":
        return primaryColor;
      default:
        return disabledColor;
    }
  }

  IconData getActionIcon(String actionType) {
    switch (actionType) {
      case "Create":
        return Icons.add_circle;
      case "Update":
        return Icons.edit;
      case "Delete":
        return Icons.delete;
      case "View":
        return Icons.visibility;
      case "Export":
        return Icons.download;
      default:
        return Icons.settings;
    }
  }

  String formatTimestamp(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> actionStats = {};
    Map<String, int> userStats = {};
    
    for (var action in filteredActions) {
      actionStats[action["action_type"]] = 
          (actionStats[action["action_type"]] ?? 0) + 1;
      userStats[action["user_name"]] = 
          (userStats[action["user_name"]] ?? 0) + 1;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("User Actions"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "User Action Tracking",
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
                            "Total Actions",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${filteredActions.length}",
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
                          Icon(Icons.people, color: infoColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "Active Users",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${userStats.keys.length}",
                        style: TextStyle(
                          fontSize: fsH2,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
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
                        "${filteredActions.where((a) => a["success"]).length}",
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
                          Icon(Icons.storage, color: warningColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "Records Affected",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${filteredActions.fold(0, (sum, action) => sum + (action["affected_records"] as int))}",
                        style: TextStyle(
                          fontSize: fsH2,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
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
                    label: "Filter by Action Type",
                    items: typeOptions,
                    value: selectedType,
                    onChanged: (value, label) {
                      selectedType = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QDropdownField(
                    label: "Filter by User",
                    items: userOptions,
                    value: selectedUser,
                    onChanged: (value, label) {
                      selectedUser = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Text(
                  "User Actions Log",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredActions.length} actions",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),

            Column(
              spacing: spMd,
              children: filteredActions.map((action) {
                Map<String, dynamic> changes = action["changes"];
                
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: getActionTypeColor(action["action_type"]),
                      ),
                    ),
                  ),
                  child: Column(
                    spacing: spMd,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: getActionTypeColor(action["action_type"]).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              getActionIcon(action["action_type"]),
                              color: getActionTypeColor(action["action_type"]),
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
                                      "${action["id"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    if (action["success"])
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: successColor.withAlpha(30),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "SUCCESS",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: successColor,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${action["user_name"]} performed ${action["action_type"]}",
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
                              color: getRoleColor(action["user_role"]).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${action["user_role"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: getRoleColor(action["user_role"]),
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
                                Icon(Icons.assignment, size: 16, color: primaryColor),
                                SizedBox(width: spSm),
                                Text(
                                  "Target: ${action["target"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${action["description"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.edit_note, size: 16, color: primaryColor),
                                SizedBox(width: spSm),
                                Text(
                                  "Changes Made:",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            ResponsiveGridView(
                              padding: EdgeInsets.zero,
                              minItemWidth: 200,
                              children: changes.entries.map((entry) {
                                String key = entry.key;
                                dynamic value = entry.value;
                                String displayKey = key.replaceAll('_', ' ').split(' ')
                                    .map((word) => word[0].toUpperCase() + word.substring(1))
                                    .join(' ');
                                
                                return Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        displayKey,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        value is List 
                                            ? (value as List).join(", ")
                                            : value.toString(),
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
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

                      Row(
                        children: [
                          Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            formatTimestamp(action["timestamp"]),
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "${action["location"]}",
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
                            Icon(Icons.network_check, size: 16, color: infoColor),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "IP: ${action["ip_address"]} • Records Affected: ${action["affected_records"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                ),
                              ),
                            ),
                            QButton(
                              icon: Icons.info,
                              size: bs.sm,
                              onPressed: () {},
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
