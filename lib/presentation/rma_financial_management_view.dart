import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaFinancialManagementView extends StatefulWidget {
  const RmaFinancialManagementView({super.key});

  @override
  State<RmaFinancialManagementView> createState() => _RmaFinancialManagementViewState();
}

class _RmaFinancialManagementViewState extends State<RmaFinancialManagementView> {
  int selectedTabIndex = 0;
  String searchQuery = "";
  String selectedAccount = "all";
  String selectedCategory = "all";
  String selectedPeriod = "current_month";
  
  List<Map<String, dynamic>> accounts = [
    {
      "id": "ACC001",
      "name": "Main Operating Account",
      "type": "checking",
      "balance": 125000.00,
      "bank": "First National Bank",
      "account_number": "****1234",
      "status": "active",
      "last_transaction": "2024-12-19",
    },
    {
      "id": "ACC002",
      "name": "RMA Processing Reserve",
      "type": "savings",
      "balance": 45000.00,
      "bank": "Commerce Bank",
      "account_number": "****5678",
      "status": "active",
      "last_transaction": "2024-12-18",
    },
    {
      "id": "ACC003",
      "name": "Refund Processing Account",
      "type": "checking",
      "balance": 18500.00,
      "bank": "Metro Credit Union",
      "account_number": "****9012",
      "status": "active",
      "last_transaction": "2024-12-19",
    },
    {
      "id": "ACC004",
      "name": "Investment Account",
      "type": "investment",
      "balance": 75000.00,
      "bank": "Investment Partners",
      "account_number": "****3456",
      "status": "restricted",
      "last_transaction": "2024-12-15",
    },
  ];

  List<Map<String, dynamic>> transactions = [
    {
      "id": "TXN001",
      "date": "2024-12-19",
      "description": "Customer Refund - RMA Return",
      "category": "refunds",
      "account": "ACC003",
      "amount": -450.00,
      "type": "debit",
      "status": "completed",
      "reference": "RMA-2024-001234",
    },
    {
      "id": "TXN002",
      "date": "2024-12-19",
      "description": "Service Revenue - Q4",
      "category": "revenue",
      "account": "ACC001",
      "amount": 12500.00,
      "type": "credit",
      "status": "completed",
      "reference": "INV-2024-5678",
    },
    {
      "id": "TXN003",
      "date": "2024-12-18",
      "description": "Processing Fee Payment",
      "category": "fees",
      "account": "ACC001",
      "amount": -125.00,
      "type": "debit",
      "status": "completed",
      "reference": "FEE-2024-001",
    },
    {
      "id": "TXN004",
      "date": "2024-12-18",
      "description": "Shipping Cost Reimbursement",
      "category": "operations",
      "account": "ACC002",
      "amount": -85.00,
      "type": "debit",
      "status": "completed",
      "reference": "SHIP-2024-789",
    },
    {
      "id": "TXN005",
      "date": "2024-12-17",
      "description": "Monthly Software Subscription",
      "category": "expenses",
      "account": "ACC001",
      "amount": -299.00,
      "type": "debit",
      "status": "completed",
      "reference": "SUB-2024-12",
    },
  ];

  List<Map<String, dynamic>> budgets = [
    {
      "category": "Refunds",
      "budgeted": 15000.00,
      "spent": 12500.00,
      "remaining": 2500.00,
      "percentage": 83.3,
      "status": "on_track",
    },
    {
      "category": "Operations",
      "budgeted": 8000.00,
      "spent": 6200.00,
      "remaining": 1800.00,
      "percentage": 77.5,
      "status": "on_track",
    },
    {
      "category": "Processing Fees",
      "budgeted": 2000.00,
      "spent": 1850.00,
      "remaining": 150.00,
      "percentage": 92.5,
      "status": "warning",
    },
    {
      "category": "Shipping",
      "budgeted": 5000.00,
      "spent": 5200.00,
      "remaining": -200.00,
      "percentage": 104.0,
      "status": "over_budget",
    },
  ];

