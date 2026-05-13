import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaMortgageCalculatorView extends StatefulWidget {
  const RmaMortgageCalculatorView({super.key});

  @override
  State<RmaMortgageCalculatorView> createState() => _RmaMortgageCalculatorViewState();
}

class _RmaMortgageCalculatorViewState extends State<RmaMortgageCalculatorView> {
  String homePrice = "450000";
  String downPayment = "90000";
  String interestRate = "6.75";
  String loanTerm = "30";
  String propertyTax = "5850";
  String homeInsurance = "1285";
  String pmiAmount = "225";
  String hoaFees = "285";
  
  List<Map<String, dynamic>> loanTermOptions = [
    {"label": "15 Years", "value": "15"},
    {"label": "20 Years", "value": "20"},
    {"label": "25 Years", "value": "25"},
    {"label": "30 Years", "value": "30"},
  ];
  
  Map<String, dynamic> calculationResults = {
    "monthly_payment": 2456.78,
    "principal_interest": 2345.67,
    "property_tax": 487.50,
    "insurance": 107.08,
    "pmi": 187.50,
    "hoa": 285.00,
    "total_payment": 3412.75,
    "loan_amount": 360000.00,
    "down_payment_percent": 20.0,
    "ltv_ratio": 80.0,
  };
  
  List<Map<String, dynamic>> paymentBreakdown = [
    {
      "component": "Principal & Interest",
      "amount": 2345.67,
      "percentage": 68.7,
      "color": "primary",
      "icon": Icons.home,
    },
    {
      "component": "Property Tax",
      "amount": 487.50,
      "percentage": 14.3,
      "color": "warning",
      "icon": Icons.account_balance,
    },
    {
      "component": "Home Insurance",
      "amount": 107.08,
      "percentage": 3.1,
      "color": "info",
      "icon": Icons.shield,
    },
    {
      "component": "PMI",
      "amount": 187.50,
      "percentage": 5.5,
      "color": "secondary",
      "icon": Icons.security,
    },
    {
      "component": "HOA Fees",
      "amount": 285.00,
      "percentage": 8.4,
      "color": "success",
      "icon": Icons.apartment,
    },
  ];
  
  List<Map<String, dynamic>> amortizationSample = [
    {"year": 1, "principal": 8245.50, "interest": 23902.54, "balance": 351754.50},
    {"year": 5, "principal": 11245.78, "interest": 20902.26, "balance": 312458.23},
    {"year": 10, "principal": 15876.34, "interest": 16271.70, "balance": 245621.89},
    {"year": 15, "principal": 22459.12, "interest": 9688.92, "balance": 156832.77},
    {"year": 20, "principal": 31784.56, "interest": 363.48, "balance": 89247.21},
    {"year": 25, "principal": 44982.34, "interest": -12834.30, "balance": 22764.87},
    {"year": 30, "principal": 22764.87, "interest": -22764.87, "balance": 0.00},
  ];
  
