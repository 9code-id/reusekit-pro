import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmTurnoverAnalysisView extends StatefulWidget {
  const IwmTurnoverAnalysisView({super.key});

  @override
  State<IwmTurnoverAnalysisView> createState() => _IwmTurnoverAnalysisViewState();
}

class _IwmTurnoverAnalysisViewState extends State<IwmTurnoverAnalysisView> {
  String selectedPeriod = "Last 12 Months";
  String selectedCategory = "All Categories";
  String selectedAnalysisType = "By Item";
  bool loading = false;

  List<Map<String, dynamic>> periodItems = [
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "Last 6 Months", "value": "Last 6 Months"},
    {"label": "Last 12 Months", "value": "Last 12 Months"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Last Year", "value": "Last Year"},
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
    {"label": "By Item", "value": "By Item"},
    {"label": "By Category", "value": "By Category"},
    {"label": "By Vendor", "value": "By Vendor"},
  ];

  List<Map<String, dynamic>> turnoverMetrics = [
    {
      "title": "Average Turnover Rate",
      "value": 6.8,
      "unit": "times/year",
      "change": 12.5,
      "trend": "up",
      "icon": Icons.refresh,
      "color": primaryColor,
    },
    {
      "title": "Inventory Days",
      "value": 54,
      "unit": "days",
      "change": -8.3,
      "trend": "down",
      "icon": Icons.calendar_today,
      "color": successColor,
    },
    {
      "title": "Fast Moving Items",
      "value": 156,
      "unit": "items",
      "change": 15.2,
      "trend": "up",
      "icon": Icons.trending_up,
      "color": warningColor,
    },
    {
      "title": "Slow Moving Items",
      "value": 23,
      "unit": "items",
      "change": -18.5,
      "trend": "down",
      "icon": Icons.trending_down,
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> itemTurnoverData = [
    {
      "id": "ITM001",
      "name": "Laptop Dell XPS 13",
      "category": "Electronics",
      "avgStock": 25,
      "totalSold": 180,
      "turnoverRate": 7.2,
      "daysInInventory": 51,
      "costOfGoodsSold": 216000,
      "avgInventoryValue": 30000,
      "classification": "Fast Moving",
    },
    {
      "id": "ITM002",
      "name": "A4 Paper Ream",
      "category": "Supplies",
      "avgStock": 500,
      "totalSold": 2400,
      "turnoverRate": 4.8,
      "daysInInventory": 76,
      "costOfGoodsSold": 36000,
      "avgInventoryValue": 7500,
      "classification": "Medium Moving",
    },
    {
      "id": "ITM003",
      "name": "Industrial Grade Steel",
      "category": "Raw Materials",
      "avgStock": 100,
      "totalSold": 850,
      "turnoverRate": 8.5,
      "daysInInventory": 43,
      "costOfGoodsSold": 425000,
      "avgInventoryValue": 50000,
      "classification": "Fast Moving",
    },
    {
      "id": "ITM004",
      "name": "Vintage Office Chair",
      "category": "Furniture",
      "avgStock": 15,
      "totalSold": 18,
      "turnoverRate": 1.2,
      "daysInInventory": 304,
      "costOfGoodsSold": 5400,
      "avgInventoryValue": 4500,
      "classification": "Slow Moving",
    },
    {
      "id": "ITM005",
      "name": "USB Type-C Cable",
      "category": "Electronics",
      "avgStock": 200,
      "totalSold": 1560,
      "turnoverRate": 7.8,
      "daysInInventory": 47,
      "costOfGoodsSold": 23400,
      "avgInventoryValue": 3000,
      "classification": "Fast Moving",
    },
    {
      "id": "ITM006",
      "name": "Safety Helmet Premium",
      "category": "Safety",
      "avgStock": 50,
      "totalSold": 120,
      "turnoverRate": 2.4,
      "daysInInventory": 152,
      "costOfGoodsSold": 12000,
      "avgInventoryValue": 5000,
      "classification": "Slow Moving",
    },
  ];

  List<Map<String, dynamic>> categoryTurnoverData = [
    {
      "category": "Electronics",
      "totalItems": 234,
      "avgTurnoverRate": 6.8,
      "totalValue": 850000,
      "fastMoving": 89,
      "slowMoving": 12,
    },
    {
      "category": "Raw Materials",
      "totalItems": 156,
      "avgTurnoverRate": 5.2,
      "totalValue": 650000,
      "fastMoving": 67,
      "slowMoving": 8,
    },
    {
      "category": "Components",
      "totalItems": 189,
      "avgTurnoverRate": 7.1,
      "totalValue": 420000,
      "fastMoving": 78,
      "slowMoving": 5,
    },
    {
      "category": "Tools",
      "totalItems": 98,
      "avgTurnoverRate": 4.5,
      "totalValue": 280000,
      "fastMoving": 34,
      "slowMoving": 15,
    },
  ];

  Color _getClassificationColor(String classification) {
    switch (classification) {
      case "Fast Moving":
        return successColor;
      case "Medium Moving":
        return warningColor;
      case "Slow Moving":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

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
            "${metric["value"]} ${metric["unit"]}",
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

  Widget _buildItemCard(Map<String, dynamic> item) {
    Color classificationColor = _getClassificationColor(item["classification"]);

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
            color: classificationColor,
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
                  color: classificationColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${item["classification"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: classificationColor,
                    fontWeight: FontWeight.w600,
                  ),
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
                  color: primaryColor.withAlpha(12),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Turnover Rate",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${item["turnoverRate"]} times/year",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
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
                      "Days in Inventory",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${item["daysInInventory"]} days",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
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
                      "Avg Stock: ${item["avgStock"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Total Sold: ${item["totalSold"]}",
                      style: TextStyle(
                        fontSize: 13,
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
                    "COGS: \$${((item["costOfGoodsSold"] as num).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: successColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Avg Value: \$${((item["avgInventoryValue"] as num).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "View Details",
              size: bs.sm,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
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
                child: Text(
                  "${category["category"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "${category["totalItems"]} items",
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
                  color: primaryColor.withAlpha(12),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Text(
                      "${category["avgTurnoverRate"]}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Avg Turnover",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(12),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Text(
                      "\$${((category["totalValue"] as num).toDouble() / 1000).toStringAsFixed(0)}K",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Total Value",
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
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(12),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${category["fastMoving"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Fast Moving",
                        style: TextStyle(
                          fontSize: 11,
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
                    color: dangerColor.withAlpha(12),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${category["slowMoving"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Slow Moving",
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Turnover Analysis"),
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
                          label: "Category",
                          items: categoryItems,
                          value: selectedCategory,
                          onChanged: (value, label) {
                            selectedCategory = value;
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

                  // Metrics Cards
                  ResponsiveGridView(
                    padding: EdgeInsets.all(0),
                    minItemWidth: 200,
                    children: turnoverMetrics.map((metric) => _buildMetricCard(metric)).toList(),
                  ),

                  // Analysis Results
                  if (selectedAnalysisType == "By Item") 
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Item Turnover Analysis",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          ...itemTurnoverData.map((item) => _buildItemCard(item)),
                        ],
                      ),
                    )
                  else if (selectedAnalysisType == "By Category")
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Category Turnover Analysis",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          ...categoryTurnoverData.map((category) => _buildCategoryCard(category)),
                        ],
                      ),
                    )
                  else
                    Container(
                      padding: EdgeInsets.all(spLg),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.analytics,
                            size: 48,
                            color: infoColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Vendor Turnover Analysis",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Coming soon - Detailed vendor performance analysis",
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
              ),
            ),
    );
  }
}
