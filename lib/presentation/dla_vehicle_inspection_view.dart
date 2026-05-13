import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaVehicleInspectionView extends StatefulWidget {
  const DlaVehicleInspectionView({super.key});

  @override
  State<DlaVehicleInspectionView> createState() => _DlaVehicleInspectionViewState();
}

class _DlaVehicleInspectionViewState extends State<DlaVehicleInspectionView> {
  int currentTab = 0;
  String selectedVehicle = "";
  String inspectionType = "pre_trip";
  String inspectorName = "";
  String inspectionNotes = "";
  bool tiresCondition = false;
  bool brakesCondition = false;
  bool lightsCondition = false;
  bool fluidLevelsCondition = false;
  bool engineCondition = false;
  bool interiorCondition = false;
  bool exteriorCondition = false;
  bool documentsValid = false;

  final List<Map<String, dynamic>> vehicles = [
    {"label": "DLA-001 (Toyota Hiace)", "value": "DLA-001"},
    {"label": "DLA-002 (Isuzu Elf)", "value": "DLA-002"},
    {"label": "DLA-003 (Honda Beat)", "value": "DLA-003"},
    {"label": "DLA-004 (Toyota Avanza)", "value": "DLA-004"},
  ];

  final List<Map<String, dynamic>> inspectionTypes = [
    {"label": "Pre-Trip Inspection", "value": "pre_trip"},
    {"label": "Post-Trip Inspection", "value": "post_trip"},
    {"label": "Monthly Safety Check", "value": "monthly"},
    {"label": "Annual Inspection", "value": "annual"},
    {"label": "Emergency Check", "value": "emergency"},
  ];

  final List<Map<String, dynamic>> inspectionHistory = [
    {
      "id": "INS-001",
      "vehicleId": "DLA-001",
      "type": "Pre-Trip",
      "date": "2024-01-15",
      "inspector": "John Smith",
      "status": "passed",
      "score": 95,
      "issues": 0,
      "checkItems": 8,
      "passedItems": 8,
      "notes": "All systems functioning properly",
    },
    {
      "id": "INS-002",
      "vehicleId": "DLA-002",
      "type": "Monthly",
      "date": "2024-01-14",
      "inspector": "Sarah Johnson",
      "status": "failed",
      "score": 72,
      "issues": 3,
      "checkItems": 8,
      "passedItems": 5,
      "notes": "Brake pads need replacement, front tire worn",
    },
    {
      "id": "INS-003",
      "vehicleId": "DLA-003",
      "type": "Post-Trip",
      "date": "2024-01-13",
      "inspector": "Mike Wilson",
      "status": "passed",
      "score": 88,
      "issues": 1,
      "checkItems": 8,
      "passedItems": 7,
      "notes": "Oil level slightly low, refilled during inspection",
    },
    {
      "id": "INS-004",
      "vehicleId": "DLA-004",
      "type": "Annual",
      "date": "2024-01-12",
      "inspector": "Lisa Brown",
      "status": "conditional",
      "score": 78,
      "issues": 2,
      "checkItems": 8,
      "passedItems": 6,
      "notes": "Minor issues found, schedule maintenance",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "passed":
        return successColor;
      case "failed":
        return dangerColor;
      case "conditional":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "passed":
        return "Passed";
      case "failed":
        return "Failed";
      case "conditional":
        return "Conditional";
      default:
        return "Unknown";
    }
  }

