import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaRentalYieldView extends StatefulWidget {
  const ReaRentalYieldView({super.key});

  @override
  State<ReaRentalYieldView> createState() => _ReaRentalYieldViewState();
}

class _ReaRentalYieldViewState extends State<ReaRentalYieldView> {
  final formKey = GlobalKey<FormState>();
  
  String propertyValue = "";
  String monthlyRent = "";
  String annualRent = "";
  String propertyTax = "";
  String maintenanceFee = "";
  String insuranceCost = "";
  String managementFee = "";
  String vacancyRate = "5";
  String selectedYieldType = "Gross Yield";
  
  bool showResults = false;
  Map<String, dynamic> yieldResults = {};

  List<Map<String, dynamic>> yieldTypes = [
    {"label": "Gross Yield", "value": "Gross Yield"},
    {"label": "Net Yield", "value": "Net Yield"},
    {"label": "Adjusted Yield", "value": "Adjusted Yield"},
  ];

  List<Map<String, dynamic>> sampleProperties = [
    {
      "type": "Apartment",
      "location": "Downtown",
      "value": 450000,
      "rent": 2800,
      "yield": 7.5,
      "rating": "Excellent"
    },
    {
      "type": "Condo",
      "location": "Suburbs",
      "value": 320000,
      "rent": 1900,
      "yield": 7.1,
      "rating": "Good"
    },
    {
      "type": "House",
      "location": "City Center",
      "value": 680000,
      "rent": 3500,
      "yield": 6.2,
      "rating": "Average"
    },
    {
      "type": "Studio",
      "location": "University Area",
      "value": 180000,
      "rent": 1200,
      "yield": 8.0,
      "rating": "Excellent"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rental Yield Calculator"),
        actions: [
          QButton(
            icon: Icons.info,
            size: bs.sm,
            onPressed: () {
              _showYieldInfoDialog();
            },
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
              _buildYieldTypeCard(),
              _buildPropertyValueCard(),
              _buildRentalIncomeCard(),
              _buildExpensesCard(),
              _buildCalculateButton(),
              if (showResults) _buildResultsCard(),
              if (showResults) _buildComparisonChart(),
              _buildMarketComparisonCard(),
              _buildBenchmarkCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildYieldTypeCard() {
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
                Icons.trending_up,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Yield Calculation Type",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Select Yield Type",
            items: yieldTypes,
            value: selectedYieldType,
            onChanged: (value, label) {
              selectedYieldType = value;
              if (showResults) {
                _calculateYield();
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  _getYieldDescription(),
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Formula: ${_getYieldFormula()}",
                  style: TextStyle(
                    fontSize: 11,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyValueCard() {
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
            "Property Value",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QNumberField(
            label: "Property Purchase/Market Value (\$)",
            value: propertyValue,
            validator: Validator.required,
            hint: "Total property value including all costs",
            onChanged: (value) {
              propertyValue = value;
              setState(() {});
            },
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb,
                  color: warningColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Include purchase price, closing costs, and any renovation expenses",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
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

  Widget _buildRentalIncomeCard() {
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
            "Rental Income",
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
                  label: "Monthly Rent (\$)",
                  value: monthlyRent,
                  validator: Validator.required,
                  onChanged: (value) {
                    monthlyRent = value;
                    _updateAnnualRent();
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QNumberField(
                  label: "Annual Rent (\$)",
                  value: annualRent,
                  hint: "Auto-calculated",
                  onChanged: (value) {
                    annualRent = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QNumberField(
            label: "Vacancy Rate (%)",
            value: vacancyRate,
            hint: "Expected percentage of time property is vacant",
            onChanged: (value) {
              vacancyRate = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExpensesCard() {
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
              Text(
                "Annual Expenses",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "(Required for Net Yield)",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QNumberField(
                  label: "Property Tax (\$)",
                  value: propertyTax,
                  onChanged: (value) {
                    propertyTax = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QNumberField(
                  label: "Maintenance (\$)",
                  value: maintenanceFee,
                  onChanged: (value) {
                    maintenanceFee = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QNumberField(
                  label: "Insurance (\$)",
                  value: insuranceCost,
                  onChanged: (value) {
                    insuranceCost = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QNumberField(
                  label: "Management Fee (\$)",
                  value: managementFee,
                  hint: "Property management costs",
                  onChanged: (value) {
                    managementFee = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          if (_getTotalExpenses() > 0)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Annual Expenses:",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "\$${_getTotalExpenses().currency}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCalculateButton() {
    return Container(
      width: double.infinity,
      child: QButton(
        label: "Calculate Rental Yield",
        icon: Icons.calculate,
        size: bs.md,
        onPressed: () {
          if (formKey.currentState!.validate()) {
            _calculateYield();
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
                Icons.analytics,
                color: successColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Yield Results",
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
              color: _getYieldColor().withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(
                color: _getYieldColor().withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  selectedYieldType,
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${yieldResults['mainYield']}%",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: _getYieldColor(),
                  ),
                ),
                Text(
                  _getYieldRating(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _getYieldColor(),
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
                "Gross Yield",
                "${yieldResults['grossYield']}%",
                Icons.trending_up,
                primaryColor,
              ),
              _buildMetricCard(
                "Net Income",
                "\$${yieldResults['netIncome']?.currency ?? '0'}",
                Icons.account_balance_wallet,
                successColor,
              ),
              _buildMetricCard(
                "Monthly Return",
                "\$${yieldResults['monthlyReturn']?.currency ?? '0'}",
                Icons.calendar_month,
                infoColor,
              ),
              _buildMetricCard(
                "Break-even Time",
                "${yieldResults['breakEven']} years",
                Icons.schedule,
                warningColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonChart() {
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
            "Yield Comparison",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              spacing: spXs,
              children: [
                _buildComparisonRow(
                  "Gross Yield",
                  "${yieldResults['grossYield']}%",
                  double.tryParse("${yieldResults['grossYield']}") ?? 0,
                ),
                if (selectedYieldType != "Gross Yield")
                  _buildComparisonRow(
                    "Net Yield",
                    "${yieldResults['netYield']}%",
                    double.tryParse("${yieldResults['netYield']}") ?? 0,
                  ),
                if (selectedYieldType == "Adjusted Yield")
                  _buildComparisonRow(
                    "Adjusted Yield",
                    "${yieldResults['adjustedYield']}%",
                    double.tryParse("${yieldResults['adjustedYield']}") ?? 0,
                  ),
              ],
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Save Analysis",
                  icon: Icons.save,
                  size: bs.sm,
                  onPressed: () {
                    ss("Yield analysis saved");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Export Report",
                  icon: Icons.file_download,
                  size: bs.sm,
                  onPressed: () {
                    ss("Yield report exported");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMarketComparisonCard() {
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
            "Market Comparison",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...sampleProperties.map((property) {
            Color ratingColor = property["rating"] == "Excellent"
                ? successColor
                : property["rating"] == "Good"
                    ? primaryColor
                    : warningColor;

            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: ratingColor.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(
                  color: ratingColor.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${property["type"]} - ${property["location"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Value: \$${(property["value"] as num).currency} | Rent: \$${(property["rent"] as num).currency}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      spacing: spXs,
                      children: [
                        Text(
                          "${property["yield"]}%",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ratingColor,
                          ),
                        ),
                        Text(
                          "${property["rating"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: ratingColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildBenchmarkCard() {
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
            "Yield Benchmarks",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              spacing: spXs,
              children: [
                _buildBenchmarkRow("Excellent", "8%+", successColor),
                _buildBenchmarkRow("Good", "6-8%", primaryColor),
                _buildBenchmarkRow("Average", "4-6%", warningColor),
                _buildBenchmarkRow("Below Average", "<4%", dangerColor),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: warningColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Consider location, property type, and market conditions when evaluating yields",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
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

  Widget _buildComparisonRow(String type, String percentage, double value) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            type,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            height: 6,
            decoration: BoxDecoration(
              color: disabledColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (value / 10).clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: _getYieldColor(),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            percentage,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: _getYieldColor(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBenchmarkRow(String rating, String range, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          rating,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Text(
          range,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  void _updateAnnualRent() {
    if (monthlyRent.isNotEmpty) {
      double monthly = double.tryParse(monthlyRent) ?? 0;
      annualRent = (monthly * 12).toString();
    }
  }

  double _getTotalExpenses() {
    double tax = double.tryParse(propertyTax) ?? 0;
    double maintenance = double.tryParse(maintenanceFee) ?? 0;
    double insurance = double.tryParse(insuranceCost) ?? 0;
    double management = double.tryParse(managementFee) ?? 0;
    return tax + maintenance + insurance + management;
  }

  void _calculateYield() {
    double propertyVal = double.tryParse(propertyValue) ?? 0;
    double annualRentVal = double.tryParse(annualRent) ?? 0;
    double vacancy = double.tryParse(vacancyRate) ?? 0;
    double totalExpenses = _getTotalExpenses();
    
    // Adjust for vacancy
    double adjustedRent = annualRentVal * (1 - vacancy / 100);
    
    // Calculate different yields
    double grossYield = (annualRentVal / propertyVal) * 100;
    double netIncome = adjustedRent - totalExpenses;
    double netYield = (netIncome / propertyVal) * 100;
    double adjustedYield = ((adjustedRent - totalExpenses) / propertyVal) * 100;
    
    double mainYield;
    switch (selectedYieldType) {
      case "Net Yield":
        mainYield = netYield;
        break;
      case "Adjusted Yield":
        mainYield = adjustedYield;
        break;
      default:
        mainYield = grossYield;
    }
    
    yieldResults = {
      'mainYield': mainYield.toStringAsFixed(2),
      'grossYield': grossYield.toStringAsFixed(2),
      'netYield': netYield.toStringAsFixed(2),
      'adjustedYield': adjustedYield.toStringAsFixed(2),
      'netIncome': netIncome.toInt(),
      'monthlyReturn': (netIncome / 12).toInt(),
      'breakEven': propertyVal > 0 ? (propertyVal / adjustedRent).toStringAsFixed(1) : "0",
    };
    
    showResults = true;
    setState(() {});
  }

  Color _getYieldColor() {
    double yield = double.tryParse(yieldResults['mainYield'] ?? '0') ?? 0;
    if (yield >= 8) return successColor;
    if (yield >= 6) return primaryColor;
    if (yield >= 4) return warningColor;
    return dangerColor;
  }

  String _getYieldRating() {
    double yield = double.tryParse(yieldResults['mainYield'] ?? '0') ?? 0;
    if (yield >= 8) return "Excellent Yield";
    if (yield >= 6) return "Good Yield";
    if (yield >= 4) return "Average Yield";
    return "Below Average Yield";
  }

  String _getYieldDescription() {
    switch (selectedYieldType) {
      case "Net Yield":
        return "Rental income minus all expenses, divided by property value";
      case "Adjusted Yield":
        return "Net yield adjusted for vacancy rates and market conditions";
      default:
        return "Total annual rental income divided by property value";
    }
  }

  String _getYieldFormula() {
    switch (selectedYieldType) {
      case "Net Yield":
        return "(Annual Rent - Expenses) ÷ Property Value × 100";
      case "Adjusted Yield":
        return "(Adjusted Rent - Expenses) ÷ Property Value × 100";
      default:
        return "Annual Rent ÷ Property Value × 100";
    }
  }

  void _showYieldInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Rental Yield Guide"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Gross Yield:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("Annual rent ÷ Property value × 100"),
            SizedBox(height: spSm),
            Text(
              "Net Yield:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("(Annual rent - Expenses) ÷ Property value × 100"),
            SizedBox(height: spSm),
            Text(
              "Adjusted Yield:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("Net yield considering vacancy rates"),
          ],
        ),
        actions: [
          QButton(
            label: "Got it",
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }
}
