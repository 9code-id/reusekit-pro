import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmRouteHistoryView extends StatefulWidget {
  const FsmRouteHistoryView({super.key});

  @override
  State<FsmRouteHistoryView> createState() => _FsmRouteHistoryViewState();
}

class _FsmRouteHistoryViewState extends State<FsmRouteHistoryView> {
  String selectedTechnician = "";
  String selectedDateRange = "last_week";
  String selectedRouteType = "all";
  String searchQuery = "";
  bool showOnlyCompleted = false;
  
  List<Map<String, dynamic>> routeHistory = [
    {
      "id": "RT001",
      "technician": "John Smith",
      "date": "2024-03-15",
      "startTime": "08:00",
      "endTime": "17:30",
      "totalDistance": 142.5,
      "totalDuration": "9h 30m",
      "jobsCompleted": 6,
      "jobsScheduled": 7,
      "status": "completed",
      "efficiency": 85.7,
      "fuelUsed": 18.4,
      "route": [
        {"address": "123 Main St", "type": "start", "time": "08:00", "duration": "0m"},
        {"address": "456 Oak Ave", "type": "service", "time": "08:45", "duration": "45m"},
        {"address": "789 Pine Rd", "type": "service", "time": "10:15", "duration": "60m"},
        {"address": "321 Elm St", "type": "service", "time": "12:00", "duration": "30m"},
        {"address": "654 Maple Dr", "type": "service", "time": "13:30", "duration": "90m"},
        {"address": "987 Cedar Ln", "type": "service", "time": "15:45", "duration": "45m"},
        {"address": "147 Birch Way", "type": "service", "time": "16:45", "duration": "30m"},
        {"address": "123 Main St", "type": "end", "time": "17:30", "duration": "0m"}
      ]
    },
    {
      "id": "RT002",
      "technician": "Sarah Johnson",
      "date": "2024-03-15",
      "startTime": "07:30",
      "endTime": "16:15",
      "totalDistance": 98.3,
      "totalDuration": "8h 45m",
      "jobsCompleted": 5,
      "jobsScheduled": 5,
      "status": "completed",
      "efficiency": 100.0,
      "fuelUsed": 12.7,
      "route": [
        {"address": "456 Service Depot", "type": "start", "time": "07:30", "duration": "0m"},
        {"address": "789 Corporate Blvd", "type": "service", "time": "08:30", "duration": "60m"},
        {"address": "321 Industrial Way", "type": "service", "time": "10:15", "duration": "75m"},
        {"address": "654 Business Park", "type": "service", "time": "12:30", "duration": "45m"},
        {"address": "987 Tech Center", "type": "service", "time": "14:00", "duration": "90m"},
        {"address": "147 Innovation Dr", "type": "service", "time": "15:45", "duration": "30m"},
        {"address": "456 Service Depot", "type": "end", "time": "16:15", "duration": "0m"}
      ]
    },
    {
      "id": "RT003",
      "technician": "Mike Davis",
      "date": "2024-03-14",
      "startTime": "09:00",
      "endTime": "18:45",
      "totalDistance": 187.2,
      "totalDuration": "9h 45m",
      "jobsCompleted": 4,
      "jobsScheduled": 6,
      "status": "incomplete",
      "efficiency": 66.7,
      "fuelUsed": 24.1,
      "route": [
        {"address": "123 Home Base", "type": "start", "time": "09:00", "duration": "0m"},
        {"address": "456 Downtown Plaza", "type": "service", "time": "10:00", "duration": "90m"},
        {"address": "789 Suburban Mall", "type": "service", "time": "12:30", "duration": "120m"},
        {"address": "321 Office Complex", "type": "service", "time": "15:15", "duration": "75m"},
        {"address": "654 Retail Center", "type": "service", "time": "17:00", "duration": "60m"},
        {"address": "123 Home Base", "type": "end", "time": "18:45", "duration": "0m"}
      ]
    },
    {
      "id": "RT004",
      "technician": "Lisa Wilson",
      "date": "2024-03-14",
      "startTime": "08:15",
      "endTime": "17:00",
      "totalDistance": 156.8,
      "totalDuration": "8h 45m",
      "jobsCompleted": 7,
      "jobsScheduled": 7,
      "status": "completed",
      "efficiency": 100.0,
      "fuelUsed": 20.3,
      "route": [
        {"address": "789 Central Hub", "type": "start", "time": "08:15", "duration": "0m"},
        {"address": "123 North District", "type": "service", "time": "09:00", "duration": "45m"},
        {"address": "456 East Side", "type": "service", "time": "10:15", "duration": "60m"},
        {"address": "789 West End", "type": "service", "time": "11:45", "duration": "30m"},
        {"address": "321 South Quarter", "type": "service", "time": "13:00", "duration": "75m"},
        {"address": "654 Harbor View", "type": "service", "time": "14:45", "duration": "45m"},
        {"address": "987 Airport Road", "type": "service", "time": "16:00", "duration": "30m"},
        {"address": "147 Industrial Zone", "type": "service", "time": "16:45", "duration": "15m"},
        {"address": "789 Central Hub", "type": "end", "time": "17:00", "duration": "0m"}
      ]
    }
  ];

