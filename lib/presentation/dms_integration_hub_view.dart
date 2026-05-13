import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsIntegrationHubView extends StatefulWidget {
  const DmsIntegrationHubView({super.key});

  @override
  State<DmsIntegrationHubView> createState() => _DmsIntegrationHubViewState();
}

class _DmsIntegrationHubViewState extends State<DmsIntegrationHubView> {
  int currentTab = 0;
  String searchQuery = "";

  final List<Map<String, dynamic>> availableIntegrations = [
    {
      "id": "salesforce",
      "name": "Salesforce",
      "description": "Sync documents with Salesforce CRM records",
      "category": "CRM",
      "icon": Icons.business_center,
      "status": "Available",
      "popularity": 4.8,
      "installs": 1250,
      "features": ["Document Sync", "Lead Attachments", "Contract Management"],
      "color": primaryColor,
    },
    {
      "id": "slack",
      "name": "Slack",
      "description": "Get document notifications in Slack channels",
      "category": "Communication",
      "icon": Icons.chat_bubble,
      "status": "Available",
      "popularity": 4.9,
      "installs": 2100,
      "features": ["Real-time Notifications", "File Sharing", "Channel Integration"],
      "color": successColor,
    },
    {
      "id": "dropbox",
      "name": "Dropbox",
      "description": "Two-way sync with Dropbox cloud storage",
      "category": "Storage",
      "icon": Icons.cloud_sync,
      "status": "Available",
      "popularity": 4.7,
      "installs": 980,
      "features": ["Auto Sync", "Version Control", "Backup"],
      "color": infoColor,
    },
    {
      "id": "microsoft365",
      "name": "Microsoft 365",
      "description": "Integrate with Office 365 and SharePoint",
      "category": "Productivity",
      "icon": Icons.work,
      "status": "Available",
      "popularity": 4.6,
      "installs": 1750,
      "features": ["Office Integration", "SharePoint Sync", "Teams Collaboration"],
      "color": warningColor,
    },
    {
      "id": "zapier",
      "name": "Zapier",
      "description": "Connect to 3000+ apps with automation",
      "category": "Automation",
      "icon": Icons.auto_fix_high,
      "status": "Available",
      "popularity": 4.5,
      "installs": 650,
      "features": ["Workflow Automation", "Multi-app Integration", "Custom Triggers"],
      "color": primaryColor,
    },
    {
      "id": "docusign",
      "name": "DocuSign",
      "description": "Digital signature integration for documents",
      "category": "Legal",
      "icon": Icons.draw,
      "status": "Available",
      "popularity": 4.9,
      "installs": 890,
      "features": ["E-Signatures", "Agreement Workflow", "Legal Compliance"],
      "color": dangerColor,
    },
  ];

  final List<Map<String, dynamic>> installedIntegrations = [
    {
      "id": "google_drive",
      "name": "Google Drive",
      "description": "Sync documents with Google Drive",
      "category": "Storage",
      "icon": Icons.cloud_done,
      "status": "Connected",
      "lastSync": "2024-06-19 11:30",
      "syncedFiles": 1247,
      "color": successColor,
      "health": "Excellent",
    },
    {
      "id": "outlook",
      "name": "Microsoft Outlook",
      "description": "Email document attachments integration",
      "category": "Communication",
      "icon": Icons.email,
      "status": "Connected",
      "lastSync": "2024-06-19 10:45",
      "syncedFiles": 567,
      "color": primaryColor,
      "health": "Good",
    },
    {
      "id": "jira",
      "name": "Atlassian Jira",
      "description": "Attach documents to Jira tickets",
      "category": "Project Management",
      "icon": Icons.assignment,
      "status": "Error",
      "lastSync": "2024-06-18 16:20",
      "syncedFiles": 234,
      "color": dangerColor,
      "health": "Needs Attention",
    },
  ];

  final List<String> categories = ["All", "CRM", "Communication", "Storage", "Productivity", "Automation", "Legal", "Project Management"];

  String selectedCategory = "All";

