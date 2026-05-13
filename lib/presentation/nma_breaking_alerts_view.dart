import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaBreakingAlertsView extends StatefulWidget {
  const NmaBreakingAlertsView({super.key});

  @override
  State<NmaBreakingAlertsView> createState() => _NmaBreakingAlertsViewState();
}

class _NmaBreakingAlertsViewState extends State<NmaBreakingAlertsView> {
  String selectedFilter = "All";
  bool soundEnabled = true;
  bool vibrationEnabled = true;
  String alertFrequency = "Immediate";
  List<String> selectedCategories = ["Breaking News", "Politics"];

  List<Map<String, dynamic>> breakingAlerts = [
    {
      "id": 1,
      "title": "Major Earthquake Hits California Coast",
      "description": "7.2 magnitude earthquake strikes Northern California, tsunami warning issued",
      "timestamp": "2 minutes ago",
      "severity": "Critical",
      "category": "Breaking News",
      "isRead": false,
      "location": "San Francisco, CA",
      "affectedPeople": "2.5M",
      "emergencyContact": "+1-800-EMERGENCY",
      "updates": 12,
      "sources": ["USGS", "Cal OES", "SF Chronicle"]
    },
    {
      "id": 2,
      "title": "Stock Market Flash Crash",
      "description": "Major indices drop 15% in minutes following Fed announcement",
      "timestamp": "8 minutes ago",
      "severity": "High",
      "category": "Business",
      "isRead": false,
      "location": "New York, NY",
      "affectedPeople": "Millions",
      "emergencyContact": "",
      "updates": 8,
      "sources": ["NYSE", "Reuters", "Bloomberg"]
    },
    {
      "id": 3,
      "title": "Prime Minister Emergency Address",
      "description": "PM announces immediate lockdown measures effective midnight",
      "timestamp": "15 minutes ago",
      "severity": "High",
      "category": "Politics",
      "isRead": true,
      "location": "London, UK",
      "affectedPeople": "67M",
      "emergencyContact": "+44-111",
      "updates": 5,
      "sources": ["10 Downing St", "BBC", "Sky News"]
    },
    {
      "id": 4,
      "title": "Airport Security Incident",
      "description": "All flights suspended at major international airport",
      "timestamp": "22 minutes ago",
      "severity": "Medium",
      "category": "Breaking News",
      "isRead": true,
      "location": "Dubai, UAE",
      "affectedPeople": "100K+",
      "emergencyContact": "+971-600-555555",
      "updates": 3,
      "sources": ["Dubai Airport", "Emirates", "Gulf News"]
    },
    {
      "id": 5,
      "title": "Celebrity Death Confirmed",
      "description": "Award-winning actor passes away at age 67",
      "timestamp": "35 minutes ago",
      "severity": "Low",
      "category": "Entertainment",
      "isRead": true,
      "location": "Los Angeles, CA",
      "affectedPeople": "",
      "emergencyContact": "",
      "updates": 15,
      "sources": ["Variety", "People", "TMZ"]
    }
  ];

  List<Map<String, dynamic>> alertCategories = [
    {"label": "All", "value": "All", "count": 5},
    {"label": "Breaking News", "value": "Breaking News", "count": 2},
    {"label": "Politics", "value": "Politics", "count": 1},
    {"label": "Business", "value": "Business", "count": 1},
    {"label": "Entertainment", "value": "Entertainment", "count": 1},
    {"label": "Sports", "value": "Sports", "count": 0},
    {"label": "Technology", "value": "Technology", "count": 0}
  ];

  List<Map<String, dynamic>> frequencyOptions = [
    {"label": "Immediate", "value": "Immediate"},
    {"label": "Every 5 minutes", "value": "5min"},
    {"label": "Every 15 minutes", "value": "15min"},
    {"label": "Every hour", "value": "1hour"},
    {"label": "Twice daily", "value": "12hour"},
    {"label": "Daily digest", "value": "daily"}
  ];

