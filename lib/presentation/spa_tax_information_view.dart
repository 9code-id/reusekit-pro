import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaTaxInformationView extends StatefulWidget {
  const SpaTaxInformationView({super.key});

  @override
  State<SpaTaxInformationView> createState() => _SpaTaxInformationViewState();
}

class _SpaTaxInformationViewState extends State<SpaTaxInformationView> {
  String selectedYear = "2024";
  String selectedQuarter = "Q4";
  bool showDetails = false;
  
  List<String> years = ["2024", "2023", "2022", "2021"];
  List<String> quarters = ["Q1", "Q2", "Q3", "Q4"];
  
  Map<String, dynamic> businessInfo = {
    "businessName": "Serenity Spa Downtown",
    "businessType": "LLC",
    "taxId": "TAX-123456789",
    "address": "123 Main Street, Downtown",
    "city": "New York, NY 10002",
    "contactPerson": "Sarah Johnson",
    "phone": "+1 (555) 123-4567",
    "email": "tax@serenityspa.com"
  };
  
  Map<String, dynamic> taxSummary = {
    "totalRevenue": 245850.75,
    "totalExpenses": 89420.50,
    "netIncome": 156430.25,
    "taxableIncome": 145380.25,
    "federalTax": 29076.05,
    "stateTax": 11630.42,
    "localTax": 3634.46,
    "totalTaxOwed": 44340.93,
    "taxesPaid": 42500.00,
    "balanceDue": 1840.93
  };
  
  List<Map<String, dynamic>> taxCategories = [
    {
      "category": "Service Revenue",
      "amount": 195850.75,
      "taxRate": 0.20,
      "taxAmount": 39170.15,
      "description": "Spa services, treatments, and consultations"
    },
    {
      "category": "Product Sales",
      "amount": 50000.00,
      "taxRate": 0.18,
      "taxAmount": 9000.00,
      "description": "Retail spa products and gift certificates"
    },
    {
      "category": "Business Expenses",
      "amount": -89420.50,
      "taxRate": 0.00,
      "taxAmount": -17884.10,
      "description": "Deductible business expenses and operating costs"
    },
    {
      "category": "Equipment Depreciation",
      "amount": -11050.00,
      "taxRate": 0.00,
      "taxAmount": -2210.00,
      "description": "Depreciation on spa equipment and furniture"
    },
  ];
  
  List<Map<String, dynamic>> quarterlyBreakdown = [
    {
      "quarter": "Q1 2024",
      "revenue": 58420.50,
      "expenses": 21850.25,
      "netIncome": 36570.25,
      "taxOwed": 10540.30,
      "taxPaid": 10540.30,
      "status": "Paid"
    },
    {
      "quarter": "Q2 2024",
      "revenue": 62180.75,
      "expenses": 23420.75,
      "netIncome": 38760.00,
      "taxOwed": 11180.40,
      "taxPaid": 11180.40,
      "status": "Paid"
    },
    {
      "quarter": "Q3 2024",
      "revenue": 69850.25,
      "expenses": 25640.50,
      "netIncome": 44209.75,
      "taxOwed": 12760.80,
      "taxPaid": 12760.80,
      "status": "Paid"
    },
    {
      "quarter": "Q4 2024",
      "revenue": 55399.25,
      "expenses": 18509.00,
      "netIncome": 36890.25,
      "taxOwed": 9859.43,
      "taxPaid": 8018.50,
      "status": "Pending"
    },
  ];
  
