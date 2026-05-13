import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaTaxManagementView extends StatefulWidget {
  const FmaTaxManagementView({super.key});

  @override
  State<FmaTaxManagementView> createState() => _FmaTaxManagementViewState();
}

class _FmaTaxManagementViewState extends State<FmaTaxManagementView> {
  List<Map<String, dynamic>> taxRecords = [
    {
      "id": "TX001",
      "type": "Sales Tax",
      "period": "Q1 2024",
      "amount": 8500.0,
      "status": "Paid",
      "dueDate": "2024-04-15",
      "paidDate": "2024-04-10",
      "rate": 8.5,
    },
    {
      "id": "TX002",
      "type": "Income Tax",
      "period": "2023",
      "amount": 25000.0,
      "status": "Paid",
      "dueDate": "2024-03-15",
      "paidDate": "2024-03-12",
      "rate": 22.0,
    },
    {
      "id": "TX003",
      "type": "Sales Tax",
      "period": "Q2 2024",
      "amount": 9200.0,
      "status": "Due",
      "dueDate": "2024-07-15",
      "paidDate": null,
      "rate": 8.5,
    },
    {
      "id": "TX004",
      "type": "Payroll Tax",
      "period": "June 2024",
      "amount": 3400.0,
      "status": "Overdue",
      "dueDate": "2024-07-05",
      "paidDate": null,
      "rate": 15.3,
    },
    {
      "id": "TX005",
      "type": "Property Tax",
      "period": "2024",
      "amount": 12000.0,
      "status": "Upcoming",
      "dueDate": "2024-12-01",
      "paidDate": null,
      "rate": 1.2,
    },
  ];

  List<Map<String, dynamic>> deductions = [
    {
      "category": "Business Expenses",
      "amount": 15000.0,
      "description": "Office supplies, software licenses",
      "supportingDocs": 25,
    },
    {
      "category": "Travel & Transportation",
      "amount": 8500.0,
      "description": "Business trips, vehicle expenses",
      "supportingDocs": 18,
    },
    {
      "category": "Professional Services",
      "amount": 12000.0,
      "description": "Legal, accounting, consulting fees",
      "supportingDocs": 12,
    },
    {
      "category": "Equipment & Depreciation",
      "amount": 22000.0,
      "description": "Computer equipment, machinery",
      "supportingDocs": 8,
    },
  ];

  String selectedTaxYear = "2024";
  String filterStatus = "All";
  bool showCalculator = false;
  double calculatorAmount = 0.0;
  double calculatorRate = 8.5;

  List<Map<String, dynamic>> taxYearOptions = [
    {"label": "2024", "value": "2024"},
    {"label": "2023", "value": "2023"},
    {"label": "2022", "value": "2022"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All"},
    {"label": "Paid", "value": "Paid"},
    {"label": "Due", "value": "Due"},
    {"label": "Overdue", "value": "Overdue"},
    {"label": "Upcoming", "value": "Upcoming"},
  ];

  @override
  Widget build(BuildContext context) {
    double totalPaid = taxRecords
        .where((tax) => tax["status"] == "Paid")
        .fold(0.0, (sum, item) => sum + (item["amount"] as double));
    double totalDue = taxRecords
        .where((tax) => tax["status"] == "Due" || tax["status"] == "Overdue")
        .fold(0.0, (sum, item) => sum + (item["amount"] as double));
    double totalDeductions = deductions.fold(0.0, (sum, item) => sum + (item["amount"] as double));

    return Scaffold(
      appBar: AppBar(
        title: Text("Tax Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.calculate),
            onPressed: () {
              setState(() {
                showCalculator = !showCalculator;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              ss("Tax report exported successfully");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Tax Calculator (Collapsible)
            if (showCalculator)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: infoColor.withAlpha(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calculate, color: infoColor),
                        SizedBox(width: spSm),
                        Text(
                          "Tax Calculator",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showCalculator = false;
                            });
                          },
                          child: Icon(Icons.close, color: disabledBoldColor),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QNumberField(
                            label: "Amount (\$)",
                            value: calculatorAmount.toString(),
                            onChanged: (value) {
                              calculatorAmount = double.tryParse(value) ?? 0.0;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: QNumberField(
                            label: "Tax Rate (%)",
                            value: calculatorRate.toString(),
                            onChanged: (value) {
                              calculatorRate = double.tryParse(value) ?? 0.0;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Calculated Tax",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "\$${(calculatorAmount * calculatorRate / 100).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 24,
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

            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Tax Year",
                    items: taxYearOptions,
                    value: selectedTaxYear,
                    onChanged: (value, label) {
                      selectedTaxYear = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: statusOptions,
                    value: filterStatus,
                    onChanged: (value, label) {
                      filterStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildSummaryCard(
                  "Total Paid",
                  "\$${totalPaid.currency}",
                  Icons.check_circle,
                  successColor,
                ),
                _buildSummaryCard(
                  "Total Due",
                  "\$${totalDue.currency}",
                  Icons.schedule,
                  warningColor,
                ),
                _buildSummaryCard(
                  "Deductions",
                  "\$${totalDeductions.currency}",
                  Icons.trending_down,
                  infoColor,
                ),
                _buildSummaryCard(
                  "Net Tax",
                  "\$${(totalPaid + totalDue - totalDeductions).toStringAsFixed(2)}",
                  Icons.account_balance,
                  primaryColor,
                ),
              ],
            ),

            // Tax Records
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(Icons.receipt, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Tax Records",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Add Record",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: taxRecords.map((tax) {
                      Color statusColor = tax["status"] == "Paid"
                          ? successColor
                          : tax["status"] == "Overdue"
                              ? dangerColor
                              : tax["status"] == "Due"
                                  ? warningColor
                                  : infoColor;

                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          border: Border.all(color: disabledOutlineBorderColor),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Column(
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${tax["type"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${tax["id"]} • ${tax["period"]}",
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
                                    color: statusColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${tax["status"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: statusColor,
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
                                    children: [
                                      Text(
                                        "Amount",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(tax["amount"] as double).currency}",
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
                                    children: [
                                      Text(
                                        "Tax Rate",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${(tax["rate"] as double).toStringAsFixed(1)}%",
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
                                    children: [
                                      Text(
                                        "Due Date",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${DateTime.parse(tax["dueDate"]).dMMMy}",
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
                            if (tax["paidDate"] != null)
                              Row(
                                children: [
                                  Icon(Icons.check_circle, color: successColor, size: 16),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Paid on ${DateTime.parse(tax["paidDate"]).dMMMy}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Spacer(),
                                  QButton(
                                    label: "View Receipt",
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            if (tax["status"] == "Due" || tax["status"] == "Overdue")
                              Container(
                                width: double.infinity,
                                child: QButton(
                                  label: "Pay Now",
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Redirecting to payment gateway");
                                  },
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

            // Tax Deductions
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(Icons.trending_down, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Tax Deductions",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Add Deduction",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: deductions.map((deduction) {
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          border: Border.all(color: disabledOutlineBorderColor),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusMd),
                              ),
                              child: Icon(Icons.receipt_long, color: infoColor, size: 20),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${deduction["category"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${deduction["description"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Icon(Icons.attach_file, color: disabledBoldColor, size: 14),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${deduction["supportingDocs"]} documents",
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "\$${(deduction["amount"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                                SizedBox(height: spSm),
                                QButton(
                                  label: "Edit",
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
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Spacer(),
              Icon(Icons.more_vert, color: disabledBoldColor, size: 16),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
