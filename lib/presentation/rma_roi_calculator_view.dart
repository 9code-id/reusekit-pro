import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaRoiCalculatorView extends StatefulWidget {
  const RmaRoiCalculatorView({super.key});

  @override
  State<RmaRoiCalculatorView> createState() => _RmaRoiCalculatorViewState();
}

class _RmaRoiCalculatorViewState extends State<RmaRoiCalculatorView> {
  String propertyPrice = "";
  String downPayment = "";
  String monthlyRent = "";
  String monthlyExpenses = "";
  String repairCosts = "";
  String closingCosts = "";
  String loanAmount = "";
  String interestRate = "";
  String loanTerm = "";
  String vacancyRate = "5";
  String appreciationRate = "3";
  String managementFees = "8";
  
  bool showResults = false;
  bool loading = false;

  List<Map<String, dynamic>> calculationHistory = [
    {
      "id": "1",
      "propertyName": "Sunset Apartments",
      "propertyPrice": 850000.0,
      "monthlyRent": 6500.0,
      "roi": 14.2,
      "cashFlow": 2800.0,
      "capRate": 7.8,
      "dateCalculated": "2024-06-15",
    },
    {
      "id": "2", 
      "propertyName": "Downtown Office Complex",
      "propertyPrice": 1200000.0,
      "monthlyRent": 9500.0,
      "roi": 16.8,
      "cashFlow": 4200.0,
      "capRate": 8.2,
      "dateCalculated": "2024-06-10",
    },
    {
      "id": "3",
      "propertyName": "Riverside Condos",
      "propertyPrice": 650000.0,
      "monthlyRent": 4200.0,
      "roi": 11.5,
      "cashFlow": 1800.0,
      "capRate": 6.1,
      "dateCalculated": "2024-06-05",
    },
  ];

  double get propertyPriceValue => double.tryParse(propertyPrice) ?? 0.0;
  double get downPaymentValue => double.tryParse(downPayment) ?? 0.0;
  double get monthlyRentValue => double.tryParse(monthlyRent) ?? 0.0;
  double get monthlyExpensesValue => double.tryParse(monthlyExpenses) ?? 0.0;
  double get repairCostsValue => double.tryParse(repairCosts) ?? 0.0;
  double get closingCostsValue => double.tryParse(closingCosts) ?? 0.0;
  double get loanAmountValue => double.tryParse(loanAmount) ?? 0.0;
  double get interestRateValue => double.tryParse(interestRate) ?? 0.0;
  double get loanTermValue => double.tryParse(loanTerm) ?? 0.0;
  double get vacancyRateValue => double.tryParse(vacancyRate) ?? 5.0;
  double get appreciationRateValue => double.tryParse(appreciationRate) ?? 3.0;
  double get managementFeesValue => double.tryParse(managementFees) ?? 8.0;

  double get totalCashInvested {
    return downPaymentValue + repairCostsValue + closingCostsValue;
  }

  double get monthlyMortgagePayment {
    if (loanAmountValue == 0 || interestRateValue == 0 || loanTermValue == 0) return 0.0;
    
    double monthlyRate = (interestRateValue / 100) / 12;
    double numberOfPayments = loanTermValue * 12;
    
    return (loanAmountValue * monthlyRate * Math.pow(1 + monthlyRate, numberOfPayments)) / 
           (Math.pow(1 + monthlyRate, numberOfPayments) - 1);
  }

  double get effectiveMonthlyRent {
    return monthlyRentValue * (1 - (vacancyRateValue / 100));
  }

  double get totalMonthlyExpenses {
    double management = effectiveMonthlyRent * (managementFeesValue / 100);
    return monthlyExpensesValue + monthlyMortgagePayment + management;
  }

  double get monthlyNetCashFlow {
    return effectiveMonthlyRent - totalMonthlyExpenses;
  }

  double get annualNetCashFlow {
    return monthlyNetCashFlow * 12;
  }

  double get cashOnCashReturn {
    if (totalCashInvested == 0) return 0.0;
    return (annualNetCashFlow / totalCashInvested) * 100;
  }

  double get capRate {
    if (propertyPriceValue == 0) return 0.0;
    double annualRent = effectiveMonthlyRent * 12;
    double annualExpenses = monthlyExpensesValue * 12;
    return ((annualRent - annualExpenses) / propertyPriceValue) * 100;
  }

  double get onePercentRule {
    if (propertyPriceValue == 0) return 0.0;
    return (monthlyRentValue / propertyPriceValue) * 100;
  }

  void _calculateROI() {
    if (_validateInputs()) {
      loading = true;
      setState(() {});

      Future.delayed(Duration(seconds: 1), () {
        showResults = true;
        loading = false;
        setState(() {});
        ss("ROI calculation completed successfully");
      });
    }
  }

  bool _validateInputs() {
    if (propertyPrice.isEmpty || monthlyRent.isEmpty) {
      se("Please enter property price and monthly rent");
      return false;
    }
    return true;
  }

