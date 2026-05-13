import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaIncomeTaxView extends StatefulWidget {
  const AbaIncomeTaxView({super.key});

  @override
  State<AbaIncomeTaxView> createState() => _AbaIncomeTaxViewState();
}

class _AbaIncomeTaxViewState extends State<AbaIncomeTaxView> {
  String selectedTaxYear = "2024";
  String selectedFilingStatus = "single";
  bool loading = false;
  
  List<Map<String, dynamic>> taxYears = [
    {"label": "2024", "value": "2024"},
    {"label": "2023", "value": "2023"},
    {"label": "2022", "value": "2022"},
    {"label": "2021", "value": "2021"},
  ];

  List<Map<String, dynamic>> filingStatuses = [
    {"label": "Single", "value": "single"},
    {"label": "Married Filing Jointly", "value": "married_joint"},
    {"label": "Married Filing Separately", "value": "married_separate"},
    {"label": "Head of Household", "value": "head_household"},
  ];

  List<Map<String, dynamic>> incomeCategories = [
    {
      "category": "Salary & Wages",
      "amount": 85000.00,
      "taxable": true,
      "icon": Icons.work,
      "color": Colors.blue,
    },
    {
      "category": "Investment Income",
      "amount": 12500.00,
      "taxable": true,
      "icon": Icons.trending_up,
      "color": Colors.green,
    },
    {
      "category": "Rental Income",
      "amount": 24000.00,
      "taxable": true,
      "icon": Icons.home,
      "color": Colors.orange,
    },
    {
      "category": "Business Income",
      "amount": 35000.00,
      "taxable": true,
      "icon": Icons.business,
      "color": Colors.purple,
    },
  ];

  List<Map<String, dynamic>> deductions = [
    {
      "category": "Standard Deduction",
      "amount": 13850.00,
      "type": "standard",
      "icon": Icons.receipt_long,
    },
    {
      "category": "Charitable Contributions",
      "amount": 5000.00,
      "type": "itemized",
      "icon": Icons.volunteer_activism,
    },
    {
      "category": "Medical Expenses",
      "amount": 3200.00,
      "type": "itemized",
      "icon": Icons.medical_services,
    },
    {
      "category": "Mortgage Interest",
      "amount": 8500.00,
      "type": "itemized",
      "icon": Icons.home_work,
    },
  ];

  double get totalIncome {
    return incomeCategories.fold(0.0, (sum, item) => 
        sum + (item["amount"] as double));
  }

  double get totalDeductions {
    return deductions.fold(0.0, (sum, item) => 
        sum + (item["amount"] as double));
  }

  double get taxableIncome {
    return totalIncome - totalDeductions;
  }

