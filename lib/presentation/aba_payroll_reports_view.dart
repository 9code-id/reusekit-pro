import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaPayrollReportsView extends StatefulWidget {
  const AbaPayrollReportsView({super.key});

  @override
  State<AbaPayrollReportsView> createState() => _AbaPayrollReportsViewState();
}

class _AbaPayrollReportsViewState extends State<AbaPayrollReportsView> {
  String selectedPeriod = "current_month";
  String selectedDepartment = "all";
  String selectedEmployee = "all";
  String searchQuery = "";
  
  List<Map<String, dynamic>> reportPeriods = [
    {"label": "Current Month", "value": "current_month"},
    {"label": "Last Month", "value": "last_month"},
    {"label": "Quarter", "value": "quarter"},
    {"label": "Year to Date", "value": "ytd"},
    {"label": "Custom Range", "value": "custom"},
  ];

  List<Map<String, dynamic>> departments = [
    {"label": "All Departments", "value": "all"},
    {"label": "Administration", "value": "admin"},
    {"label": "Sales", "value": "sales"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Operations", "value": "operations"},
    {"label": "IT", "value": "it"},
  ];

  List<Map<String, dynamic>> employees = [
    {"label": "All Employees", "value": "all"},
    {"label": "John Smith", "value": "john_smith"},
    {"label": "Sarah Johnson", "value": "sarah_johnson"},
    {"label": "Mike Davis", "value": "mike_davis"},
    {"label": "Emily Wilson", "value": "emily_wilson"},
  ];

  List<Map<String, dynamic>> payrollSummary = [
    {
      "metric": "Total Payroll",
      "amount": 285000.00,
      "change": 12.5,
      "icon": Icons.account_balance_wallet,
    },
    {
      "metric": "Gross Wages",
      "amount": 240000.00,
      "change": 8.3,
      "icon": Icons.payments,
    },
    {
      "metric": "Tax Deductions",
      "amount": 48000.00,
      "change": -2.1,
      "icon": Icons.receipt_long,
    },
    {
      "metric": "Net Pay",
      "amount": 192000.00,
      "change": 15.7,
      "icon": Icons.trending_up,
    },
  ];

  List<Map<String, dynamic>> reportTypes = [
    {
      "title": "Payroll Summary",
      "description": "Comprehensive payroll overview",
      "icon": Icons.summarize,
      "employees": 125,
      "generated": "2 hours ago",
    },
    {
      "title": "Tax Withholdings",
      "description": "Federal and state tax deductions",
      "icon": Icons.account_balance,
      "employees": 125,
      "generated": "3 hours ago",
    },
    {
      "title": "Benefits Deductions",
      "description": "Health, dental, and retirement",
      "icon": Icons.health_and_safety,
      "employees": 98,
      "generated": "5 hours ago",
    },
    {
      "title": "Overtime Analysis",
      "description": "Overtime hours and compensation",
      "icon": Icons.schedule,
      "employees": 45,
      "generated": "1 day ago",
    },
    {
      "title": "Department Breakdown", 
      "description": "Payroll costs by department",
      "icon": Icons.business,
      "employees": 125,
      "generated": "1 day ago",
    },
    {
      "title": "Year-to-Date Summary",
      "description": "Cumulative payroll data",
      "icon": Icons.calendar_today,
      "employees": 125,
      "generated": "2 days ago",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payroll Reports"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Filters Section
            Container(
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
                  Text(
                    "Report Filters",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Period",
                          items: reportPeriods,
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
                          label: "Department",
                          items: departments,
                          value: selectedDepartment,
                          onChanged: (value, label) {
                            selectedDepartment = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Employee",
                    items: employees,
                    value: selectedEmployee,
                    onChanged: (value, label) {
                      selectedEmployee = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search Reports",
                          value: searchQuery,
                          hint: "Search by report name or type",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Generate",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Summary Cards
            Text(
              "Payroll Summary",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: payrollSummary.map((summary) {
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
                              color: primaryColor.withAlpha(26),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              summary["icon"] as IconData,
                              color: primaryColor,
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
                              color: (summary["change"] as double) >= 0
                                  ? successColor.withAlpha(26)
                                  : dangerColor.withAlpha(26),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${(summary["change"] as double) >= 0 ? '+' : ''}${(summary["change"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: (summary["change"] as double) >= 0
                                    ? successColor
                                    : dangerColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${((summary["amount"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${summary["metric"]}",
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

            // Available Reports
            Text(
              "Available Reports",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: reportTypes.map((report) {
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
                              color: primaryColor.withAlpha(26),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              report["icon"] as IconData,
                              color: primaryColor,
                              size: 20,
                            ),
                          ),
                          Spacer(),
                          QButton(
                            icon: Icons.more_vert,
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
                      Row(
                        children: [
                          Icon(
                            Icons.people,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${report["employees"]} employees",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Generated ${report["generated"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "View Report",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
