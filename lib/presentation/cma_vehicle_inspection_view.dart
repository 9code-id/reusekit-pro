import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaVehicleInspectionView extends StatefulWidget {
  const CmaVehicleInspectionView({super.key});

  @override
  State<CmaVehicleInspectionView> createState() => _CmaVehicleInspectionViewState();
}

class _CmaVehicleInspectionViewState extends State<CmaVehicleInspectionView> {
  int currentTab = 0;
  String selectedVehicle = "";
  String selectedInspector = "";
  String selectedStatus = "";
  String inspectionType = "";
  String inspectionNotes = "";
  String inspectionDate = "";
  
  List<Map<String, dynamic>> inspectionRecords = [
    {
      "id": "INS001",
      "vehicle": "TRK-001",
      "type": "Safety Inspection",
      "date": "2025-06-15",
      "inspector": "Mike Johnson",
      "status": "Passed",
      "score": 95,
      "duration": "2h 30m",
      "mileage": 45250,
      "nextDue": "2025-12-15",
      "issues": [
        {"item": "Brake Pads", "status": "Good", "severity": "Low"},
        {"item": "Tire Condition", "status": "Fair", "severity": "Medium"},
        {"item": "Engine Oil", "status": "Excellent", "severity": "Low"},
      ],
      "checklist": {
        "brakes": true,
        "lights": true,
        "tires": false,
        "engine": true,
        "transmission": true,
        "suspension": true,
        "steering": true,
        "exhaust": true,
        "electrical": true,
        "bodyWork": true
      },
      "cost": 150.00,
      "location": "Main Service Center",
      "certificationNumber": "CERT-2025-001",
      "photos": ["front_view.jpg", "brake_check.jpg", "tire_check.jpg"]
    },
    {
      "id": "INS002",
      "vehicle": "VAN-002",
      "type": "Emissions Test",
      "date": "2025-06-10",
      "inspector": "Sarah Williams",
      "status": "Failed",
      "score": 65,
      "duration": "1h 45m",
      "mileage": 28750,
      "nextDue": "2025-06-25",
      "issues": [
        {"item": "Exhaust System", "status": "Poor", "severity": "High"},
        {"item": "Catalytic Converter", "status": "Needs Replacement", "severity": "Critical"},
        {"item": "Air Filter", "status": "Dirty", "severity": "Medium"},
      ],
      "checklist": {
        "brakes": true,
        "lights": true,
        "tires": true,
        "engine": false,
        "transmission": true,
        "suspension": true,
        "steering": true,
        "exhaust": false,
        "electrical": true,
        "bodyWork": true
      },
      "cost": 85.00,
      "location": "EPA Testing Center",
      "certificationNumber": "",
      "photos": ["exhaust_check.jpg", "converter_damage.jpg"]
    },
    {
      "id": "INS003",
      "vehicle": "TRK-003",
      "type": "Pre-Trip Inspection",
      "date": "2025-06-18",
      "inspector": "David Chen",
      "status": "Passed",
      "score": 98,
      "duration": "45m",
      "mileage": 52100,
      "nextDue": "2025-06-19",
      "issues": [
        {"item": "All Systems", "status": "Excellent", "severity": "Low"},
        {"item": "Cargo Area", "status": "Clean", "severity": "Low"},
      ],
      "checklist": {
        "brakes": true,
        "lights": true,
        "tires": true,
        "engine": true,
        "transmission": true,
        "suspension": true,
        "steering": true,
        "exhaust": true,
        "electrical": true,
        "bodyWork": true
      },
      "cost": 0.00,
      "location": "Driver Self-Check",
      "certificationNumber": "PRE-2025-003",
      "photos": ["pre_trip_1.jpg", "pre_trip_2.jpg"]
    }
  ];

  List<Map<String, dynamic>> vehicles = [
    {"label": "TRK-001 - Delivery Truck", "value": "TRK-001"},
    {"label": "VAN-002 - Cargo Van", "value": "VAN-002"},
    {"label": "TRK-003 - Heavy Truck", "value": "TRK-003"},
    {"label": "CAR-004 - Service Car", "value": "CAR-004"}
  ];

