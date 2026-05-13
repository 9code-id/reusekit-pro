import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaFinancingView extends StatefulWidget {
  const RmaFinancingView({Key? key}) : super(key: key);

  @override
  State<RmaFinancingView> createState() => _RmaFinancingViewState();
}

class _RmaFinancingViewState extends State<RmaFinancingView> {
  String selectedLoanType = "conventional";
  String creditScore = "750-850";
  String downPayment = "20";
  String loanAmount = "400000";
  String interestRate = "6.5";
  
  List<Map<String, dynamic>> loanTypes = [
    {"label": "Conventional Loan", "value": "conventional"},
    {"label": "FHA Loan", "value": "fha"},
    {"label": "VA Loan", "value": "va"},
    {"label": "USDA Loan", "value": "usda"},
  ];

  List<Map<String, dynamic>> creditScoreRanges = [
    {"label": "750-850 (Excellent)", "value": "750-850"},
    {"label": "700-749 (Good)", "value": "700-749"},
    {"label": "650-699 (Fair)", "value": "650-699"},
    {"label": "600-649 (Poor)", "value": "600-649"},
  ];

  List<Map<String, dynamic>> loanPrograms = [
    {
      "name": "First-Time Homebuyer Program",
      "description": "Special rates for first-time buyers",
      "rate": "5.8%",
      "minDown": "3%",
      "maxAmount": "500,000",
    },
    {
      "name": "Jumbo Loan Program",
      "description": "For high-value properties",
      "rate": "6.2%",
      "minDown": "20%",
      "maxAmount": "2,000,000",
    },
    {
      "name": "Investment Property Loan",
      "description": "For rental properties",
      "rate": "7.1%",
      "minDown": "25%",
      "maxAmount": "1,500,000",
    },
  ];

  List<Map<String, dynamic>> lenders = [
    {
      "name": "Prime Mortgage Solutions",
      "rating": 4.8,
      "rate": "6.25%",
      "fees": "1,200",
      "preApproval": "24 hours",
    },
    {
      "name": "HomeFirst Lending",
      "rating": 4.7,
      "rate": "6.35%",
      "fees": "950",
      "preApproval": "48 hours",
    },
    {
      "name": "Capital Bank Mortgage",
      "rating": 4.6,
      "rate": "6.45%",
      "fees": "800",
      "preApproval": "72 hours",
    },
  ];

  double calculateMonthlyPayment() {
    double principal = double.tryParse(loanAmount) ?? 0;
    double rate = (double.tryParse(interestRate) ?? 0) / 100 / 12;
    int n = 30 * 12; // 30 years
    
    if (rate == 0) return principal / n;
    
    return principal * (rate * Math.pow(1 + rate, n)) / (Math.pow(1 + rate, n) - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Financing Options"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Loan Calculator Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Loan Calculator",
                    style: TextStyle(
                      fontSize: fsH6,
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
                  Row(
                    children: [
                      Expanded(
                        child: QNumberField(
                          label: "Loan Amount (\$)",
                          value: loanAmount,
                          onChanged: (value) {
                            loanAmount = value;
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
                  QDropdownField(
                    label: "Credit Score Range",
                    items: creditScoreRanges,
                    value: creditScore,
                    onChanged: (value, label) {
                      creditScore = value;
                      setState(() {});
                    },
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Monthly Payment:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "\$${calculateMonthlyPayment().toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: 18,
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

            // Loan Programs Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Available Loan Programs",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...loanPrograms.map((program) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spXs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "${program["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                "${program["rate"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${program["description"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Min Down: ${program["minDown"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                              Text(
                                "Max: \$${program["maxAmount"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Recommended Lenders Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recommended Lenders",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...lenders.map((lender) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spXs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "${lender["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 16,
                                    color: warningColor,
                                  ),
                                  SizedBox(width: spXxs),
                                  Text(
                                    "${lender["rating"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Rate: ${lender["rate"]}",
                                  style: TextStyle(
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                "Fees: \$${lender["fees"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Pre-approval: ${lender["preApproval"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              QButton(
                                label: "Contact",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Action Buttons
            Column(
              spacing: spSm,
              children: [
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Get Pre-Approved",
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Schedule Consultation",
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
