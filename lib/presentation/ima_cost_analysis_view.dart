import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaCostAnalysisView extends StatefulWidget {
  const ImaCostAnalysisView({super.key});

  @override
  State<ImaCostAnalysisView> createState() => _ImaCostAnalysisViewState();
}

class _ImaCostAnalysisViewState extends State<ImaCostAnalysisView> {
  int selectedTab = 0;
  String selectedPeriod = "Monthly";
  String selectedCategory = "All Categories";

  List<Map<String, dynamic>> costAnalysisData = [
    {
      "period": "Jan 2024",
      "materialCost": 125000.00,
      "laborCost": 45000.00,
      "overheadCost": 25000.00,
      "totalCost": 195000.00,
      "unitsSold": 1500,
      "costPerUnit": 130.00,
      "variance": -5.2,
    },
    {
      "period": "Feb 2024",
      "materialCost": 132000.00,
      "laborCost": 47000.00,
      "overheadCost": 26000.00,
      "totalCost": 205000.00,
      "unitsSold": 1600,
      "costPerUnit": 128.13,
      "variance": 2.3,
    },
    {
      "period": "Mar 2024",
      "materialCost": 145000.00,
      "laborCost": 52000.00,
      "overheadCost": 28000.00,
      "totalCost": 225000.00,
      "unitsSold": 1750,
      "costPerUnit": 128.57,
      "variance": 8.7,
    },
    {
      "period": "Apr 2024",
      "materialCost": 138000.00,
      "laborCost": 48000.00,
      "overheadCost": 27000.00,
      "totalCost": 213000.00,
      "unitsSold": 1650,
      "costPerUnit": 129.09,
      "variance": -1.2,
    },
    {
      "period": "May 2024",
      "materialCost": 142000.00,
      "laborCost": 50000.00,
      "overheadCost": 29000.00,
      "totalCost": 221000.00,
      "unitsSold": 1700,
      "costPerUnit": 130.00,
      "variance": 4.8,
    },
  ];

  List<Map<String, dynamic>> costDrivers = [
    {
      "driver": "Material Price Increase",
      "impact": 15.2,
      "category": "Materials",
      "description": "Raw material costs increased due to supply chain issues",
      "action": "Negotiate with suppliers",
      "priority": "High",
    },
    {
      "driver": "Labor Rate Changes",
      "impact": 8.5,
      "category": "Labor",
      "description": "Hourly wages increased by 7% across all departments",
      "action": "Productivity improvement",
      "priority": "Medium",
    },
    {
      "driver": "Energy Costs",
      "impact": 6.3,
      "category": "Overhead",
      "description": "Electricity and fuel costs rising",
      "action": "Energy efficiency program",
      "priority": "Medium",
    },
    {
      "driver": "Equipment Maintenance",
      "impact": 4.1,
      "category": "Overhead",
      "description": "Higher maintenance costs for aging equipment",
      "action": "Equipment replacement plan",
      "priority": "Low",
    },
  ];