  List<Map<String, dynamic>> technicians = [
    {"label": "All Technicians", "value": ""},
    {"label": "John Smith", "value": "John Smith"},
    {"label": "Sarah Johnson", "value": "Sarah Johnson"},
    {"label": "Mike Davis", "value": "Mike Davis"},
    {"label": "Lisa Wilson", "value": "Lisa Wilson"},
    {"label": "David Brown", "value": "David Brown"},
    {"label": "Emma Taylor", "value": "Emma Taylor"}
  ];

  List<Map<String, dynamic>> dateRangeOptions = [
    {"label": "Today", "value": "today"},
    {"label": "Yesterday", "value": "yesterday"},
    {"label": "Last 7 Days", "value": "last_week"},
    {"label": "Last 30 Days", "value": "last_month"},
    {"label": "This Month", "value": "this_month"},
    {"label": "Last Month", "value": "last_month_full"},
    {"label": "Custom Range", "value": "custom"}
  ];

  List<Map<String, dynamic>> routeTypeOptions = [
    {"label": "All Routes", "value": "all"},
    {"label": "Completed", "value": "completed"},
    {"label": "Incomplete", "value": "incomplete"},
    {"label": "High Efficiency", "value": "high_efficiency"},
    {"label": "Low Efficiency", "value": "low_efficiency"}
  ];

