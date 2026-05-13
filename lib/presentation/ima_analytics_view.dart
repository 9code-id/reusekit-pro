import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaAnalyticsView extends StatefulWidget {
  const ImaAnalyticsView({super.key});

  @override
  State<ImaAnalyticsView> createState() => _ImaAnalyticsViewState();
}

class _ImaAnalyticsViewState extends State<ImaAnalyticsView> {
  int currentTab = 0;
  String selectedTimeRange = "last_30_days";
  String selectedCategory = "all";
  String selectedLocation = "all";
  bool showPredictions = true;
  
  List<Map<String, dynamic>> demandAnalysis = [
    {
      "item_name": "Premium Coffee Beans",
      "sku": "PCB-001",
      "current_demand": 850,
      "predicted_demand": 920,
      "demand_trend": "increasing",
      "seasonality_factor": 1.08,
      "growth_rate": 8.2,
      "confidence_level": 89,
    },
    {
      "item_name": "Organic Tea Leaves", 
      "sku": "OTL-002",
      "current_demand": 420,
      "predicted_demand": 380,
      "demand_trend": "decreasing",
      "seasonality_factor": 0.91,
      "growth_rate": -9.5,
      "confidence_level": 92,
    },
    {
      "item_name": "Paper Cups",
      "sku": "PC-003",
      "current_demand": 2500,
      "predicted_demand": 2650,
      "demand_trend": "stable",
      "seasonality_factor": 1.06,
      "growth_rate": 6.0,
      "confidence_level": 95,
    },
    {
      "item_name": "Sugar Packets",
      "sku": "SP-004", 
      "current_demand": 1800,
      "predicted_demand": 1950,
      "demand_trend": "increasing",
      "seasonality_factor": 1.08,
      "growth_rate": 8.3,
      "confidence_level": 87,
    },
  ];

  List<Map<String, dynamic>> stockOptimization = [
    {
      "item_name": "Premium Coffee Beans",
      "sku": "PCB-001",
      "current_stock": 450,
      "optimal_stock": 520,  
      "reorder_point": 380,
      "safety_stock": 120,
      "optimization_opportunity": "Increase stock by 15.6%",
      "potential_savings": 280.0,
      "risk_level": "Low",
    },
    {
      "item_name": "Organic Tea Leaves",
      "sku": "OTL-002",
      "current_stock": 280,
      "optimal_stock": 220,
      "reorder_point": 160,
      "safety_stock": 80,
      "optimization_opportunity": "Reduce stock by 21.4%",
      "potential_savings": 540.0,
      "risk_level": "Medium",
    },
    {
      "item_name": "Paper Cups",
      "sku": "PC-003",
      "current_stock": 1200,
      "optimal_stock": 1350,
      "reorder_point": 900,
      "safety_stock": 300,
      "optimization_opportunity": "Increase stock by 12.5%",
      "potential_savings": 150.0,
      "risk_level": "Low",
    },
    {
      "item_name": "Specialty Syrups",
      "sku": "SS-007",
      "current_stock": 180,
      "optimal_stock": 90,
      "reorder_point": 60,
      "safety_stock": 30,
      "optimization_opportunity": "Reduce stock by 50%",
      "potential_savings": 1260.0,
      "risk_level": "High",
    },
  ];

  List<Map<String, dynamic>> costAnalysis = [
    {
      "category": "Carrying Costs",
      "current_cost": 5840.0,
      "optimized_cost": 4920.0,
      "savings_potential": 920.0,
      "percentage_savings": 15.8,
      "breakdown": {
        "Storage": 2340.0,
        "Insurance": 1280.0,
        "Handling": 980.0,
        "Obsolescence": 1240.0,
      }
    },
    {
      "category": "Ordering Costs",
      "current_cost": 2180.0,
      "optimized_cost": 1850.0,
      "savings_potential": 330.0,
      "percentage_savings": 15.1,  
      "breakdown": {
        "Processing": 880.0,
        "Transportation": 720.0,
        "Receiving": 580.0,
      }
    },
    {
      "category": "Stockout Costs",
      "current_cost": 1560.0,
      "optimized_cost": 690.0,
      "savings_potential": 870.0,
      "percentage_savings": 55.8,
      "breakdown": {
        "Lost Sales": 920.0,
        "Customer Dissatisfaction": 420.0,
        "Emergency Orders": 220.0,
      }
    },
  ];

  List<Map<String, dynamic>> performanceMetrics = [
    {
      "metric": "Inventory Turnover Rate",
      "current": 8.5,
      "target": 12.0,
      "industry_benchmark": 10.2,
      "improvement_potential": 41.2,
      "unit": "times/year"
    },
    {
      "metric": "Fill Rate",
      "current": 94.2,
      "target": 98.0,
      "industry_benchmark": 96.5,
      "improvement_potential": 4.0,
      "unit": "%"
    },
    {
      "metric": "Days Sales Inventory",
      "current": 43.5,
      "target": 30.0,
      "industry_benchmark": 36.0,
      "improvement_potential": -31.0,
      "unit": "days"
    },
    {
      "metric": "Inventory Accuracy",
      "current": 92.8,
      "target": 98.5,
      "industry_benchmark": 95.2,
      "improvement_potential": 6.1,
      "unit": "%"
    },
  ];