  List<Map<String, dynamic>> deductions = [
    {
      "category": "Equipment & Supplies",
      "amount": 25850.75,
      "description": "Spa equipment, massage tables, skincare products"
    },
    {
      "category": "Rent & Utilities",
      "amount": 18600.00,
      "description": "Monthly rent and utility bills"
    },
    {
      "category": "Professional Services",
      "amount": 12450.50,
      "description": "Accounting, legal, and consulting fees"
    },
    {
      "category": "Marketing & Advertising",
      "amount": 8750.25,
      "description": "Online ads, print marketing, social media"
    },
    {
      "category": "Insurance",
      "amount": 7890.00,
      "description": "Business insurance and liability coverage"
    },
    {
      "category": "Staff Training",
      "amount": 5420.75,
      "description": "Employee training and certification costs"
    },
    {
      "category": "Maintenance & Repairs",
      "amount": 4650.25,
      "description": "Equipment maintenance and facility repairs"
    },
    {
      "category": "Office Supplies",
      "amount": 2890.50,
      "description": "Administrative supplies and software"
    },
    {
      "category": "Travel & Transportation",
      "amount": 2407.50,
      "description": "Business travel and transportation costs"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tax Information"),
        actions: [
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {
              _downloadTaxReport();
            },
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Business Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          Icons.business,
                          color: primaryColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${businessInfo["businessName"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${businessInfo["businessType"]} • Tax ID: ${businessInfo["taxId"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
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
                              "Address:",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${businessInfo["address"]}",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "${businessInfo["city"]}",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 14,
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
                              "Contact:",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${businessInfo["contactPerson"]}",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${businessInfo["phone"]}",
                              style: TextStyle(
                                color: infoColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "${businessInfo["email"]}",
                              style: TextStyle(
                                color: infoColor,
                                fontSize: 14,
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

            // Tax Period Selector
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Tax Period",
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
                          label: "Year",
                          items: years.map((year) => {"label": year, "value": year}).toList(),
                          value: selectedYear,
                          onChanged: (value, label) {
                            selectedYear = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QDropdownField(
                          label: "Quarter",
                          items: quarters.map((quarter) => {"label": quarter, "value": quarter}).toList(),
                          value: selectedQuarter,
                          onChanged: (value, label) {
                            selectedQuarter = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Tax Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Tax Summary - $selectedYear",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildSummaryCard("Total Revenue", taxSummary["totalRevenue"], successColor, Icons.trending_up),
                      _buildSummaryCard("Total Expenses", taxSummary["totalExpenses"], dangerColor, Icons.trending_down),
                      _buildSummaryCard("Net Income", taxSummary["netIncome"], primaryColor, Icons.account_balance),
                      _buildSummaryCard("Total Tax Owed", taxSummary["totalTaxOwed"], warningColor, Icons.receipt),
                      _buildSummaryCard("Taxes Paid", taxSummary["taxesPaid"], infoColor, Icons.payment),
                      _buildSummaryCard("Balance Due", taxSummary["balanceDue"], 
                          (taxSummary["balanceDue"] as double) > 0 ? dangerColor : successColor, 
                          Icons.account_balance_wallet),
                    ],
                  ),
                ],
              ),
            ),

            // Tax Categories
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Tax Categories",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...taxCategories.map((category) => _buildTaxCategory(category)).toList(),
                ],
              ),
            ),

            // Quarterly Breakdown
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Text(
                        "Quarterly Breakdown",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          showDetails = !showDetails;
                          setState(() {});
                        },
                        child: Row(
                          children: [
                            Text(
                              showDetails ? "Hide Details" : "Show Details",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              showDetails ? Icons.expand_less : Icons.expand_more,
                              color: primaryColor,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ...quarterlyBreakdown.map((quarter) => _buildQuarterlyItem(quarter)).toList(),
                ],
              ),
            ),

            // Deductions
            if (showDetails)
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Business Deductions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ...deductions.map((deduction) => _buildDeductionItem(deduction)).toList(),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.savings,
                            color: successColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Total Deductions: \$${deductions.fold(0.0, (sum, item) => sum + (item["amount"] as double)).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: successColor,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            // Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Download Report",
                          size: bs.md,
                          icon: Icons.download,
                          onPressed: () {
                            _downloadTaxReport();
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QButton(
                          label: "Export Data",
                          size: bs.md,
                          icon: Icons.file_download,
                          color: infoColor,
                          onPressed: () {
                            _exportTaxData();
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Contact Accountant",
                          size: bs.md,
                          icon: Icons.person,
                          color: successColor,
                          onPressed: () {
                            _contactAccountant();
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QButton(
                          label: "Schedule Review",
                          size: bs.md,
                          icon: Icons.schedule,
                          color: warningColor,
                          onPressed: () {
                            _scheduleReview();
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
      ),
    );
  }

  Widget _buildSummaryCard(String title, double amount, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: color.withAlpha(60)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Spacer(),
              Text(
                "\$${amount.abs().toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaxCategory(Map<String, dynamic> category) {
    double amount = category["amount"];
    double taxAmount = category["taxAmount"];
    bool isExpense = amount < 0;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${category["category"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${isExpense ? '-' : ''}\$${amount.abs().toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isExpense ? dangerColor : successColor,
                    ),
                  ),
                  Text(
                    "Tax: ${isExpense ? '-' : ''}\$${taxAmount.abs().toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 12,
                      color: isExpense ? dangerColor : primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            "${category["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuarterlyItem(Map<String, dynamic> quarter) {
    bool isPaid = quarter["status"] == "Paid";
    Color statusColor = isPaid ? successColor : warningColor;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: statusColor.withAlpha(60)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "${quarter["quarter"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${quarter["status"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (showDetails) ...[
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Revenue: \$${(quarter["revenue"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Expenses: \$${(quarter["expenses"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Net: \$${(quarter["netIncome"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Tax: \$${(quarter["taxOwed"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDeductionItem(Map<String, dynamic> deduction) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${deduction["category"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${deduction["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "\$${(deduction["amount"] as double).toStringAsFixed(2)}",
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

  void _downloadTaxReport() {
    ss("Downloading tax report for $selectedYear $selectedQuarter...");
  }

  void _exportTaxData() {
    ss("Exporting tax data to Excel...");
  }

  void _contactAccountant() {
    ss("Contacting your accountant...");
  }

  void _scheduleReview() {
    ss("Opening calendar to schedule tax review...");
  }
}
