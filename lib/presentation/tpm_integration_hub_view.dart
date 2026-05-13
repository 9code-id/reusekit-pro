import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmIntegrationHubView extends StatefulWidget {
  const TpmIntegrationHubView({super.key});

  @override
  State<TpmIntegrationHubView> createState() => _TpmIntegrationHubViewState();
}

class _TpmIntegrationHubViewState extends State<TpmIntegrationHubView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedCategory = "All";
  
  List<String> categories = [
    "All",
    "Communication",
    "Development",
    "Productivity",
    "Analytics",
    "Storage",
    "Security"
  ];

  List<Map<String, dynamic>> integrations = [
    {
      "id": "slack-001",
      "name": "Slack",
      "description": "Team communication and collaboration platform",
      "category": "Communication",
      "status": "connected",
      "icon": "💬",
      "lastSync": DateTime.now().subtract(Duration(minutes: 15)),
      "isActive": true,
      "webhookUrl": "https://hooks.slack.com/services/...",
      "permissions": ["read", "write", "admin"],
      "connectedBy": "John Smith",
      "connectedAt": DateTime.now().subtract(Duration(days: 5)),
      "syncFrequency": "Real-time",
      "dataPoints": 1247,
      "errorCount": 0
    },
    {
      "id": "github-002",
      "name": "GitHub",
      "description": "Code repository and version control system",
      "category": "Development",
      "status": "connected",
      "icon": "🐙",
      "lastSync": DateTime.now().subtract(Duration(hours: 2)),
      "isActive": true,
      "webhookUrl": "https://api.github.com/repos/...",
      "permissions": ["read", "write"],
      "connectedBy": "Sarah Johnson",
      "connectedAt": DateTime.now().subtract(Duration(days: 12)),
      "syncFrequency": "Every 15 minutes",
      "dataPoints": 892,
      "errorCount": 2
    },
    {
      "id": "jira-003",
      "name": "Jira",
      "description": "Project management and issue tracking",
      "category": "Productivity",
      "status": "error",
      "icon": "📋",
      "lastSync": DateTime.now().subtract(Duration(hours: 6)),
      "isActive": false,
      "webhookUrl": "https://company.atlassian.net/...",
      "permissions": ["read"],
      "connectedBy": "Mike Davis",
      "connectedAt": DateTime.now().subtract(Duration(days: 8)),
      "syncFrequency": "Every 30 minutes",
      "dataPoints": 654,
      "errorCount": 5
    },
    {
      "id": "google-004",
      "name": "Google Analytics",
      "description": "Web analytics and performance tracking",
      "category": "Analytics",
      "status": "connected",
      "icon": "📊",
      "lastSync": DateTime.now().subtract(Duration(minutes: 45)),
      "isActive": true,
      "webhookUrl": "https://analytics.google.com/...",
      "permissions": ["read"],
      "connectedBy": "Emma Wilson",
      "connectedAt": DateTime.now().subtract(Duration(days: 3)),
      "syncFrequency": "Every hour",
      "dataPoints": 2341,
      "errorCount": 0
    },
    {
      "id": "dropbox-005",
      "name": "Dropbox",
      "description": "Cloud storage and file synchronization",
      "category": "Storage",
      "status": "pending",
      "icon": "📦",
      "lastSync": null,
      "isActive": false,
      "webhookUrl": "https://api.dropboxapi.com/...",
      "permissions": ["read", "write"],
      "connectedBy": "Alex Chen",
      "connectedAt": DateTime.now().subtract(Duration(hours: 1)),
      "syncFrequency": "Every 6 hours",
      "dataPoints": 0,
      "errorCount": 0
    },
    {
      "id": "okta-006",
      "name": "Okta",
      "description": "Identity and access management",
      "category": "Security",
      "status": "connected",
      "icon": "🔐",
      "lastSync": DateTime.now().subtract(Duration(minutes: 5)),
      "isActive": true,
      "webhookUrl": "https://company.okta.com/...",
      "permissions": ["read", "admin"],
      "connectedBy": "Lisa Anderson",
      "connectedAt": DateTime.now().subtract(Duration(days: 15)),
      "syncFrequency": "Real-time",
      "dataPoints": 456,
      "errorCount": 0
    }
  ];

  List<Map<String, dynamic>> availableIntegrations = [
    {
      "name": "Microsoft Teams",
      "description": "Unified communication and collaboration platform",
      "category": "Communication",
      "icon": "💼",
      "isPopular": true,
      "difficulty": "Easy",
      "estimatedTime": "5 minutes"
    },
    {
      "name": "Trello",
      "description": "Visual project management tool",
      "category": "Productivity",
      "icon": "📌",
      "isPopular": true,
      "difficulty": "Easy",
      "estimatedTime": "3 minutes"
    },
    {
      "name": "AWS S3",
      "description": "Cloud object storage service",
      "category": "Storage",
      "icon": "☁️",
      "isPopular": false,
      "difficulty": "Medium",
      "estimatedTime": "15 minutes"
    },
    {
      "name": "Salesforce",
      "description": "Customer relationship management platform",
      "category": "Productivity",
      "icon": "🏢",
      "isPopular": true,
      "difficulty": "Hard",
      "estimatedTime": "30 minutes"
    }
  ];

  List<Map<String, dynamic>> get filteredIntegrations {
    return integrations.where((integration) {
      bool matchesSearch = integration["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          integration["description"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || integration["category"] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  List<Map<String, dynamic>> get filteredAvailableIntegrations {
    return availableIntegrations.where((integration) {
      bool matchesSearch = integration["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          integration["description"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || integration["category"] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'connected':
        return successColor;
      case 'error':
        return dangerColor;
      case 'pending':
        return warningColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'connected':
        return 'Connected';
      case 'error':
        return 'Error';
      case 'pending':
        return 'Pending';
      default:
        return 'Disconnected';
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Easy':
        return successColor;
      case 'Medium':
        return warningColor;
      case 'Hard':
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Integration Hub",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Active", icon: Icon(Icons.link)),
        Tab(text: "Available", icon: Icon(Icons.add_link)),
      ],
      tabChildren: [
        _buildActiveIntegrationsTab(),
        _buildAvailableIntegrationsTab(),
      ],
    );
  }

  Widget _buildActiveIntegrationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filter Section
          Row(
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
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),

          // Category Filter
          QCategoryPicker(
            items: categories.map((category) => {
              "label": category,
              "value": category,
            }).toList(),
            value: selectedCategory,
            onChanged: (index, label, value, item) {
              selectedCategory = value;
              setState(() {});
            },
          ),

          // Integration Stats
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Active",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${integrations.where((i) => i["isActive"]).length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Errors",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${integrations.map((i) => i["errorCount"] as int).reduce((a, b) => a + b)}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Data Points",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${((integrations.map((i) => i["dataPoints"] as int).reduce((a, b) => a + b)) / 1000).toStringAsFixed(1)}K",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Active Integrations List
          ...filteredIntegrations.map((integration) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Center(
                        child: Text(
                          "${integration["icon"]}",
                          style: TextStyle(fontSize: 24),
                        ),
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
                                  "${integration["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(integration["status"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  _getStatusText(integration["status"]),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: _getStatusColor(integration["status"]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${integration["description"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.sync,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      integration["lastSync"] != null 
                          ? "Last sync: ${integration["lastSync"].timeAgo}"
                          : "Never synced",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${integration["dataPoints"]} data points",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sync Frequency",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${integration["syncFrequency"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Connected By",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${integration["connectedBy"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if ((integration["errorCount"] as int) > 0) ...[
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                      border: Border.all(
                        color: dangerColor.withAlpha(30),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 16,
                          color: dangerColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${integration["errorCount"]} sync errors detected",
                          style: TextStyle(
                            fontSize: 12,
                            color: dangerColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                SizedBox(height: spSm),
                Row(
                  children: [
                    QButton(
                      label: "Configure",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      label: "Test Connection",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.more_vert,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildAvailableIntegrationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filter Section
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search available integrations...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),

          // Category Filter
          QCategoryPicker(
            items: categories.map((category) => {
              "label": category,
              "value": category,
            }).toList(),
            value: selectedCategory,
            onChanged: (index, label, value, item) {
              selectedCategory = value;
              setState(() {});
            },
          ),

          // Popular Integrations Section
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(
                color: primaryColor.withAlpha(30),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spXs),
                Text(
                  "Popular integrations are marked with a star",
                  style: TextStyle(
                    fontSize: 13,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Available Integrations List
          ...filteredAvailableIntegrations.map((integration) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Center(
                        child: Text(
                          "${integration["icon"]}",
                          style: TextStyle(fontSize: 24),
                        ),
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
                                  "${integration["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              if (integration["isPopular"] == true)
                                Icon(
                                  Icons.star,
                                  color: warningColor,
                                  size: 18,
                                ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${integration["description"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: _getDifficultyColor(integration["difficulty"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${integration["difficulty"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: _getDifficultyColor(integration["difficulty"]),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(
                      Icons.schedule,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${integration["estimatedTime"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${integration["category"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    QButton(
                      label: "Connect",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      label: "View Details",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.info_outline,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
