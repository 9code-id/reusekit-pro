import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaEquipmentManagementView extends StatefulWidget {
  const ComaEquipmentManagementView({super.key});

  @override
  State<ComaEquipmentManagementView> createState() => _ComaEquipmentManagementViewState();
}

class _ComaEquipmentManagementViewState extends State<ComaEquipmentManagementView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedType = "All";
  String selectedLocation = "All";
  DateTime? fromDate;
  DateTime? toDate;
  
  List<Map<String, dynamic>> equipment = [
    {
      "id": "EQ-001",
      "name": "Tower Crane TC-5013",
      "type": "Heavy Machinery",
      "brand": "Liebherr",
      "model": "TC 5013",
      "serialNumber": "LC5013-2023-001",
      "status": "Active",
      "condition": "Good",
      "location": "Site A - Block 1",
      "operator": "Michael Chen",
      "purchaseDate": "2023-01-15",
      "lastMaintenance": "2024-03-10",
      "nextMaintenance": "2024-04-10",
      "workingHours": 2450,
      "purchaseValue": 850000.0,
      "currentValue": 680000.0,
      "dailyRate": 1200.0,
      "fuelConsumption": 15.5,
      "efficiency": 92,
      "utilisationRate": 78,
      "maintenanceCost": 15000.0,
      "certificationExpiry": "2024-12-31",
      "image": "https://picsum.photos/300/200?random=1&keyword=crane"
    },
    {
      "id": "EQ-002",
      "name": "Excavator CAT 320",
      "type": "Heavy Machinery",
      "brand": "Caterpillar",
      "model": "320 GC",
      "serialNumber": "CAT320-2022-045",
      "status": "Active",
      "condition": "Excellent",
      "location": "Site B - Foundation",
      "operator": "James Rodriguez",
      "purchaseDate": "2022-08-20",
      "lastMaintenance": "2024-03-05",
      "nextMaintenance": "2024-04-05",
      "workingHours": 3200,
      "purchaseValue": 320000.0,
      "currentValue": 280000.0,
      "dailyRate": 800.0,
      "fuelConsumption": 12.8,
      "efficiency": 95,
      "utilisationRate": 85,
      "maintenanceCost": 8500.0,
      "certificationExpiry": "2024-08-31",
      "image": "https://picsum.photos/300/200?random=2&keyword=excavator"
    },
    {
      "id": "EQ-003",
      "name": "Concrete Mixer Truck",
      "type": "Transport Vehicle",
      "brand": "Volvo",
      "model": "FM 460",
      "serialNumber": "VLV460-2023-012",
      "status": "Maintenance",
      "condition": "Fair",
      "location": "Maintenance Workshop",
      "operator": "Robert Kim",
      "purchaseDate": "2023-06-10",
      "lastMaintenance": "2024-03-20",
      "nextMaintenance": "2024-04-20",
      "workingHours": 1850,
      "purchaseValue": 180000.0,
      "currentValue": 160000.0,
      "dailyRate": 450.0,
      "fuelConsumption": 22.0,
      "efficiency": 88,
      "utilisationRate": 65,
      "maintenanceCost": 5200.0,
      "certificationExpiry": "2024-06-30",
      "image": "https://picsum.photos/300/200?random=3&keyword=truck"
    },
    {
      "id": "EQ-004",
      "name": "Scaffolding System",
      "type": "Support Equipment",
      "brand": "PERI",
      "model": "MULTIFLEX",
      "serialNumber": "PERI-MF-2022-089",
      "status": "Active",
      "condition": "Good",
      "location": "Site A - Block 2",
      "operator": "Construction Team A",
      "purchaseDate": "2022-11-30",
      "lastMaintenance": "2024-02-28",
      "nextMaintenance": "2024-05-28",
      "workingHours": 0,
      "purchaseValue": 45000.0,
      "currentValue": 38000.0,
      "dailyRate": 120.0,
      "fuelConsumption": 0.0,
      "efficiency": 100,
      "utilisationRate": 90,
      "maintenanceCost": 1200.0,
      "certificationExpiry": "2025-11-30",
      "image": "https://picsum.photos/300/200?random=4&keyword=scaffolding"
    },
    {
      "id": "EQ-005",
      "name": "Welding Machine",
      "type": "Power Tools",
      "brand": "Lincoln Electric",
      "model": "Power MIG 350MP",
      "serialNumber": "LE350-2023-156",
      "status": "Available",
      "condition": "Excellent",
      "location": "Tool Storage",
      "operator": "Available",
      "purchaseDate": "2023-09-15",
      "lastMaintenance": "2024-03-01",
      "nextMaintenance": "2024-06-01",
      "workingHours": 420,
      "purchaseValue": 8500.0,
      "currentValue": 7800.0,
      "dailyRate": 85.0,
      "fuelConsumption": 0.0,
      "efficiency": 98,
      "utilisationRate": 45,
      "maintenanceCost": 320.0,
      "certificationExpiry": "2024-09-30",
      "image": "https://picsum.photos/300/200?random=5&keyword=welding"
    },
    {
      "id": "EQ-006",
      "name": "Bulldozer Komatsu D65",
      "type": "Heavy Machinery",
      "brand": "Komatsu",
      "model": "D65PX-18",
      "serialNumber": "KMT65-2021-078",
      "status": "Out of Service",
      "condition": "Poor",
      "location": "Repair Shop",
      "operator": "David Wilson",
      "purchaseDate": "2021-03-10",
      "lastMaintenance": "2024-02-15",
      "nextMaintenance": "2024-05-15",
      "workingHours": 4800,
      "purchaseValue": 420000.0,
      "currentValue": 320000.0,
      "dailyRate": 950.0,
      "fuelConsumption": 18.2,
      "efficiency": 75,
      "utilisationRate": 55,
      "maintenanceCost": 22000.0,
      "certificationExpiry": "2024-03-31",
      "image": "https://picsum.photos/300/200?random=6&keyword=bulldozer"
    }
  ];

  List<Map<String, dynamic>> get filteredEquipment {
    return equipment.where((item) {
      bool matchesSearch = item["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          item["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          item["brand"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || item["status"] == selectedStatus;
      bool matchesType = selectedType == "All" || item["type"] == selectedType;
      bool matchesLocation = selectedLocation == "All" || item["location"].toString().contains(selectedLocation);
      
      return matchesSearch && matchesStatus && matchesType && matchesLocation;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Available":
        return infoColor;
      case "Maintenance":
        return warningColor;
      case "Out of Service":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color getConditionColor(String condition) {
    switch (condition) {
      case "Excellent":
        return successColor;
      case "Good":
        return infoColor;
      case "Fair":
        return warningColor;
      case "Poor":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Equipment Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
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
              label: "Search equipment...",
              value: searchQuery,
              hint: "Search by name, ID, or brand",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Summary Cards
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Container(
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
                              Icons.precision_manufacturing,
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Total Equipment",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${equipment.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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
                              Icons.check_circle,
                              color: successColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Active",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${equipment.where((e) => e["status"] == "Active").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Container(
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
                              Icons.build,
                              color: warningColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Maintenance",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${equipment.where((e) => e["status"] == "Maintenance").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
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
                              Icons.attach_money,
                              color: infoColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Total Value",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "\$${((equipment.fold(0.0, (sum, item) => sum + (item["currentValue"] as double)) / 1000000)).toStringAsFixed(1)}M",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Equipment List
            ...filteredEquipment.map((item) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                      child: Image.network(
                        "${item["image"]}",
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${item["id"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                decoration: BoxDecoration(
                                  color: getStatusColor(item["status"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${item["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: getStatusColor(item["status"]),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${item["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${item["brand"]} ${item["model"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: getConditionColor(item["condition"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${item["condition"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: getConditionColor(item["condition"]),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${item["location"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Operator: ${item["operator"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Working Hours",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${item["workingHours"]}h",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
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
                                      "Efficiency",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${item["efficiency"]}%",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
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
                                      "Daily Rate",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${((item["dailyRate"] as double)).toStringAsFixed(0)}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: infoColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                size: 14,
                                color: warningColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Next Maintenance: ${item["nextMaintenance"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.build,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.edit,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter Equipment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QDropdownField(
                label: "Status",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "Active", "value": "Active"},
                  {"label": "Available", "value": "Available"},
                  {"label": "Maintenance", "value": "Maintenance"},
                  {"label": "Out of Service", "value": "Out of Service"},
                ],
                value: selectedStatus,
                onChanged: (value, label) {
                  selectedStatus = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Type",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "Heavy Machinery", "value": "Heavy Machinery"},
                  {"label": "Transport Vehicle", "value": "Transport Vehicle"},
                  {"label": "Support Equipment", "value": "Support Equipment"},
                  {"label": "Power Tools", "value": "Power Tools"},
                ],
                value: selectedType,
                onChanged: (value, label) {
                  selectedType = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Location",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "Site A", "value": "Site A"},
                  {"label": "Site B", "value": "Site B"},
                  {"label": "Workshop", "value": "Workshop"},
                  {"label": "Storage", "value": "Storage"},
                ],
                value: selectedLocation,
                onChanged: (value, label) {
                  selectedLocation = value;
                  setState(() {});
                },
              ),
            ],
          ),
          actions: [
            QButton(
              label: 'Clear',
              size: bs.sm,
              onPressed: () {
                selectedStatus = "All";
                selectedType = "All";
                selectedLocation = "All";
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
            QButton(
              label: 'Apply',
              size: bs.sm,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
