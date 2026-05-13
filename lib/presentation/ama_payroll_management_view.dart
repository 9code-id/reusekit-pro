import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaPayrollManagementView extends StatefulWidget {
  const AmaPayrollManagementView({super.key});

  @override
  State<AmaPayrollManagementView> createState() => _AmaPayrollManagementViewState();
}

class _AmaPayrollManagementViewState extends State<AmaPayrollManagementView> {
  int selectedTab = 0;
  String selectedPeriod = "December 2024";
  String selectedStatus = "All";
  
  List<Map<String, dynamic>> employees = [
    {
      "id": 1,
      "name": "Maria Santos",
      "employee_id": "EMP001",
      "position": "Farm Manager",
      "department": "Operations",
      "hire_date": "2022-03-15",
      "base_salary": 3500.00,
      "overtime_hours": 12.5,
      "overtime_rate": 25.00,
      "bonus": 200.00,
      "deductions": 350.00,
      "net_pay": 3662.50,
      "status": "active",
      "payroll_status": "processed",
      "avatar": "https://picsum.photos/60/60?random=1&keyword=woman",
      "work_days": 22,
      "sick_days": 1,
      "vacation_days": 0,
    },
    {
      "id": 2,
      "name": "Carlos Rodriguez",
      "employee_id": "EMP002",
      "position": "Field Supervisor",
      "department": "Field Operations",
      "hire_date": "2021-08-10",
      "base_salary": 2800.00,
      "overtime_hours": 18.0,
      "overtime_rate": 20.00,
      "bonus": 150.00,
      "deductions": 280.00,
      "net_pay": 3030.00,
      "status": "active",
      "payroll_status": "pending",
      "avatar": "https://picsum.photos/60/60?random=2&keyword=man",
      "work_days": 23,
      "sick_days": 0,
      "vacation_days": 0,
    },
    {
      "id": 3,
      "name": "Ana Martinez",
      "employee_id": "EMP003",
      "position": "Equipment Operator",
      "department": "Machinery",
      "hire_date": "2023-01-20",
      "base_salary": 2400.00,
      "overtime_hours": 8.0,
      "overtime_rate": 18.00,
      "bonus": 100.00,
      "deductions": 240.00,
      "net_pay": 2404.00,
      "status": "active",
      "payroll_status": "processed",
      "avatar": "https://picsum.photos/60/60?random=3&keyword=woman",
      "work_days": 21,
      "sick_days": 2,
      "vacation_days": 0,
    },
    {
      "id": 4,
      "name": "Diego Lopez",
      "employee_id": "EMP004",
      "position": "Harvest Worker",
      "department": "Harvesting",
      "hire_date": "2023-06-01",
      "base_salary": 2200.00,
      "overtime_hours": 15.5,
      "overtime_rate": 16.50,
      "bonus": 75.00,
      "deductions": 220.00,
      "net_pay": 2310.75,
      "status": "active",
      "payroll_status": "pending",
      "avatar": "https://picsum.photos/60/60?random=4&keyword=man",
      "work_days": 24,
      "sick_days": 0,
      "vacation_days": 1,
    },
  ];

  List<Map<String, dynamic>> payrollSummary = [
    {
      "period": "December 2024",
      "total_employees": 4,
      "total_base_salary": 10900.00,
      "total_overtime": 1695.75,
      "total_bonuses": 525.00,
      "total_deductions": 1090.00,
      "total_net_pay": 12030.75,
      "processed": 2,
      "pending": 2,
      "status": "in_progress",
    },
  ];

  List<Map<String, dynamic>> payrollHistory = [
    {
      "period": "November 2024",
      "total_employees": 4,
      "total_net_pay": 11850.00,
      "status": "completed",
      "processed_date": "2024-11-30",
    },
    {
      "period": "October 2024",
      "total_employees": 4,
      "total_net_pay": 12200.50,
      "status": "completed",
      "processed_date": "2024-10-31",
    },
    {
      "period": "September 2024",
      "total_employees": 3,
      "total_net_pay": 9150.75,
      "status": "completed",
      "processed_date": "2024-09-30",
    },
  ];

