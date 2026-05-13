import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaAccountDetailView extends StatefulWidget {
  const AbaAccountDetailView({super.key});

  @override
  State<AbaAccountDetailView> createState() => _AbaAccountDetailViewState();
}

class _AbaAccountDetailViewState extends State<AbaAccountDetailView> {
  bool loading = false;
  String selectedPeriod = "This Month";
  int currentTab = 0;

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
    {"label": "All Time", "value": "All Time"},
  ];

  Map<String, dynamic> accountInfo = {
    "id": "1002",
    "name": "Bank Account - Checking",
    "number": "1002",
    "type": "Assets",
    "balance": 45000.50,
    "status": "Active",
    "description": "Primary checking account for daily operations",
    "created": "2024-01-15",
    "lastTransaction": "2024-12-19",
    "transactionCount": 328,
    "openingBalance": 35000.00,
    "totalDebits": 125000.00,
    "totalCredits": 115000.00,
    "averageBalance": 42500.00,
    "reconciled": true,
    "lastReconciled": "2024-12-15"
  };

  List<Map<String, dynamic>> transactions = [
    {
      "id": "t001",
      "date": "2024-12-19",
      "description": "Customer Payment - Invoice #1234",
      "reference": "INV-1234",
      "debit": 2500.00,
      "credit": 0.0,
      "balance": 45000.50,
      "category": "Revenue",
      "type": "Receipt"
    },
    {
      "id": "t002",
      "date": "2024-12-18",
      "description": "Office Supplies Purchase",
      "reference": "PO-567",
      "debit": 0.0,
      "credit": 450.00,
      "balance": 42500.50,
      "category": "Expenses",
      "type": "Payment"
    },
    {
      "id": "t003",
      "date": "2024-12-17",
      "description": "Rent Payment - December",
      "reference": "RENT-12",
      "debit": 0.0,
      "credit": 2000.00,
      "balance": 42950.50,
      "category": "Expenses",
      "type": "Payment"
    },
    {
      "id": "t004",
      "date": "2024-12-16",
      "description": "Service Revenue - Client ABC",
      "reference": "SRV-789",
      "debit": 1800.00,
      "credit": 0.0,
      "balance": 44950.50,
      "category": "Revenue",
      "type": "Receipt"
    },
    {
      "id": "t005",
      "date": "2024-12-15",
      "description": "Utility Payment - Electricity",
      "reference": "UTIL-001",
      "debit": 0.0,
      "credit": 350.00,
      "balance": 43150.50,
      "category": "Expenses",
      "type": "Payment"
    },
    {
      "id": "t006",
      "date": "2024-12-14",
      "description": "Product Sales - Store",
      "reference": "SALE-456",
      "debit": 3200.00,
      "credit": 0.0,
      "balance": 43500.50,
      "category": "Revenue",
      "type": "Receipt"
    },
    {
      "id": "t007",
      "date": "2024-12-13",
      "description": "Marketing Expenses - Ads",
      "reference": "MKT-123",
      "debit": 0.0,
      "credit": 800.00,
      "balance": 40300.50,
      "category": "Expenses",
      "type": "Payment"
    },
    {
      "id": "t008",
      "date": "2024-12-12",
      "description": "Customer Refund",
      "reference": "REF-001",
      "debit": 0.0,
      "credit": 150.00,
      "balance": 41100.50,
      "category": "Sales Returns",
      "type": "Refund"
    }
  ];

  List<Map<String, dynamic>> balanceHistory = [
    {"date": "2024-12-01", "balance": 38500.00},
    {"date": "2024-12-05", "balance": 41200.00},
    {"date": "2024-12-10", "balance": 39800.00},
    {"date": "2024-12-15", "balance": 43500.00},
    {"date": "2024-12-19", "balance": 45000.50},
  ];

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

  Color _getTransactionTypeColor(String type) {
    switch (type) {
      case "Receipt":
        return successColor;
      case "Payment":
        return dangerColor;
      case "Transfer":
        return infoColor;
      case "Refund":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${accountInfo["name"]}"),
        actions: [
          IconButton(
            onPressed: () {
              //navigateTo('EditAccountView', accountInfo)
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              //navigateTo('AccountReportsView', accountInfo)
            },
            icon: Icon(Icons.assessment),
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
                  // Account Info Card
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: _getAccountTypeColor("${accountInfo["type"]}"),
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: _getAccountTypeColor("${accountInfo["type"]}").withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.account_balance,
                                color: _getAccountTypeColor("${accountInfo["type"]}"),
                                size: 24,
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
                                          "${accountInfo["name"]}",
                                          style: TextStyle(
                                            fontSize: fsH6,
                                            fontWeight: FontWeight.bold,
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
                                          color: accountInfo["status"] == "Active" ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${accountInfo["status"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: accountInfo["status"] == "Active" ? successColor : dangerColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Text(
                                        "Account No. ${accountInfo["number"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getAccountTypeColor("${accountInfo["type"]}").withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${accountInfo["type"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: _getAccountTypeColor("${accountInfo["type"]}"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        if (accountInfo["description"] != null) ...[
                          Text(
                            "${accountInfo["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                        ],
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: _getAccountTypeColor("${accountInfo["type"]}").withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Current Balance",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${(accountInfo["balance"] as double).currency}",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (accountInfo["reconciled"] == true) ...[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: successColor,
                                        size: 16,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "Reconciled",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: successColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Statistics Cards
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildStatCard("Total Debits", "${(accountInfo["totalDebits"] as double).currency}", Icons.arrow_upward, successColor),
                      _buildStatCard("Total Credits", "${(accountInfo["totalCredits"] as double).currency}", Icons.arrow_downward, dangerColor),
                      _buildStatCard("Average Balance", "${(accountInfo["averageBalance"] as double).currency}", Icons.trending_up, infoColor),
                      _buildStatCard("Transactions", "${accountInfo["transactionCount"]}", Icons.receipt, primaryColor),
                    ],
                  ),

                  // Period Filter
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: QDropdownField(
                      label: "View Period",
                      items: periodOptions,
                      value: selectedPeriod,
                      onChanged: (value, label) {
                        selectedPeriod = value;
                        setState(() {});
                      },
                    ),
                  ),

                  // Transactions List
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
                                Icons.history,
                                color: primaryColor,
                                size: 20,
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
                              QButton(
                                label: "View All",
                                size: bs.sm,
                                onPressed: () {
                                  //navigateTo('TransactionListView', accountInfo)
                                },
                              ),
                            ],
                          ),
                        ),
                        Divider(height: 1),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: transactions.length,
                          separatorBuilder: (context, index) => Divider(height: 1),
                          itemBuilder: (context, index) {
                            final transaction = transactions[index];
                            double debit = (transaction["debit"] as num).toDouble();
                            double credit = (transaction["credit"] as num).toDouble();
                            bool isDebit = debit > 0;

                            return GestureDetector(
                              onTap: () {
                                //navigateTo('TransactionDetailView', transaction)
                              },
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color: _getTransactionTypeColor("${transaction["type"]}").withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Icon(
                                        isDebit ? Icons.arrow_upward : Icons.arrow_downward,
                                        color: _getTransactionTypeColor("${transaction["type"]}"),
                                        size: 18,
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
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 2),
                                          Row(
                                            children: [
                                              Text(
                                                "${DateTime.parse("${transaction["date"]}").dMMMy}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                              if (transaction["reference"] != null) ...[
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
                                                  "${transaction["reference"]}",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: disabledBoldColor,
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${isDebit ? '+' : '-'}${(isDebit ? debit : credit).currency}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: isDebit ? successColor : dangerColor,
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          "${(transaction["balance"] as double).currency}",
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
                                      size: 14,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //navigateTo('AddTransactionView', accountInfo)
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
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
                Icons.more_vert,
                color: disabledColor,
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
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
