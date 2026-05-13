import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaTurnoverReportView extends StatefulWidget {
  const ImaTurnoverReportView({super.key});

  @override
  State<ImaTurnoverReportView> createState() => _ImaTurnoverReportViewState();
}

class _ImaTurnoverReportViewState extends State<ImaTurnoverReportView> {
  String selectedPeriod = "Last 12 Months";
  String selectedCategory = "All Categories";
  String sortBy = "Turnover Rate";
  bool sortAscending = false;

  List<Map<String, dynamic>> turnoverData = [
    {
      "itemCode": "RAW001",
      "itemName": "Steel Rod 10mm",
      "category": "Raw Materials",
      "avgInventory": 425.50,
      "cogs": 18750.00,
      "turnoverRate": 44.06,
      "daysOnHand": 8.3,
      "performance": "Excellent",
      "trend": "Improving",
      "lastPeriodRate": 38.2,
      "variance": 5.86,
      "monthlyData": [
        {"month": "Jan", "rate": 38.2, "cogs": 1500.00, "avgInv": 39.3},
        {"month": "Feb", "rate": 40.1, "cogs": 1620.00, "avgInv": 40.4},
        {"month": "Mar", "rate": 42.3, "cogs": 1680.00, "avgInv": 39.7},
        {"month": "Apr", "rate": 44.8, "cogs": 1750.00, "avgInv": 39.1},
        {"month": "May", "rate": 46.2, "cogs": 1820.00, "avgInv": 39.4},
        {"month": "Jun", "rate": 44.06, "cogs": 1800.00, "avgInv": 40.8},
      ],
    },
    {
      "itemCode": "COM002",
      "itemName": "Electronic Circuit",
      "category": "Components",
      "avgInventory": 225.75,
      "cogs": 6750.00,
      "turnoverRate": 29.89,
      "daysOnHand": 12.2,
      "performance": "Good",
      "trend": "Stable",
      "lastPeriodRate": 29.5,
      "variance": 0.39,
      "monthlyData": [
        {"month": "Jan", "rate": 29.5, "cogs": 1050.00, "avgInv": 35.6},
        {"month": "Feb", "rate": 28.8, "cogs": 1120.00, "avgInv": 38.9},
        {"month": "Mar", "rate": 30.2, "cogs": 1180.00, "avgInv": 39.1},
        {"month": "Apr", "rate": 31.1, "cogs": 1200.00, "avgInv": 38.6},
        {"month": "May", "rate": 30.5, "cogs": 1150.00, "avgInv": 37.7},
        {"month": "Jun", "rate": 29.89, "cogs": 1050.00, "avgInv": 35.1},
      ],
    },
    {
      "itemCode": "PKG003",
      "itemName": "Cardboard Box Large",
      "category": "Packaging",
      "avgInventory": 875.25,
      "cogs": 8500.00,
      "turnoverRate": 9.71,
      "daysOnHand": 37.6,
      "performance": "Poor",
      "trend": "Declining",
      "lastPeriodRate": 12.3,
      "variance": -2.59,
      "monthlyData": [
        {"month": "Jan", "rate": 12.3, "cogs": 950.00, "avgInv": 77.2},
        {"month": "Feb", "rate": 11.8, "cogs": 920.00, "avgInv": 78.0},
        {"month": "Mar", "rate": 10.9, "cogs": 880.00, "avgInv": 80.7},
        {"month": "Apr", "rate": 10.2, "cogs": 850.00, "avgInv": 83.3},
        {"month": "May", "rate": 9.8, "cogs": 800.00, "avgInv": 81.6},
        {"month": "Jun", "rate": 9.71, "cogs": 780.00, "avgInv": 80.3},
      ],
    },
    {
      "itemCode": "FIN004",
      "itemName": "Aluminum Sheet",
      "category": "Finished Goods",
      "avgInventory": 125.50,
      "cogs": 15250.00,
      "turnoverRate": 121.51,
      "daysOnHand": 3.0,
      "performance": "Excellent",
      "trend": "Improving",
      "lastPeriodRate": 115.2,
      "variance": 6.31,
      "monthlyData": [
        {"month": "Jan", "rate": 115.2, "cogs": 1350.00, "avgInv": 11.7},
        {"month": "Feb", "rate": 118.5, "cogs": 1420.00, "avgInv": 12.0},
        {"month": "Mar", "rate": 120.8, "cogs": 1480.00, "avgInv": 12.3},
        {"month": "Apr", "rate": 123.2, "cogs": 1520.00, "avgInv": 12.3},
        {"month": "May", "rate": 125.1, "cogs": 1580.00, "avgInv": 12.6},
        {"month": "Jun", "rate": 121.51, "cogs": 1550.00, "avgInv": 12.8},
      ],
    },
    {
      "itemCode": "TOL005",
      "itemName": "Precision Drill Bit",
      "category": "Tools",
      "avgInventory": 65.25,
      "cogs": 3250.00,
      "turnoverRate": 49.81,
      "daysOnHand": 7.3,
      "performance": "Excellent",
      "trend": "Stable",
      "lastPeriodRate": 48.9,
      "variance": 0.91,
      "monthlyData": [
        {"month": "Jan", "rate": 48.9, "cogs": 280.00, "avgInv": 5.7},
        {"month": "Feb", "rate": 49.2, "cogs": 290.00, "avgInv": 5.9},
        {"month": "Mar", "rate": 50.1, "cogs": 310.00, "avgInv": 6.2},
        {"month": "Apr", "rate": 51.3, "cogs": 320.00, "avgInv": 6.2},
        {"month": "May", "rate": 50.8, "cogs": 315.00, "avgInv": 6.2},
        {"month": "Jun", "rate": 49.81, "cogs": 305.00, "avgInv": 6.1},
      ],
    },
  ];

