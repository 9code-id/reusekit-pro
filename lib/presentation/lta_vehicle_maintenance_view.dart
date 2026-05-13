import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaVehicleMaintenanceView extends StatefulWidget {
  const LtaVehicleMaintenanceView({super.key});

  @override
  State<LtaVehicleMaintenanceView> createState() => _LtaVehicleMaintenanceViewState();
}

class _LtaVehicleMaintenanceViewState extends State<LtaVehicleMaintenanceView> {
  bool loading = true;
  String searchQuery = "";
  String selectedStatus = "All Status";
  String selectedType = "All Types";
  String sortBy = "Recent";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All Status"},
    {"label": "Scheduled", "value": "Scheduled"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "All Types"},
    {"label": "Regular Service", "value": "Regular Service"},
    {"label": "Oil Change", "value": "Oil Change"},
    {"label": "Tire Service", "value": "Tire Service"},
    {"label": "Engine Service", "value": "Engine Service"},
    {"label": "Brake Service", "value": "Brake Service"},
    {"label": "Emergency Repair", "value": "Emergency Repair"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Recent", "value": "Recent"},
    {"label": "Oldest", "value": "Oldest"},
    {"label": "Cost High-Low", "value": "Cost High-Low"},
    {"label": "Cost Low-High", "value": "Cost Low-High"},
  ];

