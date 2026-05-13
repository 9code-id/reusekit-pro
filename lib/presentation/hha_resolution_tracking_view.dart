import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaResolutionTrackingView extends StatefulWidget {
  const HhaResolutionTrackingView({super.key});

  @override
  State<HhaResolutionTrackingView> createState() => _HhaResolutionTrackingViewState();
}

class _HhaResolutionTrackingViewState extends State<HhaResolutionTrackingView> {
  String searchQuery = "";
  String selectedTimeframe = "This Month";
  String selectedCategory = "All";
  String selectedDepartment = "All";
  String selectedResolution = "All";

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Maintenance", "value": "Maintenance"},
    {"label": "Housekeeping", "value": "Housekeeping"},
    {"label": "Front Office", "value": "Front Office"},
    {"label": "Food & Beverage", "value": "Food & Beverage"},
    {"label": "IT Support", "value": "IT Support"},
    {"label": "Security", "value": "Security"},
    {"label": "Guest Complaint", "value": "Guest Complaint"},
  ];

  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All", "value": "All"},
    {"label": "Maintenance", "value": "Maintenance"},
    {"label": "Housekeeping", "value": "Housekeeping"},
    {"label": "Front Desk", "value": "Front Desk"},
    {"label": "Restaurant", "value": "Restaurant"},
    {"label": "IT Department", "value": "IT Department"},
    {"label": "Security", "value": "Security"},
    {"label": "Management", "value": "Management"},
  ];

  List<Map<String, dynamic>> resolutionOptions = [
    {"label": "All", "value": "All"},
    {"label": "Resolved", "value": "Resolved"},
    {"label": "Closed", "value": "Closed"},
    {"label": "Escalated", "value": "Escalated"},
    {"label": "Duplicate", "value": "Duplicate"},
  ];

  List<Map<String, dynamic>> resolutions = [
    {
      "id": "RES001",
      "issueId": "ISS001",
      "title": "Air Conditioning Not Working",
      "category": "Maintenance",
      "department": "Maintenance",
      "priority": "High",
      "reportedDate": "2024-01-15T08:30:00",
      "resolvedDate": "2024-01-15T16:30:00",
      "resolutionTime": "8h 0m",
      "resolutionTimeHours": 8.0,
      "resolutionType": "Resolved",
      "resolvedBy": "Mike Johnson",
      "solution": "Replaced faulty thermostat and recharged refrigerant",
      "customerSatisfaction": 5,
      "followUpRequired": false,
      "cost": 185.0,
      "preventiveMeasures": "Schedule monthly AC maintenance checks",
      "guestCompensation": 50.0,
      "impactLevel": "High",
      "rootCause": "Equipment wear and tear",
      "satisfaction": "Excellent",
    },
    {
      "id": "RES002",
      "issueId": "ISS002",
      "title": "Dirty Bathroom in Room 205",
      "category": "Housekeeping",
      "department": "Housekeeping",
      "priority": "Critical",
      "reportedDate": "2024-01-14T14:20:00",
      "resolvedDate": "2024-01-14T14:45:00",
      "resolutionTime": "0h 25m",
      "resolutionTimeHours": 0.42,
      "resolutionType": "Resolved",
      "resolvedBy": "Maria Santos",
      "solution": "Deep cleaned bathroom and implemented additional quality checks",
      "customerSatisfaction": 4,
      "followUpRequired": true,
      "cost": 0.0,
      "preventiveMeasures": "Enhanced room inspection protocol",
      "guestCompensation": 25.0,
      "impactLevel": "Critical",
      "rootCause": "Missed cleaning checklist item",
      "satisfaction": "Good",
    },
    {
      "id": "RES003",
      "issueId": "ISS003",
      "title": "Kitchen Equipment Malfunction",
      "category": "Food & Beverage",
      "department": "Restaurant",
      "priority": "High",
      "reportedDate": "2024-01-15T06:00:00",
      "resolvedDate": "2024-01-15T14:00:00",
      "resolutionTime": "8h 0m",
      "resolutionTimeHours": 8.0,
      "resolutionType": "Resolved",
      "resolvedBy": "Equipment Repair Team",
      "solution": "Replaced temperature control unit and calibrated system",
      "customerSatisfaction": 5,
      "followUpRequired": false,
      "cost": 275.0,
      "preventiveMeasures": "Quarterly equipment maintenance schedule",
      "guestCompensation": 0.0,
      "impactLevel": "Medium",
      "rootCause": "Component failure",
      "satisfaction": "Excellent",
    },
    {
      "id": "RES004",
      "issueId": "ISS004",
      "title": "Noisy Neighbors Complaint",
      "category": "Guest Complaint",
      "department": "Security",
      "priority": "Medium",
      "reportedDate": "2024-01-14T23:30:00",
      "resolvedDate": "2024-01-15T00:15:00",
      "resolutionTime": "0h 45m",
      "resolutionTimeHours": 0.75,
      "resolutionType": "Closed",
      "resolvedBy": "Night Security",
      "solution": "Mediated between guests and established quiet hours reminder",
      "customerSatisfaction": 4,
      "followUpRequired": false,
      "cost": 0.0,
      "preventiveMeasures": "Enhanced guest orientation about hotel policies",
      "guestCompensation": 0.0,
      "impactLevel": "Low",
      "rootCause": "Policy awareness gap",
      "satisfaction": "Good",
    },
    {
      "id": "RES005",
      "issueId": "ISS005",
      "title": "Wi-Fi Connection Issues Floor 3",
      "category": "IT Support",
      "department": "IT Department",
      "priority": "Medium",
      "reportedDate": "2024-01-13T12:00:00",
      "resolvedDate": "2024-01-14T09:30:00",
      "resolutionTime": "21h 30m",
      "resolutionTimeHours": 21.5,
      "resolutionType": "Resolved",
      "resolvedBy": "IT Support Team",
      "solution": "Upgraded router firmware and increased bandwidth allocation",
      "customerSatisfaction": 3,
      "followUpRequired": true,
      "cost": 150.0,
      "preventiveMeasures": "Monthly network performance monitoring",
      "guestCompensation": 20.0,
      "impactLevel": "Medium",
      "rootCause": "Outdated firmware and bandwidth limitations",
      "satisfaction": "Average",
    },
    {
      "id": "RES006",
      "issueId": "ISS006",
      "title": "Broken Elevator Door Sensor",
      "category": "Maintenance",
      "department": "Maintenance",
      "priority": "Critical",
      "reportedDate": "2024-01-15T09:15:00",
      "resolvedDate": "2024-01-15T18:45:00",
      "resolutionTime": "9h 30m",
      "resolutionTimeHours": 9.5,
      "resolutionType": "Resolved",
      "resolvedBy": "Elevator Technician",
      "solution": "Replaced door sensor assembly and recalibrated safety systems",
      "customerSatisfaction": 4,
      "followUpRequired": false,
      "cost": 485.0,
      "preventiveMeasures": "Bi-annual elevator safety inspection",
      "guestCompensation": 0.0,
      "impactLevel": "High",
      "rootCause": "Sensor component failure",
      "satisfaction": "Good",
    },
  ];

  List<Map<String, dynamic>> get filteredResolutions {
    return resolutions.where((resolution) {
      bool matchesSearch = searchQuery.isEmpty ||
          (resolution["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (resolution["id"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (resolution["issueId"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || resolution["category"] == selectedCategory;
      bool matchesDepartment = selectedDepartment == "All" || resolution["department"] == selectedDepartment;
      bool matchesResolution = selectedResolution == "All" || resolution["resolutionType"] == selectedResolution;
      
      return matchesSearch && matchesCategory && matchesDepartment && matchesResolution;
    }).toList();
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return Colors.orange;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color _getSatisfactionColor(String satisfaction) {
    switch (satisfaction) {
      case "Excellent":
        return successColor;
      case "Good":
        return warningColor;
      case "Average":
        return Colors.orange;
      case "Poor":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getImpactColor(String impact) {
    switch (impact) {
      case "Critical":
        return dangerColor;
      case "High":
        return Colors.orange;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resolution Tracking"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.analytics),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search resolutions...",
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
                  onPressed: () {},
                ),
              ],
            ),

            // Filter dropdowns
            QHorizontalScroll(
              children: [
                SizedBox(
                  width: 140,
                  child: QDropdownField(
                    label: "Timeframe",
                    items: timeframeOptions,
                    value: selectedTimeframe,
                    onChanged: (value, label) {
                      selectedTimeframe = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: QDropdownField(
                    label: "Category",
                    items: categoryOptions,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: QDropdownField(
                    label: "Department",
                    items: departmentOptions,
                    value: selectedDepartment,
                    onChanged: (value, label) {
                      selectedDepartment = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: QDropdownField(
                    label: "Resolution",
                    items: resolutionOptions,
                    value: selectedResolution,
                    onChanged: (value, label) {
                      selectedResolution = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Statistics cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                Container(
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
                          Icon(Icons.check_circle, color: successColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "Total Resolved",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${resolutions.length}",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                          Icon(Icons.access_time, color: primaryColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "Avg Resolution Time",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${((resolutions.fold(0.0, (sum, res) => sum + (res["resolutionTimeHours"] as double))) / resolutions.length).toStringAsFixed(1)}h",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                          Icon(Icons.star, color: warningColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "Avg Satisfaction",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${((resolutions.fold(0.0, (sum, res) => sum + (res["customerSatisfaction"] as int))) / resolutions.length).toStringAsFixed(1)}/5",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                          Icon(Icons.attach_money, color: dangerColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "Total Cost",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "\$${((resolutions.fold(0.0, (sum, res) => sum + (res["cost"] as double)))).toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Resolutions list
            ...filteredResolutions.map((resolution) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getSatisfactionColor(resolution["satisfaction"] as String),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: _getPriorityColor(resolution["priority"] as String).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${resolution["priority"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: _getPriorityColor(resolution["priority"] as String),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${resolution["id"]} (${resolution["issueId"]})",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: _getImpactColor(resolution["impactLevel"] as String).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${resolution["impactLevel"]} Impact",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: _getImpactColor(resolution["impactLevel"] as String),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${resolution["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          spacing: spXs,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${resolution["resolutionType"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ),
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  Icons.star,
                                  size: 16,
                                  color: index < (resolution["customerSatisfaction"] as int)
                                      ? warningColor
                                      : disabledColor,
                                );
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Resolution details
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.category, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${resolution["category"]}",
                                style: TextStyle(fontSize: 12, color: disabledBoldColor),
                              ),
                              SizedBox(width: spMd),
                              Icon(Icons.person, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${resolution["resolvedBy"]}",
                                style: TextStyle(fontSize: 12, color: disabledBoldColor),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "Resolution Time: ${resolution["resolutionTime"]}",
                                style: TextStyle(fontSize: 12, color: disabledBoldColor),
                              ),
                              Spacer(),
                              if ((resolution["cost"] as double) > 0)
                                Row(
                                  children: [
                                    Icon(Icons.attach_money, size: 16, color: dangerColor),
                                    SizedBox(width: spXs),
                                    Text(
                                      "\$${(resolution["cost"] as double).toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: dangerColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Solution
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: successColor.withAlpha(30)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Solution:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "${resolution["solution"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Root cause and preventive measures
                    if (resolution["rootCause"] != null || resolution["preventiveMeasures"] != null)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: infoColor.withAlpha(30)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            if (resolution["rootCause"] != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "Root Cause:",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: infoColor,
                                    ),
                                  ),
                                  Text(
                                    "${resolution["rootCause"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            if (resolution["preventiveMeasures"] != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "Preventive Measures:",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: infoColor,
                                    ),
                                  ),
                                  Text(
                                    "${resolution["preventiveMeasures"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),

                    // Additional info row
                    Row(
                      children: [
                        if (resolution["followUpRequired"] as bool)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "Follow-up Required",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: warningColor,
                              ),
                            ),
                          ),
                        if ((resolution["guestCompensation"] as double) > 0)
                          Padding(
                            padding: EdgeInsets.only(left: spSm),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: dangerColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "Compensation: \$${(resolution["guestCompensation"] as double).toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: dangerColor,
                                ),
                              ),
                            ),
                          ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getSatisfactionColor(resolution["satisfaction"] as String).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${resolution["satisfaction"]}",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: _getSatisfactionColor(resolution["satisfaction"] as String),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Action buttons
                    Row(
                      children: [
                        QButton(
                          label: "View Full Report",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                        SizedBox(width: spSm),
                        if (resolution["followUpRequired"] as bool)
                          QButton(
                            label: "Schedule Follow-up",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        Spacer(),
                        QButton(
                          icon: Icons.share,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
