import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaMortgageCalculatorView extends StatefulWidget {
  const ReaMortgageCalculatorView({super.key});

  @override
  State<ReaMortgageCalculatorView> createState() => _ReaMortgageCalculatorViewState();
}

class _ReaMortgageCalculatorViewState extends State<ReaMortgageCalculatorView> {
  String homePrice = "850000";
  String downPayment = "170000";
  String loanTerm = "30";
  String interestRate = "6.5";
  String propertyTax = "8500";
  String homeInsurance = "1200";
  String pmiInsurance = "350";
  String hoaFees = "350";
  
  String downPaymentType = "amount"; // amount or percentage
  String calculationMode = "payment"; // payment or affordability
  
  bool includePropertyTax = true;
  bool includeInsurance = true;
  bool includePMI = true;
  bool includeHOA = true;
  
  List<Map<String, dynamic>> loanTermOptions = [
    {"label": "15 years", "value": "15"},
    {"label": "20 years", "value": "20"},
    {"label": "25 years", "value": "25"},
    {"label": "30 years", "value": "30"},
  ];

  List<Map<String, dynamic>> calculationModes = [
    {"label": "Monthly Payment", "value": "payment", "icon": Icons.calculate},
    {"label": "Affordability", "value": "affordability", "icon": Icons.home},
  ];

  // Calculation Results
  double get homePriceValue => double.tryParse(homePrice) ?? 0;
  double get downPaymentValue {
    if (downPaymentType == "percentage") {
      double percentage = double.tryParse(downPayment) ?? 0;
      return homePriceValue * (percentage / 100);
    }
    return double.tryParse(downPayment) ?? 0;
  }
  double get loanAmount => homePriceValue - downPaymentValue;
  double get monthlyInterestRate => (double.tryParse(interestRate) ?? 0) / 100 / 12;
  int get numberOfPayments => ((double.tryParse(loanTerm) ?? 0) * 12).toInt();
  
  double get monthlyPrincipalAndInterest {
    if (monthlyInterestRate == 0 || numberOfPayments == 0) return 0;
    
    double r = monthlyInterestRate;
    int n = numberOfPayments;
    double p = loanAmount;
    
    return p * (r * Math.pow(1 + r, n)) / (Math.pow(1 + r, n) - 1);
  }
  
  double get monthlyPropertyTax => 
      includePropertyTax ? (double.tryParse(propertyTax) ?? 0) / 12 : 0;
  double get monthlyInsurance => 
      includeInsurance ? (double.tryParse(homeInsurance) ?? 0) / 12 : 0;
  double get monthlyPMI => 
      includePMI && (downPaymentValue / homePriceValue) < 0.2 
          ? (double.tryParse(pmiInsurance) ?? 0) / 12 : 0;
  double get monthlyHOA => 
      includeHOA ? (double.tryParse(hoaFees) ?? 0) / 12 : 0;
  
  double get totalMonthlyPayment => 
      monthlyPrincipalAndInterest + monthlyPropertyTax + 
      monthlyInsurance + monthlyPMI + monthlyHOA;
  
