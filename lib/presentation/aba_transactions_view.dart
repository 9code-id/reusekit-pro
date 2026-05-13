import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaTransactionsView extends StatefulWidget {
  const AbaTransactionsView({super.key});

  @override
  State<AbaTransactionsView> createState() => _AbaTransactionsViewState();
}

class _AbaTransactionsViewState extends State<AbaTransactionsView> {
  String searchQuery = "";
  String selectedAccount = "";
  String selectedType = "";
  String selectedStatus = "";
  String dateFilter = "";
  String sortBy = "date_desc";

  List<Map<String, dynamic>> accountItems = [
    {"label": "All Accounts", "value": ""},
    {"label": "Chase Checking - *1234", "value": "chase_checking"},
    {"label": "Wells Fargo Savings - *5678", "value": "wells_savings"},
    {"label": "Capital One Credit - *9012", "value": "capital_credit"},
    {"label": "Business Checking - *3456", "value": "business_checking"},
  ];

  List<Map<String, dynamic>> typeItems = [
    {"label": "All Types", "value": ""},
    {"label": "Income", "value": "income"},
    {"label": "Expense", "value": "expense"},
    {"label": "Transfer", "value": "transfer"},
    {"label": "Payment", "value": "payment"},
    {"label": "Deposit", "value": "deposit"},
    {"label": "Withdrawal", "value": "withdrawal"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": ""},
    {"label": "Completed", "value": "completed"},
    {"label": "Pending", "value": "pending"},
    {"label": "Failed", "value": "failed"},
    {"label": "Cancelled", "value": "cancelled"},
  ];

  List<Map<String, dynamic>> dateItems = [
    {"label": "All Time", "value": ""},
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "Last 3 Months", "value": "3months"},
    {"label": "This Year", "value": "year"},
  ];

  List<Map<String, dynamic>> sortItems = [
    {"label": "Date (Newest First)", "value": "date_desc"},
    {"label": "Date (Oldest First)", "value": "date_asc"},
    {"label": "Amount (High to Low)", "value": "amount_desc"},
    {"label": "Amount (Low to High)", "value": "amount_asc"},
    {"label": "Account Name", "value": "account"},
    {"label": "Transaction Type", "value": "type"},
  ];

