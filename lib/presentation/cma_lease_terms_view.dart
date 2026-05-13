import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaLeaseTermsView extends StatefulWidget {
  const CmaLeaseTermsView({super.key});

  @override
  State<CmaLeaseTermsView> createState() => _CmaLeaseTermsViewState();
}

class _CmaLeaseTermsViewState extends State<CmaLeaseTermsView> {
  String vehiclePrice = "45000";
  String downPayment = "3000";
  String leaseTerm = "36";
  String residualPercentage = "60";
  String moneyFactor = "0.0025";
  String salesTax = "8.5";
  String acquisitionFee = "595";
  String dispositionFee = "350";
  String mileageLimit = "12000";

  bool includeTax = true;
  bool includeGapInsurance = false;
  String gapInsuranceCost = "500";

  List<Map<String, dynamic>> leaseTermOptions = [
    {"label": "24 months", "value": "24"},
    {"label": "36 months", "value": "36"},
    {"label": "39 months", "value": "39"},
    {"label": "48 months", "value": "48"},
  ];

  List<Map<String, dynamic>> mileageOptions = [
    {"label": "10,000 miles/year", "value": "10000"},
    {"label": "12,000 miles/year", "value": "12000"},
    {"label": "15,000 miles/year", "value": "15000"},
    {"label": "18,000 miles/year", "value": "18000"},
  ];

  List<Map<String, dynamic>> comparisonScenarios = [];

  double get vehiclePriceValue => double.tryParse(vehiclePrice) ?? 0;
  double get downPaymentValue => double.tryParse(downPayment) ?? 0;
  double get leaseTermValue => double.tryParse(leaseTerm) ?? 36;
  double get residualValue => vehiclePriceValue * (double.tryParse(residualPercentage) ?? 60) / 100;
  double get moneyFactorValue => double.tryParse(moneyFactor) ?? 0.0025;
  double get salesTaxValue => double.tryParse(salesTax) ?? 0;

