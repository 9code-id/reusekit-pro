import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDashboard5View extends StatefulWidget {
  @override
  State<GrlDashboard5View> createState() => _GrlDashboard5ViewState();
}

class _GrlDashboard5ViewState extends State<GrlDashboard5View> {
  bool loading = false;
  String selectedPeriod = "This Month";
  
  List<Map<String, dynamic>> financialData = [
    {"category": "Revenue", "amount": 245000.0, "change": 12.5, "icon": Icons.trending_up, "color": "success"},
    {"category": "Expenses", "amount": 156000.0, "change": -8.3, "icon": Icons.trending_down, "color": "danger"},
    {"category": "Net Profit", "amount": 89000.0, "change": 15.2, "icon": Icons.attach_money, "color": "primary"},
    {"category": "Cash Flow", "amount": 112000.0, "change": 6.8, "icon": Icons.account_balance, "color": "info"},
  ];

  List<Map<String, dynamic>> expenseBreakdown = [
    {"category": "Salaries", "amount": 85000.0, "percentage": 54.5, "color": "primary"},
    {"category": "Office Rent", "amount": 25000.0, "percentage": 16.0, "color": "success"},
    {"category": "Marketing", "amount": 18000.0, "percentage": 11.5, "color": "warning"},
    {"category": "Utilities", "amount": 12000.0, "percentage": 7.7, "color": "info"},
    {"category": "Others", "amount": 16000.0, "percentage": 10.3, "color": "danger"},
  ];

  List<Map<String, dynamic>> recentTransactions = [
    {"description": "Client Payment - ABC Corp", "amount": 15000.0, "type": "income", "date": "2024-01-15", "category": "Revenue"},
    {"description": "Office Supplies", "amount": -450.0, "type": "expense", "date": "2024-01-14", "category": "Operating"},
    {"description": "Salary Payment", "amount": -25000.0, "type": "expense", "date": "2024-01-13", "category": "Payroll"},
    {"description": "Software License", "amount": -1200.0, "type": "expense", "date": "2024-01-12", "category": "Technology"},
    {"description": "Consulting Fee", "amount": 8500.0, "type": "income", "date": "2024-01-11", "category": "Services"},
    {"description": "Electricity Bill", "amount": -680.0, "type": "expense", "date": "2024-01-10", "category": "Utilities"},
  ];

  List<Map<String, dynamic>> budgetData = [
    {"category": "Marketing", "budgeted": 20000.0, "spent": 18000.0},
    {"category": "Operations", "budgeted": 35000.0, "spent": 32500.0},
    {"category": "Technology", "budgeted": 15000.0, "spent": 16800.0},
    {"category": "Human Resources", "budgeted": 90000.0, "spent": 85000.0},
    {"category": "Facilities", "budgeted": 28000.0, "spent": 25000.0},
  ];

  List<Map<String, dynamic>> periodItems = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Financial Dashboard"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: spMd),
            child: QButton(
              icon: Icons.file_download,
              size: bs.sm,
              onPressed: () {
                ss("Financial report exported successfully");
              },
            ),
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
                Text(
                  "Period:",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Select Period",
                    items: periodItems,
                    value: selectedPeriod,
                    onChanged: (value, label) {
                      selectedPeriod = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Financial Overview Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: financialData.map((data) {
                return _buildFinancialCard(
                  data["category"],
                  "\$${((data["amount"] as double) / 1000).toStringAsFixed(0)}K",
                  data["icon"],
                  _getColorFromString(data["color"]),
                  "${(data["change"] as double) >= 0 ? '+' : ''}${(data["change"] as double).toStringAsFixed(1)}%",
                );
              }).toList(),
            ),

            // Expense Breakdown
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
                  Text(
                    "Expense Breakdown",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Column(
                    spacing: spSm,
                    children: expenseBreakdown.map((expense) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: _getColorFromString(expense["color"]),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${expense["category"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: FractionallySizedBox(
                                widthFactor: (expense["percentage"] as double) / 100,
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _getColorFromString(expense["color"]),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "\$${((expense["amount"] as double) / 1000).toStringAsFixed(0)}K",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${(expense["percentage"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
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

            // Budget vs Actual
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
                  Text(
                    "Budget vs Actual Spending",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Column(
                    spacing: spSm,
                    children: budgetData.map((budget) {
                      double spentPercentage = (budget["spent"] as double) / (budget["budgeted"] as double);
                      bool isOverBudget = spentPercentage > 1.0;
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: isOverBudget ? dangerColor : successColor,
                            ),
                          ),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${budget["category"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: (isOverBudget ? dangerColor : successColor).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    isOverBudget ? "Over Budget" : "On Track",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: isOverBudget ? dangerColor : successColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: FractionallySizedBox(
                                      widthFactor: spentPercentage > 1.0 ? 1.0 : spentPercentage,
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: isOverBudget ? dangerColor : primaryColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                if (isOverBudget)
                                  Container(
                                    width: 20,
                                    height: 8,
                                    margin: EdgeInsets.only(left: 2),
                                    decoration: BoxDecoration(
                                      color: dangerColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Spent: \$${((budget["spent"] as double) / 1000).toStringAsFixed(1)}K",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Budget: \$${((budget["budgeted"] as double) / 1000).toStringAsFixed(1)}K",
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
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Recent Transactions
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recent Transactions",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          si("Opening transaction history");
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: recentTransactions.map((transaction) {
                      bool isIncome = transaction["type"] == "income";
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: (isIncome ? successColor : dangerColor).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                                color: isIncome ? successColor : dangerColor,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${transaction["description"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${transaction["category"]} • ${transaction["date"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "${isIncome ? '+' : ''}\$${((transaction["amount"] as double).abs() / 1000).toStringAsFixed(1)}K",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isIncome ? successColor : dangerColor,
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

            // Quick Actions
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildActionCard("Add Income", Icons.add_circle, successColor, () {
                  si("Opening income entry form");
                }),
                _buildActionCard("Add Expense", Icons.remove_circle, dangerColor, () {
                  si("Opening expense entry form");
                }),
                _buildActionCard("Budget Planning", Icons.pie_chart, warningColor, () {
                  si("Opening budget planning tool");
                }),
                _buildActionCard("Tax Calculator", Icons.calculate, infoColor, () {
                  si("Opening tax calculator");
                }),
              ],
            ),

            // Generate Report Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Generate Financial Report",
                icon: Icons.assessment,
                size: bs.md,
                onPressed: () {
                  loading = true;
                  setState(() {});
                  Future.delayed(Duration(seconds: 2), () {
                    loading = false;
                    setState(() {});
                    ss("Financial report generated successfully");
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialCard(String title, String value, IconData icon, Color color, String change) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: change.startsWith('+') ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  change,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: change.startsWith('+') ? successColor : dangerColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          boxShadow: [shadowSm],
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
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
            SizedBox(height: spSm),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorFromString(String colorName) {
    switch (colorName) {
      case "primary":
        return primaryColor;
      case "success":
        return successColor;
      case "danger":
        return dangerColor;
      case "warning":
        return warningColor;
      case "info":
        return infoColor;
      default:
        return primaryColor;
    }
  }
}