  List<Map<String, dynamic>> inspectors = [
    {"label": "Mike Johnson", "value": "mike_johnson"},
    {"label": "Sarah Williams", "value": "sarah_williams"},
    {"label": "David Chen", "value": "david_chen"},
    {"label": "Lisa Anderson", "value": "lisa_anderson"}
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "Passed", "value": "passed"},
    {"label": "Failed", "value": "failed"},
    {"label": "Pending", "value": "pending"},
    {"label": "Scheduled", "value": "scheduled"}
  ];

  List<Map<String, dynamic>> inspectionTypes = [
    {"label": "Safety Inspection", "value": "safety"},
    {"label": "Emissions Test", "value": "emissions"},
    {"label": "Pre-Trip Inspection", "value": "pre_trip"},
    {"label": "Annual Inspection", "value": "annual"},
    {"label": "DOT Inspection", "value": "dot"}
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Vehicle Inspection",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Inspections", icon: Icon(Icons.search)),
        Tab(text: "Schedule", icon: Icon(Icons.schedule)),
        Tab(text: "Reports", icon: Icon(Icons.assessment)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildInspectionsTab(),
        _buildScheduleTab(),
        _buildReportsTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildInspectionOverviewCards(),
          _buildRecentInspections(),
          _buildUpcomingInspections(),
        ],
      ),
    );
  }

  Widget _buildInspectionOverviewCards() {
    int totalInspections = inspectionRecords.length;
    int passedCount = inspectionRecords.where((r) => r["status"] == "Passed").length;
    int failedCount = inspectionRecords.where((r) => r["status"] == "Failed").length;
    double avgScore = inspectionRecords.fold(0.0, (sum, r) => sum + (r["score"] as int)) / totalInspections;
    double totalCosts = inspectionRecords.fold(0.0, (sum, r) => sum + (r["cost"] as double));
    
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildOverviewCard("Total Inspections", "$totalInspections", Icons.search, primaryColor, "This Month"),
        _buildOverviewCard("Passed", "$passedCount", Icons.check_circle, successColor, "${((passedCount / totalInspections) * 100).toStringAsFixed(1)}%"),
        _buildOverviewCard("Failed", "$failedCount", Icons.error, dangerColor, failedCount > 0 ? "Needs Attention" : "All Clear"),
        _buildOverviewCard("Avg Score", "${avgScore.toStringAsFixed(1)}", Icons.star, warningColor, "+3.2%"),
      ],
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color, String subtitle) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  subtitle,
                  style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentInspections() {
    List<Map<String, dynamic>> recentInspections = [...inspectionRecords]
      ..sort((a, b) => b["date"].toString().compareTo(a["date"].toString()));
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Text(
                "Recent Inspections",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "Last 7 Days",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          ...recentInspections.take(3).map((inspection) => _buildRecentInspectionItem(inspection)).toList(),
        ],
      ),
    );
  }

  Widget _buildRecentInspectionItem(Map<String, dynamic> inspection) {
    Color statusColor = inspection["status"] == "Passed" ? successColor : 
                       inspection["status"] == "Failed" ? dangerColor : warningColor;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(Icons.search, color: statusColor, size: 20),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${inspection["type"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${inspection["date"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${inspection["vehicle"]}",
                      style: TextStyle(
                        color: infoColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    Text(" • ", style: TextStyle(color: disabledBoldColor)),
                    Text(
                      "Score: ${inspection["score"]}",
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    Text(" • ", style: TextStyle(color: disabledBoldColor)),
                    Text(
                      "${inspection["inspector"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${inspection["status"]}",
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingInspections() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Upcoming Inspections",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ...inspectionRecords.where((i) => i["nextDue"] != null).take(3).map((inspection) => Container(
            padding: EdgeInsets.all(spSm),
            margin: EdgeInsets.only(bottom: spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor.withAlpha(20)),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Icon(Icons.schedule, color: infoColor, size: 16),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${inspection["vehicle"]} - ${inspection["type"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Due: ${inspection["nextDue"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "Schedule",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildInspectionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildInspectionFilters(),
          _buildInspectionsList(),
        ],
      ),
    );
  }

  Widget _buildInspectionFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Filter Inspections",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Vehicle",
                  items: vehicles,
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
                  label: "Inspector",
                  items: inspectors,
                  value: selectedInspector,
                  onChanged: (value, label) {
                    selectedInspector = value;
                    setState(() {});
                  },
                ),
              ),
            ],
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
    );
  }

  Widget _buildInspectionsList() {
    return Column(
      spacing: spSm,
      children: inspectionRecords.map((inspection) => _buildInspectionCard(inspection)).toList(),
    );
  }

  Widget _buildInspectionCard(Map<String, dynamic> inspection) {
    Color statusColor = inspection["status"] == "Passed" ? successColor : 
                       inspection["status"] == "Failed" ? dangerColor : warningColor;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(Icons.search, color: statusColor, size: 24),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${inspection["type"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${inspection["status"]}",
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "ID: ${inspection["id"]} • ${inspection["date"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(Icons.local_shipping, color: primaryColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${inspection["vehicle"]}",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.person, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${inspection["inspector"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                
                Row(
                  children: [
                    Icon(Icons.location_on, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${inspection["location"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.access_time, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${inspection["duration"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 120,
            children: [
              _buildInspectionMetric("Score", "${inspection["score"]}", Icons.star),
              _buildInspectionMetric("Mileage", "${inspection["mileage"]} km", Icons.speed),
              _buildInspectionMetric("Cost", "\$${(inspection["cost"] as double).toStringAsFixed(2)}", Icons.attach_money),
              _buildInspectionMetric("Issues", "${(inspection["issues"] as List).length}", Icons.error),
            ],
          ),

          if ((inspection["issues"] as List).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning, color: warningColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "Issues Found (${(inspection["issues"] as List).length})",
                        style: TextStyle(
                          color: warningColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  ...((inspection["issues"] as List).map((issue) => Padding(
                    padding: EdgeInsets.only(left: spMd),
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: issue["severity"] == "Critical" ? dangerColor : 
                                   issue["severity"] == "High" ? warningColor : infoColor,
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${issue["item"]}: ${issue["status"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )).toList()),
                ],
              ),
            ),

          if (inspection["certificationNumber"].toString().isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.verified, color: successColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "Certification: ${inspection["certificationNumber"]}",
                    style: TextStyle(
                      color: successColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.print,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.photo,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInspectionMetric(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        children: [
          Icon(icon, color: disabledBoldColor, size: 16),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryColor,
              fontSize: 11,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Schedule New Inspection",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                QDropdownField(
                  label: "Inspection Type",
                  items: inspectionTypes,
                  value: inspectionType,
                  onChanged: (value, label) {
                    inspectionType = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Vehicle",
                        items: vehicles,
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
                        label: "Inspector",
                        items: inspectors,
                        value: selectedInspector,
                        onChanged: (value, label) {
                          selectedInspector = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QDatePicker(
                  label: "Inspection Date",
                  value: inspectionDate.isNotEmpty ? DateTime.parse(inspectionDate) : DateTime.now(),
                  onChanged: (value) {
                    inspectionDate = value.toString().split(' ')[0];
                    setState(() {});
                  },
                ),

                QMemoField(
                  label: "Inspection Notes",
                  value: inspectionNotes,
                  hint: "Enter any specific inspection requirements or notes",
                  onChanged: (value) {
                    inspectionNotes = value;
                    setState(() {});
                  },
                ),

                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Schedule Inspection",
                    size: bs.md,
                    onPressed: () {
                      ss("Inspection scheduled successfully!");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildInspectionStatistics(),
          _buildInspectionTrends(),
          _buildVehicleInspectionStatus(),
        ],
      ),
    );
  }

  Widget _buildInspectionStatistics() {
    Map<String, int> checklistStats = {};
    for (var inspection in inspectionRecords) {
      Map<String, dynamic> checklist = inspection["checklist"];
      checklist.forEach((key, value) {
        if (!checklistStats.containsKey(key)) {
          checklistStats[key] = 0;
        }
        if (value) checklistStats[key] = checklistStats[key]! + 1;
      });
    }
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Inspection Statistics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildStatCard("Pass Rate", "${((inspectionRecords.where((r) => r["status"] == "Passed").length / inspectionRecords.length) * 100).toStringAsFixed(1)}%", Icons.check_circle, successColor),
              _buildStatCard("Avg Score", "${(inspectionRecords.fold(0.0, (sum, r) => sum + (r["score"] as int)) / inspectionRecords.length).toStringAsFixed(1)}", Icons.star, warningColor),
              _buildStatCard("Total Cost", "\$${inspectionRecords.fold(0.0, (sum, r) => sum + (r["cost"] as double)).toStringAsFixed(0)}", Icons.attach_money, infoColor),
              _buildStatCard("Avg Duration", "${(inspectionRecords.length * 1.5).toStringAsFixed(1)}h", Icons.access_time, primaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInspectionTrends() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Inspection Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Container(
            height: 200,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.trending_up, color: successColor, size: 48),
                  SizedBox(height: spSm),
                  Text(
                    "Inspection Quality Improving",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Average score increased by 8% this month",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleInspectionStatus() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Vehicle Inspection Status",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ...vehicles.map((vehicle) {
            String vehicleId = vehicle["value"];
            List<Map<String, dynamic>> vehicleInspections = inspectionRecords.where((r) => r["vehicle"] == vehicleId).toList();
            Map<String, dynamic>? lastInspection = vehicleInspections.isNotEmpty ? vehicleInspections.last : null;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(20)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Icon(Icons.local_shipping, color: primaryColor, size: 20),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${vehicle["label"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        if (lastInspection != null)
                          Text(
                            "Last: ${lastInspection["date"]} • Score: ${lastInspection["score"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          )
                        else
                          Text(
                            "No inspections recorded",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (lastInspection != null)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: lastInspection["status"] == "Passed" ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${lastInspection["status"]}",
                        style: TextStyle(
                          color: lastInspection["status"] == "Passed" ? successColor : dangerColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
