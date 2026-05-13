import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaExpenseTrackingView extends StatefulWidget {
  const ReaExpenseTrackingView({super.key});

  @override
  State<ReaExpenseTrackingView> createState() => _ReaExpenseTrackingViewState();
}

class _ReaExpenseTrackingViewState extends State<ReaExpenseTrackingView> {
  String searchQuery = "";
  String filterCategory = "all";
  String filterProperty = "all";
  String selectedPeriod = "thisMonth";
  
  List<Map<String, dynamic>> expenses = [
    {
      "id": "EXP001",
      "title": "HVAC Maintenance",
      "description": "Quarterly AC system maintenance and cleaning",
      "category": "Maintenance",
      "amount": 150.0,
      "date": "2024-01-15",
      "propertyName": "Downtown Apartment 2A",
      "propertyImage": "https://picsum.photos/300/200?random=1&keyword=apartment",
      "vendor": "Mike's HVAC Services",
      "status": "paid",
      "receiptUrl": "https://example.com/receipt-exp001.pdf",
      "isRecurring": true,
      "nextDue": "2024-04-15",
      "paymentMethod": "Bank Transfer"
    },
    {
      "id": "EXP002",
      "title": "Plumbing Repair",
      "description": "Fixed leaking kitchen faucet in unit B",
      "category": "Repair",
      "amount": 75.0,
      "date": "2024-01-12",
      "propertyName": "Sunset Villa Unit B",
      "propertyImage": "https://picsum.photos/300/200?random=2&keyword=villa",
      "vendor": "City Plumbing Co.",
      "status": "paid",
      "receiptUrl": "https://example.com/receipt-exp002.pdf",
      "isRecurring": false,
      "nextDue": null,
      "paymentMethod": "Credit Card"
    },
    {
      "id": "EXP003",
      "title": "Property Insurance",
      "description": "Monthly property insurance premium",
      "category": "Insurance",
      "amount": 280.0,
      "date": "2024-01-01",
      "propertyName": "All Properties",
      "propertyImage": "https://picsum.photos/300/200?random=6&keyword=insurance",
      "vendor": "SecureHome Insurance",
      "status": "paid",
      "receiptUrl": "https://example.com/receipt-exp003.pdf",
      "isRecurring": true,
      "nextDue": "2024-02-01",
      "paymentMethod": "Auto-Pay"
    },
    {
      "id": "EXP004",
      "title": "Landscaping Service",
      "description": "Monthly garden maintenance and lawn care",
      "category": "Landscaping",
      "amount": 120.0,
      "date": "2024-01-08",
      "propertyName": "Garden View Condo",
      "propertyImage": "https://picsum.photos/300/200?random=4&keyword=condo",
      "vendor": "Green Thumb Landscaping",
      "status": "paid",
      "receiptUrl": "https://example.com/receipt-exp004.pdf",
      "isRecurring": true,
      "nextDue": "2024-02-08",
      "paymentMethod": "Check"
    },
    {
      "id": "EXP005",
      "title": "Security System Upgrade",
      "description": "Install new smart security cameras",
      "category": "Security",
      "amount": 450.0,
      "date": "2024-01-20",
      "propertyName": "Luxury Penthouse",
      "propertyImage": "https://picsum.photos/300/200?random=5&keyword=penthouse",
      "vendor": "TechGuard Security",
      "status": "pending",
      "receiptUrl": null,
      "isRecurring": false,
      "nextDue": null,
      "paymentMethod": "Bank Transfer"
    },
    {
      "id": "EXP006",
      "title": "Property Tax",
      "description": "Quarterly property tax payment",
      "category": "Tax",
      "amount": 1200.0,
      "date": "2024-01-03",
      "propertyName": "All Properties",
      "propertyImage": "https://picsum.photos/300/200?random=7&keyword=tax",
      "vendor": "City Tax Department",
      "status": "paid",
      "receiptUrl": "https://example.com/receipt-exp006.pdf",
      "isRecurring": true,
      "nextDue": "2024-04-03",
      "paymentMethod": "Online Payment"
    },
    {
      "id": "EXP007",
      "title": "Cleaning Service",
      "description": "Deep cleaning after tenant moved out",
      "category": "Cleaning",
      "amount": 200.0,
      "date": "2024-01-18",
      "propertyName": "City Center Studio",
      "propertyImage": "https://picsum.photos/300/200?random=3&keyword=studio",
      "vendor": "SparkClean Services",
      "status": "paid",
      "receiptUrl": "https://example.com/receipt-exp007.pdf",
      "isRecurring": false,
      "nextDue": null,
      "paymentMethod": "Cash"
    }
  ];

