import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsPayrollIntegrationView extends StatefulWidget {
  const RfsPayrollIntegrationView({super.key});

  @override
  State<RfsPayrollIntegrationView> createState() => _RfsPayrollIntegrationViewState();
}

class _RfsPayrollIntegrationViewState extends State<RfsPayrollIntegrationView> {
  int currentTab = 0;
  String selectedPayPeriod = "current";
  String selectedDepartment = "all";
  bool autoCalculation = true;
  bool overtimeEnabled = true;

  List<Map<String, dynamic>> payrollData = [
    {
      "employee": "Alice Johnson",
      "employeeId": "EMP001",
      "role": "Server",
      "avatar": "https://picsum.photos/80/80?random=1&keyword=person",
      "baseSalary": 15.50,
      "hoursWorked": 37.5,
      "overtimeHours": 2.5,
      "tips": 125.75,
      "bonuses": 50.0,
      "deductions": 25.0,
      "grossPay": 662.50,
      "taxes": 99.38,
      "netPay": 563.12,
      "payStatus": "processed",
      "payDate": "2024-12-15",
      "department": "service",
    },
    {
      "employee": "Bob Wilson",
      "employeeId": "EMP002",
      "role": "Chef",
      "avatar": "https://picsum.photos/80/80?random=2&keyword=person",
      "baseSalary": 22.00,
      "hoursWorked": 40.0,
      "overtimeHours": 5.0,
      "tips": 45.00,
      "bonuses": 100.0,
      "deductions": 15.0,
      "grossPay": 1045.0,
      "taxes": 156.75,
      "netPay": 888.25,
      "payStatus": "pending",
      "payDate": "2024-12-15",
      "department": "kitchen",
    },
    {
      "employee": "Carol Smith",
      "employeeId": "EMP003",
      "role": "Manager",
      "avatar": "https://picsum.photos/80/80?random=3&keyword=person",
      "baseSalary": 28.00,
      "hoursWorked": 40.0,
      "overtimeHours": 0.0,
      "tips": 0.0,
      "bonuses": 200.0,
      "deductions": 35.0,
      "grossPay": 1320.0,
      "taxes": 198.0,
      "netPay": 1122.0,
      "payStatus": "processed",
      "payDate": "2024-12-15",
      "department": "management",
    },
    {
      "employee": "David Brown",
      "employeeId": "EMP004",
      "role": "Bartender",
      "avatar": "https://picsum.photos/80/80?random=4&keyword=person",
      "baseSalary": 16.75,
      "hoursWorked": 32.0,
      "overtimeHours": 0.0,
      "tips": 89.50,
      "bonuses": 25.0,
      "deductions": 10.0,
      "grossPay": 650.5,
      "taxes": 97.58,
      "netPay": 552.92,
      "payStatus": "calculated",
      "payDate": "2024-12-15",
      "department": "bar",
    },
  ];