  List<Map<String, dynamic>> get filteredTransactions {
    return transactions.where((transaction) {
      bool matchesSearch = searchQuery.isEmpty || 
          transaction["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          transaction["reference"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesAccount = selectedAccount == "all" || 
          transaction["account"] == selectedAccount;
      
      bool matchesCategory = selectedCategory == "all" || 
          transaction["category"] == selectedCategory;
      
      return matchesSearch && matchesAccount && matchesCategory;
    }).toList();
  }

  Widget _buildOverviewTab() {
    double totalBalance = accounts.map((acc) => acc["balance"] as double).fold(0.0, (a, b) => a + b);
    double totalIncome = transactions.where((t) => t["type"] == "credit").map((t) => t["amount"] as double).fold(0.0, (a, b) => a + b);
    double totalExpenses = transactions.where((t) => t["type"] == "debit").map((t) => (t["amount"] as double).abs()).fold(0.0, (a, b) => a + b);
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Financial Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          // Summary cards
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.account_balance_wallet, color: successColor, size: 32),
                      SizedBox(height: spXs),
                      Text(
                        "\$${totalBalance.currency}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Balance",
                        style: TextStyle(fontSize: 12, color: disabledBoldColor),
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.trending_up, color: infoColor, size: 32),
                      SizedBox(height: spXs),
                      Text(
                        "\$${totalIncome.currency}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Monthly Income",
                        style: TextStyle(fontSize: 12, color: disabledBoldColor),
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
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.trending_down, color: dangerColor, size: 32),
                      SizedBox(height: spXs),
                      Text(
                        "\$${totalExpenses.currency}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Monthly Expenses",
                        style: TextStyle(fontSize: 12, color: disabledBoldColor),
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.savings, color: warningColor, size: 32),
                      SizedBox(height: spXs),
                      Text(
                        "\$${(totalIncome - totalExpenses).currency}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Net Income",
                        style: TextStyle(fontSize: 12, color: disabledBoldColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          Text(
            "Account Balances",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Column(
            children: accounts.map((account) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: account["status"] == "active" ? successColor : warningColor,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: account["type"] == "checking" 
                            ? infoColor.withAlpha(51)
                            : account["type"] == "savings"
                                ? successColor.withAlpha(51)
                                : warningColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        account["type"] == "checking" 
                            ? Icons.account_balance
                            : account["type"] == "savings"
                                ? Icons.savings
                                : Icons.trending_up,
                        color: account["type"] == "checking" 
                            ? infoColor
                            : account["type"] == "savings"
                                ? successColor
                                : warningColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
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
                          Text(
                            "${account["bank"]} ${account["account_number"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "\$${(account["balance"] as double).currency}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: account["status"] == "active" ? successColor : warningColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${account["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Last: ${account["last_transaction"]}",
                          style: TextStyle(
                            fontSize: 10,
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
    );
  }

  Widget _buildTransactionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  ss("Add new transaction");
                },
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Account",
                  items: [
                    {"label": "All Accounts", "value": "all"},
                    ...accounts.map((acc) => {
                      "label": "${acc["name"]}",
                      "value": acc["id"]
                    }).toList(),
                  ],
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
                  label: "Category",
                  items: [
                    {"label": "All Categories", "value": "all"},
                    {"label": "Revenue", "value": "revenue"},
                    {"label": "Refunds", "value": "refunds"},
                    {"label": "Operations", "value": "operations"},
                    {"label": "Expenses", "value": "expenses"},
                    {"label": "Fees", "value": "fees"},
                  ],
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          Column(
            children: filteredTransactions.map((transaction) {
              bool isCredit = transaction["type"] == "credit";
              Color amountColor = isCredit ? successColor : dangerColor;
              String amountText = isCredit 
                  ? "+\$${(transaction["amount"] as double).currency}"
                  : "-\$${((transaction["amount"] as double).abs()).currency}";
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: amountColor,
                    ),
                  ),
                ),
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
                        Text(
                          amountText,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: amountColor,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spXs),
                    
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${transaction["category"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Ref: ${transaction["reference"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${transaction["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Text(
                          "Account: ${accounts.firstWhere((acc) => acc["id"] == transaction["account"])["name"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: successColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${transaction["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
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
    );
  }

  Widget _buildBudgetTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Budget Management",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Column(
            children: budgets.map((budget) {
              Color statusColor = budget["status"] == "on_track" 
                  ? successColor
                  : budget["status"] == "warning"
                      ? warningColor
                      : dangerColor;
              
              double progressWidth = (budget["percentage"] as double).clamp(0.0, 100.0) / 100.0;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
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
                        Expanded(
                          child: Text(
                            "${budget["category"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "${(budget["percentage"] as double).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: FractionallySizedBox(
                        widthFactor: progressWidth,
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                      ),
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Budgeted",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${(budget["budgeted"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
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
                                "Spent",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${(budget["spent"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
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
                                "Remaining",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${(budget["remaining"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: (budget["remaining"] as double) >= 0 ? successColor : dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          
          SizedBox(height: spMd),
          
          Container(
            width: double.infinity,
            child: QButton(
              label: "Create New Budget",
              size: bs.md,
              onPressed: () {
                ss("Creating new budget category");
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Financial Management",
      selectedIndex: selectedTabIndex,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Transactions", icon: Icon(Icons.list)),
        Tab(text: "Budget", icon: Icon(Icons.pie_chart)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildTransactionsTab(),
        _buildBudgetTab(),
      ],
    );
  }
}
