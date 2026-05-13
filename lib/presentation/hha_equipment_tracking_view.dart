import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaEquipmentTrackingView extends StatefulWidget {
  const HhaEquipmentTrackingView({super.key});

  @override
  State<HhaEquipmentTrackingView> createState() => _HhaEquipmentTrackingViewState();
}

class _HhaEquipmentTrackingViewState extends State<HhaEquipmentTrackingView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedLocation = "All";
  String selectedType = "All";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Available", "value": "available"},
    {"label": "In Use", "value": "in_use"},
    {"label": "Maintenance", "value": "maintenance"},
    {"label": "Reserved", "value": "reserved"},
    {"label": "Out of Order", "value": "out_of_order"},
  ];

  List<Map<String, dynamic>> locationOptions = [
    {"label": "All", "value": "All"},
    {"label": "ICU", "value": "icu"},
    {"label": "Emergency Room", "value": "er"},
    {"label": "Operating Room", "value": "or"},
    {"label": "Radiology", "value": "radiology"},
    {"label": "Laboratory", "value": "lab"},
    {"label": "Cardiology", "value": "cardiology"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All", "value": "All"},
    {"label": "Diagnostic", "value": "diagnostic"},
    {"label": "Monitoring", "value": "monitoring"},
    {"label": "Surgical", "value": "surgical"},
    {"label": "Life Support", "value": "life_support"},
    {"label": "Imaging", "value": "imaging"},
  ];

  List<Map<String, dynamic>> equipment = [
    {
      "id": "EQ001",
      "name": "Ventilator Pro 3000",
      "type": "Life Support",
      "model": "VP-3000",
      "serialNumber": "VP230156",
      "status": "In Use",
      "location": "ICU Room 304",
      "assignedTo": "Patient: John Doe",
      "startTime": "2024-12-14 08:30",
      "estimatedReturn": "2024-12-16 18:00",
      "condition": "Excellent",
      "batteryLevel": 85,
      "lastCalibration": "2024-11-20",
      "nextCalibration": "2025-02-20",
      "technician": "Dr. Sarah Wilson",
      "notes": "Regular monitoring, no issues reported",
      "usageHours": 1240,
      "maintenanceStatus": "Up to Date",
      "priority": "Critical",
    },
    {
      "id": "EQ002",
      "name": "X-Ray Mobile Unit",
      "type": "Imaging",
      "model": "XRM-250",
      "serialNumber": "XR240089",
      "status": "Available",
      "location": "Radiology Storage",
      "assignedTo": null,
      "startTime": null,
      "estimatedReturn": null,
      "condition": "Good",
      "batteryLevel": 92,
      "lastCalibration": "2024-12-01",
      "nextCalibration": "2025-03-01",
      "technician": "Tech. Mark Johnson",
      "notes": "Recently serviced, ready for use",
      "usageHours": 856,
      "maintenanceStatus": "Up to Date",
      "priority": "High",
    },
    {
      "id": "EQ003",
      "name": "Patient Monitor Advanced",
      "type": "Monitoring",
      "model": "PMA-500",
      "serialNumber": "PM240234",
      "status": "Reserved",
      "location": "OR-2",
      "assignedTo": "Surgery: Dr. Michael Chen",
      "startTime": "2024-12-15 14:00",
      "estimatedReturn": "2024-12-15 18:00",
      "condition": "Excellent",
      "batteryLevel": 78,
      "lastCalibration": "2024-11-15",
      "nextCalibration": "2025-02-15",
      "technician": "Tech. Lisa Anderson",
      "notes": "Reserved for cardiac surgery procedure",
      "usageHours": 2156,
      "maintenanceStatus": "Up to Date",
      "priority": "Critical",
    },
    {
      "id": "EQ004",
      "name": "Ultrasound Portable",
      "type": "Diagnostic",
      "model": "US-200P",
      "serialNumber": "US230445",
      "status": "Maintenance",
      "location": "Maintenance Workshop",
      "assignedTo": "Maintenance Team",
      "startTime": "2024-12-13 10:00",
      "estimatedReturn": "2024-12-16 16:00",
      "condition": "Fair",
      "batteryLevel": 0,
      "lastCalibration": "2024-10-15",
      "nextCalibration": "2025-01-15",
      "technician": "Tech. Robert Davis",
      "notes": "Screen replacement and software update in progress",
      "usageHours": 3421,
      "maintenanceStatus": "Overdue",
      "priority": "Medium",
    },
    {
      "id": "EQ005",
      "name": "Defibrillator AED",
      "type": "Life Support",
      "model": "AED-350",
      "serialNumber": "AED240112",
      "status": "Available",
      "location": "Emergency Room",
      "assignedTo": null,
      "startTime": null,
      "estimatedReturn": null,
      "condition": "Excellent",
      "batteryLevel": 95,
      "lastCalibration": "2024-12-01",
      "nextCalibration": "2025-06-01",
      "technician": "Dr. Emily Rodriguez",
      "notes": "Daily checks completed, fully operational",
      "usageHours": 125,
      "maintenanceStatus": "Up to Date",
      "priority": "Critical",
    },
    {
      "id": "EQ006",
      "name": "Surgical Microscope",
      "type": "Surgical",
      "model": "SM-800HD",
      "serialNumber": "SM240067",
      "status": "Out of Order",
      "location": "OR-1",
      "assignedTo": null,
      "startTime": null,
      "estimatedReturn": "2024-12-20 09:00",
      "condition": "Poor",
      "batteryLevel": 0,
      "lastCalibration": "2024-09-15",
      "nextCalibration": "2024-12-15",
      "technician": "Tech. David Wilson",
      "notes": "Lens system malfunction, replacement parts on order",
      "usageHours": 4567,
      "maintenanceStatus": "Critical",
      "priority": "High",
    },
  ];

  List<Map<String, dynamic>> get filteredEquipment {
    return equipment.where((item) {
      bool matchesSearch = item["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          item["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          item["serialNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || item["status"].toString().toLowerCase() == selectedStatus.toLowerCase();
      bool matchesLocation = selectedLocation == "All" || item["location"].toString().toLowerCase().contains(selectedLocation.toLowerCase());
      bool matchesType = selectedType == "All" || item["type"] == selectedType;
      
      return matchesSearch && matchesStatus && matchesLocation && matchesType;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'available':
        return successColor;
      case 'in use':
        return infoColor;
      case 'reserved':
        return warningColor;
      case 'maintenance':
        return warningColor;
      case 'out of order':
        return dangerColor;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Equipment Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {
              ss("QR scanner opened");
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Equipment status refreshed");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Real-time Status Dashboard
            Container(
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
                      Icon(
                        Icons.dashboard,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Real-time Equipment Status",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: successColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              "Live",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ResponsiveGridView(
                    minItemWidth: 200,
                    children: [
                      _buildStatusCard(
                        "Available",
                        "${equipment.where((e) => e["status"] == "Available").length}",
                        successColor,
                        Icons.check_circle,
                      ),
                      _buildStatusCard(
                        "In Use",
                        "${equipment.where((e) => e["status"] == "In Use").length}",
                        infoColor,
                        Icons.play_circle,
                      ),
                      _buildStatusCard(
                        "Reserved",
                        "${equipment.where((e) => e["status"] == "Reserved").length}",
                        warningColor,
                        Icons.schedule,
                      ),
                      _buildStatusCard(
                        "Maintenance",
                        "${equipment.where((e) => e["status"] == "Maintenance").length}",
                        warningColor,
                        Icons.build,
                      ),
                      _buildStatusCard(
                        "Out of Order",
                        "${equipment.where((e) => e["status"] == "Out of Order").length}",
                        dangerColor,
                        Icons.error,
                      ),
                      _buildStatusCard(
                        "Total Equipment",
                        "${equipment.length}",
                        primaryColor,
                        Icons.inventory,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Search and Filters
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
                    "Search & Filters",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search Equipment",
                          value: searchQuery,
                          hint: "Search by name, ID, or serial number",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.qr_code_scanner,
                        size: bs.sm,
                        onPressed: () {
                          ss("QR scanner activated");
                        },
                      ),
                    ],
                  ),
                  Row(
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
                    label: "Location",
                    items: locationOptions,
                    value: selectedLocation,
                    onChanged: (value, label) {
                      selectedLocation = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Equipment List
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
                          "Equipment Tracking",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${filteredEquipment.length} items found",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredEquipment.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final item = filteredEquipment[index];
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
                                          Text(
                                            "${item["name"]}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: spXs),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _getStatusColor("${item["status"]}").withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${item["status"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: _getStatusColor("${item["status"]}"),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Row(
                                        children: [
                                          Text(
                                            "ID: ${item["id"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          SizedBox(width: spSm),
                                          Text(
                                            "•",
                                            style: TextStyle(
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          SizedBox(width: spSm),
                                          Text(
                                            "${item["type"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
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
                                        color: _getPriorityColor("${item["priority"]}").withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${item["priority"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: _getPriorityColor("${item["priority"]}"),
                                        ),
                                      ),
                                    ),
                                    if (item["batteryLevel"] != null && (item["batteryLevel"] as int) > 0) ...[
                                      SizedBox(height: spXs),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.battery_std,
                                            size: 14,
                                            color: (item["batteryLevel"] as int) > 20 ? successColor : dangerColor,
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            "${item["batteryLevel"]}%",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: (item["batteryLevel"] as int) > 20 ? successColor : dangerColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
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
                                              Icons.location_on,
                                              size: 12,
                                              color: disabledBoldColor,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "${item["location"]}",
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
                                              Icons.timer,
                                              size: 12,
                                              color: disabledBoldColor,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "${item["usageHours"]}h",
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
                                  if (item["assignedTo"] != null) ...[
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          size: 12,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            "${item["assignedTo"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                  if (item["estimatedReturn"] != null) ...[
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.schedule,
                                          size: 12,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "Return: ${item["estimatedReturn"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: _getActionLabel("${item["status"]}"),
                                    size: bs.sm,
                                    onPressed: () {
                                      _performAction(item);
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.info,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Show details
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(String title, String count, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color.withAlpha(30),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 18,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            count,
            style: TextStyle(
              fontSize: fsH5,
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
      case 'available':
        return "Reserve";
      case 'in use':
        return "Return";
      case 'reserved':
        return "Check Out";
      case 'maintenance':
        return "View Status";
      case 'out of order':
        return "Report Issue";
      default:
        return "View";
    }
  }

  void _performAction(Map<String, dynamic> item) {
    String status = "${item["status"]}";
    String action = _getActionLabel(status);
    ss("$action performed for ${item["name"]}");
  }
}
