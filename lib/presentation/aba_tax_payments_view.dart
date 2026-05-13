import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaTaxPaymentsView extends StatefulWidget {
  const AbaTaxPaymentsView({super.key});

  @override
  State<AbaTaxPaymentsView> createState() => _AbaTaxPaymentsViewState();
}

class _AbaTaxPaymentsViewState extends State<AbaTaxPaymentsView> {
  String selectedStatus = "all";
  String selectedTaxType = "all";
  String selectedPeriod = "current_month";
  String searchQuery = "";
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Pending", "value": "pending"},
    {"label": "Scheduled", "value": "scheduled"},
    {"label": "Paid", "value": "paid"},
    {"label": "Failed", "value": "failed"},
    {"label": "Overdue", "value": "overdue"},
  ];

  List<Map<String, dynamic>> taxTypeOptions = [
    {"label": "All Tax Types", "value": "all"},
    {"label": "Federal Income Tax", "value": "federal_income"},
    {"label": "Social Security", "value": "social_security"},
    {"label": "Medicare", "value": "medicare"},
    {"label": "State Income Tax", "value": "state_income"},
    {"label": "Unemployment Tax", "value": "unemployment"},
    {"label": "Workers' Compensation", "value": "workers_comp"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Current Month", "value": "current_month"},
    {"label": "Previous Month", "value": "previous_month"},
    {"label": "Current Quarter", "value": "current_quarter"},
    {"label": "Year to Date", "value": "ytd"},
    {"label": "Custom Range", "value": "custom"},
  ];

  List<Map<String, dynamic>> paymentSummary = [
    {
      "title": "Total Payments",
      "amount": 125800.00,
      "count": 28,
      "icon": Icons.payment,
      "color": primaryColor,
    },
    {
      "title": "Paid This Month",
      "amount": 48500.00,
      "count": 12,
      "icon": Icons.check_circle,
      "color": successColor,
    },
    {
      "title": "Pending Payments",
      "amount": 15600.00,
      "count": 8,
      "icon": Icons.schedule,
      "color": warningColor,
    },
    {
      "title": "Overdue Payments",
      "amount": 8900.00,
      "count": 3,
      "icon": Icons.error,
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> taxPayments = [
    {
      "id": "TP001",
      "taxType": "Federal Income Tax",
      "description": "Quarterly Federal Income Tax Payment - Q1 2024",
      "amount": 32400.00,
      "dueDate": "2024-04-15",
      "paymentDate": "2024-04-12",
      "status": "paid",
      "method": "ACH Transfer",
      "confirmationNumber": "FED20240412001",
      "period": "Q1 2024",
      "agency": "IRS",
      "icon": Icons.account_balance,
    },
    {
      "id": "TP002",
      "taxType": "Social Security",
      "description": "Social Security Tax Payment - March 2024",
      "amount": 8640.00,
      "dueDate": "2024-04-15",
      "paymentDate": null,
      "status": "scheduled",
      "method": "ACH Transfer",
      "confirmationNumber": null,
      "period": "March 2024",
      "agency": "SSA",
      "icon": Icons.security,
    },
    {
      "id": "TP003",
      "taxType": "Medicare",
      "description": "Medicare Tax Payment - March 2024",
      "amount": 2025.00,
      "dueDate": "2024-04-15",
      "paymentDate": null,
      "status": "scheduled",
      "method": "ACH Transfer",
      "confirmationNumber": null,
      "period": "March 2024",
      "agency": "CMS",
      "icon": Icons.health_and_safety,
    },
    {
      "id": "TP004",
      "taxType": "State Income Tax",
      "description": "State Income Tax Payment - Q1 2024",
      "amount": 9800.00,
      "dueDate": "2024-04-20",
      "paymentDate": null,
      "status": "overdue",
      "method": "Online Payment",
      "confirmationNumber": null,
      "period": "Q1 2024",
      "agency": "State Treasury",
      "icon": Icons.location_city,
    },
    {
      "id": "TP005",
      "taxType": "Unemployment Tax",
      "description": "Federal Unemployment Tax Payment - Q1 2024",
      "amount": 1850.00,
      "dueDate": "2024-04-30",
      "paymentDate": null,
      "status": "pending",
      "method": "ACH Transfer",
      "confirmationNumber": null,
      "period": "Q1 2024",
      "agency": "DOL",
      "icon": Icons.work_off,
    },
    {
      "id": "TP006",
      "taxType": "Workers' Compensation",
      "description": "Workers' Compensation Premium - Q1 2024",
      "amount": 2400.00,
      "dueDate": "2024-05-01",
      "paymentDate": "2024-04-28",
      "status": "paid",
      "method": "Credit Card",
      "confirmationNumber": "WC20240428001",
      "period": "Q1 2024",
      "agency": "State Workers' Comp",
      "icon": Icons.medical_services,
    },
    {
      "id": "TP007",
      "taxType": "Federal Income Tax",
      "description": "Estimated Tax Payment - Q2 2024",
      "amount": 35000.00,
      "dueDate": "2024-06-15",
      "paymentDate": null,
      "status": "pending",
      "method": "ACH Transfer",
      "confirmationNumber": null,
      "period": "Q2 2024",
      "agency": "IRS",
      "icon": Icons.account_balance,
    },
    {
      "id": "TP008",
      "taxType": "State Income Tax",
      "description": "State Tax Payment Failed - Retry Required",
      "amount": 5200.00,
      "dueDate": "2024-03-15",
      "paymentDate": null,
      "status": "failed",
      "method": "ACH Transfer",
      "confirmationNumber": null,
      "period": "February 2024",
      "agency": "State Treasury",
      "icon": Icons.location_city,
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "paid":
        return successColor;
      case "scheduled":
        return infoColor;
      case "pending":
        return warningColor;
      case "overdue":
        return dangerColor;
      case "failed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "paid":
        return "Paid";
      case "scheduled":
        return "Scheduled";
      case "pending":
        return "Pending";
      case "overdue":
        return "Overdue";
      case "failed":
        return "Failed";
      default:
        return "Unknown";
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "paid":
        return Icons.check_circle;
      case "scheduled":
        return Icons.schedule;
      case "pending":
        return Icons.pending;
      case "overdue":
        return Icons.warning;
      case "failed":
        return Icons.error;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tax Payments"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.schedule),
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
                          label: "Tax Type",
                          items: taxTypeOptions,
                          value: selectedTaxType,
                          onChanged: (value, label) {
                            selectedTaxType = value;
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
                          label: "Period",
                          items: periodOptions,
                          value: selectedPeriod,
                          onChanged: (value, label) {
                            selectedPeriod = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTextField(
                          label: "Search Payments",
                          value: searchQuery,
                          hint: "Payment ID or description",
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

            // Payment Summary
            Text(
              "Payment Summary",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: paymentSummary.map((summary) {
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
                              color: (summary["color"] as Color).withAlpha(26),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              summary["icon"] as IconData,
                              color: summary["color"] as Color,
                              size: 24,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${summary["count"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: summary["color"] as Color,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${((summary["amount"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${summary["title"]}",
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
                    label: "Schedule Payment",
                    icon: Icons.schedule,
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

            // Tax Payments List
            Text(
              "Tax Payments",
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
                children: taxPayments.map((payment) {
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
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(26),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                payment["icon"] as IconData,
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
                                  Row(
                                    children: [
                                      Text(
                                        "${payment["taxType"]}",
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
                                    "${payment["description"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  _getStatusIcon(payment["status"]),
                                  color: _getStatusColor(payment["status"]),
                                  size: 20,
                                ),
                                SizedBox(width: spXs),
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
                                    "Amount",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${((payment["amount"] as double)).currency}",
                                    style: TextStyle(
                                      fontSize: 18,
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
                                    "Due Date",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${payment["dueDate"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
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
                                    "Method",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${payment["method"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
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
                              "Agency: ${payment["agency"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Period: ${payment["period"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        if (payment["paymentDate"] != null) ...[
                          Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                size: 16,
                                color: successColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Paid on ${payment["paymentDate"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                        if (payment["confirmationNumber"] != null) ...[
                          Row(
                            children: [
                              Icon(
                                Icons.receipt,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Confirmation: ${payment["confirmationNumber"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
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
                            if (payment["status"] == "pending" || payment["status"] == "overdue") ...[
                              Expanded(
                                child: QButton(
                                  label: "Pay Now",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ),
                            ] else if (payment["status"] == "failed") ...[
                              Expanded(
                                child: QButton(
                                  label: "Retry Payment",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ),
                            ] else if (payment["status"] == "scheduled") ...[
                              Expanded(
                                child: QButton(
                                  label: "Modify Schedule",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ),
                            ],
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
