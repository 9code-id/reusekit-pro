import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaProfitCalculatorView extends StatefulWidget {
  const AmaProfitCalculatorView({super.key});

  @override
  State<AmaProfitCalculatorView> createState() => _AmaProfitCalculatorViewState();
}

class _AmaProfitCalculatorViewState extends State<AmaProfitCalculatorView> {
  String selectedCrop = "Corn";
  String cropVariety = "Sweet Corn";
  String farmSize = "";
  String expectedYield = "";
  String sellingPrice = "";
  String seedCost = "";
  String fertilizerCost = "";
  String pesticideCost = "";
  String laborCost = "";
  String irrigationCost = "";
  String equipmentCost = "";
  String landRentCost = "";
  String transportCost = "";
  String processingCost = "";
  String packagingCost = "";
  String marketingCost = "";
  
  double totalRevenue = 0.0;
  double totalCosts = 0.0;
  double grossProfit = 0.0;
  double profitMargin = 0.0;
  double profitPerAcre = 0.0;
  double breakEvenPrice = 0.0;

  List<Map<String, dynamic>> cropOptions = [
    {"label": "Corn", "value": "Corn"},
    {"label": "Wheat", "value": "Wheat"},
    {"label": "Rice", "value": "Rice"},
    {"label": "Soybeans", "value": "Soybeans"},
    {"label": "Tomatoes", "value": "Tomatoes"},
    {"label": "Potatoes", "value": "Potatoes"},
    {"label": "Cotton", "value": "Cotton"},
    {"label": "Barley", "value": "Barley"},
  ];

  List<Map<String, dynamic>> recentCalculations = [
    {
      "crop": "Corn",
      "farmSize": "50",
      "profit": 25000.0,
      "margin": 23.5,
      "date": "2024-06-10"
    },
    {
      "crop": "Wheat", 
      "farmSize": "30",
      "profit": 18500.0,
      "margin": 21.2,
      "date": "2024-06-08"
    },
    {
      "crop": "Rice",
      "farmSize": "40", 
      "profit": 22000.0,
      "margin": 26.8,
      "date": "2024-06-05"
    },
    {
      "crop": "Soybeans",
      "farmSize": "25",
      "profit": 15200.0,
      "margin": 19.4,
      "date": "2024-06-02"
    },
  ];

