import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaExpenseTrackingView extends StatefulWidget {
  const EmaExpenseTrackingView({super.key});

  @override
  State<EmaExpenseTrackingView> createState() => _EmaExpenseTrackingViewState();
}

class _EmaExpenseTrackingViewState extends State<EmaExpenseTrackingView> {
  String selectedPeriod = "This Month";
  String selectedCategory = "All Categories";
  String selectedStatus = "All";
  List<String> periods = ["Today", "This Week", "This Month", "This Quarter", "This Year"];
  List<String> categories = ["All Categories", "Office Supplies", "Travel", "Meals & Entertainment", "Software", "Marketing", "Utilities", "Equipment"];
  List<String> statuses = ["All", "Pending", "Approved", "Rejected", "Reimbursed"];
  
  List<Map<String, dynamic>> expenses = [
    {
      "id": 1,
      "title": "Office Supplies",
      "category": "Office Supplies",
      "amount": 156.78,
      "date": "2025-06-18",
      "status": "Approved",
      "receipt": "receipt_001.jpg",
      "description": "Printer paper, pens, and notebooks",
      "merchant": "Office Depot",
      "paymentMethod": "Corporate Card",
      "reimbursable": true,
      "tags": ["office", "supplies", "stationary"],
    },
    {
      "id": 2,
      "title": "Client Lunch Meeting",
      "category": "Meals & Entertainment",
      "amount": 89.45,
      "date": "2025-06-17",
      "status": "Pending",
      "receipt": "receipt_002.jpg",
      "description": "Business lunch with potential client",
      "merchant": "The Steakhouse",
      "paymentMethod": "Personal Card",
      "reimbursable": true,
      "tags": ["client", "lunch", "business"],
    },
    {
      "id": 3,
      "title": "Software Subscription",
      "category": "Software",
      "amount": 299.00,
      "date": "2025-06-16",
      "status": "Approved",
      "receipt": "receipt_003.pdf",
      "description": "Annual Adobe Creative Suite license",
      "merchant": "Adobe Inc.",
      "paymentMethod": "Corporate Card",
      "reimbursable": false,
      "tags": ["software", "license", "annual"],
    },
    {
      "id": 4,
      "title": "Conference Travel",
      "category": "Travel",
      "amount": 1250.75,
      "date": "2025-06-15",
      "status": "Reimbursed",
      "receipt": "receipt_004.pdf",
      "description": "Flight and hotel for tech conference",
      "merchant": "Various",
      "paymentMethod": "Personal Card",
      "reimbursable": true,
      "tags": ["travel", "conference", "flight", "hotel"],
    },
    {
      "id": 5,
      "title": "Marketing Materials",
      "category": "Marketing",
      "amount": 425.30,
      "date": "2025-06-14",
      "status": "Approved",
      "receipt": "receipt_005.jpg",
      "description": "Brochures and business cards printing",
      "merchant": "Print Shop Pro",
      "paymentMethod": "Corporate Card",
      "reimbursable": false,
      "tags": ["marketing", "printing", "brochures"],
    },
    {
      "id": 6,
      "title": "Office Internet",
      "category": "Utilities",
      "amount": 125.99,
      "date": "2025-06-13",
      "status": "Rejected",
      "receipt": "receipt_006.pdf",
      "description": "Monthly internet service",
      "merchant": "ISP Provider",
      "paymentMethod": "Corporate Card",
      "reimbursable": false,
      "tags": ["utilities", "internet", "monthly"],
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredExpenses = expenses.where((expense) {
      bool categoryMatch = selectedCategory == "All Categories" || expense["category"] == selectedCategory;
      bool statusMatch = selectedStatus == "All" || expense["status"] == selectedStatus;
      return categoryMatch && statusMatch;
    }).toList();

    double totalAmount = filteredExpenses.fold(0.0, (sum, expense) => sum + (expense["amount"] as double));
    double pendingAmount = filteredExpenses
        .where((e) => e["status"] == "Pending")
        .fold(0.0, (sum, expense) => sum + (expense["amount"] as double));
    double approvedAmount = filteredExpenses
        .where((e) => e["status"] == "Approved")
        .fold(0.0, (sum, expense) => sum + (expense["amount"] as double));
    double reimbursableAmount = filteredExpenses
        .where((e) => e["reimbursable"] == true)
        .fold(0.0, (sum, expense) => sum + (expense["amount"] as double));

    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () {
              // navigateTo('AddExpenseView')
            },
          ),
          IconButton(
            icon: Icon(Icons.upload_file),
            onPressed: () {
              // navigateTo('UploadReceiptView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Filters Row
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Period",
                    items: periods.map((period) => {
                      "label": period,
                      "value": period,
                    }).toList(),
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
                    items: categories.map((category) => {
                      "label": category,
                      "value": category,
                    }).toList(),
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QDropdownField(
              label: "Status",
              items: statuses.map((status) => {
                "label": status,
                "value": status,
              }).toList(),
              value: selectedStatus,
              onChanged: (value, label) {
                selectedStatus = value;
                setState(() {});
              },
            ),

            // Summary Cards
            ResponsiveGridView(
              minItemWidth: 200,
              children: [
                _buildSummaryCard(
                  title: "Total Expenses",
                  value: "\$${totalAmount.currency}",
                  icon: Icons.receipt_long,
                  color: primaryColor,
                  count: "${filteredExpenses.length}",
                ),
                _buildSummaryCard(
                  title: "Pending Review",
                  value: "\$${pendingAmount.currency}",
                  icon: Icons.pending_actions,
                  color: warningColor,
                  count: "${filteredExpenses.where((e) => e["status"] == "Pending").length}",
                ),
                _buildSummaryCard(
                  title: "Approved",
                  value: "\$${approvedAmount.currency}",
                  icon: Icons.check_circle,
                  color: successColor,
                  count: "${filteredExpenses.where((e) => e["status"] == "Approved").length}",
                ),
                _buildSummaryCard(
                  title: "Reimbursable",
                  value: "\$${reimbursableAmount.currency}",
                  icon: Icons.account_balance_wallet,
                  color: infoColor,
                  count: "${filteredExpenses.where((e) => e["reimbursable"] == true).length}",
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
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.pie_chart,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Expenses by Category",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  _buildCategoryChart(),
                ],
              ),
            ),

            // Recent Expenses
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.history,
                        color: primaryColor,
                        size: 24,
                      ),
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
                      GestureDetector(
                        onTap: () {
                          // navigateTo('AllExpensesView')
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...filteredExpenses.map((expense) {
                    Color statusColor = _getStatusColor(expense["status"]);
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: statusColor.withAlpha(20)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: _getCategoryColor(expense["category"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  _getCategoryIcon(expense["category"]),
                                  color: _getCategoryColor(expense["category"]),
                                  size: 24,
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
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${expense["description"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 14,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "${expense["merchant"]} • ${expense["date"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
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
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: statusColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${expense["status"]}",
                                      style: TextStyle(
                                        color: statusColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              // Tags
                              Expanded(
                                child: Wrap(
                                  spacing: spXs,
                                  children: (expense["tags"] as List).take(2).map((tag) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: infoColor.withAlpha(15),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "#${tag}",
                                        style: TextStyle(
                                          color: infoColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (expense["reimbursable"])
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: successColor.withAlpha(15),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "Reimbursable",
                                        style: TextStyle(
                                          color: successColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  SizedBox(width: spXs),
                                  GestureDetector(
                                    onTap: () {
                                      // navigateTo('ViewReceiptView')
                                    },
                                    child: Icon(
                                      Icons.receipt,
                                      size: 16,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  GestureDetector(
                                    onTap: () {
                                      // navigateTo('EditExpenseView')
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      size: 16,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Monthly Trend Chart
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: infoColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Monthly Expense Trend",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  _buildMonthlyTrendChart(),
                ],
              ),
            ),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ResponsiveGridView(
                    minItemWidth: 200,
                    children: [
                      QButton(
                        label: "Add Expense",
                        size: bs.sm,
                        onPressed: () {
                          // navigateTo('AddExpenseView')
                        },
                      ),
                      QButton(
                        label: "Upload Receipt",
                        size: bs.sm,
                        onPressed: () {
                          // navigateTo('UploadReceiptView')
                        },
                      ),
                      QButton(
                        label: "Export Report",
                        size: bs.sm,
                        onPressed: () {
                          // navigateTo('ExportExpenseReportView')
                        },
                      ),
                      QButton(
                        label: "Submit for Review",
                        size: bs.sm,
                        onPressed: () {
                          // navigateTo('SubmitExpensesView')
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required String count,
  }) {
    return Container(
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  count,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChart() {
    Map<String, double> categoryTotals = {};
    for (var expense in expenses) {
      String category = expense["category"];
      double amount = expense["amount"] as double;
      categoryTotals[category] = (categoryTotals[category] ?? 0) + amount;
    }

    double totalAmount = categoryTotals.values.fold(0.0, (sum, amount) => sum + amount);

    return Column(
      children: categoryTotals.entries.map((entry) {
        double percentage = totalAmount > 0 ? (entry.value / totalAmount) : 0;
        Color categoryColor = _getCategoryColor(entry.key);
        
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: categoryColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      entry.key,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Text(
                    "\$${entry.value.currency}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "${(percentage * 100).toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              Container(
                height: 6,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: percentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: categoryColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMonthlyTrendChart() {
    List<String> months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"];
    List<double> amounts = [2150, 1890, 2340, 2680, 2420, 2347];
    
    double maxAmount = amounts.reduce((a, b) => a > b ? a : b);

    return Container(
      height: 150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(months.length, (index) {
          double height = (amounts[index] / maxAmount) * 120;
          
          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: height,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    months[index],
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Approved":
        return successColor;
      case "Pending":
        return warningColor;
      case "Rejected":
        return dangerColor;
      case "Reimbursed":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Office Supplies":
        return primaryColor;
      case "Travel":
        return infoColor;
      case "Meals & Entertainment":
        return warningColor;
      case "Software":
        return successColor;
      case "Marketing":
        return dangerColor;
      case "Utilities":
        return disabledBoldColor;
      case "Equipment":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Office Supplies":
        return Icons.inventory_2;
      case "Travel":
        return Icons.flight;
      case "Meals & Entertainment":
        return Icons.restaurant;
      case "Software":
        return Icons.computer;
      case "Marketing":
        return Icons.campaign;
      case "Utilities":
        return Icons.electrical_services;
      case "Equipment":
        return Icons.build;
      default:
        return Icons.receipt;
    }
  }
}
