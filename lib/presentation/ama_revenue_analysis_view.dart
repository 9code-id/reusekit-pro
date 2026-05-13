import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaRevenueAnalysisView extends StatefulWidget {
  const AmaRevenueAnalysisView({super.key});

  @override
  State<AmaRevenueAnalysisView> createState() => _AmaRevenueAnalysisViewState();
}

class _AmaRevenueAnalysisViewState extends State<AmaRevenueAnalysisView> {
  int selectedTab = 0;
  String selectedPeriod = "This Year";
  String selectedCrop = "All";

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Month", "value": "This Month"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "Last 6 Months", "value": "Last 6 Months"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Last Year", "value": "Last Year"},
  ];

  List<Map<String, dynamic>> cropOptions = [
    {"label": "All Crops", "value": "All"},
    {"label": "Rice", "value": "Rice"},
    {"label": "Wheat", "value": "Wheat"},
    {"label": "Corn", "value": "Corn"},
    {"label": "Soybeans", "value": "Soybeans"},
  ];

  List<Map<String, dynamic>> monthlyRevenue = [
    {"month": "Jan", "revenue": 125000.0, "cost": 85000.0, "profit": 40000.0},
    {"month": "Feb", "revenue": 142000.0, "cost": 95000.0, "profit": 47000.0},
    {"month": "Mar", "revenue": 158000.0, "cost": 105000.0, "profit": 53000.0},
    {"month": "Apr", "revenue": 175000.0, "cost": 115000.0, "profit": 60000.0},
    {"month": "May", "revenue": 198000.0, "cost": 125000.0, "profit": 73000.0},
    {"month": "Jun", "revenue": 210000.0, "cost": 135000.0, "profit": 75000.0},
    {"month": "Jul", "revenue": 185000.0, "cost": 120000.0, "profit": 65000.0},
    {"month": "Aug", "revenue": 225000.0, "cost": 145000.0, "profit": 80000.0},
    {"month": "Sep", "revenue": 245000.0, "cost": 155000.0, "profit": 90000.0},
    {"month": "Oct", "revenue": 265000.0, "cost": 170000.0, "profit": 95000.0},
    {"month": "Nov", "revenue": 280000.0, "cost": 180000.0, "profit": 100000.0},
    {"month": "Dec", "revenue": 295000.0, "cost": 190000.0, "profit": 105000.0},
  ];

  List<Map<String, dynamic>> cropRevenue = [
    {
      "crop": "Rice",
      "revenue": 850000.0,
      "percentage": 35.2,
      "growth": 12.5,
      "orders": 125,
      "avgOrderValue": 6800.0,
    },
    {
      "crop": "Wheat",
      "revenue": 620000.0,
      "percentage": 25.7,
      "growth": 8.3,
      "orders": 98,
      "avgOrderValue": 6326.0,
    },
    {
      "crop": "Corn",
      "revenue": 485000.0,
      "percentage": 20.1,
      "growth": 15.8,
      "orders": 76,
      "avgOrderValue": 6381.0,
    },
    {
      "crop": "Soybeans",
      "revenue": 320000.0,
      "percentage": 13.3,
      "growth": 22.4,
      "orders": 45,
      "avgOrderValue": 7111.0,
    },
    {
      "crop": "Others",
      "revenue": 138000.0,
      "percentage": 5.7,
      "growth": 5.2,
      "orders": 28,
      "avgOrderValue": 4928.0,
    },
  ];

  List<Map<String, dynamic>> quarterlyComparison = [
    {"quarter": "Q1 2024", "revenue": 425000.0, "growth": 15.2},
    {"quarter": "Q2 2024", "revenue": 583000.0, "growth": 18.6},
    {"quarter": "Q3 2024", "revenue": 655000.0, "growth": 22.8},
    {"quarter": "Q4 2024", "revenue": 740000.0, "growth": 25.4},
  ];

  List<Map<String, dynamic>> revenueMetrics = [
    {
      "title": "Total Revenue",
      "current": 2403000.0,
      "previous": 1920000.0,
      "change": 25.2,
      "icon": Icons.attach_money,
      "color": successColor,
    },
    {
      "title": "Average Order Value",
      "current": 6500.0,
      "previous": 5800.0,
      "change": 12.1,
      "icon": Icons.receipt,
      "color": infoColor,
    },
    {
      "title": "Profit Margin",
      "current": 31.5,
      "previous": 28.2,
      "change": 11.7,
      "icon": Icons.trending_up,
      "color": primaryColor,
    },
    {
      "title": "Customer Growth",
      "current": 18.8,
      "previous": 12.5,
      "change": 50.4,
      "icon": Icons.people,
      "color": warningColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Revenue Analysis",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Trends", icon: Icon(Icons.show_chart)),
        Tab(text: "By Crop", icon: Icon(Icons.pie_chart)),
        Tab(text: "Metrics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildTrendsTab(),
        _buildCropAnalysisTab(),
        _buildMetricsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    double currentYearRevenue = monthlyRevenue.fold(0.0, (sum, month) => sum + (month["revenue"] as double));
    double currentYearProfit = monthlyRevenue.fold(0.0, (sum, month) => sum + (month["profit"] as double));
    double profitMargin = (currentYearProfit / currentYearRevenue) * 100;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  label: "Crop Filter",
                  items: cropOptions,
                  value: selectedCrop,
                  onChanged: (value, label) {
                    selectedCrop = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Text(
            "Revenue Summary",
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
              _buildSummaryCard(
                "Total Revenue",
                "\$${currentYearRevenue.currency}",
                "+25.2%",
                Icons.attach_money,
                successColor,
              ),
              _buildSummaryCard(
                "Total Profit",
                "\$${currentYearProfit.currency}",
                "+31.8%",
                Icons.trending_up,
                primaryColor,
              ),
              _buildSummaryCard(
                "Profit Margin",
                "${profitMargin.toStringAsFixed(1)}%",
                "+6.3%",
                Icons.percent,
                infoColor,
              ),
              _buildSummaryCard(
                "Orders",
                "372",
                "+18.5%",
                Icons.receipt_long,
                warningColor,
              ),
            ],
          ),
          Text(
            "Quarterly Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: quarterlyComparison.map((quarter) => _buildQuarterCard(quarter)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Revenue Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 300,
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
                  "Monthly Revenue vs Profit",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: monthlyRevenue.take(6).map((data) => _buildRevenueBar(data)).toList(),
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: monthlyRevenue.take(6).map((data) => _buildMonthLabel(data)).toList(),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Container(
                      width: 16,
                      height: 4,
                      color: primaryColor,
                    ),
                    SizedBox(width: spXs),
                    Text("Revenue", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    SizedBox(width: spSm),
                    Container(
                      width: 16,
                      height: 4,
                      color: successColor,
                    ),
                    SizedBox(width: spXs),
                    Text("Profit", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                  ],
                ),
              ],
            ),
          ),
          Text(
            "Growth Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Year-over-Year Growth", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                          Text("25.2%", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: successColor)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Quarter-over-Quarter", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                          Text("8.7%", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor)),
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
                          Text("Best Month", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                          Text("December", style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Revenue Trend", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                          Row(
                            children: [
                              Icon(Icons.trending_up, color: successColor, size: 16),
                              SizedBox(width: spXs),
                              Text("Increasing", style: TextStyle(fontWeight: FontWeight.bold, color: successColor)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCropAnalysisTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Revenue by Crop",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: cropRevenue.map((crop) => _buildCropRevenueCard(crop)).toList(),
          ),
          Text(
            "Crop Performance Comparison",
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
              _buildCropMetricCard("Highest Revenue", "Rice", 850000.0, Icons.star),
              _buildCropMetricCard("Best Growth", "Soybeans", 22.4, Icons.trending_up),
              _buildCropMetricCard("Most Orders", "Rice", 125.0, Icons.receipt_long),
              _buildCropMetricCard("Highest AOV", "Soybeans", 7111.0, Icons.attach_money),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Key Performance Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: revenueMetrics.map((metric) => _buildMetricCard(metric)).toList(),
          ),
          QButton(
            label: "Export Revenue Report",
            size: bs.md,
            onPressed: () {
              ss("Revenue report exported successfully");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, String change, IconData icon, Color color) {
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
                child: Icon(icon, color: color, size: 24),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  change,
                  style: TextStyle(
                    color: successColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
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
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuarterCard(Map<String, dynamic> quarter) {
    double growth = (quarter["growth"] as num).toDouble();
    
    return Container(
      padding: EdgeInsets.all(spMd),
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
                  "${quarter["quarter"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "\$${(quarter["revenue"] as double).currency}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.trending_up, color: successColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "+${growth.toStringAsFixed(1)}%",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueBar(Map<String, dynamic> data) {
    double revenue = (data["revenue"] as num).toDouble();
    double profit = (data["profit"] as num).toDouble();
    double maxRevenue = monthlyRevenue.map((e) => e["revenue"] as num).reduce((a, b) => a > b ? a : b).toDouble();
    
    double revenueHeight = (revenue / maxRevenue) * 180;
    double profitHeight = (profit / maxRevenue) * 180;

    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: revenueHeight,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                ),
                SizedBox(width: 2),
                Expanded(
                  child: Container(
                    height: profitHeight,
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthLabel(Map<String, dynamic> data) {
    return Expanded(
      child: Text(
        "${data["month"]}",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 10,
          color: disabledBoldColor,
        ),
      ),
    );
  }

  Widget _buildCropRevenueCard(Map<String, dynamic> crop) {
    double percentage = (crop["percentage"] as num).toDouble();
    double growth = (crop["growth"] as num).toDouble();

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
              Expanded(
                child: Text(
                  "${crop["crop"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "+${growth.toStringAsFixed(1)}%",
                  style: TextStyle(
                    color: successColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "\$${(crop["revenue"] as double).currency}",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Share", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                    Text("${percentage.toStringAsFixed(1)}%", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Orders", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                    Text("${crop["orders"]}", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("AOV", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                    Text("\$${(crop["avgOrderValue"] as double).currency}", style: TextStyle(fontWeight: FontWeight.bold, color: infoColor)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentage / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCropMetricCard(String title, String crop, double value, IconData icon) {
    String displayValue = title.contains("Revenue") ? "\$${value.currency}" :
                         title.contains("Growth") ? "${value.toStringAsFixed(1)}%" :
                         title.contains("AOV") ? "\$${value.currency}" :
                         "${value.toStringAsFixed(0)}";

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
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: primaryColor, size: 20),
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            displayValue,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            crop,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(Map<String, dynamic> metric) {
    double change = (metric["change"] as num).toDouble();
    Color changeColor = change >= 0 ? successColor : dangerColor;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: (metric["color"] as Color).withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(metric["icon"] as IconData, color: metric["color"] as Color, size: 24),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${metric["title"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      metric["title"].toString().contains("Margin") || metric["title"].toString().contains("Growth") ? 
                        "${(metric["current"] as num).toStringAsFixed(1)}%" :
                        metric["title"].toString().contains("Revenue") || metric["title"].toString().contains("Order") ?
                          "\$${(metric["current"] as double).currency}" :
                          "${(metric["current"] as num).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: metric["color"] as Color,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(
                      change >= 0 ? Icons.trending_up : Icons.trending_down,
                      color: changeColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${change >= 0 ? '+' : ''}${change.toStringAsFixed(1)}%",
                      style: TextStyle(
                        color: changeColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
