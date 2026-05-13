import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaVehicleMaintenanceView extends StatefulWidget {
  const DlaVehicleMaintenanceView({super.key});

  @override
  State<DlaVehicleMaintenanceView> createState() => _DlaVehicleMaintenanceViewState();
}

class _DlaVehicleMaintenanceViewState extends State<DlaVehicleMaintenanceView> {
  int currentTab = 0;
  String selectedVehicle = "";
  String maintenanceType = "routine";
  String description = "";
  String mechanic = "";
  String cost = "";
  String scheduledDate = "";
  String notes = "";

  final List<Map<String, dynamic>> vehicles = [
    {"label": "DLA-001 (Toyota Hiace)", "value": "DLA-001"},
    {"label": "DLA-002 (Isuzu Elf)", "value": "DLA-002"},
    {"label": "DLA-003 (Honda Beat)", "value": "DLA-003"},
    {"label": "DLA-004 (Toyota Avanza)", "value": "DLA-004"},
  ];

  final List<Map<String, dynamic>> maintenanceTypes = [
    {"label": "Routine Service", "value": "routine"},
    {"label": "Oil Change", "value": "oil_change"},
    {"label": "Tire Replacement", "value": "tire_replacement"},
    {"label": "Brake Service", "value": "brake_service"},
    {"label": "Engine Repair", "value": "engine_repair"},
    {"label": "Body Repair", "value": "body_repair"},
    {"label": "Emergency Repair", "value": "emergency"},
  ];

  final List<Map<String, dynamic>> maintenanceSchedule = [
    {
      "id": "MAINT-001",
      "vehicleId": "DLA-001",
      "type": "Routine Service",
      "scheduledDate": "2024-02-10",
      "status": "scheduled",
      "mechanic": "Auto Service Center",
      "estimatedCost": 750000,
      "description": "Regular maintenance check-up",
      "priority": "medium",
    },
    {
      "id": "MAINT-002",
      "vehicleId": "DLA-002",
      "type": "Tire Replacement",
      "scheduledDate": "2024-01-25",
      "status": "overdue",
      "mechanic": "Tire Pro Shop",
      "estimatedCost": 1200000,
      "description": "Front tire replacement needed",
      "priority": "high",
    },
    {
      "id": "MAINT-003",
      "vehicleId": "DLA-003",
      "type": "Oil Change",
      "scheduledDate": "2024-02-15",
      "status": "scheduled",
      "mechanic": "Quick Lube Service",
      "estimatedCost": 300000,
      "description": "Regular oil change service",
      "priority": "low",
    },
    {
      "id": "MAINT-004",
      "vehicleId": "DLA-004",
      "type": "Brake Service",
      "scheduledDate": "2024-01-20",
      "status": "in_progress",
      "mechanic": "Brake Specialist",
      "estimatedCost": 850000,
      "description": "Brake pad replacement and inspection",
      "priority": "high",
    },
  ];

  final List<Map<String, dynamic>> maintenanceHistory = [
    {
      "id": "HIST-001",
      "vehicleId": "DLA-001",
      "type": "Engine Repair",
      "completedDate": "2024-01-10",
      "status": "completed",
      "mechanic": "Engine Specialist",
      "actualCost": 950000,
      "description": "Engine diagnostic and minor repairs",
      "downtime": "2 days",
    },
    {
      "id": "HIST-002",
      "vehicleId": "DLA-002",
      "type": "Body Repair",
      "completedDate": "2024-01-05",
      "status": "completed",
      "mechanic": "Body Shop Pro",
      "actualCost": 1500000,
      "description": "Minor collision repair",
      "downtime": "3 days",
    },
    {
      "id": "HIST-003",
      "vehicleId": "DLA-003",
      "type": "Routine Service",
      "completedDate": "2023-12-20",
      "status": "completed",
      "mechanic": "Auto Service Center",
      "actualCost": 700000,
      "description": "Regular maintenance check-up",
      "downtime": "1 day",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "scheduled":
        return infoColor;
      case "in_progress":
        return warningColor;
      case "overdue":
        return dangerColor;
      case "completed":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "scheduled":
        return "Scheduled";
      case "in_progress":
        return "In Progress";
      case "overdue":
        return "Overdue";
      case "completed":
        return "Completed";
      default:
        return "Unknown";
    }
  }

