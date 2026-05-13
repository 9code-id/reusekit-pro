import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaBudgetPlanningView extends StatefulWidget {
  const FmaBudgetPlanningView({super.key});

  @override
  State<FmaBudgetPlanningView> createState() => _FmaBudgetPlanningViewState();
}

class _FmaBudgetPlanningViewState extends State<FmaBudgetPlanningView> {
  List<Map<String, dynamic>> budgets = [
    {
      "category": "Marketing & Advertising",
      "budgeted": 5000.0,
      "spent": 3450.75,
      "remaining": 1549.25,
      "period": "Monthly",
      "startDate": "2024-06-01",
      "endDate": "2024-06-30",
      "status": "On Track",
      "transactions": 12,
    },
    {
      "category": "Office Supplies",
      "budgeted": 800.0,
      "spent": 945.30,
      "remaining": -145.30,
      "period": "Monthly",
      "startDate": "2024-06-01",
      "endDate": "2024-06-30",
      "status": "Over Budget",
      "transactions": 8,
    },
    {
      "category": "Software & Technology",
      "budgeted": 2500.0,
      "spent": 2156.89,
      "remaining": 343.11,
      "period": "Monthly",
      "startDate": "2024-06-01",
      "endDate": "2024-06-30",
      "status": "Warning",
      "transactions": 15,
    },
    {
      "category": "Travel & Transportation",
      "budgeted": 3000.0,
      "spent": 1245.67,
      "remaining": 1754.33,
      "period": "Monthly",
      "startDate": "2024-06-01",
      "endDate": "2024-06-30",
      "status": "On Track",
      "transactions": 5,
    },
    {
      "category": "Professional Services",
      "budgeted": 4000.0,
      "spent": 2800.00,
      "remaining": 1200.00,
      "period": "Monthly",
      "startDate": "2024-06-01",
      "endDate": "2024-06-30",
      "status": "On Track",
      "transactions": 6,
    },
  ];

  List<Map<String, dynamic>> budgetTemplates = [
    {
      "name": "Small Business Starter",
      "description": "Basic budget template for small businesses",
      "categories": 8,
      "totalBudget": 15000.0,
    },
    {
      "name": "E-commerce Business",
      "description": "Budget template for online retailers",
      "categories": 12,
      "totalBudget": 25000.0,
    },
    {
      "name": "Service Provider",
      "description": "Template for service-based businesses",
      "categories": 10,
      "totalBudget": 18000.0,
    },
    {
      "name": "Freelancer",
      "description": "Personal business budget for freelancers",
      "categories": 6,
      "totalBudget": 8000.0,
    },
  ];

  String selectedPeriod = "This Month";
  String selectedView = "Categories";
  bool showTemplates = false;

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Month", "value": "This Month"},
    {"label": "Next Month", "value": "Next Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> viewOptions = [
    {"label": "Categories", "value": "Categories"},
    {"label": "Performance", "value": "Performance"},
    {"label": "Trends", "value": "Trends"},
  ];