  List<Map<String, dynamic>> transactions = [
    {
      "id": "TXN001",
      "date": "2024-12-16",
      "time": "14:30",
      "description": "Salary Direct Deposit",
      "amount": 4500.00,
      "type": "deposit",
      "typeLabel": "Deposit",
      "account": "Chase Checking - *1234",
      "accountId": "chase_checking",
      "category": "Income",
      "subcategory": "Salary",
      "status": "completed",
      "statusLabel": "Completed",
      "reference": "DD202412160001",
      "balance": 15420.50,
      "merchantName": "ABC Corporation",
      "location": "Direct Deposit",
    },
    {
      "id": "TXN002",
      "date": "2024-12-15",
      "time": "16:45",
      "description": "Grocery Store Purchase",
      "amount": -125.75,
      "type": "expense",
      "typeLabel": "Expense",
      "account": "Capital One Credit - *9012",
      "accountId": "capital_credit",
      "category": "Food & Dining",
      "subcategory": "Groceries",
      "status": "completed",
      "statusLabel": "Completed",
      "reference": "CC202412150002",
      "balance": 2325.25,
      "merchantName": "Whole Foods Market",
      "location": "123 Main St, Anytown, NY",
    },
    {
      "id": "TXN003",
      "date": "2024-12-15",
      "time": "10:20",
      "description": "Transfer to Savings",
      "amount": -500.00,
      "type": "transfer",
      "typeLabel": "Transfer",
      "account": "Chase Checking - *1234",
      "accountId": "chase_checking",
      "category": "Transfer",
      "subcategory": "Internal Transfer",
      "status": "completed",
      "statusLabel": "Completed",
      "reference": "TRF202412150003",
      "balance": 10920.50,
      "merchantName": "Wells Fargo Savings",
      "location": "Internal Transfer",
    },
    {
      "id": "TXN004",
      "date": "2024-12-14",
      "time": "09:15",
      "description": "Electric Bill Payment",
      "amount": -185.20,
      "type": "payment",
      "typeLabel": "Payment",
      "account": "Chase Checking - *1234",
      "accountId": "chase_checking",
      "category": "Utilities",
      "subcategory": "Electricity",
      "status": "completed",
      "statusLabel": "Completed",
      "reference": "PAY202412140004",
      "balance": 11420.50,
      "merchantName": "ConEd Electric",
      "location": "Online Payment",
    },
    {
      "id": "TXN005",
      "date": "2024-12-14",
      "time": "13:30",
      "description": "Gas Station Purchase",
      "amount": -65.40,
      "type": "expense",
      "typeLabel": "Expense",
      "account": "Capital One Credit - *9012",
      "accountId": "capital_credit",
      "category": "Transportation",
      "subcategory": "Gas",
      "status": "pending",
      "statusLabel": "Pending",
      "reference": "CC202412140005",
      "balance": 2451.00,
      "merchantName": "Shell Gas Station",
      "location": "456 Oak Ave, Anytown, NY",
    },
    {
      "id": "TXN006",
      "date": "2024-12-13",
      "time": "19:45",
      "description": "Restaurant Dinner",
      "amount": -89.50,
      "type": "expense",
      "typeLabel": "Expense",
      "account": "Capital One Credit - *9012",
      "accountId": "capital_credit",
      "category": "Food & Dining",
      "subcategory": "Restaurants",
      "status": "completed",
      "statusLabel": "Completed",
      "reference": "CC202412130006",
      "balance": 2516.40,
      "merchantName": "The Italian Kitchen",
      "location": "789 Pine St, Anytown, NY",
    },
    {
      "id": "TXN007",
      "date": "2024-12-13",
      "time": "08:00",
      "description": "ATM Withdrawal",
      "amount": -100.00,
      "type": "withdrawal",
      "typeLabel": "Withdrawal",
      "account": "Chase Checking - *1234",
      "accountId": "chase_checking",
      "category": "Cash",
      "subcategory": "ATM Withdrawal",
      "status": "completed",
      "statusLabel": "Completed",
      "reference": "ATM202412130007",
      "balance": 11605.70,
      "merchantName": "Chase ATM",
      "location": "Downtown Branch",
    },
    {
      "id": "TXN008",
      "date": "2024-12-12",
      "time": "11:25",
      "description": "Online Purchase - Amazon",
      "amount": -245.99,
      "type": "expense",
      "typeLabel": "Expense",
      "account": "Capital One Credit - *9012",
      "accountId": "capital_credit",
      "category": "Shopping",
      "subcategory": "Online",
      "status": "completed",
      "statusLabel": "Completed",
      "reference": "CC202412120008",
      "balance": 2605.90,
      "merchantName": "Amazon.com",
      "location": "Online Purchase",
    },
  ];

