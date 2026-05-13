import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaKpiDashboardView extends StatefulWidget {
  const ImaKpiDashboardView({super.key});

  @override
  State<ImaKpiDashboardView> createState() => _ImaKpiDashboardViewState();
}

class _ImaKpiDashboardViewState extends State<ImaKpiDashboardView> {
  String selectedPeriod = "monthly";
  String selectedLocation = "all";
  bool showComparisons = true;
  
  Map<String, dynamic> kpiData = {
    "inventory_turnover": {
      "current": 8.5,
      "previous": 7.8,
      "target": 9.0,
      "trend": "up",
      "unit": "times/year",
    },
    "days_sales_outstanding": {
      "current": 42.3,
      "previous": 45.1,
      "target": 40.0,
      "trend": "down",
      "unit": "days",
    },
    "stockout_rate": {
      "current": 2.1,
      "previous": 3.5,
      "target": 1.5,
      "trend": "down",
      "unit": "%",
    },
    "carrying_cost_ratio": {
      "current": 18.5,
      "previous": 19.2,
      "target": 15.0,
      "trend": "down",
      "unit": "%",
    },
    "order_fulfillment_rate": {
      "current": 97.8,
      "previous": 96.2,
      "target": 98.0,
      "trend": "up",
      "unit": "%",
    },
    "inventory_accuracy": {
      "current": 94.5,
      "previous": 92.1,
      "target": 95.0,
      "trend": "up",
      "unit": "%",
    },
    "dead_stock_percentage": {
      "current": 3.2,
      "previous": 4.1,
      "target": 2.0,
      "trend": "down",
      "unit": "%",
    },
    "supplier_performance": {
      "current": 91.7,
      "previous": 89.4,
      "target": 93.0,
      "trend": "up",
      "unit": "%",
    },
  };

  List<Map<String, dynamic>> topPerformingItems = [
    {
      "name": "Premium Coffee Beans",
      "sku": "PCB-001",
      "turnover_rate": 12.5,
      "performance_score": 95,
      "trend": "up",
    },
    {
      "name": "Organic Tea Leaves",
      "sku": "OTL-002", 
      "turnover_rate": 10.8,
      "performance_score": 92,
      "trend": "up",
    },
    {
      "name": "Sugar Packets",
      "sku": "SP-004",
      "turnover_rate": 9.5,
      "performance_score": 88,
      "trend": "stable",
    },
  ];

  List<Map<String, dynamic>> underperformingItems = [
    {
      "name": "Specialty Syrups",
      "sku": "SS-007",
      "turnover_rate": 2.1,
      "performance_score": 45,
      "trend": "down",
      "days_on_hand": 174,
    },
    {
      "name": "Decorative Cups",
      "sku": "DC-008",
      "turnover_rate": 1.8,
      "performance_score": 38,
      "trend": "down",
      "days_on_hand": 203,
    },
    {
      "name": "Gift Cards",
      "sku": "GC-009",
      "turnover_rate": 1.5,
      "performance_score": 32,
      "trend": "down",
      "days_on_hand": 243,
    },
  ];

  List<Map<String, dynamic>> alerts = [
    {
      "type": "Critical",
      "message": "Inventory turnover below target for 3 consecutive months",
      "category": "Performance",
      "severity": "high",
      "timestamp": "2025-06-20 09:15",
    },
    {
      "type": "Warning",
      "message": "Dead stock percentage increasing in Warehouse B",
      "category": "Optimization",
      "severity": "medium", 
      "timestamp": "2025-06-19 14:30",
    },
    {
      "type": "Info",
      "message": "Order fulfillment rate improved by 1.6% this month",
      "category": "Achievement",
      "severity": "low",
      "timestamp": "2025-06-18 11:45",
    },
  ];