  Widget _buildScheduleTab() {
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
                  "Schedule New Maintenance",
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
                  label: "Maintenance Type",
                  items: maintenanceTypes,
                  value: maintenanceType,
                  onChanged: (value, label) {
                    maintenanceType = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Description",
                  value: description,
                  hint: "Describe the maintenance work needed",
                  onChanged: (value) {
                    description = value;
                    setState(() {});
                  },
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Mechanic/Service Center",
                        value: mechanic,
                        hint: "Where will the work be done",
                        onChanged: (value) {
                          mechanic = value;
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: QNumberField(
                        label: "Estimated Cost",
                        value: cost,
                        onChanged: (value) {
                          cost = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QDatePicker(
                  label: "Scheduled Date",
                  value: scheduledDate.isNotEmpty ? DateTime.parse(scheduledDate) : DateTime.now().add(Duration(days: 7)),
                  onChanged: (value) {
                    scheduledDate = value.toString();
                    setState(() {});
                  },
                ),
                QMemoField(
                  label: "Additional Notes",
                  value: notes,
                  hint: "Any special instructions or notes",
                  onChanged: (value) {
                    notes = value;
                    setState(() {});
                  },
                ),
                QButton(
                  label: "Schedule Maintenance",
                  size: bs.md,
                  onPressed: () {
                    ss("Maintenance scheduled successfully");
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
            child: Row(
              children: [
                Icon(Icons.schedule, color: primaryColor, size: 24),
                SizedBox(width: spSm),
                Text(
                  "Upcoming Maintenance",
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
                    si("Filter maintenance schedule");
                  },
                ),
              ],
            ),
          ),
          ...maintenanceSchedule.map((maintenance) {
            Color statusColor = _getStatusColor(maintenance["status"]);
            Color priorityColor = _getPriorityColor(maintenance["priority"]);
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: maintenance["status"] == "overdue" 
                    ? Border.all(color: dangerColor, width: 1)
                    : null,
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
                          _getStatusLabel(maintenance["status"]),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: priorityColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${maintenance["priority"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: priorityColor,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${maintenance["id"]}",
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
                        "${maintenance["vehicleId"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.calendar_today, color: disabledBoldColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "${maintenance["scheduledDate"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${maintenance["type"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${maintenance["description"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Divider(color: disabledColor),
                  Row(
                    children: [
                      Icon(Icons.business, color: disabledBoldColor, size: 16),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${maintenance["mechanic"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Text(
                        "Rp ${((maintenance["estimatedCost"] as int).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Start Work",
                          size: bs.sm,
                          onPressed: () {
                            si("Starting maintenance work for ${maintenance["vehicleId"]}");
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Reschedule",
                          color: disabledBoldColor,
                          size: bs.sm,
                          onPressed: () {
                            si("Reschedule maintenance for ${maintenance["vehicleId"]}");
                          },
                        ),
                      ),
                      QButton(
                        icon: Icons.more_vert,
                        size: bs.sm,
                        onPressed: () {
                          si("More options for ${maintenance["id"]}");
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

  Widget _buildHistoryTab() {
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
                  "Maintenance History",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  icon: Icons.download,
                  size: bs.sm,
                  onPressed: () {
                    si("Download maintenance report");
                  },
                ),
              ],
            ),
          ),
          ...maintenanceHistory.map((maintenance) {
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
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Completed",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${maintenance["id"]}",
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
                        "${maintenance["vehicleId"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.event_available, color: successColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "${maintenance["completedDate"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${maintenance["type"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${maintenance["description"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Divider(color: disabledColor),
                  Row(
                    children: [
                      Icon(Icons.business, color: disabledBoldColor, size: 16),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${maintenance["mechanic"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
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
                          "${maintenance["downtime"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Total Cost:",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Rp ${((maintenance["actualCost"] as int).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () {
                      si("View maintenance details for ${maintenance["id"]}");
                    },
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
    int totalMaintenances = maintenanceHistory.length;
    double totalCost = maintenanceHistory.fold(0.0, (sum, item) => sum + (item["actualCost"] as int).toDouble());
    int overdueCount = maintenanceSchedule.where((m) => m["status"] == "overdue").length;
    int scheduledCount = maintenanceSchedule.where((m) => m["status"] == "scheduled").length;

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
                  "Maintenance Overview",
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
                              "$totalMaintenances",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Completed",
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
                              "$scheduledCount",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Scheduled",
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
                              "$overdueCount",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Overdue",
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
                      Icon(Icons.attach_money, color: infoColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Total Cost: Rp ${totalCost.currency}",
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
                  "Vehicle Maintenance Status",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...vehicles.map((vehicle) {
                  int vehicleMaintenances = maintenanceHistory.where((m) => m["vehicleId"] == vehicle["value"]).length;
                  bool hasOverdue = maintenanceSchedule.any((m) => m["vehicleId"] == vehicle["value"] && m["status"] == "overdue");
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: hasOverdue ? dangerColor.withAlpha(10) : successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: hasOverdue ? dangerColor : successColor,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_shipping,
                          color: hasOverdue ? dangerColor : successColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                vehicle["value"],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "$vehicleMaintenances completed maintenances",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: hasOverdue ? dangerColor.withAlpha(20) : successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            hasOverdue ? "Overdue" : "Up to Date",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: hasOverdue ? dangerColor : successColor,
                            ),
                          ),
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
                    ss("Maintenance report exported successfully");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Print Summary",
                  color: disabledBoldColor,
                  size: bs.md,
                  onPressed: () {
                    si("Printing maintenance summary");
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
      title: "Vehicle Maintenance",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Schedule", icon: Icon(Icons.schedule)),
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Reports", icon: Icon(Icons.assessment)),
      ],
      tabChildren: [
        _buildScheduleTab(),
        _buildHistoryTab(),
        _buildReportsTab(),
      ],
    );
  }
}
