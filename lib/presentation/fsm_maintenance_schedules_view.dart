import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmMaintenanceSchedulesView extends StatefulWidget {
  const FsmMaintenanceSchedulesView({super.key});

  @override
  State<FsmMaintenanceSchedulesView> createState() => _FsmMaintenanceSchedulesViewState();
}

class _FsmMaintenanceSchedulesViewState extends State<FsmMaintenanceSchedulesView> {
  List<Map<String, dynamic>> maintenanceSchedules = [
    {
      "id": "MS001",
      "equipmentId": "EQ001",
      "equipmentName": "Industrial Generator Model X200",
      "maintenanceType": "Preventive",
      "scheduledDate": "2024-06-25",
      "scheduledTime": "09:00",
      "duration": "4 hours",
      "priority": "High",
      "status": "Scheduled",
      "technician": "John Smith",
      "technicianId": "TECH001",
      "description": "Quarterly oil change and filter replacement",
      "location": "Main Facility - Building A",
      "estimatedCost": 850.0,
      "lastCompleted": "2024-03-25",
      "notes": "Check oil levels and inspect belts for wear"
    },
    {
      "id": "MS002",
      "equipmentId": "EQ002",
      "equipmentName": "HVAC System Pro Series 500",
      "maintenanceType": "Corrective",
      "scheduledDate": "2024-06-22",
      "scheduledTime": "14:30",
      "duration": "6 hours",
      "priority": "Critical",
      "status": "In Progress",
      "technician": "Sarah Johnson",
      "technicianId": "TECH002",
      "description": "Replace faulty compressor unit",
      "location": "Main Facility - Building B",
      "estimatedCost": 2400.0,
      "lastCompleted": "2024-04-15",
      "notes": "Emergency repair required - system overheating"
    },
    {
      "id": "MS003",
      "equipmentId": "EQ003",
      "equipmentName": "Fire Safety System v3.1",
      "maintenanceType": "Inspection",
      "scheduledDate": "2024-06-28",
      "scheduledTime": "10:00",
      "duration": "2 hours",
      "priority": "Medium",
      "status": "Scheduled",
      "technician": "Mike Wilson",
      "technicianId": "TECH003",
      "description": "Monthly safety system inspection",
      "location": "Warehouse - Section C",
      "estimatedCost": 300.0,
      "lastCompleted": "2024-05-28",
      "notes": "Test all sensors and alarm systems"
    },
    {
      "id": "MS004",
      "equipmentId": "EQ004",
      "equipmentName": "Conveyor Belt System MK4",
      "maintenanceType": "Preventive",
      "scheduledDate": "2024-06-30",
      "scheduledTime": "08:00",
      "duration": "8 hours",
      "priority": "High",
      "status": "Pending Approval",
      "technician": "David Brown",
      "technicianId": "TECH004",
      "description": "Belt replacement and motor alignment",
      "location": "Production Floor - Line 1",
      "estimatedCost": 1200.0,
      "lastCompleted": "2024-03-18",
      "notes": "Schedule during weekend to minimize downtime"
    },
    {
      "id": "MS005",
      "equipmentId": "EQ005",
      "equipmentName": "Security Camera Network HD",
      "maintenanceType": "Preventive",
      "scheduledDate": "2024-07-02",
      "scheduledTime": "16:00",
      "duration": "3 hours",
      "priority": "Low",
      "status": "Scheduled",
      "technician": "Lisa Chen",
      "technicianId": "TECH005",
      "description": "Camera lens cleaning and software update",
      "location": "Multiple Locations",
      "estimatedCost": 450.0,
      "lastCompleted": "2024-04-02",
      "notes": "Update firmware to latest version"
    }
  ];

  List<Map<String, dynamic>> filteredSchedules = [];
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedPriority = "All";
  String selectedType = "All";

