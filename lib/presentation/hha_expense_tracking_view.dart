import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaExpenseTrackingView extends StatefulWidget {
  const HhaExpenseTrackingView({super.key});

  @override
  State<HhaExpenseTrackingView> createState() => _HhaExpenseTrackingViewState();
}

class _HhaExpenseTrackingViewState extends State<HhaExpenseTrackingView> {
  int currentTab = 0;
  
  // Form fields
  String expenseTitle = "";
  String expenseCategory = "";
  String expenseAmount = "";
  String expenseDescription = "";
  String selectedDate = DateTime.now().toString().split(' ')[0];
  String vendor = "";
  String paymentMethod = "";
  String receiptNumber = "";
  String searchQuery = "";
  String filterCategory = "";
  String filterPeriod = "";
  
  // Sample expense data
  List<Map<String, dynamic>> expenses = [
    {
      "id": "EXP-2024-001",
      "title": "Laundry Supplies",
      "category": "Housekeeping",
      "amount": 450.00,
      "date": "2024-01-15",
      "vendor": "CleanCorp Supplies",
      "paymentMethod": "Credit Card",
      "receiptNumber": "RCP-001234",
      "description": "Industrial detergent and cleaning supplies",
      "status": "Approved",
      "submittedBy": "Jane Smith",
      "approvedBy": "Manager",
      "department": "Housekeeping"
    },
    {
      "id": "EXP-2024-002",
      "title": "Restaurant Ingredients",
      "category": "Food & Beverage",
      "amount": 1250.75,
      "date": "2024-01-14",
      "vendor": "Fresh Foods Inc",
      "paymentMethod": "Bank Transfer",
      "receiptNumber": "FF-789456",
      "description": "Weekly fresh produce and meat delivery",
      "status": "Pending",
      "submittedBy": "Chef Mike",
      "approvedBy": "",
      "department": "Kitchen"
    },
    {
      "id": "EXP-2024-003",
      "title": "HVAC Maintenance",
      "category": "Maintenance",
      "amount": 850.00,
      "date": "2024-01-13",
      "vendor": "Climate Control Co",
      "paymentMethod": "Check",
      "receiptNumber": "CC-567890",
      "description": "Monthly HVAC system maintenance and filter replacement",
      "status": "Approved",
      "submittedBy": "Maintenance Team",
      "approvedBy": "Operations Manager",
      "department": "Maintenance"
    },
    {
      "id": "EXP-2024-004",
      "title": "Marketing Materials",
      "category": "Marketing",
      "amount": 320.50,
      "date": "2024-01-12",
      "vendor": "PrintPro",
      "paymentMethod": "Petty Cash",
      "receiptNumber": "PP-112233",
      "description": "Brochures and promotional flyers",
      "status": "Rejected",
      "submittedBy": "Marketing Team",
      "approvedBy": "",
      "department": "Marketing",
      "rejectionReason": "Budget exceeded for this category"
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"name": "Housekeeping", "budget": 5000.00, "spent": 2450.00, "color": Colors.blue},
    {"name": "Food & Beverage", "budget": 8000.00, "spent": 5250.75, "color": Colors.green},
    {"name": "Maintenance", "budget": 3000.00, "spent": 1850.00, "color": Colors.orange},
    {"name": "Marketing", "budget": 2000.00, "spent": 1320.50, "color": Colors.purple},
    {"name": "Utilities", "budget": 4000.00, "spent": 3200.00, "color": Colors.red},
    {"name": "Administration", "budget": 1500.00, "spent": 890.00, "color": Colors.teal},
  ];

  List<Map<String, dynamic>> budgetAlerts = [
    {
      "category": "Utilities",
      "budgetUsed": 80.0,
      "status": "Warning",
      "remaining": 800.00
    },
    {
      "category": "Food & Beverage", 
      "budgetUsed": 65.6,
      "status": "Good",
      "remaining": 2749.25
    },
    {
      "category": "Marketing",
      "budgetUsed": 66.0,
      "status": "Warning", 
      "remaining": 679.50
    },
  ];

