import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaExpenseTrackingView extends StatefulWidget {
  const PmaExpenseTrackingView({super.key});

  @override
  State<PmaExpenseTrackingView> createState() => _PmaExpenseTrackingViewState();
}

class _PmaExpenseTrackingViewState extends State<PmaExpenseTrackingView> {
  String selectedPeriod = "thisMonth";
  String selectedCategory = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "thisWeek"},
    {"label": "This Month", "value": "thisMonth"},
    {"label": "Last Month", "value": "lastMonth"},
    {"label": "This Quarter", "value": "thisQuarter"},
    {"label": "This Year", "value": "thisYear"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Software & Tools", "value": "software"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Travel", "value": "travel"},
    {"label": "Equipment", "value": "equipment"},
    {"label": "Office Supplies", "value": "office"},
    {"label": "Consulting", "value": "consulting"},
  ];

  List<Map<String, dynamic>> expenses = [
    {
      "id": "1",
      "title": "Adobe Creative Suite",
      "category": "software",
      "amount": 52.99,
      "date": "2024-06-15",
      "description": "Monthly subscription for design tools",
      "status": "approved",
      "receipt": true,
    },
    {
      "id": "2",
      "title": "Google Ads Campaign",
      "category": "marketing",
      "amount": 450.00,
      "date": "2024-06-14",
      "description": "Q2 marketing campaign budget",
      "status": "pending",
      "receipt": true,
    },
    {
      "id": "3",
      "title": "Business Trip - SF",
      "category": "travel",
      "amount": 1250.00,
      "date": "2024-06-12",
      "description": "Client meeting and conference",
      "status": "approved",
      "receipt": false,
    },
    {
      "id": "4",
      "title": "MacBook Pro Accessories",
      "category": "equipment",
      "amount": 299.99,
      "date": "2024-06-10",
      "description": "Keyboard, mouse, and dock",
      "status": "rejected",
      "receipt": true,
    },
    {
      "id": "5",
      "title": "Office Furniture",
      "category": "office",
      "amount": 850.00,
      "date": "2024-06-08",
      "description": "Ergonomic chair and standing desk",
      "status": "approved",
      "receipt": true,
    },
  ];

  double get totalExpenses => filteredExpenses.fold(0.0, (sum, expense) => sum + (expense["amount"] as double));
  double get approvedExpenses => filteredExpenses.where((e) => e["status"] == "approved").fold(0.0, (sum, expense) => sum + (expense["amount"] as double));
  double get pendingExpenses => filteredExpenses.where((e) => e["status"] == "pending").fold(0.0, (sum, expense) => sum + (expense["amount"] as double));

  List<Map<String, dynamic>> get filteredExpenses {
    List<Map<String, dynamic>> filtered = expenses;
    
    if (selectedCategory != "all") {
      filtered = filtered.where((expense) => expense["category"] == selectedCategory).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((expense) => 
        (expense["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (expense["description"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addExpense,
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: _exportExpenses,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildExpenseSummary(),
            _buildFiltersSection(),
            _buildExpensesList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addExpense,
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildExpenseSummary() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.account_balance_wallet,
                color: Colors.white,
                size: 28,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Expenses",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                    Text(
                      "\$${totalExpenses.currency}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(color: Colors.white.withAlpha(100)),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  "Approved",
                  "\$${approvedExpenses.currency}",
                  successColor,
                  Icons.check_circle,
                ),
              ),
              Container(
                height: 40,
                width: 1,
                color: Colors.white.withAlpha(100),
              ),
              Expanded(
                child: _buildSummaryItem(
                  "Pending",
                  "\$${pendingExpenses.currency}",
                  warningColor,
                  Icons.hourglass_empty,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String title, String amount, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withAlpha(200),
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
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
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryOptions,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QTextField(
            label: "Search Expenses",
            value: searchQuery,
            hint: "Search by title or description...",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExpensesList() {
    if (filteredExpenses.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spLg),
        child: Column(
          children: [
            Icon(
              Icons.receipt_long,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spSm),
            Text(
              "No expenses found",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "Try adjusting your filters or add a new expense",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Expenses (${filteredExpenses.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        ...filteredExpenses.map((expense) => _buildExpenseCard(expense)).toList(),
      ],
    );
  }

  Widget _buildExpenseCard(Map<String, dynamic> expense) {
    Color statusColor = _getStatusColor(expense["status"]);
    
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
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: _getCategoryColor(expense["category"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  _getCategoryIcon(expense["category"]),
                  size: 20,
                  color: _getCategoryColor(expense["category"]),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${expense["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${expense["description"]}",
                      style: TextStyle(
                        fontSize: 14,
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
                    "\$${(expense["amount"] as double).currency}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${expense["date"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: statusColor),
                ),
                child: Text(
                  "${expense["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              if (expense["receipt"] == true) ...[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.attach_file,
                        size: 12,
                        color: successColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Receipt",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => _editExpense(expense),
                    child: Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.edit,
                        size: 16,
                        color: infoColor,
                      ),
                    ),
                  ),
                  SizedBox(width: spXs),
                  GestureDetector(
                    onTap: () => _deleteExpense(expense["id"]),
                    child: Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.delete,
                        size: 16,
                        color: dangerColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "approved":
        return successColor;
      case "pending":
        return warningColor;
      case "rejected":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "software":
        return infoColor;
      case "marketing":
        return successColor;
      case "travel":
        return warningColor;
      case "equipment":
        return primaryColor;
      case "office":
        return secondaryColor;
      case "consulting":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "software":
        return Icons.computer;
      case "marketing":
        return Icons.campaign;
      case "travel":
        return Icons.flight;
      case "equipment":
        return Icons.devices;
      case "office":
        return Icons.business;
      case "consulting":
        return Icons.people;
      default:
        return Icons.receipt;
    }
  }

  void _addExpense() {
    si("Add new expense functionality");
  }

  void _editExpense(Map<String, dynamic> expense) {
    si("Edit expense: ${expense["title"]}");
  }

  void _deleteExpense(String expenseId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this expense?");
    if (isConfirmed) {
      setState(() {
        expenses.removeWhere((expense) => expense["id"] == expenseId);
      });
      ss("Expense deleted successfully");
    }
  }

  void _exportExpenses() {
    si("Export expenses to CSV/PDF");
  }
}
