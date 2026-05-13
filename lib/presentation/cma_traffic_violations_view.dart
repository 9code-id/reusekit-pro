import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaTrafficViolationsView extends StatefulWidget {
  const CmaTrafficViolationsView({super.key});

  @override
  State<CmaTrafficViolationsView> createState() => _CmaTrafficViolationsViewState();
}

class _CmaTrafficViolationsViewState extends State<CmaTrafficViolationsView> {
  String selectedFilter = "All";
  String selectedStatus = "All";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Last Year", "value": "Last Year"},
    {"label": "Last 3 Years", "value": "Last 3 Years"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Unpaid", "value": "Unpaid"},
    {"label": "Paid", "value": "Paid"},
    {"label": "Contested", "value": "Contested"},
    {"label": "Dismissed", "value": "Dismissed"},
  ];

  List<Map<String, dynamic>> violations = [
    {
      "ticketNumber": "TKT-2024-001456",
      "violation": "Speeding",
      "description": "Exceeding speed limit by 10-15 mph",
      "date": DateTime(2024, 3, 15),
      "location": "Main Street & 5th Avenue",
      "officerName": "Officer Johnson",
      "badgeNumber": "1234",
      "fineAmount": 125.00,
      "points": 2,
      "status": "Unpaid",
      "dueDate": DateTime(2024, 4, 15),
      "courtDate": DateTime(2024, 4, 20),
      "court": "Springfield Municipal Court",
      "courtAddress": "100 Court Street, Springfield, IL",
      "severity": "Minor",
    },
    {
      "ticketNumber": "TKT-2023-002789",
      "violation": "Running Red Light",
      "description": "Failure to stop at red light",
      "date": DateTime(2023, 8, 22),
      "location": "Highway 101 & Oak Street",
      "officerName": "Officer Davis",
      "badgeNumber": "5678",
      "fineAmount": 200.00,
      "points": 3,
      "status": "Paid",
      "dueDate": DateTime(2023, 9, 22),
      "courtDate": null,
      "court": "County Traffic Court",
      "courtAddress": "200 Justice Way, Springfield, IL",
      "severity": "Moderate",
    },
    {
      "ticketNumber": "TKT-2023-001234",
      "violation": "Improper Lane Change",
      "description": "Changing lanes without signal",
      "date": DateTime(2023, 6, 10),
      "location": "Interstate 55, Mile 120",
      "officerName": "Officer Wilson",
      "badgeNumber": "9012",
      "fineAmount": 85.00,
      "points": 1,
      "status": "Contested",
      "dueDate": DateTime(2023, 7, 10),
      "courtDate": DateTime(2023, 8, 15),
      "court": "Traffic Violations Bureau",
      "courtAddress": "150 Legal Plaza, Springfield, IL",
      "severity": "Minor",
    },
    {
      "ticketNumber": "TKT-2022-005678",
      "violation": "Expired Registration",
      "description": "Driving with expired vehicle registration",
      "date": DateTime(2022, 11, 5),
      "location": "Downtown Shopping District",
      "officerName": "Officer Martinez",
      "badgeNumber": "3456",
      "fineAmount": 50.00,
      "points": 0,
      "status": "Dismissed",
      "dueDate": null,
      "courtDate": DateTime(2022, 12, 10),
      "court": "Municipal Court",
      "courtAddress": "75 City Hall Drive, Springfield, IL",
      "severity": "Minor",
    },
  ];