  List<Map<String, dynamic>> get filteredEmployees {
    return employees.where((employee) {
      bool matchesStatus = selectedStatus == "All" || employee["payroll_status"] == selectedStatus;
      return matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payroll Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Period & Filter Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Pay Period",
                        items: [
                          {"label": "December 2024", "value": "December 2024"},
                          {"label": "November 2024", "value": "November 2024"},
                          {"label": "October 2024", "value": "October 2024"},
                        ],
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
                        label: "Status",
                        items: [
                          {"label": "All Status", "value": "All"},
                          {"label": "Processed", "value": "processed"},
                          {"label": "Pending", "value": "pending"},
                        ],
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
            ),
          ),

          // Main Content
          Expanded(
            child: QTabBar(
              withoutAppBar: true,
              selectedIndex: selectedTab,
              tabs: [
                Tab(text: "Overview", icon: Icon(Icons.dashboard)),
                Tab(text: "Employees", icon: Icon(Icons.people)),
                Tab(text: "History", icon: Icon(Icons.history)),
              ],
              tabChildren: [
                // Overview Tab
                SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    spacing: spMd,
                    children: [
                      // Current Period Summary
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [primaryColor.withAlpha(25), secondaryColor.withAlpha(25)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Text(
                              "Payroll Summary - $selectedPeriod",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildSummaryCard(
                                    "Total Employees",
                                    "${payrollSummary[0]["total_employees"]}",
                                    Icons.people,
                                    primaryColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: _buildSummaryCard(
                                    "Processed",
                                    "${payrollSummary[0]["processed"]}",
                                    Icons.check_circle,
                                    successColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: _buildSummaryCard(
                                    "Pending",
                                    "${payrollSummary[0]["pending"]}",
                                    Icons.pending,
                                    warningColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Financial Summary
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowMd],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spMd,
                          children: [
                            Text(
                              "Financial Breakdown",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            
                            _buildFinancialRow(
                              "Base Salaries",
                              payrollSummary[0]["total_base_salary"],
                              Icons.account_balance_wallet,
                              primaryColor,
                            ),
                            _buildFinancialRow(
                              "Overtime Pay",
                              payrollSummary[0]["total_overtime"],
                              Icons.schedule,
                              warningColor,
                            ),
                            _buildFinancialRow(
                              "Bonuses",
                              payrollSummary[0]["total_bonuses"],
                              Icons.card_giftcard,
                              successColor,
                            ),
                            _buildFinancialRow(
                              "Deductions",
                              payrollSummary[0]["total_deductions"],
                              Icons.remove_circle,
                              dangerColor,
                            ),
                            
                            Divider(),
                            
                            _buildFinancialRow(
                              "Total Net Pay",
                              payrollSummary[0]["total_net_pay"],
                              Icons.payments,
                              primaryColor,
                              isTotal: true,
                            ),
                          ],
                        ),
                      ),

                      // Quick Actions
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
                                    label: "Process Payroll",
                                    icon: Icons.play_arrow,
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: QButton(
                                    label: "Generate Report",
                                    icon: Icons.description,
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "Export Data",
                                    icon: Icons.download,
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: QButton(
                                    label: "Send Payslips",
                                    icon: Icons.email,
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Department Overview
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
                              "Department Overview",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Column(
                              children: _getDepartmentSummary().map((dept) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: spSm),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(spSm),
                                        decoration: BoxDecoration(
                                          color: primaryColor.withAlpha(25),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Icon(
                                          _getDepartmentIcon(dept["name"]),
                                          color: primaryColor,
                                          size: 20,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${dept["name"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            Text(
                                              "${dept["employees"]} employees",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "\$${((dept["total_pay"] as double)).currency}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
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
                    ],
                  ),
                ),

                // Employees Tab
                SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    spacing: spMd,
                    children: [
                      // Employee List
                      Column(
                        spacing: spMd,
                        children: filteredEmployees.map((employee) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusMd),
                              boxShadow: [shadowMd],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(spMd),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spSm,
                                children: [
                                  // Employee Header
                                  Row(
                                    children: [
                                      ClipOval(
                                        child: Image.network(
                                          "${employee["avatar"]}",
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${employee["name"]}",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                            Text(
                                              "${employee["position"]} • ${employee["employee_id"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${employee["department"]}",
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
                                          color: _getPayrollStatusColor(employee["payroll_status"]),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "${employee["payroll_status"]}".toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Salary Breakdown
                                  Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(25),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Column(
                                      spacing: spXs,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: _buildPayrollItem(
                                                "Base Salary",
                                                "\$${((employee["base_salary"] as double)).currency}",
                                              ),
                                            ),
                                            Expanded(
                                              child: _buildPayrollItem(
                                                "Overtime",
                                                "\$${(((employee["overtime_hours"] as double) * (employee["overtime_rate"] as double))).currency}",
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: _buildPayrollItem(
                                                "Bonus",
                                                "\$${((employee["bonus"] as double)).currency}",
                                              ),
                                            ),
                                            Expanded(
                                              child: _buildPayrollItem(
                                                "Deductions",
                                                "-\$${((employee["deductions"] as double)).currency}",
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(height: 1),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: _buildPayrollItem(
                                                "Net Pay",
                                                "\$${((employee["net_pay"] as double)).currency}",
                                                isTotal: true,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Work Summary
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildWorkSummary(
                                          Icons.work,
                                          "Work Days",
                                          "${employee["work_days"]}",
                                        ),
                                      ),
                                      Expanded(
                                        child: _buildWorkSummary(
                                          Icons.schedule,
                                          "Overtime",
                                          "${employee["overtime_hours"]}h",
                                        ),
                                      ),
                                      Expanded(
                                        child: _buildWorkSummary(
                                          Icons.sick,
                                          "Sick Days",
                                          "${employee["sick_days"]}",
                                        ),
                                      ),
                                      Expanded(
                                        child: _buildWorkSummary(
                                          Icons.beach_access,
                                          "Vacation",
                                          "${employee["vacation_days"]}",
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Action Buttons
                                  Row(
                                    children: [
                                      Expanded(
                                        child: QButton(
                                          label: "View Details",
                                          size: bs.sm,
                                          onPressed: () {},
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      QButton(
                                        icon: Icons.receipt,
                                        size: bs.sm,
                                        onPressed: () {},
                                      ),
                                      SizedBox(width: spXs),
                                      QButton(
                                        icon: Icons.edit,
                                        size: bs.sm,
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                // History Tab
                SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    spacing: spMd,
                    children: [
                      Text(
                        "Payroll History",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),

                      Column(
                        spacing: spMd,
                        children: payrollHistory.map((history) {
                          return Container(
                            padding: EdgeInsets.all(spMd),
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
                                    color: successColor.withAlpha(25),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    Icons.check_circle,
                                    color: successColor,
                                    size: 24,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: spXs,
                                    children: [
                                      Text(
                                        "${history["period"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${history["total_employees"]} employees • Processed on ${history["processed_date"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "Total: \$${((history["total_net_pay"] as double)).currency}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: successColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                QButton(
                                  icon: Icons.download,
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialRow(String label, double amount, IconData icon, Color color, {bool isTotal = false}) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 16,
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? primaryColor : Colors.black87,
            ),
          ),
        ),
        Text(
          "\$${amount.currency}",
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildPayrollItem(String label, String value, {bool isTotal = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 14 : 12,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal ? primaryColor : Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildWorkSummary(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 16,
        ),
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
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Color _getPayrollStatusColor(String status) {
    switch (status) {
      case "processed": return successColor;
      case "pending": return warningColor;
      default: return disabledBoldColor;
    }
  }

  List<Map<String, dynamic>> _getDepartmentSummary() {
    Map<String, Map<String, dynamic>> deptMap = {};
    
    for (var employee in employees) {
      String dept = employee["department"];
      if (!deptMap.containsKey(dept)) {
        deptMap[dept] = {
          "name": dept,
          "employees": 0,
          "total_pay": 0.0,
        };
      }
      deptMap[dept]!["employees"] += 1;
      deptMap[dept]!["total_pay"] += employee["net_pay"];
    }
    
    return deptMap.values.toList();
  }

  IconData _getDepartmentIcon(String department) {
    switch (department.toLowerCase()) {
      case "operations": return Icons.settings;
      case "field operations": return Icons.agriculture;
      case "machinery": return Icons.precision_manufacturing;
      case "harvesting": return Icons.grass;
      default: return Icons.work;
    }
  }
}
