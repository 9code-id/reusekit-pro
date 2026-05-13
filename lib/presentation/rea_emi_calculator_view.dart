import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaEmiCalculatorView extends StatefulWidget {
  const ReaEmiCalculatorView({super.key});

  @override
  State<ReaEmiCalculatorView> createState() => _ReaEmiCalculatorViewState();
}

class _ReaEmiCalculatorViewState extends State<ReaEmiCalculatorView> {
  final formKey = GlobalKey<FormState>();
  
  String loanAmount = "5000000";
  String interestRate = "8.5";
  String loanTenure = "20";
  String tenureType = "years";
  String processingFee = "1.0";
  bool includeInsurance = false;
  String insuranceAmount = "50000";
  
  double monthlyEmi = 0.0;
  double totalPayment = 0.0;
  double totalInterest = 0.0;
  double processingFeeAmount = 0.0;
  double totalInsurance = 0.0;
  double totalCost = 0.0;
  
  List<Map<String, dynamic>> amortizationSchedule = [];
  int selectedTab = 0;
  
  List<Map<String, dynamic>> tenureOptions = [
    {"label": "Years", "value": "years"},
    {"label": "Months", "value": "months"},
  ];
  
  List<Map<String, dynamic>> presetAmounts = [
    {"label": "₹10 Lac", "value": "1000000"},
    {"label": "₹25 Lac", "value": "2500000"},
    {"label": "₹50 Lac", "value": "5000000"},
    {"label": "₹1 Crore", "value": "10000000"},
  ];
  
  List<Map<String, dynamic>> presetRates = [
    {"label": "7.5%", "value": "7.5"},
    {"label": "8.0%", "value": "8.0"},
    {"label": "8.5%", "value": "8.5"},
    {"label": "9.0%", "value": "9.0"},
  ];

  @override
  void initState() {
    super.initState();
    _calculateEmi();
  }

  void _calculateEmi() {
    try {
      double principal = double.parse(loanAmount);
      double rate = double.parse(interestRate) / 100 / 12; // Monthly rate
      int tenure = tenureType == "years" ? 
        (int.parse(loanTenure) * 12) : int.parse(loanTenure);
      
      if (principal > 0 && rate > 0 && tenure > 0) {
        // EMI calculation using formula
        double emi = (principal * rate * Math.pow(1 + rate, tenure)) / 
                    (Math.pow(1 + rate, tenure) - 1);
        
        monthlyEmi = emi;
        totalPayment = emi * tenure;
        totalInterest = totalPayment - principal;
        processingFeeAmount = principal * (double.parse(processingFee) / 100);
        totalInsurance = includeInsurance ? double.parse(insuranceAmount) * tenure / 12 : 0.0;
        totalCost = totalPayment + processingFeeAmount + totalInsurance;
        
        _generateAmortizationSchedule(principal, rate, tenure, emi);
      }
    } catch (e) {
      monthlyEmi = 0.0;
      totalPayment = 0.0;
      totalInterest = 0.0;
      totalCost = 0.0;
    }
    setState(() {});
  }
  
