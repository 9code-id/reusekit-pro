import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CshIntegrationCenterView extends StatefulWidget {
  const CshIntegrationCenterView({super.key});

  @override
  State<CshIntegrationCenterView> createState() => _CshIntegrationCenterViewState();
}

class _CshIntegrationCenterViewState extends State<CshIntegrationCenterView> {
  String searchQuery = "";
  String selectedCategory = "All Categories";
  String selectedStatus = "All Status";
  
  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "All Categories"},
    {"label": "CRM Systems", "value": "CRM Systems"},
    {"label": "Communication", "value": "Communication"},
    {"label": "Analytics", "value": "Analytics"},
    {"label": "Productivity", "value": "Productivity"},
    {"label": "E-commerce", "value": "E-commerce"},
    {"label": "Social Media", "value": "Social Media"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All Status"},
    {"label": "Connected", "value": "Connected"},
    {"label": "Available", "value": "Available"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Error", "value": "Error"},
  ];

  List<Map<String, dynamic>> integrations = [
    {
      "name": "Salesforce CRM",
      "description": "Sync customer data and tickets with Salesforce",
      "icon": "https://picsum.photos/60/60?random=1",
      "category": "CRM Systems",
      "status": "Connected",
      "popularity": 95,
      "version": "2.4.1",
      "lastSync": "2 minutes ago",
      "features": ["Two-way sync", "Auto-create contacts", "Custom fields"],
      "pricing": "Premium"
    },
    {
      "name": "Slack Notifications",
      "description": "Get real-time notifications in Slack channels",
      "icon": "https://picsum.photos/60/60?random=2",
      "category": "Communication",
      "status": "Connected",
      "popularity": 89,
      "version": "1.8.3",
      "lastSync": "5 minutes ago",
      "features": ["Channel notifications", "Direct messages", "Custom alerts"],
      "pricing": "Free"
    },
    {
      "name": "Google Analytics",
      "description": "Track support interactions and customer behavior",
      "icon": "https://picsum.photos/60/60?random=3",
      "category": "Analytics",
      "status": "Available",
      "popularity": 78,
      "version": "3.1.0",
      "lastSync": null,
      "features": ["Event tracking", "Custom dimensions", "Goal conversion"],
      "pricing": "Free"
    },
    {
      "name": "Microsoft Teams",
      "description": "Collaborate with team members on support cases",
      "icon": "https://picsum.photos/60/60?random=4",
      "category": "Communication",
      "status": "Pending",
      "popularity": 82,
      "version": "2.0.1",
      "lastSync": null,
      "features": ["Team chat", "File sharing", "Video calls"],
      "pricing": "Premium"
    },
    {
      "name": "Shopify Store",
      "description": "Sync order data and customer information",
      "icon": "https://picsum.photos/60/60?random=5",
      "category": "E-commerce",
      "status": "Connected",
      "popularity": 71,
      "version": "1.5.2",
      "lastSync": "1 hour ago",
      "features": ["Order sync", "Customer profiles", "Product catalog"],
      "pricing": "Premium"
    },
    {
      "name": "Twitter API",
      "description": "Monitor and respond to social media mentions",
      "icon": "https://picsum.photos/60/60?random=6",
      "category": "Social Media",
      "status": "Error",
      "popularity": 64,
      "version": "1.2.8",
      "lastSync": "2 days ago",
      "features": ["Mention tracking", "Auto-responses", "Sentiment analysis"],
      "pricing": "Premium"
    },
    {
      "name": "Jira Service Desk",
      "description": "Create and track issues in Jira from support tickets",
      "icon": "https://picsum.photos/60/60?random=7",
      "category": "Productivity",
      "status": "Available",
      "popularity": 87,
      "version": "2.3.4",
      "lastSync": null,
      "features": ["Issue creation", "Status sync", "Custom workflows"],
      "pricing": "Premium"
    },
    {
      "name": "Zoom Meetings",
      "description": "Schedule and join video calls for complex issues",
      "icon": "https://picsum.photos/60/60?random=8",
      "category": "Communication",
      "status": "Available",
      "popularity": 76,
      "version": "1.9.0",
      "lastSync": null,
      "features": ["Meeting scheduling", "Screen sharing", "Recording"],
      "pricing": "Free"
    },
  ];

  List<Map<String, dynamic>> recentActivity = [
    {
      "integration": "Salesforce CRM",
      "action": "Data synchronized",
      "timestamp": "2 minutes ago",
      "status": "success",
      "details": "142 contacts updated"
    },
    {
      "integration": "Slack Notifications",
      "action": "Alert sent",
      "timestamp": "15 minutes ago",
      "status": "success",
      "details": "High priority ticket notification"
    },
    {
      "integration": "Shopify Store",
      "action": "Order data synced",
      "timestamp": "1 hour ago",
      "status": "success",
      "details": "23 new orders imported"
    },
    {
      "integration": "Twitter API",
      "action": "Sync failed",
      "timestamp": "2 hours ago",
      "status": "error",
      "details": "Authentication error - token expired"
    },
    {
      "integration": "Microsoft Teams",
      "action": "Setup initiated",
      "timestamp": "3 hours ago",
      "status": "pending",
      "details": "Waiting for admin approval"
    },
  ];

  List<Map<String, dynamic>> connectionStats = [
    {
      "title": "Active Integrations",
      "value": 4,
      "total": 8,
      "color": successColor,
      "icon": Icons.link,
    },
    {
      "title": "Data Synced Today",
      "value": 1247,
      "total": null,
      "color": primaryColor,
      "icon": Icons.sync,
    },
    {
      "title": "API Calls (24h)",
      "value": 15847,
      "total": 20000,
      "color": infoColor,
      "icon": Icons.api,
    },
    {
      "title": "Error Rate",
      "value": 2.1,
      "total": null,
      "color": warningColor,
      "icon": Icons.warning,
      "unit": "%"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Integration Center"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              ss("New integration setup started");
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              ss("Integration settings opened");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Connection Stats
            Text(
              "Integration Overview",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.all(0),
              minItemWidth: 200,
              children: connectionStats.map((stat) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (stat["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              stat["icon"] as IconData,
                              size: 20,
                              color: stat["color"] as Color,
                            ),
                          ),
                          Spacer(),
                          if (stat["total"] != null)
                            Text(
                              "/${stat["total"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                        ],
                      ),
                      Text(
                        "${stat["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${stat["value"]}${stat["unit"] ?? ""}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      if (stat["total"] != null)
                        LinearProgressIndicator(
                          value: (stat["value"] as num) / (stat["total"] as num),
                          backgroundColor: disabledOutlineBorderColor,
                          valueColor: AlwaysStoppedAnimation(stat["color"] as Color),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Browse Integrations",
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
                        child: QTextField(
                          label: "Search integrations...",
                          value: searchQuery,
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      QButton(
                        icon: Icons.search,
                        size: bs.sm,
                        onPressed: () {
                          ss("Search performed");
                        },
                      ),
                    ],
                  ),
                  Row(
                    spacing: spSm,
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
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statusOptions,
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

            // Available Integrations
            Text(
              "Available Integrations",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: integrations.map((integration) {
                  int index = integrations.indexOf(integration);
                  Color statusColor = integration["status"] == "Connected"
                      ? successColor
                      : integration["status"] == "Available"
                          ? primaryColor
                          : integration["status"] == "Pending"
                              ? warningColor
                              : dangerColor;

                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: index < integrations.length - 1
                            ? BorderSide(
                                color: disabledOutlineBorderColor,
                                width: 1,
                              )
                            : BorderSide.none,
                      ),
                    ),
                    child: Row(
                      spacing: spSm,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusXs),
                            image: DecorationImage(
                              image: NetworkImage("${integration["icon"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            spacing: spXs,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${integration["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: statusColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${integration["status"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: statusColor,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: integration["pricing"] == "Free"
                                          ? successColor.withAlpha(20)
                                          : primaryColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${integration["pricing"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: integration["pricing"] == "Free"
                                            ? successColor
                                            : primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${integration["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${integration["category"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(
                                    Icons.star,
                                    size: 14,
                                    color: warningColor,
                                  ),
                                  Text(
                                    "${integration["popularity"]}%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: warningColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "v${integration["version"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  if (integration["lastSync"] != null) ...[
                                    SizedBox(width: spSm),
                                    Text(
                                      "Last sync: ${integration["lastSync"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: successColor,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              QHorizontalScroll(
                                children: (integration["features"] as List<String>).map((feature) {
                                  return Container(
                                    margin: EdgeInsets.only(right: spXs),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: infoColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      feature,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: infoColor,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          spacing: spXs,
                          children: [
                            if (integration["status"] == "Connected")
                              QButton(
                                icon: Icons.settings,
                                size: bs.sm,
                                onPressed: () {
                                  ss("Configure ${integration["name"]}");
                                },
                              )
                            else if (integration["status"] == "Available")
                              QButton(
                                label: "Connect",
                                size: bs.sm,
                                onPressed: () {
                                  ss("Connecting to ${integration["name"]}");
                                },
                              )
                            else if (integration["status"] == "Pending")
                              QButton(
                                icon: Icons.hourglass_empty,
                                size: bs.sm,
                                onPressed: () {
                                  si("Integration pending approval");
                                },
                              )
                            else
                              QButton(
                                label: "Retry",
                                size: bs.sm,
                                onPressed: () {
                                  ss("Retrying ${integration["name"]} connection");
                                },
                              ),
                            QButton(
                              icon: Icons.info_outline,
                              size: bs.sm,
                              onPressed: () {
                                ss("View ${integration["name"]} details");
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            // Recent Activity
            Text(
              "Recent Activity",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: recentActivity.map((activity) {
                  int index = recentActivity.indexOf(activity);
                  Color statusColor = activity["status"] == "success"
                      ? successColor
                      : activity["status"] == "error"
                          ? dangerColor
                          : warningColor;

                  IconData statusIcon = activity["status"] == "success"
                      ? Icons.check_circle
                      : activity["status"] == "error"
                          ? Icons.error
                          : Icons.schedule;

                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: index < recentActivity.length - 1
                            ? BorderSide(
                                color: disabledOutlineBorderColor,
                                width: 1,
                              )
                            : BorderSide.none,
                      ),
                    ),
                    child: Row(
                      spacing: spSm,
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            statusIcon,
                            size: 16,
                            color: statusColor,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${activity["integration"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${activity["timestamp"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${activity["action"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: statusColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${activity["details"]}",
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
                }).toList(),
              ),
            ),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Add Integration",
                    icon: Icons.add,
                    size: bs.md,
                    onPressed: () {
                      ss("New integration wizard opened");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Sync All",
                    icon: Icons.sync,
                    size: bs.md,
                    onPressed: () {
                      ss("Syncing all connected integrations");
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
}
