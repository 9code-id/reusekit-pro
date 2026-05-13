import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmCostAnalysisView extends StatefulWidget {
  const IwmCostAnalysisView({super.key});

  @override
  State<IwmCostAnalysisView> createState() => _IwmCostAnalysisViewState();
}

class _IwmCostAnalysisViewState extends State<IwmCostAnalysisView> {
  String selectedPeriod = "This Quarter";
  String selectedCostType = "All Costs";
  String selectedCategory = "All Categories";
  String selectedAnalysisType = "Cost Breakdown";
  bool loading = false;

  List<Map<String, dynamic>> periodItems = [
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "Last Quarter", "value": "Last Quarter"},
    {"label": "Last Year", "value": "Last Year"},
  ];

  List<Map<String, dynamic>> costTypeItems = [
    {"label": "All Costs", "value": "All Costs"},
    {"label": "Purchase Cost", "value": "Purchase Cost"},
    {"label": "Holding Cost", "value": "Holding Cost"},
    {"label": "Ordering Cost", "value": "Ordering Cost"},
    {"label": "Storage Cost", "value": "Storage Cost"},
    {"label": "Handling Cost", "value": "Handling Cost"},
  ];

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Categories", "value": "All Categories"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Raw Materials", "value": "Raw Materials"},
    {"label": "Components", "value": "Components"},
    {"label": "Tools", "value": "Tools"},
    {"label": "Supplies", "value": "Supplies"},
  ];

  List<Map<String, dynamic>> analysisTypeItems = [
    {"label": "Cost Breakdown", "value": "Cost Breakdown"},
    {"label": "Cost Trends", "value": "Cost Trends"},
    {"label": "Cost Per Unit", "value": "Cost Per Unit"},
    {"label": "Cost Variance", "value": "Cost Variance"},
  ];

  List<Map<String, dynamic>> costMetrics = [
    {
      "title": "Total Cost",
      "value": 2850000,
      "change": 8.5,
      "trend": "up",
      "icon": Icons.attach_money,
      "color": primaryColor,
    },
    {
      "title": "Purchase Cost",
      "value": 2100000,
      "change": 12.3,
      "trend": "up",
      "icon": Icons.shopping_cart,
      "color": successColor,
    },
    {
      "title": "Holding Cost",
      "value": 485000,
      "change": -5.2,
      "trend": "down",
      "icon": Icons.warehouse,
      "color": warningColor,
    },
    {
      "title": "Ordering Cost",
      "value": 265000,
      "change": 3.8,
      "trend": "up",
      "icon": Icons.description,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> costBreakdown = [
    {
      "category": "Purchase Cost",
      "amount": 2100000,
      "percentage": 73.7,
      "description": "Direct cost of goods purchased",
      "color": successColor,
    },
    {
      "category": "Holding Cost",
      "amount": 485000,
      "percentage": 17.0,
      "description": "Storage, insurance, depreciation",
      "color": warningColor,
    },
    {
      "category": "Ordering Cost",
      "amount": 265000,
      "percentage": 9.3,
      "description": "Processing orders, shipping",
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> itemCostAnalysis = [
    {
      "id": "ITM001",
      "name": "Laptop Dell XPS 13",
      "category": "Electronics",
      "totalCost": 252000,
      "purchaseCost": 216000,
      "holdingCost": 21600,
      "orderingCost": 14400,
      "unitCost": 1400.00,
      "quantity": 180,
      "costPercentage": 8.8,
    },
    {
      "id": "ITM002",
      "name": "Industrial Steel Beam",
      "category": "Raw Materials",
      "totalCost": 467500,
      "purchaseCost": 425000,
      "holdingCost": 25500,
      "orderingCost": 17000,
      "unitCost": 550.00,
      "quantity": 850,
      "costPercentage": 16.4,
    },
    {
      "id": "ITM003",
      "name": "iPhone 15 Pro",
      "category": "Electronics",
      "totalCost": 418000,
      "purchaseCost": 380000,
      "holdingCost": 22800,
      "orderingCost": 15200,
      "unitCost": 1100.00,
      "quantity": 380,
      "costPercentage": 14.7,
    },
    {
      "id": "ITM004",
      "name": "Safety Equipment Set",
      "category": "Safety",
      "totalCost": 15600,
      "purchaseCost": 12000,
      "holdingCost": 2400,
      "orderingCost": 1200,
      "unitCost": 130.00,
      "quantity": 120,
      "costPercentage": 0.5,
    },
    {
      "id": "ITM005",
      "name": "Office Supplies Bundle",
      "category": "Supplies",
      "totalCost": 28800,
      "purchaseCost": 24000,
      "holdingCost": 3600,
      "orderingCost": 1200,
      "unitCost": 12.00,
      "quantity": 2400,
      "costPercentage": 1.0,
    },
  ];

  List<Map<String, dynamic>> costTrends = [
    {"month": "Jan", "purchase": 180000, "holding": 35000, "ordering": 22000},
    {"month": "Feb", "purchase": 195000, "holding": 38000, "ordering": 24000},
    {"month": "Mar", "purchase": 210000, "holding": 42000, "ordering": 26000},
    {"month": "Apr", "purchase": 225000, "holding": 45000, "ordering": 28000},
    {"month": "May", "purchase": 240000, "holding": 48000, "ordering": 30000},
    {"month": "Jun", "purchase": 255000, "holding": 51000, "ordering": 32000},
  ];

  Widget _buildMetricCard(Map<String, dynamic> metric) {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (metric["color"] as Color).withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  metric["icon"],
                  color: metric["color"] as Color,
                  size: 24,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: metric["trend"] == "up" 
                      ? successColor.withAlpha(25)
                      : dangerColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      metric["trend"] == "up" 
                          ? Icons.trending_up 
                          : Icons.trending_down,
                      size: 12,
                      color: metric["trend"] == "up" 
                          ? successColor 
                          : dangerColor,
                    ),
                    SizedBox(width: 2),
                    Text(
                      "${(metric["change"] as num).abs().toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 10,
                        color: metric["trend"] == "up" 
                            ? successColor 
                            : dangerColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "\$${((metric["value"] as num).toDouble()).currency}",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${metric["title"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCostBreakdownCard(Map<String, dynamic> breakdown) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: breakdown["color"] as Color,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${breakdown["category"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${breakdown["description"]}",
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
                "\$${((breakdown["amount"] as num).toDouble()).currency}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: breakdown["color"] as Color,
                ),
              ),
              SizedBox(height: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: (breakdown["color"] as Color).withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${(breakdown["percentage"] as num).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 12,
                    color: breakdown["color"] as Color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemCostCard(Map<String, dynamic> item) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${item["id"]} • ${item["category"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${(item["costPercentage"] as num).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Total Cost: \$${((item["totalCost"] as num).toDouble()).currency}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "Unit Cost: \$${(item["unitCost"] as double).currency}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.all(0),
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(12),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Purchase Cost",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${((item["purchaseCost"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(12),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Holding Cost",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${((item["holdingCost"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(12),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ordering Cost",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${((item["orderingCost"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "View Detailed Analysis",
              size: bs.sm,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cost Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {},
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  // Filters
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Period",
                          items: periodItems,
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
                          label: "Cost Type",
                          items: costTypeItems,
                          value: selectedCostType,
                          onChanged: (value, label) {
                            selectedCostType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: categoryItems,
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
                          label: "Analysis Type",
                          items: analysisTypeItems,
                          value: selectedAnalysisType,
                          onChanged: (value, label) {
                            selectedAnalysisType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  // Cost Metrics
                  ResponsiveGridView(
                    padding: EdgeInsets.all(0),
                    minItemWidth: 200,
                    children: costMetrics.map((metric) => _buildMetricCard(metric)).toList(),
                  ),

                  if (selectedAnalysisType == "Cost Breakdown") ...[
                    // Cost Breakdown
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Cost Breakdown",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          ...costBreakdown.map((breakdown) => _buildCostBreakdownCard(breakdown)),
                        ],
                      ),
                    ),
                  ] else if (selectedAnalysisType == "Cost Per Unit") ...[
                    // Item Cost Analysis
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Item Cost Analysis",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          ...itemCostAnalysis.map((item) => _buildItemCostCard(item)),
                        ],
                      ),
                    ),
                  ] else if (selectedAnalysisType == "Cost Trends") ...[
                    // Cost Trends Chart Placeholder
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spLg),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Cost Trends Analysis",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spLg),
                          Icon(
                            Icons.show_chart,
                            size: 64,
                            color: primaryColor.withAlpha(100),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Interactive cost trends chart",
                            style: TextStyle(
                              fontSize: 16,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Showing monthly cost trends for purchase, holding, and ordering costs",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    // Cost Variance Analysis
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spLg),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.analytics,
                            size: 48,
                            color: warningColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Cost Variance Analysis",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Compare actual costs vs budgeted costs",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  // Analysis Summary
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.lightbulb, color: infoColor),
                            SizedBox(width: spSm),
                            Text(
                              "Cost Optimization Insights",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "• Purchase costs represent 73.7% of total costs - negotiate better vendor terms",
                          style: TextStyle(
                            fontSize: 13,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "• Holding costs decreased by 5.2% - efficient storage management",
                          style: TextStyle(
                            fontSize: 13,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "• Focus on reducing ordering costs through bulk purchasing",
                          style: TextStyle(
                            fontSize: 13,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
