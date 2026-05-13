import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaBookkeepingView extends StatefulWidget {
  const FmaBookkeepingView({super.key});

  @override
  State<FmaBookkeepingView> createState() => _FmaBookkeepingViewState();
}

class _FmaBookkeepingViewState extends State<FmaBookkeepingView> {
  List<Map<String, dynamic>> transactions = [
    {
      "id": "TXN001",
      "date": "2024-06-15",
      "description": "Office supplies purchase",
      "category": "Office Expenses",
      "type": "Expense",
      "amount": 450.00,
      "account": "Business Checking",
      "reference": "INV-2024-001",
      "status": "Reconciled",
    },
    {
      "id": "TXN002",
      "date": "2024-06-14",
      "description": "Client payment - ABC Corp",
      "category": "Revenue",
      "type": "Income",
      "amount": 2500.00,
      "account": "Business Checking",
      "reference": "PAY-2024-045",
      "status": "Cleared",
    },
    {
      "id": "TXN003",
      "date": "2024-06-13",
      "description": "Internet service bill",
      "category": "Utilities",
      "type": "Expense",
      "amount": 89.99,
      "account": "Business Credit Card",
      "reference": "BILL-2024-123",
      "status": "Pending",
    },
    {
      "id": "TXN004",
      "date": "2024-06-12",
      "description": "Software subscription",
      "category": "Software",
      "type": "Expense",
      "amount": 99.00,
      "account": "Business Credit Card",
      "reference": "SUB-2024-007",
      "status": "Reconciled",
    },
    {
      "id": "TXN005",
      "date": "2024-06-11",
      "description": "Consulting service revenue",
      "category": "Revenue",
      "type": "Income",
      "amount": 1800.00,
      "account": "Business Checking",
      "reference": "CON-2024-012",
      "status": "Cleared",
    },
  ];

  List<Map<String, dynamic>> accounts = [
    {
      "name": "Business Checking",
      "type": "Asset",
      "balance": 15420.50,
      "lastReconciled": "2024-06-10",
      "transactions": 156,
    },
    {
      "name": "Business Credit Card",
      "type": "Liability",
      "balance": -2850.75,
      "lastReconciled": "2024-06-08",
      "transactions": 89,
    },
    {
      "name": "Accounts Receivable",
      "type": "Asset",
      "balance": 8750.00,
      "lastReconciled": "2024-06-09",
      "transactions": 34,
    },
    {
      "name": "Accounts Payable",
      "type": "Liability",
      "balance": -4200.00,
      "lastReconciled": "2024-06-07",
      "transactions": 28,
    },
  ];

  String selectedPeriod = "This Month";
  String selectedAccount = "All Accounts";
  String filterType = "All";

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> accountOptions = [
    {"label": "All Accounts", "value": "All Accounts"},
    {"label": "Business Checking", "value": "Business Checking"},
    {"label": "Business Credit Card", "value": "Business Credit Card"},
    {"label": "Accounts Receivable", "value": "Accounts Receivable"},
    {"label": "Accounts Payable", "value": "Accounts Payable"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "All"},
    {"label": "Income", "value": "Income"},
    {"label": "Expense", "value": "Expense"},
  ];