  List<Map<String, dynamic>> scenarios = [
    {
      "name": "Current Scenario",
      "down_payment": 90000,
      "rate": 6.75,
      "term": 30,
      "monthly_payment": 2456.78,
      "total_interest": 524440.80,
      "is_current": true,
    },
    {
      "name": "Higher Down Payment",
      "down_payment": 135000,
      "rate": 6.75,
      "term": 30,
      "monthly_payment": 2162.83,
      "total_interest": 463017.80,
      "is_current": false,
    },
    {
      "name": "15-Year Loan",
      "down_payment": 90000,
      "rate": 6.25,
      "term": 15,
      "monthly_payment": 3098.45,
      "total_interest": 197721.00,
      "is_current": false,
    },
    {
      "name": "Lower Rate",
      "down_payment": 90000,
      "rate": 6.00,
      "term": 30,
      "monthly_payment": 2278.33,
      "total_interest": 460199.80,
      "is_current": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mortgage Calculator"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // Save calculation
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
            _buildCalculatorForm(),
            _buildCalculationResults(),
            _buildPaymentBreakdown(),
            _buildAmortizationSchedule(),
            _buildScenarioComparison(),
            _buildMortgageTips(),
          ],
        ),
      ),
    );
  }

  Widget _buildCalculatorForm() {
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
            "Loan Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QNumberField(
            label: "Home Price (\$)",
            value: homePrice,
            onChanged: (value) {
              homePrice = value;
              _calculateMortgage();
            },
          ),
          QNumberField(
            label: "Down Payment (\$)",
            value: downPayment,
            onChanged: (value) {
              downPayment = value;
              _calculateMortgage();
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
                    _calculateMortgage();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Loan Term",
                  items: loanTermOptions,
                  value: loanTerm,
                  onChanged: (value, label) {
                    loanTerm = value;
                    _calculateMortgage();
                  },
                ),
              ),
            ],
          ),
          Text(
            "Additional Costs",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          QNumberField(
            label: "Annual Property Tax (\$)",
            value: propertyTax,
            onChanged: (value) {
              propertyTax = value;
              _calculateMortgage();
            },
          ),
          QNumberField(
            label: "Annual Home Insurance (\$)",
            value: homeInsurance,
            onChanged: (value) {
              homeInsurance = value;
              _calculateMortgage();
            },
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Monthly PMI (\$)",
                  value: pmiAmount,
                  onChanged: (value) {
                    pmiAmount = value;
                    _calculateMortgage();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Monthly HOA (\$)",
                  value: hoaFees,
                  onChanged: (value) {
                    hoaFees = value;
                    _calculateMortgage();
                  },
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Calculate Payment",
              size: bs.md,
              onPressed: () {
                _calculateMortgage();
                ss("Mortgage payment calculated!");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalculationResults() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Monthly Payment",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\$${(calculationResults["total_payment"] as double).currency}",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Principal & Interest: \$${(calculationResults["principal_interest"] as double).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(220),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Icon(Icons.trending_down, color: Colors.white, size: 20),
                    SizedBox(height: spXs),
                    Text(
                      "LTV",
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                    Text(
                      "${(calculationResults["ltv_ratio"] as double).toStringAsFixed(0)}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 100,
            children: [
              _buildResultStat("Loan Amount", "\$${((calculationResults["loan_amount"] as double) / 1000).toStringAsFixed(0)}K"),
              _buildResultStat("Down Payment", "${(calculationResults["down_payment_percent"] as double).toStringAsFixed(0)}%"),
              _buildResultStat("Total Interest", "\$${(((calculationResults["principal_interest"] as double) * 360) - (calculationResults["loan_amount"] as double)).toStringAsFixed(0)}"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultStat(String label, String value) {
    return Container(
      padding: EdgeInsets.all(spXs),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              color: Colors.white.withAlpha(200),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentBreakdown() {
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
            "Payment Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...paymentBreakdown.map((component) => _buildPaymentComponent(component)),
        ],
      ),
    );
  }

  Widget _buildPaymentComponent(Map<String, dynamic> component) {
    Color componentColor = _getComponentColor(component["color"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: componentColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: componentColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(component["icon"] as IconData, color: componentColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${component["component"]}",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: componentColor,
                  ),
                ),
                Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: componentColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: (component["percentage"] as double) / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: componentColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${(component["amount"] as double).currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: componentColor,
                ),
              ),
              Text(
                "${(component["percentage"] as double).toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAmortizationSchedule() {
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
            "Amortization Schedule (Sample Years)",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...amortizationSample.map((year) => _buildAmortizationYear(year)),
        ],
      ),
    );
  }

  Widget _buildAmortizationYear(Map<String, dynamic> year) {
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
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Center(
              child: Text(
                "${year["year"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 80,
              children: [
                _buildAmortizationDetail("Principal", "\$${((year["principal"] as double) / 1000).toStringAsFixed(1)}K", successColor),
                _buildAmortizationDetail("Interest", "\$${((year["interest"] as double) / 1000).toStringAsFixed(1)}K", warningColor),
                _buildAmortizationDetail("Balance", "\$${((year["balance"] as double) / 1000).toStringAsFixed(0)}K", infoColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmortizationDetail(String label, String amount, Color color) {
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
            amount,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScenarioComparison() {
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
            "Scenario Comparison",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...scenarios.map((scenario) => _buildScenarioCard(scenario)),
        ],
      ),
    );
  }

  Widget _buildScenarioCard(Map<String, dynamic> scenario) {
    Color cardColor = scenario["is_current"] ? primaryColor : disabledBoldColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: cardColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: cardColor.withAlpha(30)),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "${scenario["name"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: cardColor,
                ),
              ),
              if (scenario["is_current"]) ...[
                SizedBox(width: spXs),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "Current",
                    style: TextStyle(
                      fontSize: 8,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 100,
            children: [
              _buildScenarioDetail("Down Payment", "\$${((scenario["down_payment"] as int) / 1000).toStringAsFixed(0)}K"),
              _buildScenarioDetail("Rate", "${(scenario["rate"] as double).toStringAsFixed(2)}%"),
              _buildScenarioDetail("Term", "${scenario["term"]} years"),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Monthly: \$${(scenario["monthly_payment"] as double).currency}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: cardColor,
                  ),
                ),
              ),
              Text(
                "Interest: \$${((scenario["total_interest"] as double) / 1000).toStringAsFixed(0)}K",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScenarioDetail(String label, String value) {
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
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMortgageTips() {
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
            "Mortgage Tips",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildTipItem(
            "Higher Down Payment",
            "20% down payment eliminates PMI and reduces monthly payments",
            Icons.trending_up,
            successColor,
          ),
          _buildTipItem(
            "Shorter Loan Term",
            "15-year loans have higher payments but much less total interest",
            Icons.schedule,
            infoColor,
          ),
          _buildTipItem(
            "Rate Shopping",
            "Compare rates from multiple lenders to find the best deal",
            Icons.compare,
            warningColor,
          ),
          _buildTipItem(
            "Extra Payments",
            "Additional principal payments can save thousands in interest",
            Icons.add_circle,
            secondaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(String title, String description, IconData icon, Color color) {
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

  void _calculateMortgage() {
    // Mortgage calculation logic would go here
    // For now, using static values
    setState(() {});
  }

  Color _getComponentColor(String colorName) {
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