  double get depreciation => vehiclePriceValue - residualValue;
  double get monthlyDepreciation => depreciation / leaseTermValue;
  double get monthlyFinanceCharge => (vehiclePriceValue + residualValue) * moneyFactorValue;
  double get monthlyPaymentBeforeTax => monthlyDepreciation + monthlyFinanceCharge;
  double get monthlyTax => includeTax ? (monthlyPaymentBeforeTax * salesTaxValue / 100) : 0;
  double get monthlyPayment => monthlyPaymentBeforeTax + monthlyTax;
  double get totalCost => (monthlyPayment * leaseTermValue) + downPaymentValue + (double.tryParse(acquisitionFee) ?? 0) + (double.tryParse(dispositionFee) ?? 0);
  double get totalDueAtSigning => downPaymentValue + (double.tryParse(acquisitionFee) ?? 0) + monthlyPayment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lease Terms Calculator"),
        actions: [
          IconButton(
            onPressed: () {
              _addToComparison();
            },
            icon: Icon(Icons.add_box),
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
                    label: "Vehicle MSRP (\$)",
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
                          label: "Residual Percentage (%)",
                          value: residualPercentage,
                          onChanged: (value) {
                            residualPercentage = value;
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

            // Lease Terms
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
                    "Lease Terms",
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
                          label: "Lease Term",
                          items: leaseTermOptions,
                          value: leaseTerm,
                          onChanged: (value, label) {
                            leaseTerm = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Mileage Allowance",
                          items: mileageOptions,
                          value: mileageLimit,
                          onChanged: (value, label) {
                            mileageLimit = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  QNumberField(
                    label: "Money Factor",
                    value: moneyFactor,
                    onChanged: (value) {
                      moneyFactor = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Fees & Taxes
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
                    "Fees & Taxes",
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
                          label: "Acquisition Fee (\$)",
                          value: acquisitionFee,
                          onChanged: (value) {
                            acquisitionFee = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QNumberField(
                          label: "Disposition Fee (\$)",
                          value: dispositionFee,
                          onChanged: (value) {
                            dispositionFee = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spSm),

                  // GAP Insurance Toggle
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "GAP Insurance",
                              "value": true,
                              "checked": includeGapInsurance,
                            }
                          ],
                          value: [
                            if (includeGapInsurance)
                              {
                                "label": "GAP Insurance",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            includeGapInsurance = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                      if (includeGapInsurance) ...[
                        SizedBox(width: spSm),
                        Container(
                          width: 120,
                          child: QNumberField(
                            label: "GAP Cost (\$)",
                            value: gapInsuranceCost,
                            onChanged: (value) {
                              gapInsuranceCost = value;
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

            // Payment Calculation
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
                    "Lease Payment Breakdown",
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
                          "Monthly Lease Payment",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spSm),

                  // Payment Components
                  Column(
                    children: [
                      _buildCalculationRow("Vehicle MSRP", "\$${vehiclePriceValue.currency}"),
                      _buildCalculationRow("Residual Value (${residualPercentage}%)", "\$${residualValue.currency}"),
                      _buildCalculationRow("Depreciation", "\$${depreciation.currency}"),
                      _buildCalculationRow("Monthly Depreciation", "\$${monthlyDepreciation.currency}"),
                      _buildCalculationRow("Monthly Finance Charge", "\$${monthlyFinanceCharge.currency}"),
                      _buildCalculationRow("Payment Before Tax", "\$${monthlyPaymentBeforeTax.currency}"),
                      if (includeTax)
                        _buildCalculationRow("Sales Tax (${salesTax}%)", "\$${monthlyTax.currency}"),
                      _buildCalculationRow("Monthly Payment", "\$${monthlyPayment.currency}", isTotal: true),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Total Cost Summary
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
                    "Cost Summary",
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
                        child: _buildSummaryCard(
                          "Due at Signing",
                          "\$${totalDueAtSigning.currency}",
                          Icons.payment,
                          warningColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildSummaryCard(
                          "Total Lease Cost",
                          "\$${totalCost.currency}",
                          Icons.calculate,
                          infoColor,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spSm),

                  // Cost Breakdown
                  Column(
                    children: [
                      _buildCostRow("Down Payment", downPaymentValue),
                      _buildCostRow("Acquisition Fee", double.tryParse(acquisitionFee) ?? 0),
                      _buildCostRow("Monthly Payments (${leaseTerm}x)", monthlyPayment * leaseTermValue),
                      _buildCostRow("Disposition Fee", double.tryParse(dispositionFee) ?? 0),
                      if (includeGapInsurance)
                        _buildCostRow("GAP Insurance", double.tryParse(gapInsuranceCost) ?? 0),
                      Container(
                        height: 1,
                        color: primaryColor.withAlpha(100),
                        margin: EdgeInsets.symmetric(vertical: spXs),
                      ),
                      _buildCostRow("Total Cost", totalCost, isTotal: true),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Mileage Information
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
                    "Mileage Terms",
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
                        child: _buildMileageInfo(
                          "Annual Limit",
                          "${(int.tryParse(mileageLimit) ?? 12000).toDouble().currency} miles",
                          Icons.speed,
                        ),
                      ),
                      Expanded(
                        child: _buildMileageInfo(
                          "Total Allowed",
                          "${((int.tryParse(mileageLimit) ?? 12000) * (int.tryParse(leaseTerm) ?? 36) / 12).toStringAsFixed(0)} miles",
                          Icons.straighten,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spSm),

                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.warning, color: warningColor, size: 20),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "Excess mileage typically charged at \$0.25-\$0.30 per mile",
                            style: TextStyle(
                              fontSize: 12,
                              color: warningColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            if (comparisonScenarios.isNotEmpty) ...[
              SizedBox(height: spMd),
              
              // Comparison Section
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
                      "Comparison Scenarios",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    Column(
                      children: comparisonScenarios.map((scenario) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${scenario["term"]} months • \$${scenario["vehicle_price"]} MSRP",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${scenario["mileage"]} miles/year • ${scenario["residual"]}% residual",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "\$${scenario["monthly_payment"]}/mo",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    comparisonScenarios.remove(scenario);
                                  });
                                },
                                child: Icon(Icons.close, size: 16, color: disabledBoldColor),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],

            SizedBox(height: spLg),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Save Calculation",
                    size: bs.md,
                    onPressed: () {
                      _saveCalculation();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Find Deals",
                    size: bs.md,
                    onPressed: () {
                      _findDeals();
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

  Widget _buildCalculationRow(String label, String value, {bool isTotal = false}) {
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
                fontSize: isTotal ? 14 : 12,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: isTotal ? primaryColor : disabledBoldColor,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 14 : 12,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: isTotal ? primaryColor : disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCostRow(String label, double amount, {bool isTotal = false}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: isTotal ? 14 : 12,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: isTotal ? primaryColor : disabledBoldColor,
              ),
            ),
          ),
          Text(
            "\$${amount.currency}",
            style: TextStyle(
              fontSize: isTotal ? 14 : 12,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: isTotal ? primaryColor : disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMileageInfo(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: primaryColor, size: 20),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  void _addToComparison() {
    final scenario = {
      "term": leaseTerm,
      "vehicle_price": vehiclePrice,
      "mileage": (int.tryParse(mileageLimit) ?? 12000) ~/ 1000,
      "residual": residualPercentage,
      "monthly_payment": monthlyPayment.toStringAsFixed(0),
    };
    
    setState(() {
      comparisonScenarios.add(scenario);
    });
    
    ss("Scenario added to comparison");
  }

  void _saveCalculation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Save Calculation"),
        content: Text("Save this lease calculation for future reference?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ss("Lease calculation saved successfully");
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  void _findDeals() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Find Lease Deals"),
        content: Text("Search for current lease deals matching your criteria?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              si("Searching for lease deals...");
            },
            child: Text("Search"),
          ),
        ],
      ),
    );
  }
}
