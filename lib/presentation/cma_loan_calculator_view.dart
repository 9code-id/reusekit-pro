import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';
import 'dart:math' as Math;

class CmaLoanCalculatorView extends StatefulWidget {
  const CmaLoanCalculatorView({super.key});

  @override
  State<CmaLoanCalculatorView> createState() => _CmaLoanCalculatorViewState();
}

class _CmaLoanCalculatorViewState extends State<CmaLoanCalculatorView> {
  String vehiclePrice = "35000";
  String downPayment = "7000";
  String loanTerm = "60";
  String interestRate = "4.5";
  String tradeInValue = "0";
  String salesTax = "8.5";
  String dealerFees = "500";
  String insuranceCost = "150";

  bool includeInsurance = true;
  bool includeTax = true;
  bool includeWarranty = false;
  String warrantyPrice = "2500";

  List<Map<String, dynamic>> loanTermOptions = [
    {"label": "36 months", "value": "36"},
    {"label": "48 months", "value": "48"},
    {"label": "60 months", "value": "60"},
    {"label": "72 months", "value": "72"},
    {"label": "84 months", "value": "84"},
  ];

  List<Map<String, dynamic>> paymentHistory = [];

  double get totalVehiclePrice {
    double price = double.tryParse(vehiclePrice) ?? 0;
    double tax = includeTax ? (price * (double.tryParse(salesTax) ?? 0) / 100) : 0;
    double fees = double.tryParse(dealerFees) ?? 0;
    double warranty = includeWarranty ? (double.tryParse(warrantyPrice) ?? 0) : 0;
    return price + tax + fees + warranty;
  }

  double get loanAmount {
    return totalVehiclePrice - (double.tryParse(downPayment) ?? 0) - (double.tryParse(tradeInValue) ?? 0);
  }

  double get monthlyPayment {
    final principal = loanAmount;
    final rate = (double.tryParse(interestRate) ?? 0) / 100 / 12;
    final months = double.tryParse(loanTerm) ?? 60;
    
    if (rate == 0) return principal / months;
    
    return principal * (rate * Math.pow(1 + rate, months)) / (Math.pow(1 + rate, months) - 1);
  }

  double get totalInterest {
    return (monthlyPayment * (double.tryParse(loanTerm) ?? 60)) - loanAmount;
  }

  double get totalCost {
    return totalVehiclePrice + totalInterest;
  }

  double get monthlyTotal {
    double payment = monthlyPayment;
    if (includeInsurance) {
      payment += double.tryParse(insuranceCost) ?? 0;
    }
    return payment;
  }

