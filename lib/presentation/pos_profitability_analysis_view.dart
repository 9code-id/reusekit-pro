import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosProfitabilityAnalysisView extends StatefulWidget {
  const PosProfitabilityAnalysisView({super.key});

  @override
  State<PosProfitabilityAnalysisView> createState() => _PosProfitabilityAnalysisViewState();
}

class _PosProfitabilityAnalysisViewState extends State<PosProfitabilityAnalysisView> {
  bool loading = false;
  String selectedPeriod = "This Month";
  String selectedCategory = "All Categories";
  String selectedAnalysisType = "Product Analysis";

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "All Categories"},
    {"label": "Food & Beverages", "value": "Food & Beverages"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Clothing", "value": "Clothing"},
    {"label": "Health & Beauty", "value": "Health & Beauty"},
    {"label": "Home & Garden", "value": "Home & Garden"},
  ];

  List<Map<String, dynamic>> analysisTypeOptions = [
    {"label": "Product Analysis", "value": "Product Analysis"},
    {"label": "Category Analysis", "value": "Category Analysis"},
    {"label": "Time-based Analysis", "value": "Time-based Analysis"},
    {"label": "Customer Segment Analysis", "value": "Customer Segment Analysis"},
  ];

  List<Map<String, dynamic>> profitabilityData = [
    {
      "product": "iPhone 15 Pro",
      "category": "Electronics",
      "revenue": 12500.00,
      "cost": 8750.00,
      "grossProfit": 3750.00,
      "grossMargin": 30.0,
      "unitsSold": 25,
      "profitPerUnit": 150.00,
    },
    {
      "product": "Samsung Galaxy S24",
      "category": "Electronics",
      "revenue": 8900.00,
      "cost": 6230.00,
      "grossProfit": 2670.00,
      "grossMargin": 30.0,
      "unitsSold": 18,
      "profitPerUnit": 148.33,
    },
    {
      "product": "Premium Coffee Beans",
      "category": "Food & Beverages",
      "revenue": 2250.00,
      "cost": 1125.00,
      "grossProfit": 1125.00,
      "grossMargin": 50.0,
      "unitsSold": 150,
      "profitPerUnit": 7.50,
    },
    {
      "product": "Designer Handbag",
      "category": "Clothing",
      "revenue": 3200.00,
      "cost": 1600.00,
      "grossProfit": 1600.00,
      "grossMargin": 50.0,
      "unitsSold": 8,
      "profitPerUnit": 200.00,
    },
    {
      "product": "Skincare Set",
      "category": "Health & Beauty",
      "revenue": 1750.00,
      "cost": 875.00,
      "grossProfit": 875.00,
      "grossMargin": 50.0,
      "unitsSold": 35,
      "profitPerUnit": 25.00,
    },
  ];

  List<Map<String, dynamic>> categoryProfitability = [
    {
      "category": "Electronics",
      "revenue": 45250.00,
      "cost": 31675.00,
      "grossProfit": 13575.00,
      "grossMargin": 30.0,
      "profitGrowth": 15.2,
    },
    {
      "category": "Food & Beverages",
      "revenue": 28900.00,
      "cost": 14450.00,
      "grossProfit": 14450.00,
      "grossMargin": 50.0,
      "profitGrowth": 8.7,
    },
    {
      "category": "Clothing",
      "revenue": 22100.00,
      "cost": 11050.00,
      "grossProfit": 11050.00,
      "grossMargin": 50.0,
      "profitGrowth": -3.2,
    },
    {
      "category": "Health & Beauty",
      "revenue": 18750.00,
      "cost": 9375.00,
      "grossProfit": 9375.00,
      "grossMargin": 50.0,
      "profitGrowth": 12.5,
    },
    {
      "category": "Home & Garden",
      "revenue": 15200.00,
      "cost": 9120.00,
      "grossProfit": 6080.00,
      "grossMargin": 40.0,
      "profitGrowth": 5.8,
    },
  ];

  List<Map<String, dynamic>> monthlyProfitTrends = [
    {
      "month": "Jan",
      "revenue": 89500.00,
      "cost": 58675.00,
      "grossProfit": 30825.00,
      "netProfit": 22125.00,
      "margin": 24.7,
    },
    {
      "month": "Feb",
      "revenue": 92300.00,
      "cost": 60395.00,
      "grossProfit": 31905.00,
      "netProfit": 23190.00,
      "margin": 25.1,
    },
    {
      "month": "Mar",
      "revenue": 98750.00,
      "cost": 63537.50,
      "grossProfit": 35212.50,
      "netProfit": 25875.00,
      "margin": 26.2,
    },
    {
      "month": "Apr",
      "revenue": 105200.00,
      "cost": 67880.00,
      "grossProfit": 37320.00,
      "netProfit": 27450.00,
      "margin": 26.1,
    },
    {
      "month": "May",
      "revenue": 110750.00,
      "cost": 71487.50,
      "grossProfit": 39262.50,
      "netProfit": 28975.00,
      "margin": 26.2,
    },
    {
      "month": "Jun",
      "revenue": 130200.00,
      "cost": 84630.00,
      "grossProfit": 45570.00,
      "netProfit": 33650.00,
      "margin": 25.9,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profitability Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshData,
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: _exportReport,
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  _buildFilters(),
                  _buildProfitabilitySummaryCards(),
                  _buildProfitTrendsChart(),
                  _buildCategoryProfitabilitySection(),
                  _buildTopProfitableProductsSection(),
                  _buildProfitabilityBreakdownSection(),
                  _buildInsightsSection(),
                ],
              ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
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
          QDropdownField(
            label: "Analysis Type",
            items: analysisTypeOptions,
            value: selectedAnalysisType,
            onChanged: (value, label) {
              selectedAnalysisType = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfitabilitySummaryCards() {
    double totalRevenue = categoryProfitability
        .map((c) => c["revenue"] as double)
        .reduce((a, b) => a + b);
    double totalCost = categoryProfitability
        .map((c) => c["cost"] as double)
        .reduce((a, b) => a + b);
    double totalProfit = totalRevenue - totalCost;
    double profitMargin = (totalProfit / totalRevenue) * 100;

    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
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
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.trending_up,
                          color: successColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Total Revenue",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "\$${totalRevenue.currency}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "+18.5% from last month",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
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
                        Icon(
                          Icons.attach_money,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Gross Profit",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "\$${totalProfit.currency}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "+22.3% from last month",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
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
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.percent,
                          color: warningColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Profit Margin",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${profitMargin.toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "+2.8% from last month",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
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
                        Icon(
                          Icons.money_off,
                          color: dangerColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Total Cost",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "\$${totalCost.currency}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    Text(
                      "+15.2% from last month",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfitTrendsChart() {
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
            "Profit Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: monthlyProfitTrends.map((trend) {
                double maxProfit = monthlyProfitTrends
                    .map((t) => t["netProfit"] as double)
                    .reduce((a, b) => a > b ? a : b);
                double height = ((trend["netProfit"] as double) / maxProfit) * 160;
                
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: spXs,
                  children: [
                    Text(
                      "\$${((trend["netProfit"] as double) / 1000).toStringAsFixed(1)}K",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Container(
                      width: 30,
                      height: height,
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                    Text(
                      "${trend["month"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryProfitabilitySection() {
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
            "Category Profitability",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...categoryProfitability.map((category) {
            Color growthColor = (category["profitGrowth"] as double) >= 0
                ? successColor
                : dangerColor;

            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: primaryColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${category["category"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: growthColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${(category["profitGrowth"] as double) >= 0 ? '+' : ''}${(category["profitGrowth"] as double).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 2,
                          children: [
                            Text(
                              "Revenue",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${(category["revenue"] as double).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 2,
                          children: [
                            Text(
                              "Gross Profit",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${(category["grossProfit"] as double).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 2,
                          children: [
                            Text(
                              "Margin",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${(category["grossMargin"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: warningColor,
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
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTopProfitableProductsSection() {
    List<Map<String, dynamic>> sortedProducts = List.from(profitabilityData)
      ..sort((a, b) => (b["grossProfit"] as double).compareTo(a["grossProfit"] as double));

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
            "Top Profitable Products",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...sortedProducts.map((product) {
            Color marginColor = (product["grossMargin"] as double) >= 40
                ? successColor
                : (product["grossMargin"] as double) >= 30
                    ? warningColor
                    : dangerColor;

            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: marginColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${product["product"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "\$${(product["grossProfit"] as double).currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${product["category"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: infoColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 2,
                          children: [
                            Text(
                              "Revenue",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${(product["revenue"] as double).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 2,
                          children: [
                            Text(
                              "Units Sold",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${product["unitsSold"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 2,
                          children: [
                            Text(
                              "Margin",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${(product["grossMargin"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: marginColor,
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
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildProfitabilityBreakdownSection() {
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
            "Profitability Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Revenue",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "\$130,200.00",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 1,
                  color: disabledOutlineBorderColor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Cost of Goods Sold",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$75,670.00",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Gross Profit",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "\$54,530.00",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 1,
                  color: disabledOutlineBorderColor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Operating Expenses",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$20,880.00",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Net Profit",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "\$33,650.00",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(100),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.percent,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Net Profit Margin: 25.9%",
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
          ),
        ],
      ),
    );
  }

  Widget _buildInsightsSection() {
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
            "Profitability Insights",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: successColor,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.trending_up,
                  color: successColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Electronics category shows highest revenue at \$45.2K but Food & Beverages has the best margin at 50%.",
                    style: TextStyle(
                      fontSize: 14,
                      color: successColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: infoColor,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.insights,
                  color: infoColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "iPhone 15 Pro is the most profitable individual product with \$3.75K gross profit and 150 profit per unit.",
                    style: TextStyle(
                      fontSize: 14,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: warningColor,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning,
                  color: warningColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Clothing category shows declining profit growth at -3.2%. Consider reviewing pricing strategy or reducing costs.",
                    style: TextStyle(
                      fontSize: 14,
                      color: warningColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _refreshData() {
    loading = true;
    setState(() {});

    Future.delayed(Duration(seconds: 2), () {
      loading = false;
      setState(() {});
      ss("Profitability analysis data refreshed successfully");
    });
  }

  void _exportReport() {
    ss("Profitability analysis report exported successfully");
  }
}
