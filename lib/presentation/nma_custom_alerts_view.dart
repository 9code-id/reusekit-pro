import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaCustomAlertsView extends StatefulWidget {
  const NmaCustomAlertsView({super.key});

  @override
  State<NmaCustomAlertsView> createState() => _NmaCustomAlertsViewState();
}

class _NmaCustomAlertsViewState extends State<NmaCustomAlertsView> {
  String searchQuery = "";
  String selectedStatus = "All";
  bool isLoading = false;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Paused", "value": "Paused"},
    {"label": "Triggered", "value": "Triggered"},
  ];

  List<Map<String, dynamic>> customAlerts = [
    {
      "id": "1",
      "name": "Engagement Drop Alert",
      "description": "Alert when engagement rate drops below 5%",
      "condition": "less_than",
      "threshold": 5.0,
      "metric": "engagement_rate",
      "status": "Active",
      "frequency": "daily",
      "lastTriggered": "2024-01-10",
      "triggerCount": 3,
      "createdDate": "2024-01-01",
    },
    {
      "id": "2",
      "name": "Follower Growth Spike",
      "description": "Alert when daily follower growth exceeds 100",
      "condition": "greater_than",
      "threshold": 100.0,
      "metric": "follower_growth",
      "status": "Active",
      "frequency": "immediate",
      "lastTriggered": "2024-01-12",
      "triggerCount": 8,
      "createdDate": "2024-01-01",
    },
    {
      "id": "3",
      "name": "Keyword Ranking Change",
      "description": "Alert when target keyword ranking changes by 5+ positions",
      "condition": "greater_than",
      "threshold": 5.0,
      "metric": "keyword_position_change",
      "status": "Paused",
      "frequency": "weekly",
      "lastTriggered": "2024-01-08",
      "triggerCount": 2,
      "createdDate": "2023-12-15",
    },
    {
      "id": "4",
      "name": "Competitor Mention Spike",
      "description": "Alert when competitor mentions increase by 50%",
      "condition": "greater_than",
      "threshold": 50.0,
      "metric": "competitor_mentions",
      "status": "Triggered",
      "frequency": "hourly",
      "lastTriggered": "2024-01-13",
      "triggerCount": 15,
      "createdDate": "2024-01-05",
    },
    {
      "id": "5",
      "name": "Content Performance Alert",
      "description": "Alert when post reaches 1000+ interactions",
      "condition": "greater_than",
      "threshold": 1000.0,
      "metric": "post_interactions",
      "status": "Active",
      "frequency": "immediate",
      "lastTriggered": "2024-01-13",
      "triggerCount": 5,
      "createdDate": "2024-01-03",
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadAlerts();
  }

  void _loadAlerts() {
    isLoading = true;
    setState(() {});

    // Simulate API call
    Future.delayed(Duration(seconds: 1), () {
      isLoading = false;
      setState(() {});
    });
  }

  List<Map<String, dynamic>> get filteredAlerts {
    var filtered = customAlerts;
    
    if (selectedStatus != "All") {
      filtered = filtered.where((alert) => alert["status"] == selectedStatus).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((alert) => 
        (alert["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (alert["description"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (alert["metric"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Paused":
        return warningColor;
      case "Triggered":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getConditionText(String condition) {
    switch (condition) {
      case "greater_than":
        return ">";
      case "less_than":
        return "<";
      case "equal_to":
        return "=";
      case "contains":
        return "contains";
      default:
        return condition;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Alerts"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              // Navigate to create alert
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  // Search and Filter
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search custom alerts...",
                          value: searchQuery,
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QDropdownField(
                        label: "Status",
                        items: statusOptions,
                        value: selectedStatus,
                        onChanged: (value, label) {
                          selectedStatus = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),

                  // Stats Overview
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
                            children: [
                              Text(
                                "Total Alerts",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${customAlerts.length}",
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
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Active",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${customAlerts.where((a) => a["status"] == "Active").length}",
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
                            children: [
                              Text(
                                "Triggered",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${customAlerts.where((a) => a["status"] == "Triggered").length}",
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
                    ],
                  ),

                  // Alerts List
                  Row(
                    children: [
                      Text(
                        "Your Custom Alerts (${filteredAlerts.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Create New",
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to create alert
                        },
                      ),
                    ],
                  ),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredAlerts.length,
                    itemBuilder: (context, index) {
                      final alert = filteredAlerts[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: _getStatusColor(alert["status"] as String),
                            ),
                          ),
                        ),
                        child: ExpansionTile(
                          initiallyExpanded: false,
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${alert["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(alert["status"] as String).withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${alert["status"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: _getStatusColor(alert["status"] as String),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${alert["description"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Padding(
                            padding: EdgeInsets.only(top: spXs),
                            child: Row(
                              children: [
                                Text(
                                  "Triggered ${alert["triggerCount"]} times",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "•",
                                  style: TextStyle(color: disabledBoldColor),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "Last: ${alert["lastTriggered"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spSm,
                                children: [
                                  // Alert Details
                                  Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(10),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: spXs,
                                      children: [
                                        Text(
                                          "Alert Condition",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "${alert["metric"]} ${_getConditionText(alert["condition"] as String)} ${alert["threshold"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Frequency",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${alert["frequency"]}".replaceAll("_", " ").toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
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
                                              "Created",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${alert["createdDate"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Action Buttons
                                  Row(
                                    children: [
                                      Expanded(
                                        child: QButton(
                                          label: alert["status"] == "Active" ? "Pause" : "Activate",
                                          size: bs.sm,
                                          onPressed: () {
                                            _toggleAlertStatus(alert["id"] as String);
                                          },
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      QButton(
                                        icon: Icons.edit,
                                        size: bs.sm,
                                        onPressed: () {
                                          // Edit alert
                                        },
                                      ),
                                      SizedBox(width: spSm),
                                      QButton(
                                        icon: Icons.analytics,
                                        size: bs.sm,
                                        onPressed: () {
                                          // View analytics
                                        },
                                      ),
                                      SizedBox(width: spSm),
                                      QButton(
                                        icon: Icons.delete,
                                        size: bs.sm,
                                        onPressed: () {
                                          _deleteAlert(alert["id"] as String);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  // Quick Actions
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "Quick Actions",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Pause All",
                                size: bs.sm,
                                onPressed: () {
                                  _pauseAllAlerts();
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "Activate All",
                                size: bs.sm,
                                onPressed: () {
                                  _activateAllAlerts();
                                },
                              ),
                            ),
                          ],
                        ),
                        
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Export Settings",
                                size: bs.sm,
                                onPressed: () {
                                  // Export alerts
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "Import Settings",
                                size: bs.sm,
                                onPressed: () {
                                  // Import alerts
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void _toggleAlertStatus(String alertId) async {
    final alert = customAlerts.firstWhere((a) => a["id"] == alertId);
    final newStatus = alert["status"] == "Active" ? "Paused" : "Active";
    
    bool isConfirmed = await confirm("${newStatus == "Active" ? "Activate" : "Pause"} this alert?");
    
    if (isConfirmed) {
      showLoading();
      
      // Simulate API call
      Future.delayed(Duration(seconds: 1), () {
        hideLoading();
        setState(() {
          alert["status"] = newStatus;
        });
        ss("Alert ${newStatus.toLowerCase()} successfully!");
      });
    }
  }

  void _deleteAlert(String alertId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this alert?");
    
    if (isConfirmed) {
      showLoading();
      
      // Simulate API call
      Future.delayed(Duration(seconds: 1), () {
        hideLoading();
        setState(() {
          customAlerts.removeWhere((alert) => alert["id"] == alertId);
        });
        ss("Alert deleted successfully!");
      });
    }
  }

  void _pauseAllAlerts() async {
    bool isConfirmed = await confirm("Pause all active alerts?");
    
    if (isConfirmed) {
      showLoading();
      
      // Simulate API call
      Future.delayed(Duration(seconds: 1), () {
        hideLoading();
        setState(() {
          for (var alert in customAlerts) {
            if (alert["status"] == "Active") {
              alert["status"] = "Paused";
            }
          }
        });
        ss("All alerts paused successfully!");
      });
    }
  }

  void _activateAllAlerts() async {
    bool isConfirmed = await confirm("Activate all paused alerts?");
    
    if (isConfirmed) {
      showLoading();
      
      // Simulate API call
      Future.delayed(Duration(seconds: 1), () {
        hideLoading();
        setState(() {
          for (var alert in customAlerts) {
            if (alert["status"] == "Paused") {
              alert["status"] = "Active";
            }
          }
        });
        ss("All alerts activated successfully!");
      });
    }
  }
}