  List<Map<String, dynamic>> get filteredExpenses {
    List<Map<String, dynamic>> filtered = expenses;
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((expense) {
        return (expense["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (expense["vendor"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (expense["category"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    if (filterCategory != "all") {
      filtered = filtered.where((expense) => expense["category"].toString().toLowerCase() == filterCategory.toLowerCase()).toList();
    }
    
    if (filterProperty != "all") {
      filtered = filtered.where((expense) => expense["propertyName"] == filterProperty).toList();
    }
    
    return filtered;
  }

  double get totalExpensesThisMonth {
    return expenses.fold(0.0, (sum, expense) => sum + (expense["amount"] as double));
  }

  double get paidExpensesThisMonth {
    return expenses
        .where((expense) => expense["status"] == "paid")
        .fold(0.0, (sum, expense) => sum + (expense["amount"] as double));
  }

  double get pendingExpensesThisMonth {
    return expenses
        .where((expense) => expense["status"] == "pending")
        .fold(0.0, (sum, expense) => sum + (expense["amount"] as double));
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "paid":
        return successColor;
      case "pending":
        return warningColor;
      case "overdue":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case "maintenance":
        return primaryColor;
      case "repair":
        return warningColor;
      case "insurance":
        return infoColor;
      case "tax":
        return dangerColor;
      case "landscaping":
        return successColor;
      case "security":
        return primaryColor;
      case "cleaning":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterBottomSheet();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search expenses...",
                    value: searchQuery,
                    hint: "Search by title, vendor, or category",
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

            // Expense Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildExpenseCard(
                  "Total Expenses",
                  "\$${totalExpensesThisMonth.toStringAsFixed(0)}",
                  Icons.money_off,
                  primaryColor,
                  "This month",
                ),
                _buildExpenseCard(
                  "Paid",
                  "\$${paidExpensesThisMonth.toStringAsFixed(0)}",
                  Icons.check_circle,
                  successColor,
                  "${expenses.where((e) => e["status"] == "paid").length} transactions",
                ),
                _buildExpenseCard(
                  "Pending",
                  "\$${pendingExpensesThisMonth.toStringAsFixed(0)}",
                  Icons.pending,
                  warningColor,
                  "${expenses.where((e) => e["status"] == "pending").length} pending",
                ),
                _buildExpenseCard(
                  "Recurring",
                  "${expenses.where((e) => e["isRecurring"] == true).length}",
                  Icons.repeat,
                  infoColor,
                  "Active subscriptions",
                ),
              ],
            ),

            // Category Breakdown Chart
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
                      Icon(Icons.pie_chart, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Expense Categories",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "View Chart",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  _buildCategoryBreakdown(),
                ],
              ),
            ),

            // Quick Filters
            Row(
              children: [
                Expanded(
                  child: QCategoryPicker(
                    label: "Category",
                    items: const [
                      {"label": "All", "value": "all"},
                      {"label": "Maintenance", "value": "maintenance"},
                      {"label": "Repair", "value": "repair"},
                      {"label": "Insurance", "value": "insurance"},
                      {"label": "Tax", "value": "tax"},
                      {"label": "Landscaping", "value": "landscaping"},
                      {"label": "Security", "value": "security"},
                      {"label": "Cleaning", "value": "cleaning"},
                    ],
                    value: filterCategory,
                    onChanged: (index, label, value, item) {
                      filterCategory = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QCategoryPicker(
                    label: "Period",
                    items: const [
                      {"label": "This Month", "value": "thisMonth"},
                      {"label": "Last Month", "value": "lastMonth"},
                      {"label": "This Quarter", "value": "thisQuarter"},
                      {"label": "This Year", "value": "thisYear"},
                    ],
                    value: selectedPeriod,
                    onChanged: (index, label, value, item) {
                      selectedPeriod = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Expenses List
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
                        Icon(Icons.receipt_long, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Recent Expenses",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Export",
                          icon: Icons.download,
                          size: bs.sm,
                          onPressed: () {
                            _exportExpenses();
                          },
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredExpenses.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final expense = filteredExpenses[index];
                      return _buildExpenseItem(expense);
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
          _showAddExpenseDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildExpenseCard(String title, String value, IconData icon, Color color, String subtitle) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(width: 4, color: color),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              Spacer(),
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 16),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBreakdown() {
    Map<String, double> categoryTotals = {};
    for (var expense in expenses) {
      final category = expense["category"] as String;
      categoryTotals[category] = (categoryTotals[category] ?? 0) + (expense["amount"] as double);
    }

    return Column(
      children: categoryTotals.entries.map((entry) {
        final percentage = (entry.value / totalExpensesThisMonth) * 100;
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: _getCategoryColor(entry.key),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  entry.key,
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                "\$${entry.value.toStringAsFixed(0)}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${percentage.toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildExpenseItem(Map<String, dynamic> expense) {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        children: [
          // Property/Category Image
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
              image: DecorationImage(
                image: NetworkImage("${expense["propertyImage"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spMd),
          
          // Expense Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(expense["category"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${expense["category"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: _getCategoryColor(expense["category"]),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    if (expense["isRecurring"] as bool)
                      Icon(
                        Icons.repeat,
                        size: 16,
                        color: infoColor,
                      ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${expense["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${expense["description"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.business, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${expense["vendor"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${expense["propertyName"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Amount and Status
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${(expense["amount"] as double).toStringAsFixed(0)}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),
              SizedBox(height: spXs),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(expense["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${expense["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    color: _getStatusColor(expense["status"]),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${DateTime.parse(expense["date"]).dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              if (expense["receiptUrl"] != null) ...[
                SizedBox(height: spXs),
                GestureDetector(
                  onTap: () {
                    ss("Receipt downloaded");
                  },
                  child: Icon(
                    Icons.receipt,
                    size: 16,
                    color: primaryColor,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Filter Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            QButton(
              label: "Apply Filters",
              onPressed: () {
                back();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAddExpenseDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Expense"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Add a new expense entry"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              back();
              ss("Expense added successfully");
            },
            child: Text("Add"),
          ),
        ],
      ),
    );
  }

  void _exportExpenses() {
    ss("Expense report exported successfully");
  }
}