  double get estimatedTax {
    return _calculateIncomeTax(taxableIncome);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Income Tax Calculator"),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () => _exportTaxReturn(),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTaxSettings(),
                  _buildTaxSummary(),
                  _buildIncomeBreakdown(),
                  _buildDeductionsBreakdown(),
                  _buildTaxCalculation(),
                  _buildActionButtons(),
                ],
              ),
            ),
    );
  }

  Widget _buildTaxSettings() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tax Filing Information",
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
                  label: "Tax Year",
                  items: taxYears,
                  value: selectedTaxYear,
                  onChanged: (value, label) {
                    selectedTaxYear = value;
                    _recalculateTax();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Filing Status",
                  items: filingStatuses,
                  value: selectedFilingStatus,
                  onChanged: (value, label) {
                    selectedFilingStatus = value;
                    _recalculateTax();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTaxSummary() {
    return ResponsiveGridView(
      padding: EdgeInsets.all(spSm),
      minItemWidth: 200,
      children: [
        _buildSummaryCard(
          "Total Income",
          totalIncome,
          Colors.blue,
          Icons.account_balance_wallet,
        ),
        _buildSummaryCard(
          "Total Deductions",
          totalDeductions,
          warningColor,
          Icons.receipt,
        ),
        _buildSummaryCard(
          "Taxable Income",
          taxableIncome,
          infoColor,
          Icons.calculate,
        ),
        _buildSummaryCard(
          "Estimated Tax",
          estimatedTax,
          dangerColor,
          Icons.payment,
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
    String title,
    double value,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: color,
            width: 4,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "\$${value.currency}",
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

  Widget _buildIncomeBreakdown() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Income Sources",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...incomeCategories.map((item) => _buildIncomeItem(item)),
        ],
      ),
    );
  }

  Widget _buildIncomeItem(Map<String, dynamic> item) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: (item["color"] as Color).withAlpha(30),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              item["icon"] as IconData,
              color: item["color"] as Color,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item["category"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  item["taxable"] ? "Taxable Income" : "Non-taxable",
                  style: TextStyle(
                    fontSize: 14,
                    color: item["taxable"] ? warningColor : successColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "\$${(item["amount"] as double).currency}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeductionsBreakdown() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tax Deductions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...deductions.map((item) => _buildDeductionItem(item)),
        ],
      ),
    );
  }

  Widget _buildDeductionItem(Map<String, dynamic> item) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Icon(
            item["icon"] as IconData,
            color: successColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item["category"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${item["type"]} deduction".toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "-\$${(item["amount"] as double).currency}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaxCalculation() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(30)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Text(
            "Tax Calculation Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildCalculationRow("Total Income", totalIncome, false),
          _buildCalculationRow("Total Deductions", totalDeductions, true),
          Divider(color: primaryColor.withAlpha(50)),
          _buildCalculationRow("Taxable Income", taxableIncome, false),
          _buildCalculationRow("Estimated Tax", estimatedTax, false, isResult: true),
        ],
      ),
    );
  }

  Widget _buildCalculationRow(String label, double amount, bool isDeduction, {bool isResult = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isResult ? 16 : 14,
            fontWeight: isResult ? FontWeight.bold : FontWeight.w500,
            color: primaryColor,
          ),
        ),
        Text(
          "${isDeduction ? '-' : ''}\$${amount.currency}",
          style: TextStyle(
            fontSize: isResult ? 18 : 14,
            fontWeight: isResult ? FontWeight.bold : FontWeight.w600,
            color: isResult ? dangerColor : (isDeduction ? successColor : primaryColor),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: QButton(
            label: "E-File Tax Return",
            icon: Icons.cloud_upload,
            size: bs.md,
            onPressed: () => _eFileTaxReturn(),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: QButton(
            label: "Save Draft",
            icon: Icons.save,
            size: bs.md,
            onPressed: () => _saveDraft(),
          ),
        ),
      ],
    );
  }

  double _calculateIncomeTax(double taxableIncome) {
    // Simplified tax brackets for demonstration
    if (taxableIncome <= 10275) {
      return taxableIncome * 0.10;
    } else if (taxableIncome <= 41775) {
      return 1027.50 + (taxableIncome - 10275) * 0.12;
    } else if (taxableIncome <= 89450) {
      return 4807.50 + (taxableIncome - 41775) * 0.22;
    } else {
      return 15213.50 + (taxableIncome - 89450) * 0.24;
    }
  }

  void _recalculateTax() {
    setState(() {});
    si("Tax calculation updated");
  }

  void _eFileTaxReturn() async {
    bool isConfirmed = await confirm("Are you sure you want to electronically file your tax return?");
    
    if (isConfirmed) {
      showLoading();
      
      await Future.delayed(Duration(seconds: 3));
      
      hideLoading();
      ss("Tax return filed successfully");
    }
  }

  void _saveDraft() async {
    showLoading();
    
    await Future.delayed(Duration(seconds: 1));
    
    hideLoading();
    ss("Tax return draft saved");
  }

  void _exportTaxReturn() async {
    showLoading();
    
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    ss("Tax return exported to downloads");
  }
}
