import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaAssetManagementView extends StatefulWidget {
  const HhaAssetManagementView({super.key});

  @override
  State<HhaAssetManagementView> createState() => _HhaAssetManagementViewState();
}

class _HhaAssetManagementViewState extends State<HhaAssetManagementView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedStatus = "All";
  String selectedDepartment = "All";

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Medical Equipment", "value": "medical"},
    {"label": "IT Equipment", "value": "it"},
    {"label": "Furniture", "value": "furniture"},
    {"label": "Vehicles", "value": "vehicles"},
    {"label": "Building Assets", "value": "building"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "active"},
    {"label": "Under Maintenance", "value": "maintenance"},
    {"label": "Out of Service", "value": "out_of_service"},
    {"label": "Disposed", "value": "disposed"},
  ];

  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All", "value": "All"},
    {"label": "Cardiology", "value": "cardiology"},
    {"label": "Emergency", "value": "emergency"},
    {"label": "Surgery", "value": "surgery"},
    {"label": "Radiology", "value": "radiology"},
    {"label": "IT Department", "value": "it"},
  ];

  List<Map<String, dynamic>> assets = [
    {
      "id": "AST001",
      "name": "MRI Machine",
      "category": "Medical Equipment",
      "department": "Radiology",
      "status": "Active",
      "location": "Room 204",
      "serialNumber": "MRI-2023-001",
      "purchaseDate": "2023-01-15",
      "warrantyExpiry": "2026-01-15",
      "cost": 850000.0,
      "currentValue": 680000.0,
      "condition": "Excellent",
      "lastMaintenance": "2024-11-15",
      "nextMaintenance": "2025-02-15",
      "vendor": "Siemens Healthcare",
      "specifications": "3T MRI Scanner with Advanced Imaging",
      "utilizationRate": 85,
      "maintenanceCost": 25000.0,
    },
    {
      "id": "AST002", 
      "name": "Patient Monitor System",
      "category": "Medical Equipment",
      "department": "ICU",
      "status": "Active",
      "location": "ICU Ward A",
      "serialNumber": "PM-2023-012",
      "purchaseDate": "2023-03-20",
      "warrantyExpiry": "2025-03-20",
      "cost": 12000.0,
      "currentValue": 9600.0,
      "condition": "Good",
      "lastMaintenance": "2024-12-01",
      "nextMaintenance": "2025-03-01",
      "vendor": "Philips Healthcare",
      "specifications": "Multi-parameter monitoring with telemetry",
      "utilizationRate": 95,
      "maintenanceCost": 800.0,
    },
    {
      "id": "AST003",
      "name": "Hospital Server Rack",
      "category": "IT Equipment", 
      "department": "IT Department",
      "status": "Active",
      "location": "Data Center",
      "serialNumber": "SRV-2022-005",
      "purchaseDate": "2022-08-10",
      "warrantyExpiry": "2025-08-10",
      "cost": 45000.0,
      "currentValue": 27000.0,
      "condition": "Good",
      "lastMaintenance": "2024-12-10",
      "nextMaintenance": "2025-01-10",
      "vendor": "Dell Technologies",
      "specifications": "42U Rack with redundant power supply",
      "utilizationRate": 78,
      "maintenanceCost": 2500.0,
    },
    {
      "id": "AST004",
      "name": "Surgical Table",
      "category": "Medical Equipment",
      "department": "Surgery",
      "status": "Under Maintenance",
      "location": "OR-3",
      "serialNumber": "ST-2021-008",
      "purchaseDate": "2021-06-12",
      "warrantyExpiry": "2024-06-12",
      "cost": 28000.0,
      "currentValue": 16800.0,
      "condition": "Fair",
      "lastMaintenance": "2024-12-12",
      "nextMaintenance": "2025-01-20",
      "vendor": "Steris Corporation",
      "specifications": "Electric height adjustment with C-arm compatibility",
      "utilizationRate": 60,
      "maintenanceCost": 1200.0,
    },
    {
      "id": "AST005",
      "name": "Ambulance Vehicle",
      "category": "Vehicles",
      "department": "Emergency",
      "status": "Active",
      "location": "Emergency Bay",
      "serialNumber": "AMB-2023-002",
      "purchaseDate": "2023-09-05",
      "warrantyExpiry": "2026-09-05",
      "cost": 150000.0,
      "currentValue": 135000.0,
      "condition": "Excellent",
      "lastMaintenance": "2024-11-20",
      "nextMaintenance": "2025-02-20",
      "vendor": "Ford Emergency Vehicles",
      "specifications": "Type II Ambulance with advanced life support equipment",
      "utilizationRate": 72,
      "maintenanceCost": 3500.0,
    },
    {
      "id": "AST006",
      "name": "Executive Office Desk",
      "category": "Furniture",
      "department": "Administration",
      "status": "Active",
      "location": "Admin Office 101",
      "serialNumber": "FUR-2023-045",
      "purchaseDate": "2023-04-18",
      "warrantyExpiry": "2028-04-18",
      "cost": 2500.0,
      "currentValue": 2000.0,
      "condition": "Excellent",
      "lastMaintenance": "2024-10-01",
      "nextMaintenance": "2025-04-01",
      "vendor": "Steelcase Inc.",
      "specifications": "Mahogany finish with integrated cable management",
      "utilizationRate": 100,
      "maintenanceCost": 50.0,
    },
  ];

  List<Map<String, dynamic>> get filteredAssets {
    return assets.where((asset) {
      bool matchesSearch = asset["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          asset["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          asset["serialNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || asset["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "All" || asset["status"] == selectedStatus;
      bool matchesDepartment = selectedDepartment == "All" || asset["department"] == selectedDepartment;
      
      return matchesSearch && matchesCategory && matchesStatus && matchesDepartment;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return successColor;
      case 'under maintenance':
        return warningColor;
      case 'out of service':
        return dangerColor;
      case 'disposed':
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getConditionColor(String condition) {
    switch (condition.toLowerCase()) {
      case 'excellent':
        return successColor;
      case 'good':
        return infoColor;
      case 'fair':
        return warningColor;
      case 'poor':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Asset Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add asset
            },
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              ss("Asset report exported successfully");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
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
                          label: "Search Assets",
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
                          label: "Category",
                          items: categories,
                          value: selectedCategory,
                          onChanged: (value, label) {
                            selectedCategory = value;
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
                    label: "Department",
                    items: departmentOptions,
                    value: selectedDepartment,
                    onChanged: (value, label) {
                      selectedDepartment = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Asset Summary Cards
            ResponsiveGridView(
              minItemWidth: 200,
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
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.inventory,
                              color: primaryColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Total Assets",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${assets.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
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
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Active Assets",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${assets.where((a) => a["status"] == "Active").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
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
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.build,
                              color: warningColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Under Maintenance",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${assets.where((a) => a["status"] == "Under Maintenance").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
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
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.attach_money,
                              color: infoColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Total Value",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "\$${((assets.fold<double>(0.0, (sum, asset) => sum + (asset["currentValue"] as num).toDouble())) / 1000).toStringAsFixed(0)}K",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Assets List
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
                          "Asset Inventory",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${filteredAssets.length} assets found",
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
                    itemCount: filteredAssets.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final asset = filteredAssets[index];
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
                                            "${asset["name"]}",
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
                                              color: _getStatusColor("${asset["status"]}").withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${asset["status"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: _getStatusColor("${asset["status"]}"),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Row(
                                        children: [
                                          Text(
                                            "ID: ${asset["id"]}",
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
                                            "${asset["department"]}",
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
                                    Text(
                                      "\$${((asset["currentValue"] as num).toDouble()).currency}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getConditionColor("${asset["condition"]}").withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${asset["condition"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: _getConditionColor("${asset["condition"]}"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Location",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "${asset["location"]}",
                                        style: TextStyle(
                                          fontSize: 12,
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
                                        "Utilization",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "${asset["utilizationRate"]}%",
                                        style: TextStyle(
                                          fontSize: 12,
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
                                        "Next Maintenance",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "${asset["nextMaintenance"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                QButton(
                                  icon: Icons.more_vert,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Show asset options
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
}
