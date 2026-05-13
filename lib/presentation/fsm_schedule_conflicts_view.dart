import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmScheduleConflictsView extends StatefulWidget {
  const FsmScheduleConflictsView({super.key});

  @override
  State<FsmScheduleConflictsView> createState() => _FsmScheduleConflictsViewState();
}

class _FsmScheduleConflictsViewState extends State<FsmScheduleConflictsView> {
  int selectedFilterIndex = 0;
  String searchQuery = "";
  bool showResolvedConflicts = false;
  
  List<Map<String, dynamic>> conflicts = [
    {
      "id": "CNF001",
      "type": "Double Booking",
      "severity": "Critical",
      "technician": "Mike Johnson",
      "technicianImage": "https://picsum.photos/40/40?random=101",
      "appointment1": {
        "id": "APT001",
        "customer": "ABC Electronics",
        "service": "Equipment Installation",
        "time": "09:00 AM - 11:00 AM",
        "location": "Downtown Office",
        "priority": "High"
      },
      "appointment2": {
        "id": "APT002", 
        "customer": "Tech Solutions",
        "service": "Network Setup",
        "time": "10:00 AM - 12:00 PM",
        "location": "Business Park",
        "priority": "Medium"
      },
      "detectedAt": "2024-01-15 08:30:00",
      "status": "Unresolved",
      "estimatedResolutionTime": "15 mins",
      "autoResolutionOptions": 3,
      "impactScore": 85
    },
    {
      "id": "CNF002",
      "type": "Skill Mismatch",
      "severity": "High",
      "technician": "Sarah Davis",
      "technicianImage": "https://picsum.photos/40/40?random=102",
      "appointment1": {
        "id": "APT003",
        "customer": "Power Systems Inc",
        "service": "Electrical Repair",
        "time": "02:00 PM - 04:00 PM",
        "location": "Industrial Zone",
        "priority": "Critical",
        "requiredSkills": ["Electrical", "High Voltage"],
        "technicianSkills": ["HVAC", "General Maintenance"]
      },
      "detectedAt": "2024-01-15 09:15:00",
      "status": "In Progress",
      "estimatedResolutionTime": "25 mins",
      "autoResolutionOptions": 2,
      "impactScore": 72,
      "suggestedTechnicians": [
        {"name": "John Smith", "skillMatch": 95, "availability": "Available"},
        {"name": "Robert Chen", "skillMatch": 88, "availability": "Busy until 1:30 PM"}
      ]
    },
    {
      "id": "CNF003",
      "type": "Location Conflict",
      "severity": "Medium",
      "technician": "David Wilson",
      "technicianImage": "https://picsum.photos/40/40?random=103",
      "appointment1": {
        "id": "APT004",
        "customer": "City Mall",
        "service": "Security System Check",
        "time": "11:00 AM - 12:00 PM",
        "location": "City Mall - North Wing",
        "priority": "Medium"
      },
      "appointment2": {
        "id": "APT005",
        "customer": "Bank Branch",
        "service": "ATM Maintenance", 
        "time": "12:15 PM - 01:15 PM",
        "location": "Downtown Bank (25 miles away)",
        "priority": "High"
      },
      "detectedAt": "2024-01-15 10:00:00",
      "status": "Auto-Resolved",
      "estimatedResolutionTime": "5 mins",
      "autoResolutionOptions": 4,
      "impactScore": 45,
      "resolutionAction": "Adjusted travel time buffer from 15 to 45 minutes"
    },
    {
      "id": "CNF004",
      "type": "Resource Unavailable",
      "severity": "High",
      "technician": "Lisa Anderson",
      "technicianImage": "https://picsum.photos/40/40?random=104",
      "appointment1": {
        "id": "APT006",
        "customer": "Manufacturing Corp",
        "service": "Crane Inspection",
        "time": "03:00 PM - 05:00 PM",
        "location": "Factory District",
        "priority": "Critical",
        "requiredEquipment": ["Crane Inspection Kit", "Safety Harness"],
        "availableEquipment": ["Safety Harness"]
      },
      "detectedAt": "2024-01-15 11:30:00",
      "status": "Unresolved",
      "estimatedResolutionTime": "45 mins",
      "autoResolutionOptions": 1,
      "impactScore": 78
    },
    {
      "id": "CNF005",
      "type": "Overtime Violation", 
      "severity": "Low",
      "technician": "Mark Thompson",
      "technicianImage": "https://picsum.photos/40/40?random=105",
      "appointment1": {
        "id": "APT007",
        "customer": "Retail Chain",
        "service": "POS System Update",
        "time": "06:00 PM - 08:00 PM",
        "location": "Shopping Center",
        "priority": "Low",
        "currentHours": 7.5,
        "proposedHours": 9.5,
        "overtimeLimit": 8.0
      },
      "detectedAt": "2024-01-15 12:00:00",
      "status": "Unresolved",
      "estimatedResolutionTime": "10 mins",
      "autoResolutionOptions": 2,
      "impactScore": 25
    }
  ];

