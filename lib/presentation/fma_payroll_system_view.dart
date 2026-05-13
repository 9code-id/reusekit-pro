import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaPayrollSystemView extends StatefulWidget {
  const FmaPayrollSystemView({super.key});

  @override
  State<FmaPayrollSystemView> createState() => _FmaPayrollSystemViewState();
}

class _FmaPayrollSystemViewState extends State<FmaPayrollSystemView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedDepartment = "";
  String selectedPayPeriod = "";
  String selectedStatus = "";
  String employeeName = "";
  String position = "";
  String department = "";
  double baseSalary = 0.0;
  double hourlyRate = 0.0;
  double overtimeRate = 0.0;
  String payType = "salary";

  List<Map<String, dynamic>> departments = [
    {"label": "All Departments", "value": ""},
    {"label": "Kitchen", "value": "kitchen"},
    {"label": "Service", "value": "service"},
    {"label": "Management", "value": "management"},
    {"label": "Cleaning", "value": "cleaning"},
  ];

  List<Map<String, dynamic>> payPeriods = [
    {"label": "All Periods", "value": ""},
    {"label": "January 2024", "value": "jan2024"},
    {"label": "December 2023", "value": "dec2023"},
    {"label": "November 2023", "value": "nov2023"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Processed", "value": "processed"},
    {"label": "Pending", "value": "pending"},
    {"label": "Review", "value": "review"},
    {"label": "Paid", "value": "paid"},
  ];

  List<Map<String, dynamic>> payTypeOptions = [
    {"label": "Salary", "value": "salary"},
    {"label": "Hourly", "value": "hourly"},
    {"label": "Commission", "value": "commission"},
  ];

  List<Map<String, dynamic>> payrollRecords = [
    {
      "id": 1,
      "employee": "John Smith",
      "employeeId": "EMP001",
      "department": "Kitchen",
      "position": "Head Chef",
      "payPeriod": "January 2024",
      "regularHours": 160,
      "overtimeHours": 12,
      "basePay": 4500.00,
      "overtimePay": 450.00,
      "bonus": 200.00,
      "deductions": 320.00,
      "netPay": 4830.00,
      "status": "Processed",
      "payDate": "2024-01-31"
    },
    {
      "id": 2,
      "employee": "Sarah Johnson",
      "employeeId": "EMP002",
      "department": "Service",
      "position": "Waitress",
      "payPeriod": "January 2024",
      "regularHours": 140,
      "overtimeHours": 8,
      "basePay": 2800.00,
      "overtimePay": 240.00,
      "bonus": 150.00,
      "deductions": 280.00,
      "netPay": 2910.00,
      "status": "Pending",
      "payDate": "2024-01-31"
    },
    {
      "id": 3,
      "employee": "Mike Davis",
      "employeeId": "EMP003",
      "department": "Kitchen",
      "position": "Sous Chef",
      "payPeriod": "January 2024",
      "regularHours": 160,
      "overtimeHours": 16,
      "basePay": 3800.00,
      "overtimePay": 570.00,
      "bonus": 300.00,
      "deductions": 350.00,
      "netPay": 4320.00,
      "status": "Review",
      "payDate": "2024-01-31"
    },
    {
      "id": 4,
      "employee": "Emma Wilson",
      "employeeId": "EMP004",
      "department": "Management",
      "position": "Restaurant Manager",
      "payPeriod": "January 2024",
      "regularHours": 160,
      "overtimeHours": 20,
      "basePay": 6000.00,
      "overtimePay": 900.00,
      "bonus": 500.00,
      "deductions": 450.00,
      "netPay": 6950.00,
      "status": "Paid",
      "payDate": "2024-01-31"
    },
  ];

  List<Map<String, dynamic>> employees = [
    {
      "id": 1,
      "name": "John Smith",
      "employeeId": "EMP001",
      "department": "Kitchen",
      "position": "Head Chef",
      "payType": "Salary",
      "baseSalary": 4500.00,
      "hourlyRate": 0,
      "overtimeRate": 37.50,
      "deductions": {
        "tax": 15.5,
        "insurance": 120.00,
        "pension": 180.00
      },
      "bonuses": {
        "performance": 200.00,
        "attendance": 0
      }
    },
    {
      "id": 2,
      "name": "Sarah Johnson",
      "employeeId": "EMP002",
      "department": "Service",
      "position": "Waitress",
      "payType": "Hourly",
      "baseSalary": 0,
      "hourlyRate": 20.00,
      "overtimeRate": 30.00,
      "deductions": {
        "tax": 12.0,
        "insurance": 80.00,
        "pension": 120.00
      },
      "bonuses": {
        "performance": 150.00,
        "attendance": 50.00
      }
    },
  ];

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildPayrollStatsGrid(),
          _buildCurrentPayPeriodCard(),
          _buildPendingApprovalsSection(),
          _buildRecentPaymentsSection(),
        ],
      ),
    );
  }

  Widget _buildPayrollStatsGrid() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildStatCard("Total Employees", "24", Icons.people, primaryColor),
        _buildStatCard("Monthly Payroll", "\$48,250", Icons.payments, successColor),
        _buildStatCard("Pending Approvals", "3", Icons.pending_actions, warningColor),
        _buildStatCard("Overtime Hours", "156", Icons.schedule, infoColor),
        _buildStatCard("Total Deductions", "\$12,840", Icons.money_off, dangerColor),
        _buildStatCard("Bonus Paid", "\$3,200", Icons.card_giftcard, successColor),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
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
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Spacer(),
              Icon(
                Icons.trending_up,
                color: successColor,
                size: 16,
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

  Widget _buildCurrentPayPeriodCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_month,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Current Pay Period",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
                      "January 2024",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Jan 1 - Jan 31, 2024",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(230),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "5 days left",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Process Payroll",
                  color: successColor,
                  size: bs.md,
                  onPressed: () => _processPayroll(),
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Generate Reports",
                  color: infoColor,
                  size: bs.md,
                  onPressed: () => _generateReports(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPendingApprovalsSection() {
    List<Map<String, dynamic>> pendingRecords = payrollRecords
        .where((record) => record["status"] == "Pending" || record["status"] == "Review")
        .toList();

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
          Row(
            children: [
              Icon(
                Icons.pending_actions,
                color: warningColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Pending Approvals",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${pendingRecords.length} Pending",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: warningColor,
                  ),
                ),
              ),
            ],
          ),
          ...pendingRecords.map((record) => _buildPendingCard(record)),
        ],
      ),
    );
  }

  Widget _buildPendingCard(Map<String, dynamic> record) {
    Color statusColor = record["status"] == "Pending" ? warningColor : infoColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: statusColor.withAlpha(50),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: statusColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.person,
              color: statusColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${record["employee"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${record["department"]} • ${record["position"]}",
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
            spacing: spXs,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${record["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                "\$${((record["netPay"] as double)).currency}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.check,
            color: successColor,
            size: bs.sm,
            onPressed: () => _approvePayroll(record["id"]),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentPaymentsSection() {
    List<Map<String, dynamic>> recentPayments = payrollRecords
        .where((record) => record["status"] == "Paid")
        .toList();

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
          Row(
            children: [
              Icon(
                Icons.payment,
                color: successColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Recent Payments",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...recentPayments.take(3).map((record) => _buildPaymentItem(record)),
        ],
      ),
    );
  }

  Widget _buildPaymentItem(Map<String, dynamic> record) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: successColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 40,
            decoration: BoxDecoration(
              color: successColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${record["employee"]} - ${record["department"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Paid on ${record["payDate"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "\$${((record["netPay"] as double)).currency}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManagementTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildPayrollTable(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          QTextField(
            label: "Search employees",
            value: searchQuery,
            hint: "Enter employee name or ID",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          Row(
            spacing: spSm,
            children: [
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
              Expanded(
                child: QDropdownField(
                  label: "Pay Period",
                  items: payPeriods,
                  value: selectedPayPeriod,
                  onChanged: (value, label) {
                    selectedPayPeriod = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
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
              Expanded(
                child: QButton(
                  label: "Add Employee",
                  icon: Icons.person_add,
                  size: bs.sm,
                  onPressed: () => _showAddEmployeeDialog(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPayrollTable() {
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
            "Payroll Records",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(primaryColor.withAlpha(25)),
              columns: [
                DataColumn(label: Text("Employee", style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text("Department", style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text("Regular Hours", style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text("Overtime", style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text("Base Pay", style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text("Net Pay", style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text("Status", style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text("Actions", style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              rows: payrollRecords.map((record) {
                Color statusColor = _getStatusColor(record["status"]);

                return DataRow(
                  cells: [
                    DataCell(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("${record["employee"]}", style: TextStyle(fontWeight: FontWeight.w600)),
                          Text("${record["employeeId"]}", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                        ],
                      ),
                    ),
                    DataCell(Text("${record["department"]}")),
                    DataCell(Text("${record["regularHours"]}h")),
                    DataCell(Text("${record["overtimeHours"]}h")),
                    DataCell(Text("\$${((record["basePay"] as double)).currency}")),
                    DataCell(Text("\$${((record["netPay"] as double)).currency}", style: TextStyle(fontWeight: FontWeight.bold))),
                    DataCell(
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${record["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: spXs,
                        children: [
                          QButton(
                            icon: Icons.visibility,
                            size: bs.sm,
                            onPressed: () => _showPayrollDetails(record),
                          ),
                          QButton(
                            icon: Icons.edit,
                            size: bs.sm,
                            onPressed: () => _showEditPayrollDialog(record),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Processed":
        return primaryColor;
      case "Pending":
        return warningColor;
      case "Review":
        return infoColor;
      case "Paid":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _processPayroll() {
    ss("Processing payroll for all employees");
  }

  void _generateReports() {
    ss("Generating payroll reports");
  }

  void _approvePayroll(int id) {
    setState(() {
      var record = payrollRecords.firstWhere((r) => r["id"] == id);
      record["status"] = "Processed";
    });
    ss("Payroll approved successfully");
  }

  void _showAddEmployeeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Employee to Payroll"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spMd,
            children: [
              QTextField(
                label: "Employee Name",
                value: employeeName,
                onChanged: (value) {
                  employeeName = value;
                  setState(() {});
                },
              ),
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Position",
                      value: position,
                      onChanged: (value) {
                        position = value;
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: QDropdownField(
                      label: "Department",
                      items: departments.skip(1).toList(),
                      value: department,
                      onChanged: (value, label) {
                        department = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              QDropdownField(
                label: "Pay Type",
                items: payTypeOptions,
                value: payType,
                onChanged: (value, label) {
                  payType = value;
                  setState(() {});
                },
              ),
              if (payType == "salary")
                QNumberField(
                  label: "Base Salary (\$)",
                  value: baseSalary.toString(),
                  onChanged: (value) {
                    baseSalary = double.tryParse(value) ?? 0.0;
                    setState(() {});
                  },
                ),
              if (payType == "hourly")
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Hourly Rate (\$)",
                        value: hourlyRate.toString(),
                        onChanged: (value) {
                          hourlyRate = double.tryParse(value) ?? 0.0;
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: QNumberField(
                        label: "Overtime Rate (\$)",
                        value: overtimeRate.toString(),
                        onChanged: (value) {
                          overtimeRate = double.tryParse(value) ?? 0.0;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Add Employee",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Employee added to payroll successfully");
            },
          ),
        ],
      ),
    );
  }

  void _showPayrollDetails(Map<String, dynamic> record) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Payroll Details"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "${record["employee"]} (${record["employeeId"]})",
                style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold),
              ),
              Text("${record["department"]} • ${record["position"]}"),
              Divider(),
              _buildDetailRow("Regular Hours", "${record["regularHours"]}h"),
              _buildDetailRow("Overtime Hours", "${record["overtimeHours"]}h"),
              _buildDetailRow("Base Pay", "\$${((record["basePay"] as double)).currency}"),
              _buildDetailRow("Overtime Pay", "\$${((record["overtimePay"] as double)).currency}"),
              _buildDetailRow("Bonus", "\$${((record["bonus"] as double)).currency}"),
              _buildDetailRow("Deductions", "\$${((record["deductions"] as double)).currency}"),
              Divider(),
              _buildDetailRow("Net Pay", "\$${((record["netPay"] as double)).currency}", isTotal: true),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          QButton(
            label: "Generate Payslip",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Payslip generated successfully");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? primaryColor : disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal ? primaryColor : primaryColor,
          ),
        ),
      ],
    );
  }

  void _showEditPayrollDialog(Map<String, dynamic> record) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Payroll Record"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spMd,
            children: [
              Text(
                "Editing payroll for ${record["employee"]}",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QNumberField(
                      label: "Regular Hours",
                      value: record["regularHours"].toString(),
                      onChanged: (value) {},
                    ),
                  ),
                  Expanded(
                    child: QNumberField(
                      label: "Overtime Hours",
                      value: record["overtimeHours"].toString(),
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QNumberField(
                      label: "Bonus (\$)",
                      value: (record["bonus"] as double).toString(),
                      onChanged: (value) {},
                    ),
                  ),
                  Expanded(
                    child: QNumberField(
                      label: "Deductions (\$)",
                      value: (record["deductions"] as double).toString(),
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Update Record",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Payroll record updated successfully");
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Payroll System",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Payroll Records", icon: Icon(Icons.receipt_long)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildManagementTab(),
      ],
      onInit: (tabController) {},
    );
  }
}
