import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaExpenseManagementView extends StatefulWidget {
  const RmaExpenseManagementView({super.key});

  @override
  State<RmaExpenseManagementView> createState() => _RmaExpenseManagementViewState();
}

class _RmaExpenseManagementViewState extends State<RmaExpenseManagementView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedMonth = "Current Month";
  String selectedStatus = "All";

  List<Map<String, dynamic>> expenseCategories = [
    {"label": "All", "value": "All"},
    {"label": "Office Supplies", "value": "office_supplies"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Travel", "value": "travel"},
    {"label": "Equipment", "value": "equipment"},
    {"label": "Utilities", "value": "utilities"},
    {"label": "Professional Services", "value": "professional"},
  ];

  List<Map<String, dynamic>> monthOptions = [
    {"label": "Current Month", "value": "current"},
    {"label": "Last Month", "value": "last"},
    {"label": "Last 3 Months", "value": "3months"},
    {"label": "Last 6 Months", "value": "6months"},
    {"label": "This Year", "value": "year"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Pending", "value": "pending"},
    {"label": "Approved", "value": "approved"},
    {"label": "Rejected", "value": "rejected"},
    {"label": "Paid", "value": "paid"},
  ];

  List<Map<String, dynamic>> expenseStats = [
    {
      "title": "Total Expenses",
      "amount": 45280.50,
      "change": -12.5,
      "icon": Icons.payments,
      "color": dangerColor,
    },
    {
      "title": "Pending Approvals",
      "amount": 8450.00,
      "change": 5.2,
      "icon": Icons.pending_actions,
      "color": warningColor,
    },
    {
      "title": "Monthly Average",
      "amount": 15093.50,
      "change": 8.1,
      "icon": Icons.trending_up,
      "color": primaryColor,
    },
    {
      "title": "Budget Remaining",
      "amount": 12450.00,
      "change": -15.8,
      "icon": Icons.account_balance_wallet,
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> recentExpenses = [
    {
      "id": "EXP-2024-001",
      "description": "Office Printer Supplies",
      "category": "Office Supplies",
      "amount": 245.80,
      "date": "2024-01-15",
      "status": "approved",
      "employee": "John Smith",
      "receipt": true,
    },
    {
      "id": "EXP-2024-002", 
      "description": "Client Meeting Lunch",
      "category": "Travel",
      "amount": 125.50,
      "date": "2024-01-14",
      "status": "pending",
      "employee": "Sarah Johnson",
      "receipt": true,
    },
    {
      "id": "EXP-2024-003",
      "description": "Google Ads Campaign",
      "category": "Marketing",
      "amount": 1500.00,
      "date": "2024-01-13",
      "status": "paid",
      "employee": "Mike Wilson",
      "receipt": false,
    },
    {
      "id": "EXP-2024-004",
      "description": "Software License Renewal",
      "category": "Professional Services",
      "amount": 2400.00,
      "date": "2024-01-12",
      "status": "approved",
      "employee": "Lisa Chen",
      "receipt": true,
    },
    {
      "id": "EXP-2024-005",
      "description": "Office Equipment Repair",
      "category": "Equipment",
      "amount": 350.00,
      "date": "2024-01-11",
      "status": "rejected",
      "employee": "David Brown",
      "receipt": false,
    },
  ];

  List<Map<String, dynamic>> categoryBreakdown = [
    {"category": "Marketing", "amount": 12500.00, "percentage": 27.6, "budget": 15000.00},
    {"category": "Travel", "amount": 8750.50, "percentage": 19.3, "budget": 10000.00},
    {"category": "Office Supplies", "amount": 6230.80, "percentage": 13.8, "budget": 8000.00},
    {"category": "Equipment", "amount": 9840.20, "percentage": 21.7, "budget": 12000.00},
    {"category": "Utilities", "amount": 4560.00, "percentage": 10.1, "budget": 5000.00},
    {"category": "Professional Services", "amount": 3399.00, "percentage": 7.5, "budget": 4000.00},
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved': return successColor;
      case 'pending': return warningColor;
      case 'rejected': return dangerColor;
      case 'paid': return primaryColor;
      default: return disabledBoldColor;
    }
  }

  void _showExpenseDetails(Map<String, dynamic> expense) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Expense Details"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: _getStatusColor(expense["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.receipt,
                      color: _getStatusColor(expense["status"]),
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${expense["id"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor(expense["status"]),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(expense["status"]),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${expense["status"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Description",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "${expense["description"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
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
                          "Amount",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "\$${((expense["amount"] as num).toDouble()).currency}",
                          style: TextStyle(
                            fontSize: 18,
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
                          "Category",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${expense["category"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Employee",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${expense["employee"]}",
                          style: TextStyle(
                            fontSize: 14,
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
                          "Date",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${expense["date"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (expense["receipt"] == true) ...[
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: successColor.withAlpha(50)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: successColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Receipt Attached",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          if (expense["status"] == "pending") ...[
            QButton(
              label: "Approve",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                ss("Expense approved successfully");
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: expenseStats.map((stat) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: (stat["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            stat["icon"],
                            color: stat["color"],
                            size: 20,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: (stat["change"] as num) >= 0 
                                ? successColor.withAlpha(20)
                                : dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                (stat["change"] as num) >= 0 
                                    ? Icons.trending_up 
                                    : Icons.trending_down,
                                color: (stat["change"] as num) >= 0 
                                    ? successColor 
                                    : dangerColor,
                                size: 12,
                              ),
                              SizedBox(width: 2),
                              Text(
                                "${(stat["change"] as num).abs().toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: (stat["change"] as num) >= 0 
                                      ? successColor 
                                      : dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${stat["title"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${((stat["amount"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spLg),
          Text(
            "Category Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          ...categoryBreakdown.map((category) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${category["category"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "\$${((category["amount"] as num).toDouble()).currency} / \$${((category["budget"] as num).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 12,
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
                            "${(category["percentage"] as num).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${(((category["amount"] as num) / (category["budget"] as num)) * 100).toStringAsFixed(0)}% of budget",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
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
                      alignment: Alignment.centerLeft,
                      widthFactor: ((category["amount"] as num) / (category["budget"] as num)).clamp(0.0, 1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ((category["amount"] as num) / (category["budget"] as num)) > 0.8 
                              ? dangerColor 
                              : ((category["amount"] as num) / (category["budget"] as num)) > 0.6 
                                  ? warningColor 
                                  : successColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildExpensesTab() {
    var filteredExpenses = recentExpenses.where((expense) {
      bool matchesSearch = searchQuery.isEmpty || 
          expense["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          expense["employee"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          expense["id"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || expense["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "All" || expense["status"] == selectedStatus;
      
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search expenses...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () {
                  _showFiltersDialog();
                },
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...filteredExpenses.map((expense) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getStatusColor(expense["status"]),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${expense["id"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${expense["description"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor(expense["status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${expense["status"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: _getStatusColor(expense["status"]),
                              ),
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "\$${((expense["amount"] as num).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: disabledBoldColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${expense["employee"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(
                        Icons.calendar_today,
                        color: disabledBoldColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${expense["date"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      if (expense["receipt"] == true)
                        Icon(
                          Icons.receipt,
                          color: successColor,
                          size: 16,
                        ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: () => _showExpenseDetails(expense),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: disabledBoldColor,
                          size: 14,
                        ),
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

  void _showFiltersDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Expenses"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QDropdownField(
              label: "Category",
              items: expenseCategories,
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Status",
              items: statusOptions,
              value: selectedStatus,
              onChanged: (value, label) {
                selectedStatus = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Period",
              items: monthOptions,
              value: selectedMonth,
              onChanged: (value, label) {
                selectedMonth = value;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              selectedCategory = "All";
              selectedStatus = "All";
              selectedMonth = "Current Month";
              setState(() {});
              Navigator.pop(context);
            },
            child: Text("Clear"),
          ),
          QButton(
            label: "Apply",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Monthly Expense Trend",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  height: 200,
                  child: Center(
                    child: Text(
                      "Expense trend chart would be displayed here",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Top Expense Categories",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  height: 200,
                  child: Center(
                    child: Text(
                      "Category breakdown chart would be displayed here",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Expense Management",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Expenses", icon: Icon(Icons.receipt_long)),
        Tab(text: "Reports", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildExpensesTab(),
        _buildReportsTab(),
      ],
    );
  }
}
