import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaChartOfAccountsView extends StatefulWidget {
  const AbaChartOfAccountsView({super.key});

  @override
  State<AbaChartOfAccountsView> createState() => _AbaChartOfAccountsViewState();
}

class _AbaChartOfAccountsViewState extends State<AbaChartOfAccountsView> {
  bool loading = false;
  String selectedPeriod = "Current Year";
  bool showInactive = false;

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Current Year", "value": "Current Year"},
    {"label": "Last Year", "value": "Last Year"},
    {"label": "Quarter", "value": "Quarter"},
    {"label": "Month", "value": "Month"},
  ];

  List<Map<String, dynamic>> chartData = [
    {
      "category": "Assets",
      "accounts": [
        {
          "number": "1000",
          "name": "Current Assets",
          "type": "header",
          "balance": 0.0,
          "level": 0
        },
        {
          "number": "1001",
          "name": "Cash on Hand",
          "type": "account",
          "balance": 15000.00,
          "level": 1,
          "status": "Active"
        },
        {
          "number": "1002",
          "name": "Bank Account - Checking",
          "type": "account",
          "balance": 45000.50,
          "level": 1,
          "status": "Active"
        },
        {
          "number": "1003",
          "name": "Bank Account - Savings",
          "type": "account",
          "balance": 25000.00,
          "level": 1,
          "status": "Active"
        },
        {
          "number": "1200",
          "name": "Accounts Receivable",
          "type": "account",
          "balance": 12500.75,
          "level": 1,
          "status": "Active"
        },
        {
          "number": "1300",
          "name": "Inventory",
          "type": "account",
          "balance": 28000.00,
          "level": 1,
          "status": "Active"
        },
        {
          "number": "1400",
          "name": "Fixed Assets",
          "type": "header",
          "balance": 0.0,
          "level": 0
        },
        {
          "number": "1401",
          "name": "Equipment",
          "type": "account",
          "balance": 35000.00,
          "level": 1,
          "status": "Active"
        },
        {
          "number": "1402",
          "name": "Accumulated Depreciation - Equipment",
          "type": "account",
          "balance": -5000.00,
          "level": 1,
          "status": "Active"
        },
      ]
    },
    {
      "category": "Liabilities",
      "accounts": [
        {
          "number": "2000",
          "name": "Current Liabilities",
          "type": "header",
          "balance": 0.0,
          "level": 0
        },
        {
          "number": "2001",
          "name": "Accounts Payable",
          "type": "account",
          "balance": 8500.25,
          "level": 1,
          "status": "Active"
        },
        {
          "number": "2100",
          "name": "Credit Card Payable",
          "type": "account",
          "balance": 3200.00,
          "level": 1,
          "status": "Active"
        },
        {
          "number": "2200",
          "name": "Accrued Expenses",
          "type": "account",
          "balance": 1500.00,
          "level": 1,
          "status": "Active"
        },
        {
          "number": "2300",
          "name": "Long-term Liabilities",
          "type": "header",
          "balance": 0.0,
          "level": 0
        },
        {
          "number": "2301",
          "name": "Business Loan",
          "type": "account",
          "balance": 15000.00,
          "level": 1,
          "status": "Active"
        },
      ]
    },
    {
      "category": "Equity",
      "accounts": [
        {
          "number": "3000",
          "name": "Owner's Equity",
          "type": "header",
          "balance": 0.0,
          "level": 0
        },
        {
          "number": "3001",
          "name": "Capital Investment",
          "type": "account",
          "balance": 75000.00,
          "level": 1,
          "status": "Active"
        },
        {
          "number": "3002",
          "name": "Retained Earnings",
          "type": "account",
          "balance": 25000.00,
          "level": 1,
          "status": "Active"
        },
        {
          "number": "3003",
          "name": "Current Year Earnings",
          "type": "account",
          "balance": 18500.00,
          "level": 1,
          "status": "Active"
        },
      ]
    },
    {
      "category": "Revenue",
      "accounts": [
        {
          "number": "4000",
          "name": "Sales Revenue",
          "type": "header",
          "balance": 0.0,
          "level": 0
        },
        {
          "number": "4001",
          "name": "Product Sales",
          "type": "account",
          "balance": 95000.00,
          "level": 1,
          "status": "Active"
        },
        {
          "number": "4002",
          "name": "Service Revenue",
          "type": "account",
          "balance": 30000.00,
          "level": 1,
          "status": "Active"
        },
        {
          "number": "4100",
          "name": "Other Income",
          "type": "account",
          "balance": 2500.00,
          "level": 1,
          "status": "Active"
        },
      ]
    },
    {
      "category": "Expenses",
      "accounts": [
        {
          "number": "5000",
          "name": "Operating Expenses",
          "type": "header",
          "balance": 0.0,
          "level": 0
        },
        {
          "number": "5001",
          "name": "Office Expenses",
          "type": "account",
          "balance": 8900.50,
          "level": 1,
          "status": "Active"
        },
        {
          "number": "5100",
          "name": "Rent Expense",
          "type": "account",
          "balance": 12000.00,
          "level": 1,
          "status": "Active"
        },
        {
          "number": "5200",
          "name": "Marketing Expenses",
          "type": "account",
          "balance": 4500.00,
          "level": 1,
          "status": "Active"
        },
        {
          "number": "5300",
          "name": "Utilities",
          "type": "account",
          "balance": 2400.00,
          "level": 1,
          "status": "Active"
        },
        {
          "number": "5400",
          "name": "Insurance",
          "type": "account",
          "balance": 1800.00,
          "level": 1,
          "status": "Active"
        },
      ]
    }
  ];

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Assets":
        return successColor;
      case "Liabilities":
        return dangerColor;
      case "Equity":
        return infoColor;
      case "Revenue":
        return primaryColor;
      case "Expenses":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Assets":
        return Icons.account_balance_wallet;
      case "Liabilities":
        return Icons.credit_card;
      case "Equity":
        return Icons.pie_chart;
      case "Revenue":
        return Icons.trending_up;
      case "Expenses":
        return Icons.trending_down;
      default:
        return Icons.account_balance;
    }
  }

  double _getCategoryTotal(List<Map<String, dynamic>> accounts) {
    return accounts
        .where((account) => account["type"] == "account")
        .map((account) => account["balance"] as double)
        .fold(0.0, (sum, balance) => sum + balance);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chart of Accounts"),
        actions: [
          IconButton(
            onPressed: () {
              //navigateTo('AddAccountView')
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              //navigateTo('AccountSettingsView')
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  // Controls Section
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spSm,
                      children: [
                        QDropdownField(
                          label: "Period",
                          items: periodOptions,
                          value: selectedPeriod,
                          onChanged: (value, label) {
                            selectedPeriod = value;
                            setState(() {});
                          },
                        ),
                        QSwitch(
                          items: [
                            {
                              "label": "Show Inactive Accounts",
                              "value": true,
                              "checked": showInactive,
                            }
                          ],
                          value: [
                            if (showInactive)
                              {
                                "label": "Show Inactive Accounts",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            showInactive = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),

                  // Summary Section
                  Container(
                    padding: EdgeInsets.all(spSm),
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
                            Icon(
                              Icons.analytics,
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Financial Summary",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        ResponsiveGridView(
                          padding: EdgeInsets.zero,
                          minItemWidth: 200,
                          children: chartData.map((category) {
                            double total = _getCategoryTotal(category["accounts"] as List<Map<String, dynamic>>);
                            return Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: _getCategoryColor("${category["category"]}").withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: _getCategoryColor("${category["category"]}").withAlpha(30),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        _getCategoryIcon("${category["category"]}"),
                                        color: _getCategoryColor("${category["category"]}"),
                                        size: 18,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${category["category"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: _getCategoryColor("${category["category"]}"),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${total.currency}",
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
                        ),
                      ],
                    ),
                  ),

                  // Chart of Accounts
                  ...chartData.map((categoryData) {
                    String category = "${categoryData["category"]}";
                    List<Map<String, dynamic>> accounts = categoryData["accounts"] as List<Map<String, dynamic>>;
                    double categoryTotal = _getCategoryTotal(accounts);

                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          // Category Header
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: _getCategoryColor(category).withAlpha(10),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusMd),
                                topRight: Radius.circular(radiusMd),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: _getCategoryColor(category).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    _getCategoryIcon(category),
                                    color: _getCategoryColor(category),
                                    size: 18,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    category,
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: _getCategoryColor(category),
                                    ),
                                  ),
                                ),
                                Text(
                                  "${categoryTotal.currency}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: _getCategoryColor(category),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Accounts List
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: accounts.length,
                            separatorBuilder: (context, index) => Divider(height: 1),
                            itemBuilder: (context, index) {
                              final account = accounts[index];
                              bool isHeader = account["type"] == "header";
                              int level = (account["level"] as int?) ?? 0;

                              return GestureDetector(
                                onTap: !isHeader
                                    ? () {
                                        //navigateTo('AccountDetailView', account)
                                      }
                                    : null,
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: spSm + (level * spSm),
                                    right: spSm,
                                    top: spSm,
                                    bottom: spSm,
                                  ),
                                  color: isHeader ? disabledColor.withAlpha(5) : Colors.transparent,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 60,
                                        child: Text(
                                          "${account["number"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: isHeader ? FontWeight.bold : FontWeight.w500,
                                            color: isHeader ? primaryColor : disabledBoldColor,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: Text(
                                          "${account["name"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                                            color: isHeader ? primaryColor : Colors.black87,
                                          ),
                                        ),
                                      ),
                                      if (!isHeader) ...[
                                        SizedBox(width: spSm),
                                        Text(
                                          "${(account["balance"] as double).currency}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: (account["balance"] as double) >= 0 ? successColor : dangerColor,
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: disabledColor,
                                          size: 12,
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
    );
  }
}
