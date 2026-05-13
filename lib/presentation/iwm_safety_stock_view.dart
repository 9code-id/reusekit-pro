import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmSafetyStockView extends StatefulWidget {
  const IwmSafetyStockView({super.key});

  @override
  State<IwmSafetyStockView> createState() => _IwmSafetyStockViewState();
}

class _IwmSafetyStockViewState extends State<IwmSafetyStockView> {
  int selectedTab = 0;
  String selectedWarehouse = "all";
  String selectedCategory = "all";
  String selectedStatus = "all";

  List<Map<String, dynamic>> warehouseFilters = [
    {"label": "All Warehouses", "value": "all"},
    {"label": "Main Warehouse", "value": "main"},
    {"label": "Distribution Center", "value": "dist"},
    {"label": "Regional Hub", "value": "regional"},
  ];

  List<Map<String, dynamic>> categoryFilters = [
    {"label": "All Categories", "value": "all"},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Clothing", "value": "clothing"},
    {"label": "Home & Garden", "value": "home"},
  ];

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Status", "value": "all"},
    {"label": "Below Safety Stock", "value": "below"},
    {"label": "At Safety Stock", "value": "at"},
    {"label": "Above Safety Stock", "value": "above"},
  ];

  List<Map<String, dynamic>> safetyStockSummary = [
    {
      "title": "Items Below Safety Stock",
      "value": 23,
      "subtitle": "High risk of stockout",
      "icon": Icons.error,
      "color": dangerColor
    },
    {
      "title": "Items At Safety Stock",
      "value": 12,
      "subtitle": "Minimum safe level",
      "icon": Icons.warning,
      "color": warningColor
    },
    {
      "title": "Safety Stock Coverage",
      "value": 87.5,
      "subtitle": "Overall protection",
      "icon": Icons.shield,
      "color": successColor,
      "unit": "%"
    },
    {
      "title": "Average Safety Days",
      "value": 14.2,
      "subtitle": "Days of protection",
      "icon": Icons.schedule,
      "color": infoColor,
      "unit": "days"
    },
  ];

  List<Map<String, dynamic>> safetyStockItems = [
    {
      "productId": "PRD-001",
      "productName": "Wireless Headphones",
      "category": "Electronics",
      "warehouse": "Main Warehouse",
      "currentStock": 45,
      "safetyStock": 60,
      "recommendedSafetyStock": 75,
      "avgDailyUsage": 8.5,
      "leadTime": 7,
      "demandVariability": "High",
      "status": "Below Safety Stock",
      "stockoutRisk": 85.2,
      "lastStockout": "2024-01-10",
      "supplier": "TechSupply Co.",
      "cost": 45.00,
      "priority": "High"
    },
    {
      "productId": "PRD-002",
      "productName": "Cotton T-Shirt",
      "category": "Clothing",
      "warehouse": "Distribution Center",
      "currentStock": 125,
      "safetyStock": 90,
      "recommendedSafetyStock": 95,
      "avgDailyUsage": 5.2,
      "leadTime": 14,
      "demandVariability": "Medium",
      "status": "Above Safety Stock",
      "stockoutRisk": 12.8,
      "lastStockout": "2023-11-15",
      "supplier": "Fashion Hub",
      "cost": 12.50,
      "priority": "Low"
    },
    {
      "productId": "PRD-003",
      "productName": "Garden Tools Set",
      "category": "Home & Garden",
      "warehouse": "Regional Hub",
      "currentStock": 78,
      "safetyStock": 80,
      "recommendedSafetyStock": 85,
      "avgDailyUsage": 3.8,
      "leadTime": 10,
      "demandVariability": "Very High",
      "status": "At Safety Stock",
      "stockoutRisk": 45.6,
      "lastStockout": "2023-12-22",
      "supplier": "Garden Pro",
      "cost": 85.00,
      "priority": "Medium"
    },
  ];

  List<Map<String, dynamic>> safetyStockCalculations = [
    {
      "calculationMethod": "Fixed Percentage",
      "description": "Safety stock = Fixed percentage of average demand",
      "formula": "Safety Stock = Avg Demand × Percentage",
      "applicableItems": 89,
      "accuracy": 78.5,
      "enabled": true
    },
    {
      "calculationMethod": "Service Level",
      "description": "Based on desired service level and demand variability",
      "formula": "Safety Stock = Z-score × √(Lead Time) × Demand StdDev",
      "applicableItems": 156,
      "accuracy": 92.3,
      "enabled": true
    },
    {
      "calculationMethod": "Min-Max Method",
      "description": "Safety stock between minimum and maximum thresholds",
      "formula": "Safety Stock = Max(Min Level, Historical Max Demand)",
      "applicableItems": 67,
      "accuracy": 83.7,
      "enabled": false
    },
  ];

  List<Map<String, dynamic>> safetyStockAnalytics = [
    {
      "metric": "Stockout Prevention Rate",
      "value": 94.2,
      "target": 95.0,
      "trend": "up",
      "unit": "%",
      "description": "Stockouts prevented by safety stock"
    },
    {
      "metric": "Carrying Cost Impact",
      "value": 8.5,
      "target": 10.0,
      "trend": "down",
      "unit": "%",
      "description": "Additional cost from safety stock"
    },
    {
      "metric": "Turnover Ratio",
      "value": 6.8,
      "target": 8.0,
      "trend": "up",
      "unit": "times",
      "description": "Safety stock turnover per year"
    },
    {
      "metric": "Service Level Achievement",
      "value": 96.8,
      "target": 95.0,
      "trend": "stable",
      "unit": "%",
      "description": "Orders fulfilled without stockout"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Safety Stock",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Safety Stock", icon: Icon(Icons.shield)),
        Tab(text: "Calculations", icon: Icon(Icons.calculate)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildSafetyStockTab(),
        _buildCalculationsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilters(),
          _buildSafetyStockSummary(),
          _buildSafetyStockAnalytics(),
          _buildCriticalItems(),
        ],
      ),
    );
  }

  Widget _buildSafetyStockTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSafetyStockFilters(),
          _buildSafetyStockList(),
        ],
      ),
    );
  }

  Widget _buildCalculationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCalculationHeader(),
          _buildCalculationMethodsList(),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Warehouse",
                  items: warehouseFilters,
                  value: selectedWarehouse,
                  onChanged: (value, label) {
                    selectedWarehouse = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryFilters,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Status",
            items: statusFilters,
            value: selectedStatus,
            onChanged: (value, label) {
              selectedStatus = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSafetyStockFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: QDropdownField(
              label: "Filter by Status",
              items: statusFilters,
              value: selectedStatus,
              onChanged: (value, label) {
                selectedStatus = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.calculate,
            label: "Recalculate",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildCalculationHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Safety Stock Calculation Methods",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Configure how safety stock levels are calculated for different product categories",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.settings,
            label: "Configure",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSafetyStockSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Safety Stock Status",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: safetyStockSummary.map((summary) => _buildSummaryCard(summary)).toList(),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(Map<String, dynamic> summary) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (summary["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  summary["icon"],
                  color: summary["color"],
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            "${summary["value"]}${summary["unit"] ?? ""}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${summary["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${summary["subtitle"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSafetyStockAnalytics() {
    return Container(
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
            "Safety Stock Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...safetyStockAnalytics.map((analytic) => _buildAnalyticItem(analytic)),
        ],
      ),
    );
  }

  Widget _buildAnalyticItem(Map<String, dynamic> analytic) {
    Color trendColor = _getTrendColor(analytic["trend"]);
    IconData trendIcon = _getTrendIcon(analytic["trend"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Text(
                "${analytic["metric"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Icon(
                trendIcon,
                color: trendColor,
                size: 16,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "${analytic["value"]}${analytic["unit"]}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spXs),
              Text(
                "/ ${analytic["target"]}${analytic["unit"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Text(
            "${analytic["description"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCriticalItems() {
    List<Map<String, dynamic>> criticalItems = safetyStockItems
        .where((item) => item["status"] == "Below Safety Stock")
        .take(3)
        .toList();
    
    return Container(
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
          Row(
            children: [
              Text(
                "Critical Items",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {
                  selectedTab = 1;
                  setState(() {});
                },
              ),
            ],
          ),
          ...criticalItems.map((item) => _buildCriticalItemCard(item)),
        ],
      ),
    );
  }

  Widget _buildCriticalItemCard(Map<String, dynamic> item) {
    Color statusColor = _getStatusColor(item["status"]);
    double riskLevel = item["stockoutRisk"];
    Color riskColor = _getRiskColor(riskLevel);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: statusColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 50,
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item["productName"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Current: ${item["currentStock"]} / Safety: ${item["safetyStock"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                  ),
                ),
                Text(
                  "Stockout Risk: ${(riskLevel).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 12,
                    color: riskColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Increase Stock",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSafetyStockList() {
    return Column(
      spacing: spSm,
      children: safetyStockItems.map((item) => _buildSafetyStockCard(item)).toList(),
    );
  }

  Widget _buildSafetyStockCard(Map<String, dynamic> item) {
    Color statusColor = _getStatusColor(item["status"]);
    Color priorityColor = _getPriorityColor(item["priority"]);
    Color variabilityColor = _getVariabilityColor(item["demandVariability"]);
    Color riskColor = _getRiskColor(item["stockoutRisk"]);
    double stockPercentage = (item["currentStock"] as int) / (item["safetyStock"] as int);
    
    return Container(
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item["productName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${item["productId"]} • ${item["category"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: priorityColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${item["priority"]}",
                      style: TextStyle(
                        color: priorityColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(width: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${item["status"]}",
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 6,
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: stockPercentage.clamp(0.0, 1.5),
              child: Container(
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStockInfo("Current Stock", "${item["currentStock"]}", primaryColor),
              _buildStockInfo("Safety Stock", "${item["safetyStock"]}", statusColor),
              _buildStockInfo("Recommended", "${item["recommendedSafetyStock"]}", infoColor),
              _buildStockInfo("Stockout Risk", "${(item["stockoutRisk"] as double).toStringAsFixed(1)}%", riskColor),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Demand Variability: ",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                          decoration: BoxDecoration(
                            color: variabilityColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${item["demandVariability"]}",
                            style: TextStyle(
                              color: variabilityColor,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Avg Daily Usage: ${(item["avgDailyUsage"] as double).toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Lead Time: ${item["leadTime"]} days",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Last Stockout: ${item["lastStockout"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: dangerColor,
                    ),
                  ),
                  Text(
                    "Supplier: ${item["supplier"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Cost: \$${((item["cost"] as double)).currency}",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Spacer(),
              QButton(
                label: "Adjust",
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              if (item["status"] == "Below Safety Stock")
                QButton(
                  label: "Emergency Order",
                  size: bs.sm,
                  onPressed: () {},
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStockInfo(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalculationMethodsList() {
    return Column(
      spacing: spSm,
      children: safetyStockCalculations.map((calculation) => _buildCalculationCard(calculation)).toList(),
    );
  }

  Widget _buildCalculationCard(Map<String, dynamic> calculation) {
    bool isEnabled = calculation["enabled"];
    Color accuracyColor = _getAccuracyColor(calculation["accuracy"]);
    
    return Container(
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${calculation["calculationMethod"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${calculation["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QSwitch(
                items: [
                  {
                    "label": "Enable",
                    "value": true,
                    "checked": isEnabled,
                  }
                ],
                value: isEnabled ? [{"label": "Enable", "value": true, "checked": true}] : [],
                onChanged: (values, ids) {
                  calculation["enabled"] = values.isNotEmpty;
                  setState(() {});
                },
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Formula:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${calculation["formula"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      "Accuracy: ",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(calculation["accuracy"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: accuracyColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Applied to ${calculation["applicableItems"]} items",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'below safety stock':
        return dangerColor;
      case 'at safety stock':
        return warningColor;
      case 'above safety stock':
        return successColor;
      default:
        return primaryColor;
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
        return primaryColor;
    }
  }

  Color _getVariabilityColor(String variability) {
    switch (variability.toLowerCase()) {
      case 'very high':
        return dangerColor;
      case 'high':
        return warningColor;
      case 'medium':
        return infoColor;
      case 'low':
        return successColor;
      default:
        return primaryColor;
    }
  }

  Color _getRiskColor(double risk) {
    if (risk >= 70) return dangerColor;
    if (risk >= 40) return warningColor;
    if (risk >= 20) return infoColor;
    return successColor;
  }

  Color _getTrendColor(String trend) {
    switch (trend.toLowerCase()) {
      case 'up':
        return successColor;
      case 'down':
        return dangerColor;
      case 'stable':
        return infoColor;
      default:
        return primaryColor;
    }
  }

  IconData _getTrendIcon(String trend) {
    switch (trend.toLowerCase()) {
      case 'up':
        return Icons.trending_up;
      case 'down':
        return Icons.trending_down;
      case 'stable':
        return Icons.trending_flat;
      default:
        return Icons.timeline;
    }
  }

  Color _getAccuracyColor(double accuracy) {
    if (accuracy >= 90) return successColor;
    if (accuracy >= 80) return infoColor;
    if (accuracy >= 70) return warningColor;
    return dangerColor;
  }
}
