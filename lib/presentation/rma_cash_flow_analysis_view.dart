import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaCashFlowAnalysisView extends StatefulWidget {
  const RmaCashFlowAnalysisView({super.key});

  @override
  State<RmaCashFlowAnalysisView> createState() => _RmaCashFlowAnalysisViewState();
}

class _RmaCashFlowAnalysisViewState extends State<RmaCashFlowAnalysisView> {
  String selectedProperty = "All Properties";
  String selectedPeriod = "monthly";
  int currentTab = 0;

  List<Map<String, dynamic>> propertyOptions = [
    {"label": "All Properties", "value": "all"},
    {"label": "Sunset Apartments", "value": "sunset"},
    {"label": "Downtown Office Complex", "value": "downtown"},
    {"label": "Marina Plaza", "value": "marina"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Monthly", "value": "monthly"},
    {"label": "Quarterly", "value": "quarterly"},
    {"label": "Yearly", "value": "yearly"},
  ];

  List<Map<String, dynamic>> cashFlowData = [
    {
      "month": "January",
      "rental_income": 45000,
      "operating_expenses": 12000,
      "maintenance": 3500,
      "net_cash_flow": 29500,
      "properties": [
        {"name": "Sunset Apartments", "income": 25000, "expenses": 7000},
        {"name": "Downtown Office", "income": 20000, "expenses": 5000},
      ]
    },
    {
      "month": "February",
      "rental_income": 47500,
      "operating_expenses": 11800,
      "maintenance": 4200,
      "net_cash_flow": 31500,
      "properties": [
        {"name": "Sunset Apartments", "income": 25000, "expenses": 6800},
        {"name": "Downtown Office", "income": 22500, "expenses": 5000},
      ]
    },
    {
      "month": "March",
      "rental_income": 46200,
      "operating_expenses": 13200,
      "maintenance": 2800,
      "net_cash_flow": 30200,
      "properties": [
        {"name": "Sunset Apartments", "income": 24200, "expenses": 8200},
        {"name": "Downtown Office", "income": 22000, "expenses": 5000},
      ]
    },
  ];

  List<Map<String, dynamic>> forecastData = [
    {"period": "Q2 2024", "projected_income": 142500, "projected_expenses": 38000, "net_projection": 104500},
    {"period": "Q3 2024", "projected_income": 145000, "projected_expenses": 36500, "net_projection": 108500},
    {"period": "Q4 2024", "projected_income": 148000, "projected_expenses": 39000, "net_projection": 109000},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Cash Flow Analysis",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.analytics)),
        Tab(text: "Properties", icon: Icon(Icons.business)),
        Tab(text: "Forecast", icon: Icon(Icons.trending_up)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildPropertiesTab(),
        _buildForecastTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildFilters(),
          _buildSummaryCards(),
          _buildCashFlowChart(),
          _buildMonthlyBreakdown(),
        ],
      ),
    );
  }

  Widget _buildPropertiesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildPropertyComparison(),
          _buildPropertyPerformance(),
        ],
      ),
    );
  }

  Widget _buildForecastTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildForecastCards(),
          _buildForecastChart(),
          _buildScenarioAnalysis(),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Row(
      spacing: spMd,
      children: [
        Expanded(
          child: QDropdownField(
            label: "Property",
            items: propertyOptions,
            value: selectedProperty,
            onChanged: (value, label) {
              selectedProperty = value;
              setState(() {});
            },
          ),
        ),
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
    );
  }

  Widget _buildSummaryCards() {
    double totalIncome = cashFlowData.fold(0.0, (sum, item) => sum + (item["rental_income"] as int).toDouble());
    double totalExpenses = cashFlowData.fold(0.0, (sum, item) => sum + ((item["operating_expenses"] as int) + (item["maintenance"] as int)).toDouble());
    double netCashFlow = totalIncome - totalExpenses;
    double profitMargin = (netCashFlow / totalIncome) * 100;

    return ResponsiveGridView(
      minItemWidth: 200,
      children: [
        _buildSummaryCard("Total Income", totalIncome.currency, Icons.attach_money, successColor),
        _buildSummaryCard("Total Expenses", totalExpenses.currency, Icons.money_off, dangerColor),
        _buildSummaryCard("Net Cash Flow", netCashFlow.currency, Icons.trending_up, primaryColor),
        _buildSummaryCard("Profit Margin", "${profitMargin.toStringAsFixed(1)}%", Icons.percent, infoColor),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spLg),
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
                  color: color.withAlpha(20),
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
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCashFlowChart() {
    return Container(
      padding: EdgeInsets.all(spLg),
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
              Text(
                "Cash Flow Trend",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spLg),
          Container(
            height: 200,
            child: Stack(
              children: [
                // Chart placeholder
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.show_chart,
                        size: 48,
                        color: primaryColor.withAlpha(60),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Cash Flow Chart",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildLegendItem("Income", successColor),
              _buildLegendItem("Expenses", dangerColor),
              _buildLegendItem("Net Flow", primaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
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
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildMonthlyBreakdown() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Monthly Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spLg),
          ...cashFlowData.map((month) => _buildMonthRow(month)),
        ],
      ),
    );
  }

  Widget _buildMonthRow(Map<String, dynamic> month) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: (month["net_cash_flow"] as int) > 30000 ? successColor : warningColor,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${month["month"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "${((month["net_cash_flow"] as int).toDouble()).currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: (month["net_cash_flow"] as int) > 30000 ? successColor : warningColor,
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
                      "Income: ${((month["rental_income"] as int).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Expenses: ${(((month["operating_expenses"] as int) + (month["maintenance"] as int)).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                (month["net_cash_flow"] as int) > 30000 ? Icons.trending_up : Icons.trending_flat,
                color: (month["net_cash_flow"] as int) > 30000 ? successColor : warningColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyComparison() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Property Performance Comparison",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spLg),
          ...cashFlowData[0]["properties"].map((property) => _buildPropertyRow(property)),
        ],
      ),
    );
  }

  Widget _buildPropertyRow(Map<String, dynamic> property) {
    double netIncome = (property["income"] as int).toDouble() - (property["expenses"] as int).toDouble();
    double roi = (netIncome / (property["income"] as int).toDouble()) * 100;

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${property["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "${roi.toStringAsFixed(1)}% ROI",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: roi > 70 ? successColor : warningColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Income: ${((property["income"] as int).toDouble()).currency}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Text(
                "Net: ${netIncome.currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyPerformance() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Performance Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spLg),
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.bar_chart,
                  size: 48,
                  color: primaryColor.withAlpha(60),
                ),
                SizedBox(height: spSm),
                Text(
                  "Property Performance Chart",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForecastCards() {
    return ResponsiveGridView(
      minItemWidth: 200,
      children: forecastData.map((forecast) {
        return Container(
          padding: EdgeInsets.all(spLg),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${forecast["period"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              Text(
                "Projected Income",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "${((forecast["projected_income"] as int).toDouble()).currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Net Projection",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "${((forecast["net_projection"] as int).toDouble()).currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildForecastChart() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Forecast Trend",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spLg),
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.timeline,
                  size: 48,
                  color: primaryColor.withAlpha(60),
                ),
                SizedBox(height: spSm),
                Text(
                  "Cash Flow Forecast Chart",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScenarioAnalysis() {
    List<Map<String, dynamic>> scenarios = [
      {"name": "Conservative", "growth": 2.5, "risk": "Low", "color": successColor},
      {"name": "Moderate", "growth": 5.0, "risk": "Medium", "color": warningColor},
      {"name": "Aggressive", "growth": 8.5, "risk": "High", "color": dangerColor},
    ];

    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Scenario Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spLg),
          ...scenarios.map((scenario) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: (scenario["color"] as Color).withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: scenario["color"] as Color,
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
                        "${scenario["name"]} Scenario",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Growth: ${(scenario["growth"] as double).toStringAsFixed(1)}% • Risk: ${scenario["risk"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.trending_up,
                  color: scenario["color"] as Color,
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