  List<Map<String, dynamic>> notificationCategories = [
    {"label": "Breaking News", "value": "Breaking News", "enabled": true},
    {"label": "Politics", "value": "Politics", "enabled": true},
    {"label": "Business", "value": "Business", "enabled": false},
    {"label": "Sports", "value": "Sports", "enabled": false},
    {"label": "Technology", "value": "Technology", "enabled": false},
    {"label": "Entertainment", "value": "Entertainment", "enabled": false},
    {"label": "Health", "value": "Health", "enabled": false},
    {"label": "Science", "value": "Science", "enabled": false}
  ];

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'critical':
        return dangerColor;
      case 'high':
        return warningColor;
      case 'medium':
        return infoColor;
      case 'low':
        return successColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildAlertCard(Map<String, dynamic> alert) {
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
            color: _getSeverityColor(alert["severity"]),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getSeverityColor(alert["severity"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${alert["severity"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getSeverityColor(alert["severity"]),
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${alert["category"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
              Spacer(),
              if (!(alert["isRead"] as bool))
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: dangerColor,
                    shape: BoxShape.circle,
                  ),
                ),
              SizedBox(width: spXs),
              Text(
                "${alert["timestamp"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "${alert["title"]}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${alert["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
          if (alert["location"] != "")
            Container(
              margin: EdgeInsets.only(top: spXs),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 14,
                    color: disabledBoldColor,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "${alert["location"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  if (alert["affectedPeople"] != "")
                    Text(
                      " • ${alert["affectedPeople"]} affected",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                ],
              ),
            ),
          SizedBox(height: spSm),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.update,
                      size: 12,
                      color: successColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${alert["updates"]} updates",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "Sources: ${(alert["sources"] as List).join(", ")}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          if (alert["emergencyContact"] != "")
            Container(
              margin: EdgeInsets.only(top: spSm),
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: dangerColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.emergency,
                    size: 16,
                    color: dangerColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Emergency: ${alert["emergencyContact"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: dangerColor,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      ss("Calling emergency number...");
                    },
                    child: Icon(
                      Icons.phone,
                      size: 16,
                      color: dangerColor,
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: spSm),
          Row(
            children: [
              QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () {
                  ss("Opening alert details...");
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.share,
                size: bs.sm,
                onPressed: () {
                  ss("Sharing alert...");
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.bookmark_border,
                size: bs.sm,
                onPressed: () {
                  ss("Alert bookmarked");
                },
              ),
              Spacer(),
              if (!(alert["isRead"] as bool))
                QButton(
                  label: "Mark Read",
                  size: bs.sm,
                  onPressed: () {
                    alert["isRead"] = true;
                    setState(() {});
                    ss("Marked as read");
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
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
          Text(
            "Alert Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Sound notifications",
                      "value": true,
                      "checked": soundEnabled,
                    }
                  ],
                  value: [
                    if (soundEnabled)
                      {
                        "label": "Sound notifications",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    soundEnabled = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Vibration alerts",
                      "value": true,
                      "checked": vibrationEnabled,
                    }
                  ],
                  value: [
                    if (vibrationEnabled)
                      {
                        "label": "Vibration alerts",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    vibrationEnabled = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: "Alert Frequency",
            items: frequencyOptions,
            value: alertFrequency,
            onChanged: (value, label) {
              alertFrequency = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Text(
            "Categories",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Column(
            children: notificationCategories.map((category) {
              return Container(
                margin: EdgeInsets.only(bottom: spXs),
                child: Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": category["label"],
                            "value": category["value"],
                            "checked": category["enabled"],
                          }
                        ],
                        value: [
                          if (category["enabled"])
                            {
                              "label": category["label"],
                              "value": category["value"],
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          category["enabled"] = values.isNotEmpty;
                          setState(() {});
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

  @override
  Widget build(BuildContext context) {
    final filteredAlerts = selectedFilter == "All"
        ? breakingAlerts
        : breakingAlerts.where((alert) => alert["category"] == selectedFilter).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Breaking Alerts"),
        actions: [
          GestureDetector(
            onTap: () {
              ss("Opening alert settings...");
            },
            child: Icon(Icons.settings),
          ),
          SizedBox(width: spSm),
          GestureDetector(
            onTap: () {
              ss("Refreshing alerts...");
            },
            child: Icon(Icons.refresh),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Alert status banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: successColor.withAlpha(50),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.notifications_active,
                    color: successColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Alert System Active",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Monitoring ${notificationCategories.where((c) => c["enabled"]).length} categories",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "${breakingAlerts.where((a) => !(a["isRead"] as bool)).length} unread",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Category filter
            QCategoryPicker(
              label: "Filter by Category",
              items: alertCategories.map((category) => {
                "label": "${category["label"]} (${category["count"]})",
                "value": category["value"],
              }).toList(),
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Alert settings
            _buildSettingsSection(),
            
            SizedBox(height: spMd),
            
            // Alerts list
            Row(
              children: [
                Text(
                  "Recent Alerts",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                if (filteredAlerts.any((alert) => !(alert["isRead"] as bool)))
                  GestureDetector(
                    onTap: () {
                      for (var alert in filteredAlerts) {
                        alert["isRead"] = true;
                      }
                      setState(() {});
                      ss("All alerts marked as read");
                    },
                    child: Text(
                      "Mark all read",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            if (filteredAlerts.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.notifications_off,
                      size: 48,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No alerts in this category",
                      style: TextStyle(
                        fontSize: fsH6,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Breaking news alerts will appear here",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              Column(
                children: filteredAlerts.map((alert) => _buildAlertCard(alert)).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
