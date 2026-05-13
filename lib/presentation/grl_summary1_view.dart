import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSummary1View extends StatefulWidget {
  @override
  State<GrlSummary1View> createState() => _GrlSummary1ViewState();
}

class _GrlSummary1ViewState extends State<GrlSummary1View> {
  String selectedPeriod = "This Year";
  
  List<Map<String, dynamic>> financialSummary = [
    {
      "title": "Total Revenue",
      "value": 12847590,
      "change": 18.5,
      "trend": "up",
      "target": 12000000,
      "icon": Icons.trending_up,
      "color": Color(0xFF22C55E),
    },
    {
      "title": "Net Profit",
      "value": 3456789,
      "change": 12.3,
      "trend": "up",
      "target": 3200000,
      "icon": Icons.account_balance_wallet,
      "color": Color(0xFF3B82F6),
    },
    {
      "title": "Operating Costs",
      "value": 8234567,
      "change": -5.2,
      "trend": "down",
      "target": 8500000,
      "icon": Icons.pie_chart,
      "color": Color(0xFFF59E0B),
    },
    {
      "title": "Cash Flow",
      "value": 2156234,
      "change": 24.7,
      "trend": "up",
      "target": 2000000,
      "icon": Icons.water_drop,
      "color": Color(0xFF8B5CF6),
    },
  ];

  List<Map<String, dynamic>> quarterlyData = [
    {"quarter": "Q1", "revenue": 2847590, "profit": 756234, "margin": 26.5},
    {"quarter": "Q2", "revenue": 3156789, "profit": 867543, "margin": 27.5},
    {"quarter": "Q3", "revenue": 3423156, "profit": 945678, "margin": 27.6},
    {"quarter": "Q4", "revenue": 3420055, "profit": 887334, "margin": 25.9},
  ];

  List<Map<String, dynamic>> keyMetrics = [
    {"metric": "Gross Margin", "value": 68.5, "unit": "%", "target": 70.0, "color": Color(0xFF22C55E)},
    {"metric": "Operating Margin", "value": 35.8, "unit": "%", "target": 35.0, "color": Color(0xFF3B82F6)},
    {"metric": "ROI", "value": 24.3, "unit": "%", "target": 20.0, "color": Color(0xFF8B5CF6)},
    {"metric": "Debt Ratio", "value": 0.42, "unit": "x", "target": 0.45, "color": Color(0xFFF59E0B)},
  ];

  List<Map<String, dynamic>> departmentBreakdown = [
    {"department": "Sales", "revenue": 5847590, "percentage": 45.5, "color": Color(0xFF22C55E)},
    {"department": "Marketing", "revenue": 2156789, "percentage": 16.8, "color": Color(0xFF3B82F6)},
    {"department": "Operations", "revenue": 3456234, "percentage": 26.9, "color": Color(0xFF8B5CF6)},
    {"department": "R&D", "revenue": 1386977, "percentage": 10.8, "color": Color(0xFFF59E0B)},
  ];

  List<Map<String, dynamic>> periodItems = [
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Last 12 Months", "value": "Last 12 Months"},
    {"label": "YTD", "value": "YTD"},
  ];

  @override
  Widget build(BuildContext context) {
    double totalRevenue = financialSummary.firstWhere((item) => item["title"] == "Total Revenue")["value"].toDouble();
    double netProfit = financialSummary.firstWhere((item) => item["title"] == "Net Profit")["value"].toDouble();
    double profitMargin = (netProfit / totalRevenue) * 100;

    return Scaffold(
      appBar: AppBar(
        title: Text("Financial Summary"),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              ss("Financial report exported successfully");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Filter
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
                SizedBox(width: spMd),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor, successColor],
                    ),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Strong Performance",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Financial Overview Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 160,
              children: financialSummary.map((item) => _buildFinancialCard(item)).toList(),
            ),

