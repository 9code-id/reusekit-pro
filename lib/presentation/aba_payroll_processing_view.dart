import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaPayrollProcessingView extends StatefulWidget {
  const AbaPayrollProcessingView({super.key});

  @override
  State<AbaPayrollProcessingView> createState() => _AbaPayrollProcessingViewState();
}

class _AbaPayrollProcessingViewState extends State<AbaPayrollProcessingView> {
  String selectedPeriod = "January 2024";
  String selectedDepartment = "All";
  bool loading = false;
  int currentStep = 0;

  List<Map<String, dynamic>> periodItems = [
    {"label": "January 2024", "value": "January 2024"},
    {"label": "February 2024", "value": "February 2024"},
    {"label": "March 2024", "value": "March 2024"},
    {"label": "April 2024", "value": "April 2024"},
  ];

  List<Map<String, dynamic>> departmentItems = [
    {"label": "All", "value": "All"},
    {"label": "Engineering", "value": "Engineering"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Sales", "value": "Sales"},
    {"label": "HR", "value": "HR"},
    {"label": "Finance", "value": "Finance"},
  ];

  List<Map<String, dynamic>> employeePayroll = [
    {
      "employee_id": "EMP001",
      "name": "John Smith",
      "department": "Engineering",
      "position": "Senior Developer",
      "base_salary": 8500.00,
      "overtime_hours": 8.0,
      "overtime_rate": 63.75,
      "overtime_pay": 510.00,
      "bonus": 500.00,
      "commission": 0.00,
      "gross_pay": 9510.00,
      "tax_deduction": 1902.00,
      "insurance": 250.00,
      "retirement": 285.30,
      "other_deductions": 120.00,
      "total_deductions": 2557.30,
      "net_pay": 6952.70,
      "status": "Approved",
    },
    {
      "employee_id": "EMP002",
      "name": "Sarah Johnson",
      "department": "Engineering",
      "position": "Engineering Manager",
      "base_salary": 12000.00,
      "overtime_hours": 4.0,
      "overtime_rate": 90.00,
      "overtime_pay": 360.00,
      "bonus": 1000.00,
      "commission": 0.00,
      "gross_pay": 13360.00,
      "tax_deduction": 2672.00,
      "insurance": 300.00,
      "retirement": 400.80,
      "other_deductions": 150.00,
      "total_deductions": 3522.80,
      "net_pay": 9837.20,
      "status": "Pending",
    },
    {
      "employee_id": "EMP003",
      "name": "Mike Chen",
      "department": "Sales",
      "position": "Sales Director",
      "base_salary": 10000.00,
      "overtime_hours": 0.0,
      "overtime_rate": 0.00,
      "overtime_pay": 0.00,
      "bonus": 2500.00,
      "commission": 3200.00,
      "gross_pay": 15700.00,
      "tax_deduction": 3140.00,
      "insurance": 350.00,
      "retirement": 471.00,
      "other_deductions": 200.00,
      "total_deductions": 4161.00,
      "net_pay": 11539.00,
      "status": "Approved",
    },
    {
      "employee_id": "EMP004",
      "name": "Lisa Wong",
      "department": "HR",
      "position": "HR Specialist",
      "base_salary": 5800.00,
      "overtime_hours": 2.0,
      "overtime_rate": 43.50,
      "overtime_pay": 87.00,
      "bonus": 200.00,
      "commission": 0.00,
      "gross_pay": 6087.00,
      "tax_deduction": 1217.40,
      "insurance": 200.00,
      "retirement": 182.61,
      "other_deductions": 80.00,
      "total_deductions": 1680.01,
      "net_pay": 4406.99,
      "status": "Hold",
    },
  ];

  List<Map<String, dynamic>> processingSteps = [
    {
      "title": "Setup Payroll",
      "description": "Configure payroll period and departments",
      "completed": true,
    },
    {
      "title": "Import Timesheet",
      "description": "Import employee hours and attendance data",
      "completed": true,
    },
    {
      "title": "Calculate Pay",
      "description": "Calculate gross pay, taxes, and deductions",
      "completed": false,
    },
    {
      "title": "Review & Approve",
      "description": "Review calculations and approve payroll",
      "completed": false,
    },
    {
      "title": "Process Payment",
      "description": "Generate pay slips and process payments",
      "completed": false,
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return warningColor;
      case "Approved":
        return successColor;
      case "Hold":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildProcessingStepper() {
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
          Text(
            "Processing Steps",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: processingSteps.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> step = entry.value;
              bool isActive = index == currentStep;
              bool isCompleted = step["completed"];
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isCompleted 
                            ? successColor 
                            : isActive 
                                ? primaryColor 
                                : disabledColor,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        isCompleted ? Icons.check : Icons.radio_button_unchecked,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${step["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isActive ? primaryColor : disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${step["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildPayrollSummary() {
    double totalGross = employeePayroll.fold(0.0, (sum, emp) => sum + (emp["gross_pay"] as double));
    double totalDeductions = employeePayroll.fold(0.0, (sum, emp) => sum + (emp["total_deductions"] as double));
    double totalNet = employeePayroll.fold(0.0, (sum, emp) => sum + (emp["net_pay"] as double));
    
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
          Text(
            "Payroll Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem("Employees", "${employeePayroll.length}", primaryColor),
              ),
              Expanded(
                child: _buildSummaryItem("Gross Pay", "\$${(totalGross / 1000).toStringAsFixed(1)}K", successColor),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem("Deductions", "\$${(totalDeductions / 1000).toStringAsFixed(1)}K", dangerColor),
              ),
              Expanded(
                child: _buildSummaryItem("Net Pay", "\$${(totalNet / 1000).toStringAsFixed(1)}K", infoColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(right: spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSetupSection() {
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
          Text(
            "Payroll Configuration",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Pay Period",
                  items: periodItems,
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
                  items: departmentItems,
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
    );
  }

  Widget _buildEmployeePayrollCard(Map<String, dynamic> employee) {
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
            color: _getStatusColor(employee["status"]),
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
                      "${employee["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${employee["position"]} • ${employee["department"]}",
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
                  color: _getStatusColor(employee["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: _getStatusColor(employee["status"]).withAlpha(100),
                  ),
                ),
                child: Text(
                  "${employee["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(employee["status"]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Base Salary",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${(employee["base_salary"] as double).toStringAsFixed(2)}",
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
                        children: [
                          Text(
                            "Overtime",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${(employee["overtime_pay"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
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
                            "Bonus",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${(employee["bonus"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Gross Pay",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${(employee["gross_pay"] as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 16,
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
                          children: [
                            Text(
                              "Deductions",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${(employee["total_deductions"] as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
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
                              "Net Pay",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${(employee["net_pay"] as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Text(
                "OT Hours: ${(employee["overtime_hours"] as double).toStringAsFixed(1)}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "ID: ${employee["employee_id"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
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
              if (employee["status"] == "Pending") ...[
                Expanded(
                  child: QButton(
                    label: "Approve",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
              ],
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payroll Processing"),
        actions: [
          QButton(
            icon: Icons.save,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProcessingStepper(),
                  SizedBox(height: spMd),
                  _buildSetupSection(),
                  SizedBox(height: spMd),
                  _buildPayrollSummary(),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Import Timesheet",
                          size: bs.md,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Calculate All",
                          size: bs.md,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Employee Payroll Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...employeePayroll.map((employee) => _buildEmployeePayrollCard(employee)).toList(),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Save Draft",
                          size: bs.md,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Submit for Approval",
                          size: bs.md,
                          onPressed: () {},
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