  List<Map<String, dynamic>> violationStats = [
    {
      "title": "Total Violations",
      "value": "4",
      "icon": Icons.warning,
      "color": warningColor,
    },
    {
      "title": "Unpaid Fines",
      "value": "\$125",
      "icon": Icons.attach_money,
      "color": dangerColor,
    },
    {
      "title": "Total Points",
      "value": "6",
      "icon": Icons.speed,
      "color": warningColor,
    },
    {
      "title": "This Year",
      "value": "1",
      "icon": Icons.calendar_today,
      "color": infoColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredViolations = _getFilteredViolations();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Traffic Violations"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Unpaid Violation Alert
            if (violations.any((v) => v["status"] == "Unpaid"))
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: dangerColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.error, color: dangerColor, size: 28),
                        SizedBox(width: spSm),
                        Text(
                          "Unpaid Violations",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "You have unpaid traffic violations. Please pay by the due date to avoid additional penalties.",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Pay Now",
                        color: dangerColor,
                        onPressed: () {
                          _showPaymentDialog();
                        },
                      ),
                    ),
                  ],
                ),
              ),

            // Statistics Overview
            Text(
              "Violation Statistics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 120,
              children: violationStats.map((stat) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: (stat["color"] as Color).withAlpha(50),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (stat["color"] as Color).withAlpha(20),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          stat["icon"] as IconData,
                          color: stat["color"] as Color,
                          size: 20,
                        ),
                      ),
                      Text(
                        "${stat["value"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: stat["color"] as Color,
                        ),
                      ),
                      Text(
                        "${stat["title"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Filter by Period",
                    items: filterOptions,
                    value: selectedFilter,
                    onChanged: (value, label) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Filter by Status",
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

            // Violations List
            Text(
              "Traffic Violations (${filteredViolations.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (filteredViolations.isEmpty)
              Container(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 64,
                      color: successColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No Violations Found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "You have no traffic violations for the selected criteria.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              )
            else
              Column(
                spacing: spSm,
                children: filteredViolations.map((violation) {
                  Color statusColor = _getStatusColor(violation["status"] as String);
                  Color severityColor = _getSeverityColor(violation["severity"] as String);
                  
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: (violation["status"] as String) == "Unpaid"
                          ? Border.all(color: dangerColor.withAlpha(50), width: 2)
                          : null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${violation["violation"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${violation["status"]}",
                                style: TextStyle(
                                  color: statusColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        Text(
                          "${violation["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        
                        Row(
                          children: [
                            Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${(violation["date"] as DateTime).dMMMy}",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(width: spMd),
                            Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${violation["location"]}",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        
                        Row(
                          children: [
                            Text(
                              "Ticket: ${violation["ticketNumber"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spMd),
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
                                "${violation["severity"]}",
                                style: TextStyle(
                                  color: severityColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  if (violation["dueDate"] != null)
                                    Text(
                                      "Due: ${(violation["dueDate"] as DateTime).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: (violation["status"] as String) == "Unpaid" 
                                            ? dangerColor 
                                            : disabledBoldColor,
                                      ),
                                    ),
                                  if (violation["courtDate"] != null)
                                    Text(
                                      "Court: ${(violation["courtDate"] as DateTime).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              spacing: spXs,
                              children: [
                                Text(
                                  "\$${(violation["fineAmount"] as double).toStringAsFixed(0)}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: (violation["status"] as String) == "Unpaid" 
                                        ? dangerColor 
                                        : primaryColor,
                                  ),
                                ),
                                if ((violation["points"] as int) > 0)
                                  Text(
                                    "${violation["points"]} points",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: warningColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                        
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () {
                                  _showViolationDetails(violation);
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            if ((violation["status"] as String) == "Unpaid")
                              QButton(
                                label: "Pay Fine",
                                icon: Icons.payment,
                                size: bs.sm,
                                color: primaryColor,
                                onPressed: () {
                                  _showPaymentDialog();
                                },
                              )
                            else if ((violation["status"] as String) == "Contested")
                              QButton(
                                label: "Court Info",
                                icon: Icons.gavel,
                                size: bs.sm,
                                color: infoColor,
                                onPressed: () {
                                  _showCourtInfo(violation);
                                },
                              ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

            // Legal Resources
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: infoColor),
                      SizedBox(width: spSm),
                      Text(
                        "Legal Resources",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "• Contest a ticket within 30 days of issue date\n"
                    "• Traffic school may reduce points for some violations\n"
                    "• Late payments may result in additional fees\n"
                    "• Contact court for payment plan options",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Traffic School",
                          icon: Icons.school,
                          size: bs.sm,
                          color: infoColor,
                          onPressed: () {
                            si("Finding traffic school options");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Legal Help",
                          icon: Icons.gavel,
                          size: bs.sm,
                          color: infoColor,
                          onPressed: () {
                            si("Finding legal assistance");
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

  List<Map<String, dynamic>> _getFilteredViolations() {
    List<Map<String, dynamic>> filtered = violations;
    
    // Filter by period
    if (selectedFilter != "All") {
      DateTime now = DateTime.now();
      DateTime filterDate;
      
      switch (selectedFilter) {
        case "This Year":
          filterDate = DateTime(now.year, 1, 1);
          break;
        case "Last Year":
          filterDate = DateTime(now.year - 1, 1, 1);
          break;
        case "Last 3 Years":
          filterDate = DateTime(now.year - 3, 1, 1);
          break;
        default:
          filterDate = DateTime(1900);
      }
      
      filtered = filtered.where((v) => (v["date"] as DateTime).isAfter(filterDate)).toList();
    }
    
    // Filter by status
    if (selectedStatus != "All") {
      filtered = filtered.where((v) => v["status"] == selectedStatus).toList();
    }
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Paid":
        return successColor;
      case "Unpaid":
        return dangerColor;
      case "Contested":
        return warningColor;
      case "Dismissed":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "Minor":
        return successColor;
      case "Moderate":
        return warningColor;
      case "Major":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Violations"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QDropdownField(
              label: "Time Period",
              items: filterOptions,
              value: selectedFilter,
              onChanged: (value, label) {
                selectedFilter = value;
                setState(() {});
              },
            ),
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
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Apply Filters"),
          ),
        ],
      ),
    );
  }

  void _showViolationDetails(Map<String, dynamic> violation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Violation Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Ticket: ${violation["ticketNumber"]}"),
            Text("Violation: ${violation["violation"]}"),
            Text("Date: ${(violation["date"] as DateTime).dMMMy}"),
            Text("Location: ${violation["location"]}"),
            Text("Officer: ${violation["officerName"]} (#${violation["badgeNumber"]})"),
            Text("Fine: \$${(violation["fineAmount"] as double).toStringAsFixed(2)}"),
            Text("Points: ${violation["points"]}"),
            Text("Status: ${violation["status"]}"),
            if (violation["court"] != null)
              Text("Court: ${violation["court"]}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void _showPaymentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Pay Traffic Fine"),
        content: Text(
          "You will be redirected to the secure payment portal to pay your traffic fine."
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              si("Redirecting to payment portal...");
            },
            child: Text("Pay Now"),
          ),
        ],
      ),
    );
  }

  void _showCourtInfo(Map<String, dynamic> violation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Court Information"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Court: ${violation["court"]}"),
            Text("Address: ${violation["courtAddress"]}"),
            if (violation["courtDate"] != null)
              Text("Date: ${(violation["courtDate"] as DateTime).dMMMy}"),
            Text("Ticket: ${violation["ticketNumber"]}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}
