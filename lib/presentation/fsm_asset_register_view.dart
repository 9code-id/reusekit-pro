import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmAssetRegisterView extends StatefulWidget {
  const FsmAssetRegisterView({super.key});

  @override
  State<FsmAssetRegisterView> createState() => _FsmAssetRegisterViewState();
}

class _FsmAssetRegisterViewState extends State<FsmAssetRegisterView> {
  String searchQuery = "";
  String selectedCategory = "All Categories";
  String selectedStatus = "All Status";
  String selectedLocation = "All Locations";
  int currentTab = 0;

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "All Categories"},
    {"label": "Equipment", "value": "Equipment"},
    {"label": "Vehicles", "value": "Vehicles"},
    {"label": "Tools", "value": "Tools"},
    {"label": "IT Assets", "value": "IT Assets"},
    {"label": "Furniture", "value": "Furniture"},
    {"label": "Real Estate", "value": "Real Estate"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All Status"},
    {"label": "Active", "value": "Active"},
    {"label": "Depreciated", "value": "Depreciated"},
    {"label": "Disposed", "value": "Disposed"},
    {"label": "Under Maintenance", "value": "Under Maintenance"},
    {"label": "Lost/Stolen", "value": "Lost/Stolen"},
  ];

  List<Map<String, dynamic>> locations = [
    {"label": "All Locations", "value": "All Locations"},
    {"label": "Headquarters", "value": "Headquarters"},
    {"label": "Warehouse A", "value": "Warehouse A"},
    {"label": "Service Center 1", "value": "Service Center 1"},
    {"label": "Service Center 2", "value": "Service Center 2"},
    {"label": "Mobile Unit", "value": "Mobile Unit"},
  ];

  List<Map<String, dynamic>> assets = [
    {
      "id": "AST001",
      "name": "Industrial Compressor Unit",
      "category": "Equipment",
      "description": "High-capacity air compressor for workshop operations",
      "serialNumber": "ICU-2023-001",
      "model": "PowerComp PC-500",
      "manufacturer": "PowerTech Industries",
      "purchaseDate": DateTime(2023, 3, 15),
      "purchasePrice": 15500.00,
      "currentValue": 12400.00,
      "depreciationRate": 20.0,
      "condition": "Good",
      "status": "Active",
      "location": "Warehouse A",
      "assignedTo": "Workshop Team",
      "warrantyExpiry": DateTime(2025, 3, 15),
      "lastInspection": DateTime(2024, 10, 20),
      "nextInspection": DateTime(2025, 4, 20),
      "maintenanceCost": 850.00,
      "insuranceValue": 14000.00,
      "supplier": "TechEquip Solutions",
      "tags": ["Critical", "High Value"],
    },
    {
      "id": "AST002",
      "name": "Ford Transit Service Van",
      "category": "Vehicles",
      "description": "Service vehicle for field operations",
      "serialNumber": "1FTBW2CM8HKA12345",
      "model": "Transit-350 HD",
      "manufacturer": "Ford Motor Company",
      "purchaseDate": DateTime(2021, 8, 10),
      "purchasePrice": 32000.00,
      "currentValue": 19200.00,
      "depreciationRate": 15.0,
      "condition": "Fair",
      "status": "Active",
      "location": "Service Center 1",
      "assignedTo": "Field Service Team A",
      "warrantyExpiry": DateTime(2024, 8, 10),
      "lastInspection": DateTime(2024, 11, 5),
      "nextInspection": DateTime(2025, 5, 5),
      "maintenanceCost": 2100.00,
      "insuranceValue": 22000.00,
      "supplier": "Fleet Solutions Ltd",
      "tags": ["Vehicle", "Fleet"],
    },
    {
      "id": "AST003",
      "name": "Digital Oscilloscope",
      "category": "Equipment",
      "description": "Advanced digital oscilloscope for electronic testing",
      "serialNumber": "DO-2024-078",
      "model": "TekScope TS-4000",
      "manufacturer": "TekTronics",
      "purchaseDate": DateTime(2024, 2, 28),
      "purchasePrice": 4200.00,
      "currentValue": 3780.00,
      "depreciationRate": 10.0,
      "condition": "Excellent",
      "status": "Active",
      "location": "Service Center 2",
      "assignedTo": "Electronics Team",
      "warrantyExpiry": DateTime(2027, 2, 28),
      "lastInspection": DateTime(2024, 11, 15),
      "nextInspection": DateTime(2025, 5, 15),
      "maintenanceCost": 120.00,
      "insuranceValue": 4500.00,
      "supplier": "Scientific Instruments Inc",
      "tags": ["Precision", "Calibrated"],
    },
    {
      "id": "AST004",
      "name": "Laptop Computer Dell Precision",
      "category": "IT Assets",
      "description": "High-performance laptop for CAD and engineering work",
      "serialNumber": "DLP-2023-156",
      "model": "Precision 5570",
      "manufacturer": "Dell Technologies",
      "purchaseDate": DateTime(2023, 6, 12),
      "purchasePrice": 2800.00,
      "currentValue": 1680.00,
      "depreciationRate": 20.0,
      "condition": "Good",
      "status": "Active",
      "location": "Headquarters",
      "assignedTo": "Engineering Department",
      "warrantyExpiry": DateTime(2026, 6, 12),
      "lastInspection": DateTime(2024, 9, 30),
      "nextInspection": DateTime(2025, 3, 30),
      "maintenanceCost": 0.00,
      "insuranceValue": 2000.00,
      "supplier": "IT Solutions Pro",
      "tags": ["IT", "Portable"],
    },
    {
      "id": "AST005",
      "name": "Hydraulic Lift Table",
      "category": "Equipment",
      "description": "Heavy-duty hydraulic lift for workshop operations",
      "serialNumber": "HLT-2020-089",
      "model": "LiftMaster HM-2000",
      "manufacturer": "Industrial Lifts Co",
      "purchaseDate": DateTime(2020, 11, 20),
      "purchasePrice": 8500.00,
      "currentValue": 4250.00,
      "depreciationRate": 15.0,
      "condition": "Fair",
      "status": "Under Maintenance",
      "location": "Warehouse A",
      "assignedTo": "Maintenance Team",
      "warrantyExpiry": DateTime(2023, 11, 20),
      "lastInspection": DateTime(2024, 8, 14),
      "nextInspection": DateTime(2025, 2, 14),
      "maintenanceCost": 1200.00,
      "insuranceValue": 6000.00,
      "supplier": "Heavy Equipment Direct",
      "tags": ["Heavy Duty", "Safety Critical"],
    },
    {
      "id": "AST006",
      "name": "Office Desk Set",
      "category": "Furniture",
      "description": "Ergonomic office desk with storage cabinet",
      "serialNumber": "ODS-2022-045",
      "model": "ErgoDesk Pro 180",
      "manufacturer": "Office Furniture Plus",
      "purchaseDate": DateTime(2022, 4, 8),
      "purchasePrice": 650.00,
      "currentValue": 390.00,
      "depreciationRate": 10.0,
      "condition": "Good",
      "status": "Active",
      "location": "Headquarters",
      "assignedTo": "Administrative Staff",
      "warrantyExpiry": DateTime(2025, 4, 8),
      "lastInspection": DateTime(2024, 6, 10),
      "nextInspection": DateTime(2025, 6, 10),
      "maintenanceCost": 0.00,
      "insuranceValue": 500.00,
      "supplier": "Office Solutions Inc",
      "tags": ["Furniture", "Ergonomic"],
    },
  ];

  List<Map<String, dynamic>> depreciationRecords = [
    {
      "assetId": "AST001",
      "assetName": "Industrial Compressor Unit",
      "year": 2024,
      "openingValue": 13640.00,
      "depreciationAmount": 2728.00,
      "closingValue": 10912.00,
      "method": "Straight Line",
      "rate": 20.0,
    },
    {
      "assetId": "AST002",
      "assetName": "Ford Transit Service Van",
      "year": 2024,
      "openingValue": 22080.00,
      "depreciationAmount": 3312.00,
      "closingValue": 18768.00,
      "method": "Reducing Balance",
      "rate": 15.0,
    },
    {
      "assetId": "AST003",
      "assetName": "Digital Oscilloscope",
      "year": 2024,
      "openingValue": 4200.00,
      "depreciationAmount": 420.00,
      "closingValue": 3780.00,
      "method": "Straight Line",
      "rate": 10.0,
    },
    {
      "assetId": "AST004",
      "assetName": "Laptop Computer Dell Precision",
      "year": 2024,
      "openingValue": 2240.00,
      "depreciationAmount": 448.00,
      "closingValue": 1792.00,
      "method": "Straight Line",
      "rate": 20.0,
    },
    {
      "assetId": "AST005",
      "assetName": "Hydraulic Lift Table",
      "year": 2024,
      "openingValue": 5100.00,
      "depreciationAmount": 765.00,
      "closingValue": 4335.00,
      "method": "Reducing Balance",
      "rate": 15.0,
    },
  ];

  List<Map<String, dynamic>> get filteredAssets {
    return assets.where((asset) {
      bool matchesSearch = asset["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          asset["id"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          asset["serialNumber"].toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesCategory = selectedCategory == "All Categories" || asset["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "All Status" || asset["status"] == selectedStatus;
      bool matchesLocation = selectedLocation == "All Locations" || asset["location"] == selectedLocation;

      return matchesSearch && matchesCategory && matchesStatus && matchesLocation;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Depreciated":
        return warningColor;
      case "Disposed":
        return disabledColor;
      case "Under Maintenance":
        return infoColor;
      case "Lost/Stolen":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getConditionColor(String condition) {
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
    int totalAssets = assets.length;
    int activeAssets = assets.where((a) => a["status"] == "Active").length;
    double totalPurchaseValue = assets.fold(0.0, (sum, item) => sum + (item["purchasePrice"] as double));
    double totalCurrentValue = assets.fold(0.0, (sum, item) => sum + (item["currentValue"] as double));
    double totalDepreciation = totalPurchaseValue - totalCurrentValue;
    double totalMaintenanceCost = assets.fold(0.0, (sum, item) => sum + (item["maintenanceCost"] as double));

    return QTabBar(
      title: "Asset Register",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Assets", icon: Icon(Icons.inventory_2)),
        Tab(text: "Depreciation", icon: Icon(Icons.trending_down)),
      ],
      tabChildren: [
        // Assets Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Summary Cards
              ResponsiveGridView(
                padding: EdgeInsets.zero,
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
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.inventory_2,
                              color: primaryColor,
                              size: 24,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Total Assets",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${totalAssets}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${activeAssets} active assets",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.attach_money,
                              color: successColor,
                              size: 24,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Purchase Value",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "\$${totalPurchaseValue.currency}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Original cost",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.account_balance,
                              color: infoColor,
                              size: 24,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Current Value",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "\$${totalCurrentValue.currency}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "After depreciation",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.trending_down,
                              color: warningColor,
                              size: 24,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Depreciation",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "\$${totalDepreciation.currency}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "${((totalDepreciation / totalPurchaseValue) * 100).toStringAsFixed(1)}% of original",
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
                  children: [
                    QTextField(
                      label: "Search Assets",
                      hint: "Search by name, ID, or serial number",
                      value: searchQuery,
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      spacing: spSm,
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
                      label: "Location",
                      items: locations,
                      value: selectedLocation,
                      onChanged: (value, label) {
                        selectedLocation = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Asset List
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
                    Row(
                      children: [
                        Text(
                          "Asset Register",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Add Asset",
                          icon: Icons.add,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Column(
                      spacing: spXs,
                      children: filteredAssets.map((asset) {
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border(
                              left: BorderSide(
                                width: 4,
                                color: _getStatusColor("${asset["status"]}"),
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: spXs / 2,
                                      children: [
                                        Text(
                                          "${asset["name"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "ID: ${asset["id"]} | Serial: ${asset["serialNumber"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "${asset["description"]}",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXs / 2),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor("${asset["status"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${asset["status"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: _getStatusColor("${asset["status"]}"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: spXs / 2,
                                      children: [
                                        Text(
                                          "Category: ${asset["category"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "Location: ${asset["location"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "Assigned to: ${asset["assignedTo"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "Model: ${asset["model"]} | ${asset["manufacturer"]}",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    spacing: spXs / 2,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXs / 2),
                                        decoration: BoxDecoration(
                                          color: _getConditionColor("${asset["condition"]}").withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${asset["condition"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: _getConditionColor("${asset["condition"]}"),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Purchase: \$${(asset["purchasePrice"] as double).currency}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "Current: \$${(asset["currentValue"] as double).currency}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "Depreciation: ${asset["depreciationRate"]}%",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: warningColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      spacing: spSm,
                                      children: [
                                        if ((asset["tags"] as List).isNotEmpty)
                                          ...(asset["tags"] as List).map((tag) {
                                            return Container(
                                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXs / 2),
                                              decoration: BoxDecoration(
                                                color: infoColor.withAlpha(20),
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Text(
                                                "${tag}",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  color: infoColor,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    spacing: spXs,
                                    children: [
                                      QButton(
                                        icon: Icons.edit,
                                        size: bs.sm,
                                        onPressed: () {},
                                      ),
                                      QButton(
                                        icon: Icons.qr_code,
                                        size: bs.sm,
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.only(top: spXs),
                                child: Row(
                                  children: [
                                    Text(
                                      "Purchased: ${(asset["purchaseDate"] as DateTime).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "Next Inspection: ${(asset["nextInspection"] as DateTime).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: warningColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Depreciation Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Depreciation Summary
              ResponsiveGridView(
                padding: EdgeInsets.zero,
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
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.trending_down,
                              color: warningColor,
                              size: 24,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Annual Depreciation",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "\$${depreciationRecords.fold(0.0, (sum, item) => sum + (item["depreciationAmount"] as double)).currency}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Year 2024",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.account_balance,
                              color: infoColor,
                              size: 24,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Book Value",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "\$${depreciationRecords.fold(0.0, (sum, item) => sum + (item["closingValue"] as double)).currency}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Closing balance",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.build,
                              color: dangerColor,
                              size: 24,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Maintenance Cost",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "\$${totalMaintenanceCost.currency}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Total to date",
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

              // Depreciation Schedule
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
                    Row(
                      children: [
                        Text(
                          "Depreciation Schedule 2024",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Export",
                          icon: Icons.download,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Column(
                      spacing: spXs,
                      children: depreciationRecords.map((record) {
                        double depreciationPercentage = ((record["depreciationAmount"] as double) / (record["openingValue"] as double)) * 100;
                        
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border(
                              left: BorderSide(
                                width: 4,
                                color: warningColor,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: spXs / 2,
                                      children: [
                                        Text(
                                          "${record["assetName"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "Asset ID: ${record["assetId"]} | Method: ${record["method"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXs / 2),
                                    decoration: BoxDecoration(
                                      color: warningColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${(record["rate"] as double).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: warningColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: spXs / 2,
                                      children: [
                                        Text(
                                          "Opening Value: \$${(record["openingValue"] as double).currency}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "Depreciation: \$${(record["depreciationAmount"] as double).currency}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: warningColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "Closing Value: \$${(record["closingValue"] as double).currency}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    spacing: spXs / 2,
                                    children: [
                                      Text(
                                        "Year ${record["year"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${depreciationPercentage.toStringAsFixed(1)}% of value",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: spXs),
                                height: 6,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withAlpha(50),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: depreciationPercentage / 100,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: warningColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
