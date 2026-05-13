import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaFinancialView extends StatefulWidget {
  const EmaFinancialView({super.key});

  @override
  State<EmaFinancialView> createState() => _EmaFinancialViewState();
}

class _EmaFinancialViewState extends State<EmaFinancialView> {
  String selectedPeriod = "This Month";
  String selectedAccount = "All Accounts";
  List<String> periods = ["Today", "This Week", "This Month", "This Quarter", "This Year"];
  List<String> accounts = ["All Accounts", "Checking Account", "Savings Account", "Business Account", "Investment Account"];
  
  List<Map<String, dynamic>> financialData = [
    {
      "id": 1,
      "type": "Income",
      "category": "Sales Revenue",
      "amount": 15420.50,
      "account": "Business Account",
      "date": "2025-06-18",
      "description": "Monthly sales revenue",
      "recurring": true,
      "status": "Completed",
    },
    {
      "id": 2,
      "type": "Expense",
      "category": "Office Rent",
      "amount": 2500.00,
      "account": "Business Account",
      "date": "2025-06-15",
      "description": "Monthly office rent payment",
      "recurring": true,
      "status": "Completed",
    },
    {
      "id": 3,
      "type": "Income",
      "category": "Investment Return",
      "amount": 850.25,
      "account": "Investment Account",
      "date": "2025-06-14",
      "description": "Quarterly dividend payment",
      "recurring": false,
      "status": "Completed",
    },
    {
      "id": 4,
      "type": "Expense",
      "category": "Marketing",
      "amount": 1200.00,
      "account": "Business Account",
      "date": "2025-06-13",
      "description": "Digital advertising campaign",
      "recurring": false,
      "status": "Pending",
    },
    {
      "id": 5,
      "type": "Expense",
      "category": "Utilities",
      "amount": 450.75,
      "account": "Business Account",
      "date": "2025-06-12",
      "description": "Monthly utility bills",
      "recurring": true,
      "status": "Completed",
    },
    {
      "id": 6,
      "type": "Income",
      "category": "Freelance Work",
      "amount": 3200.00,
      "account": "Checking Account",
      "date": "2025-06-11",
      "description": "Consulting project payment",
      "recurring": false,
      "status": "Completed",
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredTransactions = financialData.where((transaction) {
      if (selectedAccount == "All Accounts") return true;
      return transaction["account"] == selectedAccount;
    }).toList();

    double totalIncome = filteredTransactions
        .where((t) => t["type"] == "Income")
        .fold(0.0, (sum, t) => sum + (t["amount"] as double));
    double totalExpenses = filteredTransactions
        .where((t) => t["type"] == "Expense")
        .fold(0.0, (sum, t) => sum + (t["amount"] as double));
    double netIncome = totalIncome - totalExpenses;
    double pendingAmount = filteredTransactions
        .where((t) => t["status"] == "Pending")
        .fold(0.0, (sum, t) => sum + (t["amount"] as double));

    return Scaffold(
      appBar: AppBar(
        title: Text("Financial Overview"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo('AddTransactionView')
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // navigateTo('FinancialAnalyticsView')
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
            // Period and Account Filters
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
                    label: "Account",
                    items: accounts.map((account) => {
                      "label": account,
                      "value": account,
                    }).toList(),
                    value: selectedAccount,
                    onChanged: (value, label) {
                      selectedAccount = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Financial Summary Cards
            ResponsiveGridView(
              minItemWidth: 200,
              children: [
                _buildSummaryCard(
                  title: "Total Income",
                  value: "\$${totalIncome.currency}",
                  icon: Icons.trending_up,
                  color: successColor,
                  change: "+8.5%",
                  isPositive: true,
                ),
                _buildSummaryCard(
                  title: "Total Expenses",
                  value: "\$${totalExpenses.currency}",
                  icon: Icons.trending_down,
                  color: dangerColor,
                  change: "+3.2%",
                  isPositive: false,
                ),
                _buildSummaryCard(
                  title: "Net Income",
                  value: "\$${netIncome.currency}",
                  icon: Icons.account_balance,
                  color: netIncome >= 0 ? successColor : dangerColor,
                  change: "+12.8%",
                  isPositive: netIncome >= 0,
                ),
                _buildSummaryCard(
                  title: "Pending",
                  value: "\$${pendingAmount.currency}",
                  icon: Icons.pending,
                  color: warningColor,
                  change: "-2.1%",
                  isPositive: false,
                ),
              ],
            ),

            // Cash Flow Chart
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
                        Icons.show_chart,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Cash Flow Overview",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  _buildCashFlowChart(),
                ],
              ),
            ),

            // Income vs Expenses Breakdown
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
                        Icons.pie_chart,
                        color: infoColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Income vs Expenses",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildIncomeExpenseCard(
                          title: "Income",
                          amount: totalIncome,
                          color: successColor,
                          percentage: totalIncome + totalExpenses > 0 
                              ? (totalIncome / (totalIncome + totalExpenses)) * 100 
                              : 0,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildIncomeExpenseCard(
                          title: "Expenses",
                          amount: totalExpenses,
                          color: dangerColor,
                          percentage: totalIncome + totalExpenses > 0 
                              ? (totalExpenses / (totalIncome + totalExpenses)) * 100 
                              : 0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Recent Transactions
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
                        Icons.receipt_long,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Recent Transactions",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          // navigateTo('AllTransactionsView')
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
                  ...filteredTransactions.take(5).map((transaction) {
                    bool isIncome = transaction["type"] == "Income";
                    Color statusColor = transaction["status"] == "Completed" 
                        ? successColor 
                        : warningColor;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: isIncome 
                            ? successColor.withAlpha(5) 
                            : dangerColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isIncome 
                              ? successColor.withAlpha(20) 
                              : dangerColor.withAlpha(20),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: isIncome 
                                  ? successColor.withAlpha(20) 
                                  : dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                              color: isIncome ? successColor : dangerColor,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${transaction["category"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${transaction["description"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: statusColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${transaction["status"]}",
                                        style: TextStyle(
                                          color: statusColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    if (transaction["recurring"])
                                      Container(
                                        margin: EdgeInsets.only(left: spXs),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: infoColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "Recurring",
                                          style: TextStyle(
                                            color: infoColor,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${isIncome ? '+' : '-'}\$${(transaction["amount"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isIncome ? successColor : dangerColor,
                                ),
                              ),
                              Text(
                                "${transaction["account"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
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
                        label: "Add Income",
                        size: bs.sm,
                        onPressed: () {
                          // navigateTo('AddIncomeView')
                        },
                      ),
                      QButton(
                        label: "Add Expense",
                        size: bs.sm,
                        onPressed: () {
                          // navigateTo('AddExpenseView')
                        },
                      ),
                      QButton(
                        label: "Transfer Funds",
                        size: bs.sm,
                        onPressed: () {
                          // navigateTo('TransferFundsView')
                        },
                      ),
                      QButton(
                        label: "Generate Report",
                        size: bs.sm,
                        onPressed: () {
                          // navigateTo('FinancialReportView')
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
    required String change,
    required bool isPositive,
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: isPositive 
                      ? successColor.withAlpha(20) 
                      : dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                      size: 12,
                      color: isPositive ? successColor : dangerColor,
                    ),
                    Text(
                      change,
                      style: TextStyle(
                        color: isPositive ? successColor : dangerColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
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
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCashFlowChart() {
    List<String> months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"];
    List<double> incomeData = [12500, 13200, 11800, 15400, 14600, 15420];
    List<double> expenseData = [8500, 9200, 8800, 10400, 9600, 10150];
    
    double maxValue = [...incomeData, ...expenseData].reduce((a, b) => a > b ? a : b);

    return Container(
      height: 200,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(months.length, (index) {
          double incomeHeight = (incomeData[index] / maxValue) * 160;
          double expenseHeight = (expenseData[index] / maxValue) * 160;
          
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
                          height: incomeHeight,
                          margin: EdgeInsets.only(right: 2),
                          decoration: BoxDecoration(
                            color: successColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: expenseHeight,
                          margin: EdgeInsets.only(left: 2),
                          decoration: BoxDecoration(
                            color: dangerColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    months[index],
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildIncomeExpenseCard({
    required String title,
    required double amount,
    required Color color,
    required double percentage,
  }) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "\$${amount.currency}",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "${percentage.toStringAsFixed(1)}%",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
