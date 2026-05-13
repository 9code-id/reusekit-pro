import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaCommodityRatesView extends StatefulWidget {
  const AmaCommodityRatesView({super.key});

  @override
  State<AmaCommodityRatesView> createState() => _AmaCommodityRatesViewState();
}

class _AmaCommodityRatesViewState extends State<AmaCommodityRatesView> {
  String selectedCategory = "All Categories";
  String selectedRegion = "All Regions";
  String selectedGrade = "All Grades";

  List<Map<String, dynamic>> commodityRates = [
    {
      "commodity": "Rice",
      "category": "Grains",
      "grade": "Premium",
      "currentRate": 12500,
      "baseRate": 12000,
      "variance": 4.17,
      "unit": "kg",
      "region": "Jakarta",
      "market": "Central Market",
      "effectiveDate": "2024-01-15",
      "validUntil": "2024-01-22",
      "qualitySpecs": "Moisture ≤14%, Broken grain ≤5%",
      "icon": Icons.rice_bowl,
      "status": "Active",
    },
    {
      "commodity": "Corn",
      "category": "Grains",
      "grade": "Grade A",
      "currentRate": 8500,
      "baseRate": 9000,
      "variance": -5.56,
      "unit": "kg",
      "region": "Surabaya",
      "market": "Wholesale Center",
      "effectiveDate": "2024-01-15",
      "validUntil": "2024-01-22",
      "qualitySpecs": "Moisture ≤15%, Foreign matter ≤2%",
      "icon": Icons.grass,
      "status": "Active",
    },
    {
      "commodity": "Soybeans",
      "category": "Legumes",
      "grade": "Export Quality",
      "currentRate": 15000,
      "baseRate": 14200,
      "variance": 5.63,
      "unit": "kg",
      "region": "Medan",
      "market": "Agricultural Hub",
      "effectiveDate": "2024-01-15",
      "validUntil": "2024-01-22",
      "qualitySpecs": "Protein ≥38%, Oil ≥18%",
      "icon": Icons.eco,
      "status": "Active",
    },
    {
      "commodity": "Coffee",
      "category": "Beverages",
      "grade": "Arabica Premium",
      "currentRate": 45000,
      "baseRate": 42000,
      "variance": 7.14,
      "unit": "kg",
      "region": "Bandung",
      "market": "Export Terminal",
      "effectiveDate": "2024-01-15",
      "validUntil": "2024-01-22",
      "qualitySpecs": "Screen size 16+, Defects <5%",
      "icon": Icons.coffee,
      "status": "Active",
    },
    {
      "commodity": "Sugar",
      "category": "Sweeteners",
      "grade": "Refined",
      "currentRate": 14000,
      "baseRate": 14500,
      "variance": -3.45,
      "unit": "kg",
      "region": "Jakarta",
      "market": "Industrial Market",
      "effectiveDate": "2024-01-15",
      "validUntil": "2024-01-22",
      "qualitySpecs": "Purity ≥99.7%, Color ICUMSA 45",
      "icon": Icons.grain,
      "status": "Active",
    },
    {
      "commodity": "Palm Oil",
      "category": "Oils",
      "grade": "Crude",
      "currentRate": 11500,
      "baseRate": 12200,
      "variance": -5.74,
      "unit": "kg",
      "region": "Riau",
      "market": "Plantation Direct",
      "effectiveDate": "2024-01-15",
      "validUntil": "2024-01-22",
      "qualitySpecs": "FFA ≤3.5%, Moisture ≤0.1%",
      "icon": Icons.oil_barrel,
      "status": "Active",
    },
    {
      "commodity": "Rubber",
      "category": "Industrial",
      "grade": "RSS 1",
      "currentRate": 28000,
      "baseRate": 26500,
      "variance": 5.66,
      "unit": "kg",
      "region": "Sumatra",
      "market": "Processing Plant",
      "effectiveDate": "2024-01-15",
      "validUntil": "2024-01-22",
      "qualitySpecs": "DRC ≥60%, Dirt content ≤0.05%",
      "icon": Icons.circle,
      "status": "Active",
    },
    {
      "commodity": "Cocoa",
      "category": "Beverages",
      "grade": "Fine Flavor",
      "currentRate": 38000,
      "baseRate": 36000,
      "variance": 5.56,
      "unit": "kg",
      "region": "Sulawesi",
      "market": "Export Terminal",
      "effectiveDate": "2024-01-15",
      "validUntil": "2024-01-22",
      "qualitySpecs": "Bean count 100/100g, Defects <3%",
      "icon": Icons.local_cafe,
      "status": "Active",
    },
  ];