  double get totalLoanCost => monthlyPrincipalAndInterest * numberOfPayments;
  double get totalInterest => totalLoanCost - loanAmount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mortgage Calculator"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveCalculation();
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              _shareCalculation();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Calculator Mode Toggle
                  Text(
                    "Calculator Mode",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  QCategoryPicker(
                    items: calculationModes.map((mode) => {
                      "label": mode["label"],
                      "value": mode["value"],
                    }).toList(),
                    value: calculationMode,
                    onChanged: (index, label, value, item) {
                      calculationMode = value;
                      setState(() {});
                    },
                  ),

                  SizedBox(height: spLg),

                  // Input Section
                  _buildInputSection(),

                  SizedBox(height: spLg),

                  // Results Section
                  _buildResultsSection(),

                  SizedBox(height: spLg),

                  // Breakdown Section
                  _buildBreakdownSection(),

                  SizedBox(height: spLg),

                  // Additional Options
                  _buildAdditionalOptionsSection(),
                ],
              ),
            ),
          ),

          // Bottom Action Bar
          _buildBottomActionBar(),
        ],
      ),
    );
  }

  Widget _buildInputSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Loan Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          // Home Price
          QNumberField(
            label: "Home Price (\$)",
            value: homePrice,
            onChanged: (value) {
              homePrice = value;
              setState(() {});
            },
          ),

          SizedBox(height: spMd),

          // Down Payment
          Row(
            children: [
              Expanded(
                flex: 3,
                child: QNumberField(
                  label: downPaymentType == "amount" 
                      ? "Down Payment (\$)" 
                      : "Down Payment (%)",
                  value: downPayment,
                  onChanged: (value) {
                    downPayment = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Type",
                  items: [
                    {"label": "Amount", "value": "amount"},
                    {"label": "Percent", "value": "percentage"},
                  ],
                  value: downPaymentType,
                  onChanged: (value, label) {
                    downPaymentType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          SizedBox(height: spMd),

          // Loan Term
          QDropdownField(
            label: "Loan Term",
            items: loanTermOptions,
            value: loanTerm,
            onChanged: (value, label) {
              loanTerm = value;
              setState(() {});
            },
          ),

          SizedBox(height: spMd),

          // Interest Rate
          QNumberField(
            label: "Interest Rate (%)",
            value: interestRate,
            onChanged: (value) {
              interestRate = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildResultsSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: successColor.withAlpha(50)),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.calculate,
                color: successColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Monthly Payment Breakdown",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),

          // Main Monthly Payment
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: successColor.withAlpha(50)),
            ),
            child: Column(
              children: [
                Text(
                  "Total Monthly Payment",
                  style: TextStyle(
                    fontSize: 16,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "\$${totalMonthlyPayment.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: fsH3,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Payment Breakdown
          _buildPaymentRow(
            "Principal & Interest",
            monthlyPrincipalAndInterest,
            primaryColor,
          ),
          if (includePropertyTax) ...[
            _buildPaymentRow(
              "Property Tax",
              monthlyPropertyTax,
              secondaryColor,
            ),
          ],
          if (includeInsurance) ...[
            _buildPaymentRow(
              "Home Insurance",
              monthlyInsurance,
              infoColor,
            ),
          ],
          if (includePMI && monthlyPMI > 0) ...[
            _buildPaymentRow(
              "PMI Insurance",
              monthlyPMI,
              warningColor,
            ),
          ],
          if (includeHOA) ...[
            _buildPaymentRow(
              "HOA Fees",
              monthlyHOA,
              disabledBoldColor,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPaymentRow(String label, double amount, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ),
          Text(
            "\$${amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Loan Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          _buildSummaryRow("Home Price", homePriceValue),
          _buildSummaryRow("Down Payment", downPaymentValue),
          _buildSummaryRow("Loan Amount", loanAmount),
          
          Divider(color: disabledOutlineBorderColor),
          
          _buildSummaryRow("Total of Payments", totalLoanCost),
          _buildSummaryRow("Total Interest", totalInterest),
          
          SizedBox(height: spMd),
          
          // Down Payment Percentage
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: (downPaymentValue / homePriceValue) >= 0.2 
                  ? successColor.withAlpha(20)
                  : warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(
                color: (downPaymentValue / homePriceValue) >= 0.2 
                    ? successColor
                    : warningColor,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  (downPaymentValue / homePriceValue) >= 0.2 
                      ? Icons.check_circle
                      : Icons.warning,
                  color: (downPaymentValue / homePriceValue) >= 0.2 
                      ? successColor
                      : warningColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Down Payment: ${((downPaymentValue / homePriceValue) * 100).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: (downPaymentValue / homePriceValue) >= 0.2 
                              ? successColor
                              : warningColor,
                        ),
                      ),
                      if ((downPaymentValue / homePriceValue) < 0.2) ...[
                        Text(
                          "PMI required (less than 20% down)",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
            ),
          ),
          Text(
            "\$${amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalOptionsSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Additional Costs",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          // Property Tax
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Include Property Tax",
                      "value": true,
                      "checked": includePropertyTax,
                    }
                  ],
                  value: [
                    if (includePropertyTax)
                      {
                        "label": "Include Property Tax",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    includePropertyTax = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          if (includePropertyTax) ...[
            SizedBox(height: spSm),
            QNumberField(
              label: "Annual Property Tax (\$)",
              value: propertyTax,
              onChanged: (value) {
                propertyTax = value;
                setState(() {});
              },
            ),
          ],

          SizedBox(height: spMd),

          // Home Insurance
          Row(
            children: [
              Expanded(
                child: QSwitch(
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
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          if (includeInsurance) ...[
            SizedBox(height: spSm),
            QNumberField(
              label: "Annual Home Insurance (\$)",
              value: homeInsurance,
              onChanged: (value) {
                homeInsurance = value;
                setState(() {});
              },
            ),
          ],

          SizedBox(height: spMd),

          // PMI
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Include PMI (if applicable)",
                      "value": true,
                      "checked": includePMI,
                    }
                  ],
                  value: [
                    if (includePMI)
                      {
                        "label": "Include PMI (if applicable)",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    includePMI = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          if (includePMI) ...[
            SizedBox(height: spSm),
            QNumberField(
              label: "Annual PMI (\$)",
              value: pmiInsurance,
              onChanged: (value) {
                pmiInsurance = value;
                setState(() {});
              },
            ),
          ],

          SizedBox(height: spMd),

          // HOA Fees
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Include HOA Fees",
                      "value": true,
                      "checked": includeHOA,
                    }
                  ],
                  value: [
                    if (includeHOA)
                      {
                        "label": "Include HOA Fees",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    includeHOA = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          if (includeHOA) ...[
            SizedBox(height: spSm),
            QNumberField(
              label: "Monthly HOA Fees (\$)",
              value: hoaFees,
              onChanged: (value) {
                hoaFees = value;
                setState(() {});
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBottomActionBar() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowMd],
      ),
      child: Row(
        children: [
          Expanded(
            child: QButton(
              label: "Reset Calculator",
              size: bs.md,
              onPressed: () {
                _resetCalculator();
              },
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: QButton(
              label: "Get Pre-Approved",
              size: bs.md,
              onPressed: () {
                _getPreApproved();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _saveCalculation() {
    ss("Mortgage calculation saved!");
  }

  void _shareCalculation() {
    ss("Sharing mortgage calculation...");
  }

  void _resetCalculator() {
    homePrice = "850000";
    downPayment = "170000";
    loanTerm = "30";
    interestRate = "6.5";
    propertyTax = "8500";
    homeInsurance = "1200";
    pmiInsurance = "350";
    hoaFees = "350";
    setState(() {});
  }

  void _getPreApproved() {
    ss("Redirecting to pre-approval application...");
  }
}