  @override
  Widget build(BuildContext context) {
    double totalBudgeted = budgets.fold(0.0, (sum, item) => sum + (item["budgeted"] as double));
    double totalSpent = budgets.fold(0.0, (sum, item) => sum + (item["spent"] as double));
    double totalRemaining = totalBudgeted - totalSpent;
    int overBudgetCount = budgets.where((budget) => budget["status"] == "Over Budget").length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Budget Planning"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                showTemplates = !showTemplates;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              ss("Budget report exported successfully");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Budget Templates (Collapsible)
            if (showTemplates)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: infoColor.withAlpha(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.add, color: infoColor),
                        SizedBox(width: spSm),
                        Text(
                          "Budget Templates",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showTemplates = false;
                            });
                          },
                          child: Icon(Icons.close, color: disabledBoldColor),
                        ),
                      ],
                    ),
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: budgetTemplates.map((template) {
                        return Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            border: Border.all(color: disabledOutlineBorderColor),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spSm,
                            children: [
                              Text(
                                "${template["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${template["description"]}",
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
                                          "Categories",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "${template["categories"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
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
                                          "Total Budget",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "\$${(template["totalBudget"] as double).currency}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              Container(
                                width: double.infinity,
                                child: QButton(
                                  label: "Use Template",
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Template applied successfully");
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

            // Filters
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
                SizedBox(width: spMd),
                Expanded(
                  child: QDropdownField(
                    label: "View",
                    items: viewOptions,
                    value: selectedView,
                    onChanged: (value, label) {
                      selectedView = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildSummaryCard(
                  "Total Budgeted",
                  "\$${totalBudgeted.currency}",
                  Icons.account_balance_wallet,
                  primaryColor,
                ),
                _buildSummaryCard(
                  "Total Spent",
                  "\$${totalSpent.currency}",
                  Icons.trending_down,
                  dangerColor,
                ),
                _buildSummaryCard(
                  "Remaining",
                  "\$${totalRemaining.currency}",
                  Icons.savings,
                  totalRemaining >= 0 ? successColor : dangerColor,
                ),
                _buildSummaryCard(
                  "Over Budget",
                  "${overBudgetCount} categories",
                  Icons.warning,
                  overBudgetCount > 0 ? dangerColor : successColor,
                ),
              ],
            ),

            // Budget Performance Chart
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(Icons.bar_chart, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Budget vs Actual",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Container(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: budgets.length,
                      itemBuilder: (context, index) {
                        final budget = budgets[index];
                        final budgetedAmount = budget["budgeted"] as double;
                        final spentAmount = budget["spent"] as double;
                        final maxAmount = budgets.map((b) => b["budgeted"] as double).reduce((a, b) => a > b ? a : b);
                        
                        final budgetedHeight = (budgetedAmount / maxAmount) * 140;
                        final spentHeight = (spentAmount / maxAmount) * 140;
                        
                        return Container(
                          width: 80,
                          margin: EdgeInsets.only(right: spMd),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "\$${(budgetedAmount / 1000).toStringAsFixed(1)}K",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Container(
                                width: 60,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 20,
                                          height: budgetedHeight,
                                          decoration: BoxDecoration(
                                            color: primaryColor.withAlpha(150),
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                        ),
                                        SizedBox(height: spXs),
                                        Text(
                                          "Budget",
                                          style: TextStyle(
                                            fontSize: 8,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 20,
                                          height: spentHeight,
                                          decoration: BoxDecoration(
                                            color: spentAmount > budgetedAmount ? dangerColor : successColor,
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                        ),
                                        SizedBox(height: spXs),
                                        Text(
                                          "Actual",
                                          style: TextStyle(
                                            fontSize: 8,
                                            color: spentAmount > budgetedAmount ? dangerColor : successColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "${budget["category"]}".split(' ')[0],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Budget Categories
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(Icons.category, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Budget Categories",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Add Category",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: budgets.map((budget) {
                      Color statusColor = budget["status"] == "On Track"
                          ? successColor
                          : budget["status"] == "Over Budget"
                              ? dangerColor
                              : warningColor;

                      double spentPercentage = (budget["spent"] as double) / (budget["budgeted"] as double);

                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          border: Border.all(color: disabledOutlineBorderColor),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Column(
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: statusColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusMd),
                                  ),
                                  child: Icon(
                                    budget["status"] == "On Track"
                                        ? Icons.check_circle
                                        : budget["status"] == "Over Budget"
                                            ? Icons.warning
                                            : Icons.info,
                                    color: statusColor,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${budget["category"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${budget["period"]} • ${budget["transactions"]} transactions",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
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
                                    "${budget["status"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: statusColor,
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
                                    children: [
                                      Text(
                                        "Budgeted",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(budget["budgeted"] as double).currency}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
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
                                        "Spent",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(budget["spent"] as double).currency}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
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
                                        "Remaining",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${(budget["remaining"] as double) >= 0 ? "" : "-"}\$${((budget["remaining"] as double).abs()).currency}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: (budget["remaining"] as double) >= 0 ? successColor : dangerColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: disabledColor,
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: FractionallySizedBox(
                                          alignment: Alignment.centerLeft,
                                          widthFactor: spentPercentage > 1.0 ? 1.0 : spentPercentage,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: statusColor,
                                              borderRadius: BorderRadius.circular(radiusSm),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "${(spentPercentage * 100).toStringAsFixed(0)}%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: statusColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spSm),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Period: ${DateTime.parse(budget["startDate"]).dMMMy} - ${DateTime.parse(budget["endDate"]).dMMMy}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ),
                                    QButton(
                                      label: "Edit",
                                      size: bs.sm,
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
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
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Spacer(),
              Icon(Icons.trending_up, color: successColor, size: 16),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