  List<Map<String, dynamic>> rateComparisons = [
    {
      "commodity": "Rice",
      "thisWeek": 12500,
      "lastWeek": 12000,
      "thisMonth": 12500,
      "lastMonth": 11800,
      "thisYear": 12500,
      "lastYear": 10500,
    },
    {
      "commodity": "Corn",
      "thisWeek": 8500,
      "lastWeek": 8800,
      "thisMonth": 8500,
      "lastMonth": 8200,
      "thisYear": 8500,
      "lastYear": 7800,
    },
    {
      "commodity": "Soybeans",
      "thisWeek": 15000,
      "lastWeek": 14500,
      "thisMonth": 15000,
      "lastMonth": 14000,
      "thisYear": 15000,
      "lastYear": 12500,
    },
  ];

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Categories", "value": "All Categories"},
    {"label": "Grains", "value": "Grains"},
    {"label": "Legumes", "value": "Legumes"},
    {"label": "Beverages", "value": "Beverages"},
    {"label": "Sweeteners", "value": "Sweeteners"},
    {"label": "Oils", "value": "Oils"},
    {"label": "Industrial", "value": "Industrial"},
  ];

  List<Map<String, dynamic>> regionItems = [
    {"label": "All Regions", "value": "All Regions"},
    {"label": "Jakarta", "value": "Jakarta"},
    {"label": "Surabaya", "value": "Surabaya"},
    {"label": "Medan", "value": "Medan"},
    {"label": "Bandung", "value": "Bandung"},
    {"label": "Riau", "value": "Riau"},
    {"label": "Sumatra", "value": "Sumatra"},
    {"label": "Sulawesi", "value": "Sulawesi"},
  ];

  List<Map<String, dynamic>> gradeItems = [
    {"label": "All Grades", "value": "All Grades"},
    {"label": "Premium", "value": "Premium"},
    {"label": "Grade A", "value": "Grade A"},
    {"label": "Export Quality", "value": "Export Quality"},
    {"label": "Refined", "value": "Refined"},
    {"label": "Crude", "value": "Crude"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Commodity Rates"),
        actions: [
          IconButton(
            icon: Icon(Icons.compare_arrows),
            onPressed: () {
              // Navigate to rate comparison
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export rates data
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Rate Overview Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildRateCard(
                  "Total Commodities",
                  "${commodityRates.length}",
                  Icons.inventory,
                  primaryColor,
                  "Active rates",
                ),
                _buildRateCard(
                  "Average Rate",
                  "Rp ${((commodityRates.map((c) => c["currentRate"] as int).reduce((a, b) => a + b)) / commodityRates.length).toStringAsFixed(0)}",
                  Icons.trending_up,
                  successColor,
                  "Per kilogram",
                ),
                _buildRateCard(
                  "Rate Updates",
                  "24",
                  Icons.update,
                  infoColor,
                  "Today",
                ),
                _buildRateCard(
                  "Market Coverage",
                  "8 Regions",
                  Icons.location_on,
                  warningColor,
                  "Nationwide",
                ),
              ],
            ),

            // Filter Section
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                QDropdownField(
                  label: "Category",
                  items: categoryItems,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Region",
                  items: regionItems,
                  value: selectedRegion,
                  onChanged: (value, label) {
                    selectedRegion = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Grade",
                  items: gradeItems,
                  value: selectedGrade,
                  onChanged: (value, label) {
                    selectedGrade = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            // Rate Comparison Summary
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
                  Row(
                    children: [
                      Icon(
                        Icons.compare,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Rate Comparison",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...rateComparisons.map((comparison) {
                    double weeklyChange = (((comparison["thisWeek"] as int) - (comparison["lastWeek"] as int)) / (comparison["lastWeek"] as int)) * 100;
                    double monthlyChange = (((comparison["thisMonth"] as int) - (comparison["lastMonth"] as int)) / (comparison["lastMonth"] as int)) * 100;
                    double yearlyChange = (((comparison["thisYear"] as int) - (comparison["lastYear"] as int)) / (comparison["lastYear"] as int)) * 100;
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${comparison["commodity"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: _buildComparisonItem(
                                  "Weekly",
                                  "Rp ${((comparison["thisWeek"] as int).toDouble()).currency}",
                                  weeklyChange,
                                ),
                              ),
                              Expanded(
                                child: _buildComparisonItem(
                                  "Monthly", 
                                  "Rp ${((comparison["thisMonth"] as int).toDouble()).currency}",
                                  monthlyChange,
                                ),
                              ),
                              Expanded(
                                child: _buildComparisonItem(
                                  "Yearly",
                                  "Rp ${((comparison["thisYear"] as int).toDouble()).currency}",
                                  yearlyChange,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Commodity Rates List
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
                  Row(
                    children: [
                      Icon(
                        Icons.price_check,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Current Rates",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: successColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Live Rates",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...commodityRates.map((rate) {
                    bool isPositive = (rate["variance"] as num) >= 0;
                    Color varianceColor = isPositive ? successColor : dangerColor;
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  rate["icon"] as IconData,
                                  color: primaryColor,
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${rate["commodity"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        SizedBox(width: spXs),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: infoColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${rate["grade"]}",
                                            style: TextStyle(
                                              fontSize: 9,
                                              fontWeight: FontWeight.w600,
                                              color: infoColor,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: varianceColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                                                color: varianceColor,
                                                size: 10,
                                              ),
                                              Text(
                                                "${(rate["variance"] as num).abs().toStringAsFixed(1)}%",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  color: varianceColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${rate["category"]} • ${rate["region"]}",
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
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Current Rate",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
                                    ),
                                    Text(
                                      "Rp ${((rate["currentRate"] as int).toDouble()).currency}/${rate["unit"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Base Rate",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
                                    ),
                                    Text(
                                      "Rp ${((rate["baseRate"] as int).toDouble()).currency}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Market",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
                                    ),
                                    Text(
                                      "${rate["market"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Quality Specifications:",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
                                  ),
                                ),
                                Text(
                                  "${rate["qualitySpecs"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Text(
                                "Valid: ${rate["effectiveDate"]} - ${rate["validUntil"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledColor,
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${rate["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRateCard(String title, String value, IconData icon, Color color, String subtitle) {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Spacer(),
              Icon(
                Icons.trending_up,
                color: successColor,
                size: 16,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              color: disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonItem(String period, String value, double change) {
    bool isPositive = change >= 0;
    Color changeColor = isPositive ? successColor : dangerColor;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          period,
          style: TextStyle(
            fontSize: 11,
            color: disabledColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        Row(
          children: [
            Icon(
              isPositive ? Icons.arrow_upward : Icons.arrow_downward,
              color: changeColor,
              size: 10,
            ),
            Text(
              "${change.abs().toStringAsFixed(1)}%",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: changeColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
