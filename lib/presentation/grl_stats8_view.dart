import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStats8View extends StatefulWidget {
  @override
  State<GrlStats8View> createState() => _GrlStats8ViewState();
}

class _GrlStats8ViewState extends State<GrlStats8View> {
  String selectedDepartment = "all";
  String selectedPeriod = "month";
  
  List<Map<String, dynamic>> departmentItems = [
    {"label": "All Departments", "value": "all"},
    {"label": "Engineering", "value": "engineering"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Sales", "value": "sales"},
    {"label": "Operations", "value": "operations"},
  ];

  List<Map<String, dynamic>> periodItems = [
    {"label": "This Month", "value": "month"},
    {"label": "This Quarter", "value": "quarter"},
    {"label": "This Year", "value": "year"},
  ];

  List<Map<String, dynamic>> get budgetMetrics => [
    {
      "title": "Total Budget",
      "value": "\$2.8M",
      "trend": "+5.2%",
      "icon": Icons.account_balance_wallet,
      "color": primaryColor,
    },
    {
      "title": "Spent",
      "value": "\$2.1M",
      "trend": "+8.7%",
      "icon": Icons.trending_down,
      "color": warningColor,
    },
    {
      "title": "Remaining",
      "value": "\$700K",
      "trend": "-12.3%",
      "icon": Icons.savings,
      "color": successColor,
    },
    {
      "title": "Burn Rate",
      "value": "75%",
      "trend": "+3.4%",
      "icon": Icons.local_fire_department,
      "color": dangerColor,
    },
    {
      "title": "ROI",
      "value": "142%",
      "trend": "+15.6%",
      "icon": Icons.trending_up,
      "color": successColor,
    },
    {
      "title": "Efficiency",
      "value": "87%",
      "trend": "+2.8%",
      "icon": Icons.speed,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> get departmentBudgets => [
    {
      "department": "Engineering",
      "allocated": 1200000,
      "spent": 890000,
      "remaining": 310000,
      "utilization": 74.2,
      "projects": 12,
      "icon": Icons.engineering,
      "color": primaryColor,
    },
    {
      "department": "Marketing",
      "allocated": 800000,
      "spent": 645000,
      "remaining": 155000,
      "utilization": 80.6,
      "projects": 8,
      "icon": Icons.campaign,
      "color": successColor,
    },
    {
      "department": "Sales",
      "allocated": 500000,
      "spent": 420000,
      "remaining": 80000,
      "utilization": 84.0,
      "projects": 6,
      "icon": Icons.point_of_sale,
      "color": infoColor,
    },
    {
      "department": "Operations",
      "allocated": 300000,
      "spent": 185000,
      "remaining": 115000,
      "utilization": 61.7,
      "projects": 4,
      "icon": Icons.settings,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> get expenseCategories => [
    {
      "category": "Salaries & Benefits",
      "amount": 1250000,
      "percentage": 59.5,
      "budget": 1400000,
      "variance": -10.7,
    },
    {
      "category": "Technology & Software",
      "amount": 320000,
      "percentage": 15.2,
      "budget": 300000,
      "variance": 6.7,
    },
    {
      "category": "Marketing & Advertising",
      "amount": 280000,
      "percentage": 13.3,
      "budget": 320000,
      "variance": -12.5,
    },
    {
      "category": "Office & Facilities",
      "amount": 150000,
      "percentage": 7.1,
      "budget": 140000,
      "variance": 7.1,
    },
    {
      "category": "Travel & Events",
      "amount": 100000,
      "percentage": 4.8,
      "budget": 120000,
      "variance": -16.7,
    },
  ];

  List<Map<String, dynamic>> get upcomingExpenses => [
    {
      "item": "Software License Renewal",
      "amount": 45000,
      "dueDate": "2024-02-15",
      "department": "Engineering",
      "priority": "High",
      "status": "Pending",
    },
    {
      "item": "Marketing Campaign Q2",
      "amount": 125000,
      "dueDate": "2024-03-01",
      "department": "Marketing",
      "priority": "Medium",
      "status": "Approved",
    },
    {
      "item": "Office Equipment Upgrade",
      "amount": 28000,
      "dueDate": "2024-02-28",
      "department": "Operations",
      "priority": "Low",
      "status": "Under Review",
    },
    {
      "item": "Sales Training Program",
      "amount": 15000,
      "dueDate": "2024-02-20",
      "department": "Sales",
      "priority": "Medium",
      "status": "Pending",
    },
  ];

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Approved":
        return successColor;
      case "Pending":
        return warningColor;
      case "Under Review":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Budget Analytics"),
        actions: [
          IconButton(
            icon: Icon(Icons.calculate),
            onPressed: () {
              ss("Budget calculator opened");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filter Controls
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Department",
                    items: departmentItems,
                    value: selectedDepartment,
                    onChanged: (value, label) {
                      selectedDepartment = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Period",
                    items: periodItems,
                    value: selectedPeriod,
                    onChanged: (value, label) {
                      selectedPeriod = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Budget Metrics
            ResponsiveGridView(
              minItemWidth: 200,
              children: budgetMetrics.map((metric) {
                bool isPositive = !(metric["trend"] as String).startsWith('-') || 
                                 (metric["title"] == "ROI" || metric["title"] == "Efficiency");
                return Container(
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
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (metric["color"] as Color).withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              metric["icon"] as IconData,
                              color: metric["color"] as Color,
                              size: 20,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: isPositive ? successColor.withAlpha(51) : dangerColor.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                                  color: isPositive ? successColor : dangerColor,
                                  size: 12,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${metric["trend"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isPositive ? successColor : dangerColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${metric["value"]}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${metric["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Department Budgets
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Text(
                          "Department Budget Breakdown",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          icon: Icons.pie_chart,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: departmentBudgets.map((dept) {
                      return Container(
                        margin: EdgeInsets.only(left: spMd, right: spMd, bottom: spSm),
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(13),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: disabledOutlineBorderColor,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: (dept["color"] as Color).withAlpha(51),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    dept["icon"] as IconData,
                                    color: dept["color"] as Color,
                                    size: 16,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${dept["department"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "\$${((dept["allocated"] as int).toDouble() / 1000).toStringAsFixed(0)}K",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${dept["utilization"]}% used",
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
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Spent: ",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          Text(
                                            "\$${((dept["spent"] as int).toDouble() / 1000).toStringAsFixed(0)}K",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: warningColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Row(
                                        children: [
                                          Text(
                                            "Remaining: ",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          Text(
                                            "\$${((dept["remaining"] as int).toDouble() / 1000).toStringAsFixed(0)}K",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: successColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.folder,
                                      size: 14,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${dept["projects"]} projects",
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
                            Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: disabledColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: (dept["utilization"] as double) / 100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: (dept["utilization"] as double) > 80 
                                      ? dangerColor 
                                      : (dept["utilization"] as double) > 60 
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
                  ),
                  SizedBox(height: spMd),
                ],
              ),
            ),

            // Expense Categories
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Text(
                      "Expense Categories",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: expenseCategories.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final category = expenseCategories[index];
                      bool isOverBudget = (category["variance"] as double) > 0;
                      return Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${category["category"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "\$${((category["amount"] as int).toDouble() / 1000).toStringAsFixed(0)}K",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "${category["percentage"]}% of budget",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: isOverBudget ? dangerColor.withAlpha(51) : successColor.withAlpha(51),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${isOverBudget ? '+' : ''}${category["variance"]}%",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: isOverBudget ? dangerColor : successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
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
                                    color: isOverBudget ? dangerColor : primaryColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Upcoming Expenses
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Text(
                          "Upcoming Expenses",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          icon: Icons.add,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: upcomingExpenses.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final expense = upcomingExpenses[index];
                      return Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 50,
                              decoration: BoxDecoration(
                                color: _getPriorityColor(expense["priority"] as String),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${expense["item"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Text(
                                        "${expense["department"]} • ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "Due: ${expense["dueDate"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "\$${((expense["amount"] as int).toDouble() / 1000).toStringAsFixed(0)}K",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: _getPriorityColor(expense["priority"] as String).withAlpha(51),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${expense["priority"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: _getPriorityColor(expense["priority"] as String),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(expense["status"] as String).withAlpha(51),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${expense["status"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: _getStatusColor(expense["status"] as String),
                                          fontWeight: FontWeight.w600,
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
                ],
              ),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Create Budget",
                    icon: Icons.add_circle,
                    size: bs.md,
                    onPressed: () {
                      ss("New budget created");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Export Report",
                    icon: Icons.file_download,
                    size: bs.md,
                    onPressed: () {
                      ss("Budget report exported");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
