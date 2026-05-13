import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaPayrollSystemView extends StatefulWidget {
  const HhaPayrollSystemView({super.key});

  @override
  State<HhaPayrollSystemView> createState() => _HhaPayrollSystemViewState();
}

class _HhaPayrollSystemViewState extends State<HhaPayrollSystemView> {
  int currentTab = 0;
  String searchQuery = "";
  String departmentFilter = "all";
  String statusFilter = "all";
  String selectedPeriod = "current";

  List<Map<String, dynamic>> payrollData = [
    {
      "id": "PR001",
      "employeeId": "EMP001",
      "employeeName": "John Smith",
      "department": "front_desk",
      "position": "Receptionist",
      "payPeriod": "2024-01-01 to 2024-01-15",
      "basicSalary": 2400.00,
      "hourlyRate": 18.50,
      "hoursWorked": 80.0,
      "overtimeHours": 5.0,
      "overtimePay": 138.75,
      "grossPay": 2538.75,
      "socialSecurity": 157.40,
      "medicare": 36.81,
      "federalTax": 380.81,
      "stateTax": 152.33,
      "healthInsurance": 125.00,
      "retirement": 76.16,
      "totalDeductions": 928.51,
      "netPay": 1610.24,
      "status": "processed",
      "payDate": "2024-01-16",
      "bonus": 0.00,
      "allowances": 150.00,
    },
    {
      "id": "PR002",
      "employeeId": "EMP002",
      "employeeName": "Sarah Johnson",
      "department": "housekeeping",
      "position": "Housekeeper",
      "payPeriod": "2024-01-01 to 2024-01-15",
      "basicSalary": 2200.00,
      "hourlyRate": 16.00,
      "hoursWorked": 75.0,
      "overtimeHours": 8.0,
      "overtimePay": 192.00,
      "grossPay": 2392.00,
      "socialSecurity": 148.30,
      "medicare": 34.68,
      "federalTax": 358.80,
      "stateTax": 143.52,
      "healthInsurance": 100.00,
      "retirement": 71.76,
      "totalDeductions": 857.06,
      "netPay": 1534.94,
      "status": "pending",
      "payDate": "2024-01-16",
      "bonus": 200.00,
      "allowances": 100.00,
    },
    {
      "id": "PR003",
      "employeeId": "EMP003",
      "employeeName": "Maria Garcia",
      "department": "kitchen",
      "position": "Chef",
      "payPeriod": "2024-01-01 to 2024-01-15",
      "basicSalary": 3200.00,
      "hourlyRate": 22.00,
      "hoursWorked": 85.0,
      "overtimeHours": 10.0,
      "overtimePay": 330.00,
      "grossPay": 3530.00,
      "socialSecurity": 218.86,
      "medicare": 51.19,
      "federalTax": 529.50,
      "stateTax": 211.80,
      "healthInsurance": 150.00,
      "retirement": 105.90,
      "totalDeductions": 1267.25,
      "netPay": 2262.75,
      "status": "processed",
      "payDate": "2024-01-16",
      "bonus": 500.00,
      "allowances": 200.00,
    },
    {
      "id": "PR004",
      "employeeId": "EMP004",
      "employeeName": "Mike Johnson",
      "department": "security",
      "position": "Security Guard",
      "payPeriod": "2024-01-01 to 2024-01-15",
      "basicSalary": 2600.00,
      "hourlyRate": 20.00,
      "hoursWorked": 88.0,
      "overtimeHours": 8.0,
      "overtimePay": 240.00,
      "grossPay": 2840.00,
      "socialSecurity": 176.08,
      "medicare": 41.18,
      "federalTax": 426.00,
      "stateTax": 170.40,
      "healthInsurance": 125.00,
      "retirement": 85.20,
      "totalDeductions": 1023.86,
      "netPay": 1816.14,
      "status": "approved",
      "payDate": "2024-01-16",
      "bonus": 100.00,
      "allowances": 75.00,
    },
  ];