  List<Map<String, dynamic>> get filteredTransactions {
    var filtered = transactions.where((transaction) {
      final matchesSearch = searchQuery.isEmpty ||
          (transaction["description"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (transaction["merchantName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (transaction["reference"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesAccount = selectedAccount.isEmpty || 
          transaction["accountId"] == selectedAccount;
          
      final matchesType = selectedType.isEmpty ||
          transaction["type"] == selectedType;
          
      final matchesStatus = selectedStatus.isEmpty ||
          transaction["status"] == selectedStatus;
      
      return matchesSearch && matchesAccount && matchesType && matchesStatus;
    }).toList();

    switch (sortBy) {
      case "date_asc":
        filtered.sort((a, b) => DateTime.parse(a["date"]).compareTo(DateTime.parse(b["date"])));
        break;
      case "amount_desc":
        filtered.sort((a, b) => (b["amount"] as double).abs().compareTo((a["amount"] as double).abs()));
        break;
      case "amount_asc":
        filtered.sort((a, b) => (a["amount"] as double).abs().compareTo((b["amount"] as double).abs()));
        break;
      case "account":
        filtered.sort((a, b) => (a["account"] as String).compareTo(b["account"] as String));
        break;
      case "type":
        filtered.sort((a, b) => (a["typeLabel"] as String).compareTo(b["typeLabel"] as String));
        break;
      default:
        filtered.sort((a, b) => DateTime.parse(b["date"]).compareTo(DateTime.parse(a["date"])));
    }

    return filtered;
  }

  double get totalIncome {
    return transactions
        .where((t) => (t["amount"] as double) > 0)
        .fold(0.0, (sum, t) => sum + (t["amount"] as double));
  }

  double get totalExpenses {
    return transactions
        .where((t) => (t["amount"] as double) < 0)
        .fold(0.0, (sum, t) => sum + (t["amount"] as double).abs());
  }

  double get netFlow {
    return totalIncome - totalExpenses;
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "income":
      case "deposit":
        return successColor;
      case "expense":
        return dangerColor;
      case "transfer":
        return infoColor;
      case "payment":
        return warningColor;
      case "withdrawal":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "income":
      case "deposit":
        return Icons.trending_up;
      case "expense":
        return Icons.trending_down;
      case "transfer":
        return Icons.swap_horiz;
      case "payment":
        return Icons.payment;
      case "withdrawal":
        return Icons.money;
      default:
        return Icons.history;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "pending":
        return warningColor;
      case "failed":
        return dangerColor;
      case "cancelled":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transactions"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add transaction
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [successColor, successColor.withAlpha(200)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.trending_up,
                              color: Colors.white.withAlpha(230),
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Total Income",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(230),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "\$${totalIncome.currency}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
                      gradient: LinearGradient(
                        colors: [dangerColor, dangerColor.withAlpha(200)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.trending_down,
                              color: Colors.white.withAlpha(230),
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Total Expenses",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(230),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "\$${totalExpenses.currency}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
                      gradient: LinearGradient(
                        colors: [primaryColor, primaryColor.withAlpha(200)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.account_balance_wallet,
                              color: Colors.white.withAlpha(230),
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Net Flow",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(230),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${netFlow >= 0 ? '+' : ''}\$${netFlow.abs().currency}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),
            
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search transactions",
                    value: searchQuery,
                    hint: "Search by description, merchant, or reference",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: spSm),
            
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Account",
                    items: accountItems,
                    value: selectedAccount,
                    onChanged: (value, label) {
                      selectedAccount = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Type",
                    items: typeItems,
                    value: selectedType,
                    onChanged: (value, label) {
                      selectedType = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: statusItems,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Sort by",
                    items: sortItems,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Transactions (${filteredTransactions.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QButton(
                  label: "Add Transaction",
                  icon: Icons.add,
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to add transaction
                  },
                ),
              ],
            ),
            SizedBox(height: spMd),
            
            ...filteredTransactions.map((transaction) {
              final amount = transaction["amount"] as double;
              final isPositive = amount > 0;
              final type = transaction["type"] as String;
              final status = transaction["status"] as String;
              final typeColor = _getTypeColor(type);
              final typeIcon = _getTypeIcon(type);
              final statusColor = _getStatusColor(status);
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: typeColor.withAlpha(100)),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: typeColor.withAlpha(20),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusLg),
                          topRight: Radius.circular(radiusLg),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: typeColor,
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Icon(
                              typeIcon,
                              color: Colors.white,
                              size: 20,
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
                                        "${transaction["description"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: statusColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${transaction["statusLabel"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${transaction["merchantName"]} • ${transaction["account"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
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
                                "${isPositive ? '+' : ''}\$${amount.abs().currency}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: isPositive ? successColor : dangerColor,
                                ),
                              ),
                              Text(
                                "${DateTime.parse(transaction["date"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Category",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${transaction["category"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Reference",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${transaction["reference"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Balance",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "\$${(transaction["balance"] as double).currency}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: successColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spMd),
                          
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to transaction details
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: QButton(
                                  label: "Edit Transaction",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to edit transaction
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.more_vert,
                                size: bs.sm,
                                onPressed: () {},
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
    );
  }
}