  void _generateAmortizationSchedule(double principal, double rate, int tenure, double emi) {
    amortizationSchedule.clear();
    double balance = principal;
    
    for (int i = 1; i <= Math.min(tenure, 60); i++) { // Show first 5 years max
      double interestPayment = balance * rate;
      double principalPayment = emi - interestPayment;
      balance -= principalPayment;
      
      amortizationSchedule.add({
        "month": i,
        "emi": emi,
        "principal": principalPayment,
        "interest": interestPayment,
        "balance": Math.max(0, balance),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EMI Calculator"),
        actions: [
          IconButton(
            onPressed: () {
              // Share EMI calculation
            },
            icon: Icon(Icons.share),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            // Tab Bar
            Container(
              margin: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        selectedTab = 0;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: spSm),
                        decoration: BoxDecoration(
                          color: selectedTab == 0 ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Text(
                          "Calculator",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: selectedTab == 0 ? Colors.white : disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        selectedTab = 1;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: spSm),
                        decoration: BoxDecoration(
                          color: selectedTab == 1 ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Text(
                          "Schedule",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: selectedTab == 1 ? Colors.white : disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: selectedTab == 0 ? _buildCalculatorTab() : _buildScheduleTab(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalculatorTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Loan Amount
          Text(
            "Loan Amount",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QNumberField(
            label: "Enter loan amount",
            value: loanAmount,
            validator: Validator.required,
            onChanged: (value) {
              loanAmount = value;
              _calculateEmi();
            },
          ),
          SizedBox(height: spSm),
          
          // Preset Amount Buttons
          QHorizontalScroll(
            children: presetAmounts.map((amount) {
              bool isSelected = loanAmount == amount["value"];
              return GestureDetector(
                onTap: () {
                  loanAmount = amount["value"];
                  _calculateEmi();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                  margin: EdgeInsets.only(right: spSm),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.white,
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                    ),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${amount["label"]}",
                    style: TextStyle(
                      color: isSelected ? Colors.white : disabledBoldColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          
          SizedBox(height: spLg),
          
          // Interest Rate
          Text(
            "Interest Rate (% per annum)",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QNumberField(
            label: "Enter interest rate",
            value: interestRate,
            validator: Validator.required,
            onChanged: (value) {
              interestRate = value;
              _calculateEmi();
            },
          ),
          SizedBox(height: spSm),
          
          // Preset Rate Buttons
          QHorizontalScroll(
            children: presetRates.map((rate) {
              bool isSelected = interestRate == rate["value"];
              return GestureDetector(
                onTap: () {
                  interestRate = rate["value"];
                  _calculateEmi();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                  margin: EdgeInsets.only(right: spSm),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.white,
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                    ),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${rate["label"]}",
                    style: TextStyle(
                      color: isSelected ? Colors.white : disabledBoldColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          
          SizedBox(height: spLg),
          
          // Loan Tenure
          Text(
            "Loan Tenure",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: QNumberField(
                  label: "Enter tenure",
                  value: loanTenure,
                  validator: Validator.required,
                  onChanged: (value) {
                    loanTenure = value;
                    _calculateEmi();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Period",
                  items: tenureOptions,
                  value: tenureType,
                  onChanged: (value, label) {
                    tenureType = value;
                    _calculateEmi();
                  },
                ),
              ),
            ],
          ),
          
          SizedBox(height: spLg),
          
          // Processing Fee
          Text(
            "Processing Fee (%)",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QNumberField(
            label: "Enter processing fee percentage",
            value: processingFee,
            onChanged: (value) {
              processingFee = value;
              _calculateEmi();
            },
          ),
          
          SizedBox(height: spLg),
          
          // Insurance
          QSwitch(
            items: [
              {
                "label": "Include Home Insurance",
                "value": true,
                "checked": includeInsurance,
              }
            ],
            value: [
              if (includeInsurance)
                {
                  "label": "Include Home Insurance",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              includeInsurance = values.isNotEmpty;
              _calculateEmi();
            },
          ),
          
          if (includeInsurance) ...[
            SizedBox(height: spSm),
            QNumberField(
              label: "Annual insurance premium",
              value: insuranceAmount,
              onChanged: (value) {
                insuranceAmount = value;
                _calculateEmi();
              },
            ),
          ],
          
          SizedBox(height: spXl),
          
          // EMI Results
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(200)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowLg],
            ),
            child: Column(
              children: [
                Text(
                  "Monthly EMI",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "₹${monthlyEmi.toStringAsFixed(0).currency}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spLg),
          
          // Detailed Breakdown
          _buildResultCard("Total Payment", "₹${totalPayment.toStringAsFixed(0).currency}"),
          SizedBox(height: spSm),
          _buildResultCard("Total Interest", "₹${totalInterest.toStringAsFixed(0).currency}"),
          SizedBox(height: spSm),
          _buildResultCard("Processing Fee", "₹${processingFeeAmount.toStringAsFixed(0).currency}"),
          if (includeInsurance) ...[
            SizedBox(height: spSm),
            _buildResultCard("Total Insurance", "₹${totalInsurance.toStringAsFixed(0).currency}"),
          ],
          SizedBox(height: spSm),
          _buildResultCard("Total Cost", "₹${totalCost.toStringAsFixed(0).currency}", isHighlighted: true),
          
          SizedBox(height: spXl),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Download Report",
                  icon: Icons.download,
                  size: bs.md,
                  onPressed: () {
                    // Download EMI report
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Apply for Loan",
                  size: bs.md,
                  onPressed: () {
                    // Navigate to loan application
                  },
                ),
              ),
            ],
          ),
          
          SizedBox(height: spLg),
        ],
      ),
    );
  }

  Widget _buildScheduleTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Amortization Schedule",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Showing first ${Math.min(amortizationSchedule.length, 60)} payments",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          SizedBox(height: spLg),
          
          // Table Header
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusMd),
                topRight: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Month",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "EMI",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Principal",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Interest",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Balance",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Table Rows
          ...amortizationSchedule.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> row = entry.value;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: index % 2 == 0 ? Colors.grey[50] : Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: disabledOutlineBorderColor,
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "${row["month"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "₹${(row["emi"] as double).toStringAsFixed(0)}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "₹${(row["principal"] as double).toStringAsFixed(0)}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: successColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "₹${(row["interest"] as double).toStringAsFixed(0)}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: warningColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "₹${(row["balance"] as double).toStringAsFixed(0)}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          
          if (amortizationSchedule.length >= 60) ...[
            SizedBox(height: spLg),
            Container(
              width: double.infinity,
              child: QButton(
                label: "View Complete Schedule",
                size: bs.md,
                onPressed: () {
                  // Show complete amortization schedule
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildResultCard(String title, String value, {bool isHighlighted = false}) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: isHighlighted ? primaryColor.withAlpha(30) : Colors.white,
        border: Border.all(
          color: isHighlighted ? primaryColor : disabledOutlineBorderColor,
          width: isHighlighted ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: isHighlighted ? [shadowSm] : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isHighlighted ? primaryColor : disabledBoldColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: isHighlighted ? primaryColor : primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