  List<Map<String, dynamic>> employeeList = [
    {"id": "EMP001", "name": "John Smith", "department": "front_desk", "position": "Receptionist", "salary": 2400.00, "hourlyRate": 18.50},
    {"id": "EMP002", "name": "Sarah Johnson", "department": "housekeeping", "position": "Housekeeper", "salary": 2200.00, "hourlyRate": 16.00},
    {"id": "EMP003", "name": "Maria Garcia", "department": "kitchen", "position": "Chef", "salary": 3200.00, "hourlyRate": 22.00},
    {"id": "EMP004", "name": "Mike Johnson", "department": "security", "position": "Security Guard", "salary": 2600.00, "hourlyRate": 20.00},
    {"id": "EMP005", "name": "David Wilson", "department": "maintenance", "position": "Maintenance Tech", "salary": 2800.00, "hourlyRate": 25.00},
  ];

  List<Map<String, dynamic>> departmentItems = [
    {"label": "All Departments", "value": "all"},
    {"label": "Front Desk", "value": "front_desk"},
    {"label": "Housekeeping", "value": "housekeeping"},
    {"label": "Kitchen", "value": "kitchen"},
    {"label": "Security", "value": "security"},
    {"label": "Maintenance", "value": "maintenance"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "all"},
    {"label": "Pending", "value": "pending"},
    {"label": "Approved", "value": "approved"},
    {"label": "Processed", "value": "processed"},
    {"label": "Paid", "value": "paid"},
  ];

  List<Map<String, dynamic>> periodItems = [
    {"label": "Current Period", "value": "current"},
    {"label": "Previous Period", "value": "previous"},
    {"label": "Last Month", "value": "last_month"},
    {"label": "Last Quarter", "value": "last_quarter"},
  ];

  // Payroll calculation form fields
  String selectedEmployeeId = "";
  double hoursWorked = 0.0;
  double overtimeHours = 0.0;
  double bonusAmount = 0.0;
  double allowanceAmount = 0.0;
  double deductionAmount = 0.0;
  String deductionReason = "";

