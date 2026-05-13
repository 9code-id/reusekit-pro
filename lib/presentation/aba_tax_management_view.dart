import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaTaxManagementView extends StatefulWidget {
  const AbaTaxManagementView({super.key});

  @override
  State<AbaTaxManagementView> createState() => _AbaTaxManagementViewState();
}

class _AbaTaxManagementViewState extends State<AbaTaxManagementView> {
  int currentTab = 0;
  String selectedYear = "2024";
  String selectedQuarter = "q1";
  
  List<Map<String, dynamic>> yearOptions = [
    {"label": "2024", "value": "2024"},
    {"label": "2023", "value": "2023"},
    {"label": "2022", "value": "2022"},
    {"label": "2021", "value": "2021"},
  ];

  List<Map<String, dynamic>> quarterOptions = [
    {"label": "Q1 (Jan-Mar)", "value": "q1"},
    {"label": "Q2 (Apr-Jun)", "value": "q2"},
    {"label": "Q3 (Jul-Sep)", "value": "q3"},
    {"label": "Q4 (Oct-Dec)", "value": "q4"},
  ];

  List<Map<String, dynamic>> taxOverview = [
    {
      "title": "Total Tax Liability",
      "amount": 45600.00,
      "change": 8.5,
      "icon": Icons.account_balance,
      "color": primaryColor,
    },
    {
      "title": "Federal Taxes",
      "amount": 32400.00,
      "change": 12.3,
      "icon": Icons.gavel,
      "color": infoColor,
    },
    {
      "title": "State Taxes",
      "amount": 9800.00,
      "change": -2.1,
      "icon": Icons.location_city,
      "color": warningColor,
    },
    {
      "title": "Local Taxes",
      "amount": 3400.00,
      "change": 5.7,
      "icon": Icons.home_work,
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> taxCategories = [
    {
      "category": "Federal Income Tax",
      "description": "Employee federal income tax withholdings",
      "rate": "12-37%",
      "collected": 28500.00,
      "remitted": 26800.00,
      "pending": 1700.00,
      "dueDate": "2024-04-15",
      "status": "current",
      "icon": Icons.account_balance,
    },
    {
      "category": "Social Security",
      "description": "FICA Social Security contributions",
      "rate": "6.2%",
      "collected": 8640.00,
      "remitted": 8640.00,
      "pending": 0.00,
      "dueDate": "2024-04-15",
      "status": "paid",
      "icon": Icons.security,
    },
    {
      "category": "Medicare",
      "description": "FICA Medicare contributions",
      "rate": "1.45%",
      "collected": 2025.00,
      "remitted": 2025.00,
      "pending": 0.00,
      "dueDate": "2024-04-15",
      "status": "paid",
      "icon": Icons.health_and_safety,
    },
    {
      "category": "State Income Tax",
      "description": "State income tax withholdings",
      "rate": "3-8%",
      "collected": 9800.00,
      "remitted": 8500.00,
      "pending": 1300.00,
      "dueDate": "2024-04-20",
      "status": "overdue",
      "icon": Icons.location_city,
    },
    {
      "category": "Unemployment Tax",
      "description": "Federal and state unemployment taxes",
      "rate": "0.6-6%",
      "collected": 1850.00,
      "remitted": 1500.00,
      "pending": 350.00,
      "dueDate": "2024-04-30",
      "status": "current",
      "icon": Icons.work_off,
    },
    {
      "category": "Workers' Compensation",
      "description": "Workers' compensation insurance premiums",
      "rate": "Variable",
      "collected": 2400.00,
      "remitted": 2400.00,
      "pending": 0.00,
      "dueDate": "2024-05-01",
      "status": "paid",
      "icon": Icons.medical_services,
    },
  ];

  List<Map<String, dynamic>> upcomingDeadlines = [
    {
      "form": "Form 941",
      "description": "Quarterly Federal Tax Return",
      "dueDate": "2024-04-30",
      "amount": 15600.00,
      "status": "pending",
      "priority": "high",
    },
    {
      "form": "Form 940",
      "description": "Annual Federal Unemployment Tax",
      "dueDate": "2024-05-15",
      "amount": 850.00,
      "status": "draft",
      "priority": "medium",
    },
    {
      "form": "State Tax Return",
      "description": "Quarterly State Tax Filing",
      "dueDate": "2024-05-01",
      "amount": 9800.00,
      "status": "overdue",
      "priority": "urgent",
    },
    {
      "form": "Local Tax Return",
      "description": "Monthly Local Tax Filing",
      "dueDate": "2024-04-20",
      "amount": 1200.00,
      "status": "ready",
      "priority": "medium",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "paid":
        return successColor;
      case "current":
        return infoColor;
      case "overdue":
        return dangerColor;
      case "pending":
        return warningColor;
      case "draft":
        return disabledBoldColor;
      case "ready":
        return primaryColor;
      case "urgent":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "paid":
        return "Paid";
      case "current":
        return "Current";
      case "overdue":
        return "Overdue";
      case "pending":
        return "Pending";
      case "draft":
        return "Draft";
      case "ready":
        return "Ready";
      case "urgent":
        return "Urgent";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Tax Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Categories", icon: Icon(Icons.category)),
        Tab(text: "Deadlines", icon: Icon(Icons.schedule)),
        Tab(text: "Compliance", icon: Icon(Icons.verified)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildCategoriesTab(),
        _buildDeadlinesTab(),
        _buildComplianceTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Filters
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Tax Year",
                    items: yearOptions,
                    value: selectedYear,
                    onChanged: (value, label) {
                      selectedYear = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Quarter",
                    items: quarterOptions,
                    value: selectedQuarter,
                    onChanged: (value, label) {
                      selectedQuarter = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),

          // Tax Overview Cards
          Text(
            "Tax Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: taxOverview.map((overview) {
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
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (overview["color"] as Color).withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            overview["icon"] as IconData,
                            color: overview["color"] as Color,
                            size: 24,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: (overview["change"] as double) >= 0
                                ? successColor.withAlpha(26)
                                : dangerColor.withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${(overview["change"] as double) >= 0 ? '+' : ''}${(overview["change"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: (overview["change"] as double) >= 0
                                  ? successColor
                                  : dangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "\$${((overview["amount"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${overview["title"]}",
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

          // Quick Actions
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "File Tax Return",
                  icon: Icons.file_upload,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Make Payment",
                  icon: Icons.payment,
                  onPressed: () {},
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Generate Report",
                  icon: Icons.summarize,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Setup Reminder",
                  icon: Icons.notifications,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Tax Categories",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            children: taxCategories.map((category) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getStatusColor(category["status"]),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            category["icon"] as IconData,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 4,
                            children: [
                              Text(
                                "${category["category"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${category["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(category["status"]).withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            _getStatusLabel(category["status"]),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(category["status"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Rate: ${category["rate"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Due: ${category["dueDate"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 4,
                            children: [
                              Text(
                                "Collected",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${((category["collected"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: 14,
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
                            spacing: 4,
                            children: [
                              Text(
                                "Remitted",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${((category["remitted"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 4,
                            children: [
                              Text(
                                "Pending",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${((category["pending"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: (category["pending"] as double) > 0 ? warningColor : successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDeadlinesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Upcoming Deadlines",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            children: upcomingDeadlines.map((deadline) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
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
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 4,
                            children: [
                              Text(
                                "${deadline["form"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${deadline["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(deadline["priority"]).withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            _getStatusLabel(deadline["priority"]).toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(deadline["priority"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Due: ${deadline["dueDate"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\$${((deadline["amount"] as double)).currency}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(deadline["status"]).withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            _getStatusLabel(deadline["status"]),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(deadline["status"]),
                            ),
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Process",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildComplianceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Tax Compliance Status",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
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
                Text(
                  "Compliance Overview",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: successColor,
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Federal compliance: Current",
                      style: TextStyle(
                        fontSize: 14,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.warning,
                      color: warningColor,
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "State compliance: Action needed",
                      style: TextStyle(
                        fontSize: 14,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: successColor,
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Local compliance: Current",
                      style: TextStyle(
                        fontSize: 14,
                        color: successColor,
                      ),
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
}
