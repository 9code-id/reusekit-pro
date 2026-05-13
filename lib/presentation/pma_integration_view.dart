import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaIntegrationView extends StatefulWidget {
  const PmaIntegrationView({super.key});

  @override
  State<PmaIntegrationView> createState() => _PmaIntegrationViewState();
}

class _PmaIntegrationViewState extends State<PmaIntegrationView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedStatus = "All";

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Communication", "value": "Communication"},
    {"label": "Cloud Storage", "value": "Cloud Storage"},
    {"label": "Development", "value": "Development"},
    {"label": "Analytics", "value": "Analytics"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Finance", "value": "Finance"},
  ];

  List<Map<String, dynamic>> statuses = [
    {"label": "All", "value": "All"},
    {"label": "Connected", "value": "Connected"},
    {"label": "Disconnected", "value": "Disconnected"},
    {"label": "Error", "value": "Error"},
    {"label": "Pending", "value": "Pending"},
  ];

  List<Map<String, dynamic>> integrations = [
    {
      "id": 1,
      "name": "Slack",
      "description": "Team communication and collaboration",
      "category": "Communication",
      "status": "Connected",
      "icon": Icons.chat,
      "color": "success",
      "lastSync": "2024-01-22 10:30",
      "syncFrequency": "Real-time",
      "dataUsage": "2.3 GB",
      "features": ["Notifications", "File Sharing", "Bot Integration"],
      "apiVersion": "v2.1",
      "connectionHealth": 98,
      "isActive": true,
    },
    {
      "id": 2,
      "name": "Google Drive",
      "description": "Cloud storage and file management",
      "category": "Cloud Storage",
      "status": "Connected",
      "icon": Icons.cloud,
      "color": "info",
      "lastSync": "2024-01-22 09:45",
      "syncFrequency": "Every 5 min",
      "dataUsage": "15.7 GB",
      "features": ["File Sync", "Document Sharing", "Version Control"],
      "apiVersion": "v3.0",
      "connectionHealth": 95,
      "isActive": true,
    },
    {
      "id": 3,
      "name": "GitHub",
      "description": "Version control and code collaboration",
      "category": "Development",
      "status": "Connected",
      "icon": Icons.code,
      "color": "primary",
      "lastSync": "2024-01-22 11:15",
      "syncFrequency": "On commit",
      "dataUsage": "890 MB",
      "features": ["Repository Sync", "Issue Tracking", "PR Management"],
      "apiVersion": "v4.0",
      "connectionHealth": 92,
      "isActive": true,
    },
    {
      "id": 4,
      "name": "Google Analytics",
      "description": "Website and app analytics tracking",
      "category": "Analytics",
      "status": "Error",
      "icon": Icons.analytics,
      "color": "danger",
      "lastSync": "2024-01-21 14:20",
      "syncFrequency": "Hourly",
      "dataUsage": "456 MB",
      "features": ["Traffic Analysis", "Goal Tracking", "Custom Reports"],
      "apiVersion": "v4.0",
      "connectionHealth": 0,
      "isActive": false,
    },
    {
      "id": 5,
      "name": "Mailchimp",
      "description": "Email marketing and automation",
      "category": "Marketing",
      "status": "Disconnected",
      "icon": Icons.email,
      "color": "warning",
      "lastSync": "2024-01-20 16:30",
      "syncFrequency": "Daily",
      "dataUsage": "123 MB",
      "features": ["Email Campaigns", "Audience Management", "Automation"],
      "apiVersion": "v3.0",
      "connectionHealth": 0,
      "isActive": false,
    },
    {
      "id": 6,
      "name": "Stripe",
      "description": "Payment processing and financial management",
      "category": "Finance",
      "status": "Connected",
      "icon": Icons.payment,
      "color": "secondary",
      "lastSync": "2024-01-22 08:00",
      "syncFrequency": "Real-time",
      "dataUsage": "234 MB",
      "features": ["Payment Processing", "Invoice Management", "Analytics"],
      "apiVersion": "v1.0",
      "connectionHealth": 97,
      "isActive": true,
    },
    {
      "id": 7,
      "name": "Jira",
      "description": "Project management and issue tracking",
      "category": "Development",
      "status": "Pending",
      "icon": Icons.task,
      "color": "warning",
      "lastSync": "Never",
      "syncFrequency": "Every 15 min",
      "dataUsage": "0 MB",
      "features": ["Issue Tracking", "Project Management", "Reporting"],
      "apiVersion": "v3.0",
      "connectionHealth": 0,
      "isActive": false,
    },
    {
      "id": 8,
      "name": "Zoom",
      "description": "Video conferencing and meetings",
      "category": "Communication",
      "status": "Connected",
      "icon": Icons.video_call,
      "color": "info",
      "lastSync": "2024-01-22 07:30",
      "syncFrequency": "After meetings",
      "dataUsage": "567 MB",
      "features": ["Meeting Management", "Recording Sync", "Calendar Integration"],
      "apiVersion": "v2.0",
      "connectionHealth": 89,
      "isActive": true,
    },
  ];

  List<Map<String, dynamic>> get filteredIntegrations {
    return integrations.where((integration) {
      bool matchesSearch = searchQuery.isEmpty ||
          integration["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          integration["description"].toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || integration["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "All" || integration["status"] == selectedStatus;
      
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Connected":
        return successColor;
      case "Disconnected":
        return warningColor;
      case "Error":
        return dangerColor;
      case "Pending":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTemplateColor(String colorName) {
    switch (colorName) {
      case "primary":
        return primaryColor;
      case "success":
        return successColor;
      case "info":
        return infoColor;
      case "warning":
        return warningColor;
      case "danger":
        return dangerColor;
      case "secondary":
        return secondaryColor;
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    int connectedCount = integrations.where((i) => i["status"] == "Connected").length;
    int totalIntegrations = integrations.length;
    double avgHealth = integrations.where((i) => i["status"] == "Connected")
        .map((i) => i["connectionHealth"] as int)
        .fold(0, (a, b) => a + b) / connectedCount;

    return Scaffold(
      appBar: AppBar(
        title: Text("Integrations"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QTextField(
                    label: "Search Integrations",
                    value: searchQuery,
                    hint: "Search by name or description...",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: categories,
                          value: selectedCategory,
                          onChanged: (value, label) {
                            selectedCategory = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statuses,
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Stats Overview
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "$connectedCount/$totalIntegrations",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Connected",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${avgHealth.round()}%",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Avg Health",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${(integrations.where((i) => i["status"] == "Connected").map((i) => double.tryParse(i["dataUsage"].toString().replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0).fold(0.0, (a, b) => a + b)).toStringAsFixed(1)} GB",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Data Usage",
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
            ),

            // Integration Grid
            if (filteredIntegrations.isNotEmpty)
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredIntegrations.map((integration) {
                  Color templateColor = _getTemplateColor(integration["color"]);
                  Color statusColor = _getStatusColor(integration["status"]);
                  
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Integration Header
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: templateColor.withAlpha(20),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusSm),
                              topRight: Radius.circular(radiusSm),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: templateColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(
                                  integration["icon"],
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${integration["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: templateColor,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: statusColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${integration["status"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: statusColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Integration Content
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            spacing: spXs,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Description
                              Text(
                                "${integration["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              // Category
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${integration["category"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: primaryColor,
                                  ),
                                ),
                              ),

                              // Connection Health (if connected)
                              if (integration["status"] == "Connected")
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Health: ${integration["connectionHealth"]}%",
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: statusColor,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.health_and_safety,
                                          size: 12,
                                          color: statusColor,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    LinearProgressIndicator(
                                      value: (integration["connectionHealth"] as int) / 100,
                                      backgroundColor: statusColor.withAlpha(30),
                                      valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                                      minHeight: 3,
                                    ),
                                  ],
                                ),

                              // Sync Info
                              Row(
                                children: [
                                  Icon(
                                    Icons.sync,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      "${integration["syncFrequency"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${integration["dataUsage"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: infoColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),

                              // Last Sync
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      "Last sync: ${integration["lastSync"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${integration["apiVersion"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),

                              // Features
                              Text(
                                "Features",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Wrap(
                                spacing: 4,
                                runSpacing: 4,
                                children: (integration["features"] as List).map((feature) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: secondaryColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "$feature",
                                      style: TextStyle(
                                        fontSize: 9,
                                        color: secondaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),

                              // Action Buttons
                              SizedBox(height: spXs),
                              if (integration["status"] == "Connected")
                                Row(
                                  children: [
                                    Expanded(
                                      child: QButton(
                                        label: "Configure",
                                        size: bs.sm,
                                        onPressed: () {},
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    QButton(
                                      icon: Icons.pause,
                                      size: bs.sm,
                                      onPressed: () {},
                                    ),
                                    SizedBox(width: spXs),
                                    QButton(
                                      icon: Icons.sync,
                                      size: bs.sm,
                                      onPressed: () {},
                                    ),
                                  ],
                                )
                              else if (integration["status"] == "Disconnected" || integration["status"] == "Error")
                                Container(
                                  width: double.infinity,
                                  child: QButton(
                                    label: "Reconnect",
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                )
                              else if (integration["status"] == "Pending")
                                Container(
                                  width: double.infinity,
                                  child: QButton(
                                    label: "Complete Setup",
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              )
            else
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No integrations found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search criteria",
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
    );
  }
}
