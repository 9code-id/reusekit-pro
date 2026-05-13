import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaMaterialCostView extends StatefulWidget {
  const ComaMaterialCostView({super.key});

  @override
  State<ComaMaterialCostView> createState() => _ComaMaterialCostViewState();
}

class _ComaMaterialCostViewState extends State<ComaMaterialCostView> {
  String searchQuery = "";
  String selectedPeriod = "This Month";
  String selectedProject = "All";
  String selectedCategory = "All";
  DateTime? fromDate;
  DateTime? toDate;
  int currentTab = 0;

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Custom Range", "value": "Custom Range"},
  ];

  List<Map<String, dynamic>> projectOptions = [
    {"label": "All", "value": "All"},
    {"label": "Foundation Project Phase 2", "value": "Foundation Project Phase 2"},
    {"label": "Building Construction A", "value": "Building Construction A"},
    {"label": "Road Infrastructure", "value": "Road Infrastructure"},
    {"label": "Residential Complex", "value": "Residential Complex"},
    {"label": "Commercial Plaza", "value": "Commercial Plaza"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Cement", "value": "Cement"},
    {"label": "Steel", "value": "Steel"},
    {"label": "Aggregate", "value": "Aggregate"},
    {"label": "Bricks", "value": "Bricks"},
    {"label": "Timber", "value": "Timber"},
    {"label": "Paint", "value": "Paint"},
  ];

  List<Map<String, dynamic>> costRecords = [
    {
      "id": "CST001",
      "date": "2024-06-18",
      "materialId": "MAT001",
      "materialName": "Portland Cement",
      "category": "Cement",
      "project": "Foundation Project Phase 2",
      "supplier": "BuildMart Supply",
      "quantity": 200,
      "unit": "bags",
      "unitPrice": 12.50,
      "totalCost": 2500.00,
      "budgetAllocated": 3000.00,
      "varianceAmount": -500.00,
      "variancePercentage": -16.7,
      "orderType": "Regular Purchase",
      "paymentStatus": "Paid",
      "deliveryDate": "2024-06-18",
      "wastePercentage": 3.2,
      "wasteCost": 80.00,
      "actualUsage": 193.6,
      "efficiency": 96.8,
      "notes": "Standard cement procurement for foundation work",
      "image": "https://picsum.photos/120/120?random=71&keyword=cement"
    },
    {
      "id": "CST002",
      "date": "2024-06-17",
      "materialId": "MAT002",
      "materialName": "Steel Reinforcement Bar",
      "category": "Steel",
      "project": "Building Construction A",
      "supplier": "Metal Works Ltd",
      "quantity": 5,
      "unit": "tons",
      "unitPrice": 650.00,
      "totalCost": 3250.00,
      "budgetAllocated": 3000.00,
      "varianceAmount": 250.00,
      "variancePercentage": 8.3,
      "orderType": "Urgent Purchase",
      "paymentStatus": "Pending",
      "deliveryDate": "2024-06-17",
      "wastePercentage": 1.5,
      "wasteCost": 48.75,
      "actualUsage": 4.925,
      "efficiency": 98.5,
      "notes": "Premium grade steel for structural reinforcement",
      "image": "https://picsum.photos/120/120?random=72&keyword=steel"
    },
    {
      "id": "CST003",
      "date": "2024-06-16",
      "materialId": "MAT003",
      "materialName": "River Sand",
      "category": "Aggregate",
      "project": "Road Infrastructure",
      "supplier": "Sand & Gravel Co",
      "quantity": 30,
      "unit": "cubic meters",
      "unitPrice": 25.00,
      "totalCost": 750.00,
      "budgetAllocated": 800.00,
      "varianceAmount": -50.00,
      "variancePercentage": -6.3,
      "orderType": "Regular Purchase",
      "paymentStatus": "Paid",
      "deliveryDate": "2024-06-16",
      "wastePercentage": 4.1,
      "wasteCost": 30.75,
      "actualUsage": 28.77,
      "efficiency": 95.9,
      "notes": "Quality sand for road base preparation",
      "image": "https://picsum.photos/120/120?random=73&keyword=sand"
    },
    {
      "id": "CST004",
      "date": "2024-06-15",
      "materialId": "MAT004",
      "materialName": "Red Clay Bricks",
      "category": "Bricks",
      "project": "Residential Complex",
      "supplier": "Brick Manufacturing",
      "quantity": 5000,
      "unit": "pieces",
      "unitPrice": 0.35,
      "totalCost": 1750.00,
      "budgetAllocated": 1600.00,
      "varianceAmount": 150.00,
      "variancePercentage": 9.4,
      "orderType": "Emergency Purchase",
      "paymentStatus": "Paid",
      "deliveryDate": "2024-06-15",
      "wastePercentage": 6.8,
      "wasteCost": 119.00,
      "actualUsage": 4660,
      "efficiency": 93.2,
      "notes": "Emergency order due to stockout situation",
      "image": "https://picsum.photos/120/120?random=74&keyword=bricks"
    },
    {
      "id": "CST005",
      "date": "2024-06-14",
      "materialId": "MAT005",
      "materialName": "Pine Timber",
      "category": "Timber",
      "project": "Commercial Plaza",
      "supplier": "Timber Merchants",
      "quantity": 15,
      "unit": "cubic meters",
      "unitPrice": 180.00,
      "totalCost": 2700.00,
      "budgetAllocated": 2500.00,
      "varianceAmount": 200.00,
      "variancePercentage": 8.0,
      "orderType": "Contract Purchase",
      "paymentStatus": "Pending",
      "deliveryDate": "2024-06-14",
      "wastePercentage": 2.8,
      "wasteCost": 75.60,
      "actualUsage": 14.58,
      "efficiency": 97.2,
      "notes": "Premium timber for formwork construction",
      "image": "https://picsum.photos/120/120?random=75&keyword=wood"
    },
    {
      "id": "CST006",
      "date": "2024-06-13",
      "materialId": "MAT006",
      "materialName": "Exterior Paint",
      "category": "Paint",
      "project": "Foundation Project Phase 2",
      "supplier": "Paint Store",
      "quantity": 50,
      "unit": "liters",
      "unitPrice": 45.00,
      "totalCost": 2250.00,
      "budgetAllocated": 2200.00,
      "varianceAmount": 50.00,
      "variancePercentage": 2.3,
      "orderType": "Regular Purchase",
      "paymentStatus": "Paid",
      "deliveryDate": "2024-06-13",
      "wastePercentage": 5.2,
      "wasteCost": 117.00,
      "actualUsage": 47.4,
      "efficiency": 94.8,
      "notes": "High-quality exterior paint for building facade",
      "image": "https://picsum.photos/120/120?random=76&keyword=paint"
    },
  ];

  List<Map<String, dynamic>> get filteredCostRecords {
    return costRecords.where((cost) {
      bool matchesSearch = searchQuery.isEmpty ||
          (cost["materialName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (cost["project"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (cost["supplier"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (cost["materialId"] as String).toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesProject = selectedProject == "All" || cost["project"] == selectedProject;
      bool matchesCategory = selectedCategory == "All" || cost["category"] == selectedCategory;

      return matchesSearch && matchesProject && matchesCategory;
    }).toList()..sort((a, b) => 
        DateTime.parse(b["date"] as String).compareTo(DateTime.parse(a["date"] as String)));
  }

  Color _getVarianceColor(double variancePercentage) {
    if (variancePercentage <= -10) return successColor;
    if (variancePercentage <= 0) return infoColor;
    if (variancePercentage <= 10) return warningColor;
    return dangerColor;
  }

  Color _getPaymentStatusColor(String status) {
    switch (status) {
      case "Paid":
        return successColor;
      case "Pending":
        return warningColor;
      case "Overdue":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalCost = filteredCostRecords.fold(0.0, (sum, item) => sum + (item["totalCost"] as double));
    double totalBudget = filteredCostRecords.fold(0.0, (sum, item) => sum + (item["budgetAllocated"] as double));
    double totalWasteCost = filteredCostRecords.fold(0.0, (sum, item) => sum + (item["wasteCost"] as double));
    double avgEfficiency = filteredCostRecords.isNotEmpty 
        ? filteredCostRecords.fold(0.0, (sum, item) => sum + (item["efficiency"] as double)) / filteredCostRecords.length 
        : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text("Material Cost Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              _exportReport();
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog();
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
              label: "Search cost records...",
              value: searchQuery,
              hint: "Enter material name, project, or supplier",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Period Selector
            QDropdownField(
              label: "Analysis Period",
              items: periodOptions,
              value: selectedPeriod,
              onChanged: (value, label) {
                selectedPeriod = value;
                setState(() {});
              },
            ),

            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    "Total Cost",
                    "\$${totalCost.currency}",
                    Icons.attach_money,
                    primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildSummaryCard(
                    "Budget Used",
                    "${totalBudget > 0 ? ((totalCost / totalBudget) * 100).toStringAsFixed(1) : '0'}%",
                    Icons.pie_chart,
                    infoColor,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    "Waste Cost",
                    "\$${totalWasteCost.currency}",
                    Icons.delete,
                    dangerColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildSummaryCard(
                    "Avg Efficiency",
                    "${avgEfficiency.toStringAsFixed(1)}%",
                    Icons.trending_up,
                    successColor,
                  ),
                ),
              ],
            ),

            // Budget vs Actual Chart Placeholder
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
                    "Budget vs Actual Cost",
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
                          children: [
                            Text(
                              "Budgeted",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "\$${totalBudget.currency}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Actual",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "\$${totalCost.currency}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Variance",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${totalCost > totalBudget ? '+' : ''}\$${(totalCost - totalBudget).abs().currency}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: totalCost > totalBudget ? dangerColor : successColor,
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

            // Quick Category Filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: spSm,
                children: [
                  _buildQuickFilter("All", selectedCategory == "All"),
                  _buildQuickFilter("Cement", selectedCategory == "Cement"),
                  _buildQuickFilter("Steel", selectedCategory == "Steel"),
                  _buildQuickFilter("Aggregate", selectedCategory == "Aggregate"),
                  _buildQuickFilter("Timber", selectedCategory == "Timber"),
                ],
              ),
            ),

            // Cost Records List
            Column(
              spacing: spSm,
              children: filteredCostRecords.map((cost) {
                return _buildCostCard(cost);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
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
                size: 20,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFilter(String label, bool isActive) {
    return GestureDetector(
      onTap: () {
        selectedCategory = label == "All" ? "All" : label;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
        decoration: BoxDecoration(
          color: isActive ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isActive ? primaryColor : disabledOutlineBorderColor,
          ),
          boxShadow: [shadowSm],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : disabledBoldColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildCostCard(Map<String, dynamic> cost) {
    Color varianceColor = _getVarianceColor(cost["variancePercentage"] as double);
    Color paymentStatusColor = _getPaymentStatusColor(cost["paymentStatus"] as String);
    DateTime costDate = DateTime.parse(cost["date"] as String);
    double efficiency = cost["efficiency"] as double;
    double wastePercentage = (cost["wasteCost"] as double) / (cost["totalCost"] as double) * 100;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: varianceColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          // Header
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${cost["image"]}",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${cost["materialName"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${cost["materialId"]} • ${cost["category"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${costDate.dMMMy}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${(cost["totalCost"] as double).currency}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: paymentStatusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${cost["paymentStatus"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: paymentStatusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Project & Supplier Info
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.construction,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${cost["project"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.business,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${cost["supplier"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${cost["orderType"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Quantity & Pricing
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quantity",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${cost["quantity"]} ${cost["unit"]}",
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Unit Price",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${(cost["unitPrice"] as double).currency}",
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Efficiency",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${efficiency.toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: efficiency >= 95 ? successColor : efficiency >= 85 ? warningColor : dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Budget Analysis
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: varianceColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text(
                      "Budget Analysis",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
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
                            "Allocated",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${(cost["budgetAllocated"] as double).currency}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Variance",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${(cost["varianceAmount"] as double) >= 0 ? '+' : ''}\$${(cost["varianceAmount"] as double).abs().currency}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: varianceColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Variance %",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${(cost["variancePercentage"] as double) >= 0 ? '+' : ''}${(cost["variancePercentage"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: varianceColor,
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

          // Waste Analysis
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Waste Cost",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${(cost["wasteCost"] as double).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Waste %",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${(cost["wastePercentage"] as double).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Actual Usage",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${cost["actualUsage"]} ${cost["unit"]}",
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
          ),

          // Notes
          if (cost["notes"] != null && (cost["notes"] as String).isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${cost["notes"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('cost_details')
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Compare Prices",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('price_comparison')
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Filter Cost Records"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QDropdownField(
                label: "Project",
                items: projectOptions,
                value: selectedProject,
                onChanged: (value, label) {
                  selectedProject = value;
                  setState(() {});
                },
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
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                selectedProject = "All";
                selectedCategory = "All";
                setState(() {});
                Navigator.pop(context);
              },
              child: Text("Clear"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Apply"),
            ),
          ],
        );
      },
    );
  }

  void _exportReport() {
    ss("Cost analysis report exported successfully");
  }
}
