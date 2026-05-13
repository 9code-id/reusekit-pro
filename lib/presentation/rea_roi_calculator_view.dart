import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaRoiCalculatorView extends StatefulWidget {
  const ReaRoiCalculatorView({super.key});

  @override
  State<ReaRoiCalculatorView> createState() => _ReaRoiCalculatorViewState();
}

class _ReaRoiCalculatorViewState extends State<ReaRoiCalculatorView> {
  final formKey = GlobalKey<FormState>();
  
  String propertyPrice = "";
  String downPayment = "";
  String loanAmount = "";
  String interestRate = "";
  String loanTenure = "";
  String monthlyRent = "";
  String maintenanceCost = "";
  String propertyTax = "";
  String appreciationRate = "";
  String selectedCalculationType = "Basic ROI";
  
  bool showResults = false;
  Map<String, dynamic> calculationResults = {};

  List<Map<String, dynamic>> calculationTypes = [
    {"label": "Basic ROI", "value": "Basic ROI"},
    {"label": "Cash on Cash", "value": "Cash on Cash"},
    {"label": "Cap Rate", "value": "Cap Rate"},
    {"label": "Total Return", "value": "Total Return"},
  ];

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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            children: [
              _buildCalculatorTypeCard(),
              _buildPropertyDetailsCard(),
              _buildLoanDetailsCard(),
              _buildIncomeExpenseCard(),
              _buildCalculateButton(),
              if (showResults) _buildResultsCard(),
              if (showResults) _buildDetailedBreakdownCard(),
              if (showResults) _buildComparisonCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalculatorTypeCard() {
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
          Row(
            children: [
              Icon(
                Icons.calculate,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Calculation Type",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Select ROI Calculation Method",
            items: calculationTypes,
            value: selectedCalculationType,
            onChanged: (value, label) {
              selectedCalculationType = value;
              if (showResults) {
                _calculateROI();
              }
              setState(() {});
            },
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              _getCalculationDescription(),
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyDetailsCard() {
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
            "Property Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QNumberField(
                  label: "Property Price (\$)",
                  value: propertyPrice,
                  validator: Validator.required,
                  onChanged: (value) {
                    propertyPrice = value;
                    _updateLoanAmount();
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QNumberField(
                  label: "Down Payment (\$)",
                  value: downPayment,
                  validator: Validator.required,
                  onChanged: (value) {
                    downPayment = value;
                    _updateLoanAmount();
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QNumberField(
            label: "Loan Amount (\$)",
            value: loanAmount,
            hint: "Auto-calculated: Property Price - Down Payment",
            onChanged: (value) {
              loanAmount = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoanDetailsCard() {
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
            "Loan Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QNumberField(
                  label: "Interest Rate (%)",
                  value: interestRate,
                  validator: Validator.required,
                  onChanged: (value) {
                    interestRate = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QNumberField(
                  label: "Loan Tenure (Years)",
                  value: loanTenure,
                  validator: Validator.required,
                  onChanged: (value) {
                    loanTenure = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          if (interestRate.isNotEmpty && loanTenure.isNotEmpty && loanAmount.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Estimated Monthly EMI:",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "\$${_calculateEMI().currency}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildIncomeExpenseCard() {
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
            "Income & Expenses",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QNumberField(
            label: "Monthly Rental Income (\$)",
            value: monthlyRent,
            validator: Validator.required,
            onChanged: (value) {
              monthlyRent = value;
              setState(() {});
            },
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QNumberField(
                  label: "Monthly Maintenance (\$)",
                  value: maintenanceCost,
                  onChanged: (value) {
                    maintenanceCost = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QNumberField(
                  label: "Annual Property Tax (\$)",
                  value: propertyTax,
                  onChanged: (value) {
                    propertyTax = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QNumberField(
            label: "Expected Appreciation Rate (% per year)",
            value: appreciationRate,
            hint: "Average market appreciation rate",
            onChanged: (value) {
              appreciationRate = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCalculateButton() {
    return Container(
      width: double.infinity,
      child: QButton(
        label: "Calculate ROI",
        icon: Icons.calculate,
        size: bs.md,
        onPressed: () {
          if (formKey.currentState!.validate()) {
            _calculateROI();
          }
        },
      ),
    );
  }

  Widget _buildResultsCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.trending_up,
                color: successColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "ROI Results",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              color: successColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(
                color: successColor.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: Column(
              spacing: spSm,
              children: [
              Text(
                  selectedCalculationType,
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${calculationResults['mainROI']}%",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  _getROIInterpretation(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildMetricCard(
                "Monthly Cash Flow", 
                "\$${calculationResults['monthlyCashFlow']?.currency ?? '0'}",
                Icons.account_balance_wallet,
                calculationResults['monthlyCashFlow'] >= 0 ? successColor : dangerColor,
              ),
              _buildMetricCard(
                "Annual Return", 
                "\$${calculationResults['annualReturn']?.currency ?? '0'}",
                Icons.trending_up,
                primaryColor,
              ),
              _buildMetricCard(
                "Break-even Time", 
                "${calculationResults['breakEvenYears']} years",
                Icons.schedule,
                warningColor,
              ),
              _buildMetricCard(
                "Total Investment", 
                "\$${(double.tryParse(downPayment) ?? 0).currency}",
                Icons.savings,
                infoColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedBreakdownCard() {
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
            "Detailed Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildBreakdownRow("Annual Rental Income", "\$${((double.tryParse(monthlyRent) ?? 0) * 12).currency}", successColor),
          _buildBreakdownRow("Annual Loan EMI", "-\$${(_calculateEMI() * 12).currency}", dangerColor),
          _buildBreakdownRow("Annual Maintenance", "-\$${((double.tryParse(maintenanceCost) ?? 0) * 12).currency}", dangerColor),
          _buildBreakdownRow("Annual Property Tax", "-\$${(double.tryParse(propertyTax) ?? 0).currency}", dangerColor),
          Container(
            width: double.infinity,
            height: 1,
            color: disabledColor,
          ),
          _buildBreakdownRow("Net Annual Income", "\$${calculationResults['annualReturn']?.currency ?? '0'}", primaryColor),
          if (appreciationRate.isNotEmpty)
            _buildBreakdownRow("Capital Appreciation", "\$${calculationResults['capitalAppreciation']?.currency ?? '0'}", successColor),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Investment Comparison",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Fixed Deposit (6%)",
                      style: TextStyle(fontSize: 14, color: disabledBoldColor),
                    ),
                    Text(
                      "\$${((double.tryParse(downPayment) ?? 0) * 0.06).currency}/year",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Stock Market (12%)",
                      style: TextStyle(fontSize: 14, color: disabledBoldColor),
                    ),
                    Text(
                      "\$${((double.tryParse(downPayment) ?? 0) * 0.12).currency}/year",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Real Estate ROI",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: primaryColor),
                    ),
                    Text(
                      "\$${calculationResults['annualReturn']?.currency ?? '0'}/year",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: primaryColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Save Calculation",
                  icon: Icons.save,
                  size: bs.sm,
                  onPressed: () {
                    ss("ROI calculation saved");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Share Report",
                  icon: Icons.share,
                  size: bs.sm,
                  onPressed: () {
                    ss("ROI report shared");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownRow(String label, String amount, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  void _updateLoanAmount() {
    if (propertyPrice.isNotEmpty && downPayment.isNotEmpty) {
      double price = double.tryParse(propertyPrice) ?? 0;
      double down = double.tryParse(downPayment) ?? 0;
      loanAmount = (price - down).toString();
    }
  }

  double _calculateEMI() {
    if (loanAmount.isEmpty || interestRate.isEmpty || loanTenure.isEmpty) return 0;
    
    double principal = double.tryParse(loanAmount) ?? 0;
    double rate = (double.tryParse(interestRate) ?? 0) / 100 / 12;
    double tenure = (double.tryParse(loanTenure) ?? 0) * 12;
    
    if (rate == 0) return principal / tenure;
    
    return principal * rate * (1 + rate) * tenure / ((1 + rate) * tenure - 1);
  }

  void _calculateROI() {
    double monthlyRentValue = double.tryParse(monthlyRent) ?? 0;
    double maintenanceValue = double.tryParse(maintenanceCost) ?? 0;
    double propertyTaxValue = double.tryParse(propertyTax) ?? 0;
    double downPaymentValue = double.tryParse(downPayment) ?? 0;
    double propertyPriceValue = double.tryParse(propertyPrice) ?? 0;
    double appreciationValue = double.tryParse(appreciationRate) ?? 0;
    
    double monthlyEMI = _calculateEMI();
    double monthlyCashFlow = monthlyRentValue - monthlyEMI - maintenanceValue - (propertyTaxValue / 12);
    double annualCashFlow = monthlyCashFlow * 12;
    double capitalAppreciation = propertyPriceValue * (appreciationValue / 100);
    
    double mainROI;
    switch (selectedCalculationType) {
      case "Cash on Cash":
        mainROI = (annualCashFlow / downPaymentValue) * 100;
        break;
      case "Cap Rate":
        mainROI = ((monthlyRentValue * 12 - (maintenanceValue * 12 + propertyTaxValue)) / propertyPriceValue) * 100;
        break;
      case "Total Return":
        mainROI = ((annualCashFlow + capitalAppreciation) / downPaymentValue) * 100;
        break;
      default: // Basic ROI
        mainROI = (annualCashFlow / downPaymentValue) * 100;
    }
    
    calculationResults = {
      'mainROI': mainROI.toStringAsFixed(1),
      'monthlyCashFlow': monthlyCashFlow.toInt(),
      'annualReturn': annualCashFlow.toInt(),
      'breakEvenYears': downPaymentValue > 0 ? (downPaymentValue / (annualCashFlow + capitalAppreciation)).toStringAsFixed(1) : "0",
      'capitalAppreciation': capitalAppreciation.toInt(),
    };
    
    showResults = true;
    setState(() {});
  }

  String _getCalculationDescription() {
    switch (selectedCalculationType) {
      case "Cash on Cash":
        return "Annual pre-tax cash flow divided by total cash invested";
      case "Cap Rate":
        return "Net operating income divided by property value";
      case "Total Return":
        return "Cash flow plus capital appreciation divided by investment";
      default:
        return "Simple return on investment calculation";
    }
  }

  String _getROIInterpretation() {
    double roi = double.tryParse(calculationResults['mainROI'] ?? '0') ?? 0;
    if (roi >= 15) return "Excellent ROI - Very attractive investment";
    if (roi >= 10) return "Good ROI - Solid investment opportunity";
    if (roi >= 6) return "Average ROI - Consider market alternatives";
    return "Below average ROI - Review investment strategy";
  }

  void _resetCalculator() {
    propertyPrice = "";
    downPayment = "";
    loanAmount = "";
    interestRate = "";
    loanTenure = "";
    monthlyRent = "";
    maintenanceCost = "";
    propertyTax = "";
    appreciationRate = "";
    showResults = false;
    calculationResults = {};
    setState(() {});
  }
}
