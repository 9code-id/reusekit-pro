import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmReorderPointsView extends StatefulWidget {
  const IwmReorderPointsView({super.key});

  @override
  State<IwmReorderPointsView> createState() => _IwmReorderPointsViewState();
}

class _IwmReorderPointsViewState extends State<IwmReorderPointsView> {
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
    {"label": "Below Reorder Point", "value": "below"},
    {"label": "At Reorder Point", "value": "at"},
    {"label": "Above Reorder Point", "value": "above"},
  ];

  List<Map<String, dynamic>> reorderSummary = [
    {
      "title": "Items Below Reorder Point",
      "value": 18,
      "subtitle": "Needs immediate attention",
      "icon": Icons.warning,
      "color": dangerColor
    },
    {
      "title": "Items At Reorder Point",
      "value": 7,
      "subtitle": "Should order soon",
      "icon": Icons.schedule,
      "color": warningColor
    },
    {
      "title": "Total Reorder Points Set",
      "value": 245,
      "subtitle": "Active monitoring",
      "icon": Icons.inventory,
      "color": primaryColor
    },
    {
      "title": "Auto-Orders Generated",
      "value": 12,
      "subtitle": "This month",
      "icon": Icons.auto_mode,
      "color": successColor
    },
  ];

  List<Map<String, dynamic>> reorderPoints = [
    {
      "productId": "PRD-001",
      "productName": "Wireless Headphones",
      "category": "Electronics",
      "warehouse": "Main Warehouse",
      "currentStock": 25,
      "reorderPoint": 50,
      "reorderQuantity": 100,
      "leadTime": 7,
      "avgDailyUsage": 8.5,
      "status": "Below Reorder Point",
      "lastUpdated": "2024-01-16 08:00",
      "supplier": "TechSupply Co.",
      "cost": 45.00,
      "priority": "High"
    },
    {
      "productId": "PRD-002",
      "productName": "Cotton T-Shirt",
      "category": "Clothing",
      "warehouse": "Distribution Center",
      "currentStock": 89,
      "reorderPoint": 75,
      "reorderQuantity": 150,
      "leadTime": 14,
      "avgDailyUsage": 5.2,
      "status": "Above Reorder Point",
      "lastUpdated": "2024-01-16 07:30",
      "supplier": "Fashion Hub",
      "cost": 12.50,
      "priority": "Low"
    },
    {
      "productId": "PRD-003",
      "productName": "Garden Tools Set",
      "category": "Home & Garden",
      "warehouse": "Regional Hub",
      "currentStock": 35,
      "reorderPoint": 40,
      "reorderQuantity": 80,
      "leadTime": 10,
      "avgDailyUsage": 3.8,
      "status": "At Reorder Point",
      "lastUpdated": "2024-01-16 09:15",
      "supplier": "Garden Pro",
      "cost": 85.00,
      "priority": "Medium"
    },
  ];

  List<Map<String, dynamic>> reorderSettings = [
    {
      "settingName": "Auto-Reorder",
      "description": "Automatically generate purchase orders when stock reaches reorder point",
      "enabled": true,
      "applicableItems": 125
    },
    {
      "settingName": "Dynamic Reorder Points",
      "description": "Adjust reorder points based on seasonal demand patterns",
      "enabled": false,
      "applicableItems": 89
    },
    {
      "settingName": "Safety Stock Buffer",
      "description": "Add safety stock percentage to reorder calculations",
      "enabled": true,
      "applicableItems": 245
    },
    {
      "settingName": "Supplier Integration",
      "description": "Send orders directly to supplier systems",
      "enabled": true,
      "applicableItems": 156
    },
  ];

  List<Map<String, dynamic>> reorderAnalytics = [
    {
      "metric": "Stockout Prevention",
      "value": 96.5,
      "target": 95.0,
      "trend": "up",
      "unit": "%",
      "description": "Stockouts prevented by reorder system"
    },
    {
      "metric": "Average Days in Stock",
      "value": 23.4,
      "target": 25.0,
      "trend": "stable",
      "unit": "days",
      "description": "Days of inventory after reorder"
    },
    {
      "metric": "Reorder Accuracy",
      "value": 89.2,
      "target": 90.0,
      "trend": "up",
      "unit": "%",
      "description": "Orders placed at optimal time"
    },
    {
      "metric": "Cost Optimization",
      "value": 15.8,
      "target": 12.0,
      "trend": "down",
      "unit": "%",
      "description": "Savings from optimized ordering"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Reorder Points",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Reorder Points", icon: Icon(Icons.reorder)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildReorderPointsTab(),
        _buildSettingsTab(),
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
          _buildReorderSummary(),
          _buildReorderAnalytics(),
          _buildCriticalItems(),
        ],
      ),
    );
  }

  Widget _buildReorderPointsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReorderFilters(),
          _buildReorderPointsList(),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSettingsHeader(),
          _buildReorderSettingsList(),
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

  Widget _buildReorderFilters() {
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
            icon: Icons.add,
            label: "Add Reorder Point",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsHeader() {
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
                  "Reorder Point Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Configure automatic reordering behavior and rules",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.save,
            label: "Save Changes",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildReorderSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Reorder Point Status",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: reorderSummary.map((summary) => _buildSummaryCard(summary)).toList(),
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
            "${summary["value"]}",
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

  Widget _buildReorderAnalytics() {
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
            "Reorder Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...reorderAnalytics.map((analytic) => _buildAnalyticItem(analytic)),
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
    List<Map<String, dynamic>> criticalItems = reorderPoints
        .where((item) => item["status"] == "Below Reorder Point")
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
            height: 40,
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
                  "Stock: ${item["currentStock"]} / Reorder: ${item["reorderPoint"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Order Now",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildReorderPointsList() {
    return Column(
      spacing: spSm,
      children: reorderPoints.map((point) => _buildReorderPointCard(point)).toList(),
    );
  }

  Widget _buildReorderPointCard(Map<String, dynamic> point) {
    Color statusColor = _getStatusColor(point["status"]);
    Color priorityColor = _getPriorityColor(point["priority"]);
    double stockPercentage = (point["currentStock"] as int) / (point["reorderPoint"] as int);
    
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
                      "${point["productName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${point["productId"]} • ${point["category"]}",
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
                      "${point["priority"]}",
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
                      "${point["status"]}",
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
              widthFactor: stockPercentage.clamp(0.0, 1.0),
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
              _buildStockInfo("Current Stock", "${point["currentStock"]}", primaryColor),
              _buildStockInfo("Reorder Point", "${point["reorderPoint"]}", statusColor),
              _buildStockInfo("Reorder Quantity", "${point["reorderQuantity"]}", infoColor),
              _buildStockInfo("Lead Time", "${point["leadTime"]} days", disabledBoldColor),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Warehouse: ${point["warehouse"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Supplier: ${point["supplier"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Cost: \$${((point["cost"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
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
                    "Avg Daily Usage: ${(point["avgDailyUsage"] as double).toStringAsFixed(1)}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Updated: ${point["lastUpdated"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledColor,
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
                label: "Edit",
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              if (point["status"] == "Below Reorder Point")
                QButton(
                  label: "Create Order",
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

  Widget _buildReorderSettingsList() {
    return Column(
      spacing: spSm,
      children: reorderSettings.map((setting) => _buildSettingCard(setting)).toList(),
    );
  }

  Widget _buildSettingCard(Map<String, dynamic> setting) {
    bool isEnabled = setting["enabled"];
    
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
              spacing: spXs,
              children: [
                Text(
                  "${setting["settingName"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${setting["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Applicable to ${setting["applicableItems"]} items",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
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
              setting["enabled"] = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'below reorder point':
        return dangerColor;
      case 'at reorder point':
        return warningColor;
      case 'above reorder point':
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
}