  List<Map<String, dynamic>> get filteredIntegrations {
    return availableIntegrations.where((integration) {
      final matchesSearch = (integration["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
                           (integration["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory = selectedCategory == "All" || integration["category"] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Integration Hub",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Available", icon: Icon(Icons.store)),
        Tab(text: "Installed", icon: Icon(Icons.check_circle)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildAvailableTab(),
        _buildInstalledTab(),
        _buildSettingsTab(),
      ],
    );
  }

  Widget _buildAvailableTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search and Filter
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
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () {
                  _showFilterDialog();
                },
              ),
            ],
          ),
          SizedBox(height: spSm),

          // Category Filter
          QHorizontalScroll(
            children: categories.map((category) {
              final isSelected = selectedCategory == category;
              return GestureDetector(
                onTap: () {
                  selectedCategory = category;
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                    ),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? Colors.white : disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spMd),

          // Integration Stats
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Available",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${availableIntegrations.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
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
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Downloads",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${(availableIntegrations.fold(0, (sum, integration) => sum + (integration["installs"] as int)) / 1000).toStringAsFixed(1)}K",
                        style: TextStyle(
                          fontSize: 24,
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
          SizedBox(height: spMd),

          // Integrations Grid
          Text(
            "Available Integrations (${filteredIntegrations.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),

          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: filteredIntegrations.map((integration) {
              return Container(
                padding: EdgeInsets.all(spSm),
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
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: (integration["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            integration["icon"] as IconData,
                            color: integration["color"] as Color,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${integration["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    Text(
                      "${integration["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Icon(Icons.star, color: warningColor, size: 16),
                        SizedBox(width: 4),
                        Text(
                          "${integration["popularity"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${integration["installs"]} installs",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                      decoration: BoxDecoration(
                        color: (integration["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${integration["category"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: integration["color"] as Color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    // Features
                    ...(integration["features"] as List<String>).take(2).map((feature) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: Row(
                          children: [
                            Icon(Icons.check, color: successColor, size: 12),
                            SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                feature,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    SizedBox(height: spSm),
                    
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Install",
                        size: bs.sm,
                        onPressed: () {
                          _installIntegration(integration["id"] as String);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInstalledTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Installed Integrations (${installedIntegrations.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),

          ...installedIntegrations.map((integration) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: integration["color"] as Color,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: (integration["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          integration["icon"] as IconData,
                          color: integration["color"] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${integration["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${integration["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getStatusColor(integration["status"] as String).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${integration["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: _getStatusColor(integration["status"] as String),
                            fontWeight: FontWeight.w600,
                          ),
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
                              "Last Sync: ${integration["lastSync"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Files Synced: ${integration["syncedFiles"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getHealthColor(integration["health"] as String).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${integration["health"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: _getHealthColor(integration["health"] as String),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Configure",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('ConfigureIntegrationView', arguments: integration)
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.sync,
                        size: bs.sm,
                        onPressed: () {
                          _syncIntegration(integration["id"] as String);
                        },
                      ),
                      SizedBox(width: spXs),
                      QButton(
                        icon: Icons.settings,
                        size: bs.sm,
                        onPressed: () {
                          // navigateTo('IntegrationSettingsView', arguments: integration)
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Integration Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "General Settings",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                
                _buildSettingItem("Auto-sync enabled", true),
                _buildSettingItem("Real-time notifications", true),
                _buildSettingItem("Background sync", false),
                _buildSettingItem("Error notifications", true),
                _buildSettingItem("Weekly reports", false),
              ],
            ),
          ),
          SizedBox(height: spMd),

          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Security Settings",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                
                _buildSettingItem("Require authentication", true),
                _buildSettingItem("Encrypt data in transit", true),
                _buildSettingItem("Log integration activities", true),
                _buildSettingItem("Two-factor authentication", false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String title, bool value) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: (newValue) {
              // Handle setting change
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Connected":
        return successColor;
      case "Error":
        return dangerColor;
      case "Disconnected":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getHealthColor(String health) {
    switch (health) {
      case "Excellent":
        return successColor;
      case "Good":
        return primaryColor;
      case "Needs Attention":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showFilterDialog() {
    si("Filter dialog would be shown here");
  }

  void _installIntegration(String integrationId) {
    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Integration installed successfully");
    });
  }

  void _syncIntegration(String integrationId) {
    showLoading();
    Future.delayed(Duration(seconds: 1), () {
      hideLoading();
      ss("Integration synced successfully");
    });
  }
}