  Widget _buildInspectionForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Inspection Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QDropdownField(
                  label: "Select Vehicle",
                  items: vehicles,
                  value: selectedVehicle,
                  onChanged: (value, label) {
                    selectedVehicle = value;
                    setState(() {});
                  },
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
                QTextField(
                  label: "Inspector Name",
                  value: inspectorName,
                  hint: "Enter inspector's full name",
                  onChanged: (value) {
                    inspectorName = value;
                    setState(() {});
                  },
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
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Vehicle Safety Checklist",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildChecklistItem("Tires & Wheels", "Check tire pressure, tread depth, and wheel condition", tiresCondition, (value) {
                  tiresCondition = value;
                  setState(() {});
                }),
                _buildChecklistItem("Braking System", "Test brakes, check brake fluid, inspect brake pads", brakesCondition, (value) {
                  brakesCondition = value;
                  setState(() {});
                }),
                _buildChecklistItem("Lights & Signals", "Verify all lights, indicators, and warning signals work", lightsCondition, (value) {
                  lightsCondition = value;
                  setState(() {});
                }),
                _buildChecklistItem("Fluid Levels", "Check engine oil, coolant, brake fluid, and other fluids", fluidLevelsCondition, (value) {
                  fluidLevelsCondition = value;
                  setState(() {});
                }),
                _buildChecklistItem("Engine Performance", "Listen for unusual sounds, check engine operation", engineCondition, (value) {
                  engineCondition = value;
                  setState(() {});
                }),
                _buildChecklistItem("Interior Condition", "Check seats, dashboard, controls, and safety equipment", interiorCondition, (value) {
                  interiorCondition = value;
                  setState(() {});
                }),
                _buildChecklistItem("Exterior Condition", "Inspect body, mirrors, windows, and external equipment", exteriorCondition, (value) {
                  exteriorCondition = value;
                  setState(() {});
                }),
                _buildChecklistItem("Documents & Registration", "Verify registration, insurance, and required permits", documentsValid, (value) {
                  documentsValid = value;
                  setState(() {});
                }),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Inspection Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.assessment, color: infoColor, size: 24),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Inspection Score",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${_calculateScore()}% (${_getPassedCount()}/8 items passed)",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: _getScoreColor(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                QMemoField(
                  label: "Inspection Notes",
                  value: inspectionNotes,
                  hint: "Enter any additional observations, issues found, or recommendations",
                  onChanged: (value) {
                    inspectionNotes = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Save Draft",
                  color: disabledBoldColor,
                  size: bs.md,
                  onPressed: () {
                    ss("Inspection draft saved successfully");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Submit Inspection",
                  size: bs.md,
                  onPressed: () {
                    ss("Vehicle inspection submitted successfully");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistItem(String title, String description, bool isChecked, Function(bool) onChanged) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isChecked ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: isChecked ? successColor : dangerColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Icon(
                isChecked ? Icons.check_circle : Icons.cancel,
                color: isChecked ? successColor : dangerColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
              Switch(
                value: isChecked,
                onChanged: onChanged,
                activeColor: successColor,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 36),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _getPassedCount() {
    int count = 0;
    if (tiresCondition) count++;
    if (brakesCondition) count++;
    if (lightsCondition) count++;
    if (fluidLevelsCondition) count++;
    if (engineCondition) count++;
    if (interiorCondition) count++;
    if (exteriorCondition) count++;
    if (documentsValid) count++;
    return count;
  }

  int _calculateScore() {
    return ((_getPassedCount() / 8) * 100).round();
  }

  Color _getScoreColor() {
    int score = _calculateScore();
    if (score >= 90) return successColor;
    if (score >= 70) return warningColor;
    return dangerColor;
  }

  Widget _buildInspectionHistory() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Icon(Icons.history, color: primaryColor, size: 24),
                SizedBox(width: spSm),
                Text(
                  "Inspection History",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: () {
                    si("Filter inspection history");
                  },
                ),
              ],
            ),
          ),
          ...inspectionHistory.map((inspection) {
            Color statusColor = _getStatusColor(inspection["status"]);
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          _getStatusLabel(inspection["status"]),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${inspection["id"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.local_shipping, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "${inspection["vehicleId"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${inspection["type"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.person, color: disabledBoldColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "${inspection["inspector"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.calendar_today, color: disabledBoldColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "${inspection["date"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  if (inspection["notes"].toString().isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.note, color: disabledBoldColor, size: 16),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${inspection["notes"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Divider(color: disabledColor),
                  Row(
                    spacing: spMd,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${inspection["score"]}%",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: statusColor,
                              ),
                            ),
                            Text(
                              "Score",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${inspection["passedItems"]}/${inspection["checkItems"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Items Passed",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${inspection["issues"]}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: (inspection["issues"] as int) > 0 ? dangerColor : successColor,
                              ),
                            ),
                            Text(
                              "Issues",
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
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {
                            si("View inspection details: ${inspection["id"]}");
                          },
                        ),
                      ),
                      if ((inspection["issues"] as int) > 0)
                        Expanded(
                          child: QButton(
                            label: "Follow Up",
                            color: warningColor,
                            size: bs.sm,
                            onPressed: () {
                              si("Follow up on issues: ${inspection["id"]}");
                            },
                          ),
                        ),
                      QButton(
                        icon: Icons.print,
                        size: bs.sm,
                        onPressed: () {
                          si("Print inspection report: ${inspection["id"]}");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    int totalInspections = inspectionHistory.length;
    int passedInspections = inspectionHistory.where((i) => i["status"] == "passed").length;
    int failedInspections = inspectionHistory.where((i) => i["status"] == "failed").length;
    int conditionalInspections = inspectionHistory.where((i) => i["status"] == "conditional").length;
    double avgScore = inspectionHistory.fold(0.0, (sum, item) => sum + (item["score"] as int).toDouble()) / inspectionHistory.length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Inspection Overview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "$totalInspections",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total",
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
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "$passedInspections",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Passed",
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
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "$conditionalInspections",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Conditional",
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
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "$failedInspections",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Failed",
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
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: infoColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Average Score: ${avgScore.toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
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
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
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
                  List<Map<String, dynamic>> vehicleInspections = inspectionHistory.where((i) => i["vehicleId"] == vehicle["value"]).toList();
                  
                  if (vehicleInspections.isEmpty) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: warningColor, width: 1),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.local_shipping, color: warningColor, size: 20),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              vehicle["value"],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "No Inspections",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  
                  Map<String, dynamic> latestInspection = vehicleInspections.first;
                  Color statusColor = _getStatusColor(latestInspection["status"]);
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: statusColor, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.local_shipping, color: statusColor, size: 20),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                vehicle["value"],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                _getStatusLabel(latestInspection["status"]),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: statusColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Last: ${latestInspection["date"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Score: ${latestInspection["score"]}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: statusColor,
                              ),
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
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Export Report",
                  size: bs.md,
                  onPressed: () {
                    ss("Inspection report exported successfully");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Print Summary",
                  color: disabledBoldColor,
                  size: bs.md,
                  onPressed: () {
                    si("Printing inspection summary");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Vehicle Inspection",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "New Inspection", icon: Icon(Icons.add_task)),
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Reports", icon: Icon(Icons.assessment)),
      ],
      tabChildren: [
        _buildInspectionForm(),
        _buildInspectionHistory(),
        _buildReportsTab(),
      ],
    );
  }
}
