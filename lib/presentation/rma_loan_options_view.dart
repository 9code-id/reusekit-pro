import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaLoanOptionsView extends StatefulWidget {
  const RmaLoanOptionsView({super.key});

  @override
  State<RmaLoanOptionsView> createState() => _RmaLoanOptionsViewState();
}

class _RmaLoanOptionsViewState extends State<RmaLoanOptionsView> {
  String selectedLoanType = "conventional";
  String selectedTerm = "30";
  String creditScoreRange = "740-799";
  
  List<Map<String, dynamic>> loanTypeOptions = [
    {"label": "All Loan Types", "value": "all"},
    {"label": "Conventional", "value": "conventional"},
    {"label": "FHA", "value": "fha"},
    {"label": "VA", "value": "va"},
    {"label": "USDA", "value": "usda"},
    {"label": "Jumbo", "value": "jumbo"},
  ];
  
  List<Map<String, dynamic>> termOptions = [
    {"label": "All Terms", "value": "all"},
    {"label": "15 Years", "value": "15"},
    {"label": "20 Years", "value": "20"},
    {"label": "30 Years", "value": "30"},
  ];
  
  List<Map<String, dynamic>> creditRanges = [
    {"label": "Excellent (740+)", "value": "740-799"},
    {"label": "Good (680-739)", "value": "680-739"},
    {"label": "Fair (620-679)", "value": "620-679"},
    {"label": "Poor (Below 620)", "value": "below-620"},
  ];
  
  List<Map<String, dynamic>> loanOptions = [
    {
      "type": "conventional",
      "name": "Conventional Fixed-Rate",
      "term": 30,
      "rate": 6.75,
      "apr": 6.89,
      "down_payment_min": 3,
      "pmi_required": true,
      "max_loan_amount": 766550,
      "credit_score_min": 620,
      "monthly_payment": 2924.83,
      "lender": "Premier Mortgage",
      "features": ["No prepayment penalty", "Rate lock available", "Online application"],
      "pros": ["Lower rates for good credit", "No mortgage insurance with 20% down", "Flexible terms"],
      "cons": ["Higher down payment than government loans", "Stricter credit requirements"],
      "best_for": "Borrowers with good credit and stable income",
      "icon": Icons.account_balance,
      "color": "primary",
    },
    {
      "type": "fha",
      "name": "FHA Fixed-Rate",
      "term": 30,
      "rate": 6.50,
      "apr": 7.25,
      "down_payment_min": 3.5,
      "pmi_required": true,
      "max_loan_amount": 472030,
      "credit_score_min": 580,
      "monthly_payment": 2842.71,
      "lender": "FHA Approved Lender",
      "features": ["Low down payment", "Flexible credit requirements", "Assumable loan"],
      "pros": ["Low down payment options", "More lenient credit scores", "Government backing"],
      "cons": ["Mortgage insurance required", "Loan limits", "Property requirements"],
      "best_for": "First-time buyers with limited down payment",
      "icon": Icons.home_work,
      "color": "success",
    },
    {
      "type": "va",
      "name": "VA Fixed-Rate",
      "term": 30,
      "rate": 6.25,
      "apr": 6.45,
      "down_payment_min": 0,
      "pmi_required": false,
      "max_loan_amount": 0, // No limit
      "credit_score_min": 580,
      "monthly_payment": 2770.87,
      "lender": "Veterans United",
      "features": ["No down payment", "No PMI", "Competitive rates"],
      "pros": ["Zero down payment", "No mortgage insurance", "No prepayment penalty"],
      "cons": ["Veterans only", "Funding fee required", "Property requirements"],
      "best_for": "Eligible veterans and service members",
      "icon": Icons.military_tech,
      "color": "warning",
    },
    {
      "type": "usda",
      "name": "USDA Rural Development",
      "term": 30,
      "rate": 6.00,
      "apr": 6.35,
      "down_payment_min": 0,
      "pmi_required": true,
      "max_loan_amount": 0, // Based on area
      "credit_score_min": 640,
      "monthly_payment": 2698.49,
      "lender": "Rural Housing Service",
      "features": ["Zero down payment", "Below-market rates", "Income limits apply"],
      "pros": ["No down payment", "Low interest rates", "Subsidized program"],
      "cons": ["Geographic restrictions", "Income limits", "Property requirements"],
      "best_for": "Rural and suburban homebuyers",
      "icon": Icons.agriculture,
      "color": "info",
    },
    {
      "type": "conventional",
      "name": "Conventional 15-Year",
      "term": 15,
      "rate": 6.25,
      "apr": 6.38,
      "down_payment_min": 10,
      "pmi_required": true,
      "max_loan_amount": 766550,
      "credit_score_min": 620,
      "monthly_payment": 3851.74,
      "lender": "National Bank",
      "features": ["Lower total interest", "Faster equity building", "Higher monthly payments"],
      "pros": ["Much less total interest", "Builds equity faster", "Lower rates"],
      "cons": ["Higher monthly payments", "Less cash flow flexibility"],
      "best_for": "Borrowers who can afford higher payments",
      "icon": Icons.fast_forward,
      "color": "secondary",
    },
    {
      "type": "jumbo",
      "name": "Jumbo Fixed-Rate",
      "term": 30,
      "rate": 7.00,
      "apr": 7.15,
      "down_payment_min": 20,
      "pmi_required": false,
      "max_loan_amount": 0, // Above conforming limits
      "credit_score_min": 700,
      "monthly_payment": 3992.46,
      "lender": "Premium Lending",
      "features": ["High loan amounts", "Luxury property financing", "Competitive rates"],
      "pros": ["No loan amount limits", "Luxury home financing", "No PMI with 20% down"],
      "cons": ["Higher rates", "Stricter requirements", "Large down payments"],
      "best_for": "High-income borrowers buying expensive homes",
      "icon": Icons.diamond,
      "color": "warning",
    },
  ];
  