  List<Map<String, dynamic>> statusItems = [
    {"label": "All", "value": "All"},
    {"label": "Scheduled", "value": "Scheduled"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Pending Approval", "value": "Pending Approval"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];

  List<Map<String, dynamic>> priorityItems = [
    {"label": "All", "value": "All"},
    {"label": "Critical", "value": "Critical"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> typeItems = [
    {"label": "All", "value": "All"},
    {"label": "Preventive", "value": "Preventive"},
    {"label": "Corrective", "value": "Corrective"},
    {"label": "Inspection", "value": "Inspection"},
    {"label": "Emergency", "value": "Emergency"},
  ];

  @override
  void initState() {
    super.initState();
    filteredSchedules = maintenanceSchedules;
  }

  void _filterSchedules() {
    filteredSchedules = maintenanceSchedules.where((schedule) {
      bool matchesSearch = schedule["equipmentName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          schedule["technician"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          schedule["id"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus == "All" || schedule["status"] == selectedStatus;
      bool matchesPriority = selectedPriority == "All" || schedule["priority"] == selectedPriority;
      bool matchesType = selectedType == "All" || schedule["maintenanceType"] == selectedType;
      
      return matchesSearch && matchesStatus && matchesPriority && matchesType;
    }).toList();
    setState(() {});
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Scheduled":
        return infoColor;
      case "In Progress":
        return warningColor;
      case "Completed":
        return successColor;
      case "Pending Approval":
        return secondaryColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildScheduleCard(Map<String, dynamic> schedule) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getPriorityColor(schedule["priority"]),
          ),
        ),
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
                      "${schedule["equipmentName"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${schedule["id"]} • ${schedule["maintenanceType"]}",
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(schedule["status"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${schedule["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: _getStatusColor(schedule["status"]),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getPriorityColor(schedule["priority"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${schedule["priority"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: _getPriorityColor(schedule["priority"]),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${schedule["description"]}",
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem("Date & Time", "${schedule["scheduledDate"]} at ${schedule["scheduledTime"]}", Icons.schedule),
              ),
              Expanded(
                child: _buildInfoItem("Duration", "${schedule["duration"]}", Icons.timer),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem("Technician", "${schedule["technician"]}", Icons.person),
              ),
              Expanded(
                child: _buildInfoItem("Location", "${schedule["location"]}", Icons.location_on),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem("Estimated Cost", "\$${(schedule["estimatedCost"] as double).currency}", Icons.attach_money),
              ),
              Expanded(
                child: _buildInfoItem("Last Completed", "${schedule["lastCompleted"]}", Icons.history),
              ),
            ],
          ),
          if (schedule["notes"] != null && schedule["notes"].isNotEmpty) ...[
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Notes:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: warningColor,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "${schedule["notes"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
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
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to schedule details
                  },
                ),
              ),
              SizedBox(width: spSm),
              if (schedule["status"] == "Scheduled") ...[
                Expanded(
                  child: QButton(
                    label: "Start Work",
                    size: bs.sm,
                    onPressed: () {
                      // Start maintenance work
                    },
                  ),
                ),
              ] else if (schedule["status"] == "In Progress") ...[
                Expanded(
                  child: QButton(
                    label: "Complete",
                    size: bs.sm,
                    onPressed: () {
                      // Complete maintenance
                    },
                  ),
                ),
              ] else ...[
                Expanded(
                  child: QButton(
                    label: "Reschedule",
                    size: bs.sm,
                    onPressed: () {
                      // Reschedule maintenance
                    },
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: disabledBoldColor,
        ),
        SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCards() {
    int totalSchedules = maintenanceSchedules.length;
    int scheduledCount = maintenanceSchedules.where((s) => s["status"] == "Scheduled").length;
    int inProgressCount = maintenanceSchedules.where((s) => s["status"] == "In Progress").length;
    int criticalCount = maintenanceSchedules.where((s) => s["priority"] == "Critical").length;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard("Total Schedules", "$totalSchedules", Icons.schedule, primaryColor),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildStatCard("Scheduled", "$scheduledCount", Icons.event, infoColor),
            ),
          ],
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(
              child: _buildStatCard("In Progress", "$inProgressCount", Icons.work, warningColor),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildStatCard("Critical", "$criticalCount", Icons.priority_high, dangerColor),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Maintenance Schedules"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add schedule
            },
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              // Navigate to calendar view
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsCards(),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search Schedules",
                    value: searchQuery,
                    hint: "Search by equipment, technician, or ID...",
                    onChanged: (value) {
                      searchQuery = value;
                      _filterSchedules();
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
                    label: "Status",
                    items: statusItems,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      _filterSchedules();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Priority",
                    items: priorityItems,
                    value: selectedPriority,
                    onChanged: (value, label) {
                      selectedPriority = value;
                      _filterSchedules();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Maintenance Type",
              items: typeItems,
              value: selectedType,
              onChanged: (value, label) {
                selectedType = value;
                _filterSchedules();
              },
            ),
            SizedBox(height: spMd),
            Text(
              "Maintenance Schedules (${filteredSchedules.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            ...filteredSchedules.map((schedule) => _buildScheduleCard(schedule)).toList(),
          ],
        ),
      ),
    );
  }
}
