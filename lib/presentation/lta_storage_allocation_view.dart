import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaStorageAllocationView extends StatefulWidget {
  const LtaStorageAllocationView({super.key});

  @override
  State<LtaStorageAllocationView> createState() => _LtaStorageAllocationViewState();
}

class _LtaStorageAllocationViewState extends State<LtaStorageAllocationView> {
  bool loading = true;
  String searchQuery = "";
  String selectedZone = "All Zones";
  String selectedStatus = "All Status";
  String selectedCategory = "All Categories";
  int currentTab = 0;

  List<Map<String, dynamic>> zoneOptions = [
    {"label": "All Zones", "value": "All Zones"},
    {"label": "Zone A", "value": "Zone A"},
    {"label": "Zone B", "value": "Zone B"},
    {"label": "Zone C", "value": "Zone C"},
    {"label": "Zone D", "value": "Zone D"},
    {"label": "Cold Storage", "value": "Cold Storage"},
    {"label": "Hazmat", "value": "Hazmat"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All Status"},
    {"label": "Available", "value": "Available"},
    {"label": "Occupied", "value": "Occupied"},
    {"label": "Reserved", "value": "Reserved"},
    {"label": "Maintenance", "value": "Maintenance"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "All Categories"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Automotive", "value": "Automotive"},
    {"label": "Pharmaceuticals", "value": "Pharmaceuticals"},
    {"label": "Food", "value": "Food"},
    {"label": "Chemicals", "value": "Chemicals"},
    {"label": "General", "value": "General"},
  ];

  List<Map<String, dynamic>> storageLocations = [
    {
      "id": "storage_001",
      "location": "A-01-15",
      "zone": "Zone A",
      "section": "A-01",
      "level": 1,
      "position": 15,
      "status": "Occupied",
      "category": "Electronics",
      "capacity": 100,
      "utilized": 85,
      "items": [
        {"sku": "EL-001", "description": "Smartphones", "quantity": 50, "weight": 0.8},
        {"sku": "EL-002", "description": "Tablets", "quantity": 25, "weight": 0.6},
        {"sku": "EL-003", "description": "Laptops", "quantity": 15, "weight": 0.4},
      ],
      "assignedDate": "2024-03-10T09:00:00Z",
      "expectedClearance": "2024-03-20T16:00:00Z",
      "temperature": 22.5,
      "humidity": 45,
      "lastUpdated": "2024-03-15T10:30:00Z",
      "accessFrequency": "High",
      "specialRequirements": ["Climate Controlled", "Security Level 2"],
      "notes": "High-value electronics requiring climate control",
    },
    {
      "id": "storage_002",
      "location": "B-02-08",
      "zone": "Zone B",
      "section": "B-02",
      "level": 2,
      "position": 8,
      "status": "Available",
      "category": "",
      "capacity": 150,
      "utilized": 0,
      "items": [],
      "assignedDate": "",
      "expectedClearance": "",
      "temperature": 18.2,
      "humidity": 50,
      "lastUpdated": "2024-03-15T08:00:00Z",
      "accessFrequency": "Medium",
      "specialRequirements": ["Standard Storage"],
      "notes": "",
    },
    {
      "id": "storage_003",
      "location": "C-01-22",
      "zone": "Zone C",
      "section": "C-01",
      "level": 1,
      "position": 22,
      "status": "Occupied",
      "category": "Automotive",
      "capacity": 200,
      "utilized": 180,
      "items": [
        {"sku": "AU-101", "description": "Engine Parts", "quantity": 45, "weight": 2.5},
        {"sku": "AU-102", "description": "Brake Components", "quantity": 65, "weight": 1.8},
        {"sku": "AU-103", "description": "Filters", "quantity": 120, "weight": 0.6},
      ],
      "assignedDate": "2024-03-08T14:30:00Z",
      "expectedClearance": "2024-03-18T12:00:00Z",
      "temperature": 20.1,
      "humidity": 42,
      "lastUpdated": "2024-03-15T09:45:00Z",
      "accessFrequency": "Medium",
      "specialRequirements": ["Heavy Duty Shelving"],
      "notes": "Heavy automotive parts - reinforced storage area",
    },
    {
      "id": "storage_004",
      "location": "CS-01-05",
      "zone": "Cold Storage",
      "section": "CS-01",
      "level": 1,
      "position": 5,
      "status": "Reserved",
      "category": "Pharmaceuticals",
      "capacity": 75,
      "utilized": 0,
      "items": [],
      "assignedDate": "2024-03-15T15:00:00Z",
      "expectedClearance": "2024-03-17T10:00:00Z",
      "temperature": 4.2,
      "humidity": 35,
      "lastUpdated": "2024-03-15T12:00:00Z",
      "accessFrequency": "Low",
      "specialRequirements": ["Temperature Controlled", "Cold Chain", "Security Level 3"],
      "notes": "Reserved for temperature-sensitive pharmaceuticals",
    },
    {
      "id": "storage_005",
      "location": "HZ-01-03",
      "zone": "Hazmat",
      "section": "HZ-01",
      "level": 1,
      "position": 3,
      "status": "Occupied",
      "category": "Chemicals",
      "capacity": 50,
      "utilized": 30,
      "items": [
        {"sku": "CH-201", "description": "Industrial Cleaners", "quantity": 25, "weight": 0.8},
        {"sku": "CH-202", "description": "Paint Thinners", "quantity": 15, "weight": 0.6},
      ],
      "assignedDate": "2024-03-12T11:15:00Z",
      "expectedClearance": "2024-03-22T16:30:00Z",
      "temperature": 19.8,
      "humidity": 40,
      "lastUpdated": "2024-03-15T11:20:00Z",
      "accessFrequency": "Low",
      "specialRequirements": ["Hazmat Certification", "Ventilation", "Emergency Equipment"],
      "notes": "Hazardous chemicals requiring special handling protocols",
    },
    {
      "id": "storage_006",
      "location": "D-03-12",
      "zone": "Zone D",
      "section": "D-03",
      "level": 3,
      "position": 12,
      "status": "Maintenance",
      "category": "",
      "capacity": 120,
      "utilized": 0,
      "items": [],
      "assignedDate": "",
      "expectedClearance": "",
      "temperature": 21.5,
      "humidity": 48,
      "lastUpdated": "2024-03-15T07:30:00Z",
      "accessFrequency": "High",
      "specialRequirements": ["Under Maintenance"],
      "notes": "Shelf repair in progress - estimated completion March 18",
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadStorageData();
  }

  void _loadStorageData() async {
    await Future.delayed(Duration(seconds: 1));
    loading = false;
    setState(() {});
  }

  List<Map<String, dynamic>> get filteredLocations {
    return storageLocations.where((location) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${location["location"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${location["zone"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${location["category"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          (location["items"] as List).any((item) => 
              "${item["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
              "${item["sku"]}".toLowerCase().contains(searchQuery.toLowerCase()));
      
      bool matchesZone = selectedZone == "All Zones" || 
          location["zone"] == selectedZone;
      
      bool matchesStatus = selectedStatus == "All Status" || 
          location["status"] == selectedStatus;
      
      bool matchesCategory = selectedCategory == "All Categories" || 
          location["category"] == selectedCategory;
      
      return matchesSearch && matchesZone && matchesStatus && matchesCategory;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Available":
        return successColor;
      case "Occupied":
        return primaryColor;
      case "Reserved":
        return warningColor;
      case "Maintenance":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "Available":
        return Icons.check_circle;
      case "Occupied":
        return Icons.inventory;
      case "Reserved":
        return Icons.schedule;
      case "Maintenance":
        return Icons.build;
      default:
        return Icons.help;
    }
  }

  String _getAccessFrequencyColor(String frequency) {
    switch (frequency) {
      case "High":
        return "red";
      case "Medium":
        return "orange";
      case "Low":
        return "green";
      default:
        return "gray";
    }
  }

  Widget _buildStorageOverview() {
    List<Map<String, dynamic>> displayLocations = filteredLocations;
    int availableSpaces = displayLocations.where((l) => l["status"] == "Available").length;
    int occupiedSpaces = displayLocations.where((l) => l["status"] == "Occupied").length;
    int reservedSpaces = displayLocations.where((l) => l["status"] == "Reserved").length;
    int maintenanceSpaces = displayLocations.where((l) => l["status"] == "Maintenance").length;
    
    double totalCapacity = displayLocations.fold(0.0, (sum, location) => sum + (location["capacity"] as num).toDouble());
    double totalUtilized = displayLocations.fold(0.0, (sum, location) => sum + (location["utilized"] as num).toDouble());
    double utilizationPercentage = totalCapacity > 0 ? (totalUtilized / totalCapacity) * 100 : 0;

    return Column(
      spacing: spMd,
      children: [
        // Overview Cards
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: [
            _buildOverviewCard("Available", availableSpaces, successColor, Icons.check_circle),
            _buildOverviewCard("Occupied", occupiedSpaces, primaryColor, Icons.inventory),
            _buildOverviewCard("Reserved", reservedSpaces, warningColor, Icons.schedule),
            _buildOverviewCard("Maintenance", maintenanceSpaces, dangerColor, Icons.build),
          ],
        ),

        // Utilization Summary
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
              Text(
                "Storage Utilization",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Overall Utilization",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: 4),
                        LinearProgressIndicator(
                          value: utilizationPercentage / 100,
                          backgroundColor: Colors.grey.withValues(alpha: 0.2),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            utilizationPercentage > 80 ? dangerColor :
                            utilizationPercentage > 60 ? warningColor : successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: spMd),
                  Text(
                    "${utilizationPercentage.toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: utilizationPercentage > 80 ? dangerColor :
                             utilizationPercentage > 60 ? warningColor : successColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Text(
                    "Total Capacity: ${totalCapacity.toInt()} units",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Text(
                    "Utilized: ${totalUtilized.toInt()} units",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Storage Locations List
        Column(
          children: displayLocations.map((location) => _buildStorageCard(location)).toList(),
        ),
      ],
    );
  }

  Widget _buildOverviewCard(String title, int count, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "$count",
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStorageCard(Map<String, dynamic> location) {
    String status = "${location["status"]}";
    bool isOccupied = status == "Occupied";
    bool isReserved = status == "Reserved";
    double utilizationPercentage = (location["utilized"] as num) / (location["capacity"] as num) * 100;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: _getStatusColor(status),
            width: 4,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                _getStatusIcon(status),
                color: _getStatusColor(status),
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "${location["location"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStatusColor(status).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 10,
                    color: _getStatusColor(status),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: secondaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${location["zone"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: secondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),

          // Location Details
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text(
                          "Section ${location["section"]}, Level ${location["level"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    if ("${location["category"]}".isNotEmpty) ...[
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(Icons.category, size: 14, color: disabledBoldColor),
                          SizedBox(width: 4),
                          Text(
                            "${location["category"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.thermostat, size: 14, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text(
                          "${(location["temperature"] as num).toStringAsFixed(1)}°C",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.water_drop, size: 14, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text(
                          "${location["humidity"]}% RH",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),

          // Capacity Utilization
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Capacity Utilization",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${location["utilized"]}/${location["capacity"]} units (${utilizationPercentage.toInt()}%)",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              LinearProgressIndicator(
                value: utilizationPercentage / 100,
                backgroundColor: Colors.grey.withValues(alpha: 0.2),
                valueColor: AlwaysStoppedAnimation<Color>(
                  utilizationPercentage > 90 ? dangerColor :
                  utilizationPercentage > 70 ? warningColor : successColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),

          // Special Requirements
          if ((location["specialRequirements"] as List).isNotEmpty) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Special Requirements:",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: 2),
                Wrap(
                  spacing: spXs,
                  children: (location["specialRequirements"] as List).map((req) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                      decoration: BoxDecoration(
                        color: infoColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "$req",
                        style: TextStyle(
                          fontSize: 9,
                          color: infoColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: spSm),
          ],

          // Items (if occupied)
          if (isOccupied && (location["items"] as List).isNotEmpty) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Stored Items:",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: 4),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Column(
                    children: (location["items"] as List).map((item) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: Row(
                          children: [
                            Text(
                              "${item["sku"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${item["description"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                            Text(
                              "Qty: ${item["quantity"]}",
                              style: TextStyle(
                                fontSize: 9,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
          ],

          // Notes
          if ("${location["notes"]}".isNotEmpty) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: warningColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.note, size: 12, color: warningColor),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      "${location["notes"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: warningColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spSm),
          ],

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: status == "Available" ? "Allocate Space" : 
                         status == "Occupied" ? "View Items" :
                         status == "Reserved" ? "Confirm Allocation" : "Schedule Repair",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.qr_code,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildZoneView() {
    Map<String, List<Map<String, dynamic>>> zoneGroups = {};
    for (var location in filteredLocations) {
      String zone = "${location["zone"]}";
      if (!zoneGroups.containsKey(zone)) {
        zoneGroups[zone] = [];
      }
      zoneGroups[zone]!.add(location);
    }

    return Column(
      spacing: spMd,
      children: zoneGroups.entries.map((entry) {
        String zoneName = entry.key;
        List<Map<String, dynamic>> zoneLocations = entry.value;
        
        int available = zoneLocations.where((l) => l["status"] == "Available").length;
        int occupied = zoneLocations.where((l) => l["status"] == "Occupied").length;
        int reserved = zoneLocations.where((l) => l["status"] == "Reserved").length;
        int maintenance = zoneLocations.where((l) => l["status"] == "Maintenance").length;
        
        double totalCapacity = zoneLocations.fold(0.0, (sum, location) => sum + (location["capacity"] as num).toDouble());
        double totalUtilized = zoneLocations.fold(0.0, (sum, location) => sum + (location["utilized"] as num).toDouble());
        double utilizationPercentage = totalCapacity > 0 ? (totalUtilized / totalCapacity) * 100 : 0;

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
              // Zone Header
              Row(
                children: [
                  Icon(
                    Icons.warehouse,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    zoneName,
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${utilizationPercentage.toStringAsFixed(1)}% utilized",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: utilizationPercentage > 80 ? dangerColor :
                             utilizationPercentage > 60 ? warningColor : successColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),

              // Zone Statistics
              Row(
                children: [
                  _buildZoneStatItem("Available", available, successColor),
                  _buildZoneStatItem("Occupied", occupied, primaryColor),
                  _buildZoneStatItem("Reserved", reserved, warningColor),
                  _buildZoneStatItem("Maintenance", maintenance, dangerColor),
                ],
              ),
              SizedBox(height: spSm),

              // Utilization Bar
              LinearProgressIndicator(
                value: utilizationPercentage / 100,
                backgroundColor: Colors.grey.withValues(alpha: 0.2),
                valueColor: AlwaysStoppedAnimation<Color>(
                  utilizationPercentage > 80 ? dangerColor :
                  utilizationPercentage > 60 ? warningColor : successColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "Capacity: ${totalUtilized.toInt()}/${totalCapacity.toInt()} units",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildZoneStatItem(String label, int count, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(
            "$count",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Storage Allocation"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return QTabBar(
      title: "Storage Allocation",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Locations", icon: Icon(Icons.location_on)),
        Tab(text: "Zones", icon: Icon(Icons.warehouse)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Search and Filters
              QTextField(
                label: "Search storage locations...",
                value: searchQuery,
                hint: "Search by location, zone, category, or items",
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),

              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Zone",
                      items: zoneOptions,
                      value: selectedZone,
                      onChanged: (value, label) {
                        selectedZone = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
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
                ],
              ),

              QDropdownField(
                label: "Category",
                items: categoryOptions,
                value: selectedCategory,
                onChanged: (value, label) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),

              _buildStorageOverview(),
            ],
          ),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildZoneView(),
        ),
      ],
    );
  }
}