  Color _getTrendColor(String trend) {
    switch (trend.toLowerCase()) {
      case 'increasing':
        return successColor;
      case 'decreasing':
        return dangerColor;
      case 'stable':
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getRiskColor(String risk) {
    switch (risk.toLowerCase()) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildDemandAnalysisTab() {
    return Column(
      spacing: spSm,
      children: [
        // Demand Forecast Cards
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: demandAnalysis.map((item) {
            return Container(
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
                      Expanded(
                        child: Text(
                          "${item["item_name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getTrendColor(item["demand_trend"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${item["demand_trend"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: _getTrendColor(item["demand_trend"]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${item["sku"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                  Divider(height: spSm),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Current Demand",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${item["current_demand"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Predicted",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${item["predicted_demand"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _getTrendColor(item["demand_trend"]),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Text(
                        "Growth: ${item["growth_rate"] >= 0 ? '+' : ''}${(item["growth_rate"] as double).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 11,
                          color: item["growth_rate"] >= 0 ? successColor : dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Confidence: ${item["confidence_level"]}%",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStockOptimizationTab() {
    return Column(
      spacing: spSm,
      children: [
        // Stock Optimization Table
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
                "Stock Optimization Recommendations",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: WidgetStateProperty.all(primaryColor.withAlpha(10)),
                  columns: [
                    DataColumn(
                      label: Text(
                        "Item",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Current Stock",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Optimal Stock",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Recommendation",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Potential Savings",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Risk Level",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                  rows: stockOptimization.map((item) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${item["item_name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                "${item["sku"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Text(
                            "${item["current_stock"]}",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        DataCell(
                          Text(
                            "${item["optimal_stock"]}",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            width: 150,
                            child: Text(
                              "${item["optimization_opportunity"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            "\$${(item["potential_savings"] as double).currency}",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getRiskColor(item["risk_level"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${item["risk_level"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getRiskColor(item["risk_level"]),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCostAnalysisTab() {
    return Column(
      spacing: spSm,
      children: [
        // Cost Breakdown Cards
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: costAnalysis.map((category) {
            return Container(
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
                    "${category["category"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Current Cost",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${(category["current_cost"] as double).currency}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Optimized",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${(category["optimized_cost"] as double).currency}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.savings,
                          color: successColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Save \$${(category["savings_potential"] as double).currency} (${(category["percentage_savings"] as double).toStringAsFixed(1)}%)",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: spSm),
                  Text(
                    "Cost Breakdown:",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  ...(category["breakdown"] as Map<String, dynamic>).entries.map((entry) {
                    return Row(
                      children: [
                        Text(
                          "${entry.key}:",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\$${(entry.value as double).currency}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPerformanceTab() {
    return Column(
      spacing: spSm,
      children: [
        // Performance Metrics Cards
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: performanceMetrics.map((metric) {
            final isImprovement = (metric["improvement_potential"] as double) > 0;
            return Container(
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
                    "${metric["metric"]}",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Current",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${metric["current"]}${metric["unit"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Target",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${metric["target"]}${metric["unit"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Industry: ${metric["industry_benchmark"]}${metric["unit"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: isImprovement ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${isImprovement ? '+' : ''}${(metric["improvement_potential"] as double).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: isImprovement ? successColor : dangerColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Analytics",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Demand", icon: Icon(Icons.trending_up)),
        Tab(text: "Stock", icon: Icon(Icons.inventory)),
        Tab(text: "Costs", icon: Icon(Icons.monetization_on)),
        Tab(text: "Performance", icon: Icon(Icons.speed)),
      ],
      tabChildren: [
        SingleChildScrollView(
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
                      "Analysis Filters",
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
                            label: "Time Range",
                            items: [
                              {"label": "Last 7 Days", "value": "last_7_days"},
                              {"label": "Last 30 Days", "value": "last_30_days"},
                              {"label": "Last 90 Days", "value": "last_90_days"},
                              {"label": "Last Year", "value": "last_year"},
                            ],
                            value: selectedTimeRange,
                            onChanged: (value, label) {
                              selectedTimeRange = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QDropdownField(
                            label: "Category",
                            items: [
                              {"label": "All Categories", "value": "all"},
                              {"label": "Raw Materials", "value": "raw_materials"},
                              {"label": "Packaging", "value": "packaging"},
                              {"label": "Supplies", "value": "supplies"},
                            ],
                            value: selectedCategory,
                            onChanged: (value, label) {
                              selectedCategory = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _buildDemandAnalysisTab(),
            ],
          ),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildStockOptimizationTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildCostAnalysisTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildPerformanceTab(),
        ),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }
}
