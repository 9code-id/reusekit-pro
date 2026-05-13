import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaLoanEligibilityView extends StatefulWidget {
  const ReaLoanEligibilityView({super.key});

  @override
  State<ReaLoanEligibilityView> createState() => _ReaLoanEligibilityViewState();
}

class _ReaLoanEligibilityViewState extends State<ReaLoanEligibilityView> {
  final formKey = GlobalKey<FormState>();
  
  // Personal Information
  String monthlyIncome = "";
  String otherIncome = "";
  String monthlyExpenses = "";
  String existingEmiAmount = "";
  String age = "";
  String employmentType = "Salaried";
  String workExperience = "";
  
  // Property Information
  String propertyValue = "";
  String downPayment = "";
  String loanAmount = "";
  String loanTenure = "20";
  String propertyType = "Residential";
  
  // Credit Information
  String creditScore = "";
  bool hasExistingLoans = false;
  String existingLoanDetails = "";
  
  // Results
  Map<String, dynamic>? eligibilityResult;
  bool isCalculating = false;

  List<Map<String, dynamic>> employmentTypes = [
    {"label": "Salaried", "value": "Salaried"},
    {"label": "Self Employed", "value": "Self Employed"},
    {"label": "Business Owner", "value": "Business Owner"},
    {"label": "Professional", "value": "Professional"},
  ];

  List<Map<String, dynamic>> propertyTypes = [
    {"label": "Residential", "value": "Residential"},
    {"label": "Commercial", "value": "Commercial"},
    {"label": "Plot/Land", "value": "Plot/Land"},
    {"label": "Under Construction", "value": "Under Construction"},
  ];

