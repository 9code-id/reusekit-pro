import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaTrustAccountingView extends StatefulWidget {
  const LcaTrustAccountingView({super.key});

  @override
  State<LcaTrustAccountingView> createState() => _LcaTrustAccountingViewState();
}

class _LcaTrustAccountingViewState extends State<LcaTrustAccountingView> {
  String searchQuery = "";
  String selectedAccount = "all";
  String selectedTransactionType = "all";
  String dateRange = "30_days";
  
  List<Map<String, dynamic>> trustAccounts = [
    {
      "id": "TA001",
      "account_name": "Client Settlement Fund",
      "account_number": "TST-2024-001",
      "balance": 125750.00,
      "client_name": "Johnson & Associates",
      "case_number": "2024-0123",
      "status": "active",
      "last_transaction": "2024-06-18",
    },
    {
      "id": "TA002",
      "account_name": "Legal Retainer Account",
      "account_number": "TST-2024-002",
      "balance": 45300.00,
      "client_name": "Tech Solutions Inc",
      "case_number": "2024-0124",
      "status": "active", 
      "last_transaction": "2024-06-17",
    },
    {
      "id": "TA003",
      "account_name": "Court Deposit Fund",
      "account_number": "TST-2024-003",
      "balance": 75000.00,
      "client_name": "Green Valley Medical",
      "case_number": "2024-0125",
      "status": "restricted",
      "last_transaction": "2024-06-15",
    },
  ];

  List<Map<String, dynamic>> transactions = [
    {
      "id": "TXN001",
      "account_id": "TA001",
      "account_name": "Client Settlement Fund",
      "type": "deposit",
      "amount": 25000.00,
      "description": "Insurance settlement payment received",
      "date": "2024-06-18",
      "reference": "REF-2024-089",
      "balance_after": 125750.00,
      "client_name": "Johnson & Associates",
    },
    {
      "id": "TXN002",
      "account_id": "TA002",
      "type": "withdrawal",
      "amount": 5000.00,
      "description": "Legal fees disbursement",
      "date": "2024-06-17",
      "reference": "REF-2024-090",
      "balance_after": 45300.00,
      "client_name": "Tech Solutions Inc",
      "account_name": "Legal Retainer Account",
    },
    {
      "id": "TXN003",
      "account_id": "TA001",
      "type": "withdrawal",
      "amount": 2500.00,
      "description": "Court filing fees",
      "date": "2024-06-16",
      "reference": "REF-2024-091",
      "balance_after": 100750.00,
      "client_name": "Johnson & Associates",
      "account_name": "Client Settlement Fund",
    },
    {
      "id": "TXN004",
      "account_id": "TA003",
      "type": "deposit",
      "amount": 75000.00,
      "description": "Court deposit for medical malpractice case",
      "date": "2024-06-15",
      "reference": "REF-2024-092",
      "balance_after": 75000.00,
      "client_name": "Green Valley Medical",
      "account_name": "Court Deposit Fund",
    },
    {
      "id": "TXN005",
      "account_id": "TA002",
      "type": "deposit",
      "amount": 15000.00,
      "description": "Client retainer payment",
      "date": "2024-06-14",
      "reference": "REF-2024-093",
      "balance_after": 50300.00,
      "client_name": "Tech Solutions Inc",
      "account_name": "Legal Retainer Account",
    },
  ];

  List<Map<String, dynamic>> get filteredTransactions {
    return transactions.where((transaction) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${transaction["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${transaction["client_name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${transaction["reference"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesAccount = selectedAccount == "all" || transaction["account_id"] == selectedAccount;
      bool matchesType = selectedTransactionType == "all" || transaction["type"] == selectedTransactionType;
      
      return matchesSearch && matchesAccount && matchesType;
    }).toList();
  }

  Color _getAccountStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "restricted":
        return warningColor;
      case "frozen":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getTransactionTypeColor(String type) {
    switch (type) {
      case "deposit":
        return successColor;
      case "withdrawal":
        return dangerColor;
      case "transfer":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalBalance = trustAccounts.fold(0.0, (sum, account) => sum + (account["balance"] as double));
    final totalDeposits = filteredTransactions.where((t) => t["type"] == "deposit").fold(0.0, (sum, t) => sum + (t["amount"] as double));
    final totalWithdrawals = filteredTransactions.where((t) => t["type"] == "withdrawal").fold(0.0, (sum, t) => sum + (t["amount"] as double));

    return Scaffold(
      appBar: AppBar(
        title: Text("Trust Accounting"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_card),
            onPressed: () {
              // Navigate to create new trust account
            },
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              si("Generating trust account report...");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: Container(
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
                            Icon(
                              Icons.account_balance,
                              color: primaryColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Total Balance",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "\$${totalBalance.currency}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
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
                            Icon(
                              Icons.trending_up,
                              color: successColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Total Deposits",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "\$${totalDeposits.currency}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: Container(
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
                            Icon(
                              Icons.trending_down,
                              color: dangerColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Total Withdrawals",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "\$${totalWithdrawals.currency}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
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
                            Icon(
                              Icons.folder,
                              color: infoColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Active Accounts",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${trustAccounts.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),

            // Trust Accounts
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
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Text(
                          "Trust Accounts",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Reconcile",
                          size: bs.sm,
                          onPressed: () {
                            si("Starting account reconciliation...");
                          },
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: trustAccounts.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final account = trustAccounts[index];
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.account_balance_wallet,
                                color: primaryColor,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${account["account_name"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getAccountStatusColor("${account["status"]}").withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${account["status"]}".toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: _getAccountStatusColor("${account["status"]}"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${account["account_number"]} • ${account["client_name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "Last transaction: ${DateTime.parse("${account["last_transaction"]}").dMMMy}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spMd),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "\$${(account["balance"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spSm),
                                QButton(
                                  label: "View",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to account details
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Filters
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Transaction Filters",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  QTextField(
                    label: "Search transactions...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Transaction Type",
                          items: [
                            {"label": "All Types", "value": "all"},
                            {"label": "Deposits", "value": "deposit"},
                            {"label": "Withdrawals", "value": "withdrawal"},
                            {"label": "Transfers", "value": "transfer"},
                          ],
                          value: selectedTransactionType,
                          onChanged: (value, label) {
                            selectedTransactionType = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Date Range",
                          items: [
                            {"label": "Last 30 Days", "value": "30_days"},
                            {"label": "Last 60 Days", "value": "60_days"},
                            {"label": "Last 90 Days", "value": "90_days"},
                            {"label": "This Year", "value": "year"},
                          ],
                          value: dateRange,
                          onChanged: (value, label) {
                            dateRange = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Recent Transactions
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
                    padding: EdgeInsets.all(spMd),
                    child: Text(
                      "Recent Transactions (${filteredTransactions.length})",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredTransactions.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final transaction = filteredTransactions[index];
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: _getTransactionTypeColor("${transaction["type"]}").withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                transaction["type"] == "deposit" ? Icons.add : Icons.remove,
                                color: _getTransactionTypeColor("${transaction["type"]}"),
                                size: 20,
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${transaction["account_name"]} • ${transaction["client_name"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${DateTime.parse("${transaction["date"]}").dMMMy} • ${transaction["reference"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spMd),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${transaction["type"] == "deposit" ? "+" : "-"}\$${(transaction["amount"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: _getTransactionTypeColor("${transaction["type"]}"),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "Balance: \$${(transaction["balance_after"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
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
}
