import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHistory9View extends StatefulWidget {
  @override
  State<GrlHistory9View> createState() => _GrlHistory9ViewState();
}

class _GrlHistory9ViewState extends State<GrlHistory9View> {
  String searchQuery = "";
  String selectedService = "All";
  String selectedStatus = "All";

  List<Map<String, dynamic>> maintenanceHistory = [
    {
      "ticketId": "MNT-001",
      "equipmentName": "Server Rack A1",
      "equipmentType": "Network Equipment",
      "service": "Hardware Repair",
      "technician": "James Wilson",
      "requestDate": "2024-12-18",
      "completedDate": "2024-12-20",
      "status": "Completed",
      "priority": "High",
      "description": "Replace faulty power supply unit",
      "cost": 450.00,
      "downtime": 2.5,
      "location": "Data Center Floor 1",
      "parts": ["Power Supply Unit", "Cooling Fan"],
    },
    {
      "ticketId": "MNT-002",
      "equipmentName": "HVAC Unit 03",
      "equipmentType": "Climate Control",
      "service": "Preventive Maintenance",
      "technician": "Sarah Martinez",
      "requestDate": "2024-12-15",
      "completedDate": "",
      "status": "In Progress",
      "priority": "Medium",
      "description": "Monthly HVAC system inspection and cleaning",
      "cost": 200.00,
      "downtime": 0.0,
      "location": "Building Floor 3",
      "parts": ["Filter Replacement"],
    },
    {
      "ticketId": "MNT-003",
      "equipmentName": "Elevator B",
      "equipmentType": "Transportation",
      "service": "Emergency Repair",
      "technician": "Michael Brown",
      "requestDate": "2024-12-14",
      "completedDate": "2024-12-14",
      "status": "Completed",
      "priority": "Critical",
      "description": "Elevator stuck between floors 2 and 3",
      "cost": 1200.00,
      "downtime": 6.0,
      "location": "Main Building",
      "parts": ["Motor Controller", "Cable Assembly"],
    },
    {
      "ticketId": "MNT-004",
      "equipmentName": "Security Camera 15",
      "equipmentType": "Security System",
      "service": "Installation",
      "technician": "Lisa Chen",
      "requestDate": "2024-12-12",
      "completedDate": "2024-12-13",
      "status": "Completed",
      "priority": "Low",
      "description": "Install new security camera in parking area",
      "cost": 350.00,
      "downtime": 0.0,
      "location": "Parking Lot C",
      "parts": ["IP Camera", "Mounting Bracket", "Cables"],
    },
    {
      "ticketId": "MNT-005",
      "equipmentName": "Generator Unit 02",
      "equipmentType": "Power System",
      "service": "Software Update",
      "technician": "David Johnson",
      "requestDate": "2024-12-10",
      "completedDate": "",
      "status": "Scheduled",
      "priority": "Medium",
      "description": "Update control system firmware",
      "cost": 150.00,
      "downtime": 1.0,
      "location": "Generator Room",
      "parts": [],
    },
  ];

  List<Map<String, dynamic>> get filteredMaintenance {
    return maintenanceHistory.where((record) {
      final matchesSearch = record["equipmentName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          record["ticketId"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          record["technician"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      final matchesService = selectedService == "All" || record["service"] == selectedService;
      final matchesStatus = selectedStatus == "All" || record["status"] == selectedStatus;
      return matchesSearch && matchesService && matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Maintenance History"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSearchAndFilters(),
            _buildMaintenanceStats(),
            _buildMaintenanceList(),
          ],
        ),
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
                label: "Search maintenance",
                value: searchQuery,
                hint: "Search by equipment, ticket ID, technician...",
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
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Service Type",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "Hardware Repair", "value": "Hardware Repair"},
                  {"label": "Preventive Maintenance", "value": "Preventive Maintenance"},
                  {"label": "Emergency Repair", "value": "Emergency Repair"},
                  {"label": "Installation", "value": "Installation"},
                  {"label": "Software Update", "value": "Software Update"},
                ],
                value: selectedService,
                onChanged: (value, label) {
                  selectedService = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Status",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "Completed", "value": "Completed"},
                  {"label": "In Progress", "value": "In Progress"},
                  {"label": "Scheduled", "value": "Scheduled"},
                  {"label": "Cancelled", "value": "Cancelled"},
                ],
                value: selectedStatus,
                onChanged: (value, label) {
                  selectedStatus = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMaintenanceStats() {
    final completedCount = maintenanceHistory.where((r) => r["status"] == "Completed").length;
    final inProgressCount = maintenanceHistory.where((r) => r["status"] == "In Progress").length;
    final totalCost = maintenanceHistory.fold(0.0, (sum, r) => sum + (r["cost"] as double));
    final totalDowntime = maintenanceHistory.fold(0.0, (sum, r) => sum + (r["downtime"] as double));

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            "Completed",
            completedCount.toString(),
            Icons.check_circle,
            successColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            "In Progress",
            inProgressCount.toString(),
            Icons.work,
            infoColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            "Total Cost",
            "\$${(totalCost / 1000).toStringAsFixed(1)}K",
            Icons.attach_money,
            warningColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            "Downtime",
            "${totalDowntime.toStringAsFixed(1)}h",
            Icons.schedule_outlined,
            dangerColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaintenanceList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Maintenance Records (${filteredMaintenance.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: filteredMaintenance.length,
          itemBuilder: (context, index) {
            final record = filteredMaintenance[index];
            return _buildMaintenanceCard(record);
          },
        ),
      ],
    );
  }

  Widget _buildMaintenanceCard(Map<String, dynamic> record) {
    final cost = record["cost"] as double;
    final downtime = record["downtime"] as double;
    final hasDowntime = downtime > 0;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getPriorityColor(record["priority"]),
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
                  children: [
                    Text(
                      "${record["ticketId"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${record["equipmentName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getPriorityColor(record["priority"]).withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${record["priority"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: _getPriorityColor(record["priority"]),
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getStatusColor(record["status"]).withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${record["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: _getStatusColor(record["status"]),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.category,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${record["equipmentType"]} - ${record["service"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Text(
            "${record["description"]}",
            style: TextStyle(
              fontSize: 13,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.person,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${record["technician"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(
                Icons.location_on,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${record["location"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Requested: ${DateTime.parse(record["requestDate"]).dMMMy}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              if (record["completedDate"].toString().isNotEmpty) ...[
                SizedBox(width: spSm),
                Icon(
                  Icons.done,
                  size: 16,
                  color: successColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "Completed: ${DateTime.parse(record["completedDate"]).dMMMy}",
                  style: TextStyle(
                    fontSize: 13,
                    color: successColor,
                  ),
                ),
              ],
            ],
          ),
          if ((record["parts"] as List).isNotEmpty) ...[
            Row(
              children: [
                Icon(
                  Icons.build,
                  size: 16,
                  color: disabledBoldColor,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Parts: ${(record["parts"] as List).join(", ")}",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cost: \$${cost.currency}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: cost > 500 ? dangerColor : successColor,
                    ),
                  ),
                  if (hasDowntime) ...[
                    Text(
                      "Downtime: ${downtime.toStringAsFixed(1)}h",
                      style: TextStyle(
                        fontSize: 13,
                        color: dangerColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
              Spacer(),
              QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return infoColor;
      case "Scheduled":
        return warningColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
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
        return disabledBoldColor;
    }
  }
}
