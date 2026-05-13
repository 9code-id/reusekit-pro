import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaTaxCalculationsView extends StatefulWidget {
  const AbaTaxCalculationsView({super.key});

  @override
  State<AbaTaxCalculationsView> createState() => _AbaTaxCalculationsViewState();
}

class _AbaTaxCalculationsViewState extends State<AbaTaxCalculationsView> {
  String selectedEmployee = "all";
  String selectedTaxType = "all";
  String selectedPeriod = "current_month";
  String searchQuery = "";
  
  List<Map<String, dynamic>> employeeOptions = [
    {"label": "All Employees", "value": "all"},
    {"label": "John Smith", "value": "john_smith"},
    {"label": "Sarah Johnson", "value": "sarah_johnson"},
    {"label": "Mike Davis", "value": "mike_davis"},
    {"label": "Emily Wilson", "value": "emily_wilson"},
  ];

  List<Map<String, dynamic>> taxTypes = [
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

  List<Map<String, dynamic>> calculationSummary = [
    {
      "title": "Total Tax Calculated",
      "amount": 48750.00,
      "change": 8.5,
      "icon": Icons.calculate,
      "color": primaryColor,
    },
    {
      "title": "Federal Taxes",
      "amount": 32400.00,
      "change": 12.3,
      "icon": Icons.account_balance,
      "color": infoColor,
    },
    {
      "title": "State & Local",
      "amount": 12850.00,
      "change": -2.1,
      "icon": Icons.location_city,
      "color": warningColor,
    },
    {
      "title": "Other Deductions",
      "amount": 3500.00,
      "change": 5.7,
      "icon": Icons.remove_circle,
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> taxCalculations = [
    {
      "id": "TC001",
      "employeeId": "EMP001",
      "employeeName": "John Smith",
      "department": "Administration",
      "grossPay": 5200.00,
      "calculations": [
        {
          "type": "Federal Income Tax",
          "rate": 22.0,
          "taxableAmount": 5200.00,
          "calculatedTax": 1144.00,
          "ytdAmount": 13728.00,
        },
        {
          "type": "Social Security",
          "rate": 6.2,
          "taxableAmount": 5200.00,
          "calculatedTax": 322.40,
          "ytdAmount": 3868.80,
        },
        {
          "type": "Medicare",
          "rate": 1.45,
          "taxableAmount": 5200.00,
          "calculatedTax": 75.40,
          "ytdAmount": 904.80,
        },
        {
          "type": "State Income Tax",
          "rate": 5.0,
          "taxableAmount": 5200.00,
          "calculatedTax": 260.00,
          "ytdAmount": 3120.00,
        },
      ],
      "totalTax": 1801.80,
      "netPay": 3398.20,
      "calculatedDate": "2024-03-31",
      "status": "calculated",
    },
    {
      "id": "TC002",
      "employeeId": "EMP002",
      "employeeName": "Sarah Johnson",
      "department": "Sales",
      "grossPay": 4800.00,
      "calculations": [
        {
          "type": "Federal Income Tax",
          "rate": 22.0,
          "taxableAmount": 4800.00,
          "calculatedTax": 1056.00,
          "ytdAmount": 12672.00,
        },
        {
          "type": "Social Security",
          "rate": 6.2,
          "taxableAmount": 4800.00,
          "calculatedTax": 297.60,
          "ytdAmount": 3571.20,
        },
        {
          "type": "Medicare",
          "rate": 1.45,
          "taxableAmount": 4800.00,
          "calculatedTax": 69.60,
          "ytdAmount": 835.20,
        },
        {
          "type": "State Income Tax",
          "rate": 5.0,
          "taxableAmount": 4800.00,
          "calculatedTax": 240.00,
          "ytdAmount": 2880.00,
        },
      ],
      "totalTax": 1663.20,
      "netPay": 3136.80,
      "calculatedDate": "2024-03-31",
      "status": "calculated",
    },
    {
      "id": "TC003",
      "employeeId": "EMP003",
      "employeeName": "Mike Davis",
      "department": "IT",
      "grossPay": 6200.00,
      "calculations": [
        {
          "type": "Federal Income Tax",
          "rate": 24.0,
          "taxableAmount": 6200.00,
          "calculatedTax": 1488.00,
          "ytdAmount": 17856.00,
        },
        {
          "type": "Social Security",
          "rate": 6.2,
          "taxableAmount": 6200.00,
          "calculatedTax": 384.40,
          "ytdAmount": 4612.80,
        },
        {
          "type": "Medicare",
          "rate": 1.45,
          "taxableAmount": 6200.00,
          "calculatedTax": 89.90,
          "ytdAmount": 1078.80,
        },
        {
          "type": "State Income Tax",
          "rate": 5.0,
          "taxableAmount": 6200.00,
          "calculatedTax": 310.00,
          "ytdAmount": 3720.00,
        },
      ],
      "totalTax": 2272.30,
      "netPay": 3927.70,
      "calculatedDate": "2024-03-31",
      "status": "pending_review",
    },
    {
      "id": "TC004",
      "employeeId": "EMP004",
      "employeeName": "Emily Wilson",
      "department": "Marketing",
      "grossPay": 4500.00,
      "calculations": [
        {
          "type": "Federal Income Tax",
          "rate": 22.0,
          "taxableAmount": 4500.00,
          "calculatedTax": 990.00,
          "ytdAmount": 11880.00,
        },
        {
          "type": "Social Security",
          "rate": 6.2,
          "taxableAmount": 4500.00,
          "calculatedTax": 279.00,
          "ytdAmount": 3348.00,
        },
        {
          "type": "Medicare",
          "rate": 1.45,
          "taxableAmount": 4500.00,
          "calculatedTax": 65.25,
          "ytdAmount": 783.00,
        },
        {
          "type": "State Income Tax",
          "rate": 5.0,
          "taxableAmount": 4500.00,
          "calculatedTax": 225.00,
          "ytdAmount": 2700.00,
        },
      ],
      "totalTax": 1559.25,
      "netPay": 2940.75,
      "calculatedDate": "2024-03-31",
      "status": "error",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "calculated":
        return successColor;
      case "pending_review":
        return warningColor;
      case "error":
        return dangerColor;
      case "recalculating":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "calculated":
        return "Calculated";
      case "pending_review":
        return "Pending Review";
      case "error":
        return "Error";
      case "recalculating":
        return "Recalculating";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tax Calculations"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
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
                    "Calculation Filters",
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
                          label: "Employee",
                          items: employeeOptions,
                          value: selectedEmployee,
                          onChanged: (value, label) {
                            selectedEmployee = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Tax Type",
                          items: taxTypes,
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
                          label: "Search",
                          value: searchQuery,
                          hint: "Employee name or ID",
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

            // Calculation Summary
            Text(
              "Calculation Summary",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: calculationSummary.map((summary) {
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
                    label: "Recalculate All",
                    icon: Icons.refresh,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Export Results",
                    icon: Icons.download,
                    onPressed: () {},
                  ),
                ),
              ],
            ),

            // Tax Calculations List
            Text(
              "Employee Tax Calculations",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Column(
              children: taxCalculations.map((calculation) {
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
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
                                Row(
                                  children: [
                                    Text(
                                      "${calculation["employeeName"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "(${calculation["employeeId"]})",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${calculation["department"]}",
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
                              color: _getStatusColor(calculation["status"]).withAlpha(26),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              _getStatusLabel(calculation["status"]),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor(calculation["status"]),
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
                                  "\$${((calculation["grossPay"] as double)).currency}",
                                  style: TextStyle(
                                    fontSize: 16,
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
                                  "Total Tax",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${((calculation["totalTax"] as double)).currency}",
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
                                  "\$${((calculation["netPay"] as double)).currency}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      // Tax Breakdown
                      Text(
                        "Tax Breakdown",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Column(
                        children: (calculation["calculations"] as List).map<Widget>((tax) {
                          return Container(
                            padding: EdgeInsets.all(spSm),
                            margin: EdgeInsets.only(bottom: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(13),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: 4,
                                    children: [
                                      Text(
                                        "${tax["type"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${(tax["rate"] as double).toStringAsFixed(2)}%",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    spacing: 4,
                                    children: [
                                      Text(
                                        "\$${((tax["calculatedTax"] as double)).currency}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: dangerColor,
                                        ),
                                      ),
                                      Text(
                                        "YTD: \$${((tax["ytdAmount"] as double)).currency}",
                                        style: TextStyle(
                                          fontSize: 10,
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
                      
                      Row(
                        children: [
                          Text(
                            "Calculated: ${calculation["calculatedDate"]}",
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
          ],
        ),
      ),
    );
  }
}
