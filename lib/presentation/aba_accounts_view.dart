import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaAccountsView extends StatefulWidget {
  const AbaAccountsView({super.key});

  @override
  State<AbaAccountsView> createState() => _AbaAccountsViewState();
}

class _AbaAccountsViewState extends State<AbaAccountsView> {
  String searchQuery = "";
  String selectedAccountType = "All";
  bool loading = false;

  List<Map<String, dynamic>> accountTypes = [
    {"label": "All", "value": "All"},
    {"label": "Assets", "value": "Assets"},
    {"label": "Liabilities", "value": "Liabilities"},
    {"label": "Equity", "value": "Equity"},
    {"label": "Revenue", "value": "Revenue"},
    {"label": "Expenses", "value": "Expenses"},
  ];

  List<Map<String, dynamic>> accounts = [
    {
      "id": "1",
      "name": "Cash on Hand",
      "number": "1001",
      "type": "Assets",
      "balance": 15000.00,
      "status": "Active",
      "description": "Petty cash and till money",
      "lastTransaction": "2024-12-18",
      "transactionCount": 145
    },
    {
      "id": "2",
      "name": "Bank Account - Checking",
      "number": "1002",
      "type": "Assets",
      "balance": 45000.50,
      "status": "Active",
      "description": "Primary checking account",
      "lastTransaction": "2024-12-19",
      "transactionCount": 328
    },
    {
      "id": "3",
      "name": "Accounts Receivable",
      "number": "1200",
      "type": "Assets",
      "balance": 12500.75,
      "status": "Active",
      "description": "Outstanding customer invoices",
      "lastTransaction": "2024-12-17",
      "transactionCount": 89
    },
    {
      "id": "4",
      "name": "Inventory",
      "number": "1300",
      "type": "Assets",
      "balance": 28000.00,
      "status": "Active",
      "description": "Stock and merchandise",
      "lastTransaction": "2024-12-19",
      "transactionCount": 234
    },
    {
      "id": "5",
      "name": "Accounts Payable",
      "number": "2001",
      "type": "Liabilities",
      "balance": 8500.25,
      "status": "Active",
      "description": "Outstanding vendor bills",
      "lastTransaction": "2024-12-18",
      "transactionCount": 67
    },
    {
      "id": "6",
      "name": "Credit Card Payable",
      "number": "2100",
      "type": "Liabilities",
      "balance": 3200.00,
      "status": "Active",
      "description": "Business credit card balance",
      "lastTransaction": "2024-12-16",
      "transactionCount": 45
    },
    {
      "id": "7",
      "name": "Owner's Equity",
      "number": "3001",
      "type": "Equity",
      "balance": 75000.00,
      "status": "Active",
      "description": "Initial capital investment",
      "lastTransaction": "2024-12-01",
      "transactionCount": 12
    },
    {
      "id": "8",
      "name": "Sales Revenue",
      "number": "4001",
      "type": "Revenue",
      "balance": 125000.00,
      "status": "Active",
      "description": "Product and service sales",
      "lastTransaction": "2024-12-19",
      "transactionCount": 456
    },
    {
      "id": "9",
      "name": "Office Expenses",
      "number": "5001",
      "type": "Expenses",
      "balance": 8900.50,
      "status": "Active",
      "description": "Office supplies and utilities",
      "lastTransaction": "2024-12-18",
      "transactionCount": 78
    },
    {
      "id": "10",
      "name": "Marketing Expenses",
      "number": "5200",
      "type": "Expenses",
      "balance": 4500.00,
      "status": "Active",
      "description": "Advertising and promotion costs",
      "lastTransaction": "2024-12-15",
      "transactionCount": 34
    }
  ];