  List<Map<String, dynamic>> get filteredExpenses {
    var filtered = expenses.where((expense) {
      final matchesSearch = searchQuery.isEmpty ||
          (expense["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (expense["vendor"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (expense["id"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesCategory = filterCategory.isEmpty || expense["category"] == filterCategory;
      
      return matchesSearch && matchesCategory;
    }).toList();
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return successColor;
      case 'pending':
        return warningColor;
      case 'rejected':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getAlertColor(String status) {
    switch (status.toLowerCase()) {
      case 'good':
        return successColor;
      case 'warning':
        return warningColor;
      case 'danger':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  double get totalExpensesThisMonth {
    return expenses.fold(0.0, (sum, expense) => sum + (expense["amount"] as double));
  }

  double get totalBudgetAllocated {
    return categories.fold(0.0, (sum, category) => sum + (category["budget"] as double));
  }

  double get totalBudgetRemaining {
    return categories.fold(0.0, (sum, category) => 
        sum + ((category["budget"] as double) - (category["spent"] as double)));
  }

  Widget _buildAddExpenseTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                          Icon(Icons.trending_up, color: primaryColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "This Month",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${totalExpensesThisMonth.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH5,
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
                          Icon(Icons.account_balance_wallet, color: successColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "Remaining",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${totalBudgetRemaining.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH6,
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
          SizedBox(height: spLg),
          
          // Expense Form
          Text(
            "Add New Expense",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          QTextField(
            label: "Expense Title",
            value: expenseTitle,
            hint: "Enter expense title",
            onChanged: (value) {
              expenseTitle = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          QDropdownField(
            label: "Category",
            value: expenseCategory,
            items: categories.map((category) => {
              "label": "${category["name"]} (\$${((category["budget"] as double) - (category["spent"] as double)).toStringAsFixed(2)} remaining)",
              "value": category["name"],
            }).toList(),
            onChanged: (value, label) {
              expenseCategory = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Amount (\$)",
                  value: expenseAmount,
                  hint: "Enter expense amount",
                  onChanged: (value) {
                    expenseAmount = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDatePicker(
                  label: "Date",
                  value: DateTime.parse(selectedDate),
                  onChanged: (value) {
                    selectedDate = value.toString().split(' ')[0];
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          QTextField(
            label: "Vendor",
            value: vendor,
            hint: "Enter vendor name",
            onChanged: (value) {
              vendor = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Payment Method",
                  value: paymentMethod,
                  items: [
                    {"label": "Credit Card", "value": "Credit Card"},
                    {"label": "Bank Transfer", "value": "Bank Transfer"},
                    {"label": "Check", "value": "Check"},
                    {"label": "Petty Cash", "value": "Petty Cash"},
                    {"label": "Online Payment", "value": "Online Payment"},
                  ],
                  onChanged: (value, label) {
                    paymentMethod = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Receipt Number",
                  value: receiptNumber,
                  hint: "Enter receipt number",
                  onChanged: (value) {
                    receiptNumber = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          QMemoField(
            label: "Description",
            value: expenseDescription,
            hint: "Enter expense description",
            onChanged: (value) {
              expenseDescription = value;
              setState(() {});
            },
          ),
          SizedBox(height: spLg),
          
          // Budget Check Warning
          if (expenseAmount.isNotEmpty && expenseCategory.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: _getBudgetWarningColor().withAlpha(25),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: _getBudgetWarningColor()),
              ),
              child: Row(
                children: [
                  Icon(
                    _getBudgetWarningIcon(),
                    color: _getBudgetWarningColor(),
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getBudgetWarningTitle(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: _getBudgetWarningColor(),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          _getBudgetWarningMessage(),
                          style: TextStyle(
                            fontSize: 12,
                            color: _getBudgetWarningColor(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),
          ],
          
          Container(
            width: double.infinity,
            child: QButton(
              label: "Submit Expense",
              onPressed: () {
                ss("Expense submitted for approval");
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getBudgetWarningColor() {
    if (expenseAmount.isEmpty || expenseCategory.isEmpty) return infoColor;
    
    var category = categories.firstWhere(
      (cat) => cat["name"] == expenseCategory,
      orElse: () => {"budget": 0.0, "spent": 0.0},
    );
    
    double budget = category["budget"] as double;
    double spent = category["spent"] as double;
    double newExpense = double.tryParse(expenseAmount) ?? 0.0;
    double remaining = budget - spent;
    
    if (newExpense > remaining) return dangerColor;
    if (newExpense > remaining * 0.8) return warningColor;
    return successColor;
  }

  IconData _getBudgetWarningIcon() {
    Color color = _getBudgetWarningColor();
    if (color == dangerColor) return Icons.error;
    if (color == warningColor) return Icons.warning;
    return Icons.check_circle;
  }

  String _getBudgetWarningTitle() {
    Color color = _getBudgetWarningColor();
    if (color == dangerColor) return "Budget Exceeded";
    if (color == warningColor) return "Budget Warning";
    return "Budget OK";
  }

  String _getBudgetWarningMessage() {
    if (expenseAmount.isEmpty || expenseCategory.isEmpty) return "";
    
    var category = categories.firstWhere(
      (cat) => cat["name"] == expenseCategory,
      orElse: () => {"budget": 0.0, "spent": 0.0},
    );
    
    double budget = category["budget"] as double;
    double spent = category["spent"] as double;
    double newExpense = double.tryParse(expenseAmount) ?? 0.0;
    double remaining = budget - spent;
    
    if (newExpense > remaining) {
      return "This expense exceeds the remaining budget by \$${(newExpense - remaining).toStringAsFixed(2)}";
    }
    if (newExpense > remaining * 0.8) {
      return "This expense will use ${((newExpense / remaining) * 100).toStringAsFixed(1)}% of remaining budget";
    }
    return "Budget sufficient. \$${(remaining - newExpense).toStringAsFixed(2)} will remain after this expense";
  }

  Widget _buildExpenseListTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search and Filter
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search Expenses",
                  value: searchQuery,
                  hint: "Search by title, vendor, or expense ID",
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
          
          QDropdownField(
            label: "Filter by Category",
            value: filterCategory,
            items: [
              {"label": "All Categories", "value": ""},
              ...categories.map((category) => {
                "label": category["name"] as String,
                "value": category["name"],
              }).toList(),
            ],
            onChanged: (value, label) {
              filterCategory = value;
              setState(() {});
            },
          ),
          SizedBox(height: spLg),
          
          // Expenses List
          Text(
            "Expenses (${filteredExpenses.length})",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          ...filteredExpenses.map((expense) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: _getStatusColor(expense["status"] as String),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${expense["id"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(expense["status"] as String).withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${expense["status"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _getStatusColor(expense["status"] as String),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
                Text(
                  "${expense["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spXs),
                
                Row(
                  children: [
                    Icon(Icons.category, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${expense["category"]}",
                      style: TextStyle(fontSize: 14, color: disabledBoldColor),
                    ),
                    Spacer(),
                    Text(
                      "\$${(expense["amount"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                
                Row(
                  children: [
                    Icon(Icons.business, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${expense["vendor"]}",
                      style: TextStyle(fontSize: 14, color: disabledBoldColor),
                    ),
                    SizedBox(width: spMd),
                    Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${expense["date"]}",
                      style: TextStyle(fontSize: 14, color: disabledBoldColor),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                
                Row(
                  children: [
                    Icon(Icons.payment, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${expense["paymentMethod"]}",
                      style: TextStyle(fontSize: 14, color: disabledBoldColor),
                    ),
                    SizedBox(width: spMd),
                    Icon(Icons.receipt, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${expense["receiptNumber"]}",
                      style: TextStyle(fontSize: 14, color: disabledBoldColor),
                    ),
                  ],
                ),
                
                if ((expense["description"] as String).isNotEmpty) ...[
                  SizedBox(height: spXs),
                  Text(
                    "${expense["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
                
                if (expense["status"] == "Rejected" && expense.containsKey("rejectionReason")) ...[
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error, size: 16, color: dangerColor),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "Rejection: ${expense["rejectionReason"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: dangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    QButton(
                      label: "View Details",
                      size: bs.sm,
                      onPressed: () {
                        si("Viewing expense ${expense["id"]}");
                      },
                    ),
                    SizedBox(width: spSm),
                    if (expense["status"] == "Pending") ...[
                      QButton(
                        label: "Approve",
                        size: bs.sm,
                        onPressed: () {
                          expense["status"] = "Approved";
                          expense["approvedBy"] = "Manager";
                          setState(() {});
                          ss("Expense approved");
                        },
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Reject",
                        size: bs.sm,
                        onPressed: () {
                          expense["status"] = "Rejected";
                          setState(() {});
                          sw("Expense rejected");
                        },
                      ),
                    ],
                    if (expense["status"] == "Rejected") ...[
                      QButton(
                        label: "Resubmit",
                        size: bs.sm,
                        onPressed: () {
                          expense["status"] = "Pending";
                          setState(() {});
                          si("Expense resubmitted");
                        },
                      ),
                    ],
                  ],
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildBudgetOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Budget Alerts
          Text(
            "Budget Alerts",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          ...budgetAlerts.map((alert) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: _getAlertColor(alert["status"] as String).withAlpha(25),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: _getAlertColor(alert["status"] as String)),
            ),
            child: Row(
              children: [
                Icon(
                  alert["status"] == "Good" ? Icons.check_circle : Icons.warning,
                  color: _getAlertColor(alert["status"] as String),
                  size: 24,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${alert["category"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: _getAlertColor(alert["status"] as String),
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${(alert["budgetUsed"] as double).toStringAsFixed(1)}% used • \$${(alert["remaining"] as double).toStringAsFixed(2)} remaining",
                        style: TextStyle(
                          fontSize: 12,
                          color: _getAlertColor(alert["status"] as String),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )).toList(),
          SizedBox(height: spLg),
          
          // Category Budget Overview
          Text(
            "Category Budget Overview",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          ...categories.map((category) {
            double budget = category["budget"] as double;
            double spent = category["spent"] as double;
            double percentage = (spent / budget) * 100;
            
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${category["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${percentage.toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: percentage > 80 ? dangerColor : 
                                 percentage > 60 ? warningColor : successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  // Progress Bar
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: percentage / 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: category["color"] as Color,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Spent: \$${spent.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Budget: \$${budget.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Remaining: \$${(budget - spent).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: (budget - spent) > 0 ? successColor : dangerColor,
                        ),
                      ),
                      QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {
                          si("Viewing ${category["name"]} budget details");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Expense Tracking",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Add Expense", icon: Icon(Icons.add)),
        Tab(text: "Expense List", icon: Icon(Icons.list_alt)),
        Tab(text: "Budget Overview", icon: Icon(Icons.pie_chart)),
      ],
      tabChildren: [
        _buildAddExpenseTab(),
        _buildExpenseListTab(),
        _buildBudgetOverviewTab(),
      ],
    );
  }
}