  List<Map<String, dynamic>> payPeriodOptions = [
    {"label": "Current Period", "value": "current"},
    {"label": "Previous Period", "value": "previous"},
    {"label": "Custom Range", "value": "custom"},
  ];

  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All Departments", "value": "all"},
    {"label": "Service", "value": "service"},
    {"label": "Kitchen", "value": "kitchen"},
    {"label": "Bar", "value": "bar"},
    {"label": "Management", "value": "management"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Payroll Integration",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Processing", icon: Icon(Icons.calculate)),
        Tab(text: "Reports", icon: Icon(Icons.description)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildProcessingTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildPayrollSummary(),
          _buildQuickActions(),
          _buildRecentPayroll(),
          _buildPayrollSettings(),
        ],
      ),
    );
  }

  Widget _buildProcessingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildProcessingFilters(),
          _buildPayrollCalculations(),
          _buildEmployeePayroll(),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildReportFilters(),
          _buildPayrollAnalytics(),
          _buildDepartmentCosts(),
          _buildTaxSummary(),
        ],
      ),
    );
  }

  Widget _buildPayrollSummary() {
    double totalGross = payrollData.fold(0.0, (sum, emp) => sum + (emp["grossPay"] as double));
    double totalNet = payrollData.fold(0.0, (sum, emp) => sum + (emp["netPay"] as double));
    double totalTaxes = payrollData.fold(0.0, (sum, emp) => sum + (emp["taxes"] as double));
    double totalTips = payrollData.fold(0.0, (sum, emp) => sum + (emp["tips"] as double));

    return ResponsiveGridView(
      minItemWidth: 200,
      children: [
        _buildSummaryCard("Gross Pay", "\$${totalGross.currency}", Icons.account_balance_wallet, primaryColor),
        _buildSummaryCard("Net Pay", "\$${totalNet.currency}", Icons.payments, successColor),
        _buildSummaryCard("Total Taxes", "\$${totalTaxes.currency}", Icons.receipt, warningColor),
        _buildSummaryCard("Total Tips", "\$${totalTips.currency}", Icons.star, infoColor),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String amount, IconData icon, Color color) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                Spacer(),
                Icon(Icons.trending_up, color: successColor, size: 20),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  amount,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  title,
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
    );
  }

  Widget _buildQuickActions() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Icon(Icons.flash_on, color: warningColor),
                SizedBox(width: spSm),
                Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            ResponsiveGridView(
              minItemWidth: 200,
              children: [
                _buildActionButton("Calculate Payroll", Icons.calculate, () {
                  ss("Payroll calculation started");
                }),
                _buildActionButton("Process Payments", Icons.payment, () {
                  ss("Payment processing initiated");
                }),
                _buildActionButton("Generate Reports", Icons.description, () {
                  ss("Reports generation started");
                }),
                _buildActionButton("Export Data", Icons.download, () {
                  ss("Data export completed");
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String title, IconData icon, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      child: QButton(
        label: title,
        size: bs.sm,
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildRecentPayroll() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Icon(Icons.history, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Recent Payroll Activity",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            Column(
              spacing: spSm,
              children: [
                _buildActivityItem("Payroll processed for 15 employees", "2 hours ago", Icons.check_circle, successColor),
                _buildActivityItem("Tax calculations updated", "4 hours ago", Icons.calculate, infoColor),
                _buildActivityItem("Overtime rates adjusted", "1 day ago", Icons.schedule, warningColor),
                _buildActivityItem("Monthly report generated", "2 days ago", Icons.description, primaryColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(String activity, String time, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 11,
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

  Widget _buildPayrollSettings() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Icon(Icons.settings, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Payroll Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Auto Calculate Payroll",
                            "value": true,
                            "checked": autoCalculation,
                          }
                        ],
                        value: [if (autoCalculation) {"label": "Auto Calculate Payroll", "value": true, "checked": true}],
                        onChanged: (values, ids) {
                          autoCalculation = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Include Overtime Calculations",
                            "value": true,
                            "checked": overtimeEnabled,
                          }
                        ],
                        value: [if (overtimeEnabled) {"label": "Include Overtime Calculations", "value": true, "checked": true}],
                        onChanged: (values, ids) {
                          overtimeEnabled = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Save Settings",
                size: bs.sm,
                onPressed: () {
                  ss("Payroll settings saved successfully");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProcessingFilters() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Icon(Icons.filter_list, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Processing Filters",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Pay Period",
                    items: payPeriodOptions,
                    value: selectedPayPeriod,
                    onChanged: (value, label) {
                      selectedPayPeriod = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Department",
                    items: departmentOptions,
                    value: selectedDepartment,
                    onChanged: (value, label) {
                      selectedDepartment = value;
                      setState(() {});
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

  Widget _buildPayrollCalculations() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Icon(Icons.calculate, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Payroll Calculations",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "Calculate All",
                  size: bs.sm,
                  onPressed: () {
                    ss("Calculating payroll for all employees");
                  },
                ),
              ],
            ),
            ResponsiveGridView(
              minItemWidth: 200,
              children: [
                _buildCalculationCard("Regular Hours", "${payrollData.fold(0.0, (sum, emp) => sum + (emp["hoursWorked"] as double)).toStringAsFixed(1)}h", Icons.schedule),
                _buildCalculationCard("Overtime Hours", "${payrollData.fold(0.0, (sum, emp) => sum + (emp["overtimeHours"] as double)).toStringAsFixed(1)}h", Icons.schedule_send),
                _buildCalculationCard("Total Bonuses", "\$${payrollData.fold(0.0, (sum, emp) => sum + (emp["bonuses"] as double)).currency}", Icons.card_giftcard),
                _buildCalculationCard("Total Deductions", "\$${payrollData.fold(0.0, (sum, emp) => sum + (emp["deductions"] as double)).currency}", Icons.remove_circle),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalculationCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Icon(icon, color: primaryColor, size: 24),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeePayroll() {
    return Column(
      spacing: spSm,
      children: [
        Card(
          child: Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Icon(Icons.people, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Employee Payroll Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        ...payrollData.map((employee) => _buildEmployeePayrollCard(employee)),
      ],
    );
  }

  Widget _buildEmployeePayrollCard(Map<String, dynamic> employee) {
    Color statusColor = _getPayStatusColor(employee["payStatus"] as String);
    
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage("${employee["avatar"]}"),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${employee["employee"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${employee["role"]} • ID: ${employee["employeeId"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${employee["payStatus"]}".toUpperCase(),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
            ResponsiveGridView(
              minItemWidth: 200,
              children: [
                _buildPayDetailCard("Base Rate", "\$${(employee["baseSalary"] as double).toStringAsFixed(2)}/hr", Icons.attach_money),
                _buildPayDetailCard("Hours Worked", "${(employee["hoursWorked"] as double).toStringAsFixed(1)}h", Icons.schedule),
                _buildPayDetailCard("Overtime", "${(employee["overtimeHours"] as double).toStringAsFixed(1)}h", Icons.schedule_send),
                _buildPayDetailCard("Tips", "\$${(employee["tips"] as double).currency}", Icons.star),
              ],
            ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Text("Gross Pay:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                      Spacer(),
                      Text("\$${(employee["grossPay"] as double).currency}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Taxes:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                      Spacer(),
                      Text("-\$${(employee["taxes"] as double).currency}", style: TextStyle(fontSize: 12, color: dangerColor)),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Deductions:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                      Spacer(),
                      Text("-\$${(employee["deductions"] as double).currency}", style: TextStyle(fontSize: 12, color: dangerColor)),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Text("Net Pay:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: primaryColor)),
                      Spacer(),
                      Text("\$${(employee["netPay"] as double).currency}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: successColor)),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Process Payment",
                    size: bs.sm,
                    onPressed: () {
                      ss("Processing payment for ${employee["employee"]}");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.edit,
                  size: bs.sm,
                  onPressed: () {
                    ss("Editing payroll for ${employee["employee"]}");
                  },
                ),
                SizedBox(width: spXs),
                QButton(
                  icon: Icons.receipt,
                  size: bs.sm,
                  onPressed: () {
                    ss("Payslip generated for ${employee["employee"]}");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPayDetailCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(icon, color: primaryColor, size: 18),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportFilters() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Icon(Icons.filter_alt, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Report Filters",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Report Type",
                    items: [
                      {"label": "Payroll Summary", "value": "summary"},
                      {"label": "Tax Report", "value": "tax"},
                      {"label": "Department Costs", "value": "department"},
                    ],
                    value: "summary",
                    onChanged: (value, label) {
                      ss("Report type updated");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Generate",
                  size: bs.sm,
                  onPressed: () {
                    ss("Report generated successfully");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPayrollAnalytics() {
    return ResponsiveGridView(
      minItemWidth: 200,
      children: [
        _buildAnalyticsCard("Avg Hourly Rate", "\$${(19.56).currency}", Icons.schedule, primaryColor, "+5.2%"),
        _buildAnalyticsCard("Total Labor Cost", "\$${(3680.87).currency}", Icons.account_balance_wallet, infoColor, "+8.1%"),
        _buildAnalyticsCard("Overtime Ratio", "12.5%", Icons.schedule_send, warningColor, "-2.3%"),
        _buildAnalyticsCard("Benefits Cost", "\$${(425.50).currency}", Icons.health_and_safety, successColor, "+1.8%"),
      ],
    );
  }

  Widget _buildAnalyticsCard(String title, String value, IconData icon, Color color, String change) {
    bool isPositive = change.startsWith('+');
    Color changeColor = isPositive ? successColor : dangerColor;
    
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: changeColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    change,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: changeColor,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  title,
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
    );
  }

  Widget _buildDepartmentCosts() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Icon(Icons.business, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Department Labor Costs",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            Column(
              spacing: spSm,
              children: [
                _buildDepartmentCostItem("Kitchen", "\$1,045.00", "28.4%", successColor),
                _buildDepartmentCostItem("Service", "\$1,225.62", "33.3%", infoColor),
                _buildDepartmentCostItem("Management", "\$1,122.00", "30.5%", warningColor),
                _buildDepartmentCostItem("Bar", "\$552.92", "15.0%", primaryColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDepartmentCostItem(String department, String cost, String percentage, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: color,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  department,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "$percentage of total",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            cost,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaxSummary() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Icon(Icons.receipt_long, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Tax Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            ResponsiveGridView(
              minItemWidth: 200,
              children: [
                _buildTaxCard("Federal Tax", "\$285.45", "15.0%"),
                _buildTaxCard("State Tax", "\$142.72", "7.5%"),
                _buildTaxCard("Social Security", "\$228.36", "12.0%"),
                _buildTaxCard("Medicare", "\$57.09", "3.0%"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaxCard(String taxType, String amount, String rate) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        children: [
          Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            taxType,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: disabledBoldColor,
            ),
          ),
          Text(
            rate,
            style: TextStyle(
              fontSize: 11,
              color: disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getPayStatusColor(String status) {
    switch (status) {
      case "processed":
        return successColor;
      case "pending":
        return warningColor;
      case "calculated":
        return infoColor;
      default:
        return disabledColor;
    }
  }
}