  List<Map<String, dynamic>> get filteredRoutes {
    return routeHistory.where((route) {
      bool matchesTechnician = selectedTechnician.isEmpty || 
          route["technician"] == selectedTechnician;
      
      bool matchesSearch = searchQuery.isEmpty ||
          route["technician"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          route["id"].toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesType = selectedRouteType == "all" ||
          (selectedRouteType == "completed" && route["status"] == "completed") ||
          (selectedRouteType == "incomplete" && route["status"] == "incomplete") ||
          (selectedRouteType == "high_efficiency" && (route["efficiency"] as double) >= 85) ||
          (selectedRouteType == "low_efficiency" && (route["efficiency"] as double) < 75);
      
      bool matchesCompleted = !showOnlyCompleted || route["status"] == "completed";
      
      return matchesTechnician && matchesSearch && matchesType && matchesCompleted;
    }).toList();
  }

  void _exportRouteData() {
    ss("Route data exported successfully");
  }

  void _viewRouteDetails(Map<String, dynamic> route) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Route ${route["id"]}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${route["technician"]} - ${route["date"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => back(),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: Colors.grey[200]!),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "${(route["totalDistance"] as double).toStringAsFixed(1)} km",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Total Distance",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
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
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: Colors.grey[200]!),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "${route["totalDuration"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Duration",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: Colors.grey[200]!),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "${(route["efficiency"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: (route["efficiency"] as double) >= 85 ? successColor : warningColor,
                                  ),
                                ),
                                Text(
                                  "Efficiency",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
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
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: Colors.grey[200]!),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "${route["jobsCompleted"]}/${route["jobsScheduled"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Jobs Completed",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Route Timeline",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...List.generate((route["route"] as List).length, (index) {
                      final stop = (route["route"] as List)[index];
                      final isFirst = index == 0;
                      final isLast = index == (route["route"] as List).length - 1;
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              child: Column(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: stop["type"] == "start" ? successColor :
                                             stop["type"] == "end" ? dangerColor : primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  if (!isLast)
                                    Container(
                                      width: 2,
                                      height: 40,
                                      color: Colors.grey[300],
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(color: Colors.grey[200]!),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${stop["address"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: stop["type"] == "start" ? successColor :
                                                   stop["type"] == "end" ? dangerColor : primaryColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            stop["type"] == "start" ? "START" :
                                            stop["type"] == "end" ? "END" : "SERVICE",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spXs),
                                    Row(
                                      children: [
                                        Icon(Icons.access_time, size: 14, color: disabledBoldColor),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${stop["time"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        if (stop["duration"] != "0m") ...[
                                          SizedBox(width: spSm),
                                          Icon(Icons.timer, size: 14, color: disabledBoldColor),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${stop["duration"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _analyzeRoute(Map<String, dynamic> route) {
    si("Analyzing route efficiency and optimization opportunities");
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "incomplete":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getEfficiencyColor(double efficiency) {
    if (efficiency >= 85) return successColor;
    if (efficiency >= 75) return warningColor;
    return dangerColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Route History"),
        actions: [
          GestureDetector(
            onTap: _exportRouteData,
            child: Icon(Icons.download),
          ),
          SizedBox(width: spSm),
          GestureDetector(
            onTap: () {
              si("Opening route analytics dashboard");
            },
            child: Icon(Icons.analytics),
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filters",
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
                        child: QDropdownField(
                          label: "Technician",
                          items: technicians,
                          value: selectedTechnician,
                          onChanged: (value, label) {
                            selectedTechnician = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Date Range",
                          items: dateRangeOptions,
                          value: selectedDateRange,
                          onChanged: (value, label) {
                            selectedDateRange = value;
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
                        child: QDropdownField(
                          label: "Route Type",
                          items: routeTypeOptions,
                          value: selectedRouteType,
                          onChanged: (value, label) {
                            selectedRouteType = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTextField(
                          label: "Search Routes",
                          value: searchQuery,
                          hint: "Search by technician or ID",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  QSwitch(
                    items: [
                      {
                        "label": "Show only completed routes",
                        "value": true,
                        "checked": showOnlyCompleted,
                      }
                    ],
                    value: [
                      if (showOnlyCompleted)
                        {
                          "label": "Show only completed routes",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      showOnlyCompleted = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),
            
            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: primaryColor.withAlpha(100)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${filteredRoutes.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Routes",
                          style: TextStyle(
                            fontSize: 12,
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
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(100)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${filteredRoutes.where((r) => r["status"] == "completed").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Completed",
                          style: TextStyle(
                            fontSize: 12,
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
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: warningColor.withAlpha(100)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${(filteredRoutes.map((r) => r["efficiency"] as double).reduce((a, b) => a + b) / filteredRoutes.length).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Avg Efficiency",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            
            // Route History List
            Text(
              "Route History (${filteredRoutes.length} routes)",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            ...List.generate(filteredRoutes.length, (index) {
              final route = filteredRoutes[index];
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: Colors.grey[200]!),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Route ${route["id"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${route["technician"]}",
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
                            color: _getStatusColor(route["status"]),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${route["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 14, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${route["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(Icons.access_time, size: 14, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${route["startTime"]} - ${route["endTime"]}",
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
                                "${(route["totalDistance"] as double).toStringAsFixed(1)} km",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Distance",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
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
                                "${route["totalDuration"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Duration",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
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
                                "${route["jobsCompleted"]}/${route["jobsScheduled"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Jobs",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
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
                                "${(route["efficiency"] as double).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: _getEfficiencyColor(route["efficiency"] as double),
                                ),
                              ),
                              Text(
                                "Efficiency",
                                style: TextStyle(
                                  fontSize: 10,
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
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () => _viewRouteDetails(route),
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.analytics,
                          size: bs.sm,
                          onPressed: () => _analyzeRoute(route),
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.map,
                          size: bs.sm,
                          onPressed: () {
                            si("Opening route map view");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
            
            if (filteredRoutes.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.route,
                      size: 48,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No Route History Found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters or date range",
                      textAlign: TextAlign.center,
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
