import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaCostAnalysisView extends StatefulWidget {
  const DlaCostAnalysisView({super.key});

  @override
  State<DlaCostAnalysisView> createState() => _DlaCostAnalysisViewState();
}

class _DlaCostAnalysisViewState extends State<DlaCostAnalysisView> {
  String selectedPeriod = "monthly";
  String selectedCategory = "all";
  
  final List<Map<String, dynamic>> periodOptions = [
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
    {"label": "Quarterly", "value": "quarterly"},
    {"label": "Yearly", "value": "yearly"},
  ];

  final List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Transportation", "value": "transportation"},
    {"label": "Fuel & Energy", "value": "fuel"},
    {"label": "Labor Costs", "value": "labor"},
    {"label": "Warehouse Operations", "value": "warehouse"},
    {"label": "Technology & Equipment", "value": "technology"},
  ];

  final List<Map<String, dynamic>> costBreakdown = [
    {
      "category": "Transportation",
      "amount": 285600.0,
      "percentage": 35.8,
      "budget": 300000.0,
      "variance": -14400.0,
      "trend": "down",
      "color": primaryColor,
      "icon": Icons.local_shipping,
    },
    {
      "category": "Fuel & Energy",
      "amount": 164200.0,
      "percentage": 20.6,
      "budget": 150000.0,
      "variance": 14200.0,
      "trend": "up",
      "color": dangerColor,
      "icon": Icons.local_gas_station,
    },
    {
      "category": "Labor Costs",
      "amount": 156800.0,
      "percentage": 19.7,
      "budget": 160000.0,
      "variance": -3200.0,
      "trend": "down",
      "color": successColor,
      "icon": Icons.people,
    },
    {
      "category": "Warehouse Operations",
      "amount": 98400.0,
      "percentage": 12.3,
      "budget": 100000.0,
      "variance": -1600.0,
      "trend": "down",
      "color": warningColor,
      "icon": Icons.inventory,
    },
    {
      "category": "Technology & Equipment",
      "amount": 92800.0,
      "percentage": 11.6,
      "budget": 95000.0,
      "variance": -2200.0,
      "trend": "down",
      "color": infoColor,
      "icon": Icons.computer,
    },
  ];

  final List<Map<String, dynamic>> monthlyCosts = [
    {
      "month": "Jan",
      "actual": 125000.0,
      "budget": 130000.0,
      "variance": -5000.0,
    },
    {
      "month": "Feb", 
      "actual": 132000.0,
      "budget": 130000.0,
      "variance": 2000.0,
    },
    {
      "month": "Mar",
      "actual": 128500.0,
      "budget": 130000.0,
      "variance": -1500.0,
    },
    {
      "month": "Apr",
      "actual": 134000.0,
      "budget": 135000.0,
      "variance": -1000.0,
    },
    {
      "month": "May",
      "actual": 138200.0,
      "budget": 135000.0,
      "variance": 3200.0,
    },
    {
      "month": "Jun",
      "actual": 140100.0,
      "budget": 135000.0,
      "variance": 5100.0,
    },
  ];

  final Map<String, dynamic> costSummary = {
    "total_costs": 797800.0,
    "total_budget": 805000.0,
    "budget_variance": -7200.0,
    "cost_per_delivery": 24.85,
    "efficiency_ratio": 92.4,
    "month_over_month": -2.3,
  };

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
            "Cost Analysis Filters",
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
                  label: "Time Period",
                  items: periodOptions,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Cost Category",
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

  Widget _buildCostSummary() {
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
            "Cost Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildSummaryCard(
                "Total Costs",
                "\$${(costSummary["total_costs"] as double).currency}",
                Icons.attach_money,
                primaryColor,
              ),
              _buildSummaryCard(
                "Budget Variance",
                "${(costSummary["budget_variance"] as double) >= 0 ? '+' : ''}\$${(costSummary["budget_variance"] as double).abs().currency}",
                Icons.trending_down,
                (costSummary["budget_variance"] as double) >= 0 ? dangerColor : successColor,
              ),
              _buildSummaryCard(
                "Cost per Delivery",
                "\$${(costSummary["cost_per_delivery"] as double).currency}",
                Icons.local_shipping,
                warningColor,
              ),
              _buildSummaryCard(
                "Efficiency Ratio",
                "${(costSummary["efficiency_ratio"] as double).toStringAsFixed(1)}%",
                Icons.trending_up,
                successColor,
              ),
              _buildSummaryCard(
                "Total Budget",
                "\$${(costSummary["total_budget"] as double).currency}",
                Icons.account_balance,
                infoColor,
              ),
              _buildSummaryCard(
                "MoM Change",
                "${(costSummary["month_over_month"] as double) >= 0 ? '+' : ''}${(costSummary["month_over_month"] as double).toStringAsFixed(1)}%",
                Icons.show_chart,
                (costSummary["month_over_month"] as double) >= 0 ? dangerColor : successColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCostBreakdown() {
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
            "Cost Breakdown by Category",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...costBreakdown.map((cost) => Container(
            padding: EdgeInsets.all(spSm),
            margin: EdgeInsets.only(bottom: spSm),
            decoration: BoxDecoration(
              color: (cost["color"] as Color).withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      cost["icon"] as IconData,
                      color: cost["color"] as Color,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${cost["category"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${(cost["percentage"] as double).toStringAsFixed(1)}% of total costs",
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
                          "\$${((cost["amount"] as double) / 1000).toStringAsFixed(0)}K",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: cost["color"] as Color,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              (cost["variance"] as double) >= 0 ? Icons.trending_up : Icons.trending_down,
                              size: 14,
                              color: (cost["variance"] as double) >= 0 ? dangerColor : successColor,
                            ),
                            Text(
                              "${(cost["variance"] as double) >= 0 ? '+' : ''}\$${((cost["variance"] as double).abs() / 1000).toStringAsFixed(1)}K",
                              style: TextStyle(
                                fontSize: 12,
                                color: (cost["variance"] as double) >= 0 ? dangerColor : successColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: ((cost["amount"] as double) / (cost["budget"] as double) * 100).round(),
                        child: Container(
                          decoration: BoxDecoration(
                            color: (cost["amount"] as double) <= (cost["budget"] as double) 
                                ? successColor 
                                : dangerColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 100 - ((cost["amount"] as double) / (cost["budget"] as double) * 100).round(),
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildMonthlyCostTrend() {
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
            "Monthly Cost Trend",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 40),
                    Expanded(
                      child: Text(
                        "Actual vs Budget",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 80,
                      child: Text(
                        "Variance",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                ...monthlyCosts.map((month) => Container(
                  padding: EdgeInsets.symmetric(vertical: spSm),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        child: Text(
                          "${month["month"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              height: 15,
                              decoration: BoxDecoration(
                                color: disabledColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: FractionallySizedBox(
                                widthFactor: (month["actual"] as double) / 150000,
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 2),
                            Container(
                              height: 15,
                              decoration: BoxDecoration(
                                color: disabledColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: FractionallySizedBox(
                                widthFactor: (month["budget"] as double) / 150000,
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: disabledBoldColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),
                      SizedBox(
                        width: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              (month["variance"] as double) >= 0 ? Icons.trending_up : Icons.trending_down,
                              size: 14,
                              color: (month["variance"] as double) >= 0 ? dangerColor : successColor,
                            ),
                            Text(
                              "${(month["variance"] as double) >= 0 ? '+' : ''}\$${((month["variance"] as double).abs() / 1000).toStringAsFixed(0)}K",
                              style: TextStyle(
                                fontSize: 10,
                                color: (month["variance"] as double) >= 0 ? dangerColor : successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCostOptimization() {
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
            "Cost Optimization Insights",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb,
                  color: warningColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Fuel costs are 9.5% above budget. Consider route optimization to reduce fuel consumption.",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.trending_down,
                  color: successColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Transportation costs are under budget by \$14.4K. Great job on route efficiency!",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "View Recommendations",
                  icon: Icons.recommend,
                  size: bs.sm,
                  onPressed: () {
                    si("Viewing cost optimization recommendations");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Export Analysis",
                  icon: Icons.download,
                  color: disabledBoldColor,
                  size: bs.sm,
                  onPressed: () {
                    si("Exporting cost analysis report");
                  },
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
        title: Text("Cost Analysis"),
        actions: [
          QButton(
            icon: Icons.calculate,
            size: bs.sm,
            onPressed: () {
              si("Opening cost calculator");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildFilters(),
            _buildCostSummary(),
            _buildCostBreakdown(),
            _buildMonthlyCostTrend(),
            _buildCostOptimization(),
          ],
        ),
      ),
    );
  }
}
