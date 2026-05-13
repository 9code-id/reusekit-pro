import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmExpenseTrackingView extends StatefulWidget {
  const TpmExpenseTrackingView({super.key});

  @override
  State<TpmExpenseTrackingView> createState() => _TpmExpenseTrackingViewState();
}

class _TpmExpenseTrackingViewState extends State<TpmExpenseTrackingView> {
  String selectedPeriod = "This Month";
  String selectedCategory = "All Categories";
  String selectedStatus = "All Status";
  String selectedEmployee = "All Employees";
  String searchQuery = "";
  int currentTab = 0;

  List<Map<String, dynamic>> periods = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "All Categories"},
    {"label": "Travel", "value": "Travel"},
    {"label": "Meals", "value": "Meals"},
    {"label": "Equipment", "value": "Equipment"},
    {"label": "Software", "value": "Software"},
    {"label": "Training", "value": "Training"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Office Supplies", "value": "Office Supplies"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All Status"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Approved", "value": "Approved"},
    {"label": "Rejected", "value": "Rejected"},
    {"label": "Reimbursed", "value": "Reimbursed"},
  ];

  List<Map<String, dynamic>> employees = [
    {"label": "All Employees", "value": "All Employees"},
    {"label": "Sarah Johnson", "value": "Sarah Johnson"},
    {"label": "Mike Chen", "value": "Mike Chen"},
    {"label": "Emily Davis", "value": "Emily Davis"},
    {"label": "David Wilson", "value": "David Wilson"},
  ];

  List<Map<String, dynamic>> expenseSummary = [
    {
      "title": "Total Expenses",
      "amount": 45750,
      "currency": "USD",
      "trend": 8.5,
      "icon": Icons.receipt_long,
      "color": Colors.blue,
    },
    {
      "title": "Pending Approval",
      "amount": 12300,
      "currency": "USD",
      "trend": 15.2,
      "icon": Icons.pending,
      "color": Colors.orange,
    },
    {
      "title": "Approved",
      "amount": 28450,
      "currency": "USD",
      "trend": 5.8,
      "icon": Icons.check_circle,
      "color": Colors.green,
    },
    {
      "title": "Reimbursed",
      "amount": 22100,
      "currency": "USD",
      "trend": -3.2,
      "icon": Icons.payment,
      "color": Colors.purple,
    },
  ];

  List<Map<String, dynamic>> expenseCategories = [
    {
      "category": "Travel",
      "amount": 18500,
      "count": 24,
      "percentage": 40.4,
      "color": Colors.blue,
      "avgAmount": 770.83,
    },
    {
      "category": "Meals",
      "amount": 8900,
      "count": 45,
      "percentage": 19.5,
      "color": Colors.green,
      "avgAmount": 197.78,
    },
    {
      "category": "Equipment",
      "amount": 7200,
      "count": 12,
      "percentage": 15.7,
      "color": Colors.purple,
      "avgAmount": 600.0,
    },
    {
      "category": "Software",
      "amount": 4850,
      "count": 8,
      "percentage": 10.6,
      "color": Colors.orange,
      "avgAmount": 606.25,
    },
    {
      "category": "Training",
      "amount": 3200,
      "count": 6,
      "percentage": 7.0,
      "color": Colors.teal,
      "avgAmount": 533.33,
    },
    {
      "category": "Marketing",
      "amount": 2100,
      "count": 4,
      "percentage": 4.6,
      "color": Colors.red,
      "avgAmount": 525.0,
    },
    {
      "category": "Office Supplies",
      "amount": 1000,
      "count": 15,
      "percentage": 2.2,
      "color": Colors.brown,
      "avgAmount": 66.67,
    },
  ];

  List<Map<String, dynamic>> recentExpenses = [
    {
      "id": "EXP-001",
      "employee": "Sarah Johnson",
      "description": "Client Meeting - Hotel Accommodation",
      "category": "Travel",
      "amount": 350.00,
      "date": "2024-03-15",
      "status": "Pending",
      "receipt": true,
      "project": "Mobile App Development",
      "location": "New York",
    },
    {
      "id": "EXP-002",
      "employee": "Mike Chen",
      "description": "Development Tools License",
      "category": "Software",
      "amount": 299.99,
      "date": "2024-03-14",
      "status": "Approved",
      "receipt": true,
      "project": "Website Redesign",
      "location": "Remote",
    },
    {
      "id": "EXP-003",
      "employee": "Emily Davis",
      "description": "Team Lunch - Quarterly Meeting",
      "category": "Meals",
      "amount": 125.50,
      "date": "2024-03-13",
      "status": "Reimbursed",
      "receipt": true,
      "project": "General",
      "location": "Office",
    },
    {
      "id": "EXP-004",
      "employee": "David Wilson",
      "description": "Conference Registration",
      "category": "Training",
      "amount": 750.00,
      "date": "2024-03-12",
      "status": "Approved",
      "receipt": true,
      "project": "Professional Development",
      "location": "San Francisco",
    },
    {
      "id": "EXP-005",
      "employee": "Sarah Johnson",
      "description": "Marketing Materials",
      "category": "Marketing",
      "amount": 180.00,
      "date": "2024-03-11",
      "status": "Rejected",
      "receipt": false,
      "project": "Q2 Campaign",
      "location": "Office",
      "note": "Missing receipt required",
    },
  ];

  List<Map<String, dynamic>> topSpenders = [
    {
      "employee": "Sarah Johnson",
      "role": "Project Manager",
      "totalAmount": 2850.00,
      "expenseCount": 12,
      "avgExpense": 237.50,
      "lastExpense": "2024-03-15",
      "avatar": "SJ",
    },
    {
      "employee": "Mike Chen",
      "role": "Lead Developer",
      "totalAmount": 2340.00,
      "expenseCount": 8,
      "avgExpense": 292.50,
      "lastExpense": "2024-03-14",
      "avatar": "MC",
    },
    {
      "employee": "Emily Davis",
      "role": "UI/UX Designer",
      "totalAmount": 1890.00,
      "expenseCount": 15,
      "avgExpense": 126.00,
      "lastExpense": "2024-03-13",
      "avatar": "ED",
    },
    {
      "employee": "David Wilson",
      "role": "DevOps Engineer",
      "totalAmount": 1650.00,
      "expenseCount": 6,
      "avgExpense": 275.00,
      "lastExpense": "2024-03-12",
      "avatar": "DW",
    },
  ];

  List<Map<String, dynamic>> pendingApprovals = [
    {
      "id": "EXP-001",
      "employee": "Sarah Johnson",
      "description": "Client Meeting - Hotel Accommodation",
      "amount": 350.00,
      "category": "Travel",
      "date": "2024-03-15",
      "priority": "High",
      "daysWaiting": 2,
    },
    {
      "id": "EXP-006",
      "employee": "Mike Chen",
      "description": "Cloud Service Subscription",
      "amount": 89.99,
      "category": "Software",
      "date": "2024-03-14",
      "priority": "Medium",
      "daysWaiting": 3,
    },
    {
      "id": "EXP-007",
      "employee": "Emily Davis",
      "description": "Design Software License",
      "amount": 199.00,
      "category": "Software",
      "date": "2024-03-13",
      "priority": "Low",
      "daysWaiting": 4,
    },
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'reimbursed':
        return Colors.purple;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.blue;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildExpenseSummaryCard(Map<String, dynamic> summary) {
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
                  color: (summary["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  summary["icon"] as IconData,
                  color: summary["color"] as Color,
                  size: 24,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: (summary["trend"] as double) >= 0 
                      ? Colors.green.withAlpha(20)
                      : Colors.red.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      (summary["trend"] as double) >= 0 
                          ? Icons.trending_up
                          : Icons.trending_down,
                      size: 12,
                      color: (summary["trend"] as double) >= 0 
                          ? Colors.green
                          : Colors.red,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${(summary["trend"] as double).abs().toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: (summary["trend"] as double) >= 0 
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${summary["title"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "\$${((summary["amount"] as num).toDouble()).currency}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
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
                width: 4,
                height: 40,
                decoration: BoxDecoration(
                  color: category["color"] as Color,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${category["category"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${category["count"]} expenses",
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
                    "\$${((category["amount"] as num).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${(category["percentage"] as double).toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Text(
            "Avg per expense: \$${((category["avgAmount"] as num).toDouble()).currency}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (category["percentage"] as double) / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: category["color"] as Color,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseItem(Map<String, dynamic> expense) {
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spSm),
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
              CircleAvatar(
                radius: 16,
                backgroundColor: primaryColor.withAlpha(20),
                child: Text(
                  "${expense["employee"]}".split(" ").map((e) => e[0]).join(""),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${expense["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${expense["employee"]} • ${expense["category"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${((expense["amount"] as num).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor("${expense["status"]}").withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${expense["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: _getStatusColor("${expense["status"]}"),
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
              Icon(
                Icons.calendar_today,
                size: 14,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${expense["date"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(
                Icons.location_on,
                size: 14,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${expense["location"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              if (expense["receipt"] == true)
                Row(
                  children: [
                    Icon(
                      Icons.receipt,
                      size: 14,
                      color: Colors.green,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Receipt",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          
          if (expense["note"] != null) ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.red.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info,
                    size: 14,
                    color: Colors.red,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${expense["note"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTopSpenderCard(Map<String, dynamic> spender) {
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: primaryColor,
            child: Text(
              "${spender["avatar"]}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${spender["employee"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${spender["role"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${spender["expenseCount"]} expenses • Last: ${spender["lastExpense"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${((spender["totalAmount"] as num).toDouble()).currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "Avg: \$${((spender["avgExpense"] as num).toDouble()).currency}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPendingApprovalCard(Map<String, dynamic> approval) {
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getPriorityColor("${approval["priority"]}"),
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
                      "${approval["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${approval["employee"]} • ${approval["category"]}",
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
                    "\$${((approval["amount"] as num).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: _getPriorityColor("${approval["priority"]}").withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${approval["priority"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: _getPriorityColor("${approval["priority"]}"),
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
              Text(
                "${approval["date"]} • Waiting ${approval["daysWaiting"]} days",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Approve",
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Reject",
                size: bs.sm,
                color: Colors.red,
                onPressed: () {},
              ),
            ],
          ),
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
          // Summary Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: expenseSummary.map((summary) {
              return _buildExpenseSummaryCard(summary);
            }).toList(),
          ),
          
          SizedBox(height: spLg),
          
          // Category Breakdown
          Text(
            "Expense Categories",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...expenseCategories.map((category) {
            return Column(
              children: [
                _buildCategoryCard(category),
                SizedBox(height: spSm),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildExpensesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search and Filters
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
                onPressed: () {},
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Filter Options
          QHorizontalScroll(
            children: [
              QDropdownField(
                label: "Period",
                items: periods,
                value: selectedPeriod,
                onChanged: (value, label) {
                  selectedPeriod = value;
                  setState(() {});
                },
              ),
              SizedBox(width: spSm),
              QDropdownField(
                label: "Category",
                items: categories,
                value: selectedCategory,
                onChanged: (value, label) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),
              SizedBox(width: spSm),
              QDropdownField(
                label: "Status",
                items: statusOptions,
                value: selectedStatus,
                onChanged: (value, label) {
                  selectedStatus = value;
                  setState(() {});
                },
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Expenses List
          Text(
            "Recent Expenses",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...recentExpenses.map((expense) {
            return _buildExpenseItem(expense);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Top Spenders",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...topSpenders.map((spender) {
            return _buildTopSpenderCard(spender);
          }).toList(),
          
          SizedBox(height: spLg),
          
          Text(
            "Pending Approvals",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...pendingApprovals.map((approval) {
            return _buildPendingApprovalCard(approval);
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
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Expenses", icon: Icon(Icons.receipt_long)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildExpensesTab(),
        _buildAnalyticsTab(),
      ],
      actions: [
        QButton(
          icon: Icons.add,
          size: bs.sm,
          onPressed: () {},
        ),
      ],
    );
  }
}