  void _generatePaymentSchedule() {
    paymentHistory.clear();
    double balance = loanAmount;
    final rate = (double.tryParse(interestRate) ?? 0) / 100 / 12;
    final payment = monthlyPayment;
    
    for (int i = 1; i <= (int.tryParse(loanTerm) ?? 60); i++) {
      double interestPayment = balance * rate;
      double principalPayment = payment - interestPayment;
      balance -= principalPayment;
      
      paymentHistory.add({
        "month": i,
        "payment": payment,
        "principal": principalPayment,
        "interest": interestPayment,
        "balance": balance < 0 ? 0 : balance,
      });
      
      if (balance <= 0) break;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loan Calculator"),
        actions: [
          IconButton(
            onPressed: () {
              _showSaveCalculation();
            },
            icon: Icon(Icons.bookmark),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vehicle Information
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Vehicle Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  QNumberField(
                    label: "Vehicle Price (\$)",
                    value: vehiclePrice,
                    onChanged: (value) {
                      vehiclePrice = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  
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
                          label: "Trade-in Value (\$)",
                          value: tradeInValue,
                          onChanged: (value) {
                            tradeInValue = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Loan Terms
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Loan Terms",
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
                        child: QDropdownField(
                          label: "Loan Term",
                          items: loanTermOptions,
                          value: loanTerm,
                          onChanged: (value, label) {
                            loanTerm = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
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
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Additional Costs
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
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
                  SizedBox(height: spSm),

                  // Tax Toggle
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Include Sales Tax",
                              "value": true,
                              "checked": includeTax,
                            }
                          ],
                          value: [
                            if (includeTax)
                              {
                                "label": "Include Sales Tax",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            includeTax = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                      if (includeTax) ...[
                        SizedBox(width: spSm),
                        Container(
                          width: 100,
                          child: QNumberField(
                            label: "Tax Rate (%)",
                            value: salesTax,
                            onChanged: (value) {
                              salesTax = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ],
                  ),

                  SizedBox(height: spSm),

                  Row(
                    children: [
                      Expanded(
                        child: QNumberField(
                          label: "Dealer Fees (\$)",
                          value: dealerFees,
                          onChanged: (value) {
                            dealerFees = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QNumberField(
                          label: "Monthly Insurance (\$)",
                          value: insuranceCost,
                          onChanged: (value) {
                            insuranceCost = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spSm),

                  // Warranty Toggle
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Extended Warranty",
                              "value": true,
                              "checked": includeWarranty,
                            }
                          ],
                          value: [
                            if (includeWarranty)
                              {
                                "label": "Extended Warranty",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            includeWarranty = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                      if (includeWarranty) ...[
                        SizedBox(width: spSm),
                        Container(
                          width: 120,
                          child: QNumberField(
                            label: "Warranty Cost (\$)",
                            value: warrantyPrice,
                            onChanged: (value) {
                              warrantyPrice = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Payment Summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Payment Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),

                  // Main Payment Display
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "\$${monthlyPayment.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Monthly Loan Payment",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                        if (includeInsurance) ...[
                          SizedBox(height: spXs),
                          Text(
                            "+ \$${insuranceCost} insurance = \$${monthlyTotal.toStringAsFixed(2)} total",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  SizedBox(height: spSm),

                  // Breakdown
                  Column(
                    children: [
                      _buildSummaryRow("Vehicle Price", "\$${(double.tryParse(vehiclePrice) ?? 0).currency}"),
                      if (includeTax)
                        _buildSummaryRow("Sales Tax (${salesTax}%)", "\$${(totalVehiclePrice - (double.tryParse(vehiclePrice) ?? 0) - (double.tryParse(dealerFees) ?? 0) - (includeWarranty ? (double.tryParse(warrantyPrice) ?? 0) : 0)).currency}"),
                      if (double.tryParse(dealerFees) != 0)
                        _buildSummaryRow("Dealer Fees", "\$${(double.tryParse(dealerFees) ?? 0).currency}"),
                      if (includeWarranty)
                        _buildSummaryRow("Extended Warranty", "\$${(double.tryParse(warrantyPrice) ?? 0).currency}"),
                      _buildSummaryRow("Total Vehicle Price", "\$${totalVehiclePrice.currency}", isTotal: true),
                      _buildSummaryRow("Down Payment", "-\$${(double.tryParse(downPayment) ?? 0).currency}", isNegative: true),
                      if (double.tryParse(tradeInValue) != 0)
                        _buildSummaryRow("Trade-in Value", "-\$${(double.tryParse(tradeInValue) ?? 0).currency}", isNegative: true),
                      _buildSummaryRow("Loan Amount", "\$${loanAmount.currency}", isLoan: true),
                      _buildSummaryRow("Total Interest", "\$${totalInterest.currency}"),
                      _buildSummaryRow("Total of Payments", "\$${totalCost.currency}", isTotal: true),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Payment Schedule",
                    size: bs.md,
                    onPressed: () {
                      _generatePaymentSchedule();
                      _showPaymentSchedule();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Compare Rates",
                    size: bs.md,
                    onPressed: () {
                      _showRateComparison();
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

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false, bool isNegative = false, bool isLoan = false}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spXs),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: disabledOutlineBorderColor.withAlpha(100))),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: isTotal ? 14 : 13,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: isTotal ? primaryColor : disabledBoldColor,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 14 : 13,
              fontWeight: isTotal || isLoan ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? primaryColor : 
                     isNegative ? successColor :
                     isLoan ? warningColor : disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showPaymentSchedule() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Payment Schedule",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Schedule Header
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Container(width: 50, child: Text("Month", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor))),
                  Expanded(child: Text("Payment", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor))),
                  Expanded(child: Text("Principal", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor))),
                  Expanded(child: Text("Interest", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor))),
                  Expanded(child: Text("Balance", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor))),
                ],
              ),
            ),
            
            SizedBox(height: spSm),
            
            // Schedule List
            Expanded(
              child: ListView.builder(
                itemCount: paymentHistory.length,
                itemBuilder: (context, index) {
                  final payment = paymentHistory[index];
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: 1),
                    decoration: BoxDecoration(
                      color: index % 2 == 0 ? Colors.grey.withAlpha(30) : Colors.white,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50, 
                          child: Text(
                            "${payment["month"]}",
                            style: TextStyle(fontSize: 12, color: disabledBoldColor),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "\$${(payment["payment"] as double).toStringAsFixed(2)}",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12, color: primaryColor),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "\$${(payment["principal"] as double).toStringAsFixed(2)}",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12, color: successColor),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "\$${(payment["interest"] as double).toStringAsFixed(2)}",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12, color: warningColor),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "\$${(payment["balance"] as double).toStringAsFixed(2)}",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12, color: disabledBoldColor),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRateComparison() {
    List<double> rates = [3.5, 4.0, 4.5, 5.0, 5.5, 6.0];
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Rate Comparison",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            Expanded(
              child: ListView.builder(
                itemCount: rates.length,
                itemBuilder: (context, index) {
                  final rate = rates[index];
                  final monthlyRate = rate / 100 / 12;
                  final months = double.tryParse(loanTerm) ?? 60;
                  final payment = loanAmount * (monthlyRate * Math.pow(1 + monthlyRate, months)) / (Math.pow(1 + monthlyRate, months) - 1);
                  final totalInterestAtRate = (payment * months) - loanAmount;
                  
                  final isCurrentRate = rate == (double.tryParse(interestRate) ?? 0);
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isCurrentRate ? primaryColor.withAlpha(30) : Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isCurrentRate ? primaryColor : disabledOutlineBorderColor,
                      ),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${rate}% APR",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Interest: \$${totalInterestAtRate.toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "\$${payment.toStringAsFixed(2)}/mo",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isCurrentRate ? primaryColor : disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSaveCalculation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Save Calculation"),
        content: Text("Save this loan calculation for future reference?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ss("Calculation saved successfully");
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }
}
