import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaRecallNoticesView extends StatefulWidget {
  const CmaRecallNoticesView({super.key});

  @override
  State<CmaRecallNoticesView> createState() => _CmaRecallNoticesViewState();
}

class _CmaRecallNoticesViewState extends State<CmaRecallNoticesView> {
  String selectedVehicle = "All Vehicles";
  String severityFilter = "All Severity";
  String statusFilter = "All Status";

  List<Map<String, dynamic>> recallNotices = [
    {
      "id": 1,
      "recallNumber": "NHTSA-2025-001",
      "vehicle": "Honda Civic",
      "modelYears": "2018-2021",
      "title": "Airbag Inflator Recall",
      "description": "Front passenger airbag inflator may rupture during deployment, causing metal fragments to spray into the vehicle.",
      "dateIssued": "2025-06-15",
      "severity": "High",
      "status": "Open",
      "affectedVehicles": 125000,
      "remedy": "Replace airbag inflator",
      "estimatedTime": "2-3 hours",
      "cost": "Free",
      "dealer": "Honda Authorized Dealers",
      "contactNumber": "1-800-999-1009",
      "safetyRisk": "Deployment may cause injury due to metal fragments",
      "components": ["Airbag System", "Passenger Side"],
      "vinRange": "Starting with 1HGBH41",
      "manufacturerResponse": "Honda will notify owners by mail",
    },
    {
      "id": 2,
      "recallNumber": "NHTSA-2025-002",
      "vehicle": "Toyota Camry",
      "modelYears": "2019-2020",
      "title": "Fuel Pump Failure",
      "description": "Fuel pump may fail, causing the vehicle to stall without warning, increasing the risk of a crash.",
      "dateIssued": "2025-06-10",
      "severity": "High",
      "status": "Completed",
      "affectedVehicles": 95000,
      "remedy": "Replace fuel pump",
      "estimatedTime": "3-4 hours",
      "cost": "Free",
      "dealer": "Toyota Authorized Service Centers",
      "contactNumber": "1-800-331-4331",
      "safetyRisk": "Vehicle stalling increases crash risk",
      "components": ["Fuel System", "Fuel Pump"],
      "vinRange": "Starting with 4T1B11HK",
      "manufacturerResponse": "Toyota has mailed notices to all owners",
    },
    {
      "id": 3,
      "recallNumber": "NHTSA-2025-003",
      "vehicle": "Honda Civic",
      "modelYears": "2020-2022",
      "title": "Brake System Software",
      "description": "Anti-lock brake system software may malfunction, potentially increasing stopping distance.",
      "dateIssued": "2025-05-28",
      "severity": "Medium",
      "status": "Open",
      "affectedVehicles": 67000,
      "remedy": "Update brake system software",
      "estimatedTime": "1 hour",
      "cost": "Free",
      "dealer": "Honda Service Centers",
      "contactNumber": "1-800-999-1009",
      "safetyRisk": "Increased stopping distance in emergency situations",
      "components": ["Brake System", "ABS Module"],
      "vinRange": "Starting with 2HGFC2F",
      "manufacturerResponse": "Software update available at dealerships",
    },
    {
      "id": 4,
      "recallNumber": "NHTSA-2025-004",
      "vehicle": "Honda Civic",
      "modelYears": "2019-2021",
      "title": "Seat Belt Buckle Issue",
      "description": "Front seat belt buckle may not latch properly, reducing occupant protection in a crash.",
      "dateIssued": "2025-05-15",
      "severity": "Medium",
      "status": "In Progress",
      "affectedVehicles": 45000,
      "remedy": "Replace seat belt buckle",
      "estimatedTime": "30 minutes",
      "cost": "Free",
      "dealer": "Honda Dealers",
      "contactNumber": "1-800-999-1009",
      "safetyRisk": "Reduced protection in crash due to improper seat belt function",
      "components": ["Seat Belt System", "Buckle Mechanism"],
      "vinRange": "Starting with 19XFC2F",
      "manufacturerResponse": "Parts are being shipped to dealers",
    },
    {
      "id": 5,
      "recallNumber": "NHTSA-2024-087",
      "vehicle": "Toyota Camry",
      "modelYears": "2018-2019",
      "title": "Rearview Camera Display",
      "description": "Rearview camera display may go blank intermittently, reducing visibility when backing up.",
      "dateIssued": "2024-12-20",
      "severity": "Low",
      "status": "Open",
      "affectedVehicles": 28000,
      "remedy": "Update display software",
      "estimatedTime": "45 minutes",
      "cost": "Free",
      "dealer": "Toyota Service Centers",
      "contactNumber": "1-800-331-4331",
      "safetyRisk": "Reduced visibility when reversing",
      "components": ["Infotainment System", "Backup Camera"],
      "vinRange": "Starting with 4T1B11HK",
      "manufacturerResponse": "Software update in development",
    },
  ];

