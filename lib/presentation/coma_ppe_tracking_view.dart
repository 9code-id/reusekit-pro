import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaPpeTrackingView extends StatefulWidget {
  const ComaPpeTrackingView({Key? key}) : super(key: key);

  @override
  State<ComaPpeTrackingView> createState() => _ComaPpeTrackingViewState();
}

class _ComaPpeTrackingViewState extends State<ComaPpeTrackingView> {
  String selectedStatus = "all";
  String selectedType = "all";
  String selectedCondition = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Status", "value": "all"},
    {"label": "Available", "value": "available"},
    {"label": "In Use", "value": "in_use"},
    {"label": "Maintenance", "value": "maintenance"},
    {"label": "Damaged", "value": "damaged"},
    {"label": "Expired", "value": "expired"},
  ];

  List<Map<String, dynamic>> typeFilters = [
    {"label": "All Types", "value": "all"},
    {"label": "Hard Hats", "value": "hard_hats"},
    {"label": "Safety Glasses", "value": "safety_glasses"},
    {"label": "Work Gloves", "value": "work_gloves"},
    {"label": "Safety Boots", "value": "safety_boots"},
    {"label": "High-Vis Vests", "value": "high_vis_vests"},
    {"label": "Respirators", "value": "respirators"},
    {"label": "Fall Protection", "value": "fall_protection"},
  ];

  List<Map<String, dynamic>> conditionFilters = [
    {"label": "All Conditions", "value": "all"},
    {"label": "Excellent", "value": "excellent"},
    {"label": "Good", "value": "good"},
    {"label": "Fair", "value": "fair"},
    {"label": "Poor", "value": "poor"},
    {"label": "Unsafe", "value": "unsafe"},
  ];

  List<Map<String, dynamic>> ppeInventory = [
    {
      "id": "PPE-001",
      "item_code": "HH-2024-001",
      "type": "hard_hats",
      "name": "MSA V-Gard Hard Hat",
      "description": "Class E electrical protection hard hat with 4-point suspension",
      "brand": "MSA Safety",
      "model": "V-Gard",
      "color": "White",
      "size": "Universal",
      "quantity_total": 50,
      "quantity_available": 32,
      "quantity_in_use": 15,
      "quantity_maintenance": 2,
      "quantity_damaged": 1,
      "status": "available",
      "condition": "good",
      "purchase_date": "2024-01-15",
      "expiry_date": "2029-01-15",
      "cost_per_unit": 25.99,
      "total_cost": 1299.50,
      "supplier": "Industrial Safety Supply Co.",
      "certification": "ANSI Z89.1 Type I Class E",
      "location": "Storage Room A - Shelf 1",
      "barcode": "123456789012",
      "last_inspection": "2024-06-10",
      "next_inspection": "2024-09-10",
      "assigned_workers": [
        {
          "worker_id": "EMP-001",
          "worker_name": "Michael Rodriguez",
          "assignment_date": "2024-06-15",
          "return_date": null,
          "condition_at_issue": "excellent"
        },
        {
          "worker_id": "EMP-002",
          "worker_name": "Sarah Thompson",
          "assignment_date": "2024-06-16",
          "return_date": null,
          "condition_at_issue": "good"
        }
      ],
      "maintenance_history": [
        {
          "date": "2024-05-20",
          "type": "cleaning",
          "description": "Deep cleaning and sanitization",
          "performed_by": "Maintenance Team",
          "cost": 0.00
        }
      ],
      "image_url": "https://picsum.photos/300/200?random=1&keyword=hardhat"
    },
    {
      "id": "PPE-002",
      "item_code": "SG-2024-002",
      "type": "safety_glasses",
      "name": "3M SecureFit Safety Glasses",
      "description": "Anti-fog safety glasses with wrap-around design",
      "brand": "3M",
      "model": "SecureFit SF400",
      "color": "Clear",
      "size": "One Size",
      "quantity_total": 100,
      "quantity_available": 78,
      "quantity_in_use": 20,
      "quantity_maintenance": 0,
      "quantity_damaged": 2,
      "status": "available",
      "condition": "excellent",
      "purchase_date": "2024-02-01",
      "expiry_date": null,
      "cost_per_unit": 8.50,
      "total_cost": 850.00,
      "supplier": "Safety Equipment Plus",
      "certification": "ANSI Z87.1+",
      "location": "Storage Room A - Shelf 2",
      "barcode": "123456789013",
      "last_inspection": "2024-06-01",
      "next_inspection": "2024-09-01",
      "assigned_workers": [
        {
          "worker_id": "EMP-003",
          "worker_name": "James Wilson",
          "assignment_date": "2024-06-12",
          "return_date": null,
          "condition_at_issue": "excellent"
        }
      ],
      "maintenance_history": [],
      "image_url": "https://picsum.photos/300/200?random=2&keyword=glasses"
    },
    {
      "id": "PPE-003",
      "item_code": "WG-2024-003",
      "type": "work_gloves",
      "name": "Cut-Resistant Work Gloves",
      "description": "ANSI A3 cut-resistant gloves with nitrile palm coating",
      "brand": "Mechanix Wear",
      "model": "Cut Protection Level 3",
      "color": "Yellow/Black",
      "size": "Large",
      "quantity_total": 75,
      "quantity_available": 45,
      "quantity_in_use": 25,
      "quantity_maintenance": 3,
      "quantity_damaged": 2,
      "status": "available",
      "condition": "good",
      "purchase_date": "2024-03-10",
      "expiry_date": "2026-03-10",
      "cost_per_unit": 12.75,
      "total_cost": 956.25,
      "supplier": "ProSafe Equipment",
      "certification": "ANSI A3 Cut Level",
      "location": "Storage Room B - Bin 1",
      "barcode": "123456789014",
      "last_inspection": "2024-06-05",
      "next_inspection": "2024-09-05",
      "assigned_workers": [
        {
          "worker_id": "EMP-004",
          "worker_name": "Maria Garcia",
          "assignment_date": "2024-06-18",
          "return_date": null,
          "condition_at_issue": "good"
        }
      ],
      "maintenance_history": [
        {
          "date": "2024-04-15",
          "type": "washing",
          "description": "Industrial washing and sanitization",
          "performed_by": "Cleaning Service",
          "cost": 2.50
        }
      ],
      "image_url": "https://picsum.photos/300/200?random=3&keyword=gloves"
    },
    {
      "id": "PPE-004",
      "item_code": "SB-2024-004",
      "type": "safety_boots",
      "name": "Steel Toe Work Boots",
      "description": "Waterproof steel toe boots with electrical hazard protection",
      "brand": "Timberland PRO",
      "model": "Pitboss",
      "color": "Brown",
      "size": "10",
      "quantity_total": 30,
      "quantity_available": 18,
      "quantity_in_use": 10,
      "quantity_maintenance": 1,
      "quantity_damaged": 1,
      "status": "available",
      "condition": "good",
      "purchase_date": "2024-01-20",
      "expiry_date": "2026-01-20",
      "cost_per_unit": 185.00,
      "total_cost": 5550.00,
      "supplier": "Industrial Footwear Supply",
      "certification": "ASTM F2413 Safety Toe, EH",
      "location": "Boot Storage Area",
      "barcode": "123456789015",
      "last_inspection": "2024-06-08",
      "next_inspection": "2024-09-08",
      "assigned_workers": [
        {
          "worker_id": "EMP-005",
          "worker_name": "David Chen",
          "assignment_date": "2024-06-20",
          "return_date": null,
          "condition_at_issue": "good"
        }
      ],
      "maintenance_history": [
        {
          "date": "2024-05-10",
          "type": "conditioning",
          "description": "Leather conditioning and waterproofing",
          "performed_by": "Equipment Team",
          "cost": 5.00
        }
      ],
      "image_url": "https://picsum.photos/300/200?random=4&keyword=boots"
    },
    {
      "id": "PPE-005",
      "item_code": "HV-2024-005",
      "type": "high_vis_vests",
      "name": "Class 2 High-Visibility Vest",
      "description": "ANSI Class 2 high-visibility safety vest with reflective stripes",
      "brand": "DEWALT",
      "model": "DSV521",
      "color": "Orange",
      "size": "XL",
      "quantity_total": 60,
      "quantity_available": 35,
      "quantity_in_use": 22,
      "quantity_maintenance": 2,
      "quantity_damaged": 1,
      "status": "available",
      "condition": "good",
      "purchase_date": "2024-02-15",
      "expiry_date": "2027-02-15",
      "cost_per_unit": 15.99,
      "total_cost": 959.40,
      "supplier": "Safety Gear Direct",
      "certification": "ANSI/ISEA 107 Class 2",
      "location": "Storage Room A - Rack 1",
      "barcode": "123456789016",
      "last_inspection": "2024-06-12",
      "next_inspection": "2024-09-12",
      "assigned_workers": [
        {
          "worker_id": "EMP-006",
          "worker_name": "Amanda Foster",
          "assignment_date": "2024-06-14",
          "return_date": null,
          "condition_at_issue": "excellent"
        }
      ],
      "maintenance_history": [],
      "image_url": "https://picsum.photos/300/200?random=5&keyword=vest"
    },
    {
      "id": "PPE-006",
      "item_code": "RS-2024-006",
      "type": "respirators",
      "name": "N95 Filtering Facepiece Respirator",
      "description": "NIOSH-approved N95 respirator for dust and particulate protection",
      "brand": "3M",
      "model": "8210",
      "color": "White",
      "size": "Regular",
      "quantity_total": 200,
      "quantity_available": 150,
      "quantity_in_use": 45,
      "quantity_maintenance": 0,
      "quantity_damaged": 5,
      "status": "available",
      "condition": "excellent",
      "purchase_date": "2024-04-01",
      "expiry_date": "2025-04-01",
      "cost_per_unit": 2.25,
      "total_cost": 450.00,
      "supplier": "Medical Safety Supply",
      "certification": "NIOSH N95",
      "location": "Storage Room C - Cabinet 1",
      "barcode": "123456789017",
      "last_inspection": "2024-06-15",
      "next_inspection": "2024-07-15",
      "assigned_workers": [],
      "maintenance_history": [],
      "image_url": "https://picsum.photos/300/200?random=6&keyword=mask"
    },
    {
      "id": "PPE-007",
      "item_code": "FP-2024-007",
      "type": "fall_protection",
      "name": "Full Body Safety Harness",
      "description": "5-point full body harness with dorsal and front D-rings",
      "brand": "Miller by Honeywell",
      "model": "DuraFlex",
      "color": "Black/Yellow",
      "size": "Medium",
      "quantity_total": 25,
      "quantity_available": 15,
      "quantity_in_use": 8,
      "quantity_maintenance": 1,
      "quantity_damaged": 1,
      "status": "maintenance",
      "condition": "fair",
      "purchase_date": "2024-01-10",
      "expiry_date": "2029-01-10",
      "cost_per_unit": 125.00,
      "total_cost": 3125.00,
      "supplier": "Height Safety Solutions",
      "certification": "ANSI Z359.11",
      "location": "Fall Protection Storage",
      "barcode": "123456789018",
      "last_inspection": "2024-06-01",
      "next_inspection": "2024-09-01",
      "assigned_workers": [
        {
          "worker_id": "EMP-007",
          "worker_name": "Kevin Johnson",
          "assignment_date": "2024-06-10",
          "return_date": null,
          "condition_at_issue": "good"
        }
      ],
      "maintenance_history": [
        {
          "date": "2024-06-18",
          "type": "inspection",
          "description": "Annual inspection and recertification",
          "performed_by": "Certified Inspector",
          "cost": 25.00
        }
      ],
      "image_url": "https://picsum.photos/300/200?random=7&keyword=harness"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PPE Tracking"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _addPpeItem(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.qr_code_scanner,
            size: bs.sm,
            onPressed: () => _scanBarcode(),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  _buildPpeOverview(),
                  _buildFilters(),
                  _buildInventoryMetrics(),
                  _buildLowStockAlerts(),
                  _buildPpeList(),
                ],
              ),
            ),
    );
  }

  Widget _buildPpeOverview() {
    int totalItems = ppeInventory.fold(0, (sum, item) => sum + (item["quantity_total"] as int));
    int availableItems = ppeInventory.fold(0, (sum, item) => sum + (item["quantity_available"] as int));
    int inUseItems = ppeInventory.fold(0, (sum, item) => sum + (item["quantity_in_use"] as int));
    int maintenanceItems = ppeInventory.fold(0, (sum, item) => sum + (item["quantity_maintenance"] as int));

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(Icons.security, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "PPE Inventory Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildOverviewCard("Total Items", "$totalItems", Icons.inventory, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Available", "$availableItems", Icons.check_circle, successColor),
              SizedBox(width: spSm),
              _buildOverviewCard("In Use", "$inUseItems", Icons.assignment, warningColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Maintenance", "$maintenanceItems", Icons.build, dangerColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 18),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.search, color: disabledBoldColor, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Search PPE items...",
                  value: searchQuery,
                  hint: "Search by name, code, or brand",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.qr_code,
                size: bs.sm,
                onPressed: () => _scanSearch(),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusFilters,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QDropdownField(
                  label: "Type",
                  items: typeFilters,
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QDropdownField(
                  label: "Condition",
                  items: conditionFilters,
                  value: selectedCondition,
                  onChanged: (value, label) {
                    selectedCondition = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryMetrics() {
    double totalValue = ppeInventory.fold(0.0, (sum, item) => sum + (item["total_cost"] as double));
    int typesCount = typeFilters.length - 1; // Excluding "all"
    double utilizationRate = ppeInventory.fold(0.0, (sum, item) => 
        sum + ((item["quantity_in_use"] as int) / (item["quantity_total"] as int))) / ppeInventory.length * 100;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: successColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Inventory Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
          Row(
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
                    children: [
                      Icon(Icons.attach_money, color: successColor, size: 20),
                      SizedBox(height: spXs),
                      Text(
                        "\$${totalValue.currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Total Value",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.category, color: infoColor, size: 20),
                      SizedBox(height: spXs),
                      Text(
                        "$typesCount",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "PPE Types",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.trending_up, color: warningColor, size: 20),
                      SizedBox(height: spXs),
                      Text(
                        "${utilizationRate.toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Utilization",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLowStockAlerts() {
    List<Map<String, dynamic>> lowStockItems = ppeInventory
        .where((item) => (item["quantity_available"] as int) < ((item["quantity_total"] as int) * 0.2))
        .toList();

    if (lowStockItems.isEmpty) {
      return SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: dangerColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: dangerColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.warning, color: dangerColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Low Stock Alerts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),
            ],
          ),
          ...lowStockItems.map((item) => Container(
            padding: EdgeInsets.all(spSm),
            margin: EdgeInsets.only(bottom: spXs),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: dangerColor.withAlpha(30)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "${item["name"]} (${item["item_code"]})",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                    ),
                  ),
                ),
                Text(
                  "${item["quantity_available"]}/${item["quantity_total"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: dangerColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildPpeList() {
    List<Map<String, dynamic>> filteredItems = _getFilteredItems();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "PPE Inventory (${filteredItems.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              icon: Icons.sort,
              size: bs.sm,
              onPressed: () => _showSortOptions(),
            ),
          ],
        ),
        ...filteredItems.map((item) => _buildPpeCard(item)),
      ],
    );
  }

  Widget _buildPpeCard(Map<String, dynamic> item) {
    Color statusColor = _getStatusColor(item["status"]);
    Color conditionColor = _getConditionColor(item["condition"]);
    double stockPercentage = (item["quantity_available"] as int) / (item["quantity_total"] as int);

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: statusColor,
            width: 4,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${item["image_url"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Code: ${item["item_code"]} | ${item["brand"]} ${item["model"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${item["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: statusColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: conditionColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${item["condition"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: conditionColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Text(
                      "Inventory Status",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${item["quantity_available"]}/${item["quantity_total"]} available",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: stockPercentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: stockPercentage > 0.5 ? successColor : 
                               stockPercentage > 0.2 ? warningColor : dangerColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "In Use: ${item["quantity_in_use"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text(
                      "Maintenance: ${item["quantity_maintenance"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text(
                      "Damaged: ${item["quantity_damaged"]}",
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
          Row(
            children: [
              Icon(Icons.location_on, color: disabledBoldColor, size: 14),
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
              Icon(Icons.attach_money, color: successColor, size: 14),
              SizedBox(width: spXs),
              Text(
                "\$${(item["cost_per_unit"] as double).currency}/unit",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          if (item["expiry_date"] != null)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.schedule, color: warningColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "Expires: ${item["expiry_date"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Next Inspection: ${item["next_inspection"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                    ),
                  ),
                ],
              ),
            ),
          if ((item["assigned_workers"] as List).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "Currently Assigned to:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: infoColor,
                    ),
                  ),
                  ...(item["assigned_workers"] as List).take(2).map((worker) => Row(
                    children: [
                      Icon(Icons.person, color: infoColor, size: 12),
                      SizedBox(width: spXs),
                      Text(
                        "${worker["worker_name"]} (${worker["assignment_date"]})",
                        style: TextStyle(
                          fontSize: 11,
                          color: infoColor,
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Certification: ${item["certification"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () => _viewItemDetails(item["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editItem(item["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showItemOptions(item),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredItems() {
    List<Map<String, dynamic>> filtered = ppeInventory;

    if (selectedStatus != "all") {
      filtered = filtered.where((item) => item["status"] == selectedStatus).toList();
    }

    if (selectedType != "all") {
      filtered = filtered.where((item) => item["type"] == selectedType).toList();
    }

    if (selectedCondition != "all") {
      filtered = filtered.where((item) => item["condition"] == selectedCondition).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((item) =>
          item["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          item["item_code"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          item["brand"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'available':
        return successColor;
      case 'in_use':
        return infoColor;
      case 'maintenance':
        return warningColor;
      case 'damaged':
        return dangerColor;
      case 'expired':
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
      case 'unsafe':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _addPpeItem() {
    ss("Add new PPE item");
  }

  void _scanBarcode() {
    ss("Scan PPE barcode");
  }

  void _scanSearch() {
    ss("Scan to search PPE");
  }

  void _showSortOptions() {
    ss("PPE sort options");
  }

  void _viewItemDetails(String itemId) {
    ss("Viewing PPE item details $itemId");
  }

  void _editItem(String itemId) {
    ss("Editing PPE item $itemId");
  }

  void _showItemOptions(Map<String, dynamic> item) {
    ss("PPE item options for ${item["name"]}");
  }
}
