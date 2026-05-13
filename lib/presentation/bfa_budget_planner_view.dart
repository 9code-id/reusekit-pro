import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaBudgetPlannerView extends StatefulWidget {
  const BfaBudgetPlannerView({super.key});

  @override
  State<BfaBudgetPlannerView> createState() => _BfaBudgetPlannerViewState();
}

class _BfaBudgetPlannerViewState extends State<BfaBudgetPlannerView> {
  int currentTab = 0;
  double monthlyIncome = 5000.0;
  String selectedPeriod = "This Month";
  
  List<Map<String, dynamic>> periods = [
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> categories = [
    {
      "name": "Housing",
      "budgeted": 1500.0,
      "spent": 1450.0,
      "icon": Icons.home,
      "color": primaryColor,
      "subcategories": [
        {"name": "Rent/Mortgage", "amount": 1200.0},
        {"name": "Utilities", "amount": 150.0},
        {"name": "Internet", "amount": 60.0},
        {"name": "Insurance", "amount": 40.0},
      ],
    },
    {
      "name": "Transportation",
      "budgeted": 600.0,
      "spent": 720.0,
      "icon": Icons.directions_car,
      "color": warningColor,
      "subcategories": [
        {"name": "Car Payment", "amount": 350.0},
        {"name": "Gas", "amount": 200.0},
        {"name": "Insurance", "amount": 120.0},
        {"name": "Maintenance", "amount": 50.0},
      ],
    },
    {
      "name": "Food",
      "budgeted": 500.0,
      "spent": 425.0,
      "icon": Icons.restaurant,
      "color": successColor,
      "subcategories": [
        {"name": "Groceries", "amount": 300.0},
        {"name": "Dining Out", "amount": 125.0},
      ],
    },
    {
      "name": "Entertainment",
      "budgeted": 300.0,
      "spent": 180.0,
      "icon": Icons.movie,
      "color": infoColor,
      "subcategories": [
        {"name": "Streaming Services", "amount": 45.0},
        {"name": "Movies", "amount": 60.0},
        {"name": "Hobbies", "amount": 75.0},
      ],
    },
    {
      "name": "Shopping",
      "budgeted": 400.0,
      "spent": 520.0,
      "icon": Icons.shopping_bag,
      "color": dangerColor,
      "subcategories": [
        {"name": "Clothing", "amount": 200.0},
        {"name": "Electronics", "amount": 250.0},
        {"name": "Personal Care", "amount": 70.0},
      ],
    },
    {
      "name": "Healthcare",
      "budgeted": 200.0,
      "spent": 150.0,
      "icon": Icons.local_hospital,
      "color": successColor,
      "subcategories": [
        {"name": "Insurance Premium", "amount": 120.0},
        {"name": "Doctor Visits", "amount": 30.0},
      ],
    },
  ];

  List<Map<String, dynamic>> savingsGoals = [
    {
      "name": "Emergency Fund",
      "target": 10000.0,
      "current": 6500.0,
      "monthly_contribution": 500.0,
      "color": successColor,
      "icon": Icons.savings,
      "deadline": "2024-12-31",
    },
    {
      "name": "Vacation",
      "target": 3000.0,
      "current": 1200.0,
      "monthly_contribution": 300.0,
      "color": infoColor,
      "icon": Icons.flight,
      "deadline": "2024-08-15",
    },
    {
      "name": "New Car",
      "target": 25000.0,
      "current": 8500.0,
      "monthly_contribution": 750.0,
      "color": warningColor,
      "icon": Icons.directions_car,
      "deadline": "2025-06-30",
    },
    {
      "name": "Home Down Payment",
      "target": 50000.0,
      "current": 15000.0,
      "monthly_contribution": 1000.0,
      "color": primaryColor,
      "icon": Icons.home,
      "deadline": "2026-12-31",
    },
  ];

  List<Map<String, dynamic>> tips = [
    {
      "title": "Track Your Spending",
      "description": "Review your expenses weekly to stay on track",
      "icon": Icons.visibility,
      "category": "Monitoring",
    },
    {
      "title": "Use the 50/30/20 Rule",
      "description": "50% needs, 30% wants, 20% savings",
      "icon": Icons.pie_chart,
      "category": "Strategy",
    },
    {
      "title": "Automate Savings",
      "description": "Set up automatic transfers to savings accounts",
      "icon": Icons.autorenew,
      "category": "Automation",
    },
    {
      "title": "Review Monthly",
      "description": "Adjust your budget based on spending patterns",
      "icon": Icons.calendar_month,
      "category": "Review",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Budget Planner",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Categories", icon: Icon(Icons.category)),
        Tab(text: "Savings", icon: Icon(Icons.savings)),
        Tab(text: "Tips", icon: Icon(Icons.lightbulb)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildCategoriesTab(),
        _buildSavingsTab(),
        _buildTipsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    double totalBudgeted = categories.fold(0.0, (sum, cat) => sum + (cat["budgeted"] as double));
    double totalSpent = categories.fold(0.0, (sum, cat) => sum + (cat["spent"] as double));
    double remaining = totalBudgeted - totalSpent;

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
                Text(
                  "Monthly Budget",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withAlpha(230),
                  ),
                ),
                Text(
                  "\$${totalBudgeted.currency}",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      remaining >= 0 ? Icons.trending_up : Icons.trending_down,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      remaining >= 0 
                          ? "\$${remaining.currency} remaining"
                          : "\$${(-remaining).currency} over budget",
                      style: TextStyle(
                        color: Colors.white.withAlpha(230),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          QDropdownField(
            label: "Time Period",
            items: periods,
            value: selectedPeriod,
            onChanged: (value, label) {
              selectedPeriod = value;
              setState(() {});
            },
          ),

          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildSummaryCard("Income", monthlyIncome, successColor, Icons.trending_up),
              _buildSummaryCard("Spent", totalSpent, warningColor, Icons.shopping_cart),
              _buildSummaryCard("Budgeted", totalBudgeted, infoColor, Icons.account_balance),
              _buildSummaryCard("Remaining", remaining, remaining >= 0 ? successColor : dangerColor, 
                  remaining >= 0 ? Icons.savings : Icons.warning),
            ],
          ),

          Text(
            "Spending by Category",
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
              children: categories.map((category) {
                double spent = category["spent"] as double;
                double budgeted = category["budgeted"] as double;
                double percentage = (spent / budgeted * 100).clamp(0, 100);
                bool isOverBudget = spent > budgeted;

                return Column(
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: (category["color"] as Color).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            category["icon"] as IconData,
                            color: category["color"] as Color,
                            size: 16,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${category["name"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "\$${spent.currency}/\$${budgeted.currency}",
                          style: TextStyle(
                            fontSize: 12,
                            color: isOverBudget ? dangerColor : disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    LinearProgressIndicator(
                      value: percentage / 100,
                      backgroundColor: disabledColor.withAlpha(60),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isOverBudget ? dangerColor : category["color"] as Color,
                      ),
                    ),
                  ],
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
                  Icons.lightbulb_outline,
                  color: infoColor,
                  size: 24,
                ),
                Text(
                  "Budget Health Score",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  "${_calculateBudgetScore()}/100",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  _getBudgetScoreDescription(),
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

  Widget _buildCategoriesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Budget Categories",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          ...categories.map((category) {
            double spent = category["spent"] as double;
            double budgeted = category["budgeted"] as double;
            double remaining = budgeted - spent;
            bool isOverBudget = spent > budgeted;

            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: category["color"] as Color,
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
                          color: (category["color"] as Color).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          category["icon"] as IconData,
                          color: category["color"] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${category["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              isOverBudget 
                                  ? "\$${(-remaining).currency} over budget"
                                  : "\$${remaining.currency} remaining",
                              style: TextStyle(
                                color: isOverBudget ? dangerColor : successColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: isOverBudget ? dangerColor.withAlpha(20) : successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${((spent / budgeted) * 100).toStringAsFixed(0)}%",
                          style: TextStyle(
                            color: isOverBudget ? dangerColor : successColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
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
                              "Spent",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "\$${spent.currency}",
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
                              "Budgeted",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "\$${budgeted.currency}",
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
                              "Difference",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "${remaining >= 0 ? '+' : '-'}\$${remaining.abs().currency}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: remaining >= 0 ? successColor : dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  LinearProgressIndicator(
                    value: (spent / budgeted).clamp(0, 1),
                    backgroundColor: disabledColor.withAlpha(60),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isOverBudget ? dangerColor : category["color"] as Color,
                    ),
                  ),

                  if (category["subcategories"] != null) ...[
                    Text(
                      "Breakdown",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: (category["subcategories"] as List).map<Widget>((sub) {
                          return Row(
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: category["color"] as Color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${sub["name"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Text(
                                "\$${(sub["amount"] as double).currency}",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ],
              ),
            );
          }).toList(),

          Container(
            width: double.infinity,
            child: QButton(
              label: "Add New Category",
              icon: Icons.add,
              size: bs.md,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSavingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Savings Goals",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          ...savingsGoals.map((goal) {
            double current = goal["current"] as double;
            double target = goal["target"] as double;
            double progress = current / target;
            double monthly = goal["monthly_contribution"] as double;
            int monthsRemaining = ((target - current) / monthly).ceil();

            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: goal["color"] as Color,
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
                          color: (goal["color"] as Color).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          goal["icon"] as IconData,
                          color: goal["color"] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${goal["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Target: ${goal["deadline"]}",
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
                          color: (goal["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${(progress * 100).toStringAsFixed(0)}%",
                          style: TextStyle(
                            color: goal["color"] as Color,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
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
                              "Current",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "\$${current.currency}",
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
                              "Target",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "\$${target.currency}",
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
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "\$${(target - current).currency}",
                              style: TextStyle(
                                fontSize: 16,
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
                    value: progress.clamp(0, 1),
                    backgroundColor: disabledColor.withAlpha(60),
                    valueColor: AlwaysStoppedAnimation<Color>(goal["color"] as Color),
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
                          Icons.schedule,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "\$${monthly.currency}/month • $monthsRemaining months to goal",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
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
            child: QButton(
              label: "Add New Goal",
              icon: Icons.add,
              size: bs.md,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Budgeting Tips",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [successColor, successColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 32,
                ),
                Text(
                  "50/30/20 Rule",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Allocate 50% for needs, 30% for wants, and 20% for savings",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withAlpha(230),
                  ),
                ),
              ],
            ),
          ),

          ...tips.map((tip) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      tip["icon"] as IconData,
                      color: primaryColor,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${tip["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${tip["description"]}",
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
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${tip["category"]}",
                      style: TextStyle(
                        color: infoColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
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
                  Icons.warning_amber,
                  color: warningColor,
                  size: 24,
                ),
                Text(
                  "Budget Emergency Fund",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "Always maintain 3-6 months of expenses in an emergency fund to handle unexpected costs.",
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

  Widget _buildSummaryCard(String title, double amount, Color color, IconData icon) {
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
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          Text(
            "\$${amount.abs().currency}",
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

  int _calculateBudgetScore() {
    double totalBudgeted = categories.fold(0.0, (sum, cat) => sum + (cat["budgeted"] as double));
    double totalSpent = categories.fold(0.0, (sum, cat) => sum + (cat["spent"] as double));
    
    if (totalSpent <= totalBudgeted) {
      return (100 - ((totalSpent / totalBudgeted) * 20)).round();
    } else {
      return (80 - ((totalSpent - totalBudgeted) / totalBudgeted * 100)).clamp(0, 80).round();
    }
  }

  String _getBudgetScoreDescription() {
    int score = _calculateBudgetScore();
    if (score >= 80) return "Excellent budget management!";
    if (score >= 60) return "Good budget control";
    if (score >= 40) return "Room for improvement";
    return "Focus on reducing expenses";
  }
}