  void _saveCalculation() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Save Calculation",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            QTextField(
              label: "Property Name",
              value: "",
              hint: "Enter property name",
              onChanged: (value) {},
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Cancel",
                    size: bs.md,
                    onPressed: () => back(),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Save",
                    size: bs.md,
                    onPressed: () {
                      back();
                      ss("Calculation saved successfully");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _resetCalculator() {
    setState(() {
      propertyPrice = "";
      downPayment = "";
      monthlyRent = "";
      monthlyExpenses = "";
      repairCosts = "";
      closingCosts = "";
      loanAmount = "";
      interestRate = "";
      loanTerm = "";
      vacancyRate = "5";
      appreciationRate = "3";
      managementFees = "8";
      showResults = false;
    });
  }

  void _loadCalculation(Map<String, dynamic> calculation) {
    setState(() {
      propertyPrice = (calculation["propertyPrice"] as double).toString();
      monthlyRent = (calculation["monthlyRent"] as double).toString();
      // Load other saved values
      showResults = false;
    });
    ss("Calculation loaded successfully");
  }

  Widget _buildInputSection() {
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
          Text(
            "Property Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          QNumberField(
            label: "Property Price (\$)",
            value: propertyPrice,
            onChanged: (value) {
              propertyPrice = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Down Payment (\$)",
                  value: downPayment,
                  onChanged: (value) {
                    downPayment = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Monthly Rent (\$)",
                  value: monthlyRent,
                  onChanged: (value) {
                    monthlyRent = value;
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
                  label: "Monthly Expenses (\$)",
                  value: monthlyExpenses,
                  onChanged: (value) {
                    monthlyExpenses = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Repair Costs (\$)",
                  value: repairCosts,
                  onChanged: (value) {
                    repairCosts = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QNumberField(
            label: "Closing Costs (\$)",
            value: closingCosts,
            onChanged: (value) {
              closingCosts = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoanSection() {
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
          Text(
            "Loan Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          QNumberField(
            label: "Loan Amount (\$)",
            value: loanAmount,
            onChanged: (value) {
              loanAmount = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Interest Rate (%)",
                  value: interestRate,
                  onChanged: (value) {
                    interestRate = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Loan Term (Years)",
                  value: loanTerm,
                  onChanged: (value) {
                    loanTerm = value;
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

  Widget _buildAssumptionsSection() {
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
          Text(
            "Assumptions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Vacancy Rate (%)",
                  value: vacancyRate,
                  onChanged: (value) {
                    vacancyRate = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Appreciation Rate (%)",
                  value: appreciationRate,
                  onChanged: (value) {
                    appreciationRate = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QNumberField(
            label: "Management Fees (%)",
            value: managementFees,
            onChanged: (value) {
              managementFees = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildResultsSection() {
    if (!showResults) return Container();

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
          Row(
            children: [
              Expanded(
                child: Text(
                  "ROI Calculation Results",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              QButton(
                icon: Icons.save,
                size: bs.sm,
                onPressed: _saveCalculation,
              ),
            ],
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildResultCard(
                "Cash-on-Cash Return",
                "${cashOnCashReturn.toStringAsFixed(2)}%",
                Icons.trending_up,
                successColor,
              ),
              _buildResultCard(
                "Cap Rate",
                "${capRate.toStringAsFixed(2)}%",
                Icons.analytics,
                infoColor,
              ),
              _buildResultCard(
                "Monthly Cash Flow",
                "\$${(monthlyNetCashFlow).currency}",
                Icons.monetization_on,
                warningColor,
              ),
              _buildResultCard(
                "1% Rule",
                "${onePercentRule.toStringAsFixed(2)}%",
                Icons.percent,
                primaryColor,
              ),
            ],
          ),
          SizedBox(height: spMd),
          _buildDetailedResults(),
        ],
      ),
    );
  }

  Widget _buildResultCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              SizedBox(width: spSm),
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
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedResults() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Detailed Breakdown",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spSm),
        _buildResultRow("Total Cash Invested", "\$${(totalCashInvested).currency}"),
        _buildResultRow("Effective Monthly Rent", "\$${(effectiveMonthlyRent).currency}"),
        _buildResultRow("Monthly Mortgage Payment", "\$${(monthlyMortgagePayment).currency}"),
        _buildResultRow("Total Monthly Expenses", "\$${(totalMonthlyExpenses).currency}"),
        _buildResultRow("Annual Net Cash Flow", "\$${(annualNetCashFlow).currency}"),
        Divider(),
        _buildResultRow(
          "Investment Grade",
          _getInvestmentGrade(),
          isGrade: true,
        ),
      ],
    );
  }

  Widget _buildResultRow(String label, String value, {bool isGrade = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isGrade ? _getGradeColor() : primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  String _getInvestmentGrade() {
    if (cashOnCashReturn >= 15) return "Excellent";
    if (cashOnCashReturn >= 10) return "Good";
    if (cashOnCashReturn >= 5) return "Fair";
    return "Poor";
  }

  Color _getGradeColor() {
    String grade = _getInvestmentGrade();
    switch (grade) {
      case "Excellent": return successColor;
      case "Good": return infoColor;
      case "Fair": return warningColor;
      default: return dangerColor;
    }
  }

  Widget _buildHistoryItem(Map<String, dynamic> calculation) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,  
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${calculation["propertyName"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              QButton(
                label: "Load",
                size: bs.sm,
                onPressed: () => _loadCalculation(calculation),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ROI",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "${(calculation["roi"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 18,
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
                      "Cash Flow",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "\$${((calculation["cashFlow"] as double)).currency}",
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
                  children: [
                    Text(
                      "Cap Rate",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "${(calculation["capRate"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "Calculated: ${DateTime.parse(calculation["dateCalculated"]).dMMMy}",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ROI Calculator"),
        actions: [
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: _resetCalculator,
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
                  _buildInputSection(),
                  SizedBox(height: spMd),
                  _buildLoanSection(),
                  SizedBox(height: spMd),
                  _buildAssumptionsSection(),
                  SizedBox(height: spMd),
                  
                  // Calculate Button
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Calculate ROI",
                      size: bs.md,
                      onPressed: _calculateROI,
                    ),
                  ),
                  SizedBox(height: spMd),

                  _buildResultsSection(),
                  
                  if (showResults) SizedBox(height: spMd),

                  // Calculation History
                  Text(
                    "Calculation History",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...calculationHistory.map((calculation) => _buildHistoryItem(calculation)),
                ],
              ),
            ),
    );
  }
}
