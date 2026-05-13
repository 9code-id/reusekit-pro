import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaMaintenanceScheduleView extends StatefulWidget {
  const HhaMaintenanceScheduleView({super.key});

  @override
  State<HhaMaintenanceScheduleView> createState() => _HhaMaintenanceScheduleViewState();
}

class _HhaMaintenanceScheduleViewState extends State<HhaMaintenanceScheduleView> {
  DateTime selectedDate = DateTime.now();
  String selectedPriority = "All";
  String selectedType = "All";
  String selectedStatus = "All";

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All", "value": "All"},
    {"label": "Critical", "value": "critical"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All", "value": "All"},
    {"label": "Preventive", "value": "preventive"},
    {"label": "Corrective", "value": "corrective"},
    {"label": "Calibration", "value": "calibration"},
    {"label": "Inspection", "value": "inspection"},
    {"label": "Repair", "value": "repair"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Scheduled", "value": "scheduled"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Completed", "value": "completed"},
    {"label": "Overdue", "value": "overdue"},
    {"label": "Cancelled", "value": "cancelled"},
  ];

  List<Map<String, dynamic>> maintenanceSchedule = [
    {
      "id": "MAINT001",
      "equipmentId": "EQ001",
      "equipmentName": "MRI Machine - Siemens 3T",
      "type": "Preventive",
      "priority": "Critical",
      "status": "Scheduled",
      "scheduledDate": "2024-12-16",
      "scheduledTime": "09:00",
      "estimatedDuration": "4 hours",
      "assignedTechnician": "Dr. Sarah Mitchell",
      "department": "Radiology",
      "location": "Imaging Suite 1",
      "description": "Quarterly preventive maintenance including system calibration and software updates",
      "checklist": [
        "System diagnostics",
        "Gradient coil inspection",
        "Software updates",
        "Safety system check",
        "Performance verification"
      ],
      "requiredParts": ["Filter cartridge", "Cooling system fluid"],
      "estimatedCost": 2500.0,
      "lastMaintenance": "2024-09-16",
      "notes": "Priority maintenance - equipment heavily utilized",
      "approvedBy": "Head of Radiology",
      "contactInfo": "ext. 2201",
    },
    {
      "id": "MAINT002",
      "equipmentId": "EQ015",
      "equipmentName": "Ventilator - Philips V60",
      "type": "Calibration",
      "priority": "High",
      "status": "In Progress",
      "scheduledDate": "2024-12-15",
      "scheduledTime": "14:00",
      "estimatedDuration": "2 hours",
      "assignedTechnician": "Tech. Michael Chen",
      "department": "ICU",
      "location": "Critical Care Unit",
      "description": "Monthly calibration of pressure sensors and flow meters",
      "checklist": [
        "Pressure sensor calibration",
        "Flow meter accuracy test",
        "Alarm system verification",
        "Display calibration",
        "Documentation update"
      ],
      "requiredParts": ["Calibration gas mixture"],
      "estimatedCost": 150.0,
      "lastMaintenance": "2024-11-15",
      "notes": "Routine calibration - no issues expected",
      "approvedBy": "ICU Supervisor",
      "contactInfo": "ext. 3001",
    },
    {
      "id": "MAINT003",
      "equipmentId": "EQ023",
      "equipmentName": "X-Ray Machine - GE Discovery",
      "type": "Inspection",
      "priority": "Medium",
      "status": "Scheduled",
      "scheduledDate": "2024-12-17",
      "scheduledTime": "11:30",
      "estimatedDuration": "3 hours",
      "assignedTechnician": "Dr. Lisa Rodriguez",
      "department": "Radiology",
      "location": "X-Ray Room 2",
      "description": "Annual safety inspection and radiation leakage testing",
      "checklist": [
        "Radiation leakage measurement",
        "Collimator inspection",
        "Image quality assessment",
        "Safety interlock testing",
        "Documentation review"
      ],
      "requiredParts": ["Radiation detector batteries"],
      "estimatedCost": 800.0,
      "lastMaintenance": "2023-12-17",
      "notes": "Annual mandatory inspection due",
      "approvedBy": "Radiation Safety Officer",
      "contactInfo": "ext. 2250",
    },
    {
      "id": "MAINT004",
      "equipmentId": "EQ007",
      "equipmentName": "Patient Monitor - Nihon Kohden",
      "type": "Corrective",
      "priority": "High",
      "status": "Overdue",
      "scheduledDate": "2024-12-13",
      "scheduledTime": "08:00",
      "estimatedDuration": "1.5 hours",
      "assignedTechnician": "Tech. Robert Wilson",
      "department": "Emergency",
      "location": "ER Bay 3",
      "description": "Display backlight replacement and software troubleshooting",
      "checklist": [
        "Backlight assembly replacement",
        "Display calibration",
        "Software diagnostics",
        "Connection testing",
        "User acceptance test"
      ],
      "requiredParts": ["LED backlight assembly", "Display cable"],
      "estimatedCost": 450.0,
      "lastMaintenance": "2024-10-13",
      "notes": "URGENT: Display visibility compromised",
      "approvedBy": "ER Director",
      "contactInfo": "ext. 4001",
    },
    {
      "id": "MAINT005",
      "equipmentId": "EQ032",
      "equipmentName": "Ultrasound - Philips EPIQ",
      "type": "Preventive",
      "priority": "Medium",
      "status": "Completed",
      "scheduledDate": "2024-12-14",
      "scheduledTime": "15:00",
      "estimatedDuration": "2 hours",
      "assignedTechnician": "Dr. Amanda Foster",
      "department": "Cardiology",
      "location": "Echo Lab",
      "description": "Bi-annual preventive maintenance and transducer inspection",
      "checklist": [
        "Transducer inspection",
        "System software update",
        "Image quality verification",
        "Printer maintenance",
        "Storage system check"
      ],
      "requiredParts": ["Transducer gel", "Cleaning supplies"],
      "estimatedCost": 200.0,
      "lastMaintenance": "2024-06-14",
      "notes": "Completed successfully - all systems operational",
      "approvedBy": "Cardiology Chief",
      "contactInfo": "ext. 2501",
    },
    {
      "id": "MAINT006",
      "equipmentId": "EQ041",
      "equipmentName": "Anesthesia Machine - Draeger",
      "type": "Repair",
      "priority": "Critical",
      "status": "Scheduled",
      "scheduledDate": "2024-12-18",
      "scheduledTime": "07:00",
      "estimatedDuration": "6 hours",
      "assignedTechnician": "Tech. David Thompson",
      "department": "Surgery",
      "location": "OR-4",
      "description": "Ventilator bellows replacement and breathing circuit leak repair",
      "checklist": [
        "Bellows replacement",
        "Leak testing",
        "Pressure system verification",
        "Gas flow calibration",
        "Safety alarm testing"
      ],
      "requiredParts": ["Ventilator bellows", "O-ring kit", "Pressure sensors"],
      "estimatedCost": 1800.0,
      "lastMaintenance": "2024-08-18",
      "notes": "Critical repair - backup equipment arranged",
      "approvedBy": "OR Supervisor",
      "contactInfo": "ext. 3501",
    },
  ];