  @override
  Widget build(BuildContext context) {
    double totalIncome = transactions
        .where((txn) => txn["type"] == "Income")
        .fold(0.0, (sum, item) => sum + (item["amount"] as double));
    double totalExpenses = transactions
        .where((txn) => txn["type"] == "Expense")
        .fold(0.0, (sum, item) => sum + (item["amount"] as double));
    double netIncome = totalIncome - totalExpenses;
    double totalAssets = accounts
        .where((acc) => acc["type"] == "Asset")
        .fold(0.0, (sum, item) => sum + (item["balance"] as double));

    return Scaffold(
      appBar: AppBar(
        title: Text("Bookkeeping"),
        actions: [
          IconButton(
            icon: Icon(Icons.sync),
            onPressed: () {
              ss("Accounts synchronized successfully");
            },
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              ss("Bookkeeping report exported");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filters
            Column(
              spacing: spMd,
              children: [
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
                        label: "Account",
                        items: accountOptions,
                        value: selectedAccount,
                        onChanged: (value, label) {
                          selectedAccount = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QDropdownField(
                  label: "Transaction Type",
                  items: typeOptions,
                  value: filterType,
                  onChanged: (value, label) {
                    filterType = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            // Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildSummaryCard(
                  "Total Income",
                  "\$${totalIncome.currency}",
                  Icons.trending_up,
                  successColor,
                ),
                _buildSummaryCard(
                  "Total Expenses",
                  "\$${totalExpenses.currency}",
                  Icons.trending_down,
                  dangerColor,
                ),
                _buildSummaryCard(
                  "Net Income",
                  "\$${netIncome.currency}",
                  Icons.account_balance,
                  netIncome >= 0 ? successColor : dangerColor,
                ),
                _buildSummaryCard(
                  "Total Assets",
                  "\$${totalAssets.currency}",
                  Icons.account_balance_wallet,
                  primaryColor,
                ),
              ],
            ),

            // Accounts Overview
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
                      Icon(Icons.account_balance, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Accounts Overview",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Add Account",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: accounts.map((account) {
                      Color balanceColor = account["balance"] >= 0 ? successColor : dangerColor;
                      String balanceSign = account["balance"] >= 0 ? "" : "-";
                      
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          border: Border.all(color: disabledOutlineBorderColor),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: account["type"] == "Asset" ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusMd),
                              ),
                              child: Icon(
                                account["type"] == "Asset" ? Icons.account_balance_wallet : Icons.credit_card,
                                color: account["type"] == "Asset" ? successColor : warningColor,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spMd),
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
                                  SizedBox(height: spXs),
                                  Text(
                                    "${account["type"]} • ${account["transactions"]} transactions",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "Last reconciled: ${DateTime.parse(account["lastReconciled"]).dMMMy}",
                                    style: TextStyle(
                                      fontSize: 11,
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
                                  "$balanceSign\$${((account["balance"] as double).abs()).currency}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: balanceColor,
                                  ),
                                ),
                                SizedBox(height: spSm),
                                QButton(
                                  label: "Reconcile",
                                  size: bs.sm,
                                  onPressed: () {},
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
                      Icon(Icons.receipt_long, color: primaryColor),
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
                      QButton(
                        label: "Add Transaction",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: transactions.map((transaction) {
                      Color typeColor = transaction["type"] == "Income" ? successColor : dangerColor;
                      Color statusColor = transaction["status"] == "Reconciled"
                          ? successColor
                          : transaction["status"] == "Cleared"
                              ? infoColor
                              : warningColor;

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
                                    color: typeColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusMd),
                                  ),
                                  child: Icon(
                                    transaction["type"] == "Income" ? Icons.arrow_downward : Icons.arrow_upward,
                                    color: typeColor,
                                    size: 16,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${transaction["description"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${transaction["category"]} • ${transaction["account"]}",
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
                                      "${transaction["type"] == "Income" ? "+" : "-"}\$${(transaction["amount"] as double).currency}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: typeColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: statusColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "${transaction["status"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: statusColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Date: ${DateTime.parse(transaction["date"]).dMMMy}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Ref: ${transaction["reference"]}",
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
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Quick Actions
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
                      Icon(Icons.flash_on, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Quick Actions",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildQuickAction(
                        "Record Income",
                        "Add revenue transaction",
                        Icons.add_circle,
                        successColor,
                        () {},
                      ),
                      _buildQuickAction(
                        "Record Expense",
                        "Add expense transaction",
                        Icons.remove_circle,
                        dangerColor,
                        () {},
                      ),
                      _buildQuickAction(
                        "Bank Reconciliation",
                        "Reconcile bank accounts",
                        Icons.sync_alt,
                        infoColor,
                        () {},
                      ),
                      _buildQuickAction(
                        "Generate Report",
                        "Create financial reports",
                        Icons.assessment,
                        warningColor,
                        () {},
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

  Widget _buildQuickAction(String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          border: Border.all(color: disabledOutlineBorderColor),
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: color.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
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
            Icon(Icons.arrow_forward_ios, color: disabledBoldColor, size: 16),
          ],
        ),
      ),
    );
  }
}
