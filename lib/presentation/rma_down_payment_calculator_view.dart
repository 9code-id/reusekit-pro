import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaDownPaymentCalculatorView extends StatefulWidget {
  const RmaDownPaymentCalculatorView({Key? key}) : super(key: key);

  @override
  State<RmaDownPaymentCalculatorView> createState() => _RmaDownPaymentCalculatorViewState();
}

class _RmaDownPaymentCalculatorViewState extends State<RmaDownPaymentCalculatorView> {
  String homePrice = "500000";
  String downPaymentPercentage = "20";
  String downPaymentAmount = "100000";
  String loanType = "conventional";
  String creditScore = "740";
  String monthlyIncome = "8000";
  String currentSavings = "75000";
  String monthlySavings = "2000";
  
  bool usePercentage = true;

  List<Map<String, dynamic>> loanTypes = [
    {"label": "Conventional", "value": "conventional"},
    {"label": "FHA", "value": "fha"},
    {"label": "VA", "value": "va"},
    {"label": "USDA", "value": "usda"},
  ];

  List<Map<String, dynamic>> creditScores = [
    {"label": "800+ (Excellent)", "value": "800"},
    {"label": "740-799 (Very Good)", "value": "740"},
    {"label": "670-739 (Good)", "value": "670"},
    {"label": "580-669 (Fair)", "value": "580"},
  ];

  Map<String, dynamic> get loanRequirements {
    switch (loanType) {
      case "fha":
        return {
          "minDownPayment": 3.5,
          "name": "FHA Loan",
          "description": "Government-backed loan for first-time buyers",
          "pmiRequired": true,
        };
      case "va":
        return {
          "minDownPayment": 0.0,
          "name": "VA Loan",
          "description": "For eligible veterans and service members",
          "pmiRequired": false,
        };
      case "usda":
        return {
          "minDownPayment": 0.0,
          "name": "USDA Loan",
          "description": "For rural and suburban homebuyers",
          "pmiRequired": false,
        };
      default:
        return {
          "minDownPayment": 5.0,
          "name": "Conventional Loan",
          "description": "Standard mortgage loan",
          "pmiRequired": true,
        };
    }
  }

  double get downPaymentPercent {
    if (usePercentage) {
      return double.tryParse(downPaymentPercentage) ?? 0;
    } else {
      double price = double.tryParse(homePrice) ?? 1;
      double amount = double.tryParse(downPaymentAmount) ?? 0;
      return (amount / price) * 100;
    }
  }

  double get downPaymentDollar {
    if (usePercentage) {
      double price = double.tryParse(homePrice) ?? 0;
      double percent = double.tryParse(downPaymentPercentage) ?? 0;
      return price * (percent / 100);
    } else {
      return double.tryParse(downPaymentAmount) ?? 0;
    }
  }

  double get loanAmount {
    double price = double.tryParse(homePrice) ?? 0;
    return price - downPaymentDollar;
  }

  int get monthsToSave {
    double currentSave = double.tryParse(currentSavings) ?? 0;
    double monthlySave = double.tryParse(monthlySavings) ?? 1;
    double needed = downPaymentDollar - currentSave;
    if (needed <= 0) return 0;
    return (needed / monthlySave).ceil();
  }

  List<Map<String, dynamic>> downPaymentOptions = [
    {"percentage": 5, "description": "Minimum conventional"},
    {"percentage": 10, "description": "Good option"},
    {"percentage": 15, "description": "Better rates"},
    {"percentage": 20, "description": "No PMI required"},
    {"percentage": 25, "description": "Maximum savings"},
  ];

  List<Map<String, dynamic>> savingStrategies = [
    {
      "strategy": "High-Yield Savings Account",
      "rate": "4.5%",
      "risk": "Low",
      "description": "Safe option with guaranteed returns",
    },
    {
      "strategy": "Certificate of Deposit",
      "rate": "5.0%",
      "risk": "Low",
      "description": "Fixed rate for specific terms",
    },
    {
      "strategy": "Money Market Account",
      "rate": "4.2%",
      "risk": "Low",
      "description": "Higher rates with limited transactions",
    },
    {
      "strategy": "Treasury Bills",
      "rate": "5.2%",
      "risk": "Very Low",
      "description": "Government-backed short-term investments",
    },
  ];

