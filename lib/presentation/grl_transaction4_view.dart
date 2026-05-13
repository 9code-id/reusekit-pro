import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTransaction4View extends StatefulWidget {
  @override
  State<GrlTransaction4View> createState() => _GrlTransaction4ViewState();
}

class _GrlTransaction4ViewState extends State<GrlTransaction4View> {
  String searchQuery = "";
  String selectedFilter = "All";
  String selectedPeriod = "This Month";
  bool loading = false;

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Income", "value": "Income"},
    {"label": "Expense", "value": "Expense"},
    {"label": "Transfer", "value": "Transfer"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> transactions = [
    {
      "id": "TXN001",
      "type": "Income",
      "title": "Salary Payment",
      "description": "Monthly salary from TechCorp",
      "amount": 5500.00,
      "date": "2024-06-20",
      "time": "09:30 AM",
      "category": "Salary",
      "status": "Completed",
      "account": "Main Account",
      "icon": Icons.work,
      "color": Colors.green,
    },
    {
      "id": "TXN002",
      "type": "Expense",
      "title": "Grocery Shopping",
      "description": "Weekly groceries at SuperMart",
      "amount": 125.50,
      "date": "2024-06-19",
      "time": "02:15 PM",
      "category": "Food & Dining",
      "status": "Completed",
      "account": "Debit Card",
      "icon": Icons.shopping_cart,
      "color": Colors.orange,
    },
    {
      "id": "TXN003",
      "type": "Transfer",
      "title": "Money Transfer",
      "description": "Transfer to Sarah Wilson",
      "amount": 250.00,
      "date": "2024-06-18",
      "time": "11:45 AM",
      "category": "Transfer",
      "status": "Completed",
      "account": "Savings Account",
      "icon": Icons.send,
      "color": Colors.blue,
    },
    {
      "id": "TXN004",
      "type": "Expense",
      "title": "Electric Bill",
      "description": "Monthly electricity payment",
      "amount": 89.75,
      "date": "2024-06-17",
      "time": "08:20 AM",
      "category": "Utilities",
      "status": "Completed",
      "account": "Main Account",
      "icon": Icons.flash_on,
      "color": Colors.red,
    },
    {
      "id": "TXN005",
      "type": "Income",
      "title": "Freelance Project",
      "description": "Web development project",
      "amount": 800.00,
      "date": "2024-06-16",
      "time": "04:30 PM",
      "category": "Freelance",
      "status": "Pending",
      "account": "Business Account",
      "icon": Icons.computer,
      "color": Colors.purple,
    },
  ];

  List<Map<String, dynamic>> get filteredTransactions {
    List<Map<String, dynamic>> filtered = transactions;

    if (selectedFilter != "All") {
      filtered = filtered.where((t) => t["type"] == selectedFilter).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((t) =>
        t["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        t["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        t["category"].toString().toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }

    return filtered;
  }

  double get totalIncome {
    return transactions
        .where((t) => t["type"] == "Income")
        .fold(0.0, (sum, t) => sum + (t["amount"] as double));
  }

  double get totalExpense {
    return transactions
        .where((t) => t["type"] == "Expense")
        .fold(0.0, (sum, t) => sum + (t["amount"] as double));
  }

  double get netBalance {
    return totalIncome - totalExpense;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction History"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _showFilterModal(),
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
                  _buildSummaryCards(),
                  _buildSearchAndFilters(),
                  _buildPeriodSelector(),
                  _buildTransactionsList(),
                ],
              ),
            ),
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.green.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: Colors.green.withAlpha(50)),
            ),
            child: Column(
              children: [
                Icon(Icons.trending_up, color: Colors.green, size: 24),
                SizedBox(height: spXs),
                Text(
                  "Income",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "\$${totalIncome.currency}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.red.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: Colors.red.withAlpha(50)),
            ),
            child: Column(
              children: [
                Icon(Icons.trending_down, color: Colors.red, size: 24),
                SizedBox(height: spXs),
                Text(
                  "Expense",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "\$${totalExpense.currency}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: primaryColor.withAlpha(50)),
            ),
            child: Column(
              children: [
                Icon(Icons.account_balance, color: primaryColor, size: 24),
                SizedBox(height: spXs),
                Text(
                  "Net Balance",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "\$${netBalance.currency}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchAndFilters() {
    return Row(
      children: [
        Expanded(
          child: QTextField(
            label: "Search transactions...",
            value: searchQuery,
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
        ),
        SizedBox(width: spSm),
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
            border: Border.all(color: primaryColor.withAlpha(50)),
          ),
          child: Icon(
            Icons.search,
            color: primaryColor,
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      width: double.infinity,
      child: QDropdownField(
        label: "Period",
        items: periodOptions,
        value: selectedPeriod,
        onChanged: (value, label) {
          selectedPeriod = value;
          setState(() {});
        },
      ),
    );
  }

  Widget _buildTransactionsList() {
    if (filteredTransactions.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spLg),
        child: Column(
          children: [
            Icon(Icons.receipt_long, size: 64, color: disabledColor),
            SizedBox(height: spSm),
            Text(
              "No transactions found",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "Try adjusting your search or filter criteria",
              style: TextStyle(
                color: disabledColor,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Transactions",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ...filteredTransactions.map((transaction) => _buildTransactionItem(transaction)),
      ],
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
    bool isIncome = transaction["type"] == "Income";
    bool isPending = transaction["status"] == "Pending";

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: isPending
            ? Border.all(color: warningColor.withAlpha(100), width: 1)
            : null,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: (transaction["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              transaction["icon"],
              color: transaction["color"],
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
                        "${transaction["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    if (isPending)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Pending",
                          style: TextStyle(
                            fontSize: 10,
                            color: warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${transaction["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 12, color: disabledColor),
                    SizedBox(width: 4),
                    Text(
                      "${transaction["date"]} • ${transaction["time"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${transaction["category"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
                "${isIncome ? "+" : "-"}\$${(transaction["amount"] as double).currency}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: isIncome ? Colors.green : Colors.red,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${transaction["account"]}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Filter Transactions",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.close, color: disabledBoldColor),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: spMd),
            QDropdownField(
              label: "Transaction Type",
              items: filterOptions,
              value: selectedFilter,
              onChanged: (value, label) {
                selectedFilter = value;
                setState(() {});
                Navigator.pop(context);
              },
            ),
            SizedBox(height: spLg),
          ],
        ),
      ),
    );
  }
}
