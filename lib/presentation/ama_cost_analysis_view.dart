import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaCostAnalysisView extends StatefulWidget {
  const AmaCostAnalysisView({super.key});

  @override
  State<AmaCostAnalysisView> createState() => _AmaCostAnalysisViewState();
}

class _AmaCostAnalysisViewState extends State<AmaCostAnalysisView> {
  String selectedCrop = "Corn";
  String selectedPeriod = "This Year";
  String selectedAnalysisType = "Cost Per Acre";
  
  List<Map<String, dynamic>> cropOptions = [
    {"label": "Corn", "value": "Corn"},
    {"label": "Wheat", "value": "Wheat"},
    {"label": "Rice", "value": "Rice"},
    {"label": "Soybeans", "value": "Soybeans"},
    {"label": "Tomatoes", "value": "Tomatoes"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Last Year", "value": "Last Year"},
    {"label": "Compare Years", "value": "Compare Years"},
  ];

  List<Map<String, dynamic>> analysisOptions = [
    {"label": "Cost Per Acre", "value": "Cost Per Acre"},
    {"label": "Cost Per Unit", "value": "Cost Per Unit"},
    {"label": "Total Cost Analysis", "value": "Total Cost Analysis"},
    {"label": "Cost Trends", "value": "Cost Trends"},
  ];

  List<Map<String, dynamic>> costBreakdown = [
    {
      "category": "Seeds",
      "amount": 15000.0,
      "percentage": 18.5,
      "perAcre": 150.0,
      "perUnit": 12.50,
      "color": Colors.green,
      "trend": "up",
      "change": 5.2,
    },
    {
      "category": "Fertilizer",
      "amount": 21200.0,
      "percentage": 26.1,
      "perAcre": 212.0,
      "perUnit": 17.67,
      "color": Colors.brown,
      "trend": "down",
      "change": -2.8,
    },
    {
      "category": "Pesticides",
      "amount": 9800.0,
      "percentage": 12.1,
      "perAcre": 98.0,
      "perUnit": 8.17,
      "color": Colors.red,
      "trend": "up",
      "change": 8.5,
    },
    {
      "category": "Labor",
      "amount": 16500.0,
      "percentage": 20.3,
      "perAcre": 165.0,
      "perUnit": 13.75,
      "color": Colors.blue,
      "trend": "up",
      "change": 12.3,
    },
    {
      "category": "Equipment",
      "amount": 8900.0,
      "percentage": 11.0,
      "perAcre": 89.0,
      "perUnit": 7.42,
      "color": Colors.purple,
      "trend": "stable",
      "change": 0.5,
    },
    {
      "category": "Fuel",
      "amount": 5200.0,
      "percentage": 6.4,
      "perAcre": 52.0,
      "perUnit": 4.33,
      "color": Colors.orange,
      "trend": "up",
      "change": 15.2,
    },
    {
      "category": "Other",
      "amount": 4500.0,
      "percentage": 5.6,
      "perAcre": 45.0,
      "perUnit": 3.75,
      "color": Colors.grey,
      "trend": "down",
      "change": -3.1,
    },
  ];

  List<Map<String, dynamic>> monthlyTrends = [
    {"month": "Jan", "cost": 8500.0, "budget": 9000.0},
    {"month": "Feb", "cost": 7200.0, "budget": 8500.0},
    {"month": "Mar", "cost": 12500.0, "budget": 12000.0},
    {"month": "Apr", "cost": 15800.0, "budget": 15000.0},
    {"month": "May", "cost": 11200.0, "budget": 11500.0},
    {"month": "Jun", "cost": 9800.0, "budget": 10000.0},
  ];

  List<Map<String, dynamic>> benchmarks = [
    {
      "category": "Industry Average",
      "costPerAcre": 890.0,
      "comparison": "below",
      "difference": 45.0,
    },
    {
      "category": "Regional Average",
      "costPerAcre": 820.0,
      "comparison": "above",
      "difference": 115.0,
    },
    {
      "category": "Top Performers",
      "costPerAcre": 750.0,
      "comparison": "above",
      "difference": 185.0,
    },
  ];

  double get totalCost => costBreakdown.fold(0.0, (sum, item) => sum + (item["amount"] as double));
  double get averageCostPerAcre => 935.0;
  double get averageCostPerUnit => 77.92;
  double get farmSize => 100.0;
  double get totalYield => 1200.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cost Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              //navigateTo('AmaAdvancedAnalyticsView')
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Cost analysis report exported");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Analysis Overview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(128)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Cost Analysis Dashboard",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.trending_up,
                        color: Colors.white,
                        size: 28,
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Comprehensive cost analysis for your farm operations",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(204),
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Cost",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(204),
                              ),
                            ),
                            Text(
                              "\$${totalCost.currency}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
                              "Cost/Acre",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(204),
                              ),
                            ),
                            Text(
                              "\$${averageCostPerAcre.currency}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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

            // Filter Options
            Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Crop",
                        items: cropOptions,
                        value: selectedCrop,
                        onChanged: (value, label) {
                          selectedCrop = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Period",
                        items: periodOptions,
                        value: selectedPeriod,
                        onChanged: (value, label) {
                          selectedPeriod = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QDropdownField(
                  label: "Analysis Type",
                  items: analysisOptions,
                  value: selectedAnalysisType,
                  onChanged: (value, label) {
                    selectedAnalysisType = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            // Key Metrics
            ResponsiveGridView(
              padding: EdgeInsets.all(spSm),
              minItemWidth: 200,
              children: [
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
                      Row(
                        children: [
                          Icon(Icons.landscape, color: primaryColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Cost Per Acre",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "\$${averageCostPerAcre.currency}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(Icons.trending_up, color: dangerColor, size: 14),
                          SizedBox(width: 4),
                          Text(
                            "+8.5% vs last year",
                            style: TextStyle(
                              fontSize: 12,
                              color: dangerColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
                      Row(
                        children: [
                          Icon(Icons.inventory_2, color: primaryColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Cost Per Unit",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "\$${averageCostPerUnit.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(Icons.trending_down, color: successColor, size: 14),
                          SizedBox(width: 4),
                          Text(
                            "-2.1% vs last year",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
                      Row(
                        children: [
                          Icon(Icons.calculate, color: primaryColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Total Yield",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${totalYield.toInt()} units",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "From ${farmSize.toInt()} acres",
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

            // Cost Breakdown
            Text(
              "Cost Breakdown by Category",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: costBreakdown.map((item) {
                  IconData trendIcon = item["trend"] == "up" 
                      ? Icons.trending_up 
                      : item["trend"] == "down" 
                          ? Icons.trending_down 
                          : Icons.trending_flat;
                  
                  Color trendColor = item["trend"] == "up" 
                      ? dangerColor 
                      : item["trend"] == "down" 
                          ? successColor 
                          : disabledBoldColor;

                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: (item["color"] as Color).withAlpha(51),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                Icons.category,
                                color: item["color"] as Color,
                                size: 16,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${item["category"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Container(
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: disabledColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: ((item["percentage"] as double) / 100).clamp(0.0, 1.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: item["color"] as Color,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                      ),
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
                                  "\$${((item["amount"] as double)).currency}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${(item["percentage"] as double).toStringAsFixed(1)}%",
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
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    "Per Acre: \$${((item["perAcre"] as double)).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "Per Unit: \$${((item["perUnit"] as double)).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Icon(trendIcon, color: trendColor, size: 14),
                                SizedBox(width: 4),
                                Text(
                                  "${(item["change"] as double) >= 0 ? '+' : ''}${(item["change"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: trendColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            // Benchmarking
            Text(
              "Industry Benchmarks",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
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
                      Text(
                        "Your Cost Per Acre: ",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "\$${averageCostPerAcre.currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  ...benchmarks.map((benchmark) {
                    bool isAbove = benchmark["comparison"] == "above";
                    Color comparisonColor = isAbove ? dangerColor : successColor;
                    IconData comparisonIcon = isAbove ? Icons.arrow_upward : Icons.arrow_downward;
                    
                    return Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${benchmark["category"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          "\$${((benchmark["costPerAcre"] as double)).currency}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Row(
                          children: [
                            Icon(comparisonIcon, color: comparisonColor, size: 14),
                            SizedBox(width: 4),
                            Text(
                              "\$${((benchmark["difference"] as double)).toStringAsFixed(0)}",
                              style: TextStyle(
                                fontSize: 12,
                                color: comparisonColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),

            // Monthly Trends
            Text(
              "Monthly Cost Trends",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 16,
                            height: 4,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Actual Cost",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 16,
                            height: 4,
                            decoration: BoxDecoration(
                              color: warningColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Budget",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  ...monthlyTrends.map((trend) {
                    double costPercentage = ((trend["cost"] as double) / 20000).clamp(0.0, 1.0);
                    double budgetPercentage = ((trend["budget"] as double) / 20000).clamp(0.0, 1.0);
                    bool overBudget = (trend["cost"] as double) > (trend["budget"] as double);

                    return Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              child: Text(
                                "${trend["month"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  // Actual Cost Bar
                                  Container(
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: disabledColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: costPercentage,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: overBudget ? dangerColor : primaryColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  // Budget Bar
                                  Container(
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: disabledColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: budgetPercentage,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: warningColor.withAlpha(128),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                      ),
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
                                  "\$${((trend["cost"] as double) / 1000).toStringAsFixed(1)}K",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: overBudget ? dangerColor : primaryColor,
                                  ),
                                ),
                                Text(
                                  "\$${((trend["budget"] as double) / 1000).toStringAsFixed(1)}K",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (monthlyTrends.indexOf(trend) < monthlyTrends.length - 1)
                          SizedBox(height: spSm),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
