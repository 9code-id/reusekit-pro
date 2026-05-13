import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaBudgetView extends StatefulWidget {
  const EmaBudgetView({super.key});

  @override
  State<EmaBudgetView> createState() => _EmaBudgetViewState();
}

class _EmaBudgetViewState extends State<EmaBudgetView> {
  String selectedPeriod = "This Month";
  String selectedBudgetType = "All Budgets";
  List<String> periods = ["This Month", "This Quarter", "This Year"];
  List<String> budgetTypes = ["All Budgets", "Department", "Project", "Category"];
  
  List<Map<String, dynamic>> budgets = [
    {
      "id": 1,
      "name": "Marketing Department",
      "type": "Department",
      "allocated": 15000.0,
      "spent": 8750.25,
      "remaining": 6249.75,
      "period": "Monthly",
      "startDate": "2025-06-01",
      "endDate": "2025-06-30",
      "status": "On Track",
      "lastUpdated": "2025-06-18",
      "categories": ["Digital Ads", "Content Creation", "Events"],
      "alerts": [],
    },
    {
      "id": 2,
      "name": "Office Supplies",
      "type": "Category",
      "allocated": 2500.0,
      "spent": 2850.50,
      "remaining": -350.50,
      "period": "Monthly",
      "startDate": "2025-06-01",
      "endDate": "2025-06-30",
      "status": "Over Budget",
      "lastUpdated": "2025-06-17",
      "categories": ["Stationery", "Equipment", "Furniture"],
      "alerts": ["Budget exceeded by 14%"],
    },
    {
      "id": 3,
      "name": "Website Redesign",
      "type": "Project",
      "allocated": 25000.0,
      "spent": 18200.75,
      "remaining": 6799.25,
      "period": "Project",
      "startDate": "2025-04-01",
      "endDate": "2025-08-31",
      "status": "On Track",
      "lastUpdated": "2025-06-16",
      "categories": ["Design", "Development", "Testing"],
      "alerts": [],
    },
    {
      "id": 4,
      "name": "HR Department",
      "type": "Department",
      "allocated": 12000.0,
      "spent": 5450.30,
      "remaining": 6549.70,
      "period": "Monthly",
      "startDate": "2025-06-01",
      "endDate": "2025-06-30",
      "status": "Under Budget",
      "lastUpdated": "2025-06-15",
      "categories": ["Recruitment", "Training", "Benefits"],
      "alerts": [],
    },
    {
      "id": 5,
      "name": "Travel & Expenses",
      "type": "Category",
      "allocated": 8000.0,
      "spent": 7125.80,
      "remaining": 874.20,
      "period": "Monthly",
      "startDate": "2025-06-01",
      "endDate": "2025-06-30",
      "status": "Near Limit",
      "lastUpdated": "2025-06-14",
      "categories": ["Flights", "Hotels", "Meals"],
      "alerts": ["89% of budget used"],
    },
    {
      "id": 6,
      "name": "Software Licenses",
      "type": "Category",
      "allocated": 5000.0,
      "spent": 3750.00,
      "remaining": 1250.00,
      "period": "Monthly",
      "startDate": "2025-06-01",
      "endDate": "2025-06-30",
      "status": "On Track",
      "lastUpdated": "2025-06-13",
      "categories": ["Productivity", "Design", "Development"],
      "alerts": [],
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredBudgets = budgets.where((budget) {
      if (selectedBudgetType == "All Budgets") return true;
      return budget["type"] == selectedBudgetType;
    }).toList();

    double totalAllocated = filteredBudgets.fold(0.0, (sum, budget) => sum + (budget["allocated"] as double));
    double totalSpent = filteredBudgets.fold(0.0, (sum, budget) => sum + (budget["spent"] as double));
    double totalRemaining = filteredBudgets.fold(0.0, (sum, budget) => sum + (budget["remaining"] as double));
    int overBudgetCount = filteredBudgets.where((b) => b["status"] == "Over Budget").length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Budget Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_chart),
            onPressed: () {
              // navigateTo('CreateBudgetView')
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // navigateTo('BudgetSettingsView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Period",
                    items: periods.map((period) => {
                      "label": period,
                      "value": period,
                    }).toList(),
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
                    label: "Budget Type",
                    items: budgetTypes.map((type) => {
                      "label": type,
                      "value": type,
                    }).toList(),
                    value: selectedBudgetType,
                    onChanged: (value, label) {
                      selectedBudgetType = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Budget Summary Cards
            ResponsiveGridView(
              minItemWidth: 200,
              children: [
                _buildSummaryCard(
                  title: "Total Allocated",
                  value: "\$${totalAllocated.currency}",
                  icon: Icons.account_balance,
                  color: primaryColor,
                  subtitle: "${filteredBudgets.length} budgets",
                ),
                _buildSummaryCard(
                  title: "Total Spent",
                  value: "\$${totalSpent.currency}",
                  icon: Icons.trending_down,
                  color: warningColor,
                  subtitle: "${((totalSpent / totalAllocated) * 100).toStringAsFixed(1)}% used",
                ),
                _buildSummaryCard(
                  title: "Remaining",
                  value: "\$${totalRemaining.currency}",
                  icon: Icons.savings,
                  color: totalRemaining >= 0 ? successColor : dangerColor,
                  subtitle: "${((totalRemaining / totalAllocated) * 100).toStringAsFixed(1)}% left",
                ),
                _buildSummaryCard(
                  title: "Over Budget",
                  value: "${overBudgetCount}",
                  icon: Icons.warning,
                  color: dangerColor,
                  subtitle: "Needs attention",
                ),
              ],
            ),

            // Budget Alerts
            if (budgets.any((b) => (b["alerts"] as List).isNotEmpty))
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: warningColor.withAlpha(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.notification_important,
                          color: warningColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Budget Alerts",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    ...budgets
                        .where((b) => (b["alerts"] as List).isNotEmpty)
                        .map((budget) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: warningColor.withAlpha(30)),
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${budget["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  ...(budget["alerts"] as List).map((alert) {
                                    return Text(
                                      "${alert}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    );
                                  }).toList(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),

            // Budget Overview Chart
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.bar_chart,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Budget vs Actual Spending",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  _buildBudgetChart(),
                ],
              ),
            ),

            // Budget List
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.list,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Budget Details",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          // navigateTo('AllBudgetsView')
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...filteredBudgets.map((budget) {
                    Color statusColor = _getStatusColor(budget["status"]);
                    double percentage = (budget["allocated"] as double) > 0 
                        ? ((budget["spent"] as double) / (budget["allocated"] as double)) * 100 
                        : 0;
                    
                    return Container(
                      padding: EdgeInsets.all(spMd),
                      margin: EdgeInsets.only(bottom: spMd),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: statusColor.withAlpha(20)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: _getTypeColor(budget["type"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  _getTypeIcon(budget["type"]),
                                  color: _getTypeColor(budget["type"]),
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${budget["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${budget["type"]} • ${budget["period"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: statusColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${budget["status"]}",
                                      style: TextStyle(
                                        color: statusColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${percentage.toStringAsFixed(1)}% used",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // Budget Progress Bar
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Spent: \$${(budget["spent"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Budget: \$${(budget["allocated"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Container(
                                height: 8,
                                decoration: BoxDecoration(
                                  color: disabledColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: percentage > 100 ? 1.0 : percentage / 100,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: percentage > 100 ? dangerColor : statusColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Categories
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (budget["categories"] as List).map((category) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(15),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${category}",
                                  style: TextStyle(
                                    color: infoColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {
                                    // navigateTo('BudgetDetailsView')
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.edit,
                                size: bs.sm,
                                onPressed: () {
                                  // navigateTo('EditBudgetView')
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ResponsiveGridView(
                    minItemWidth: 200,
                    children: [
                      QButton(
                        label: "Create Budget",
                        size: bs.sm,
                        onPressed: () {
                          // navigateTo('CreateBudgetView')
                        },
                      ),
                      QButton(
                        label: "Budget Report",
                        size: bs.sm,
                        onPressed: () {
                          // navigateTo('BudgetReportView')
                        },
                      ),
                      QButton(
                        label: "Forecast",
                        size: bs.sm,
                        onPressed: () {
                          // navigateTo('BudgetForecastView')
                        },
                      ),
                      QButton(
                        label: "Export Data",
                        size: bs.sm,
                        onPressed: () {
                          // navigateTo('ExportBudgetView')
                        },
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

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required String subtitle,
  }) {
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
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetChart() {
    return Container(
      height: 200,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(budgets.length.clamp(0, 6), (index) {
          var budget = budgets[index];
          double allocated = budget["allocated"] as double;
          double spent = budget["spent"] as double;
          double maxValue = budgets.map((b) => b["allocated"] as double).reduce((a, b) => a > b ? a : b);
          
          double allocatedHeight = (allocated / maxValue) * 160;
          double spentHeight = (spent / maxValue) * 160;
          
          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: allocatedHeight,
                          margin: EdgeInsets.only(right: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(100),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: spentHeight,
                          margin: EdgeInsets.only(left: 2),
                          decoration: BoxDecoration(
                            color: spent > allocated ? dangerColor : warningColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${budget["name"]}".length > 8 
                        ? "${budget["name"]}".substring(0, 8) + "..."
                        : "${budget["name"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "On Track":
        return successColor;
      case "Near Limit":
        return warningColor;
      case "Over Budget":
        return dangerColor;
      case "Under Budget":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Department":
        return primaryColor;
      case "Project":
        return infoColor;
      case "Category":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "Department":
        return Icons.groups;
      case "Project":
        return Icons.folder;
      case "Category":
        return Icons.category;
      default:
        return Icons.account_balance;
    }
  }
}