  List<Map<String, dynamic>> get filteredSchedule {
    return maintenanceSchedule.where((item) {
      bool matchesPriority = selectedPriority == "All" || item["priority"] == selectedPriority;
      bool matchesType = selectedType == "All" || item["type"] == selectedType;
      bool matchesStatus = selectedStatus == "All" || item["status"] == selectedStatus;
      
      DateTime scheduleDate = DateTime.parse("${item["scheduledDate"]}");
      bool matchesDate = scheduleDate.day == selectedDate.day &&
                        scheduleDate.month == selectedDate.month &&
                        scheduleDate.year == selectedDate.year;
      
      return matchesPriority && matchesType && matchesStatus && matchesDate;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'scheduled':
        return infoColor;
      case 'in progress':
        return warningColor;
      case 'completed':
        return successColor;
      case 'overdue':
        return dangerColor;
      case 'cancelled':
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'critical':
        return dangerColor;
      case 'high':
        return warningColor;
      case 'medium':
        return infoColor;
      case 'low':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'preventive':
        return successColor;
      case 'corrective':
        return warningColor;
      case 'calibration':
        return infoColor;
      case 'inspection':
        return infoColor;
      case 'repair':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Maintenance Schedule"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add maintenance task
            },
          ),
          IconButton(
            icon: Icon(Icons.calendar_month),
            onPressed: () {
              // Calendar view
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Schedule Overview Cards
            ResponsiveGridView(
              minItemWidth: 200,
              children: [
                _buildOverviewCard(
                  "Today's Tasks",
                  "${maintenanceSchedule.where((m) => DateTime.parse(m["scheduledDate"]).day == DateTime.now().day).length}",
                  primaryColor,
                  Icons.today,
                ),
                _buildOverviewCard(
                  "Overdue",
                  "${maintenanceSchedule.where((m) => m["status"] == "Overdue").length}",
                  dangerColor,
                  Icons.warning,
                ),
                _buildOverviewCard(
                  "In Progress",
                  "${maintenanceSchedule.where((m) => m["status"] == "In Progress").length}",
                  warningColor,
                  Icons.build,
                ),
                _buildOverviewCard(
                  "Completed",
                  "${maintenanceSchedule.where((m) => m["status"] == "Completed").length}",
                  successColor,
                  Icons.check_circle,
                ),
                _buildOverviewCard(
                  "Critical Priority",
                  "${maintenanceSchedule.where((m) => m["priority"] == "Critical").length}",
                  dangerColor,
                  Icons.priority_high,
                ),
                _buildOverviewCard(
                  "This Week",
                  "${maintenanceSchedule.where((m) => DateTime.parse(m["scheduledDate"]).isAfter(DateTime.now().subtract(Duration(days: 7)))).length}",
                  infoColor,
                  Icons.date_range,
                ),
              ],
            ),

            // Date Selector and Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Schedule Filters",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  QDatePicker(
                    label: "Select Date",
                    value: selectedDate,
                    onChanged: (value) {
                      selectedDate = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Priority",
                          items: priorityOptions,
                          value: selectedPriority,
                          onChanged: (value, label) {
                            selectedPriority = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Type",
                          items: typeOptions,
                          value: selectedType,
                          onChanged: (value, label) {
                            selectedType = value;
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
            ),

            // Maintenance Schedule List
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
                        Text(
                          "Maintenance Schedule",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${filteredSchedule.length} tasks for ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1),
                  if (filteredSchedule.isEmpty) ...[
                    Container(
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        children: [
                          Icon(
                            Icons.event_available,
                            size: 48,
                            color: disabledBoldColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No maintenance tasks scheduled for this date",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: filteredSchedule.length,
                      separatorBuilder: (context, index) => Divider(height: 1),
                      itemBuilder: (context, index) {
                        final task = filteredSchedule[index];
                        return Container(
                          padding: EdgeInsets.all(spSm),
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
                                              padding: EdgeInsets.symmetric(
                                                horizontal: spXs,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: _getTypeColor("${task["type"]}").withAlpha(20),
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Text(
                                                "${task["type"]}",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  color: _getTypeColor("${task["type"]}"),
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
                                                color: _getPriorityColor("${task["priority"]}").withAlpha(20),
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Text(
                                                "${task["priority"]}",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  color: _getPriorityColor("${task["priority"]}"),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: spXs),
                                        Text(
                                          "${task["equipmentName"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${task["description"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor("${task["status"]}").withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${task["status"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: _getStatusColor("${task["status"]}"),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${task["scheduledTime"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${task["estimatedDuration"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Column(
                                  spacing: spXs,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.person,
                                                size: 12,
                                                color: disabledBoldColor,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                "${task["assignedTechnician"]}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                size: 12,
                                                color: disabledBoldColor,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                "${task["location"]}",
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
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.attach_money,
                                                size: 12,
                                                color: disabledBoldColor,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                "\$${((task["estimatedCost"] as num).toDouble()).currency}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.checklist,
                                                size: 12,
                                                color: disabledBoldColor,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                "${(task["checklist"] as List).length} items",
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
                                  ],
                                ),
                              ),
                              if (task["notes"] != null && "${task["notes"]}".isNotEmpty) ...[
                                SizedBox(height: spXs),
                                Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: warningColor.withAlpha(10),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                    border: Border(
                                      left: BorderSide(
                                        color: warningColor,
                                        width: 3,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.note,
                                        size: 14,
                                        color: warningColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Expanded(
                                        child: Text(
                                          "${task["notes"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: warningColor,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              SizedBox(height: spSm),
                              Row(
                                children: [
                                  Expanded(
                                    child: QButton(
                                      label: _getActionLabel("${task["status"]}"),
                                      size: bs.sm,
                                      onPressed: () {
                                        _performAction(task);
                                      },
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  QButton(
                                    icon: Icons.checklist,
                                    size: bs.sm,
                                    onPressed: () {
                                      // Show checklist
                                    },
                                  ),
                                  SizedBox(width: spXs),
                                  QButton(
                                    icon: Icons.more_vert,
                                    size: bs.sm,
                                    onPressed: () {
                                      // Show options
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard(String title, String count, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            count,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  String _getActionLabel(String status) {
    switch (status.toLowerCase()) {
      case 'scheduled':
        return "Start Task";
      case 'in progress':
        return "Update Progress";
      case 'completed':
        return "View Report";
      case 'overdue':
        return "Reschedule";
      case 'cancelled':
        return "Restore";
      default:
        return "View";
    }
  }

  void _performAction(Map<String, dynamic> task) {
    String status = "${task["status"]}";
    String action = _getActionLabel(status);
    ss("$action performed for ${task["equipmentName"]}");
  }
}
