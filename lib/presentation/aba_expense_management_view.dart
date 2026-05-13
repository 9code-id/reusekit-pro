import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaExpenseManagementView extends StatefulWidget {
  const AbaExpenseManagementView({super.key});

  @override
  State<AbaExpenseManagementView> createState() => _AbaExpenseManagementViewState();
}

class _AbaExpenseManagementViewState extends State<AbaExpenseManagementView> {
  String searchQuery = "";
  String selectedCategory = "all";
  String selectedPeriod = "current_month";
  String selectedStatus = "all";
  int currentTab = 0;

  List<Map<String, dynamic>> expenses = [
    {
      "id": "EXP-2025-001",
      "title": "Assessment Materials",
      "description": "Standardized assessment tools and forms",
      "amount": 450.00,
      "date": "2025-01-15",
      "category": "materials",
      "status": "approved",
      "receipt_url": "receipt_001.pdf",
      "vendor": "Psychological Corp",
      "payment_method": "Credit Card",
      "reimbursable": true,
      "submitted_by": "Dr. Sarah Johnson",
      "approval_date": "2025-01-16"
    },
    {
      "id": "EXP-2025-002",
      "title": "Training Workshop",
      "description": "Advanced ABA techniques workshop",
      "amount": 1200.00,
      "date": "2025-01-12",
      "category": "training",
      "status": "pending",
      "receipt_url": "receipt_002.pdf",
      "vendor": "ABA Training Institute",
      "payment_method": "Bank Transfer",
      "reimbursable": true,
      "submitted_by": "Dr. Michael Chen",
      "approval_date": null
    },
    {
      "id": "EXP-2025-003",
      "title": "Office Supplies",
      "description": "Stationery, printing, and office materials",
      "amount": 185.50,
      "date": "2025-01-10",
      "category": "office",
      "status": "approved",
      "receipt_url": "receipt_003.pdf",
      "vendor": "Office Depot",
      "payment_method": "Cash",
      "reimbursable": false,
      "submitted_by": "Admin Staff",
      "approval_date": "2025-01-11"
    },
    {
      "id": "EXP-2025-004",
      "title": "Equipment Maintenance",
      "description": "Repair and maintenance of therapy equipment",
      "amount": 320.00,
      "date": "2025-01-18",
      "category": "equipment",
      "status": "rejected",
      "receipt_url": "receipt_004.pdf",
      "vendor": "Tech Repair Services",
      "payment_method": "Check",
      "reimbursable": true,
      "submitted_by": "Dr. Lisa Rodriguez",
      "approval_date": "2025-01-19"
    },
    {
      "id": "EXP-2025-005",
      "title": "Travel Expenses",
      "description": "Client home visit transportation",
      "amount": 85.00,
      "date": "2025-01-20",
      "category": "travel",
      "status": "submitted",
      "receipt_url": "receipt_005.pdf",
      "vendor": "Gas Station",
      "payment_method": "Personal Card",
      "reimbursable": true,
      "submitted_by": "Dr. Amanda Wilson",
      "approval_date": null
    },
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Materials & Supplies", "value": "materials"},
    {"label": "Training & Education", "value": "training"},
    {"label": "Office Expenses", "value": "office"},
    {"label": "Equipment", "value": "equipment"},
    {"label": "Travel", "value": "travel"},
    {"label": "Software & Technology", "value": "technology"},
    {"label": "Other", "value": "other"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Submitted", "value": "submitted"},
    {"label": "Pending", "value": "pending"},
    {"label": "Approved", "value": "approved"},
    {"label": "Rejected", "value": "rejected"},
    {"label": "Reimbursed", "value": "reimbursed"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Current Month", "value": "current_month"},
    {"label": "Last Month", "value": "last_month"},
    {"label": "Last 3 Months", "value": "last_3_months"},
    {"label": "This Year", "value": "this_year"},
    {"label": "All Time", "value": "all_time"},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'approved':
        return successColor;
      case 'pending':
        return warningColor;
      case 'submitted':
        return infoColor;
      case 'rejected':
        return dangerColor;
      case 'reimbursed':
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'approved':
        return 'Approved';
      case 'pending':
        return 'Pending Review';
      case 'submitted':
        return 'Submitted';
      case 'rejected':
        return 'Rejected';
      case 'reimbursed':
        return 'Reimbursed';
      default:
        return 'Unknown';
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'materials':
        return Icons.inventory;
      case 'training':
        return Icons.school;
      case 'office':
        return Icons.business;
      case 'equipment':
        return Icons.build;
      case 'travel':
        return Icons.directions_car;
      case 'technology':
        return Icons.computer;
      default:
        return Icons.receipt;
    }
  }

  List<Map<String, dynamic>> get filteredExpenses {
    return expenses.where((expense) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${expense["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${expense["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${expense["id"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${expense["vendor"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "all" || expense["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "all" || expense["status"] == selectedStatus;
      
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();
  }

  double get totalExpenses {
    return filteredExpenses.fold(0.0, (sum, expense) => sum + (expense["amount"] as double));
  }

  double get pendingAmount {
    return filteredExpenses
        .where((expense) => expense["status"] == "pending" || expense["status"] == "submitted")
        .fold(0.0, (sum, expense) => sum + (expense["amount"] as double));
  }

  double get reimbursableAmount {
    return filteredExpenses
        .where((expense) => expense["reimbursable"] == true && expense["status"] == "approved")
        .fold(0.0, (sum, expense) => sum + (expense["amount"] as double));
  }

  int get pendingCount {
    return filteredExpenses.where((expense) => expense["status"] == "pending" || expense["status"] == "submitted").length;
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Expense Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All Expenses", icon: Icon(Icons.receipt_long)),
        Tab(text: "Categories", icon: Icon(Icons.category)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildExpensesListTab(),
        _buildCategoriesTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildExpensesListTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildSummaryCards(),
          _buildExpensesList(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search expenses...",
                value: searchQuery,
                hint: "Title, description, vendor, or expense ID",
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
        Row(
          children: [
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
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Status",
                items: statusOptions,
                value: selectedStatus,
                onChanged: (value, label) {
                  selectedStatus = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryCards() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildSummaryCard(
          "Total Expenses",
          "\$${totalExpenses.currency}",
          Icons.attach_money,
          primaryColor,
        ),
        _buildSummaryCard(
          "Pending Amount",
          "\$${pendingAmount.currency}",
          Icons.pending,
          warningColor,
        ),
        _buildSummaryCard(
          "Reimbursable",
          "\$${reimbursableAmount.currency}",
          Icons.account_balance_wallet,
          successColor,
        ),
        _buildSummaryCard(
          "Pending Items",
          "$pendingCount",
          Icons.hourglass_empty,
          infoColor,
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.trending_up,
                  color: color,
                  size: 16,
                ),
              ),
            ],
          ),
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
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpensesList() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recent Expenses",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QButton(
              label: "Add Expense",
              icon: Icons.add,
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        ...filteredExpenses.map((expense) => _buildExpenseCard(expense)),
      ],
    );
  }

  Widget _buildExpenseCard(Map<String, dynamic> expense) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getStatusColor("${expense["status"]}"),
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(
                          _getCategoryIcon("${expense["category"]}"),
                          color: primaryColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${expense["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor("${expense["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  _getStatusLabel("${expense["status"]}"),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor("${expense["status"]}"),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Amount: \$${(expense["amount"] as double).currency}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Date: ${expense["date"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Vendor: ${expense["vendor"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                spacing: spXs,
                children: [
                  QButton(
                    icon: Icons.visibility,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                  QButton(
                    icon: Icons.edit,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Expense ID: ${expense["id"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Payment: ${expense["payment_method"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    if (expense["reimbursable"] == true)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Reimbursable",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ),
                    if (expense["receipt_url"] != null)
                      Container(
                        margin: EdgeInsets.only(left: spXs),
                        child: Icon(
                          Icons.attach_file,
                          color: infoColor,
                          size: 16,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.person,
                  color: infoColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Submitted by: ${expense["submitted_by"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ),
                if (expense["approval_date"] != null)
                  Text(
                    "Approved: ${expense["approval_date"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab() {
    Map<String, List<Map<String, dynamic>>> expensesByCategory = {};
    
    for (var expense in expenses) {
      String category = expense["category"];
      if (!expensesByCategory.containsKey(category)) {
        expensesByCategory[category] = [];
      }
      expensesByCategory[category]!.add(expense);
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildCategoriesHeader(),
          _buildCategoriesOverview(expensesByCategory),
          _buildCategoriesBreakdown(expensesByCategory),
        ],
      ),
    );
  }

  Widget _buildCategoriesHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Icon(
            Icons.category,
            color: primaryColor,
            size: 32,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Expense Categories",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Organize and track expenses by category",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesOverview(Map<String, List<Map<String, dynamic>>> expensesByCategory) {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: expensesByCategory.entries.map((entry) {
        String category = entry.key;
        List<Map<String, dynamic>> categoryExpenses = entry.value;
        double totalAmount = categoryExpenses.fold(0.0, (sum, expense) => sum + (expense["amount"] as double));
        
        return _buildCategoryOverviewCard(category, categoryExpenses.length, totalAmount);
      }).toList(),
    );
  }

  Widget _buildCategoryOverviewCard(String category, int count, double totalAmount) {
    String categoryLabel = categoryOptions.firstWhere(
      (option) => option["value"] == category,
      orElse: () => {"label": category.toUpperCase()},
    )["label"];

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                _getCategoryIcon(category),
                color: primaryColor,
                size: 24,
              ),
              Text(
                "$count items",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Text(
            "\$${totalAmount.currency}",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            categoryLabel,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesBreakdown(Map<String, List<Map<String, dynamic>>> expensesByCategory) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Category Breakdown",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...expensesByCategory.entries.map((entry) {
          String category = entry.key;
          List<Map<String, dynamic>> categoryExpenses = entry.value;
          return _buildCategoryBreakdownCard(category, categoryExpenses);
        }),
      ],
    );
  }

  Widget _buildCategoryBreakdownCard(String category, List<Map<String, dynamic>> categoryExpenses) {
    String categoryLabel = categoryOptions.firstWhere(
      (option) => option["value"] == category,
      orElse: () => {"label": category.toUpperCase()},
    )["label"];

    double totalAmount = categoryExpenses.fold(0.0, (sum, expense) => sum + (expense["amount"] as double));
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                _getCategoryIcon(category),
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  categoryLabel,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "\$${totalAmount.currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Column(
            spacing: spXs,
            children: categoryExpenses.take(3).map((expense) => Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "${expense["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Text(
                    "\$${(expense["amount"] as double).currency}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            )).toList(),
          ),
          if (categoryExpenses.length > 3)
            Container(
              width: double.infinity,
              child: QButton(
                label: "View All ${categoryExpenses.length} Items",
                size: bs.sm,
                onPressed: () {},
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAnalyticsHeader(),
          _buildExpenseMetrics(),
          _buildTrendAnalysis(),
          _buildExpenseReports(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Icon(
            Icons.analytics,
            color: successColor,
            size: 32,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Expense Analytics",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Analyze spending patterns and expense trends",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseMetrics() {
    double avgExpense = expenses.isNotEmpty ? totalExpenses / expenses.length : 0.0;
    int approvedCount = expenses.where((expense) => expense["status"] == "approved").length;
    double approvalRate = expenses.isNotEmpty ? (approvedCount / expenses.length) * 100 : 0.0;

    return Container(
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
          Text(
            "Expense Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildMetricCard(
                "Monthly Total",
                "\$${totalExpenses.currency}",
                Icons.attach_money,
                successColor,
                "+8.5%",
              ),
              _buildMetricCard(
                "Average Expense",
                "\$${avgExpense.currency}",
                Icons.receipt,
                infoColor,
                "+3.2%",
              ),
              _buildMetricCard(
                "Approval Rate",
                "${approvalRate.toStringAsFixed(1)}%",
                Icons.check_circle,
                primaryColor,
                "+5.1%",
              ),
              _buildMetricCard(
                "Pending Items",
                "$pendingCount",
                Icons.pending,
                warningColor,
                "-2 items",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color, String change) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: color.withAlpha(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Text(
                change,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: change.startsWith('+') ? successColor : dangerColor,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendAnalysis() {
    return Container(
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
          Text(
            "Spending Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: spSm,
                children: [
                  Icon(
                    Icons.trending_up,
                    color: primaryColor,
                    size: 48,
                  ),
                  Text(
                    "Expense Trend Chart",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Monthly expense trends would be displayed here",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseReports() {
    List<Map<String, dynamic>> reportOptions = [
      {
        "title": "Monthly Expense Summary",
        "description": "Detailed breakdown of monthly expenses",
        "icon": Icons.calendar_month,
        "color": primaryColor
      },
      {
        "title": "Category Analysis",
        "description": "Expense analysis by category",
        "icon": Icons.pie_chart,
        "color": infoColor
      },
      {
        "title": "Reimbursement Report",
        "description": "Track reimbursable expenses",
        "icon": Icons.account_balance_wallet,
        "color": successColor
      },
      {
        "title": "Vendor Analysis",
        "description": "Spending patterns by vendor",
        "icon": Icons.business,
        "color": warningColor
      },
    ];

    return Container(
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
          Text(
            "Expense Reports",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: reportOptions.map((report) => _buildReportOptionCard(report)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildReportOptionCard(Map<String, dynamic> report) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                report["icon"] as IconData,
                color: report["color"] as Color,
                size: 24,
              ),
              QButton(
                icon: Icons.file_download,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          Text(
            "${report["title"]}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${report["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
