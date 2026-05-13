import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaPortionControlView extends StatefulWidget {
  const RmaPortionControlView({super.key});

  @override
  State<RmaPortionControlView> createState() => _RmaPortionControlViewState();
}

class _RmaPortionControlViewState extends State<RmaPortionControlView> {
  String selectedCategory = "all";
  String selectedStatus = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> portionItems = [
    {
      "id": "PRT-001",
      "itemName": "Grilled Salmon",
      "category": "main_course",
      "standardPortion": 180,
      "unit": "g",
      "actualPortions": [
        {"date": "2024-03-15", "weight": 185, "variance": 2.8, "staff": "John Chef"},
        {"date": "2024-03-15", "weight": 175, "variance": -2.8, "staff": "John Chef"},
        {"date": "2024-03-15", "weight": 190, "variance": 5.6, "staff": "Sarah Kitchen"},
      ],
      "avgVariance": 1.9,
      "costPerGram": 0.125,
      "dailyWaste": 15.5,
      "totalServed": 28,
      "complianceRate": 85.7,
      "status": "needs_attention",
    },
    {
      "id": "PRT-002",
      "itemName": "Caesar Salad",
      "category": "appetizer",
      "standardPortion": 120,
      "unit": "g",
      "actualPortions": [
        {"date": "2024-03-15", "weight": 118, "variance": -1.7, "staff": "Mike Prep"},
        {"date": "2024-03-15", "weight": 122, "variance": 1.7, "staff": "Lisa Salad"},
        {"date": "2024-03-15", "weight": 120, "variance": 0.0, "staff": "Mike Prep"},
      ],
      "avgVariance": 0.0,
      "costPerGram": 0.08,
      "dailyWaste": 2.1,
      "totalServed": 45,
      "complianceRate": 96.7,
      "status": "good",
    },
    {
      "id": "PRT-003",
      "itemName": "Chocolate Lava Cake",
      "category": "dessert",
      "standardPortion": 85,
      "unit": "g",
      "actualPortions": [
        {"date": "2024-03-15", "weight": 95, "variance": 11.8, "staff": "Emma Pastry"},
        {"date": "2024-03-15", "weight": 90, "variance": 5.9, "staff": "Emma Pastry"},
        {"date": "2024-03-15", "weight": 88, "variance": 3.5, "staff": "David Dessert"},
      ],
      "avgVariance": 7.1,
      "costPerGram": 0.18,
      "dailyWaste": 12.8,
      "totalServed": 18,
      "complianceRate": 72.2,
      "status": "critical",
    },
    {
      "id": "PRT-004",
      "itemName": "French Fries",
      "category": "side",
      "standardPortion": 150,
      "unit": "g",
      "actualPortions": [
        {"date": "2024-03-15", "weight": 155, "variance": 3.3, "staff": "Tom Fry"},
        {"date": "2024-03-15", "weight": 148, "variance": -1.3, "staff": "Tom Fry"},
        {"date": "2024-03-15", "weight": 152, "variance": 1.3, "staff": "Anna Kitchen"},
      ],
      "avgVariance": 1.1,
      "costPerGram": 0.04,
      "dailyWaste": 8.2,
      "totalServed": 62,
      "complianceRate": 91.9,
      "status": "good",
    },
    {
      "id": "PRT-005",
      "itemName": "House Wine",
      "category": "beverage",
      "standardPortion": 150,
      "unit": "ml",
      "actualPortions": [
        {"date": "2024-03-15", "weight": 165, "variance": 10.0, "staff": "Rachel Bar"},
        {"date": "2024-03-15", "weight": 160, "variance": 6.7, "staff": "Rachel Bar"},
        {"date": "2024-03-15", "weight": 145, "variance": -3.3, "staff": "Mark Server"},
      ],
      "avgVariance": 4.4,
      "costPerGram": 0.12,
      "dailyWaste": 18.0,
      "totalServed": 35,
      "complianceRate": 80.0,
      "status": "needs_attention",
    },
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Main Course", "value": "main_course"},
    {"label": "Appetizers", "value": "appetizer"},
    {"label": "Desserts", "value": "dessert"},
    {"label": "Sides", "value": "side"},
    {"label": "Beverages", "value": "beverage"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Good", "value": "good"},
    {"label": "Needs Attention", "value": "needs_attention"},
    {"label": "Critical", "value": "critical"},
  ];

  List<Map<String, dynamic>> get filteredItems {
    return portionItems.where((item) {
      final matchesCategory = selectedCategory == "all" || item["category"] == selectedCategory;
      final matchesStatus = selectedStatus == "all" || item["status"] == selectedStatus;
      final matchesSearch = searchQuery.isEmpty ||
          item["itemName"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesCategory && matchesStatus && matchesSearch;
    }).toList();
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
                Icons.scale,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Portion Control",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Add Standard",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('AddPortionStandard')
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search items...",
                  value: searchQuery,
                  hint: "Item name",
                  onChanged: (value) {
                    searchQuery = value;
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
        ],
      ),
    );
  }