  List<Map<String, dynamic>> benchmarks = [
    {
      "category": "Raw Materials",
      "industryAvg": 24.5,
      "bestPractice": 36.0,
      "acceptableRange": "18-30",
      "description": "Fast-moving materials should turn over frequently",
    },
    {
      "category": "Components",
      "industryAvg": 18.2,
      "bestPractice": 24.0,
      "acceptableRange": "12-20",
      "description": "Electronic components have moderate turnover",
    },
    {
      "category": "Packaging",
      "industryAvg": 15.6,
      "bestPractice": 20.0,
      "acceptableRange": "10-18",
      "description": "Packaging materials vary by demand",
    },
    {
      "category": "Finished Goods",
      "industryAvg": 52.1,
      "bestPractice": 72.0,
      "acceptableRange": "40-65",
      "description": "Finished goods should move quickly",
    },
    {
      "category": "Tools",
      "industryAvg": 8.3,
      "bestPractice": 12.0,
      "acceptableRange": "6-10",
      "description": "Tools have slow but steady turnover",
    },
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "Last 6 Months", "value": "Last 6 Months"},
    {"label": "Last 12 Months", "value": "Last 12 Months"},
    {"label": "Current Year", "value": "Current Year"},
    {"label": "Last Year", "value": "Last Year"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "All Categories"},
    {"label": "Raw Materials", "value": "Raw Materials"},
    {"label": "Components", "value": "Components"},
    {"label": "Packaging", "value": "Packaging"},
    {"label": "Finished Goods", "value": "Finished Goods"},
    {"label": "Tools", "value": "Tools"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory Turnover Report"),
        actions: [
          IconButton(
            icon: Icon(Icons.trending_up),
            onPressed: () {
              _showTurnoverTrends();
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Turnover report exported successfully");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTurnoverSummary(),
            SizedBox(height: spLg),
            _buildPerformanceMetrics(),
            SizedBox(height: spLg),
            _buildFiltersSection(),
            SizedBox(height: spLg),
            _buildTurnoverTable(),
            SizedBox(height: spLg),
            _buildBenchmarksSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildTurnoverSummary() {
    double avgTurnoverRate = turnoverData.fold(0.0, (sum, item) => sum + (item["turnoverRate"] as double)) / turnoverData.length;
    double avgDaysOnHand = turnoverData.fold(0.0, (sum, item) => sum + (item["daysOnHand"] as double)) / turnoverData.length;
    int excellentItems = turnoverData.where((item) => item["performance"] == "Excellent").length;
    int poorItems = turnoverData.where((item) => item["performance"] == "Poor").length;

    return ResponsiveGridView(
      padding: EdgeInsets.all(spSm),
      minItemWidth: 200,
      children: [
        _buildSummaryCard(
          "Avg Turnover Rate",
          "${(avgTurnoverRate).toStringAsFixed(1)}x",
          Icons.rotate_right,
          primaryColor,
          "Times per year",
        ),
        _buildSummaryCard(
          "Avg Days on Hand",
          "${(avgDaysOnHand).toStringAsFixed(1)}",
          Icons.access_time,
          infoColor,
          "Days in inventory",
        ),
        _buildSummaryCard(
          "High Performers",
          "${excellentItems}",
          Icons.trending_up,
          successColor,
          "Excellent turnover",
        ),
        _buildSummaryCard(
          "Underperformers",
          "${poorItems}",
          Icons.trending_down,
          dangerColor,
          "Need improvement",
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color, String subtitle) {
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              Spacer(),
              Icon(
                Icons.more_vert,
                color: disabledBoldColor,
                size: 20,
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
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
                Icons.speed,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Performance Distribution",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          _buildPerformanceBar("Excellent", successColor, 2),
          _buildPerformanceBar("Good", warningColor, 1),
          _buildPerformanceBar("Poor", dangerColor, 1),
          _buildPerformanceBar("Needs Review", disabledBoldColor, 1),
        ],
      ),
    );
  }

  Widget _buildPerformanceBar(String performance, Color color, int count) {
    double percentage = count / turnoverData.length;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  performance,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "${count} items",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${(percentage * 100).toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          LinearProgressIndicator(
            value: percentage,
            backgroundColor: color.withAlpha(50),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection() {
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
            "Report Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
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
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Sort By",
                  items: [
                    {"label": "Turnover Rate", "value": "Turnover Rate"},
                    {"label": "Days on Hand", "value": "Days on Hand"},
                    {"label": "Item Name", "value": "Item Name"},
                    {"label": "Performance", "value": "Performance"},
                  ],
                  value: sortBy,
                  onChanged: (value, label) {
                    sortBy = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: sortAscending ? Icons.arrow_upward : Icons.arrow_downward,
                size: bs.sm,
                onPressed: () {
                  sortAscending = !sortAscending;
                  setState(() {});
                },
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Refresh",
                icon: Icons.refresh,
                size: bs.sm,
                onPressed: () {
                  ss("Turnover data refreshed");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTurnoverTable() {
    List<Map<String, dynamic>> filteredData = _getFilteredData();
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusMd),
                topRight: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.table_chart,
                  color: primaryColor,
                  size: 24,
                ),
                SizedBox(width: spSm),
                Text(
                  "Inventory Turnover Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredData.length} items",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: filteredData.length,
            itemBuilder: (context, index) {
              final item = filteredData[index];
              return _buildTurnoverItem(item);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTurnoverItem(Map<String, dynamic> item) {
    Color performanceColor = _getPerformanceColor(item["performance"]);
    bool isImproving = item["trend"] == "Improving";
    Icon trendIcon = Icon(
      isImproving ? Icons.trending_up : 
      item["trend"] == "Declining" ? Icons.trending_down : Icons.trending_flat,
      color: isImproving ? successColor : 
             item["trend"] == "Declining" ? dangerColor : warningColor,
      size: 16,
    );

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: disabledOutlineBorderColor,
            width: 0.5,
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
                      "${item["itemName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Text(
                          "${item["itemCode"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontFamily: 'monospace',
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${item["category"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      trendIcon,
                      SizedBox(width: spXs),
                      Text(
                        "${(item["turnoverRate"] as double).toStringAsFixed(1)}x",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: performanceColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${item["performance"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: performanceColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildTurnoverMetric(
                  "Days on Hand",
                  "${(item["daysOnHand"] as double).toStringAsFixed(1)}",
                  Icons.access_time,
                ),
              ),
              Expanded(
                child: _buildTurnoverMetric(
                  "Avg Inventory",
                  "\$${(item["avgInventory"] as double).currency}",
                  Icons.inventory,
                ),
              ),
              Expanded(
                child: _buildTurnoverMetric(
                  "COGS",
                  "\$${(item["cogs"] as double).currency}",
                  Icons.attach_money,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Text(
                "Trend: ${item["trend"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Text(
                "Variance: ${(item["variance"] as double) >= 0 ? '+' : ''}${(item["variance"] as double).toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 12,
                  color: (item["variance"] as double) >= 0 ? successColor : dangerColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  _showItemDetails(item);
                },
                child: Text(
                  "View Details",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTurnoverMetric(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: disabledBoldColor,
        ),
        SizedBox(width: spXs),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBenchmarksSection() {
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
                Icons.compare_arrows,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Industry Benchmarks",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            children: benchmarks.map((benchmark) {
              return _buildBenchmarkItem(benchmark);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBenchmarkItem(Map<String, dynamic> benchmark) {
    double currentRate = _getCategoryAverageRate(benchmark["category"]);
    double industryAvg = benchmark["industryAvg"] as double;
    bool isAboveAverage = currentRate > industryAvg;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isAboveAverage ? successColor.withAlpha(20) : warningColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: isAboveAverage ? successColor.withAlpha(100) : warningColor.withAlpha(100),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${benchmark["category"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Icon(
                isAboveAverage ? Icons.trending_up : Icons.trending_down,
                color: isAboveAverage ? successColor : warningColor,
                size: 20,
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "${benchmark["description"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Average: ${currentRate.toStringAsFixed(1)}x",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Industry Avg: ${industryAvg.toStringAsFixed(1)}x",
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
                    "Best Practice: ${(benchmark["bestPractice"] as double).toStringAsFixed(1)}x",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  Text(
                    "Range: ${benchmark["acceptableRange"]}x",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredData() {
    List<Map<String, dynamic>> filtered = turnoverData;

    if (selectedCategory != "All Categories") {
      filtered = filtered.where((item) => item["category"] == selectedCategory).toList();
    }

    // Apply sorting
    filtered.sort((a, b) {
      dynamic valueA, valueB;
      
      switch (sortBy) {
        case "Turnover Rate":
          valueA = a["turnoverRate"];
          valueB = b["turnoverRate"];
          break;
        case "Days on Hand":
          valueA = a["daysOnHand"];
          valueB = b["daysOnHand"];
          break;
        case "Item Name":
          valueA = a["itemName"];
          valueB = b["itemName"];
          break;
        case "Performance":
          valueA = a["performance"];
          valueB = b["performance"];
          break;
        default:
          valueA = a["turnoverRate"];
          valueB = b["turnoverRate"];
      }

      if (sortAscending) {
        return valueA.compareTo(valueB);
      } else {
        return valueB.compareTo(valueA);
      }
    });

    return filtered;
  }

  double _getCategoryAverageRate(String category) {
    List<Map<String, dynamic>> categoryItems = turnoverData.where((item) => item["category"] == category).toList();
    if (categoryItems.isEmpty) return 0.0;
    
    return categoryItems.fold(0.0, (sum, item) => sum + (item["turnoverRate"] as double)) / categoryItems.length;
  }

  Color _getPerformanceColor(String performance) {
    switch (performance) {
      case "Excellent":
        return successColor;
      case "Good":
        return warningColor;
      case "Poor":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showTurnoverTrends() {
    ss("Turnover trends analysis opened");
  }

  void _showItemDetails(Map<String, dynamic> item) {
    ss("Detailed turnover analysis for ${item["itemName"]} opened");
  }
}