  List<Map<String, dynamic>> get filteredPayroll {
    return payrollData.where((payroll) {
      bool matchesSearch = payroll["employeeName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          payroll["employeeId"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          payroll["position"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesDepartment = departmentFilter == "all" || payroll["department"] == departmentFilter;
      bool matchesStatus = statusFilter == "all" || payroll["status"] == statusFilter;
      return matchesSearch && matchesDepartment && matchesStatus;
    }).toList();
  }

  double get totalGrossPay {
    return filteredPayroll.fold(0.0, (sum, payroll) => sum + (payroll["grossPay"] as double));
  }

  double get totalNetPay {
    return filteredPayroll.fold(0.0, (sum, payroll) => sum + (payroll["netPay"] as double));
  }

  double get totalDeductions {
    return filteredPayroll.fold(0.0, (sum, payroll) => sum + (payroll["totalDeductions"] as double));
  }

  double get totalOvertimePay {
    return filteredPayroll.fold(0.0, (sum, payroll) => sum + (payroll["overtimePay"] as double));
  }

  int get pendingPayrolls => filteredPayroll.where((p) => p["status"] == "pending").length;
  int get processedPayrolls => filteredPayroll.where((p) => p["status"] == "processed").length;

  void _calculatePayroll() {
    if (selectedEmployeeId.isNotEmpty && hoursWorked > 0) {
      final employee = employeeList.firstWhere((emp) => emp["id"] == selectedEmployeeId);
      
      // Calculate basic pay
      double regularHours = hoursWorked > 40 ? 40 : hoursWorked;
      double calculatedOvertimeHours = hoursWorked > 40 ? hoursWorked - 40 : 0.0;
      calculatedOvertimeHours += overtimeHours;
      
      double basicPay = regularHours * (employee["hourlyRate"] as double);
      double overtimePayAmount = calculatedOvertimeHours * (employee["hourlyRate"] as double) * 1.5;
      double grossPay = basicPay + overtimePayAmount + bonusAmount + allowanceAmount;
      
      // Calculate deductions (simplified)
      double socialSecurity = grossPay * 0.062;
      double medicare = grossPay * 0.0145;
      double federalTax = grossPay * 0.15;
      double stateTax = grossPay * 0.06;
      double healthInsurance = 125.00;
      double retirement = grossPay * 0.03;
      
      double totalDeductionsAmount = socialSecurity + medicare + federalTax + stateTax + 
          healthInsurance + retirement + deductionAmount;
      
      double netPay = grossPay - totalDeductionsAmount;
      
      final newPayroll = {
        "id": "PR${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}",
        "employeeId": selectedEmployeeId,
        "employeeName": employee["name"],
        "department": employee["department"],
        "position": employee["position"],
        "payPeriod": "${DateTime.now().toString().split(' ')[0]} to ${DateTime.now().add(Duration(days: 14)).toString().split(' ')[0]}",
        "basicSalary": employee["salary"],
        "hourlyRate": employee["hourlyRate"],
        "hoursWorked": hoursWorked,
        "overtimeHours": calculatedOvertimeHours,
        "overtimePay": overtimePayAmount,
        "grossPay": grossPay,
        "socialSecurity": socialSecurity,
        "medicare": medicare,
        "federalTax": federalTax,
        "stateTax": stateTax,
        "healthInsurance": healthInsurance,
        "retirement": retirement,
        "totalDeductions": totalDeductionsAmount,
        "netPay": netPay,
        "status": "pending",
        "payDate": DateTime.now().add(Duration(days: 2)).toString().split(' ')[0],
        "bonus": bonusAmount,
        "allowances": allowanceAmount,
      };

      payrollData.add(newPayroll);
      
      // Reset form
      selectedEmployeeId = "";
      hoursWorked = 0.0;
      overtimeHours = 0.0;
      bonusAmount = 0.0;
      allowanceAmount = 0.0;
      deductionAmount = 0.0;
      deductionReason = "";
      
      setState(() {});
      ss("Payroll calculated successfully");
    }
  }

  void _approvePayroll(String payrollId) {
    final index = payrollData.indexWhere((p) => p["id"] == payrollId);
    if (index != -1) {
      payrollData[index]["status"] = "approved";
      setState(() {});
      ss("Payroll approved");
    }
  }

  void _processPayroll(String payrollId) {
    final index = payrollData.indexWhere((p) => p["id"] == payrollId);
    if (index != -1) {
      payrollData[index]["status"] = "processed";
      setState(() {});
      ss("Payroll processed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Payroll System",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Payroll Overview", icon: Icon(Icons.receipt_long)),
        Tab(text: "Calculate Payroll", icon: Icon(Icons.calculate)),
        Tab(text: "Reports", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildPayrollOverviewTab(),
        _buildCalculatePayrollTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildPayrollOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Gross Pay",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${totalGrossPay.currency}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
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
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Net Pay",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${totalNetPay.currency}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Deductions",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${totalDeductions.currency}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
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
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Overtime Pay",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${totalOvertimePay.currency}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Filters
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search employees...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Department",
                  items: departmentItems,
                  value: departmentFilter,
                  onChanged: (value, label) {
                    departmentFilter = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusItems,
                  value: statusFilter,
                  onChanged: (value, label) {
                    statusFilter = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Status Summary
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: warningColor),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$pendingPayrolls",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Pending",
                        style: TextStyle(
                          fontSize: 14,
                          color: warningColor,
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
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: successColor),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$processedPayrolls",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Processed",
                        style: TextStyle(
                          fontSize: 14,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Payroll List
          Text(
            "Payroll Records (${filteredPayroll.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: filteredPayroll.length,
            itemBuilder: (context, index) {
              final payroll = filteredPayroll[index];
              Color statusColor = payroll["status"] == "processed" ? successColor :
                  payroll["status"] == "approved" ? infoColor :
                  payroll["status"] == "pending" ? warningColor : dangerColor;

              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: statusColor,
                    ),
                  ),
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
                                "${payroll["employeeName"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${payroll["position"]} • ${payroll["department"]}".replaceAll('_', ' ').toUpperCase(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Period: ${payroll["payPeriod"]}",
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
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: statusColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${payroll["status"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Pay Date: ${payroll["payDate"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Pay Details
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text("Hours Worked:", style: TextStyle(fontSize: 12, color: disabledBoldColor))),
                              Text("${(payroll["hoursWorked"] as double).toStringAsFixed(1)}h", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                            ],
                          ),
                          if ((payroll["overtimeHours"] as double) > 0)
                            Row(
                              children: [
                                Expanded(child: Text("Overtime Hours:", style: TextStyle(fontSize: 12, color: disabledBoldColor))),
                                Text("${(payroll["overtimeHours"] as double).toStringAsFixed(1)}h", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: warningColor)),
                              ],
                            ),
                          Row(
                            children: [
                              Expanded(child: Text("Gross Pay:", style: TextStyle(fontSize: 12, color: disabledBoldColor))),
                              Text("\$${(payroll["grossPay"] as double).currency}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: Text("Total Deductions:", style: TextStyle(fontSize: 12, color: disabledBoldColor))),
                              Text("\$${(payroll["totalDeductions"] as double).currency}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: dangerColor)),
                            ],
                          ),
                          Divider(height: 1),
                          Row(
                            children: [
                              Expanded(child: Text("Net Pay:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
                              Text("\$${(payroll["netPay"] as double).currency}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: successColor)),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Action Buttons
                    if (payroll["status"] == "pending")
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Approve",
                              size: bs.sm,
                              onPressed: () => _approvePayroll(payroll["id"]),
                            ),
                          ),
                        ],
                      ),
                    
                    if (payroll["status"] == "approved")
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Process Payment",
                              size: bs.sm,
                              onPressed: () => _processPayroll(payroll["id"]),
                            ),
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
    );
  }

  Widget _buildCalculatePayrollTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Calculate Payroll",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
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
                  "Employee Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                QDropdownField(
                  label: "Select Employee",
                  items: employeeList.map((emp) => {
                    "label": "${emp["name"]} - ${emp["position"]} (\$${(emp["hourlyRate"] as double).currency}/hr)",
                    "value": emp["id"],
                  }).toList(),
                  value: selectedEmployeeId.isNotEmpty ? selectedEmployeeId : employeeList.first["id"],
                  onChanged: (value, label) {
                    selectedEmployeeId = value;
                    setState(() {});
                  },
                ),

                if (selectedEmployeeId.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "Employee Details",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(child: Text("Base Salary:", style: TextStyle(fontSize: 12, color: disabledBoldColor))),
                            Text("\$${(employeeList.firstWhere((e) => e["id"] == selectedEmployeeId)["salary"] as double).currency}/month", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: Text("Hourly Rate:", style: TextStyle(fontSize: 12, color: disabledBoldColor))),
                            Text("\$${(employeeList.firstWhere((e) => e["id"] == selectedEmployeeId)["hourlyRate"] as double).currency}/hr", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
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
                  "Time & Earnings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Hours Worked",
                        value: hoursWorked.toString(),
                        onChanged: (value) {
                          hoursWorked = double.tryParse(value) ?? 0.0;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Additional Overtime",
                        value: overtimeHours.toString(),
                        onChanged: (value) {
                          overtimeHours = double.tryParse(value) ?? 0.0;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Bonus Amount (\$)",
                        value: bonusAmount.toString(),
                        onChanged: (value) {
                          bonusAmount = double.tryParse(value) ?? 0.0;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Allowances (\$)",
                        value: allowanceAmount.toString(),
                        onChanged: (value) {
                          allowanceAmount = double.tryParse(value) ?? 0.0;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Additional Deduction (\$)",
                        value: deductionAmount.toString(),
                        onChanged: (value) {
                          deductionAmount = double.tryParse(value) ?? 0.0;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: "Deduction Reason",
                        value: deductionReason,
                        onChanged: (value) {
                          deductionReason = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Payroll Preview
          if (selectedEmployeeId.isNotEmpty && hoursWorked > 0)
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border.all(color: primaryColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Payroll Preview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text("Regular Hours:", style: TextStyle(fontSize: 12, color: disabledBoldColor))),
                          Text("${(hoursWorked > 40 ? 40 : hoursWorked).toStringAsFixed(1)}h", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                        ],
                      ),
                      if (hoursWorked > 40 || overtimeHours > 0)
                        Row(
                          children: [
                            Expanded(child: Text("Overtime Hours:", style: TextStyle(fontSize: 12, color: disabledBoldColor))),
                            Text("${((hoursWorked > 40 ? hoursWorked - 40 : 0) + overtimeHours).toStringAsFixed(1)}h", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: warningColor)),
                          ],
                        ),
                      if (bonusAmount > 0)
                        Row(
                          children: [
                            Expanded(child: Text("Bonus:", style: TextStyle(fontSize: 12, color: disabledBoldColor))),
                            Text("\$${bonusAmount.currency}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: successColor)),
                          ],
                        ),
                      if (allowanceAmount > 0)
                        Row(
                          children: [
                            Expanded(child: Text("Allowances:", style: TextStyle(fontSize: 12, color: disabledBoldColor))),
                            Text("\$${allowanceAmount.currency}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: successColor)),
                          ],
                        ),
                      if (deductionAmount > 0)
                        Row(
                          children: [
                            Expanded(child: Text("Additional Deduction:", style: TextStyle(fontSize: 12, color: disabledBoldColor))),
                            Text("\$${deductionAmount.currency}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: dangerColor)),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),

          Container(
            width: double.infinity,
            child: QButton(
              label: "Calculate & Save Payroll",
              size: bs.md,
              onPressed: _calculatePayroll,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Payroll Reports",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Period Selection
          QDropdownField(
            label: "Report Period",
            items: periodItems,
            value: selectedPeriod,
            onChanged: (value, label) {
              selectedPeriod = value;
              setState(() {});
            },
          ),

          // Summary Report
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
                  "Payroll Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Total Employees",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${payrollData.length}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: disabledOutlineBorderColor,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Total Payroll",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "\$${totalGrossPay.currency}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: disabledOutlineBorderColor,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Net Payout",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "\$${totalNetPay.currency}",
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
              ],
            ),
          ),

          // Department Breakdown
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
                  "Department Payroll Breakdown",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    final departments = ["front_desk", "housekeeping", "kitchen", "security", "maintenance"];
                    final colors = [primaryColor, successColor, warningColor, infoColor, dangerColor];
                    final amounts = [2538.75, 2392.00, 3530.00, 2840.00, 2100.00];
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: colors[index].withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: colors[index],
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Text(
                              departments[index].replaceAll('_', ' ').toUpperCase(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            "\$${amounts[index].currency}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: colors[index],
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

          // Tax Summary
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
                  "Tax & Deduction Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text("Federal Tax:", style: TextStyle(fontSize: 14, color: disabledBoldColor))),
                        Text("\$1,695.11", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: dangerColor)),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text("State Tax:", style: TextStyle(fontSize: 14, color: disabledBoldColor))),
                        Text("\$678.05", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: dangerColor)),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text("Social Security:", style: TextStyle(fontSize: 14, color: disabledBoldColor))),
                        Text("\$700.64", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: dangerColor)),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text("Medicare:", style: TextStyle(fontSize: 14, color: disabledBoldColor))),
                        Text("\$163.86", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: dangerColor)),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text("Health Insurance:", style: TextStyle(fontSize: 14, color: disabledBoldColor))),
                        Text("\$500.00", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: dangerColor)),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text("Retirement:", style: TextStyle(fontSize: 14, color: disabledBoldColor))),
                        Text("\$339.02", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: dangerColor)),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(child: Text("Total Deductions:", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold))),
                        Text("\$${totalDeductions.currency}", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold, color: dangerColor)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Export Options
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Export Reports",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Export PDF",
                        size: bs.sm,
                        onPressed: () {
                          ss("Payroll report exported as PDF");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Export Excel",
                        size: bs.sm,
                        onPressed: () {
                          ss("Payroll report exported as Excel");
                        },
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
