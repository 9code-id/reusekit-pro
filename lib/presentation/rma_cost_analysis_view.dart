import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaCostAnalysisView extends StatefulWidget {
  const RmaCostAnalysisView({super.key});

  @override
  State<RmaCostAnalysisView> createState() => _RmaCostAnalysisViewState();
}

class _RmaCostAnalysisViewState extends State<RmaCostAnalysisView> {
  String selectedPeriod = "month";
  String selectedMetric = "total_cost";
  String selectedCategory = "all";

  List<Map<String, dynamic>> costData = [
    {
      "category": "meat",
      "totalCost": 15420.50,
      "quantity": 320.5,
      "unit": "kg",
      "avgPricePerUnit": 48.12,
      "percentageOfTotal": 32.5,
      "trend": "up",
      "trendPercentage": 8.3,
      "topItems": [
        {"name": "Beef Ribeye", "cost": 5200.00, "quantity": 80.0},
        {"name": "Salmon Fillet", "cost": 4500.00, "quantity": 100.0},
        {"name": "Chicken Breast", "cost": 3720.50, "quantity": 140.5},
      ],
    },
    {
      "category": "vegetables",
      "totalCost": 8750.25,
      "quantity": 1250.0,
      "unit": "kg",
      "avgPricePerUnit": 7.00,
      "percentageOfTotal": 18.4,
      "trend": "down",
      "trendPercentage": 3.2,
      "topItems": [
        {"name": "Organic Tomatoes", "cost": 2100.00, "quantity": 300.0},
        {"name": "Mixed Greens", "cost": 1875.25, "quantity": 375.0},
        {"name": "Bell Peppers", "cost": 1650.00, "quantity": 220.0},
      ],
    },
    {
      "category": "seafood",
      "totalCost": 12300.75,
      "quantity": 180.5,
      "unit": "kg",
      "avgPricePerUnit": 68.15,
      "percentageOfTotal": 25.9,
      "trend": "up",
      "trendPercentage": 12.5,
      "topItems": [
        {"name": "Fresh Lobster", "cost": 4500.00, "quantity": 30.0},
        {"name": "Tuna Steaks", "cost": 3800.75, "quantity": 50.5},
        {"name": "Shrimp", "cost": 2850.00, "quantity": 60.0},
      ],
    },
    {
      "category": "dairy",
      "totalCost": 4650.30,
      "quantity": 450.0,
      "unit": "units",
      "avgPricePerUnit": 10.33,
      "percentageOfTotal": 9.8,
      "trend": "stable",
      "trendPercentage": 1.1,
      "topItems": [
        {"name": "Heavy Cream", "cost": 1540.10, "quantity": 180.0},
        {"name": "Cheese Selection", "cost": 1320.20, "quantity": 88.0},
        {"name": "Butter", "cost": 975.00, "quantity": 130.0},
      ],
    },
    {
      "category": "beverages",
      "totalCost": 6420.40,
      "quantity": 800.0,
      "unit": "units",
      "avgPricePerUnit": 8.03,
      "percentageOfTotal": 13.5,
      "trend": "up",
      "trendPercentage": 5.7,
      "topItems": [
        {"name": "Wine Selection", "cost": 3200.00, "quantity": 128.0},
        {"name": "Craft Beer", "cost": 1680.40, "quantity": 280.0},
        {"name": "Premium Spirits", "cost": 1540.00, "quantity": 77.0},
      ],
    },
  ];

