import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaTrafficUpdatesView extends StatefulWidget {
  const CmaTrafficUpdatesView({super.key});

  @override
  State<CmaTrafficUpdatesView> createState() => _CmaTrafficUpdatesViewState();
}

class _CmaTrafficUpdatesViewState extends State<CmaTrafficUpdatesView> {
  List<Map<String, dynamic>> trafficUpdates = [
    {
      "id": "TU001",
      "title": "Major Accident on Highway 101",
      "description": "Multi-vehicle collision causing severe delays. Emergency services on scene.",
      "location": "Highway 101 North, near Mission Street Exit",
      "severity": "High",
      "type": "Accident",
      "estimatedDelay": "45-60 minutes",
      "alternateRoute": "Use Highway 280 or surface streets",
      "timestamp": "2024-12-19T08:30:00Z",
      "isActive": true,
      "affectedLanes": "All northbound lanes blocked",
      "expectedClearance": "2024-12-19T10:30:00Z"
    },
    {
      "id": "TU002",
      "title": "Construction Work on Bay Bridge",
      "description": "Ongoing construction reducing lanes during morning rush hour.",
      "location": "Bay Bridge Eastbound, between Toll Plaza and Treasure Island",
      "severity": "Medium",
      "type": "Construction",
      "estimatedDelay": "15-25 minutes",
      "alternateRoute": "Consider Richmond Bridge or Golden Gate Bridge",
      "timestamp": "2024-12-19T06:00:00Z",
      "isActive": true,
      "affectedLanes": "2 of 5 lanes closed",
      "expectedClearance": "2024-12-19T09:00:00Z"
    },
    {
      "id": "TU003",
      "title": "Heavy Rain Causing Slow Traffic",
      "description": "Weather conditions causing reduced visibility and slower speeds citywide.",
      "location": "Citywide - All major highways and surface streets",
      "severity": "Medium",
      "type": "Weather",
      "estimatedDelay": "10-20 minutes",
      "alternateRoute": "Allow extra travel time, drive cautiously",
      "timestamp": "2024-12-19T07:00:00Z",
      "isActive": true,
      "affectedLanes": "All lanes moving slowly",
      "expectedClearance": "2024-12-19T12:00:00Z"
    },
    {
      "id": "TU004",
      "title": "Disabled Vehicle on Golden Gate Bridge",
      "description": "Disabled vehicle in right lane causing minor delays.",
      "location": "Golden Gate Bridge Southbound, middle span",
      "severity": "Low",
      "type": "Vehicle Issue",
      "estimatedDelay": "5-10 minutes",
      "alternateRoute": "No alternate route needed, minor delay only",
      "timestamp": "2024-12-19T08:45:00Z",
      "isActive": false,
      "affectedLanes": "Right lane blocked",
      "expectedClearance": "2024-12-19T09:15:00Z"
    },
    {
      "id": "TU005",
      "title": "Special Event Traffic",
      "description": "Giants game causing heavy traffic around AT&T Park area.",
      "location": "SOMA District, near AT&T Park and surrounding areas",
      "severity": "High",
      "type": "Event",
      "estimatedDelay": "30-45 minutes",
      "alternateRoute": "Use Bay Bridge or avoid downtown area",
      "timestamp": "2024-12-18T18:00:00Z",
      "isActive": true,
      "affectedLanes": "Multiple streets congested",
      "expectedClearance": "2024-12-19T00:00:00Z"
    }
  ];