  List<Map<String, dynamic>> maintenanceRecords = [
    {
      "id": "MNT001",
      "vehicleId": "VH001",
      "vehiclePlate": "B 1234 ABC",
      "type": "Regular Service",
      "description": "Routine maintenance service including oil change, filter replacement, and brake check",
      "scheduledDate": "2024-03-20T00:00:00Z",
      "completedDate": "2024-03-20T00:00:00Z",
      "status": "Completed",
      "garage": "Toyota Service Center",
      "garageAddress": "Jl. Gatot Subroto No. 123, Jakarta",
      "mileage": 45000,
      "cost": 850000,
      "technician": "Budi Santoso",
      "parts": [
        {"name": "Engine Oil", "quantity": 4, "unit": "Liter", "cost": 200000},
        {"name": "Oil Filter", "quantity": 1, "unit": "Piece", "cost": 75000},
        {"name": "Air Filter", "quantity": 1, "unit": "Piece", "cost": 50000},
      ],
      "services": ["Oil Change", "Filter Replacement", "Brake Check", "Battery Check"],
      "notes": "All systems functioning normally. Next service in 6 months or 10,000 km.",
      "images": ["maintenance1.jpg", "maintenance2.jpg"],
      "priority": "Medium"
    },
    {
      "id": "MNT002",
      "vehicleId": "VH002",
      "vehiclePlate": "B 5678 DEF",
      "type": "Emergency Repair",
      "description": "Engine overheating issue - coolant system repair",
      "scheduledDate": "2024-03-18T00:00:00Z",
      "completedDate": "2024-03-19T00:00:00Z",
      "status": "Completed",
      "garage": "Express Auto Repair",
      "garageAddress": "Jl. Sudirman No. 456, Jakarta",
      "mileage": 52000,
      "cost": 1200000,
      "technician": "Ahmad Wijaya",
      "parts": [
        {"name": "Radiator", "quantity": 1, "unit": "Piece", "cost": 800000},
        {"name": "Coolant", "quantity": 2, "unit": "Liter", "cost": 100000},
        {"name": "Thermostat", "quantity": 1, "unit": "Piece", "cost": 150000},
      ],
      "services": ["Radiator Replacement", "Coolant Flush", "Thermostat Replacement"],
      "notes": "Radiator was completely damaged. Vehicle tested for 50km after repair.",
      "images": ["repair1.jpg", "repair2.jpg", "repair3.jpg"],
      "priority": "High"
    },
    {
      "id": "MNT003",
      "vehicleId": "VH001",
      "vehiclePlate": "B 1234 ABC",
      "type": "Tire Service",
      "description": "Tire replacement and wheel alignment",
      "scheduledDate": "2024-03-15T00:00:00Z",
      "completedDate": "2024-03-15T00:00:00Z",
      "status": "Completed",
      "garage": "Bridgestone Service Center",
      "garageAddress": "Jl. TB Simatupang No. 789, Jakarta",
      "mileage": 43500,
      "cost": 1500000,
      "technician": "Sari Dewi",
      "parts": [
        {"name": "Tire 185/65R15", "quantity": 4, "unit": "Piece", "cost": 1200000},
        {"name": "Valve Stem", "quantity": 4, "unit": "Piece", "cost": 40000},
      ],
      "services": ["Tire Replacement", "Wheel Alignment", "Balancing"],
      "notes": "All tires replaced due to uneven wear. Alignment fixed.",
      "images": ["tire1.jpg", "tire2.jpg"],
      "priority": "Medium"
    },
    {
      "id": "MNT004",
      "vehicleId": "VH003",
      "vehiclePlate": "B 9012 GHI",
      "type": "Regular Service",
      "description": "Scheduled maintenance service",
      "scheduledDate": "2024-03-25T00:00:00Z",
      "completedDate": null,
      "status": "Scheduled",
      "garage": "Honda Service Center",
      "garageAddress": "Jl. Rasuna Said No. 321, Jakarta",
      "mileage": 38000,
      "cost": 0,
      "technician": "TBD",
      "parts": [],
      "services": ["Oil Change", "Filter Check", "General Inspection"],
      "notes": "Upcoming scheduled service",
      "images": [],
      "priority": "Medium"
    },
    {
      "id": "MNT005",
      "vehicleId": "VH002",
      "vehiclePlate": "B 5678 DEF",
      "type": "Brake Service",
      "description": "Brake pad replacement and brake fluid change",
      "scheduledDate": "2024-03-22T00:00:00Z",
      "completedDate": null,
      "status": "In Progress",
      "garage": "Brake Specialist",
      "garageAddress": "Jl. Thamrin No. 654, Jakarta",
      "mileage": 52500,
      "cost": 750000,
      "technician": "Eko Prasetyo",
      "parts": [
        {"name": "Brake Pad Front", "quantity": 1, "unit": "Set", "cost": 300000},
        {"name": "Brake Pad Rear", "quantity": 1, "unit": "Set", "cost": 250000},
        {"name": "Brake Fluid", "quantity": 1, "unit": "Bottle", "cost": 50000},
      ],
      "services": ["Brake Pad Replacement", "Brake Fluid Change", "Brake Test"],
      "notes": "Brake pads were worn out. Service in progress.",
      "images": ["brake1.jpg"],
      "priority": "High"
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadMaintenanceData();
  }

  void _loadMaintenanceData() async {
    await Future.delayed(Duration(seconds: 1));
    loading = false;
    setState(() {});
  }

  List<Map<String, dynamic>> get filteredAndSortedRecords {
    List<Map<String, dynamic>> filtered = maintenanceRecords.where((record) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${record["vehiclePlate"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${record["type"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${record["garage"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${record["technician"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All Status" || record["status"] == selectedStatus;
      bool matchesType = selectedType == "All Types" || record["type"] == selectedType;
      
      return matchesSearch && matchesStatus && matchesType;
    }).toList();

    switch (sortBy) {
      case "Recent":
        filtered.sort((a, b) => 
            DateTime.parse("${b["scheduledDate"]}").compareTo(DateTime.parse("${a["scheduledDate"]}")));
        break;
      case "Oldest":
        filtered.sort((a, b) => 
            DateTime.parse("${a["scheduledDate"]}").compareTo(DateTime.parse("${b["scheduledDate"]}")));
        break;
      case "Cost High-Low":
        filtered.sort((a, b) => (b["cost"] as int).compareTo(a["cost"] as int));
        break;
      case "Cost Low-High":
        filtered.sort((a, b) => (a["cost"] as int).compareTo(b["cost"] as int));
        break;
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'in progress':
        return warningColor;
      case 'scheduled':
        return infoColor;
      case 'cancelled':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'regular service':
        return Icons.build;
      case 'oil change':
        return Icons.oil_barrel;
      case 'tire service':
        return Icons.tire_repair;
      case 'engine service':
        return Icons.settings;
      case 'brake service':
        return Icons.disc_full;
      case 'emergency repair':
        return Icons.warning;
      default:
        return Icons.build;
    }
  }

  void _deleteMaintenanceRecord(String recordId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this maintenance record?");
    if (isConfirmed) {
      maintenanceRecords.removeWhere((record) => record["id"] == recordId);
      setState(() {});
      ss("Maintenance record deleted successfully");
    }
  }

  void _showMaintenanceDetails(Map<String, dynamic> record) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: 500,
          padding: EdgeInsets.all(spMd),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(_getTypeIcon("${record["type"]}"), color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${record["type"]}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                SizedBox(height: spMd),

                // Vehicle Info
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.local_shipping, color: primaryColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "${record["vehiclePlate"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${((record["mileage"] as int) / 1000).toStringAsFixed(1)}K km",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spMd),

                // Description
                Text(
                  "Description:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${record["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spMd),

                // Services
                if ((record["services"] as List).isNotEmpty) ...[
                  Text(
                    "Services Performed:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (record["services"] as List).map((service) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                        decoration: BoxDecoration(
                          color: secondaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "$service",
                          style: TextStyle(
                            fontSize: 12,
                            color: secondaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: spMd),
                ],

                // Parts Used
                if ((record["parts"] as List).isNotEmpty) ...[
                  Text(
                    "Parts Used:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Column(
                    children: (record["parts"] as List).map((part) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spXs),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${part["name"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Text(
                              "${part["quantity"]} ${part["unit"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Rp ${((part["cost"] as int).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: spMd),
                ],

                // Notes
                if (record["notes"].isNotEmpty) ...[
                  Text(
                    "Notes:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${record["notes"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: primaryColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Vehicle Maintenance"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    List<Map<String, dynamic>> displayRecords = filteredAndSortedRecords;

    return Scaffold(
      appBar: AppBar(
        title: Text("Vehicle Maintenance"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add new maintenance record
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            QTextField(
              label: "Search maintenance records...",
              value: searchQuery,
              hint: "Search by vehicle, type, garage, or technician",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Filters
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
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Sort by",
                    items: sortOptions,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Summary Stats
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
                    "Maintenance Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 120,
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${maintenanceRecords.where((r) => r["status"] == "Completed").length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Completed",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: warningColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${maintenanceRecords.where((r) => r["status"] == "In Progress").length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "In Progress",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${maintenanceRecords.where((r) => r["status"] == "Scheduled").length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Scheduled",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Rp ${((maintenanceRecords.fold(0, (sum, record) => sum + (record["cost"] as int))).toDouble() / 1000000).toStringAsFixed(1)}M",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Cost",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
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

            // Results Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${displayRecords.length} maintenance records found",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Maintenance Records List
            if (displayRecords.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.build,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No maintenance records found",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters or add a new maintenance record",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    QButton(
                      label: "Add Maintenance Record",
                      icon: Icons.add,
                      size: bs.md,
                      onPressed: () {
                        // Add maintenance record
                      },
                    ),
                  ],
                ),
              )
            else
              Column(
                children: displayRecords.map((record) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          color: _getStatusColor("${record["status"]}"),
                          width: 4,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: primaryColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  _getTypeIcon("${record["type"]}"),
                                  color: primaryColor,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${record["type"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${record["vehiclePlate"]} • ${((record["mileage"] as int) / 1000).toStringAsFixed(1)}K km",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _getStatusColor("${record["status"]}").withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${record["status"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _getStatusColor("${record["status"]}"),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spMd),

                          // Description
                          Text(
                            "${record["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spMd),

                          // Details
                          Row(
                            children: [
                              Icon(Icons.store, size: 14, color: disabledBoldColor),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  "${record["garage"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(Icons.person, size: 14, color: disabledBoldColor),
                              SizedBox(width: 4),
                              Text(
                                "${record["technician"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),

                          Row(
                            children: [
                              Icon(Icons.calendar_today, size: 14, color: disabledBoldColor),
                              SizedBox(width: 4),
                              Text(
                                DateTime.parse("${record["scheduledDate"]}").dMMMy,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              if (record["completedDate"] != null) ...[
                                SizedBox(width: spSm),
                                Icon(Icons.check_circle, size: 14, color: successColor),
                                SizedBox(width: 4),
                                Text(
                                  "Completed: ${DateTime.parse("${record["completedDate"]}").dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                  ),
                                ),
                              ],
                              Spacer(),
                              if ((record["cost"] as int) > 0)
                                Text(
                                  "Rp ${((record["cost"] as int).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: spMd),

                          // Services tags
                          if ((record["services"] as List).isNotEmpty)
                            Wrap(
                              spacing: spXs,
                              runSpacing: 4,
                              children: (record["services"] as List).take(3).map((service) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: secondaryColor.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "$service",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: secondaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          SizedBox(height: spMd),

                          // Actions
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getPriorityColor("${record["priority"]}").withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${record["priority"]} Priority",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _getPriorityColor("${record["priority"]}"),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Spacer(),
                              QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () => _showMaintenanceDetails(record),
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                label: "Edit",
                                size: bs.sm,
                                onPressed: () {
                                  // Edit maintenance record
                                },
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.delete,
                                size: bs.sm,
                                onPressed: () => _deleteMaintenanceRecord("${record["id"]}"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
