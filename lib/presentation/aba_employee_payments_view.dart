import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaEmployeePaymentsView extends StatefulWidget {
  const AbaEmployeePaymentsView({super.key});

  @override
  State<AbaEmployeePaymentsView> createState() => _AbaEmployeePaymentsViewState();
}

class _AbaEmployeePaymentsViewState extends State<AbaEmployeePaymentsView> {
  String selectedStatus = "all";
  String selectedDepartment = "all";
  String selectedPayPeriod = "current";
  String searchQuery = "";
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Processed", "value": "processed"},
    {"label": "Pending", "value": "pending"},
    {"label": "Failed", "value": "failed"},
    {"label": "On Hold", "value": "on_hold"},
  ];

  List<Map<String, dynamic>> departments = [
    {"label": "All Departments", "value": "all"},
    {"label": "Administration", "value": "admin"},
    {"label": "Sales", "value": "sales"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Operations", "value": "operations"},
    {"label": "IT", "value": "it"},
  ];

  List<Map<String, dynamic>> payPeriods = [
    {"label": "Current Period", "value": "current"},
    {"label": "Previous Period", "value": "previous"},
    {"label": "Last 3 Months", "value": "quarter"},
    {"label": "Year to Date", "value": "ytd"},
  ];

  List<Map<String, dynamic>> paymentStats = [
    {
      "title": "Total Payments",
      "value": 125,
      "amount": 285000.00,
      "icon": Icons.payment,
      "color": primaryColor,
    },
    {
      "title": "Processed",
      "value": 118,
      "amount": 267500.00,
      "icon": Icons.check_circle,
      "color": successColor,
    },
    {
      "title": "Pending",
      "value": 5,
      "amount": 12500.00,
      "icon": Icons.schedule,
      "color": warningColor,
    },
    {
      "title": "Failed",
      "value": 2,
      "amount": 5000.00,
      "icon": Icons.error,
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> employeePayments = [
    {
      "id": "EMP001",
      "name": "John Smith",
      "department": "Administration",
      "position": "Manager",
      "grossPay": 5200.00,
      "deductions": 1240.00,
      "netPay": 3960.00,
      "status": "processed",
      "payDate": "2024-03-15",
      "avatar": "https://picsum.photos/50/50?random=1&keyword=person",
    },
    {
      "id": "EMP002",
      "name": "Sarah Johnson",
      "department": "Sales",
      "position": "Sales Representative",
      "grossPay": 4800.00,
      "deductions": 1152.00,
      "netPay": 3648.00,
      "status": "processed",
      "payDate": "2024-03-15",
      "avatar": "https://picsum.photos/50/50?random=2&keyword=person",
    },
    {
      "id": "EMP003",
      "name": "Mike Davis",
      "department": "IT",
      "position": "Developer",
      "grossPay": 6200.00,
      "deductions": 1488.00,
      "netPay": 4712.00,
      "status": "pending",
      "payDate": "2024-03-15",
      "avatar": "https://picsum.photos/50/50?random=3&keyword=person",
    },
    {
      "id": "EMP004",
      "name": "Emily Wilson",
      "department": "Marketing",
      "position": "Marketing Specialist",
      "grossPay": 4500.00,
      "deductions": 1080.00,
      "netPay": 3420.00,
      "status": "processed",
      "payDate": "2024-03-15",
      "avatar": "https://picsum.photos/50/50?random=4&keyword=person",
    },
    {
      "id": "EMP005",
      "name": "David Brown",
      "department": "Operations",
      "position": "Operations Manager",
      "grossPay": 5800.00,
      "deductions": 1392.00,
      "netPay": 4408.00,
      "status": "failed",
      "payDate": "2024-03-15",
      "avatar": "https://picsum.photos/50/50?random=5&keyword=person",
    },
    {
      "id": "EMP006",
      "name": "Lisa Anderson",
      "department": "Sales",
      "position": "Sales Manager",
      "grossPay": 6500.00,
      "deductions": 1560.00,
      "netPay": 4940.00,
      "status": "on_hold",
      "payDate": "2024-03-15",
      "avatar": "https://picsum.photos/50/50?random=6&keyword=person",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "processed":
        return successColor;
      case "pending":
        return warningColor;
      case "failed":
        return dangerColor;
      case "on_hold":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "processed":
        return "Processed";
      case "pending":
        return "Pending";
      case "failed":
        return "Failed";
      case "on_hold":
        return "On Hold";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee Payments"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.add),
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
                    "Payment Filters",
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
                          label: "Status",
                          items: statusOptions,
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
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
                  Row(
                    children: [
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
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTextField(
                          label: "Search Employee",
                          value: searchQuery,
                          hint: "Name or ID",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Payment Statistics
            Text(
              "Payment Statistics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: paymentStats.map((stat) {
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
                              color: (stat["color"] as Color).withAlpha(26),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              stat["icon"] as IconData,
                              color: stat["color"] as Color,
                              size: 24,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${stat["value"]}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: stat["color"] as Color,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${stat["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "\$${((stat["amount"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Employee Payments List
            Text(
              "Employee Payments",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: employeePayments.map((payment) {
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                "${payment["avatar"]}",
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 4,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${payment["name"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "(${payment["id"]})",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${payment["position"]} • ${payment["department"]}",
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
                                color: _getStatusColor(payment["status"]).withAlpha(26),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                _getStatusLabel(payment["status"]),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _getStatusColor(payment["status"]),
                                ),
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
                                    "Gross Pay",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${((payment["grossPay"] as double)).currency}",
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
                                    "Deductions",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${((payment["deductions"] as double)).currency}",
                                    style: TextStyle(
                                      fontSize: 14,
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
                                spacing: 4,
                                children: [
                                  Text(
                                    "Net Pay",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${((payment["netPay"] as double)).currency}",
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
                        Row(
                          children: [
                            Text(
                              "Pay Date: ${payment["payDate"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledColor,
                              ),
                            ),
                            Spacer(),
                            QButton(
                              label: "View Details",
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
            ),
          ],
        ),
      ),
    );
  }
}
