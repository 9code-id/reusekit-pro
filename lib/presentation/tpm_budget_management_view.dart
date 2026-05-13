import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmBudgetManagementView extends StatefulWidget {
  const TpmBudgetManagementView({super.key});

  @override
  State<TpmBudgetManagementView> createState() => _TpmBudgetManagementViewState();
}

class _TpmBudgetManagementViewState extends State<TpmBudgetManagementView> {
  String selectedPeriod = "Q1 2024";
  String selectedDepartment = "All Departments";
  String selectedBudgetType = "All Types";
  String searchQuery = "";
  int currentTab = 0;

  List<Map<String, dynamic>> budgetPeriods = [
    {"label": "Q1 2024", "value": "Q1 2024"},
    {"label": "Q2 2024", "value": "Q2 2024"},
    {"label": "Q3 2024", "value": "Q3 2024"},
    {"label": "Q4 2024", "value": "Q4 2024"},
    {"label": "FY 2024", "value": "FY 2024"},
  ];

  List<Map<String, dynamic>> departments = [
    {"label": "All Departments", "value": "All Departments"},
    {"label": "Engineering", "value": "Engineering"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Sales", "value": "Sales"},
    {"label": "Operations", "value": "Operations"},
    {"label": "HR", "value": "HR"},
  ];

  List<Map<String, dynamic>> budgetTypes = [
    {"label": "All Types", "value": "All Types"},
    {"label": "Personnel", "value": "Personnel"},
    {"label": "Equipment", "value": "Equipment"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Operations", "value": "Operations"},
    {"label": "Travel", "value": "Travel"},
  ];

  List<Map<String, dynamic>> budgetSummary = [
    {
      "title": "Total Budget",
      "amount": 2500000,
      "currency": "USD",
      "trend": 12.5,
      "icon": Icons.account_balance,
      "color": Colors.blue,
    },
    {
      "title": "Allocated",
      "amount": 1875000,
      "currency": "USD",
      "trend": 8.3,
      "icon": Icons.pie_chart,
      "color": Colors.green,
    },
    {
      "title": "Remaining",
      "amount": 625000,
      "currency": "USD",
      "trend": -15.2,
      "icon": Icons.account_balance_wallet,
      "color": Colors.orange,
    },
    {
      "title": "Utilization",
      "amount": 75,
      "currency": "PERCENT",
      "trend": 5.1,
      "icon": Icons.trending_up,
      "color": Colors.purple,
    },
  ];

  List<Map<String, dynamic>> budgetCategories = [
    {
      "category": "Personnel",
      "budgeted": 1200000,
      "allocated": 950000,
      "spent": 780000,
      "remaining": 420000,
      "utilization": 65.0,
      "status": "On Track",
      "color": Colors.blue,
      "projects": 12,
    },
    {
      "category": "Equipment",
      "budgeted": 500000,
      "allocated": 380000,
      "spent": 420000,
      "remaining": 80000,
      "utilization": 84.0,
      "status": "At Risk",
      "color": Colors.orange,
      "projects": 8,
    },
    {
      "category": "Marketing",
      "budgeted": 300000,
      "allocated": 280000,
      "spent": 245000,
      "remaining": 55000,
      "utilization": 81.7,
      "status": "On Track",
      "color": Colors.green,
      "projects": 6,
    },
    {
      "category": "Operations",
      "budgeted": 350000,
      "allocated": 200000,
      "spent": 165000,
      "remaining": 185000,
      "utilization": 47.1,
      "status": "Under Budget",
      "color": Colors.teal,
      "projects": 10,
    },
    {
      "category": "Travel",
      "budgeted": 150000,
      "allocated": 65000,
      "spent": 85000,
      "remaining": 65000,
      "utilization": 56.7,
      "status": "Over Budget",
      "color": Colors.red,
      "projects": 4,
    },
  ];

  List<Map<String, dynamic>> recentTransactions = [
    {
      "id": "TXN-001",
      "description": "Equipment Purchase - Development Team",
      "category": "Equipment",
      "amount": 15000,
      "type": "Expense",
      "date": "2024-03-15",
      "status": "Approved",
      "department": "Engineering",
      "project": "Mobile App Development",
    },
    {
      "id": "TXN-002",
      "description": "Marketing Campaign Budget",
      "category": "Marketing",
      "amount": 25000,
      "type": "Allocation",
      "date": "2024-03-14",
      "status": "Pending",
      "department": "Marketing",
      "project": "Q2 Product Launch",
    },
    {
      "id": "TXN-003",
      "description": "Training & Development",
      "category": "Personnel",
      "amount": 8500,
      "type": "Expense",
      "date": "2024-03-13",
      "status": "Approved",
      "department": "HR",
      "project": "Employee Development",
    },
  ];

  List<Map<String, dynamic>> budgetAlerts = [
    {
      "type": "warning",
      "title": "Equipment Budget Alert",
      "description": "Equipment category is at 84% utilization",
      "severity": "Medium",
      "category": "Equipment",
      "action": "Review upcoming purchases",
    },
    {
      "type": "error",
      "title": "Travel Budget Exceeded",
      "description": "Travel expenses exceeded allocated budget by 23%",
      "severity": "High",
      "category": "Travel",
      "action": "Immediate review required",
    },
    {
      "type": "info",
      "title": "Operations Under Budget",
      "description": "Operations category has 53% budget remaining",
      "severity": "Low",
      "category": "Operations",
      "action": "Consider reallocation",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'on track':
        return Colors.green;
      case 'at risk':
        return Colors.orange;
      case 'over budget':
        return Colors.red;
      case 'under budget':
        return Colors.teal;
      default:
        return disabledBoldColor;
    }
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
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

  Widget _buildBudgetSummaryCard(Map<String, dynamic> summary) {
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
            summary["currency"] == "PERCENT"
                ? "${(summary["amount"] as num).toInt()}%"
                : "\$${((summary["amount"] as num).toDouble()).currency}",
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

  Widget _buildBudgetCategoryCard(Map<String, dynamic> category) {
    double utilization = category["utilization"] as double;
    
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
                      "${category["projects"]} Projects",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor("${category["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${category["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor("${category["status"]}"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Budgeted",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((category["budgeted"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
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
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((category["spent"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
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
                      "Remaining",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((category["remaining"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Utilization",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${utilization.toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
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
                  widthFactor: utilization / 100,
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
        ],
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
    bool isExpense = transaction["type"] == "Expense";
    
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
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: isExpense 
                  ? Colors.red.withAlpha(20)
                  : Colors.blue.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              isExpense ? Icons.remove : Icons.add,
              color: isExpense ? Colors.red : Colors.blue,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${transaction["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${transaction["category"]} • ${transaction["department"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${transaction["date"]} • ${transaction["id"]}",
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
                "${isExpense ? '-' : '+'}\$${((transaction["amount"] as num).toDouble()).currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isExpense ? Colors.red : Colors.green,
                ),
              ),
              SizedBox(height: spXs),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: transaction["status"] == "Approved"
                      ? Colors.green.withAlpha(20)
                      : Colors.orange.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${transaction["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: transaction["status"] == "Approved"
                        ? Colors.green
                        : Colors.orange,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAlertItem(Map<String, dynamic> alert) {
    Color alertColor = _getSeverityColor("${alert["severity"]}");
    IconData alertIcon;
    
    switch (alert["type"]) {
      case "warning":
        alertIcon = Icons.warning;
        break;
      case "error":
        alertIcon = Icons.error;
        break;
      case "info":
        alertIcon = Icons.info;
        break;
      default:
        alertIcon = Icons.notifications;
    }
    
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
            color: alertColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            alertIcon,
            color: alertColor,
            size: 24,
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
                        "${alert["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: alertColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${alert["severity"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: alertColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${alert["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${alert["action"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: alertColor,
                        ),
                      ),
                    ),
                    QButton(
                      label: "Review",
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
            children: budgetSummary.map((summary) {
              return _buildBudgetSummaryCard(summary);
            }).toList(),
          ),
          
          SizedBox(height: spLg),
          
          // Budget Categories
          Text(
            "Budget Categories",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...budgetCategories.map((category) {
            return Column(
              children: [
                _buildBudgetCategoryCard(category),
                SizedBox(height: spSm),
              ],
            );
          }).toList(),
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
          // Search and Filters
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
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Transactions List
          Text(
            "Recent Transactions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...recentTransactions.map((transaction) {
            return _buildTransactionItem(transaction);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildAlertsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Budget Alerts & Notifications",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...budgetAlerts.map((alert) {
            return _buildAlertItem(alert);
          }).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Budget Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Transactions", icon: Icon(Icons.receipt_long)),
        Tab(text: "Alerts", icon: Icon(Icons.notifications)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildTransactionsTab(),
        _buildAlertsTab(),
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
