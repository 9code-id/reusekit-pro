import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaEmiCalculatorView extends StatefulWidget {
  const BfaEmiCalculatorView({super.key});

  @override
  State<BfaEmiCalculatorView> createState() => _BfaEmiCalculatorViewState();
}

class _BfaEmiCalculatorViewState extends State<BfaEmiCalculatorView> {
  final formKey = GlobalKey<FormState>();
  
  String loanAmount = "500000";
  String interestRate = "12.5";
  String tenure = "36";
  String selectedTenureUnit = "months";
  
  List<Map<String, dynamic>> tenureUnits = [
    {"label": "Months", "value": "months"},
    {"label": "Years", "value": "years"},
  ];
  
  List<Map<String, dynamic>> loanTypes = [
    {"label": "Personal Loan", "value": "personal"},
    {"label": "Home Loan", "value": "home"},
    {"label": "Car Loan", "value": "car"},
    {"label": "Education Loan", "value": "education"},
  ];
  
  String selectedLoanType = "personal";
  bool showResults = false;
  
  double monthlyEmi = 0.0;
  double totalInterest = 0.0;
  double totalAmount = 0.0;
  
  List<Map<String, dynamic>> loanComparison = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EMI Calculator"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetCalculator,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCalculatorCard(),
              if (showResults) ...[
                _buildResultsCard(),
                _buildBreakdownCard(),
                _buildAmortizationChart(),
                _buildComparisonCard(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalculatorCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Loan Calculator",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Loan Type",
            items: loanTypes,
            value: selectedLoanType,
            onChanged: (value, label) {
              selectedLoanType = value;
              setState(() {});
            },
          ),
          QNumberField(
            label: "Loan Amount (₹)",
            value: loanAmount,
            validator: Validator.required,
            onChanged: (value) {
              loanAmount = value;
              setState(() {});
            },
          ),
          QNumberField(
            label: "Interest Rate (% per annum)",
            value: interestRate,
            validator: Validator.required,
            onChanged: (value) {
              interestRate = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: QNumberField(
                  label: "Tenure",
                  value: tenure,
                  validator: Validator.required,
                  onChanged: (value) {
                    tenure = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Unit",
                  items: tenureUnits,
                  value: selectedTenureUnit,
                  onChanged: (value, label) {
                    selectedTenureUnit = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Calculate EMI",
              size: bs.md,
              onPressed: _calculateEmi,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [successColor, successColor.withAlpha(200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Text(
            "EMI Calculation Results",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildResultItem(
                  "Monthly EMI",
                  "₹${monthlyEmi.currency}",
                  Icons.payment,
                ),
              ),
              Container(
                width: 1,
                height: 60,
                color: Colors.white.withAlpha(100),
              ),
              Expanded(
                child: _buildResultItem(
                  "Total Interest",
                  "₹${totalInterest.currency}",
                  Icons.trending_up,
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Text(
                  "Total Amount Payable",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
                Text(
                  "₹${totalAmount.currency}",
                  style: TextStyle(
                    fontSize: fsH3,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
        SizedBox(height: spXs),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withAlpha(200),
          ),
        ),
        Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildBreakdownCard() {
    double principalPercentage = ((double.tryParse(loanAmount) ?? 0) / totalAmount) * 100;
    double interestPercentage = (totalInterest / totalAmount) * 100;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: principalPercentage.toInt(),
                child: Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radiusSm),
                      bottomLeft: Radius.circular(radiusSm),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: interestPercentage.toInt(),
                child: Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: warningColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(radiusSm),
                      bottomRight: Radius.circular(radiusSm),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Principal (${principalPercentage.toStringAsFixed(1)}%)",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: warningColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Interest (${interestPercentage.toStringAsFixed(1)}%)",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Principal Amount:",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "₹${(double.tryParse(loanAmount) ?? 0).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Interest:",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "₹${totalInterest.currency}",
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
  }

  Widget _buildAmortizationChart() {
    int totalMonths = selectedTenureUnit == "years" 
        ? (int.tryParse(tenure) ?? 0) * 12 
        : (int.tryParse(tenure) ?? 0);
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Amortization Schedule (First 6 Months)",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...List.generate(6.clamp(0, totalMonths), (index) {
            double remainingPrincipal = (double.tryParse(loanAmount) ?? 0) - (monthlyEmi * index);
            double interestPayment = remainingPrincipal * ((double.tryParse(interestRate) ?? 0) / 100 / 12);
            double principalPayment = monthlyEmi - interestPayment;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: index % 2 == 0 ? disabledColor.withAlpha(50) : Colors.transparent,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Month ${index + 1}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "₹${principalPayment.toStringAsFixed(0)}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "₹${interestPayment.toStringAsFixed(0)}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "₹${remainingPrincipal.toStringAsFixed(0)}",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Month",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Principal",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Interest",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Balance",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Loan Comparison",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Compare different scenarios",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          ...List.generate(3, (index) {
            double rate = (double.tryParse(interestRate) ?? 0) + (index * 1.0);
            double emi = _calculateEmiAmount(
              double.tryParse(loanAmount) ?? 0,
              rate,
              selectedTenureUnit == "years" 
                  ? (int.tryParse(tenure) ?? 0) * 12 
                  : (int.tryParse(tenure) ?? 0),
            );
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: index == 0 ? primaryColor.withAlpha(25) : Colors.transparent,
                borderRadius: BorderRadius.circular(radiusSm),
                border: index == 0 ? Border.all(color: primaryColor, width: 1) : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${rate.toStringAsFixed(1)}% p.a.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: index == 0 ? FontWeight.bold : FontWeight.normal,
                      color: index == 0 ? primaryColor : disabledBoldColor,
                    ),
                  ),
                  Text(
                    "₹${emi.currency}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: index == 0 ? FontWeight.bold : FontWeight.w600,
                      color: index == 0 ? primaryColor : disabledBoldColor,
                    ),
                  ),
                  Text(
                    index == 0 
                        ? "Current" 
                        : "${((emi - monthlyEmi) / monthlyEmi * 100).toStringAsFixed(1)}% more",
                    style: TextStyle(
                      fontSize: 12,
                      color: index == 0 ? primaryColor : warningColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Apply for This Loan",
              size: bs.md,
              onPressed: () {
                // Navigate to loan application
              },
            ),
          ),
        ],
      ),
    );
  }

  void _calculateEmi() {
    if (!formKey.currentState!.validate()) return;
    
    double principal = double.tryParse(loanAmount) ?? 0;
    double rate = (double.tryParse(interestRate) ?? 0) / 100 / 12;
    int months = selectedTenureUnit == "years" 
        ? (int.tryParse(tenure) ?? 0) * 12 
        : (int.tryParse(tenure) ?? 0);
    
    if (principal > 0 && rate > 0 && months > 0) {
      monthlyEmi = _calculateEmiAmount(principal, (double.tryParse(interestRate) ?? 0), months);
      totalAmount = monthlyEmi * months;
      totalInterest = totalAmount - principal;
      showResults = true;
      setState(() {});
    }
  }

  double _calculateEmiAmount(double principal, double annualRate, int months) {
    double monthlyRate = annualRate / 100 / 12;
    if (monthlyRate == 0) return principal / months;
    
    double emi = principal * monthlyRate * (pow(1 + monthlyRate, months)) / 
                 ((pow(1 + monthlyRate, months)) - 1);
    return emi;
  }

  double pow(double base, int exponent) {
    double result = 1;
    for (int i = 0; i < exponent; i++) {
      result *= base;
    }
    return result;
  }

  void _resetCalculator() {
    loanAmount = "500000";
    interestRate = "12.5";
    tenure = "36";
    selectedTenureUnit = "months";
    selectedLoanType = "personal";
    showResults = false;
    monthlyEmi = 0.0;
    totalInterest = 0.0;
    totalAmount = 0.0;
    setState(() {});
  }
}
