import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmCustomerEquipmentView extends StatefulWidget {
  const FsmCustomerEquipmentView({super.key});

  @override
  State<FsmCustomerEquipmentView> createState() => _FsmCustomerEquipmentViewState();
}

class _FsmCustomerEquipmentViewState extends State<FsmCustomerEquipmentView> {
  String searchQuery = "";
  String selectedLocation = "all";
  String selectedCategory = "all";
  String selectedStatus = "all";
  
  List<Map<String, dynamic>> locationOptions = [
    {"label": "All Locations", "value": "all"},
    {"label": "Main Office", "value": "LOC001"},
    {"label": "R&D Center", "value": "LOC002"},
    {"label": "Warehouse A", "value": "LOC003"},
    {"label": "Data Center", "value": "LOC004"},
  ];
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "HVAC", "value": "hvac"},
    {"label": "Electrical", "value": "electrical"},
    {"label": "Security", "value": "security"},
    {"label": "IT Equipment", "value": "it"},
    {"label": "Plumbing", "value": "plumbing"},
    {"label": "Fire Safety", "value": "fire_safety"},
  ];
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Operational", "value": "operational"},
    {"label": "Maintenance Required", "value": "maintenance_required"},
    {"label": "Under Repair", "value": "under_repair"},
    {"label": "Out of Service", "value": "out_of_service"},
  ];
  
  Map<String, dynamic> customer = {
    "id": "CUST001",
    "name": "TechCorp Industries",
    "total_equipment": 48,
  };
  
  List<Map<String, dynamic>> equipment = [
    {
      "id": "EQ001",
      "name": "Central HVAC Unit A",
      "category": "hvac",
      "brand": "Carrier",
      "model": "30XA-1002",
      "serial_number": "CV-2023-001",
      "location_id": "LOC001",
      "location_name": "Main Office",
      "status": "operational",
      "installation_date": "2022-03-15",
      "warranty_expiry": "2025-03-15",
      "last_maintenance": "2024-01-10",
      "next_maintenance": "2024-04-10",
      "maintenance_frequency": "Quarterly",
      "criticality": "high",
      "service_contract": true,
      "notes": "Primary HVAC system for main building. Critical for operations.",
      "specifications": {
        "capacity": "50 tons",
        "voltage": "480V",
        "power": "75 kW",
        "refrigerant": "R-410A"
      },
    },
    {
      "id": "EQ002",
      "name": "Emergency Generator",
      "category": "electrical",
      "brand": "Caterpillar",
      "model": "C32-ACERT",
      "serial_number": "CAT-2023-002",
      "location_id": "LOC001",
      "location_name": "Main Office",
      "status": "operational",
      "installation_date": "2021-08-20",
      "warranty_expiry": "2026-08-20",
      "last_maintenance": "2024-01-05",
      "next_maintenance": "2024-02-05",
      "maintenance_frequency": "Monthly",
      "criticality": "critical",
      "service_contract": true,
      "notes": "Backup power supply for entire facility. Must be tested monthly.",
      "specifications": {
        "power_output": "800 kW",
        "fuel_type": "Diesel",
        "fuel_capacity": "500 gallons",
        "runtime": "24 hours"
      },
    },
    {
      "id": "EQ003",
      "name": "Fire Suppression System",
      "category": "fire_safety",
      "brand": "Ansul",
      "model": "R-102",
      "serial_number": "ANS-2023-003",
      "location_id": "LOC002",
      "location_name": "R&D Center",
      "status": "maintenance_required",
      "installation_date": "2023-01-10",
      "warranty_expiry": "2026-01-10",
      "last_maintenance": "2023-07-10",
      "next_maintenance": "2024-01-20",
      "maintenance_frequency": "Semi-annual",
      "criticality": "critical",
      "service_contract": true,
      "notes": "Overdue for inspection. Schedule immediately.",
      "specifications": {
        "coverage_area": "2000 sq ft",
        "agent_type": "FM-200",
        "detection_type": "Smoke & Heat",
        "zones": "4"
      },
    },
    {
      "id": "EQ004",
      "name": "Server Rack Cooling Unit",
      "category": "hvac",
      "brand": "Liebert",
      "model": "PCW-140",
      "serial_number": "LIE-2023-004",
      "location_id": "LOC004",
      "location_name": "Data Center",
      "status": "under_repair",
      "installation_date": "2023-05-15",
      "warranty_expiry": "2026-05-15",
      "last_maintenance": "2024-01-08",
      "next_maintenance": "2024-01-25",
      "maintenance_frequency": "Monthly",
      "criticality": "critical",
      "service_contract": true,
      "notes": "Currently being repaired. Compressor failure detected.",
      "specifications": {
        "cooling_capacity": "40 kW",
        "airflow": "4000 CFM",
        "voltage": "208V",
        "refrigerant": "R-134a"
      },
    },
    {
      "id": "EQ005",
      "name": "Access Control System",
      "category": "security",
      "brand": "HID Global",
      "model": "iCLASS SE",
      "serial_number": "HID-2023-005",
      "location_id": "LOC001",
      "location_name": "Main Office",
      "status": "operational",
      "installation_date": "2023-11-12",
      "warranty_expiry": "2026-11-12",
      "last_maintenance": "2024-01-12",
      "next_maintenance": "2024-04-12",
      "maintenance_frequency": "Quarterly",
      "criticality": "medium",
      "service_contract": false,
      "notes": "Recently installed. Working well.",
      "specifications": {
        "card_readers": "12",
        "door_controllers": "4",
        "cameras": "16",
        "software": "VertX V1000"
      },
    },
    {
      "id": "EQ006",
      "name": "Water Heater System",
      "category": "plumbing",
      "brand": "Bradford White",
      "model": "MI753T6FBN",
      "serial_number": "BW-2023-006",
      "location_id": "LOC003",
      "location_name": "Warehouse A",
      "status": "out_of_service",
      "installation_date": "2020-05-05",
      "warranty_expiry": "2023-05-05",
      "last_maintenance": "2023-12-20",
      "next_maintenance": "",
      "maintenance_frequency": "Annual",
      "criticality": "low",
      "service_contract": false,
      "notes": "Needs replacement. Beyond economical repair.",
      "specifications": {
        "capacity": "75 gallons",
        "power": "75000 BTU",
        "fuel_type": "Natural Gas",
        "efficiency": "82%"
      },
    },
  ];

  List<Map<String, dynamic>> get filteredEquipment {
    return equipment.where((item) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${item["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${item["brand"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${item["model"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${item["serial_number"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesLocation = selectedLocation == "all" || item["location_id"] == selectedLocation;
      bool matchesCategory = selectedCategory == "all" || item["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "all" || item["status"] == selectedStatus;
      
      return matchesSearch && matchesLocation && matchesCategory && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "operational":
        return successColor;
      case "maintenance_required":
        return warningColor;
      case "under_repair":
        return dangerColor;
      case "out_of_service":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getCriticalityColor(String criticality) {
    switch (criticality) {
      case "critical":
        return dangerColor;
      case "high":
        return warningColor;
      case "medium":
        return infoColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "hvac":
        return infoColor;
      case "electrical":
        return warningColor;
      case "security":
        return primaryColor;
      case "it":
        return successColor;
      case "plumbing":
        return Colors.cyan;
      case "fire_safety":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildEquipmentCard(Map<String, dynamic> item) {
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
            color: _getCategoryColor("${item["category"]}"),
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
                    Row(
                      children: [
                        Text(
                          "${item["id"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getCategoryColor("${item["category"]}").withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${item["category"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _getCategoryColor("${item["category"]}"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${item["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
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
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor("${item["status"]}").withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      "${item["status"]}".replaceAll("_", " ").toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor("${item["status"]}"),
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getCriticalityColor("${item["criticality"]}").withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      "${item["criticality"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: _getCriticalityColor("${item["criticality"]}"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${item["brand"]} ${item["model"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${item["location_name"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              if (item["service_contract"] == true)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Text(
                    "CONTRACT",
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(
                Icons.tag,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "SN: ${item["serial_number"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Installed",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${item["installation_date"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Warranty",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${item["warranty_expiry"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Frequency",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${item["maintenance_frequency"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if ("${item["next_maintenance"]}".isNotEmpty) ...[
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 14,
                        color: warningColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Next Maintenance: ${item["next_maintenance"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          if ("${item["notes"]}".isNotEmpty) ...[
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: Colors.blue[100]!),
              ),
              child: Text(
                "${item["notes"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.blue[800],
                ),
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
                    // Navigate to equipment detail
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "History",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to service history
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.build,
                size: bs.sm,
                onPressed: () {
                  // Schedule maintenance
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${customer["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Equipment Inventory",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  // Add new equipment
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Equipment", "${customer["total_equipment"]}", Icons.devices),
              _buildStatCard("Operational", "${equipment.where((e) => e["status"] == "operational").length}", Icons.check_circle),
              _buildStatCard("Need Maintenance", "${equipment.where((e) => e["status"] == "maintenance_required").length}", Icons.warning),
              _buildStatCard("Under Service Contract", "${equipment.where((e) => e["service_contract"] == true).length}", Icons.verified),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: primaryColor,
                size: 20,
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
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
        title: Text("Customer Equipment"),
        actions: [
          QButton(
            icon: Icons.qr_code_scanner,
            size: bs.sm,
            onPressed: () {
              // QR code scanner
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                _buildSummaryCard(),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search equipment...",
                        value: searchQuery,
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
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
                        label: "Location",
                        items: locationOptions,
                        value: selectedLocation,
                        onChanged: (value, label) {
                          selectedLocation = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categoryOptions,
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
                          setState(() {});
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
                        items: statusOptions,
                        value: selectedStatus,
                        onChanged: (value, label) {
                          selectedStatus = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.filter_list,
                      size: bs.sm,
                      onPressed: () {
                        // Advanced filters
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredEquipment.length,
              itemBuilder: (context, index) {
                return _buildEquipmentCard(filteredEquipment[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