  Widget _buildPortionSummary() {
    final totalItems = filteredItems.length;
    final avgCompliance = filteredItems.fold(0.0, (sum, item) => sum + (item["complianceRate"] as double)) / 
                         (totalItems > 0 ? totalItems : 1);
    final totalWaste = filteredItems.fold(0.0, (sum, item) => sum + (item["dailyWaste"] as double));
    final criticalItems = filteredItems.where((item) => item["status"] == "critical").length;

    return Container(
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
            "Portion Control Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildSummaryCard(
                "Total Items",
                "$totalItems",
                Icons.restaurant_menu,
                primaryColor,
              ),
              _buildSummaryCard(
                "Avg Compliance",
                "${avgCompliance.toStringAsFixed(1)}%",
                Icons.check_circle,
                _getComplianceColor(avgCompliance),
              ),
              _buildSummaryCard(
                "Daily Waste",
                "${totalWaste.toStringAsFixed(1)}g",
                Icons.delete_outline,
                dangerColor,
              ),
              _buildSummaryCard(
                "Critical Items",
                "$criticalItems",
                Icons.warning,
                criticalItems > 0 ? dangerColor : successColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortionList() {
    return Container(
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
            "Portion Control Items (${filteredItems.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          if (filteredItems.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "No portion control items found",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            )
          else
            ...filteredItems.map((item) => _buildPortionCard(item)).toList(),
        ],
      ),
    );
  }

  Widget _buildPortionCard(Map<String, dynamic> item) {
    final statusColor = _getStatusColor(item["status"]);
    final complianceColor = _getComplianceColor(item["complianceRate"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
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
                          "${item["itemName"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${item["status"]}".replaceAll('_', ' ').toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${item["category"]}".replaceAll('_', ' ').toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
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
                    "${item["complianceRate"]}%",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: complianceColor,
                    ),
                  ),
                  Text(
                    "Compliance",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            minItemWidth: 150,
            children: [
              _buildPortionDetail(
                "Standard Portion",
                "${item["standardPortion"]} ${item["unit"]}",
                Icons.straighten,
                primaryColor,
              ),
              _buildPortionDetail(
                "Avg Variance",
                "${(item["avgVariance"] as double).toStringAsFixed(1)}%",
                Icons.trending_up,
                _getVarianceColor(item["avgVariance"]),
              ),
              _buildPortionDetail(
                "Daily Waste",
                "${(item["dailyWaste"] as double).toStringAsFixed(1)}g",
                Icons.delete_outline,
                dangerColor,
              ),
              _buildPortionDetail(
                "Total Served",
                "${item["totalServed"]}",
                Icons.restaurant,
                infoColor,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recent Portions (Today)",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...(item["actualPortions"] as List<Map<String, dynamic>>).map((portion) => 
                  Container(
                    margin: EdgeInsets.only(bottom: spXs),
                    child: Row(
                      children: [
                        Text(
                          "${portion["weight"]} ${item["unit"]}",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getVarianceColor(portion["variance"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${(portion["variance"] as double) >= 0 ? '+' : ''}${(portion["variance"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _getVarianceColor(portion["variance"]),
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${portion["staff"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View History",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('PortionHistory')
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Update Standard",
                size: bs.sm,
                onPressed: () {
                  //navigateTo('UpdateStandard')
                },
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Train Staff",
                size: bs.sm,
                onPressed: () {
                  //navigateTo('StaffTraining')
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPortionDetail(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spXs),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 16,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "good":
        return successColor;
      case "needs_attention":
        return warningColor;
      case "critical":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getComplianceColor(double compliance) {
    if (compliance >= 95) return successColor;
    if (compliance >= 85) return infoColor;
    if (compliance >= 75) return warningColor;
    return dangerColor;
  }

  Color _getVarianceColor(double variance) {
    final absVariance = variance.abs();
    if (absVariance <= 2) return successColor;
    if (absVariance <= 5) return warningColor;
    return dangerColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Portion Control"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              //navigateTo('PortionAnalytics')
            },
          ),
          IconButton(
            icon: Icon(Icons.school),
            onPressed: () {
              //navigateTo('StaffTraining')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildHeader(),
            _buildPortionSummary(),
            _buildPortionList(),
          ],
        ),
      ),
    );
  }
}