  List<Map<String, dynamic>> severityFilters = [
    {"label": "All Severities", "value": "all"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"}
  ];

  List<Map<String, dynamic>> typeFilters = [
    {"label": "All Types", "value": "all"},
    {"label": "Accident", "value": "accident"},
    {"label": "Construction", "value": "construction"},
    {"label": "Weather", "value": "weather"},
    {"label": "Vehicle Issue", "value": "vehicle issue"},
    {"label": "Event", "value": "event"}
  ];

  String selectedSeverity = "all";
  String selectedType = "all";
  String searchQuery = "";
  bool showActiveOnly = true;

  List<Map<String, dynamic>> get filteredUpdates {
    return trafficUpdates.where((update) {
      bool matchesSeverity = selectedSeverity == "all" || 
          (update["severity"] as String).toLowerCase() == selectedSeverity.toLowerCase();
      bool matchesType = selectedType == "all" ||
          (update["type"] as String).toLowerCase() == selectedType.toLowerCase();
      bool matchesSearch = searchQuery.isEmpty ||
          (update["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (update["location"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesActive = !showActiveOnly || (update["isActive"] as bool);
      
      return matchesSeverity && matchesType && matchesSearch && matchesActive;
    }).toList();
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'accident':
        return dangerColor;
      case 'construction':
        return warningColor;
      case 'weather':
        return infoColor;
      case 'vehicle issue':
        return primaryColor;
      case 'event':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'accident':
        return Icons.car_crash;
      case 'construction':
        return Icons.construction;
      case 'weather':
        return Icons.cloud;
      case 'vehicle issue':
        return Icons.car_repair;
      case 'event':
        return Icons.event;
      default:
        return Icons.traffic;
    }
  }

  String _getTimeAgo(String timestamp) {
    final DateTime updateTime = DateTime.parse(timestamp);
    final Duration difference = DateTime.now().difference(updateTime);
    
    if (difference.inHours > 0) {
      return "${difference.inHours}h ago";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes}m ago";
    } else {
      return "Just now";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Traffic Updates"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Traffic updates refreshed");
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: Container(
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
                            Icon(
                              Icons.warning,
                              color: dangerColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Active Incidents",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${trafficUpdates.where((u) => u["isActive"] as bool).length}",
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
                            Icon(
                              Icons.traffic,
                              color: warningColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "High Severity",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${trafficUpdates.where((u) => (u["severity"] as String).toLowerCase() == "high").length}",
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

            // Filters
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.filter_list,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Filters",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search by location or description",
                          value: searchQuery,
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Severity",
                          items: severityFilters,
                          value: selectedSeverity,
                          onChanged: (value, label) {
                            selectedSeverity = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Type",
                          items: typeFilters,
                          value: selectedType,
                          onChanged: (value, label) {
                            selectedType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Show active incidents only",
                        "value": true,
                        "checked": showActiveOnly,
                      }
                    ],
                    value: [
                      if (showActiveOnly)
                        {
                          "label": "Show active incidents only",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      setState(() {
                        showActiveOnly = values.isNotEmpty;
                      });
                    },
                  ),
                ],
              ),
            ),

            // Traffic Updates List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Icon(
                          Icons.traffic,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Traffic Updates",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${filteredUpdates.length} updates",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredUpdates.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      color: disabledOutlineBorderColor,
                    ),
                    itemBuilder: (context, index) {
                      final update = filteredUpdates[index];
                      final severityColor = _getSeverityColor("${update["severity"]}");
                      final typeColor = _getTypeColor("${update["type"]}");
                      final typeIcon = _getTypeIcon("${update["type"]}");
                      final timeAgo = _getTimeAgo("${update["timestamp"]}");
                      final expectedClearance = DateTime.parse("${update["expectedClearance"]}");
                      
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: typeColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    typeIcon,
                                    color: typeColor,
                                    size: 24,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${update["title"]}",
                                              style: TextStyle(
                                                fontSize: fsH6,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: spSm,
                                                  vertical: spXs,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: severityColor.withAlpha(20),
                                                  borderRadius: BorderRadius.circular(radiusSm),
                                                ),
                                                child: Text(
                                                  "${update["severity"]}",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: severityColor,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: spSm),
                                              Container(
                                                width: 8,
                                                height: 8,
                                                decoration: BoxDecoration(
                                                  color: (update["isActive"] as bool) ? successColor : disabledBoldColor,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${update["location"]}",
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
                            SizedBox(height: spMd),

                            // Description
                            Text(
                              "${update["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spMd),

                            // Details Section
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                spacing: spSm,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.schedule,
                                              color: disabledBoldColor,
                                              size: 16,
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "${update["estimatedDelay"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: dangerColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.access_time,
                                              color: disabledBoldColor,
                                              size: 16,
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              timeAgo,
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.block,
                                              color: disabledBoldColor,
                                              size: 16,
                                            ),
                                            SizedBox(width: spXs),
                                            Expanded(
                                              child: Text(
                                                "${update["affectedLanes"]}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  if ((update["isActive"] as bool)) ...[
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.event,
                                          color: disabledBoldColor,
                                          size: 16,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "Expected clearance: ${expectedClearance.dMMMy}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: successColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            SizedBox(height: spMd),

                            // Alternate Route Section
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(color: infoColor.withAlpha(50)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.alt_route,
                                        color: infoColor,
                                        size: 16,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "Alternate Route Suggestion",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: infoColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${update["alternateRoute"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: infoColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: spMd),

                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "Get Directions",
                                    icon: Icons.directions,
                                    size: bs.sm,
                                    onPressed: () {
                                      // Navigate to directions with alternate route
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: QButton(
                                    label: "Share Alert",
                                    icon: Icons.share,
                                    size: bs.sm,
                                    onPressed: () {
                                      // Share traffic alert
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
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