  List<Map<String, dynamic>> tenureOptions = [
    {"label": "10 Years", "value": "10"},
    {"label": "15 Years", "value": "15"},
    {"label": "20 Years", "value": "20"},
    {"label": "25 Years", "value": "25"},
    {"label": "30 Years", "value": "30"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loan Eligibility"),
        actions: [
          IconButton(
            onPressed: () => _showTipsDialog(),
            icon: Icon(Icons.help_outline),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            children: [
              _buildHeaderCard(),
              _buildPersonalInfoSection(),
              _buildPropertyInfoSection(),
              _buildCreditInfoSection(),
              if (eligibilityResult != null) _buildResultsSection(),
              _buildCalculateButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Icon(
            Icons.account_balance,
            color: Colors.white,
            size: 40,
          ),
          Text(
            "Home Loan Eligibility Calculator",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            "Calculate your loan eligibility based on your income, expenses, and credit profile",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(220),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
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
          Row(
            children: [
              Icon(
                Icons.person,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Personal Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QNumberField(
            label: "Monthly Income (\$)",
            value: monthlyIncome,
            validator: Validator.required,
            onChanged: (value) {
              monthlyIncome = value;
              setState(() {});
            },
          ),
          QNumberField(
            label: "Other Income (\$)",
            value: otherIncome,
            onChanged: (value) {
              otherIncome = value;
              setState(() {});
            },
          ),
          QNumberField(
            label: "Monthly Expenses (\$)",
            value: monthlyExpenses,
            validator: Validator.required,
            onChanged: (value) {
              monthlyExpenses = value;
              setState(() {});
            },
          ),
          QNumberField(
            label: "Existing EMI Amount (\$)",
            value: existingEmiAmount,
            onChanged: (value) {
              existingEmiAmount = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Age (Years)",
                  value: age,
                  validator: Validator.required,
                  onChanged: (value) {
                    age = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Employment Type",
                  items: employmentTypes,
                  value: employmentType,
                  onChanged: (value, label) {
                    employmentType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QNumberField(
            label: "Work Experience (Years)",
            value: workExperience,
            validator: Validator.required,
            onChanged: (value) {
              workExperience = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyInfoSection() {
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
          Row(
            children: [
              Icon(
                Icons.home,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Property Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QNumberField(
            label: "Property Value (\$)",
            value: propertyValue,
            validator: Validator.required,
            onChanged: (value) {
              propertyValue = value;
              _calculateLoanAmount();
              setState(() {});
            },
          ),
          QNumberField(
            label: "Down Payment (\$)",
            value: downPayment,
            validator: Validator.required,
            onChanged: (value) {
              downPayment = value;
              _calculateLoanAmount();
              setState(() {});
            },
          ),
          QNumberField(
            label: "Loan Amount (\$)",
            value: loanAmount,
            validator: Validator.required,
            onChanged: (value) {
              loanAmount = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Loan Tenure",
                  items: tenureOptions,
                  value: loanTenure,
                  onChanged: (value, label) {
                    loanTenure = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Property Type",
                  items: propertyTypes,
                  value: propertyType,
                  onChanged: (value, label) {
                    propertyType = value;
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

  Widget _buildCreditInfoSection() {
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
          Row(
            children: [
              Icon(
                Icons.credit_score,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Credit Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QNumberField(
            label: "Credit Score",
            value: creditScore,
            validator: Validator.required,
            onChanged: (value) {
              creditScore = value;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "I have existing loans",
                "value": true,
                "checked": hasExistingLoans,
              }
            ],
            value: [
              if (hasExistingLoans)
                {
                  "label": "I have existing loans",
                  "value": true,
                  "checked": true,
                }
            ],
            onChanged: (values, ids) {
              setState(() {
                hasExistingLoans = values.isNotEmpty;
              });
            },
          ),
          if (hasExistingLoans) ...[
            QMemoField(
              label: "Existing Loan Details",
              value: existingLoanDetails,
              onChanged: (value) {
                existingLoanDetails = value;
                setState(() {});
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildResultsSection() {
    final result = eligibilityResult!;
    Color statusColor = _getEligibilityColor(result["status"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.assessment,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Eligibility Results",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
              border: Border.all(color: statusColor.withAlpha(60)),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      _getEligibilityIcon(result["status"]),
                      color: statusColor,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${result["message"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                if (result["eligibleAmount"] > 0) ...[
                  Divider(color: statusColor.withAlpha(60)),
                  Row(
                    children: [
                      Expanded(
                        child: _buildResultItem(
                          "Eligible Amount",
                          "\$${((result["eligibleAmount"] as double)).currency}",
                          successColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildResultItem(
                          "Monthly EMI",
                          "\$${(result["monthlyEmi"] as double).toStringAsFixed(2)}",
                          primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildResultItem(
                          "Interest Rate",
                          "${(result["interestRate"] as double).toStringAsFixed(2)}%",
                          warningColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildResultItem(
                          "DTI Ratio",
                          "${(result["dtiRatio"] as double).toStringAsFixed(1)}%",
                          infoColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          if (result["recommendations"] != null) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recommendations",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: infoColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  ...((result["recommendations"] as List).map((rec) => Padding(
                    padding: EdgeInsets.only(bottom: spXs),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.circle,
                          color: infoColor,
                          size: 6,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            rec.toString(),
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildResultItem(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildCalculateButton() {
    return Column(
      spacing: spSm,
      children: [
        QButton(
          label: isCalculating ? "Calculating..." : "Calculate Eligibility",
          size: bs.md,
          onPressed: isCalculating ? null : () => _calculateEligibility(),
        ),
        if (eligibilityResult != null) ...[
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Lenders",
                  size: bs.md,
                  onPressed: () => _viewLenders(),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Apply for Loan",
                  size: bs.md,
                  onPressed: () => _applyForLoan(),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  void _calculateLoanAmount() {
    if (propertyValue.isNotEmpty && downPayment.isNotEmpty) {
      double propValue = double.tryParse(propertyValue) ?? 0;
      double downPay = double.tryParse(downPayment) ?? 0;
      
      if (propValue > downPay) {
        loanAmount = (propValue - downPay).toStringAsFixed(0);
      }
    }
  }

  void _calculateEligibility() {
    if (!formKey.currentState!.validate()) {
      se("Please fill all required fields");
      return;
    }

    setState(() {
      isCalculating = true;
    });

    // Simulate calculation delay
    Future.delayed(Duration(seconds: 2), () {
      double income = (double.tryParse(monthlyIncome) ?? 0) + (double.tryParse(otherIncome) ?? 0);
      double expenses = double.tryParse(monthlyExpenses) ?? 0;
      double existingEmi = double.tryParse(existingEmiAmount) ?? 0;
      double loanAmt = double.tryParse(loanAmount) ?? 0;
      int tenure = int.tryParse(loanTenure) ?? 20;
      int score = int.tryParse(creditScore) ?? 0;
      int ageValue = int.tryParse(age) ?? 0;

      // Calculate DTI (Debt-to-Income) ratio
      double totalObligations = expenses + existingEmi;
      double dtiRatio = (totalObligations / income) * 100;

      // Determine interest rate based on credit score
      double interestRate = _getInterestRate(score);

      // Calculate maximum eligible amount based on income
      double maxEmi = income * 0.4; // 40% of income
      double availableEmi = maxEmi - existingEmi;
      
      // Calculate eligible loan amount using EMI formula
      double eligibleAmount = 0;
      if (availableEmi > 0) {
        double monthlyRate = interestRate / 12 / 100;
        int months = tenure * 12;
        eligibleAmount = (availableEmi * (Math.pow(1 + monthlyRate, months) - 1)) / 
                        (monthlyRate * Math.pow(1 + monthlyRate, months));
      }

      // Apply additional factors
      if (ageValue > 55) eligibleAmount *= 0.8; // Reduce for older applicants
      if (employmentType == "Self Employed") eligibleAmount *= 0.9;
      if (score < 650) eligibleAmount *= 0.7;

      // Calculate monthly EMI for requested loan
      double monthlyRate = interestRate / 12 / 100;
      int months = tenure * 12;
      double monthlyEmi = (loanAmt * monthlyRate * Math.pow(1 + monthlyRate, months)) /
                         (Math.pow(1 + monthlyRate, months) - 1);

      // Determine eligibility status
      String status;
      String message;
      List<String> recommendations = [];

      if (eligibleAmount >= loanAmt && dtiRatio <= 40 && score >= 650) {
        status = "approved";
        message = "Congratulations! You are eligible for the requested loan amount.";
      } else if (eligibleAmount >= loanAmt * 0.8 && dtiRatio <= 50 && score >= 600) {
        status = "partial";
        message = "You are eligible for a reduced loan amount.";
        recommendations.add("Consider increasing your down payment");
        recommendations.add("You may qualify for better rates with improved credit score");
      } else {
        status = "rejected";
        message = "Unfortunately, you don't meet the current eligibility criteria.";
        
        if (dtiRatio > 40) recommendations.add("Reduce monthly expenses to improve DTI ratio");
        if (score < 650) recommendations.add("Improve your credit score before applying");
        if (eligibleAmount < loanAmt) recommendations.add("Consider a larger down payment");
        recommendations.add("Increase your monthly income");
      }

      setState(() {
        eligibilityResult = {
          "status": status,
          "message": message,
          "eligibleAmount": eligibleAmount,
          "monthlyEmi": monthlyEmi,
          "interestRate": interestRate,
          "dtiRatio": dtiRatio,
          "recommendations": recommendations.isNotEmpty ? recommendations : null,
        };
        isCalculating = false;
      });
    });
  }

  double _getInterestRate(int creditScore) {
    if (creditScore >= 750) return 6.5;
    if (creditScore >= 700) return 7.0;
    if (creditScore >= 650) return 7.5;
    if (creditScore >= 600) return 8.0;
    return 8.5;
  }

  Color _getEligibilityColor(String status) {
    switch (status) {
      case "approved":
        return successColor;
      case "partial":
        return warningColor;
      case "rejected":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getEligibilityIcon(String status) {
    switch (status) {
      case "approved":
        return Icons.check_circle;
      case "partial":
        return Icons.warning;
      case "rejected":
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  void _showTipsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Loan Eligibility Tips"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("• Maintain a DTI ratio below 40%"),
            Text("• Keep credit score above 650"),
            Text("• Have stable employment history"),
            Text("• Provide accurate income details"),
            Text("• Consider a larger down payment"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Got it"),
          ),
        ],
      ),
    );
  }

  void _viewLenders() {
    si("Opening lender comparison");
  }

  void _applyForLoan() {
    si("Proceeding to loan application");
  }
}
