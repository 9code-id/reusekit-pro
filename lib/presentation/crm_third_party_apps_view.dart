import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmThirdPartyAppsView extends StatefulWidget {
  const CrmThirdPartyAppsView({super.key});

  @override
  State<CrmThirdPartyAppsView> createState() => _CrmThirdPartyAppsViewState();
}

class _CrmThirdPartyAppsViewState extends State<CrmThirdPartyAppsView> {
  String searchQuery = "";
  String selectedCategory = "All";
  bool showInstalledOnly = false;

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "all"},
    {"label": "Sales", "value": "sales"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Analytics", "value": "analytics"},
    {"label": "Communication", "value": "communication"},
    {"label": "Productivity", "value": "productivity"},
    {"label": "Finance", "value": "finance"},
  ];

  List<Map<String, dynamic>> apps = [
    {
      "id": "1",
      "name": "Calendly",
      "description": "Schedule meetings automatically with calendar integration",
      "category": "Productivity",
      "developer": "Calendly Inc.",
      "version": "2.1.0",
      "icon": "https://picsum.photos/80/80?random=1",
      "installed": true,
      "rating": 4.8,
      "reviews": 2340,
      "price": "Free - \$12/month",
      "features": ["Calendar Sync", "Meeting Scheduling", "Email Reminders", "Team Scheduling"],
      "screenshots": [
        "https://picsum.photos/300/200?random=11",
        "https://picsum.photos/300/200?random=12",
      ],
      "installedDate": "2024-11-15",
      "lastUpdate": "2024-12-10",
    },
    {
      "id": "2",
      "name": "DocuSign",
      "description": "Electronic signature and document management solution",
      "category": "Productivity",
      "developer": "DocuSign Inc.",
      "version": "3.2.1",
      "icon": "https://picsum.photos/80/80?random=2",
      "installed": true,
      "rating": 4.6,
      "reviews": 1890,
      "price": "\$10 - \$45/month",
      "features": ["E-Signatures", "Document Templates", "Workflow Automation", "Audit Trail"],
      "screenshots": [
        "https://picsum.photos/300/200?random=21",
        "https://picsum.photos/300/200?random=22",
      ],
      "installedDate": "2024-10-20",
      "lastUpdate": "2024-12-05",
    },
    {
      "id": "3",
      "name": "Stripe",
      "description": "Payment processing and billing integration",
      "category": "Finance",
      "developer": "Stripe Inc.",
      "version": "4.1.2",
      "icon": "https://picsum.photos/80/80?random=3",
      "installed": false,
      "rating": 4.7,
      "reviews": 3240,
      "price": "2.9% + 30¢ per transaction",
      "features": ["Payment Processing", "Subscription Billing", "Invoice Management", "Financial Reporting"],
      "screenshots": [
        "https://picsum.photos/300/200?random=31",
        "https://picsum.photos/300/200?random=32",
      ],
      "installedDate": null,
      "lastUpdate": null,
    },
    {
      "id": "4",
      "name": "Zoom",
      "description": "Video conferencing and virtual meetings platform",
      "category": "Communication",
      "developer": "Zoom Video Communications",
      "version": "5.8.0",
      "icon": "https://picsum.photos/80/80?random=4",
      "installed": true,
      "rating": 4.5,
      "reviews": 4560,
      "price": "Free - \$19.99/month",
      "features": ["Video Calls", "Screen Sharing", "Recording", "Breakout Rooms"],
      "screenshots": [
        "https://picsum.photos/300/200?random=41",
        "https://picsum.photos/300/200?random=42",
      ],
      "installedDate": "2024-09-12",
      "lastUpdate": "2024-12-18",
    },
    {
      "id": "5",
      "name": "Salesforce",
      "description": "Advanced CRM and sales automation platform",
      "category": "Sales",
      "developer": "Salesforce Inc.",
      "version": "1.5.3",
      "icon": "https://picsum.photos/80/80?random=5",
      "installed": false,
      "rating": 4.4,
      "reviews": 5670,
      "price": "\$25 - \$300/month",
      "features": ["Lead Management", "Sales Pipeline", "Forecasting", "Einstein AI"],
      "screenshots": [
        "https://picsum.photos/300/200?random=51",
        "https://picsum.photos/300/200?random=52",
      ],
      "installedDate": null,
      "lastUpdate": null,
    },
    {
      "id": "6",
      "name": "Google Analytics",
      "description": "Web analytics and reporting dashboard",
      "category": "Analytics",
      "developer": "Google LLC",
      "version": "6.2.1",
      "icon": "https://picsum.photos/80/80?random=6",
      "installed": true,
      "rating": 4.6,
      "reviews": 8900,
      "price": "Free - \$150,000/year",
      "features": ["Traffic Analysis", "Goal Tracking", "Custom Reports", "Real-time Data"],
      "screenshots": [
        "https://picsum.photos/300/200?random=61",
        "https://picsum.photos/300/200?random=62",
      ],
      "installedDate": "2024-08-05",
      "lastUpdate": "2024-12-15",
    },
  ];

  int currentTab = 0;

  List<Map<String, dynamic>> get filteredApps {
    return apps.where((app) {
      bool matchesSearch = searchQuery.isEmpty ||
          (app["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (app["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || app["category"] == selectedCategory;
      bool matchesInstallation = !showInstalledOnly || app["installed"] == true;
      
      return matchesSearch && matchesCategory && matchesInstallation;
    }).toList();
  }

  List<Map<String, dynamic>> get installedApps {
    return apps.where((app) => app["installed"] == true).toList();
  }

  void _toggleInstallation(String id) {
    int index = apps.indexWhere((app) => app["id"] == id);
    if (index != -1) {
      bool currentStatus = apps[index]["installed"] as bool;
      apps[index]["installed"] = !currentStatus;
      if (!currentStatus) {
        apps[index]["installedDate"] = "2024-12-19";
        ss("App installed successfully");
      } else {
        apps[index]["installedDate"] = null;
        si("App uninstalled");
      }
      setState(() {});
    }
  }

  Widget _buildInstalledTab() {
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
                          Icon(Icons.apps, color: primaryColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Installed Apps",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${installedApps.length}",
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
                          Icon(Icons.update, color: successColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Up to Date",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${installedApps.length}",
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
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Installed Applications",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                if (installedApps.isEmpty)
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
                          Icons.apps,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "No apps installed yet",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Browse the marketplace to find apps that enhance your CRM",
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
                    children: installedApps.map((app) {
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
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusSm),
                                image: DecorationImage(
                                  image: NetworkImage("${app["icon"]}"),
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
                                        "${app["name"]}",
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
                                        child: Text(
                                          "v${app["version"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: successColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${app["category"]} • ${app["developer"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        size: 14,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "Installed: ${app["installedDate"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Spacer(),
                                      if (app["lastUpdate"] != null)
                                        Text(
                                          "Updated: ${app["lastUpdate"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: successColor,
                                          ),
                                        ),
                                    ],
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
        ],
      ),
    );
  }

  Widget _buildMarketplaceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search Apps",
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
                      "label": "Show Installed Only",
                      "value": true,
                      "checked": showInstalledOnly,
                    }
                  ],
                  value: [
                    if (showInstalledOnly)
                      {
                        "label": "Show Installed Only",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    showInstalledOnly = values.isNotEmpty;
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
                  "Available Apps (${filteredApps.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Column(
                  spacing: spSm,
                  children: filteredApps.map((app) {
                    bool isInstalled = app["installed"] as bool;
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
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  image: DecorationImage(
                                    image: NetworkImage("${app["icon"]}"),
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
                                          "${app["name"]}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        if (isInstalled)
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
                                                  "Installed",
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
                                      "${app["description"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Row(
                                      children: [
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
                                            "${app["category"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: infoColor,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              size: 14,
                                              color: warningColor,
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "${(app["rating"] as double).toStringAsFixed(1)}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: warningColor,
                                              ),
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "(${app["reviews"]})",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "By ${app["developer"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (app["features"] as List<String>).map((feature) {
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
                          if ((app["screenshots"] as List).isNotEmpty) ...[
                            Text(
                              "Screenshots",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            QHorizontalScroll(
                              children: (app["screenshots"] as List<String>).map((screenshot) {
                                return Container(
                                  width: 200,
                                  height: 120,
                                  margin: EdgeInsets.only(right: spSm),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    image: DecorationImage(
                                      image: NetworkImage(screenshot),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: spSm),
                          ],
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
                                    "${app["price"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              QButton(
                                label: isInstalled ? "Uninstall" : "Install",
                                size: bs.sm,
                                onPressed: () => _toggleInstallation(app["id"] as String),
                              ),
                            ],
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

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Third-Party Apps",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Installed", icon: Icon(Icons.check_circle)),
        Tab(text: "Marketplace", icon: Icon(Icons.store)),
      ],
      tabChildren: [
        _buildInstalledTab(),
        _buildMarketplaceTab(),
      ],
      onInit: (tabController) {},
    );
  }
}
