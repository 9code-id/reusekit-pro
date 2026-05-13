import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlInvoice10View extends StatefulWidget {
  @override
  State<GrlInvoice10View> createState() => _GrlInvoice10ViewState();
}

class _GrlInvoice10ViewState extends State<GrlInvoice10View> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedFilter = "all";
  String selectedCategory = "all";

  List<Map<String, dynamic>> expenseCategories = [
    {
      "id": "1",
      "name": "Office Supplies",
      "icon": Icons.inventory,
      "color": primaryColor,
      "totalExpenses": 2450.75,
      "monthlyBudget": 3000.0,
      "transactionCount": 23,
      "lastTransaction": DateTime.now().subtract(Duration(days: 2)),
    },
    {
      "id": "2", 
      "name": "Travel & Transport",
      "icon": Icons.directions_car,
      "color": successColor,
      "totalExpenses": 1890.50,
      "monthlyBudget": 2500.0,
      "transactionCount": 15,
      "lastTransaction": DateTime.now().subtract(Duration(days: 1)),
    },
    {
      "id": "3",
      "name": "Marketing",
      "icon": Icons.campaign,
      "color": warningColor,
      "totalExpenses": 3250.00,
      "monthlyBudget": 4000.0,
      "transactionCount": 18,
      "lastTransaction": DateTime.now().subtract(Duration(hours: 5)),
    },
    {
      "id": "4",
      "name": "Utilities",
      "icon": Icons.electrical_services,
      "color": infoColor,
      "totalExpenses": 980.25,
      "monthlyBudget": 1200.0,
      "transactionCount": 8,
      "lastTransaction": DateTime.now().subtract(Duration(days: 3)),
    },
  ];

  List<Map<String, dynamic>> recentExpenses = [
    {
      "id": "1",
      "title": "Office Printer Paper",
      "amount": 125.50,
      "category": "Office Supplies",
      "date": DateTime.now().subtract(Duration(hours: 2)),
      "vendor": "Office Depot",
      "status": "approved",
      "receiptUrl": "https://picsum.photos/400/600?random=1",
    },
    {
      "id": "2",
      "title": "Client Meeting Lunch",
      "amount": 89.75,
      "category": "Travel & Transport",
      "date": DateTime.now().subtract(Duration(hours: 6)),
      "vendor": "Downtown Bistro",
      "status": "pending",
      "receiptUrl": "https://picsum.photos/400/600?random=2",
    },
    {
      "id": "3",
      "title": "Google Ads Campaign",
      "amount": 450.00,
      "category": "Marketing",
      "date": DateTime.now().subtract(Duration(days: 1)),
      "vendor": "Google LLC",
      "status": "approved",
      "receiptUrl": "https://picsum.photos/400/600?random=3",
    },
    {
      "id": "4",
      "title": "Internet Service",
      "amount": 89.99,
      "category": "Utilities",
      "date": DateTime.now().subtract(Duration(days: 2)),
      "vendor": "Comcast",
      "status": "approved",
      "receiptUrl": "https://picsum.photos/400/600?random=4",
    },
    {
      "id": "5",
      "title": "Software License",
      "amount": 299.00,
      "category": "Office Supplies",
      "date": DateTime.now().subtract(Duration(days: 3)),
      "vendor": "Adobe Inc",
      "status": "rejected",
      "receiptUrl": "https://picsum.photos/400/600?random=5",
    },
  ];

  List<Map<String, dynamic>> budgetAlerts = [
    {
      "id": "1",
      "category": "Marketing",
      "percentage": 81.25,
      "amount": 3250.00,
      "budget": 4000.0,
      "severity": "warning",
      "message": "Approaching budget limit",
    },
    {
      "id": "2",
      "category": "Office Supplies", 
      "percentage": 81.69,
      "amount": 2450.75,
      "budget": 3000.0,
      "severity": "warning",
      "message": "Budget usage high",
    },
  ];

  List<Map<String, dynamic>> get filteredExpenses {
    return recentExpenses.where((expense) {
      bool matchesSearch = expense["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          expense["vendor"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesFilter = selectedFilter == "all" || expense["status"] == selectedFilter;
      bool matchesCategory = selectedCategory == "all" || expense["category"] == selectedCategory;
      return matchesSearch && matchesFilter && matchesCategory;
    }).toList();
  }

  double get totalMonthlyExpenses {
    return expenseCategories.fold(0.0, (sum, category) => sum + (category["totalExpenses"] as double));
  }

  double get totalMonthlyBudget {
    return expenseCategories.fold(0.0, (sum, category) => sum + (category["monthlyBudget"] as double));
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Summary Cards
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
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
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.account_balance_wallet,
                              color: primaryColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Total Expenses",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "\$${totalMonthlyExpenses.currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "This month",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
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
                    borderRadius: BorderRadius.circular(radiusLg),
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
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.trending_down,
                              color: successColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Budget Used",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${((totalMonthlyExpenses / totalMonthlyBudget) * 100).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "of \$${totalMonthlyBudget.currency}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Budget Alerts
          if (budgetAlerts.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: warningColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning_amber,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Budget Alerts",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  ...budgetAlerts.map((alert) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${alert["category"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${alert["message"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "${(alert["percentage"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

          // Expense Categories
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Expense Categories",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...expenseCategories.map((category) {
                  double percentage = ((category["totalExpenses"] as double) / (category["monthlyBudget"] as double)) * 100;
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (category["color"] as Color).withAlpha(5),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: (category["color"] as Color).withAlpha(20)),
                    ),
                    child: Column(
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: (category["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                category["icon"] as IconData,
                                color: category["color"] as Color,
                                size: 16,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${category["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "${category["transactionCount"]} transactions",
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
                                  "\$${(category["totalExpenses"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: category["color"] as Color,
                                  ),
                                ),
                                Text(
                                  "of \$${(category["monthlyBudget"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: (category["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: percentage / 100,
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
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpensesTab() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spMd,
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
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Status",
                      items: [
                        {"label": "All Status", "value": "all"},
                        {"label": "Approved", "value": "approved"},
                        {"label": "Pending", "value": "pending"},
                        {"label": "Rejected", "value": "rejected"},
                      ],
                      value: selectedFilter,
                      onChanged: (value, label) {
                        selectedFilter = value;
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
                        ...expenseCategories.map((category) => {
                          "label": category["name"],
                          "value": category["name"],
                        }).toList(),
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
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(spMd),
            itemCount: filteredExpenses.length,
            itemBuilder: (context, index) {
              final expense = filteredExpenses[index];
              Color statusColor = expense["status"] == "approved" 
                  ? successColor 
                  : expense["status"] == "pending" 
                      ? warningColor 
                      : dangerColor;

              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${expense["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${expense["vendor"]}",
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
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
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
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${expense["category"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\$${(expense["amount"] as double).currency}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${(expense["date"] as DateTime).dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // View receipt
                              },
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(
                                  Icons.receipt,
                                  color: infoColor,
                                  size: 16,
                                ),
                              ),
                            ),
                            SizedBox(width: spXs),
                            GestureDetector(
                              onTap: () {
                                // Edit expense
                              },
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(
                                  Icons.edit,
                                  color: primaryColor,
                                  size: 16,
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
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBudgetTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Monthly Budget Overview
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Monthly Budget Overview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Budget",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${totalMonthlyBudget.currency}",
                            style: TextStyle(
                              fontSize: fsH5,
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
                            "\$${totalMonthlyExpenses.currency}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
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
                            "\$${(totalMonthlyBudget - totalMonthlyExpenses).currency}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: totalMonthlyExpenses / totalMonthlyBudget,
                    child: Container(
                      decoration: BoxDecoration(
                        color: warningColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
                Text(
                  "${((totalMonthlyExpenses / totalMonthlyBudget) * 100).toStringAsFixed(1)}% of budget used",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          // Category Budgets
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Category Budgets",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    QButton(
                      label: "Edit Budgets",
                      size: bs.sm,
                      onPressed: () {
                        // Edit budgets
                      },
                    ),
                  ],
                ),
                ...expenseCategories.map((category) {
                  double spent = category["totalExpenses"] as double;
                  double budget = category["monthlyBudget"] as double;
                  double percentage = (spent / budget) * 100;
                  Color progressColor = percentage > 80 
                      ? dangerColor 
                      : percentage > 60 
                          ? warningColor 
                          : successColor;

                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (category["color"] as Color).withAlpha(5),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: (category["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                category["icon"] as IconData,
                                color: category["color"] as Color,
                                size: 16,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${category["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "\$${spent.currency} / \$${budget.currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${percentage.toStringAsFixed(1)}% used",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: progressColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: progressColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: percentage / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: progressColor,
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
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Expense Tracker",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Expenses", icon: Icon(Icons.receipt_long)),
        Tab(text: "Budget", icon: Icon(Icons.account_balance_wallet)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildExpensesTab(),
        _buildBudgetTab(),
      ],
    );
  }
}