  List<Map<String, dynamic>> get filteredAccounts {
    return accounts.where((account) {
      bool matchesSearch = "${account["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${account["number"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesType = selectedAccountType == "All" || account["type"] == selectedAccountType;
      return matchesSearch && matchesType;
    }).toList();
  }

  Color _getAccountTypeColor(String type) {
    switch (type) {
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

  IconData _getAccountTypeIcon(String type) {
    switch (type) {
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
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  // Search and Filter Section
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
                        Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: disabledBoldColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QTextField(
                                label: "Search accounts...",
                                value: searchQuery,
                                hint: "Account name or number",
                                onChanged: (value) {
                                  searchQuery = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                        QDropdownField(
                          label: "Account Type",
                          items: accountTypes,
                          value: selectedAccountType,
                          onChanged: (value, label) {
                            selectedAccountType = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),

                  // Summary Cards
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildSummaryCard(
                        "Total Assets",
                        ((accounts
                                    .where((a) => a["type"] == "Assets")
                                    .map((a) => a["balance"] as double)
                                    .fold(0.0, (sum, balance) => sum + balance))
                                .toDouble())
                            .currency,
                        Icons.account_balance_wallet,
                        successColor,
                      ),
                      _buildSummaryCard(
                        "Total Liabilities",
                        ((accounts
                                    .where((a) => a["type"] == "Liabilities")
                                    .map((a) => a["balance"] as double)
                                    .fold(0.0, (sum, balance) => sum + balance))
                                .toDouble())
                            .currency,
                        Icons.credit_card,
                        dangerColor,
                      ),
                      _buildSummaryCard(
                        "Total Equity",
                        ((accounts
                                    .where((a) => a["type"] == "Equity")
                                    .map((a) => a["balance"] as double)
                                    .fold(0.0, (sum, balance) => sum + balance))
                                .toDouble())
                            .currency,
                        Icons.pie_chart,
                        infoColor,
                      ),
                      _buildSummaryCard(
                        "Net Income",
                        (((accounts
                                        .where((a) => a["type"] == "Revenue")
                                        .map((a) => a["balance"] as double)
                                        .fold(0.0, (sum, balance) => sum + balance)) -
                                    (accounts
                                        .where((a) => a["type"] == "Expenses")
                                        .map((a) => a["balance"] as double)
                                        .fold(0.0, (sum, balance) => sum + balance)))
                                .toDouble())
                            .currency,
                        Icons.trending_up,
                        primaryColor,
                      ),
                    ],
                  ),

                  // Accounts List
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Row(
                            children: [
                              Icon(
                                Icons.list,
                                color: primaryColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Accounts (${filteredAccounts.length})",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(height: 1),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: filteredAccounts.length,
                          separatorBuilder: (context, index) => Divider(height: 1),
                          itemBuilder: (context, index) {
                            final account = filteredAccounts[index];
                            return GestureDetector(
                              onTap: () {
                                //navigateTo('AccountDetailView', account)
                              },
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: _getAccountTypeColor("${account["type"]}").withAlpha(30),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Icon(
                                        _getAccountTypeIcon("${account["type"]}"),
                                        color: _getAccountTypeColor("${account["type"]}"),
                                        size: 20,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "${account["name"]}",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: primaryColor,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: spXs,
                                                  vertical: 2,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: _getAccountTypeColor("${account["type"]}").withAlpha(20),
                                                  borderRadius: BorderRadius.circular(radiusXs),
                                                ),
                                                child: Text(
                                                  "${account["type"]}",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: _getAccountTypeColor("${account["type"]}"),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 2),
                                          Row(
                                            children: [
                                              Text(
                                                "No. ${account["number"]}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                              SizedBox(width: spSm),
                                              Container(
                                                width: 4,
                                                height: 4,
                                                decoration: BoxDecoration(
                                                  color: disabledColor,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              SizedBox(width: spSm),
                                              Text(
                                                "${account["transactionCount"]} transactions",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (account["description"] != null) ...[
                                            SizedBox(height: 2),
                                            Text(
                                              "${account["description"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledColor,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${(account["balance"] as double).currency}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: (account["balance"] as double) >= 0 ? successColor : dangerColor,
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          "Last: ${DateTime.parse("${account["lastTransaction"]}").dMMMy}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: spSm),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: disabledColor,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
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
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 18,
                ),
              ),
              Spacer(),
              Icon(
                Icons.trending_up,
                color: color,
                size: 16,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
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