  List<Map<String, dynamic>> get filteredConflicts {
    var filtered = conflicts.where((conflict) {
      if (!showResolvedConflicts && conflict["status"] == "Auto-Resolved") {
        return false;
      }
      
      if (searchQuery.isNotEmpty) {
        final query = searchQuery.toLowerCase();
        return conflict["technician"].toString().toLowerCase().contains(query) ||
               conflict["type"].toString().toLowerCase().contains(query) ||
               conflict["id"].toString().toLowerCase().contains(query);
      }
      
      return true;
    }).toList();

    switch (selectedFilterIndex) {
      case 1: // Critical
        return filtered.where((c) => c["severity"] == "Critical").toList();
      case 2: // High  
        return filtered.where((c) => c["severity"] == "High").toList();
      case 3: // Medium
        return filtered.where((c) => c["severity"] == "Medium").toList();
      case 4: // Unresolved
        return filtered.where((c) => c["status"] == "Unresolved").toList();
      default:
        return filtered;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule Conflicts"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Refresh conflicts
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Conflict settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildConflictsSummary(),
            _buildSearchAndFilters(),
            _buildConflictsList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBulkResolutionDialog(),
        child: Icon(Icons.auto_fix_high),
      ),
    );
  }

  Widget _buildConflictsSummary() {
    final unresolved = conflicts.where((c) => c["status"] == "Unresolved").length;
    final inProgress = conflicts.where((c) => c["status"] == "In Progress").length;
    final critical = conflicts.where((c) => c["severity"] == "Critical").length;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.warning, color: dangerColor),
              SizedBox(width: spSm),
              Text(
                "Conflicts Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard("Unresolved", "$unresolved", dangerColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSummaryCard("In Progress", "$inProgress", warningColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSummaryCard("Critical", "$critical", dangerColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(60)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search conflicts...",
                value: searchQuery,
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            QButton(
              icon: Icons.search,
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        
        QCategoryPicker(
          items: [
            {"label": "All", "value": 0},
            {"label": "Critical", "value": 1},
            {"label": "High", "value": 2},
            {"label": "Medium", "value": 3},
            {"label": "Unresolved", "value": 4},
          ],
          value: selectedFilterIndex,
          onChanged: (index, label, value, item) {
            selectedFilterIndex = value;
            setState(() {});
          },
        ),
        
        Row(
          children: [
            QSwitch(
              items: [
                {
                  "label": "Show Resolved",
                  "value": true,
                  "checked": showResolvedConflicts,
                }
              ],
              value: [
                if (showResolvedConflicts)
                  {
                    "label": "Show Resolved", 
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                showResolvedConflicts = values.isNotEmpty;
                setState(() {});
              },
            ),
            Spacer(),
            Text(
              "${filteredConflicts.length} conflicts",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildConflictsList() {
    if (filteredConflicts.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spLg),
        child: Column(
          children: [
            Icon(
              Icons.check_circle,
              size: 64,
              color: successColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No conflicts found",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "All schedules are optimized and conflict-free",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      spacing: spSm,
      children: filteredConflicts.map((conflict) => _buildConflictCard(conflict)).toList(),
    );
  }

  Widget _buildConflictCard(Map<String, dynamic> conflict) {
    Color severityColor = _getSeverityColor(conflict["severity"]);
    Color statusColor = _getStatusColor(conflict["status"]);
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: severityColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: severityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${conflict["type"]}",
                  style: TextStyle(
                    color: severityColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${conflict["status"]}",
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${conflict["technicianImage"]}",
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${conflict["technician"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "ID: ${conflict["id"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: _getImpactColor((conflict["impactScore"] as num).toDouble()).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${conflict["impactScore"]}",
                  style: TextStyle(
                    color: _getImpactColor((conflict["impactScore"] as num).toDouble()),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          
          _buildConflictDetails(conflict),
          
          if (conflict["status"] != "Auto-Resolved")
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Auto Resolve",
                    size: bs.sm,
                    onPressed: () => _showAutoResolutionDialog(conflict),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Manual Fix",
                    size: bs.sm,
                    onPressed: () => _showManualResolutionDialog(conflict),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildConflictDetails(Map<String, dynamic> conflict) {
    switch (conflict["type"]) {
      case "Double Booking":
        return _buildDoubleBookingDetails(conflict);
      case "Skill Mismatch":
        return _buildSkillMismatchDetails(conflict);
      case "Location Conflict":
        return _buildLocationConflictDetails(conflict);
      case "Resource Unavailable":
        return _buildResourceConflictDetails(conflict);
      case "Overtime Violation":
        return _buildOvertimeConflictDetails(conflict);
      default:
        return SizedBox.shrink();
    }
  }

  Widget _buildDoubleBookingDetails(Map<String, dynamic> conflict) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: dangerColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spSm,
        children: [
          _buildAppointmentRow("Appointment 1", conflict["appointment1"]),
          Divider(height: 1),
          _buildAppointmentRow("Appointment 2", conflict["appointment2"]),
        ],
      ),
    );
  }

  Widget _buildSkillMismatchDetails(Map<String, dynamic> conflict) {
    final appointment = conflict["appointment1"];
    final required = appointment["requiredSkills"] as List;
    final technician = appointment["technicianSkills"] as List;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppointmentRow("Appointment", appointment),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Required Skills",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Wrap(
                      spacing: spXs,
                      children: required.map((skill) => Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "$skill",
                          style: TextStyle(
                            fontSize: 10,
                            color: dangerColor,
                          ),
                        ),
                      )).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Technician Skills",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Wrap(
                      spacing: spXs,
                      children: technician.map((skill) => Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "$skill",
                          style: TextStyle(
                            fontSize: 10,
                            color: successColor,
                          ),
                        ),
                      )).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          if (conflict["suggestedTechnicians"] != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Suggested Technicians",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: spXs),
                ...(conflict["suggestedTechnicians"] as List).map((tech) => Container(
                  margin: EdgeInsets.only(bottom: spXs),
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${tech["name"]}",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Text(
                        "${tech["skillMatch"]}% match",
                        style: TextStyle(
                          fontSize: 10,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildLocationConflictDetails(Map<String, dynamic> conflict) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spSm,
        children: [
          _buildAppointmentRow("First Appointment", conflict["appointment1"]),
          Divider(height: 1),
          _buildAppointmentRow("Next Appointment", conflict["appointment2"]),
          
          if (conflict["status"] == "Auto-Resolved")
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, size: 16, color: successColor),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${conflict["resolutionAction"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildResourceConflictDetails(Map<String, dynamic> conflict) {
    final appointment = conflict["appointment1"];
    final required = appointment["requiredEquipment"] as List;
    final available = appointment["availableEquipment"] as List;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: dangerColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppointmentRow("Appointment", appointment),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Required Equipment",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: spXs),
                    ...required.map((item) => Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: available.contains(item) 
                            ? successColor.withAlpha(20)
                            : dangerColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            available.contains(item) ? Icons.check : Icons.close,
                            size: 12,
                            color: available.contains(item) ? successColor : dangerColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "$item",
                            style: TextStyle(
                              fontSize: 10,
                              color: available.contains(item) ? successColor : dangerColor,
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOvertimeConflictDetails(Map<String, dynamic> conflict) {
    final appointment = conflict["appointment1"];
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spSm,
        children: [
          _buildAppointmentRow("Appointment", appointment),
          
          Row(
            children: [
              Expanded(
                child: _buildHoursInfo("Current Hours", "${appointment["currentHours"]}", successColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildHoursInfo("With This Job", "${appointment["proposedHours"]}", dangerColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildHoursInfo("Limit", "${appointment["overtimeLimit"]}", warningColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHoursInfo(String label, String hours, Color color) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Column(
        children: [
          Text(
            hours,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 16,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentRow(String title, Map<String, dynamic> appointment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spXs),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${appointment["customer"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "${appointment["service"]}",
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
              children: [
                Text(
                  "${appointment["time"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (appointment["priority"] != null)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                    decoration: BoxDecoration(
                      color: _getPriorityColor(appointment["priority"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${appointment["priority"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: _getPriorityColor(appointment["priority"]),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Unresolved":
        return dangerColor;
      case "In Progress":
        return warningColor;
      case "Auto-Resolved":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getImpactColor(double score) {
    if (score >= 80) return dangerColor;
    if (score >= 60) return warningColor;
    if (score >= 40) return infoColor;
    return successColor;
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showAutoResolutionDialog(Map<String, dynamic> conflict) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Auto Resolution Options"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Choose an automatic resolution:"),
            SizedBox(height: spMd),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Reschedule Lower Priority",
                size: bs.sm,
                onPressed: () {
                  back();
                  ss("Conflict resolved by rescheduling");
                },
              ),
            ),
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Assign Different Technician",
                size: bs.sm,
                onPressed: () {
                  back();
                  ss("Conflict resolved with reassignment");
                },
              ),
            ),
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Adjust Time Slots",
                size: bs.sm,
                onPressed: () {
                  back();
                  ss("Conflict resolved by adjusting times");
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void _showManualResolutionDialog(Map<String, dynamic> conflict) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Manual Resolution"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Manually resolve this conflict:"),
            SizedBox(height: spMd),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Open Schedule Editor",
                size: bs.sm,
                onPressed: () {
                  back();
                  // Navigate to schedule editor
                },
              ),
            ),
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Contact Customer",
                size: bs.sm,
                onPressed: () {
                  back();
                  // Open contact options
                },
              ),
            ),
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Mark as Handled",
                size: bs.sm,
                onPressed: () {
                  back();
                  ss("Conflict marked as manually handled");
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void _showBulkResolutionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Bulk Resolution"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Resolve multiple conflicts automatically:"),
            SizedBox(height: spMd),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Resolve All Low Impact",
                size: bs.sm,
                onPressed: () {
                  back();
                  ss("Low impact conflicts resolved");
                },
              ),
            ),
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Apply AI Suggestions",
                size: bs.sm,
                onPressed: () {
                  back();
                  ss("AI suggestions applied");
                },
              ),
            ),
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Optimize All Schedules",
                size: bs.sm,
                onPressed: () {
                  back();
                  ss("Schedules optimized");
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }
}