  List<Map<String, dynamic>> additionalCosts = [
    {"item": "Closing Costs", "percentage": 3.0, "description": "2-5% of home price"},
    {"item": "Home Inspection", "amount": 500, "description": "Property assessment"},
    {"item": "Appraisal", "amount": 600, "description": "Home valuation"},
    {"item": "Moving Costs", "amount": 2000, "description": "Relocation expenses"},
    {"item": "Immediate Repairs", "percentage": 1.0, "description": "Urgent fixes"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Down Payment Calculator"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Home Price & Down Payment
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
                    "Home Price & Down Payment",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QNumberField(
                    label: "Home Purchase Price (\$)",
                    value: homePrice,
                    onChanged: (value) {
                      homePrice = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Loan Type",
                          items: loanTypes,
                          value: loanType,
                          onChanged: (value, label) {
                            loanType = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Credit Score",
                          items: creditScores,
                          value: creditScore,
                          onChanged: (value, label) {
                            creditScore = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  // Down Payment Toggle
                  Row(
                    children: [
                      Text(
                        "Enter by:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: () {
                          usePercentage = true;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: usePercentage ? primaryColor : disabledColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "Percentage",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spXs),
                      GestureDetector(
                        onTap: () {
                          usePercentage = false;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: !usePercentage ? primaryColor : disabledColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "Dollar Amount",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (usePercentage)
                    QNumberField(
                      label: "Down Payment (%)",
                      value: downPaymentPercentage,
                      onChanged: (value) {
                        downPaymentPercentage = value;
                        setState(() {});
                      },
                    )
                  else
                    QNumberField(
                      label: "Down Payment Amount (\$)",
                      value: downPaymentAmount,
                      onChanged: (value) {
                        downPaymentAmount = value;
                        setState(() {});
                      },
                    ),
                ],
              ),
            ),

            // Loan Requirements
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: loanRequirements["pmiRequired"] ? warningColor.withAlpha(20) : successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: loanRequirements["pmiRequired"] ? warningColor.withAlpha(50) : successColor.withAlpha(50)),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: loanRequirements["pmiRequired"] ? warningColor : successColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${loanRequirements["name"]} Requirements",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: loanRequirements["pmiRequired"] ? warningColor : successColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${loanRequirements["description"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Minimum Down Payment:",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${loanRequirements["minDownPayment"]}%",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  if (loanRequirements["pmiRequired"])
                    Text(
                      "PMI required if down payment < 20%",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
            ),

            // Calculation Results
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Calculation Results",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Down Payment:",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "\$${downPaymentDollar.toStringAsFixed(0)} (${downPaymentPercent.toStringAsFixed(1)}%)",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Loan Amount:",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "\$${loanAmount.toStringAsFixed(0)}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Loan-to-Value Ratio:",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "${(100 - downPaymentPercent).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
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

            // Down Payment Options
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
                    "Down Payment Options",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...downPaymentOptions.map((option) {
                    double price = double.tryParse(homePrice) ?? 0;
                    double amount = price * ((option["percentage"] as int) / 100);
                    bool isSelected = (option["percentage"] as int).toDouble() == downPaymentPercent;
                    
                    return GestureDetector(
                      onTap: () {
                        downPaymentPercentage = (option["percentage"] as int).toString();
                        usePercentage = true;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledColor,
                            width: isSelected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(radiusSm),
                          color: isSelected ? primaryColor.withAlpha(20) : null,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${option["percentage"]}% Down Payment",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? primaryColor : null,
                                    ),
                                  ),
                                  Text(
                                    "${option["description"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "\$${amount.toStringAsFixed(0)}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? primaryColor : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Savings Plan
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
                    "Savings Plan",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QNumberField(
                          label: "Current Savings (\$)",
                          value: currentSavings,
                          onChanged: (value) {
                            currentSavings = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QNumberField(
                          label: "Monthly Savings (\$)",
                          value: monthlySavings,
                          onChanged: (value) {
                            monthlySavings = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Time to Save Goal:",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          monthsToSave == 0 ? "Ready!" : "$monthsToSave months",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: monthsToSave == 0 ? successColor : primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Saving Strategies
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
                    "Recommended Saving Strategies",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...savingStrategies.map((strategy) {
                    Color riskColor;
                    switch (strategy["risk"]) {
                      case "Very Low":
                        riskColor = successColor;
                        break;
                      case "Low":
                        riskColor = infoColor;
                        break;
                      default:
                        riskColor = warningColor;
                    }
                    
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
                                  "${strategy["strategy"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                "${strategy["rate"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "${strategy["description"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXxs),
                                decoration: BoxDecoration(
                                  color: riskColor.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${strategy["risk"]} Risk",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: riskColor,
                                    fontWeight: FontWeight.w600,
                                  ),
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

            // Additional Costs to Consider
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: warningColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Additional Costs to Consider",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  ...additionalCosts.map((cost) {
                    double price = double.tryParse(homePrice) ?? 0;
                    double amount;
                    
                    if (cost.containsKey("percentage")) {
                      amount = price * ((cost["percentage"] as double) / 100);
                    } else {
                      amount = (cost["amount"] as int).toDouble();
                    }
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${cost["item"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${cost["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "\$${amount.toStringAsFixed(0)}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
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
                    label: "Save Down Payment Plan",
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Explore Loan Options",
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
