import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaSalesTaxView extends StatefulWidget {
  const AbaSalesTaxView({super.key});

  @override
  State<AbaSalesTaxView> createState() => _AbaSalesTaxViewState();
}

class _AbaSalesTaxViewState extends State<AbaSalesTaxView> {
  String selectedPeriod = "current_quarter";
  String selectedTaxRate = "10";
  bool loading = false;
  
  List<Map<String, dynamic>> taxPeriods = [
    {"label": "Current Quarter", "value": "current_quarter"},
    {"label": "Previous Quarter", "value": "previous_quarter"},
    {"label": "Current Year", "value": "current_year"},
    {"label": "Previous Year", "value": "previous_year"},
  ];

  List<Map<String, dynamic>> taxRates = [
    {"label": "10% GST", "value": "10"},
    {"label": "15% VAT", "value": "15"},
    {"label": "20% VAT", "value": "20"},
  ];

  List<Map<String, dynamic>> taxData = [
    {
      "description": "Sales Revenue",
      "amount": 125000.00,
      "taxRate": 10,
      "taxAmount": 12500.00,
      "category": "revenue"
    },
    {
      "description": "Service Income",
      "amount": 85000.00,
      "taxRate": 10,
      "taxAmount": 8500.00,
      "category": "revenue"
    },
    {
      "description": "Product Sales",
      "amount": 95000.00,
      "taxRate": 10,
      "taxAmount": 9500.00,
      "category": "revenue"
    },
    {
      "description": "Consulting Fees",
      "amount": 45000.00,
      "taxRate": 10,
      "taxAmount": 4500.00,
      "category": "revenue"
    },
  ];

  double get totalTaxableAmount {
    return taxData.fold(0.0, (sum, item) => sum + (item["amount"] as double));
  }

  double get totalTaxAmount {
    return taxData.fold(0.0, (sum, item) => sum + (item["taxAmount"] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sales Tax Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () => _exportTaxReport(),
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
                  _buildFilters(),
                  _buildTaxSummary(),
                  _buildTaxBreakdown(),
                  _buildActionButtons(),
                ],
              ),
            ),
    );
  }

  Widget _buildFilters() {
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
            "Tax Period & Settings",
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
                  label: "Tax Period",
                  items: taxPeriods,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    _loadTaxData();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Tax Rate",
                  items: taxRates,
                  value: selectedTaxRate,
                  onChanged: (value, label) {
                    selectedTaxRate = value;
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
          "Total Taxable Amount",
          totalTaxableAmount,
          Colors.blue,
          Icons.account_balance_wallet,
        ),
        _buildSummaryCard(
          "Total Tax Amount",
          totalTaxAmount,
          warningColor,
          Icons.receipt,
        ),
        _buildSummaryCard(
          "Tax Rate",
          double.parse(selectedTaxRate),
          infoColor,
          Icons.percent,
          isPercentage: true,
        ),
        _buildSummaryCard(
          "Net Amount",
          totalTaxableAmount - totalTaxAmount,
          successColor,
          Icons.trending_up,
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
    String title,
    double value,
    Color color,
    IconData icon, {
    bool isPercentage = false,
  }) {
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
            isPercentage 
                ? "${value.toStringAsFixed(0)}%"
                : "\$${value.currency}",
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

  Widget _buildTaxBreakdown() {
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
            "Tax Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...taxData.map((item) => _buildTaxItem(item)),
        ],
      ),
    );
  }

  Widget _buildTaxItem(Map<String, dynamic> item) {
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
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item["description"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Rate: ${item["taxRate"]}%",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "\$${(item["amount"] as double).currency}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Tax: \$${(item["taxAmount"] as double).currency}",
                  style: TextStyle(
                    fontSize: 14,
                    color: warningColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: QButton(
            label: "Generate Tax Report",
            icon: Icons.assignment,
            size: bs.md,
            onPressed: () => _generateTaxReport(),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: QButton(
            label: "Submit Tax Return",
            icon: Icons.send,
            size: bs.md,
            onPressed: () => _submitTaxReturn(),
          ),
        ),
      ],
    );
  }

  void _loadTaxData() {
    loading = true;
    setState(() {});

    // Simulate API call
    Future.delayed(Duration(seconds: 1), () {
      loading = false;
      setState(() {});
      ss("Tax data loaded successfully");
    });
  }

  void _recalculateTax() {
    double rate = double.parse(selectedTaxRate) / 100;
    
    for (var item in taxData) {
      item["taxRate"] = double.parse(selectedTaxRate);
      item["taxAmount"] = (item["amount"] as double) * rate;
    }
    
    setState(() {});
    si("Tax amounts recalculated");
  }

  void _generateTaxReport() async {
    showLoading();
    
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    ss("Tax report generated successfully");
  }

  void _submitTaxReturn() async {
    bool isConfirmed = await confirm("Are you sure you want to submit the tax return? This action cannot be undone.");
    
    if (isConfirmed) {
      showLoading();
      
      await Future.delayed(Duration(seconds: 3));
      
      hideLoading();
      ss("Tax return submitted successfully");
    }
  }

  void _exportTaxReport() async {
    showLoading();
    
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    ss("Tax report exported to downloads");
  }
}