  List<Map<String, dynamic>> get filteredRecalls {
    return recallNotices.where((recall) {
      bool vehicleMatch = selectedVehicle == "All Vehicles" || 
        recall["vehicle"] == selectedVehicle;
      bool severityMatch = severityFilter == "All Severity" || 
        recall["severity"] == severityFilter;
      bool statusMatch = statusFilter == "All Status" || 
        recall["status"] == statusFilter;
      return vehicleMatch && severityMatch && statusMatch;
    }).toList();
  }

  int get highSeverityRecalls {
    return filteredRecalls
      .where((recall) => recall["severity"] == "High")
      .length;
  }

  int get openRecalls {
    return filteredRecalls
      .where((recall) => recall["status"] == "Open")
      .length;
  }

  int get completedRecalls {
    return filteredRecalls
      .where((recall) => recall["status"] == "Completed")
      .length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recall Notices"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Refresh recall data
            },
          ),
          IconButton(
            icon: Icon(Icons.warning),
            onPressed: () {
              // View safety alerts
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters Section
            Container(
              padding: EdgeInsets.all(spSm),
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
                      Icon(Icons.filter_list, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Filter Recalls",
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
                        child: QDropdownField(
                          label: "Vehicle",
                          items: [
                            {"label": "All Vehicles", "value": "All Vehicles"},
                            {"label": "Honda Civic", "value": "Honda Civic"},
                            {"label": "Toyota Camry", "value": "Toyota Camry"},
                          ],
                          value: selectedVehicle,
                          onChanged: (value, label) {
                            selectedVehicle = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Severity",
                          items: [
                            {"label": "All Severity", "value": "All Severity"},
                            {"label": "High", "value": "High"},
                            {"label": "Medium", "value": "Medium"},
                            {"label": "Low", "value": "Low"},
                          ],
                          value: severityFilter,
                          onChanged: (value, label) {
                            severityFilter = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Status",
                    items: [
                      {"label": "All Status", "value": "All Status"},
                      {"label": "Open", "value": "Open"},
                      {"label": "In Progress", "value": "In Progress"},
                      {"label": "Completed", "value": "Completed"},
                    ],
                    value: statusFilter,
                    onChanged: (value, label) {
                      statusFilter = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.priority_high,
                            color: dangerColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "High Severity",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "$highSeverityRecalls recalls",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.pending_actions,
                            color: warningColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Open Recalls",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "$openRecalls recalls",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Completed",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "$completedRecalls recalls",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Recall Notices List
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
                    padding: EdgeInsets.all(spSm),
                    child: Row(
                      children: [
                        Icon(Icons.campaign, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Recall Details",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${filteredRecalls.length} notices",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredRecalls.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      color: disabledColor,
                    ),
                    itemBuilder: (context, index) {
                      final recall = filteredRecalls[index];
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getSeverityColor(recall["severity"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${recall["severity"]} RISK",
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: _getSeverityColor(recall["severity"]),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(recall["status"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${recall["status"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: _getStatusColor(recall["status"]),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${recall["recallNumber"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ],
                            ),
                            
                            Text(
                              "${recall["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            
                            Text(
                              "${recall["vehicle"]} (${recall["modelYears"]})",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: dangerColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.warning,
                                        size: 14,
                                        color: dangerColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "Safety Risk:",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: dangerColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${recall["safetyRisk"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: dangerColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            Text(
                              "${recall["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            
                            Row(
                              children: [
                                Icon(
                                  Icons.build,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "Components: ${(recall["components"] as List).join(", ")}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            Row(
                              spacing: spMd,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Remedy",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${recall["remedy"]}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: successColor,
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
                                        "Time Required",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${recall["estimatedTime"]}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: infoColor,
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
                                        "Cost",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${recall["cost"]}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: successColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.info,
                                        size: 14,
                                        color: infoColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "Affected Vehicles: ${(recall["affectedVehicles"] as int).toString().replaceAllMapped(
                                          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                          (Match m) => '${m[1]},'
                                        )}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: infoColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "VIN Range: ${recall["vinRange"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: infoColor,
                                      fontFamily: 'monospace',
                                    ),
                                  ),
                                  Text(
                                    "${recall["manufacturerResponse"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: infoColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            Row(
                              children: [
                                Icon(
                                  Icons.business,
                                  size: 14,
                                  color: primaryColor,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${recall["dealer"]}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.phone,
                                  size: 14,
                                  color: primaryColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${recall["contactNumber"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            
                            Row(
                              children: [
                                Text(
                                  "Issued: ${recall["dateIssued"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                                Spacer(),
                                QButton(
                                  label: "Schedule Repair",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Schedule recall repair
                                  },
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

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Open":
        return warningColor;
      case "In Progress":
        return infoColor;
      case "Completed":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }
}
