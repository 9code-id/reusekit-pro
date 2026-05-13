import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaAccidentManagementView extends StatefulWidget {
  const LtaAccidentManagementView({super.key});

  @override
  State<LtaAccidentManagementView> createState() => _LtaAccidentManagementViewState();
}

class _LtaAccidentManagementViewState extends State<LtaAccidentManagementView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedSeverity = "All";
  String selectedType = "All";

  List<Map<String, dynamic>> accidents = [
    {
      "id": "ACC-2024-001",
      "title": "Bus-Car Collision",
      "description": "Bus collided with private car at traffic junction",
      "type": "Vehicle Collision",
      "severity": "Critical",
      "status": "Under Investigation",
      "dateTime": "2024-01-15T08:45:00",
      "location": "Junction of Orchard Road & Scotts Road",
      "vehicleId": "SBS8001X",
      "route": "Service 14",
      "driverName": "Ahmad Rahman",
      "driverLicense": "DL123456789",
      "passengersAffected": 35,
      "injuries": {
        "serious": 2,
        "minor": 5,
        "none": 28,
      },
      "policeReport": "PR-2024-001",
      "ambulanceCalled": true,
      "fireServiceCalled": false,
      "insuranceClaim": "INS-2024-001",
      "estimatedCost": 45000.0,
      "witnesses": [
        {"name": "John Tan", "contact": "+65 9123 4567"},
        {"name": "Mary Lim", "contact": "+65 9234 5678"},
      ],
      "images": ["https://picsum.photos/300/200?random=1&keyword=accident"],
      "assignedOfficer": "Inspector Chen Wei Ming",
      "lastUpdated": "2024-01-15T16:30:00",
      "nextAction": "Interview remaining witnesses",
      "completionDate": null,
      "thirdPartyVehicle": "SGP1234A",
      "thirdPartyDriver": "David Wong",
      "thirdPartyInsurance": "AIG Insurance",
      "roadCondition": "Wet",
      "weather": "Light Rain",
      "trafficCondition": "Heavy",
      "speedLimit": "50 km/h",
      "estimatedSpeed": "45 km/h",
    },
    {
      "id": "ACC-2024-002",
      "title": "Passenger Fall Accident",
      "description": "Elderly passenger fell while alighting from bus",
      "type": "Passenger Injury",
      "severity": "High",
      "status": "Investigation Complete",
      "dateTime": "2024-01-14T17:20:00",
      "location": "Bedok MRT Station Bus Stop",
      "vehicleId": "SMRT2045",
      "route": "Service 222",
      "driverName": "Raj Kumar",
      "driverLicense": "DL987654321",
      "passengersAffected": 1,
      "injuries": {
        "serious": 1,
        "minor": 0,
        "none": 0,
      },
      "policeReport": "PR-2024-002",
      "ambulanceCalled": true,
      "fireServiceCalled": false,
      "insuranceClaim": "INS-2024-002",
      "estimatedCost": 8500.0,
      "witnesses": [
        {"name": "Sarah Teo", "contact": "+65 9345 6789"},
        {"name": "Kumar Singh", "contact": "+65 9456 7890"},
        {"name": "Lisa Chen", "contact": "+65 9567 8901"},
      ],
      "images": ["https://picsum.photos/300/200?random=2&keyword=injury"],
      "assignedOfficer": "Sergeant Lim Hong Wei",
      "lastUpdated": "2024-01-15T12:00:00",
      "nextAction": "Prepare final report",
      "completionDate": null,
      "thirdPartyVehicle": null,
      "thirdPartyDriver": null,
      "thirdPartyInsurance": null,
      "roadCondition": "Dry",
      "weather": "Clear",
      "trafficCondition": "Moderate",
      "speedLimit": "50 km/h",
      "estimatedSpeed": "15 km/h",
    },
    {
      "id": "ACC-2024-003",
      "title": "Bus Breakdown Incident",
      "description": "Bus broke down causing minor rear-end collision",
      "type": "Breakdown Related",
      "severity": "Medium",
      "status": "Resolved",
      "dateTime": "2024-01-13T14:30:00",
      "location": "Tampines Avenue 2",
      "vehicleId": "SBS7023Y",
      "route": "Service 291",
      "driverName": "Wong Mei Ling",
      "driverLicense": "DL456789123",
      "passengersAffected": 28,
      "injuries": {
        "serious": 0,
        "minor": 1,
        "none": 27,
      },
      "policeReport": "PR-2024-003",
      "ambulanceCalled": false,
      "fireServiceCalled": false,
      "insuranceClaim": "INS-2024-003",
      "estimatedCost": 12000.0,
      "witnesses": [
        {"name": "Peter Ng", "contact": "+65 9678 9012"},
      ],
      "images": ["https://picsum.photos/300/200?random=3&keyword=breakdown"],
      "assignedOfficer": "Corporal Rahman Ali",
      "lastUpdated": "2024-01-14T09:00:00",
      "nextAction": "Case closed",
      "completionDate": "2024-01-14T09:00:00",
      "thirdPartyVehicle": "SGP5678B",
      "thirdPartyDriver": "Amy Chong",
      "thirdPartyInsurance": "NTUC Income",
      "roadCondition": "Dry",
      "weather": "Sunny",
      "trafficCondition": "Light",
      "speedLimit": "60 km/h",
      "estimatedSpeed": "0 km/h",
    },
    {
      "id": "ACC-2024-004",
      "title": "Motorcycle-Bus Collision",
      "description": "Motorcycle hit bus while changing lanes",
      "type": "Vehicle Collision",
      "severity": "High",
      "status": "Pending Documentation",
      "dateTime": "2024-01-12T18:45:00",
      "location": "Marina Bay Link",
      "vehicleId": "SMRT3012",
      "route": "Service 106",
      "driverName": "Hassan Ibrahim",
      "driverLicense": "DL789123456",
      "passengersAffected": 42,
      "injuries": {
        "serious": 1,
        "minor": 0,
        "none": 41,
      },
      "policeReport": "PR-2024-004",
      "ambulanceCalled": true,
      "fireServiceCalled": false,
      "insuranceClaim": "INS-2024-004",
      "estimatedCost": 18000.0,
      "witnesses": [
        {"name": "Michelle Tan", "contact": "+65 9789 0123"},
        {"name": "Robert Lee", "contact": "+65 9890 1234"},
      ],
      "images": ["https://picsum.photos/300/200?random=4&keyword=motorcycle"],
      "assignedOfficer": "Inspector Janet Loh",
      "lastUpdated": "2024-01-13T11:30:00",
      "nextAction": "Obtain final medical reports",
      "completionDate": null,
      "thirdPartyVehicle": "FBE1234C",
      "thirdPartyDriver": "Alex Tan",
      "thirdPartyInsurance": "Great Eastern",
      "roadCondition": "Dry",
      "weather": "Clear",
      "trafficCondition": "Heavy",
      "speedLimit": "70 km/h",
      "estimatedSpeed": "65 km/h",
    },
  ];

  List<Map<String, dynamic>> accidentTypes = [
    {"label": "All", "value": "All"},
    {"label": "Vehicle Collision", "value": "Vehicle Collision"},
    {"label": "Passenger Injury", "value": "Passenger Injury"},
    {"label": "Breakdown Related", "value": "Breakdown Related"},
    {"label": "Infrastructure", "value": "Infrastructure"},
  ];

  List<Map<String, dynamic>> severityLevels = [
    {"label": "All", "value": "All"},
    {"label": "Critical", "value": "Critical"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Under Investigation", "value": "Under Investigation"},
    {"label": "Investigation Complete", "value": "Investigation Complete"},
    {"label": "Pending Documentation", "value": "Pending Documentation"},
    {"label": "Resolved", "value": "Resolved"},
    {"label": "Closed", "value": "Closed"},
  ];

  List<Map<String, dynamic>> get filteredAccidents {
    return accidents.where((accident) {
      bool matchesSearch = accident["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          accident["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          accident["vehicleId"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || accident["status"] == selectedStatus;
      bool matchesSeverity = selectedSeverity == "All" || accident["severity"] == selectedSeverity;
      bool matchesType = selectedType == "All" || accident["type"] == selectedType;
      
      return matchesSearch && matchesStatus && matchesSeverity && matchesType;
    }).toList();
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
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

  Color _getStatusColor(String status) {
    switch (status) {
      case "Resolved":
      case "Closed":
        return successColor;
      case "Investigation Complete":
        return infoColor;
      case "Under Investigation":
        return warningColor;
      case "Pending Documentation":
        return disabledBoldColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildAccidentReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filters
          QTextField(
            label: "Search Accidents",
            value: searchQuery,
            hint: "Search by ID, title, or vehicle...",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusOptions,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Severity",
                  items: severityLevels,
                  value: selectedSeverity,
                  onChanged: (value, label) {
                    selectedSeverity = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          QDropdownField(
            label: "Accident Type",
            items: accidentTypes,
            value: selectedType,
            onChanged: (value, label) {
              selectedType = value;
              setState(() {});
            },
          ),

          // Statistics Cards
          Row(
            spacing: spSm,
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
                    children: [
                      Icon(Icons.car_crash, color: dangerColor, size: 32),
                      SizedBox(height: spSm),
                      Text(
                        "${accidents.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Total Accidents",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.local_hospital, color: Colors.orange, size: 32),
                      SizedBox(height: spSm),
                      Text(
                        "${accidents.map((a) => ((a["injuries"] as Map)["serious"] as int) + ((a["injuries"] as Map)["minor"] as int)).reduce((a, b) => a + b)}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      Text(
                        "Total Injuries",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.check_circle, color: successColor, size: 32),
                      SizedBox(height: spSm),
                      Text(
                        "${accidents.where((a) => a["status"] == "Resolved" || a["status"] == "Closed").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Resolved",
                        textAlign: TextAlign.center,
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

          // Accidents List
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
                  child: Text(
                    "Accident Reports (${filteredAccidents.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: filteredAccidents.length,
                  separatorBuilder: (context, index) => Divider(height: 1),
                  itemBuilder: (context, index) {
                    final accident = filteredAccidents[index];
                    final injuries = accident["injuries"] as Map;
                    return Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                          decoration: BoxDecoration(
                                            color: _getSeverityColor("${accident["severity"]}").withAlpha(30),
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: Text(
                                            "${accident["severity"]}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: _getSeverityColor("${accident["severity"]}"),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                          decoration: BoxDecoration(
                                            color: _getStatusColor("${accident["status"]}").withAlpha(30),
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: Text(
                                            "${accident["status"]}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: _getStatusColor("${accident["status"]}"),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spSm),
                                    Text(
                                      "${accident["id"]} - ${accident["title"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${accident["description"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  QButton(
                                    icon: Icons.visibility,
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                  SizedBox(height: spXs),
                                  QButton(
                                    icon: Icons.edit,
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${accident["location"]}",
                                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(Icons.directions_bus, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${accident["vehicleId"]} - ${accident["route"]}",
                                style: TextStyle(fontSize: 12, color: disabledBoldColor),
                              ),
                              SizedBox(width: spMd),
                              Icon(Icons.person, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${accident["driverName"]}",
                                style: TextStyle(fontSize: 12, color: disabledBoldColor),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: dangerColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.local_hospital, size: 12, color: dangerColor),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Serious: ${injuries["serious"]}",
                                      style: TextStyle(fontSize: 10, color: dangerColor),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: spSm),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: warningColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.healing, size: 12, color: warningColor),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Minor: ${injuries["minor"]}",
                                      style: TextStyle(fontSize: 10, color: warningColor),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${DateTime.parse("${accident["dateTime"]}").dMMMykkss}",
                                style: TextStyle(fontSize: 12, color: disabledBoldColor),
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
    );
  }

  Widget _buildInvestigationTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Active Investigations
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
                Text(
                  "Active Investigations",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: accidents.where((a) => a["status"] == "Under Investigation").length,
                  separatorBuilder: (context, index) => SizedBox(height: spSm),
                  itemBuilder: (context, index) {
                    final activeAccidents = accidents.where((a) => a["status"] == "Under Investigation").toList();
                    final accident = activeAccidents[index];
                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: warningColor, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${accident["id"]} - ${accident["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getSeverityColor("${accident["severity"]}"),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${accident["severity"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Icon(Icons.badge, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "Officer: ${accident["assignedOfficer"]}",
                                style: TextStyle(fontSize: 12, color: disabledBoldColor),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(Icons.task, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "Next: ${accident["nextAction"]}",
                                style: TextStyle(fontSize: 12, color: disabledBoldColor),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Update Progress",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.visibility,
                                size: bs.sm,
                                onPressed: () {},
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

          // Investigation Timeline Template
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
                Text(
                  "Investigation Process",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildInvestigationStep("Initial Response", "Secure scene, ensure safety", true),
                _buildInvestigationStep("Evidence Collection", "Photos, measurements, statements", true),
                _buildInvestigationStep("Witness Interviews", "Collect witness testimonies", true),
                _buildInvestigationStep("Technical Analysis", "Vehicle inspection, data analysis", false),
                _buildInvestigationStep("Report Compilation", "Prepare preliminary findings", false),
                _buildInvestigationStep("Final Report", "Submit completed investigation", false),
              ],
            ),
          ),

          // Investigation Tools
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
                Text(
                  "Investigation Tools",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Photo Manager",
                        icon: Icons.camera_alt,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Witness List",
                        icon: Icons.people,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Evidence Log",
                        icon: Icons.list_alt,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Report Generator",
                        icon: Icons.description,
                        size: bs.sm,
                        onPressed: () {},
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
  }

  Widget _buildInvestigationStep(String title, String description, bool completed) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: completed ? successColor : disabledColor,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              completed ? Icons.check : Icons.circle,
              size: 16,
              color: Colors.white,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: completed ? primaryColor : disabledBoldColor,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Monthly Statistics
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
                Text(
                  "Accident Statistics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "12",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "This Month",
                              style: TextStyle(
                                fontSize: 12,
                                color: dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "8",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Last Month",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Accident Types Breakdown
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
                Text(
                  "Accidents by Type",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Column(
                  children: [
                    _buildTypeStatRow("Vehicle Collision", 6, dangerColor),
                    _buildTypeStatRow("Passenger Injury", 3, warningColor),
                    _buildTypeStatRow("Breakdown Related", 2, infoColor),
                    _buildTypeStatRow("Infrastructure", 1, successColor),
                  ],
                ),
              ],
            ),
          ),

          // Cost Analysis
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
                Text(
                  "Financial Impact",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "\$83,500",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Total Cost (MTD)",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                color: dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "\$20,875",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Avg per Accident",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Investigation Performance
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
                Text(
                  "Investigation Performance",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.timer, color: primaryColor, size: 24),
                            SizedBox(height: spSm),
                            Text(
                              "4.2 days",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Avg Resolution",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.trending_up, color: successColor, size: 24),
                            SizedBox(height: spSm),
                            Text(
                              "83%",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Resolution Rate",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.trending_down, color: warningColor, size: 24),
                            SizedBox(height: spSm),
                            Text(
                              "-15%",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "vs Last Month",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
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
  }

  Widget _buildTypeStatRow(String type, int count, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              type,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
          Text(
            "$count",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Accident Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Reports", icon: Icon(Icons.car_crash)),
        Tab(text: "Investigation", icon: Icon(Icons.search)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildAccidentReportsTab(),
        _buildInvestigationTab(),
        _buildAnalyticsTab(),
      ],
    );
  }
}
