import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmIntegrationCenterView extends StatefulWidget {
  const CrmIntegrationCenterView({super.key});

  @override
  State<CrmIntegrationCenterView> createState() => _CrmIntegrationCenterViewState();
}

class _CrmIntegrationCenterViewState extends State<CrmIntegrationCenterView> {
  String searchQuery = "";
  String selectedCategory = "All";
  bool showConnectedOnly = false;

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "all"},
    {"label": "Email Marketing", "value": "email"},
    {"label": "Analytics", "value": "analytics"},
    {"label": "Productivity", "value": "productivity"},
    {"label": "Communication", "value": "communication"},
    {"label": "E-commerce", "value": "ecommerce"},
    {"label": "Social Media", "value": "social"},
  ];

  List<Map<String, dynamic>> integrations = [
    {
      "id": "1",
      "name": "Mailchimp",
      "description": "Email marketing automation and campaigns",
      "category": "Email Marketing",
      "icon": "https://picsum.photos/80/80?random=1",
      "connected": true,
      "rating": 4.8,
      "reviews": 1250,
      "features": ["Email Campaigns", "Automation", "Analytics", "A/B Testing"],
      "pricing": "Free - \$299/month",
      "lastSync": "2024-12-19 14:30",
    },
    {
      "id": "2",
      "name": "Google Analytics",
      "description": "Web analytics and reporting platform",
      "category": "Analytics",
      "icon": "https://picsum.photos/80/80?random=2",
      "connected": true,
      "rating": 4.6,
      "reviews": 2180,
      "features": ["Traffic Analysis", "Goal Tracking", "Custom Reports", "Real-time Data"],
      "pricing": "Free - \$150,000/year",
      "lastSync": "2024-12-19 13:45",
    },
    {
      "id": "3",
      "name": "Slack",
      "description": "Team communication and collaboration",
      "category": "Communication",
      "icon": "https://picsum.photos/80/80?random=3",
      "connected": false,
      "rating": 4.5,
      "reviews": 890,
      "features": ["Team Chat", "File Sharing", "Video Calls", "App Integrations"],
      "pricing": "Free - \$15/user/month",
      "lastSync": null,
    },
    {
      "id": "4",
      "name": "HubSpot",
      "description": "Marketing, sales, and service automation",
      "category": "Email Marketing",
      "icon": "https://picsum.photos/80/80?random=4",
      "connected": true,
      "rating": 4.7,
      "reviews": 1670,
      "features": ["Lead Tracking", "Email Sequences", "Landing Pages", "CRM"],
      "pricing": "Free - \$3,200/month",
      "lastSync": "2024-12-19 12:15",
    },
    {
      "id": "5",
      "name": "Zapier",
      "description": "Automation workflows between apps",
      "category": "Productivity",
      "icon": "https://picsum.photos/80/80?random=5",
      "connected": false,
      "rating": 4.4,
      "reviews": 756,
      "features": ["Workflow Automation", "Multi-app Integration", "Custom Triggers", "Data Sync"],
      "pricing": "Free - \$799/month",
      "lastSync": null,
    },
    {
      "id": "6",
      "name": "Shopify",
      "description": "E-commerce platform integration",
      "category": "E-commerce",
      "icon": "https://picsum.photos/80/80?random=6",
      "connected": true,
      "rating": 4.6,
      "reviews": 1340,
      "features": ["Order Sync", "Customer Data", "Inventory Tracking", "Sales Analytics"],
      "pricing": "\$29 - \$2,000/month",
      "lastSync": "2024-12-19 11:20",
    },
  ];

  int currentTab = 0;

  List<Map<String, dynamic>> get filteredIntegrations {
    return integrations.where((integration) {
      bool matchesSearch = searchQuery.isEmpty ||
          (integration["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (integration["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || integration["category"] == selectedCategory;
      bool matchesConnection = !showConnectedOnly || integration["connected"] == true;
      
      return matchesSearch && matchesCategory && matchesConnection;
    }).toList();
  }

  List<Map<String, dynamic>> get connectedIntegrations {
    return integrations.where((integration) => integration["connected"] == true).toList();
  }

  void _toggleConnection(String id) {
    int index = integrations.indexWhere((i) => i["id"] == id);
    if (index != -1) {
      bool currentStatus = integrations[index]["connected"] as bool;
      integrations[index]["connected"] = !currentStatus;
      if (!currentStatus) {
        integrations[index]["lastSync"] = "2024-12-19 ${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}";
        ss("Integration connected successfully");
      } else {
        integrations[index]["lastSync"] = null;
        si("Integration disconnected");
      }
      setState(() {});
    }
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: primaryColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.integration_instructions, color: primaryColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Total Integrations",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${integrations.length}",
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
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: successColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: successColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Connected",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${connectedIntegrations.length}",
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
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: infoColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.sync, color: infoColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Data Synced",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "12.5K",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: warningColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.schedule, color: warningColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Last Sync",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "2 min ago",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Connected Integrations",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                if (connectedIntegrations.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spLg),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.integration_instructions,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "No integrations connected yet",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Browse available integrations to connect your favorite tools",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Column(
                    spacing: spSm,
                    children: connectedIntegrations.map((integration) {
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                          border: Border.all(color: successColor.withAlpha(30)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusSm),
                                image: DecorationImage(
                                  image: NetworkImage("${integration["icon"]}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${integration["name"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: successColor.withAlpha(10),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.check_circle,
                                              size: 12,
                                              color: successColor,
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "Connected",
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
                                  SizedBox(height: spXs),
                                  Text(
                                    "${integration["category"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  if (integration["lastSync"] != null) ...[
                                    SizedBox(height: spXs),
                                    Text(
                                      "Last sync: ${integration["lastSync"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledColor,
                                      ),
                                    ),
                                  ],
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
        ],
      ),
    );
  }

  Widget _buildBrowseTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search Integrations",
                  value: searchQuery,
                  hint: "Search by name or description",
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
                onPressed: () {},
              ),
            ],
          ),
          QCategoryPicker(
            label: "Category",
            items: categoryOptions,
            value: selectedCategory,
            onChanged: (index, label, value, item) {
              selectedCategory = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Show Connected Only",
                      "value": true,
                      "checked": showConnectedOnly,
                    }
                  ],
                  value: [
                    if (showConnectedOnly)
                      {
                        "label": "Show Connected Only",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    showConnectedOnly = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Available Integrations (${filteredIntegrations.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Column(
                  spacing: spSm,
                  children: filteredIntegrations.map((integration) {
                    bool isConnected = integration["connected"] as bool;
                    return Container(
                      padding: EdgeInsets.all(spMd),
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
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  image: DecorationImage(
                                    image: NetworkImage("${integration["icon"]}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${integration["name"]}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              size: 16,
                                              color: warningColor,
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "${(integration["rating"] as double).toStringAsFixed(1)}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: warningColor,
                                              ),
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "(${integration["reviews"]})",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${integration["description"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: infoColor.withAlpha(10),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "${integration["category"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: infoColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (integration["features"] as List<String>).map((feature) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  feature,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Pricing",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledColor,
                                    ),
                                  ),
                                  Text(
                                    "${integration["pricing"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              QButton(
                                label: isConnected ? "Disconnect" : "Connect",
                                size: bs.sm,
                                onPressed: () => _toggleConnection(integration["id"] as String),
                              ),
                            ],
                          ),
                          if (isConnected && integration["lastSync"] != null) ...[
                            SizedBox(height: spSm),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.sync,
                                    size: 16,
                                    color: successColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Last sync: ${integration["lastSync"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Integration Center",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Browse", icon: Icon(Icons.apps)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildBrowseTab(),
      ],
      onInit: (tabController) {},
    );
  }
}
