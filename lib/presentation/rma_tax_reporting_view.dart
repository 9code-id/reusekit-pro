import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaTaxReportingView extends StatefulWidget {
  const RmaTaxReportingView({super.key});

  @override
  State<RmaTaxReportingView> createState() => _RmaTaxReportingViewState();
}

class _RmaTaxReportingViewState extends State<RmaTaxReportingView> {
  String selectedYear = "2024";
  String selectedProperty = "all";
  String selectedQuarter = "all";

  List<Map<String, dynamic>> yearItems = [
    {"label": "2024", "value": "2024"},
    {"label": "2023", "value": "2023"},
    {"label": "2022", "value": "2022"},
    {"label": "2021", "value": "2021"},
  ];

  List<Map<String, dynamic>> properties = [
    {"label": "All Properties", "value": "all"},
    {"label": "Sunset Apartments Unit 1A", "value": "sunset_1a"},
    {"label": "Downtown Loft 205", "value": "downtown_205"},
    {"label": "Garden View Villa", "value": "garden_villa"},
    {"label": "Metro Plaza Suite 12", "value": "metro_12"},
  ];

  List<Map<String, dynamic>> quarterItems = [
    {"label": "All Quarters", "value": "all"},
    {"label": "Q1 (Jan-Mar)", "value": "q1"},
    {"label": "Q2 (Apr-Jun)", "value": "q2"},
    {"label": "Q3 (Jul-Sep)", "value": "q3"},
    {"label": "Q4 (Oct-Dec)", "value": "q4"},
  ];

  List<Map<String, dynamic>> taxDocuments = [
    {
      "id": "TD001",
      "type": "Schedule E",
      "description": "Rental Income and Expenses",
      "year": "2024",
      "status": "draft",
      "amount": 73500.0,
      "date": "2024-12-15",
    },
    {
      "id": "TD002",
      "type": "Form 1099-MISC",
      "description": "Miscellaneous Income",
      "year": "2024",
      "status": "submitted",
      "amount": 2400.0,
      "date": "2024-01-31",
    },
    {
      "id": "TD003",
      "type": "Depreciation Summary",
      "description": "Annual Depreciation Report",
      "year": "2024",
      "status": "completed",
      "amount": 18650.0,
      "date": "2024-12-31",
    },
    {
      "id": "TD004",
      "type": "Property Tax Statement",
      "description": "Annual Property Tax Summary",
      "year": "2024",
      "status": "completed",
      "amount": 9600.0,
      "date": "2024-12-31",
    },
  ];

  Map<String, dynamic> _getTaxSummary() {
    return {
      "rental_income": 136500.0,
      "deductible_expenses": {
        "maintenance": 12400.0,
        "management_fees": 14400.0,
        "insurance": 4800.0,
        "property_tax": 9600.0,
        "utilities": 4200.0,
        "depreciation": 18650.0,
        "professional_services": 3600.0,
        "advertising": 1440.0,
        "travel": 1200.0,
        "supplies": 1800.0,
        "other": 2400.0,
        "total": 74490.0,
      },
      "net_rental_income": 62010.0,
      "quarterly_payments": 15500.0,
      "estimated_tax_due": 18603.0,
    };
  }

  List<Map<String, dynamic>> _getQuarterlyBreakdown() {
    return [
      {
        "quarter": "Q1 2024",
        "income": 34125.0,
        "expenses": 18620.0,
        "net_income": 15505.0,
        "tax_payment": 3876.25,
        "status": "filed",
      },
      {
        "quarter": "Q2 2024",
        "income": 34200.0,
        "expenses": 18725.0,
        "net_income": 15475.0,
        "tax_payment": 3868.75,
        "status": "filed",
      },
      {
        "quarter": "Q3 2024",
        "income": 34087.5,
        "expenses": 18572.5,
        "net_income": 15515.0,
        "tax_payment": 3878.75,
        "status": "filed",
      },
      {
        "quarter": "Q4 2024",
        "income": 34087.5,
        "expenses": 18572.5,
        "net_income": 15515.0,
        "tax_payment": 3878.75,
        "status": "pending",
      },
    ];
  }