  List<Map<String, dynamic>> periodItems = [
    {"label": "Weekly", "value": "Weekly"},
    {"label": "Monthly", "value": "Monthly"},
    {"label": "Quarterly", "value": "Quarterly"},
    {"label": "Yearly", "value": "Yearly"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Cost Analysis",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.analytics)),
        Tab(text: "Trends", icon: Icon(Icons.trending_up)),
        Tab(text: "Drivers", icon: Icon(Icons.analytics)),
        Tab(text: "Insights", icon: Icon(Icons.insights)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildTrendsTab(),
        _buildDriversTab(),
        _buildInsightsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOverviewCards(),
          SizedBox(height: spLg),
          _buildCostBreakdownChart(),
          SizedBox(height: spLg),
          _buildRecentAnalysis(),
        ],
      ),
    );
  }

  Widget _buildOverviewCards() {
    double totalCost = costAnalysisData.fold(0.0, (sum, item) => sum + (item["totalCost"] as double));
    double avgCostPerUnit = costAnalysisData.fold(0.0, (sum, item) => sum + (item["costPerUnit"] as double)) / costAnalysisData.length;
    double avgVariance = costAnalysisData.fold(0.0, (sum, item) => sum + (item["variance"] as double)) / costAnalysisData.length;
    int totalUnits = costAnalysisData.fold(0, (sum, item) => sum + (item["unitsSold"] as int));

    return ResponsiveGridView(
      padding: EdgeInsets.all(spSm),
      minItemWidth: 200,
      children: [
        _buildOverviewCard(
          "Total Cost",
          "\$${(totalCost).currency}",
          Icons.account_balance_wallet,
          primaryColor,
          "Last 5 months",
        ),
        _buildOverviewCard(
          "Avg Cost/Unit",
          "\$${(avgCostPerUnit).toStringAsFixed(2)}",
          Icons.precision_manufacturing,
          infoColor,
          "Per unit average",
        ),
        _buildOverviewCard(
          "Avg Variance",
          "${avgVariance >= 0 ? '+' : ''}${(avgVariance).toStringAsFixed(1)}%",
          Icons.trending_up,
          avgVariance >= 0 ? dangerColor : successColor,
          "Month over month",
        ),
        _buildOverviewCard(
          "Total Units",
          "${totalUnits}",
          Icons.inventory,
          warningColor,
          "Units produced",
        ),
      ],
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color, String subtitle) {
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

  Widget _buildCostBreakdownChart() {
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
            "Cost Breakdown Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildCostBreakdownItem("Material Costs", 142000.00, 0.64, primaryColor),
          _buildCostBreakdownItem("Labor Costs", 50000.00, 0.23, successColor),
          _buildCostBreakdownItem("Overhead Costs", 29000.00, 0.13, warningColor),
        ],
      ),
    );
  }

  Widget _buildCostBreakdownItem(String category, double amount, double percentage, Color color) {
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
                  category,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "${(percentage * 100).toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "\$${(amount).currency}",
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

  Widget _buildTrendsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPeriodSelector(),
          SizedBox(height: spLg),
          _buildTrendsChart(),
          SizedBox(height: spLg),
          _buildVarianceAnalysis(),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
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
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () {
              ss("Trends data refreshed");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTrendsChart() {
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
            "Cost Trends Over Time",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            height: 250,
            child: Column(
              children: costAnalysisData.map((data) {
                return _buildTrendLine(data);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendLine(Map<String, dynamic> data) {
    double maxValue = 250000.00;
    double percentage = (data["totalCost"] as double) / maxValue;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  "${data["period"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 20,
                  child: LinearProgressIndicator(
                    value: percentage,
                    backgroundColor: primaryColor.withAlpha(30),
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "\$${(data["totalCost"] as double).currency}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDriversTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDriversHeader(),
          SizedBox(height: spLg),
          _buildDriversList(),
        ],
      ),
    );
  }

  Widget _buildDriversHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(
            Icons.analytics,
            color: primaryColor,
            size: 24,
          ),
          SizedBox(width: spSm),
          Text(
            "Cost Drivers Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Spacer(),
          Text(
            "${costDrivers.length} drivers identified",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriversList() {
    return Column(
      children: costDrivers.map((driver) {
        return _buildDriverItem(driver);
      }).toList(),
    );
  }

  Widget _buildDriverItem(Map<String, dynamic> driver) {
    Color priorityColor = _getPriorityColor(driver["priority"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
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
                  "${driver["driver"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: priorityColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${driver["priority"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: priorityColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${driver["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      color: dangerColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Impact: ${(driver["impact"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Category: ${driver["category"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                color: warningColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "Action: ${driver["action"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
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

  Widget _buildInsightsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildKeyInsights(),
          SizedBox(height: spLg),
          _buildRecommendations(),
        ],
      ),
    );
  }

  Widget _buildKeyInsights() {
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
                Icons.insights,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Key Insights",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          _buildInsightItem(
            "Material costs represent 64% of total expenses",
            "Focus on supplier negotiations and bulk purchasing",
            Icons.pie_chart,
            primaryColor,
          ),
          _buildInsightItem(
            "Cost per unit has increased by 2.3% over 5 months",
            "Consider process optimization and efficiency improvements",
            Icons.trending_up,
            dangerColor,
          ),
          _buildInsightItem(
            "Labor productivity has improved by 8% this quarter",
            "Training programs are showing positive results",
            Icons.people,
            successColor,
          ),
          _buildInsightItem(
            "Overhead costs are stable but can be optimized",
            "Energy efficiency initiatives could reduce costs by 15%",
            Icons.energy_savings_leaf,
            warningColor,
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(String insight, String action, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color.withAlpha(100),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  insight,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  action,
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
    );
  }

  Widget _buildRecommendations() {
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
                Icons.recommend,
                color: successColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Recommendations",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          _buildRecommendationItem(
            "Short Term (1-3 months)",
            "Renegotiate supplier contracts and implement bulk purchasing",
            "Potential savings: 8-12%",
            successColor,
          ),
          _buildRecommendationItem(
            "Medium Term (3-6 months)",
            "Invest in automation and process optimization",
            "Potential savings: 15-20%",
            warningColor,
          ),
          _buildRecommendationItem(
            "Long Term (6-12 months)",
            "Equipment modernization and energy efficiency programs",
            "Potential savings: 20-25%",
            infoColor,
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationItem(String timeframe, String action, String impact, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  timeframe,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  action,
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  impact,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentAnalysis() {
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
            "Recent Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: costAnalysisData.take(3).length,
            itemBuilder: (context, index) {
              final data = costAnalysisData[index];
              return _buildAnalysisItem(data);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisItem(Map<String, dynamic> data) {
    bool isPositiveVariance = (data["variance"] as double) >= 0;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${data["period"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Total Cost: \$${(data["totalCost"] as double).currency}",
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
                "${isPositiveVariance ? '+' : ''}${(data["variance"] as double).toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isPositiveVariance ? dangerColor : successColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${data["unitsSold"]} units",
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

  Widget _buildVarianceAnalysis() {
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
            "Variance Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            children: costAnalysisData.map((data) {
              return _buildVarianceItem(data);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildVarianceItem(Map<String, dynamic> data) {
    bool isPositive = (data["variance"] as double) >= 0;
    Color varianceColor = isPositive ? dangerColor : successColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(
          color: disabledOutlineBorderColor,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            child: Text(
              "${data["period"]}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Icon(
                  isPositive ? Icons.trending_up : Icons.trending_down,
                  color: varianceColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Text(
                  "${isPositive ? '+' : ''}${(data["variance"] as double).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: varianceColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "\$${(data["costPerUnit"] as double).toStringAsFixed(2)}/unit",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }
}
