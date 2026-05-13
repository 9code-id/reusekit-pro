import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWallet3View extends StatefulWidget {
  @override
  State<GrlWallet3View> createState() => _GrlWallet3ViewState();
}

class _GrlWallet3ViewState extends State<GrlWallet3View> {
  List<Map<String, dynamic>> expenses = [
    {
      "category": "Food & Dining",
      "amount": 450.0,
      "budget": 600.0,
      "icon": Icons.restaurant,
      "color": Colors.orange,
      "percentage": 75.0,
      "transactions": 28
    },
    {
      "category": "Transportation",
      "amount": 280.0,
      "budget": 400.0,
      "icon": Icons.directions_car,
      "color": Colors.blue,
      "percentage": 70.0,
      "transactions": 15
    },
    {
      "category": "Shopping",
      "amount": 320.0,
      "budget": 500.0,
      "icon": Icons.shopping_bag,
      "color": Colors.pink,
      "percentage": 64.0,
      "transactions": 12
    },
    {
      "category": "Entertainment",
      "amount": 150.0,
      "budget": 200.0,
      "icon": Icons.movie,
      "color": Colors.purple,
      "percentage": 75.0,
      "transactions": 8
    },
    {
      "category": "Health & Fitness",
      "amount": 85.0,
      "budget": 150.0,
      "icon": Icons.fitness_center,
      "color": Colors.green,
      "percentage": 56.7,
      "transactions": 5
    },
    {
      "category": "Utilities",
      "amount": 220.0,
      "budget": 300.0,
      "icon": Icons.electrical_services,
      "color": Colors.red,
      "percentage": 73.3,
      "transactions": 6
    }
  ];

  String selectedPeriod = "This Month";
  List<String> periods = ["This Week", "This Month", "Last Month", "This Year"];

  double get totalSpent {
    return expenses.fold(0.0, (sum, expense) => sum + (expense["amount"] as double));
  }

  double get totalBudget {
    return expenses.fold(0.0, (sum, expense) => sum + (expense["budget"] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Period Selector
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
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

            // Budget Overview
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Text(
                    "Budget Overview",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildBudgetStat(
                        "Spent",
                        totalSpent,
                        Colors.red.withAlpha(100),
                      ),
                      _buildBudgetStat(
                        "Budget", 
                        totalBudget,
                        Colors.white.withAlpha(100),
                      ),
                      _buildBudgetStat(
                        "Remaining",
                        totalBudget - totalSpent,
                        Colors.green.withAlpha(100),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(100),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: (totalSpent / totalBudget).clamp(0.0, 1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "${((totalSpent / totalBudget) * 100).toStringAsFixed(1)}% of budget used",
                    style: TextStyle(
                      color: Colors.white.withAlpha(200),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Add Expense Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Add New Expense",
                icon: Icons.add,
                size: bs.md,
                onPressed: () {},
              ),
            ),

            // Expense Categories
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Expense Categories",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      final expense = expenses[index];
                      return _buildExpenseCategory(expense);
                    },
                  ),
                ],
              ),
            ),

            // Spending Insights
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Spending Insights",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  _buildInsightItem(
                    "Highest Category",
                    "Food & Dining",
                    "\$${expenses.first["amount"]}",
                    Icons.trending_up,
                    dangerColor,
                  ),
                  _buildInsightItem(
                    "Most Transactions",
                    "Food & Dining",
                    "${expenses.first["transactions"]} transactions",
                    Icons.receipt,
                    infoColor,
                  ),
                  _buildInsightItem(
                    "Budget Alert",
                    "3 categories over 70%",
                    "Consider reducing spending",
                    Icons.warning,
                    warningColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetStat(String title, double amount, Color backgroundColor) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "\$${amount.currency}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseCategory(Map<String, dynamic> expense) {
    double percentage = expense["percentage"] as double;
    Color color = expense["color"] as Color;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  expense["icon"] as IconData,
                  color: color,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${expense["category"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${expense["transactions"]} transactions",
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
                    "\$${(expense["amount"] as double).currency}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "of \$${(expense["budget"] as double).currency}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: color.withAlpha(100),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: (percentage / 100).clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${percentage.toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(String title, String subtitle, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      child: Row(
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: color.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 18,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
