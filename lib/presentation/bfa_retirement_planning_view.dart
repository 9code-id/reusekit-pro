import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';
import 'dart:math' as Math;

class BfaRetirementPlanningView extends StatefulWidget {
  const BfaRetirementPlanningView({super.key});

  @override
  State<BfaRetirementPlanningView> createState() => _BfaRetirementPlanningViewState();
}

class _BfaRetirementPlanningViewState extends State<BfaRetirementPlanningView> {
  int currentTab = 0;
  int currentAge = 35;
  int retirementAge = 65;
  double currentSavings = 125000.0;
  double monthlyContribution = 1200.0;
  double desiredIncome = 80000.0;
  String riskTolerance = "Moderate";
  
  List<Map<String, dynamic>> riskLevels = [
    {"label": "Conservative", "value": "Conservative"},
    {"label": "Moderate", "value": "Moderate"},
    {"label": "Aggressive", "value": "Aggressive"},
  ];

  List<Map<String, dynamic>> accounts = [
    {
      "name": "401(k)",
      "balance": 75000.0,
      "contribution": 800.0,
      "employer_match": 400.0,
      "type": "Employer Sponsored",
      "icon": Icons.business,
      "color": primaryColor,
    },
    {
      "name": "Traditional IRA",
      "balance": 35000.0,
      "contribution": 300.0,
      "employer_match": 0.0,
      "type": "Individual",
      "icon": Icons.account_balance,
      "color": successColor,
    },
    {
      "name": "Roth IRA",
      "balance": 15000.0,
      "contribution": 100.0,
      "employer_match": 0.0,
      "type": "Individual",
      "icon": Icons.savings,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> projectionData = [
    {"age": 35, "balance": 125000.0},
    {"age": 40, "balance": 195000.0},
    {"age": 45, "balance": 285000.0},
    {"age": 50, "balance": 395000.0},
    {"age": 55, "balance": 535000.0},
    {"age": 60, "balance": 715000.0},
    {"age": 65, "balance": 950000.0},
  ];

  List<Map<String, dynamic>> strategies = [
    {
      "title": "Maximize Employer Match",
      "description": "Contribute enough to get full employer 401(k) match",
      "priority": "High",
      "impact": "+\$4,800/year",
      "icon": Icons.trending_up,
      "color": successColor,
    },
    {
      "title": "Increase Contribution Rate",
      "description": "Raise monthly contributions by 1% annually",
      "priority": "Medium",
      "impact": "+\$125,000 at retirement",
      "icon": Icons.arrow_upward,
      "color": warningColor,
    },
    {
      "title": "Diversify Investments",
      "description": "Spread investments across different asset classes",
      "priority": "Medium",
      "impact": "Reduced risk",
      "icon": Icons.pie_chart,
      "color": infoColor,
    },
    {
      "title": "Consider Roth Conversion",
      "description": "Convert traditional IRA to Roth for tax-free growth",
      "priority": "Low",
      "impact": "Tax efficiency",
      "icon": Icons.compare_arrows,
      "color": primaryColor,
    },
  ];

  List<Map<String, dynamic>> milestones = [
    {
      "age": 30,
      "target": "1x annual salary",
      "amount": 60000.0,
      "status": "completed",
    },
    {
      "age": 35,
      "target": "2x annual salary",
      "amount": 120000.0,
      "status": "completed",
    },
    {
      "age": 40,
      "target": "3x annual salary",
      "amount": 180000.0,
      "status": "on_track",
    },
    {
      "age": 50,
      "target": "6x annual salary",
      "amount": 360000.0,
      "status": "pending",
    },
    {
      "age": 60,
      "target": "8x annual salary",
      "amount": 480000.0,
      "status": "pending",
    },
    {
      "age": 67,
      "target": "10x annual salary",
      "amount": 600000.0,
      "status": "pending",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Retirement Planning",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Calculator", icon: Icon(Icons.calculate)),
        Tab(text: "Accounts", icon: Icon(Icons.account_balance)),
        Tab(text: "Strategies", icon: Icon(Icons.lightbulb)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildCalculatorTab(),
        _buildAccountsTab(),
        _buildStrategiesTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    double projectedBalance = _calculateProjectedBalance();
    double monthlyIncomeAtRetirement = projectedBalance * 0.04 / 12;
    int yearsToRetirement = retirementAge - currentAge;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                  size: 32,
                ),
                Text(
                  "Projected Retirement Balance",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withAlpha(230),
                  ),
                ),
                Text(
                  "\$${projectedBalance.currency}",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "At age $retirementAge ($yearsToRetirement years from now)",
                  style: TextStyle(
                    color: Colors.white.withAlpha(230),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildMetricCard("Current Savings", "\$${currentSavings.currency}", successColor, Icons.savings),
              _buildMetricCard("Monthly Income", "\$${monthlyIncomeAtRetirement.currency}", infoColor, Icons.monetization_on),
              _buildMetricCard("Years to Retirement", "$yearsToRetirement years", warningColor, Icons.schedule),
              _buildMetricCard("Monthly Savings", "\$${monthlyContribution.currency}", primaryColor, Icons.trending_up),
            ],
          ),

          Text(
            "Retirement Milestones",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: milestones.map((milestone) {
                Color statusColor = _getMilestoneColor(milestone["status"] as String);
                IconData statusIcon = _getMilestoneIcon(milestone["status"] as String);
                
                return Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(30),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        statusIcon,
                        color: statusColor,
                        size: 16,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Age ${milestone["age"]} - ${milestone["target"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "\$${(milestone["amount"] as double).currency}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${milestone["status"]}".replaceAll('_', ' ').toUpperCase(),
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),

          Text(
            "Projection Chart",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          Container(
            width: double.infinity,
            height: 200,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: QHorizontalScroll(
              children: projectionData.map((data) {
                double balance = data["balance"] as double;
                int age = data["age"] as int;
                bool isCurrent = age == currentAge;
                
                return Container(
                  width: 80,
                  margin: EdgeInsets.only(right: spSm),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "\$${(balance / 1000).toStringAsFixed(0)}K",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isCurrent ? primaryColor : disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Container(
                        height: (balance / 1000000 * 120).clamp(10, 120),
                        width: 40,
                        decoration: BoxDecoration(
                          color: isCurrent ? primaryColor : primaryColor.withAlpha(100),
                          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusXs)),
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$age",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isCurrent ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: infoColor.withAlpha(60)),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Icon(
                  Icons.info_outline,
                  color: infoColor,
                  size: 24,
                ),
                Text(
                  "Retirement Readiness",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  _getRetirementReadinessMessage(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
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

  Widget _buildCalculatorTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Retirement Calculator",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              children: [
                Text(
                  "Personal Information",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Current Age",
                        value: currentAge.toString(),
                        onChanged: (value) {
                          currentAge = int.tryParse(value) ?? 35;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Retirement Age",
                        value: retirementAge.toString(),
                        onChanged: (value) {
                          retirementAge = int.tryParse(value) ?? 65;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QNumberField(
                  label: "Current Savings (\$)",
                  value: currentSavings.toString(),
                  onChanged: (value) {
                    currentSavings = double.tryParse(value) ?? 125000.0;
                    setState(() {});
                  },
                ),

                QNumberField(
                  label: "Monthly Contribution (\$)",
                  value: monthlyContribution.toString(),
                  onChanged: (value) {
                    monthlyContribution = double.tryParse(value) ?? 1200.0;
                    setState(() {});
                  },
                ),

                QNumberField(
                  label: "Desired Annual Income (\$)",
                  value: desiredIncome.toString(),
                  onChanged: (value) {
                    desiredIncome = double.tryParse(value) ?? 80000.0;
                    setState(() {});
                  },
                ),

                QDropdownField(
                  label: "Risk Tolerance",
                  items: riskLevels,
                  value: riskTolerance,
                  onChanged: (value, label) {
                    riskTolerance = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: primaryColor.withAlpha(60)),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Retirement Projection",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Projected Balance",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "\$${_calculateProjectedBalance().currency}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Monthly Income",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "\$${(_calculateProjectedBalance() * 0.04 / 12).currency}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                LinearProgressIndicator(
                  value: (_calculateProjectedBalance() * 0.04 / desiredIncome).clamp(0, 1),
                  backgroundColor: disabledColor.withAlpha(60),
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),

                Text(
                  _getIncomeGapMessage(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              children: [
                Text(
                  "Scenario Analysis",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                _buildScenarioRow("Conservative (5% return)", _calculateScenario(0.05)),
                _buildScenarioRow("Moderate (7% return)", _calculateScenario(0.07)),
                _buildScenarioRow("Aggressive (9% return)", _calculateScenario(0.09)),
              ],
            ),
          ),

          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Calculation",
              icon: Icons.save,
              size: bs.md,
              onPressed: () {
                ss("Retirement calculation saved successfully!");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Retirement Accounts",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          ...accounts.map((account) {
            double balance = account["balance"] as double;
            double contribution = account["contribution"] as double;
            double employerMatch = account["employer_match"] as double;

            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: account["color"] as Color,
                  ),
                ),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (account["color"] as Color).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          account["icon"] as IconData,
                          color: account["color"] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${account["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${account["type"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "\$${balance.currency}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: account["color"] as Color,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Monthly Contribution",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "\$${contribution.currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (employerMatch > 0)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Employer Match",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "\$${employerMatch.currency}",
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
                          children: [
                            Text(
                              "Annual Growth",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "+\$${((contribution + employerMatch) * 12 * 0.07).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  if (employerMatch > 0)
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: successColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Free money! Employer matches your contributions",
                            style: TextStyle(
                              color: successColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          }).toList(),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: warningColor.withAlpha(60)),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Icon(
                  Icons.info_outline,
                  color: warningColor,
                  size: 24,
                ),
                Text(
                  "Contribution Limits 2024",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Column(
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Text(
                          "401(k): ",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "\$23,000 (\$30,500 if 50+)",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "IRA: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "\$7,000 (\$8,000 if 50+)",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            width: double.infinity,
            child: QButton(
              label: "Add New Account",
              icon: Icons.add,
              size: bs.md,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStrategiesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Optimization Strategies",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          ...strategies.map((strategy) {
            Color priorityColor = _getPriorityColor(strategy["priority"] as String);

            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: strategy["color"] as Color,
                  ),
                ),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (strategy["color"] as Color).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          strategy["icon"] as IconData,
                          color: strategy["color"] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${strategy["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${strategy["description"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: priorityColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${strategy["priority"]} Priority",
                          style: TextStyle(
                            color: priorityColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.trending_up,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Impact: ${strategy["impact"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Learn More",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            );
          }).toList(),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: infoColor.withAlpha(60)),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Icon(
                  Icons.psychology,
                  color: infoColor,
                  size: 24,
                ),
                Text(
                  "Smart Retirement Tips",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Column(
                  spacing: spXs,
                  children: [
                    _buildTipItem("Start early - time is your biggest advantage"),
                    _buildTipItem("Increase contributions with salary raises"),
                    _buildTipItem("Take advantage of catch-up contributions after 50"),
                    _buildTipItem("Consider tax diversification between accounts"),
                    _buildTipItem("Review and rebalance annually"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
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
          SizedBox(height: spSm),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScenarioRow(String scenario, double amount) {
    return Row(
      children: [
        Expanded(
          child: Text(
            scenario,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ),
        Text(
          "\$${amount.currency}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTipItem(String tip) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 6),
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            color: infoColor,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            tip,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  double _calculateProjectedBalance() {
    int years = retirementAge - currentAge;
    double annualContribution = monthlyContribution * 12;
    double rate = 0.07; // 7% average return
    
    // Future value calculation
    return currentSavings * Math.pow(1 + rate, years) + 
           annualContribution * ((Math.pow(1 + rate, years) - 1) / rate);
  }

  double _calculateScenario(double rate) {
    int years = retirementAge - currentAge;
    double annualContribution = monthlyContribution * 12;
    
    return currentSavings * Math.pow(1 + rate, years) + 
           annualContribution * ((Math.pow(1 + rate, years) - 1) / rate);
  }

  String _getRetirementReadinessMessage() {
    double projectedIncome = _calculateProjectedBalance() * 0.04;
    double ratio = projectedIncome / desiredIncome;
    
    if (ratio >= 1.0) {
      return "Excellent! You're on track to meet your retirement income goals.";
    } else if (ratio >= 0.8) {
      return "Good progress! Consider increasing contributions to reach your full goal.";
    } else if (ratio >= 0.6) {
      return "You're making progress but may need to adjust your strategy.";
    } else {
      return "Consider increasing contributions or extending your working years.";
    }
  }

  String _getIncomeGapMessage() {
    double projectedIncome = _calculateProjectedBalance() * 0.04;
    double gap = desiredIncome - projectedIncome;
    
    if (gap <= 0) {
      return "You're on track to exceed your income goal!";
    } else {
      return "Income gap: \$${gap.currency} annually";
    }
  }

  Color _getMilestoneColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "on_track":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getMilestoneIcon(String status) {
    switch (status) {
      case "completed":
        return Icons.check_circle;
      case "on_track":
        return Icons.schedule;
      default:
        return Icons.radio_button_unchecked;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      default:
        return infoColor;
    }
  }
}