            // Key Financial Metrics
            Text(
              "Key Financial Metrics",
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
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Performance Indicators",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Above Target",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: keyMetrics.map((metric) => _buildMetricRow(metric)).toList(),
                  ),
                ],
              ),
            ),

            // Quarterly Performance
            Text(
              "Quarterly Performance",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Container(
              height: 250,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Revenue & Profit Trends",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          _buildLegendItem("Revenue", primaryColor),
                          SizedBox(width: spSm),
                          _buildLegendItem("Profit", successColor),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: quarterlyData.map((quarter) {
                        double revenue = (quarter["revenue"] as int).toDouble();
                        double profit = (quarter["profit"] as int).toDouble();
                        double maxRevenue = quarterlyData.map((q) => q["revenue"] as int).reduce((a, b) => a > b ? a : b).toDouble();
                        
                        double revenueHeight = (revenue / maxRevenue) * 140;
                        double profitHeight = (profit / maxRevenue) * 140;

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "${(quarter["margin"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: 12,
                                  height: revenueHeight,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                                SizedBox(width: 4),
                                Container(
                                  width: 12,
                                  height: profitHeight,
                                  decoration: BoxDecoration(
                                    color: successColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${quarter["quarter"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
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
            ),

            // Department Revenue Breakdown
            Text(
              "Revenue by Department",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: departmentBreakdown.map((dept) => _buildDepartmentItem(dept)).toList(),
              ),
            ),

            // Financial Health Insights
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor.withAlpha(10),
                    successColor.withAlpha(10),
                  ],
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.health_and_safety,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Financial Health Analysis",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        _buildInsightItem(
                          Icons.emoji_events,
                          "Revenue exceeded target by 7.1% (\$847K above goal)",
                          successColor,
                        ),
                        _buildInsightItem(
                          Icons.trending_up,
                          "Profit margin improved to 26.9% (vs 24.5% last year)",
                          infoColor,
                        ),
                        _buildInsightItem(
                          Icons.savings,
                          "Operating costs reduced by 5.2% through efficiency gains",
                          warningColor,
                        ),
                        _buildInsightItem(
                          Icons.water_drop,
                          "Cash flow increased 24.7% - strong liquidity position",
                          primaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Action Items & Recommendations
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.assignment_turned_in,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Strategic Recommendations",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spXs,
                    children: [
                      _buildActionItem(
                        "Continue cost optimization initiatives to maintain efficiency",
                        successColor,
                        "Continue",
                      ),
                      _buildActionItem(
                        "Invest in R&D expansion to support future growth",
                        infoColor,
                        "Opportunity",
                      ),
                      _buildActionItem(
                        "Consider debt reduction to improve financial ratios",
                        warningColor,
                        "Consider",
                      ),
                      _buildActionItem(
                        "Explore new revenue streams in emerging markets",
                        primaryColor,
                        "Strategic",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialCard(Map<String, dynamic> item) {
    double value = (item["value"] as int).toDouble();
    double target = (item["target"] as int).toDouble();
    double achievementPercentage = (value / target) * 100;
    bool isAboveTarget = value > target;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (item["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  item["icon"] as IconData,
                  color: item["color"] as Color,
                  size: 20,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: isAboveTarget ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${achievementPercentage.toStringAsFixed(0)}%",
                  style: TextStyle(
                    fontSize: 10,
                    color: isAboveTarget ? successColor : warningColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "\$${(value / 1000000).toStringAsFixed(1)}M",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${item["title"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    "${item["trend"]}" == "up" ? Icons.arrow_upward : Icons.arrow_downward,
                    color: "${item["trend"]}" == "up" ? successColor : dangerColor,
                    size: 12,
                  ),
                  Text(
                    "${(item["change"] as double).abs().toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 12,
                      color: "${item["trend"]}" == "up" ? successColor : dangerColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Text(
                "Target: \$${(target / 1000000).toStringAsFixed(1)}M",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricRow(Map<String, dynamic> metric) {
    double value = metric["value"] as double;
    double target = metric["target"] as double;
    bool isAboveTarget = value > target;
    double progressPercentage = (value / target).clamp(0.0, 1.5);

    return Column(
      spacing: spXs,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${metric["metric"]}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Text(
              "${value.toStringAsFixed(metric["unit"] == "x" ? 2 : 1)}${metric["unit"]}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isAboveTarget ? successColor : warningColor,
              ),
            ),
          ],
        ),
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: disabledColor,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: FractionallySizedBox(
            widthFactor: progressPercentage,
            child: Container(
              decoration: BoxDecoration(
                color: metric["color"] as Color,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Target: ${target.toStringAsFixed(metric["unit"] == "x" ? 2 : 1)}${metric["unit"]}",
              style: TextStyle(
                fontSize: 11,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "${isAboveTarget ? '+' : ''}${(value - target).toStringAsFixed(1)}${metric["unit"]}",
              style: TextStyle(
                fontSize: 11,
                color: isAboveTarget ? successColor : dangerColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDepartmentItem(Map<String, dynamic> dept) {
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
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: (dept["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              _getDepartmentIcon("${dept["department"]}"),
              color: dept["color"] as Color,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${dept["department"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 4,
                  margin: EdgeInsets.only(top: spXs),
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: (dept["percentage"] as double) / 100,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: dept["color"] as Color,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spMd),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${((dept["revenue"] as int) / 1000000).toStringAsFixed(1)}M",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${(dept["percentage"] as double).toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildInsightItem(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 16,
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionItem(String text, Color color, String priority) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: Text(
            priority,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  IconData _getDepartmentIcon(String department) {
    switch (department) {
      case "Sales":
        return Icons.sell;
      case "Marketing":
        return Icons.campaign;
      case "Operations":
        return Icons.settings;
      case "R&D":
        return Icons.science;
      default:
        return Icons.business;
    }
  }
}