  Color _getTrendColor(String trend) {
    switch (trend.toLowerCase()) {
      case 'up':
        return successColor;
      case 'down':
        return dangerColor;
      case 'stable':
        return warningColor;
      default:
        return disabledBoldColor;
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
        return Icons.help;
    }
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  bool _isKpiOnTarget(String kpiKey) {
    final kpi = kpiData[kpiKey];
    final current = kpi["current"] as double;
    final target = kpi["target"] as double;
    
    // For metrics where lower is better
    if (["days_sales_outstanding", "stockout_rate", "carrying_cost_ratio", "dead_stock_percentage"].contains(kpiKey)) {
      return current <= target;
    }
    // For metrics where higher is better
    return current >= target;
  }

  Widget _buildKpiCard(String title, String kpiKey) {
    final kpi = kpiData[kpiKey];
    final current = kpi["current"] as double;
    final previous = kpi["previous"] as double;
    final target = kpi["target"] as double;
    final trend = kpi["trend"] as String;
    final unit = kpi["unit"] as String;
    final isOnTarget = _isKpiOnTarget(kpiKey);
    final change = current - previous;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: isOnTarget ? successColor.withAlpha(100) : dangerColor.withAlpha(100),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: _getTrendColor(trend).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  _getTrendIcon(trend),
                  size: 14,
                  color: _getTrendColor(trend),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "$current",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spXs),
              Text(
                unit,
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Text(
                "Target: $target$unit",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: isOnTarget ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  isOnTarget ? "On Target" : "Off Target",
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: isOnTarget ? successColor : dangerColor,
                  ),
                ),
              ),
            ],
          ),
          if (showComparisons) ...[
            SizedBox(height: spXs),
            Row(
              children: [
                Icon(
                  change >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
                  size: 12,
                  color: change >= 0 ? successColor : dangerColor,
                ),
                SizedBox(width: 2),
                Text(
                  "${change >= 0 ? '+' : ''}${change.toStringAsFixed(1)}$unit vs last period",
                  style: TextStyle(
                    fontSize: 9,
                    color: change >= 0 ? successColor : dangerColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("KPI Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("KPI data refreshed");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filter Section
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
                  Text(
                    "Dashboard Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Period",
                          items: [
                            {"label": "Weekly", "value": "weekly"},
                            {"label": "Monthly", "value": "monthly"},
                            {"label": "Quarterly", "value": "quarterly"},
                            {"label": "Yearly", "value": "yearly"},
                          ],
                          value: selectedPeriod,
                          onChanged: (value, label) {
                            selectedPeriod = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Location",
                          items: [
                            {"label": "All Locations", "value": "all"},
                            {"label": "Warehouse A", "value": "warehouse_a"},
                            {"label": "Warehouse B", "value": "warehouse_b"},
                            {"label": "Store Front", "value": "store_front"},
                          ],
                          value: selectedLocation,
                          onChanged: (value, label) {
                            selectedLocation = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QSwitch(
                    label: "Show Period Comparisons",
                    items: [
                      {
                        "label": "Period Comparisons",
                        "value": true,
                        "checked": showComparisons,
                      }
                    ],
                    value: showComparisons ? [{"label": "Period Comparisons", "value": true, "checked": true}] : [],
                    onChanged: (values, ids) {
                      showComparisons = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Key Performance Indicators
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
                  Text(
                    "Key Performance Indicators",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildKpiCard("Inventory Turnover", "inventory_turnover"),
                      _buildKpiCard("Days Sales Outstanding", "days_sales_outstanding"),
                      _buildKpiCard("Stockout Rate", "stockout_rate"),
                      _buildKpiCard("Carrying Cost Ratio", "carrying_cost_ratio"),
                      _buildKpiCard("Order Fulfillment Rate", "order_fulfillment_rate"),
                      _buildKpiCard("Inventory Accuracy", "inventory_accuracy"),
                      _buildKpiCard("Dead Stock %", "dead_stock_percentage"),
                      _buildKpiCard("Supplier Performance", "supplier_performance"),
                    ],
                  ),
                ],
              ),
            ),

            // Performance Insights
            Row(
              spacing: spSm,
              children: [
                // Top Performing Items
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
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: successColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Top Performers",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        ...topPerformingItems.map((item) {
                          return Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(5),
                              borderRadius: BorderRadius.circular(radiusXs),
                              border: Border.all(
                                color: successColor.withAlpha(30),
                                width: 0.5,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${item["name"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "${item["sku"]} • Turnover: ${item["turnover_rate"]}x",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${item["performance_score"]}%",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),

                // Underperforming Items
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
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.warning,
                              color: dangerColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Needs Attention",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        ...underperformingItems.map((item) {
                          return Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(5),
                              borderRadius: BorderRadius.circular(radiusXs),
                              border: Border.all(
                                color: dangerColor.withAlpha(30),
                                width: 0.5,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${item["name"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "${item["sku"]} • ${item["days_on_hand"]} days on hand",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: dangerColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${item["performance_score"]}%",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: dangerColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Alerts and Notifications
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
                      Icon(
                        Icons.notifications,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Alerts & Notifications",
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
                          //navigateTo('alerts');
                        },
                      ),
                    ],
                  ),
                  ...alerts.map((alert) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getSeverityColor(alert["severity"]).withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: _getSeverityColor(alert["severity"]).withAlpha(30),
                          width: 0.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: _getSeverityColor(alert["severity"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              alert["severity"] == "high" ? Icons.error : 
                              alert["severity"] == "medium" ? Icons.warning : Icons.info,
                              color: _getSeverityColor(alert["severity"]),
                              size: 16,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: _getSeverityColor(alert["severity"]).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${alert["type"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: _getSeverityColor(alert["severity"]),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${alert["category"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "${alert["message"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${alert["timestamp"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
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

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Export Dashboard",
                    icon: Icons.download,
                    onPressed: () {
                      ss("KPI dashboard exported successfully");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Schedule Report",
                    icon: Icons.schedule,
                    onPressed: () {
                      ss("KPI report scheduled");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