  List<Map<String, dynamic>> _getDeductibleExpenses() {
    return [
      {
        "category": "Maintenance & Repairs",
        "amount": 12400.0,
        "description": "Plumbing, electrical, HVAC repairs",
        "receipts": 24,
      },
      {
        "category": "Management Fees",
        "amount": 14400.0,
        "description": "Property management services",
        "receipts": 12,
      },
      {
        "category": "Insurance",
        "amount": 4800.0,
        "description": "Property insurance premiums",
        "receipts": 4,
      },
      {
        "category": "Property Tax",
        "amount": 9600.0,
        "description": "Municipal property taxes",
        "receipts": 4,
      },
      {
        "category": "Utilities",
        "amount": 4200.0,
        "description": "Electricity, water, gas",
        "receipts": 36,
      },
      {
        "category": "Professional Services",
        "amount": 3600.0,
        "description": "Legal, accounting, consulting",
        "receipts": 8,
      },
      {
        "category": "Depreciation",
        "amount": 18650.0,
        "description": "Building and equipment depreciation",
        "receipts": 0,
      },
    ];
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed':
      case 'filed':
        return successColor;
      case 'submitted':
        return infoColor;
      case 'pending':
        return warningColor;
      case 'draft':
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'completed':
        return 'Completed';
      case 'submitted':
        return 'Submitted';
      case 'pending':
        return 'Pending';
      case 'draft':
        return 'Draft';
      case 'filed':
        return 'Filed';
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final taxSummary = _getTaxSummary();
    final quarterlyBreakdown = _getQuarterlyBreakdown();
    final deductibleExpenses = _getDeductibleExpenses();

    return Scaffold(
      appBar: AppBar(
        title: Text("Tax Reporting"),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Container(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "Tax Reports",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spMd),
                      Column(
                        spacing: spSm,
                        children: [
                          QButton(
                            label: "Generate Schedule E",
                            size: bs.md,
                            onPressed: () {
                              back();
                              si("Generating Schedule E form");
                            },
                          ),
                          QButton(
                            label: "Export Expense Summary",
                            color: successColor,
                            size: bs.md,
                            onPressed: () {
                              back();
                              si("Exporting expense summary");
                            },
                          ),
                          QButton(
                            label: "Download Tax Package",
                            color: warningColor,
                            size: bs.md,
                            onPressed: () {
                              back();
                              si("Downloading tax package");
                            },
                          ),
                          QButton(
                            label: "Send to Accountant",
                            color: infoColor,
                            size: bs.md,
                            onPressed: () {
                              back();
                              si("Sending to accountant");
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            icon: Icon(Icons.file_download),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Filter Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Tax Year",
                      items: yearItems,
                      value: selectedYear,
                      onChanged: (value, label) {
                        selectedYear = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Property",
                      items: properties,
                      value: selectedProperty,
                      onChanged: (value, label) {
                        selectedProperty = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Quarter",
                      items: quarterItems,
                      value: selectedQuarter,
                      onChanged: (value, label) {
                        selectedQuarter = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Tax Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.account_balance,
                            color: successColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Rental Income",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${(taxSummary["rental_income"] as double).currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Gross rental income",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.receipt_long,
                            color: dangerColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Deductions",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${(taxSummary["deductible_expenses"]["total"] as double).currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Tax deductible expenses",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.trending_up,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Net Income",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${(taxSummary["net_rental_income"] as double).currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Taxable rental income",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.payment,
                            color: warningColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Est. Tax Due",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${(taxSummary["estimated_tax_due"] as double).currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Estimated tax liability",
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

            // Quarterly Tax Payments
            Container(
              padding: EdgeInsets.all(spSm),
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
                    "Quarterly Tax Payments",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: quarterlyBreakdown.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final quarter = quarterlyBreakdown[index];
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: spSm),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 60,
                              decoration: BoxDecoration(
                                color: _getStatusColor(quarter["status"]),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${quarter["quarter"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor(quarter["status"]).withAlpha(30),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          _getStatusLabel(quarter["status"]),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: _getStatusColor(quarter["status"]),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Income: \$${(quarter["income"] as double).currency}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: successColor,
                                        ),
                                      ),
                                      Text(
                                        " • Expenses: \$${(quarter["expenses"] as double).currency}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: dangerColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Net: \$${(quarter["net_income"] as double).currency}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        " • Tax: \$${(quarter["tax_payment"] as double).currency}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: warningColor,
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
                    },
                  ),
                ],
              ),
            ),

            // Deductible Expenses
            Container(
              padding: EdgeInsets.all(spSm),
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
                    "Deductible Expenses",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: deductibleExpenses.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final expense = deductibleExpenses[index];
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: spSm),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "${expense["category"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${expense["description"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  if ((expense["receipts"] as int) > 0)
                                    Text(
                                      "${expense["receipts"]} receipts available",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: successColor,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "\$${(expense["amount"] as double).currency}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Divider(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: spXs),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Total Deductible Expenses",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          "\$${(taxSummary["deductible_expenses"]["total"] as double).currency}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Tax Documents
            Container(
              padding: EdgeInsets.all(spSm),
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
                    "Tax Documents",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: taxDocuments.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final document = taxDocuments[index];
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: spSm),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 50,
                              decoration: BoxDecoration(
                                color: _getStatusColor(document["status"]),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${document["type"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor(document["status"]).withAlpha(30),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          _getStatusLabel(document["status"]),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: _getStatusColor(document["status"]),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${document["description"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Year: ${document["year"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        " • Amount: \$${(document["amount"] as double).currency}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.more_vert,
                              color: primaryColor,
                              size: bs.sm,
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => Container(
                                    padding: EdgeInsets.all(spMd),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color: disabledColor,
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                        ),
                                        SizedBox(height: spMd),
                                        Text(
                                          "Document Actions",
                                          style: TextStyle(
                                            fontSize: fsH6,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: spMd),
                                        Column(
                                          spacing: spSm,
                                          children: [
                                            QButton(
                                              label: "View Document",
                                              size: bs.md,
                                              onPressed: () {
                                                back();
                                                si("Opening tax document");
                                              },
                                            ),
                                            QButton(
                                              label: "Download PDF",
                                              color: successColor,
                                              size: bs.md,
                                              onPressed: () {
                                                back();
                                                si("Downloading PDF");
                                              },
                                            ),
                                            QButton(
                                              label: "Share with Accountant",
                                              color: infoColor,
                                              size: bs.md,
                                              onPressed: () {
                                                back();
                                                si("Sharing with accountant");
                                              },
                                            ),
                                            QButton(
                                              label: "Generate Report",
                                              color: warningColor,
                                              size: bs.md,
                                              onPressed: () {
                                                back();
                                                si("Generating tax report");
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
