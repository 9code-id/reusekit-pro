import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaTransactionHistoryView extends StatefulWidget {
  const BfaTransactionHistoryView({super.key});

  @override
  State<BfaTransactionHistoryView> createState() => _BfaTransactionHistoryViewState();
}

class _BfaTransactionHistoryViewState extends State<BfaTransactionHistoryView> {
  String selectedFilter = "All";
  String selectedDateRange = "Last 30 Days";
  String searchQuery = "";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Transactions", "value": "All"},
    {"label": "Credit", "value": "Credit"},
    {"label": "Debit", "value": "Debit"},
    {"label": "Transfer", "value": "Transfer"},
    {"label": "Payment", "value": "Payment"},
    {"label": "ATM", "value": "ATM"},
  ];
  
  List<Map<String, dynamic>> dateRangeOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "Last 6 Months", "value": "Last 6 Months"},
    {"label": "Custom Range", "value": "Custom"},
  ];
  
  List<Map<String, dynamic>> transactions = [
    {
      "id": "TXN001",
      "type": "Credit",
      "description": "Salary Credit - ABC Corp",
      "amount": 5500.00,
      "balance": 125450.75,
      "date": "2024-01-15 14:30:00",
      "status": "Completed",
      "reference": "SAL/2024/001",
      "category": "Salary"
    },
    {
      "id": "TXN002",
      "type": "Debit",
      "description": "Online Purchase - Amazon",
      "amount": -245.50,
      "balance": 119950.75,
      "date": "2024-01-15 10:15:00",
      "status": "Completed",
      "reference": "AMZ/2024/1234",
      "category": "Shopping"
    },
    {
      "id": "TXN003",
      "type": "Transfer",
      "description": "Transfer to Jane Smith",
      "amount": -1500.00,
      "balance": 120196.25,
      "date": "2024-01-14 16:45:00",
      "status": "Completed",
      "reference": "TRF/2024/567",
      "category": "Transfer"
    },
    {
      "id": "TXN004",
      "type": "Payment",
      "description": "Electricity Bill - City Power",
      "amount": -158.75,
      "balance": 121696.25,
      "date": "2024-01-14 09:20:00",
      "status": "Completed",
      "reference": "BILL/2024/890",
      "category": "Utility"
    },
    {
      "id": "TXN005",
      "type": "ATM",
      "description": "Cash Withdrawal - ATM 123456",
      "amount": -300.00,
      "balance": 121855.00,
      "date": "2024-01-13 18:30:00",
      "status": "Completed",
      "reference": "ATM/2024/789",
      "category": "Cash"
    },
    {
      "id": "TXN006",
      "type": "Credit",
      "description": "Interest Credit - Savings Account",
      "amount": 25.50,
      "balance": 122155.00,
      "date": "2024-01-13 12:00:00",
      "status": "Completed",
      "reference": "INT/2024/001",
      "category": "Interest"
    },
    {
      "id": "TXN007",
      "type": "Debit",
      "description": "Restaurant Payment - Dine & Wine",
      "amount": -89.25,
      "balance": 122129.50,
      "date": "2024-01-12 20:15:00",
      "status": "Completed",
      "reference": "REST/2024/456",
      "category": "Food"
    },
    {
      "id": "TXN008",
      "type": "Transfer",
      "description": "Transfer from Michael Johnson",
      "amount": 750.00,
      "balance": 122218.75,
      "date": "2024-01-12 14:30:00",
      "status": "Completed",
      "reference": "TRF/2024/321",
      "category": "Transfer"
    },
    {
      "id": "TXN009",
      "type": "Payment",
      "description": "Mobile Recharge - Telecom Plus",
      "amount": -35.00,
      "balance": 121468.75,
      "date": "2024-01-11 11:45:00",
      "status": "Completed",
      "reference": "MOB/2024/654",
      "category": "Telecom"
    },
    {
      "id": "TXN010",
      "type": "Debit",
      "description": "Grocery Shopping - SuperMart",
      "amount": -125.80,
      "balance": 121503.75,
      "date": "2024-01-11 16:20:00",
      "status": "Completed",
      "reference": "GRO/2024/987",
      "category": "Grocery"
    },
  ];

  List<Map<String, dynamic>> get filteredTransactions {
    return transactions.where((transaction) {
      bool matchesFilter = selectedFilter == "All" || transaction["type"] == selectedFilter;
      bool matchesSearch = searchQuery.isEmpty || 
          (transaction["description"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (transaction["reference"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return matchesFilter && matchesSearch;
    }).toList();
  }

  Map<String, dynamic> get transactionSummary {
    List<Map<String, dynamic>> filtered = filteredTransactions;
    double totalCredit = 0;
    double totalDebit = 0;
    int creditCount = 0;
    int debitCount = 0;
    
    for (var transaction in filtered) {
      double amount = transaction["amount"] as double;
      if (amount > 0) {
        totalCredit += amount;
        creditCount++;
      } else {
        totalDebit += amount.abs();
        debitCount++;
      }
    }
    
    return {
      "totalCredit": totalCredit,
      "totalDebit": totalDebit,
      "creditCount": creditCount,
      "debitCount": debitCount,
      "netAmount": totalCredit - totalDebit,
    };
  }

  Color _getTransactionColor(String type) {
    switch (type) {
      case "Credit":
        return successColor;
      case "Debit":
        return dangerColor;
      case "Transfer":
        return infoColor;
      case "Payment":
        return warningColor;
      case "ATM":
        return secondaryColor;
      default:
        return primaryColor;
    }
  }

  IconData _getTransactionIcon(String type) {
    switch (type) {
      case "Credit":
        return Icons.add_circle;
      case "Debit":
        return Icons.remove_circle;
      case "Transfer":
        return Icons.swap_horiz;
      case "Payment":
        return Icons.payment;
      case "ATM":
        return Icons.atm;
      default:
        return Icons.account_balance_wallet;
    }
  }

  String _getCategoryIcon(String category) {
    switch (category) {
      case "Salary":
        return "💼";
      case "Shopping":
        return "🛒";
      case "Transfer":
        return "💸";
      case "Utility":
        return "⚡";
      case "Cash":
        return "💰";
      case "Interest":
        return "📈";
      case "Food":
        return "🍽️";
      case "Telecom":
        return "📱";
      case "Grocery":
        return "🛍️";
      default:
        return "💳";
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> summary = transactionSummary;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction History"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Downloading transaction history");
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: () {
              ss("Advanced filters opened");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: successColor.withAlpha(50),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.trending_up,
                          color: successColor,
                          size: 32,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Total Credit",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "\$${((summary["totalCredit"] as double).toDouble()).currency}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "${summary["creditCount"]} transactions",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: dangerColor.withAlpha(50),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.trending_down,
                          color: dangerColor,
                          size: 32,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Total Debit",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "\$${((summary["totalDebit"] as double).toDouble()).currency}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "${summary["debitCount"]} transactions",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Net Amount
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: (summary["netAmount"] as double) >= 0 ? successColor.withAlpha(10) : dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: (summary["netAmount"] as double) >= 0 ? successColor.withAlpha(50) : dangerColor.withAlpha(50),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    (summary["netAmount"] as double) >= 0 ? Icons.trending_up : Icons.trending_down,
                    color: (summary["netAmount"] as double) >= 0 ? successColor : dangerColor,
                    size: 32,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Net Amount",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${(summary["netAmount"] as double) >= 0 ? '+' : ''}\$${(((summary["netAmount"] as double).abs()).toDouble()).currency}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: (summary["netAmount"] as double) >= 0 ? successColor : dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "${filteredTransactions.length} total transactions",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

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
                    "Filter Transactions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search",
                          value: searchQuery,
                          hint: "Search by description or reference...",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Transaction Type",
                          items: filterOptions,
                          value: selectedFilter,
                          onChanged: (value, label) {
                            selectedFilter = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QDropdownField(
                          label: "Date Range",
                          items: dateRangeOptions,
                          value: selectedDateRange,
                          onChanged: (value, label) {
                            selectedDateRange = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Transaction List
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
                  Row(
                    children: [
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
                        label: "Export",
                        icon: Icons.file_download,
                        size: bs.sm,
                        onPressed: () {
                          ss("Exporting filtered transactions");
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  if (filteredTransactions.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.receipt_long,
                              size: 64,
                              color: disabledColor,
                            ),
                            SizedBox(height: spMd),
                            Text(
                              "No transactions found",
                              style: TextStyle(
                                fontSize: 16,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "Try adjusting your filters or search criteria",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ...filteredTransactions.map((transaction) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spMd),
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: _getTransactionColor(transaction["type"] as String).withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: disabledOutlineBorderColor,
                          ),
                        ),
                        child: Row(
                          children: [
                            // Icon and Category
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: _getTransactionColor(transaction["type"] as String).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    _getTransactionIcon(transaction["type"] as String),
                                    color: _getTransactionColor(transaction["type"] as String),
                                    size: 24,
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    _getCategoryIcon(transaction["category"] as String),
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spMd),
                            
                            // Transaction Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${transaction["description"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${(transaction["amount"] as double) >= 0 ? '+' : ''}\$${(((transaction["amount"] as double).abs()).toDouble()).currency}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: _getTransactionColor(transaction["type"] as String),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                        decoration: BoxDecoration(
                                          color: _getTransactionColor(transaction["type"] as String).withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${transaction["type"]}",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: _getTransactionColor(transaction["type"] as String),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: Text(
                                          "Ref: ${transaction["reference"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Text(
                                        "${DateTime.parse(transaction["date"] as String).dMMMy} • ${DateTime.parse(transaction["date"] as String).dMMMy}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "Balance: \$${((transaction["balance"] as double).toDouble()).currency}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                ],
              ),
            ),

            // Load More Button
            if (filteredTransactions.length >= 10)
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Load More Transactions",
                  icon: Icons.keyboard_arrow_down,
                  size: bs.md,
                  onPressed: () {
                    ss("Loading more transactions...");
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
