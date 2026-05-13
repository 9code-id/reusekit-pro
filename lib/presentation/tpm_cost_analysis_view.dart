import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmCostAnalysisView extends StatefulWidget {
  const TpmCostAnalysisView({super.key});

  @override
  State<TpmCostAnalysisView> createState() => _TpmCostAnalysisViewState();
}

class _TpmCostAnalysisViewState extends State<TpmCostAnalysisView> {
  int selectedPeriod = 0;
  String selectedProject = "all_projects";
  bool showDetails = false;

  List<Map<String, dynamic>> periods = [
    {"label": "This Month", "value": 0},
    {"label": "Last 3 Months", "value": 1},
    {"label": "Last 6 Months", "value": 2},
    {"label": "This Year", "value": 3},
  ];

  List<Map<String, dynamic>> projects = [
    {"label": "All Projects", "value": "all_projects"},
    {"label": "Mobile App Development", "value": "mobile_app"},
    {"label": "Web Platform", "value": "web_platform"},
    {"label": "AI Integration", "value": "ai_integration"},
    {"label": "Cloud Migration", "value": "cloud_migration"},
  ];

  List<Map<String, dynamic>> costData = [
    {
      "category": "Personnel",
      "budgeted": 150000,
      "actual": 142000,
      "variance": -8000,
      "percentage": 94.7,
      "icon": Icons.people,
      "color": Colors.blue,
    },
    {
      "category": "Infrastructure",
      "budgeted": 85000,
      "actual": 92000,
      "variance": 7000,
      "percentage": 108.2,
      "icon": Icons.cloud,
      "color": Colors.green,
    },
    {
      "category": "Software Licenses",
      "budgeted": 45000,
      "actual": 43500,
      "variance": -1500,
      "percentage": 96.7,
      "icon": Icons.computer,
      "color": Colors.orange,
    },
    {
      "category": "Equipment",
      "budgeted": 30000,
      "actual": 35000,
      "variance": 5000,
      "percentage": 116.7,
      "icon": Icons.devices,
      "color": Colors.purple,
    },
    {
      "category": "Training",
      "budgeted": 20000,
      "actual": 18500,
      "variance": -1500,
      "percentage": 92.5,
      "icon": Icons.school,
      "color": Colors.teal,
    },
    {
      "category": "Marketing",
      "budgeted": 25000,
      "actual": 28000,
      "variance": 3000,
      "percentage": 112.0,
      "icon": Icons.campaign,
      "color": Colors.red,
    },
  ];