  void _calculateProfit() {
    double revenue = (double.tryParse(expectedYield) ?? 0) * (double.tryParse(sellingPrice) ?? 0);
    
    double costs = (double.tryParse(seedCost) ?? 0) +
                  (double.tryParse(fertilizerCost) ?? 0) +
                  (double.tryParse(pesticideCost) ?? 0) +
                  (double.tryParse(laborCost) ?? 0) +
                  (double.tryParse(irrigationCost) ?? 0) +
                  (double.tryParse(equipmentCost) ?? 0) +
                  (double.tryParse(landRentCost) ?? 0) +
                  (double.tryParse(transportCost) ?? 0) +
                  (double.tryParse(processingCost) ?? 0) +
                  (double.tryParse(packagingCost) ?? 0) +
                  (double.tryParse(marketingCost) ?? 0);

    totalRevenue = revenue;
    totalCosts = costs;
    grossProfit = revenue - costs;
    profitMargin = revenue > 0 ? (grossProfit / revenue) * 100 : 0;
    
    double farmSizeValue = double.tryParse(farmSize) ?? 1;
    profitPerAcre = farmSizeValue > 0 ? grossProfit / farmSizeValue : 0;
    
    double yieldValue = double.tryParse(expectedYield) ?? 1;
    breakEvenPrice = yieldValue > 0 ? costs / yieldValue : 0;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profit Calculator"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              //navigateTo('AmaCalculationHistoryView')
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Calculation shared successfully");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(128)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Icon(
                      Icons.calculate,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Farm Profit Calculator",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Calculate expected profits for your crops",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(204),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Crop Selection
            Text(
              "Crop Information",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QDropdownField(
                    label: "Select Crop",
                    items: cropOptions,
                    value: selectedCrop,
                    onChanged: (value, label) {
                      selectedCrop = value;
                      setState(() {});
                    },
                  ),
                  QTextField(
                    label: "Crop Variety",
                    value: cropVariety,
                    hint: "e.g. Sweet Corn, Basmati Rice",
                    onChanged: (value) {
                      cropVariety = value;
                      setState(() {});
                    },
                  ),
                  QNumberField(
                    label: "Farm Size (acres)",
                    value: farmSize,
                    onChanged: (value) {
                      farmSize = value;
                      setState(() {});
                    },
                  ),
                  QNumberField(
                    label: "Expected Yield (units)",
                    value: expectedYield,
                    hint: "Expected total production",
                    onChanged: (value) {
                      expectedYield = value;
                      setState(() {});
                    },
                  ),
                  QNumberField(
                    label: "Selling Price per Unit (\$)",
                    value: sellingPrice,
                    onChanged: (value) {
                      sellingPrice = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Cost Breakdown
            Text(
              "Cost Breakdown",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QNumberField(
                          label: "Seed Cost (\$)",
                          value: seedCost,
                          onChanged: (value) {
                            seedCost = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QNumberField(
                          label: "Fertilizer Cost (\$)",
                          value: fertilizerCost,
                          onChanged: (value) {
                            fertilizerCost = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QNumberField(
                          label: "Pesticide Cost (\$)",
                          value: pesticideCost,
                          onChanged: (value) {
                            pesticideCost = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QNumberField(
                          label: "Labor Cost (\$)",
                          value: laborCost,
                          onChanged: (value) {
                            laborCost = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QNumberField(
                          label: "Irrigation Cost (\$)",
                          value: irrigationCost,
                          onChanged: (value) {
                            irrigationCost = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QNumberField(
                          label: "Equipment Cost (\$)",
                          value: equipmentCost,
                          onChanged: (value) {
                            equipmentCost = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QNumberField(
                          label: "Land Rent (\$)",
                          value: landRentCost,
                          onChanged: (value) {
                            landRentCost = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QNumberField(
                          label: "Transport Cost (\$)",
                          value: transportCost,
                          onChanged: (value) {
                            transportCost = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QNumberField(
                          label: "Processing Cost (\$)",
                          value: processingCost,
                          onChanged: (value) {
                            processingCost = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QNumberField(
                          label: "Packaging Cost (\$)",
                          value: packagingCost,
                          onChanged: (value) {
                            packagingCost = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QNumberField(
                    label: "Marketing Cost (\$)",
                    value: marketingCost,
                    onChanged: (value) {
                      marketingCost = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Calculate Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Calculate Profit",
                icon: Icons.calculate,
                size: bs.md,
                onPressed: _calculateProfit,
              ),
            ),

            // Results Section
            if (totalRevenue > 0 || totalCosts > 0) ...[
              Text(
                "Calculation Results",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      grossProfit >= 0 ? successColor : dangerColor,
                      (grossProfit >= 0 ? successColor : dangerColor).withAlpha(128),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Revenue:",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "\$${totalRevenue.currency}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Costs:",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "\$${totalCosts.currency}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Divider(color: Colors.white.withAlpha(102)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Gross Profit:",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${grossProfit >= 0 ? '+' : ''}\$${grossProfit.currency}",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Additional Metrics
              ResponsiveGridView(
                padding: EdgeInsets.all(spSm),
                minItemWidth: 200,
                children: [
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.percent, color: primaryColor, size: 20),
                            SizedBox(width: spXs),
                            Text(
                              "Profit Margin",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${profitMargin.toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: profitMargin >= 0 ? successColor : dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.landscape, color: primaryColor, size: 20),
                            SizedBox(width: spXs),
                            Text(
                              "Profit per Acre",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "\$${profitPerAcre.currency}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: profitPerAcre >= 0 ? successColor : dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.balance, color: primaryColor, size: 20),
                            SizedBox(width: spXs),
                            Text(
                              "Break-even Price",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "\$${breakEvenPrice.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "per unit",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],

            // Recent Calculations
            Text(
              "Recent Calculations",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: recentCalculations.map((calc) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            Icons.agriculture,
                            color: primaryColor,
                            size: 16,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${calc["crop"]} - ${calc["farmSize"]} acres",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Text(
                                    "\$${((calc["profit"] as double)).currency}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${(calc["margin"] as num).toStringAsFixed(1)}%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${calc["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