  List<Map<String, dynamic>> monthlyTrends = [
    {"month": "Jan", "totalCost": 42500.0, "foodCost": 38250.0, "laborCost": 4250.0},
    {"month": "Feb", "totalCost": 44200.0, "foodCost": 39780.0, "laborCost": 4420.0},
    {"month": "Mar", "totalCost": 47541.2, "foodCost": 42787.08, "laborCost": 4754.12},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "Last Quarter", "value": "quarter"},
    {"label": "This Year", "value": "year"},
  ];

  List<Map<String, dynamic>> metricOptions = [
    {"label": "Total Cost", "value": "total_cost"},
    {"label": "Cost Per Unit", "value": "cost_per_unit"},
    {"label": "Percentage Share", "value": "percentage"},
    {"label": "Trend Analysis", "value": "trend"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Meat", "value": "meat"},
    {"label": "Seafood", "value": "seafood"},
    {"label": "Vegetables", "value": "vegetables"},
    {"label": "Dairy", "value": "dairy"},
    {"label": "Beverages", "value": "beverages"},
  ];

  List<Map<String, dynamic>> get filteredData {
    if (selectedCategory == "all") return costData;
    return costData.where((item) => item["category"] == selectedCategory).toList();
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
                Icons.analytics,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Cost Analysis",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Export",
                icon: Icons.file_download,
                size: bs.sm,
                onPressed: () {
                  //exportCostReport()
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Time Period",
                  items: periodOptions,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Metric",
                  items: metricOptions,
                  value: selectedMetric,
                  onChanged: (value, label) {
                    selectedMetric = value;
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCostOverview() {
    final totalCost = costData.fold(0.0, (sum, item) => sum + (item["totalCost"] as double));
    final avgCostPerCategory = totalCost / costData.length;
    final highestCostCategory = costData.reduce((a, b) => 
        (a["totalCost"] as double) > (b["totalCost"] as double) ? a : b);
    final foodCostPercentage = 72.5; // Example percentage

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
            "Cost Overview",
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
              _buildOverviewCard(
                "Total Cost",
                "\$${totalCost.currency}",
                Icons.attach_money,
                primaryColor,
                "This month",
              ),
              _buildOverviewCard(
                "Food Cost %",
                "${foodCostPercentage.toStringAsFixed(1)}%",
                Icons.restaurant,
                warningColor,
                "Of total revenue",
              ),
              _buildOverviewCard(
                "Highest Category",
                "${highestCostCategory["category"]}".toUpperCase(),
                Icons.trending_up,
                dangerColor,
                "\$${(highestCostCategory["totalCost"] as double).currency}",
              ),
              _buildOverviewCard(
                "Average/Category",
                "\$${avgCostPerCategory.currency}",
                Icons.calculate,
                infoColor,
                "Across all categories",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color, String subtitle) {
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
              fontWeight: FontWeight.bold,
              color: disabledBoldColor,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10,
              color: disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCostBreakdown() {
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
            "Cost Breakdown by Category",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...filteredData.map((category) => _buildCategoryCard(category)).toList(),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    final trendColor = _getTrendColor(category["trend"]);
    final trendIcon = _getTrendIcon(category["trend"]);
    final categoryColor = _getCategoryColor(category["category"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: categoryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: categoryColor,
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
                          "${category["category"]}".toUpperCase(),
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
                            color: trendColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                trendIcon,
                                color: trendColor,
                                size: 12,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${category["trendPercentage"]}%",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: trendColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${(category["percentageOfTotal"] as double).toStringAsFixed(1)}% of total costs",
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
                    "\$${(category["totalCost"] as double).currency}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: categoryColor,
                    ),
                  ),
                  Text(
                    "\$${(category["avgPricePerUnit"] as double).toStringAsFixed(2)}/${category["unit"]}",
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
                  "Top Items:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                ...(category["topItems"] as List<Map<String, dynamic>>).map((item) => 
                  Padding(
                    padding: EdgeInsets.only(bottom: spXs),
                    child: Row(
                      children: [
                        Text(
                          "• ${item["name"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\$${(item["cost"] as double).currency}",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: categoryColor,
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
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('CategoryDetails')
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Price History",
                size: bs.sm,
                onPressed: () {
                  //navigateTo('PriceHistory')
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrendAnalysis() {
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
            "Monthly Trend Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...monthlyTrends.map((month) => _buildTrendCard(month)).toList(),
        ],
      ),
    );
  }

  Widget _buildTrendCard(Map<String, dynamic> month) {
    final foodCostPercentage = ((month["foodCost"] as double) / (month["totalCost"] as double) * 100);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "${month["month"]} 2024",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "\$${(month["totalCost"] as double).currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
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
                      "Food Cost",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(month["foodCost"] as double).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
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
                      "Labor Cost",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(month["laborCost"] as double).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
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
                      "Food Cost %",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${foodCostPercentage.toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: _getFoodCostColor(foodCostPercentage),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getTrendColor(String trend) {
    switch (trend) {
      case "up":
        return dangerColor;
      case "down":
        return successColor;
      case "stable":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTrendIcon(String trend) {
    switch (trend) {
      case "up":
        return Icons.trending_up;
      case "down":
        return Icons.trending_down;
      case "stable":
        return Icons.trending_flat;
      default:
        return Icons.help;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "meat":
        return dangerColor;
      case "seafood":
        return Colors.blue;
      case "vegetables":
        return successColor;
      case "dairy":
        return Colors.orange;
      case "beverages":
        return Colors.purple;
      default:
        return primaryColor;
    }
  }

  Color _getFoodCostColor(double percentage) {
    if (percentage > 35) return dangerColor;
    if (percentage > 30) return warningColor;
    return successColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cost Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.compare),
            onPressed: () {
              //navigateTo('CostComparison')
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              //navigateTo('AnalysisSettings')
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
            _buildCostOverview(),
            _buildCostBreakdown(),
            _buildTrendAnalysis(),
          ],
        ),
      ),
    );
  }
}