  List<Map<String, dynamic>> projectBreakdown = [
    {
      "project": "Mobile App Development",
      "budget": 180000,
      "spent": 165000,
      "remaining": 15000,
      "progress": 92,
      "status": "On Track",
      "color": successColor,
    },
    {
      "project": "Web Platform",
      "budget": 220000,
      "spent": 185000,
      "remaining": 35000,
      "progress": 84,
      "status": "Under Budget",
      "color": primaryColor,
    },
    {
      "project": "AI Integration",
      "budget": 150000,
      "spent": 160000,
      "remaining": -10000,
      "progress": 107,
      "status": "Over Budget",
      "color": dangerColor,
    },
    {
      "project": "Cloud Migration",
      "budget": 95000,
      "spent": 72000,
      "remaining": 23000,
      "progress": 76,
      "status": "On Track",
      "color": successColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cost Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Cost report exported successfully");
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
            _buildSummaryCards(),
            _buildCostChart(),
            _buildCategoryBreakdown(),
            _buildProjectBreakdown(),
            if (showDetails) _buildDetailedAnalysis(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  label: "Time Period",
                  items: periods,
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
                  label: "Project",
                  items: projects,
                  value: selectedProject,
                  onChanged: (value, label) {
                    selectedProject = value;
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

  Widget _buildSummaryCards() {
    double totalBudget = costData.fold(0.0, (sum, item) => sum + (item["budgeted"] as int).toDouble());
    double totalActual = costData.fold(0.0, (sum, item) => sum + (item["actual"] as int).toDouble());
    double totalVariance = totalActual - totalBudget;
    double variancePercentage = ((totalVariance / totalBudget) * 100);

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spXs,
              children: [
                Icon(
                  Icons.account_balance_wallet,
                  color: primaryColor,
                  size: 32,
                ),
                Text(
                  "Total Budget",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "\$${(totalBudget).currency}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spXs,
              children: [
                Icon(
                  Icons.money_off,
                  color: warningColor,
                  size: 32,
                ),
                Text(
                  "Actual Spent",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "\$${(totalActual).currency}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spXs,
              children: [
                Icon(
                  totalVariance >= 0 ? Icons.trending_up : Icons.trending_down,
                  color: totalVariance >= 0 ? dangerColor : successColor,
                  size: 32,
                ),
                Text(
                  "Variance",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${totalVariance >= 0 ? '+' : ''}\$${totalVariance.abs().currency}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: totalVariance >= 0 ? dangerColor : successColor,
                  ),
                ),
                Text(
                  "${variancePercentage >= 0 ? '+' : ''}${variancePercentage.toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 10,
                    color: totalVariance >= 0 ? dangerColor : successColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCostChart() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Budget vs Actual Spending",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: showDetails ? "Hide Details" : "Show Details",
                size: bs.sm,
                onPressed: () {
                  showDetails = !showDetails;
                  setState(() {});
                },
              ),
            ],
          ),
          Container(
            height: 200,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.bar_chart,
                  size: 64,
                  color: primaryColor.withAlpha(100),
                ),
                SizedBox(height: spSm),
                Text(
                  "Interactive Cost Chart",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Budget vs Actual comparison by category",
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

  Widget _buildCategoryBreakdown() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Cost Breakdown by Category",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...costData.map((category) {
            bool isOverBudget = (category["percentage"] as double) > 100;
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: (category["color"] as Color).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: (category["color"] as Color).withAlpha(50),
                ),
              ),
              child: Column(
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Icon(
                        category["icon"] as IconData,
                        color: category["color"] as Color,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${category["category"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        "${(category["percentage"] as double).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isOverBudget ? dangerColor : successColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          spacing: spXxs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Budget: \$${((category["budgeted"] as int).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Actual: \$${((category["actual"] as int).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: isOverBudget ? dangerColor : successColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${(category["variance"] as int) >= 0 ? '+' : ''}\$${((category["variance"] as int).abs().toDouble()).currency}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  LinearProgressIndicator(
                    value: (category["percentage"] as double) / 100,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(category["color"] as Color),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildProjectBreakdown() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Project Budget Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...projectBreakdown.map((project) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${project["project"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: project["color"] as Color,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${project["status"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          spacing: spXxs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Budget: \$${((project["budget"] as int).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Spent: \$${((project["spent"] as int).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${(project["remaining"] as int) >= 0 ? '\$' : '-\$'}${((project["remaining"] as int).abs().toDouble()).currency} remaining",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: (project["remaining"] as int) >= 0 ? successColor : dangerColor,
                        ),
                      ),
                    ],
                  ),
                  LinearProgressIndicator(
                    value: (project["progress"] as int) / 100,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(project["color"] as Color),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildDetailedAnalysis() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Detailed Cost Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.analytics, color: infoColor, size: 20),
                    SizedBox(width: spSm),
                    Text(
                      "Key Insights",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "• Personnel costs are 5.3% under budget, showing efficient resource allocation",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "• Infrastructure spending is 8.2% over budget due to increased cloud usage",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "• Equipment costs exceeded budget by 16.7% due to hardware upgrades",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "• Overall project costs are within 2% of total budget allocation",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Generate Report",
                  size: bs.sm,
                  onPressed: () {
                    ss("Detailed cost report generated");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Schedule Review",
                  size: bs.sm,
                  icon: Icons.schedule,
                  onPressed: () {
                    ss("Cost review meeting scheduled");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