  List<Map<String, dynamic>> comparisonFactors = [
    {
      "factor": "Interest Rate",
      "description": "The cost of borrowing money",
      "importance": "High",
      "icon": Icons.percent,
    },
    {
      "factor": "Down Payment",
      "description": "Upfront cash required",
      "importance": "High",
      "icon": Icons.payments,
    },
    {
      "factor": "Monthly Payment",
      "description": "Principal, interest, taxes, insurance",
      "importance": "High",
      "icon": Icons.calendar_month,
    },
    {
      "factor": "Total Interest",
      "description": "Total cost over life of loan",
      "importance": "Medium",
      "icon": Icons.calculate,
    },
    {
      "factor": "PMI Requirements",
      "description": "Private mortgage insurance costs",
      "importance": "Medium",
      "icon": Icons.shield,
    },
    {
      "factor": "Credit Requirements",
      "description": "Minimum credit score needed",
      "importance": "Medium",
      "icon": Icons.credit_score,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loan Options"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Open advanced filters
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spLg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLoanFilters(),
            _buildLoanComparison(),
            _buildLoanOptions(),
            _buildComparisonFactors(),
            _buildLoanAdvice(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoanFilters() {
    return Container(
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
            "Filter Loan Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Loan Type",
            items: loanTypeOptions,
            value: selectedLoanType,
            onChanged: (value, label) {
              selectedLoanType = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Loan Term",
                  items: termOptions,
                  value: selectedTerm,
                  onChanged: (value, label) {
                    selectedTerm = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Credit Score",
                  items: creditRanges,
                  value: creditScoreRange,
                  onChanged: (value, label) {
                    creditScoreRange = value;
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

  Widget _buildLoanComparison() {
    List<Map<String, dynamic>> filteredLoans = _getFilteredLoans();
    
    if (filteredLoans.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Text(
          "No loans match your current filters. Try adjusting your criteria.",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
      );
    }

    return Container(
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
            "Quick Comparison",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: filteredLoans.take(4).map((loan) => _buildQuickComparisonCard(loan)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickComparisonCard(Map<String, dynamic> loan) {
    Color loanColor = _getLoanColor(loan["color"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: loanColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: loanColor.withAlpha(30)),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(loan["icon"] as IconData, color: loanColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  loan["type"].toString().toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: loanColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${(loan["rate"] as double).toStringAsFixed(2)}% Rate",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "\$${(loan["monthly_payment"] as double).currency}/month",
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "${(loan["down_payment_min"] as int)}% down minimum",
            style: TextStyle(
              fontSize: 9,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoanOptions() {
    List<Map<String, dynamic>> filteredLoans = _getFilteredLoans();
    
    return Container(
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
          Row(
            children: [
              Text(
                "Available Loan Options",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${filteredLoans.length} options",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          ...filteredLoans.map((loan) => _buildLoanOptionCard(loan)),
        ],
      ),
    );
  }

  Widget _buildLoanOptionCard(Map<String, dynamic> loan) {
    Color loanColor = _getLoanColor(loan["color"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: loanColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: loanColor.withAlpha(30)),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: loanColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  loan["icon"] as IconData,
                  color: loanColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${loan["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${loan["lender"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${(loan["rate"] as double).toStringAsFixed(2)}%",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: loanColor,
                    ),
                  ),
                  Text(
                    "APR ${(loan["apr"] as double).toStringAsFixed(2)}%",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 120,
            children: [
              _buildLoanDetail("Monthly Payment", "\$${(loan["monthly_payment"] as double).currency}"),
              _buildLoanDetail("Down Payment", "${loan["down_payment_min"]}% minimum"),
              _buildLoanDetail("Loan Term", "${loan["term"]} years"),
              _buildLoanDetail("Credit Score", "${loan["credit_score_min"]}+ required"),
            ],
          ),
          
          Text(
            "Best for: ${loan["best_for"]}",
            style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: primaryColor,
            ),
          ),
          
          if ((loan["features"] as List).isNotEmpty) ...[
            Text(
              "Key Features:",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: (loan["features"] as List).map((feature) => 
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: loanColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    feature,
                    style: TextStyle(
                      fontSize: 9,
                      color: loanColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ).toList(),
            ),
          ],
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pros:",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                    ...(loan["pros"] as List).take(2).map((pro) => 
                      Text(
                        "• $pro",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Cons:",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: dangerColor,
                      ),
                    ),
                    ...(loan["cons"] as List).take(2).map((con) => 
                      Text(
                        "• $con",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Get Quote",
                  size: bs.sm,
                  onPressed: () {
                    // Request quote for this loan
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: loanColor),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "Learn More",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: loanColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoanDetail(String label, String value) {
    return Container(
      padding: EdgeInsets.all(spXs),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonFactors() {
    return Container(
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
            "Key Comparison Factors",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...comparisonFactors.map((factor) => _buildFactorCard(factor)),
        ],
      ),
    );
  }

  Widget _buildFactorCard(Map<String, dynamic> factor) {
    Color importanceColor = factor["importance"] == "High" ? dangerColor : 
                          factor["importance"] == "Medium" ? warningColor : successColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Icon(factor["icon"] as IconData, color: primaryColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${factor["factor"]}",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: importanceColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${factor["importance"]}",
                        style: TextStyle(
                          fontSize: 9,
                          color: importanceColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${factor["description"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoanAdvice() {
    return Container(
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
            "Loan Selection Advice",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildAdviceItem(
            "First-Time Buyers",
            "Consider FHA loans for lower down payments and flexible credit requirements",
            Icons.home_work,
            successColor,
          ),
          _buildAdviceItem(
            "Veterans",
            "VA loans offer zero down payment and no PMI for eligible service members",
            Icons.military_tech,
            warningColor,
          ),
          _buildAdviceItem(
            "Rural Areas",
            "USDA loans provide zero down payment options for qualifying rural properties",
            Icons.agriculture,
            infoColor,
          ),
          _buildAdviceItem(
            "High Income",
            "Jumbo loans enable luxury home purchases above conforming loan limits",
            Icons.diamond,
            secondaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildAdviceItem(String title, String description, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredLoans() {
    return loanOptions.where((loan) {
      bool typeMatch = selectedLoanType == "all" || loan["type"] == selectedLoanType;
      bool termMatch = selectedTerm == "all" || loan["term"].toString() == selectedTerm;
      return typeMatch && termMatch;
    }).toList();
  }

  Color _getLoanColor(String colorName) {
    switch (colorName) {
      case "primary":
        return primaryColor;
      case "secondary":
        return secondaryColor;
      case "success":
        return successColor;
      case "warning":
        return warningColor;
      case "info":
        return infoColor;
      default:
        return primaryColor;
    }
  }
}
