import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlChart6View extends StatefulWidget {
  @override
  State<GrlChart6View> createState() => _GrlChart6ViewState();
}

class _GrlChart6ViewState extends State<GrlChart6View> {
  String selectedCategory = "Sales Performance";
  int selectedQuarter = 0;
  bool showComparison = false;
  
  List<String> quarters = ["Q1 2024", "Q2 2024", "Q3 2024", "Q4 2024"];
  
  List<Map<String, dynamic>> categories = [
    {"label": "Sales Performance", "value": "sales_performance"},
    {"label": "Market Analysis", "value": "market_analysis"},
    {"label": "Customer Growth", "value": "customer_growth"},
    {"label": "Product Performance", "value": "product_performance"},
  ];

  List<Map<String, dynamic>> salesData = [
    {"month": "Jan", "current": 85000, "previous": 78000, "target": 80000},
    {"month": "Feb", "current": 92000, "previous": 82000, "target": 85000},
    {"month": "Mar", "current": 78000, "previous": 88000, "target": 90000},
    {"month": "Apr", "current": 105000, "previous": 95000, "target": 95000},
    {"month": "May", "current": 118000, "previous": 98000, "target": 100000},
    {"month": "Jun", "current": 125000, "previous": 102000, "target": 110000},
  ];

  List<Map<String, dynamic>> productData = [
    {"product": "Premium Plan", "revenue": 245000, "growth": 18.5, "units": 1250},
    {"product": "Standard Plan", "revenue": 189000, "growth": 12.3, "units": 2100},
    {"product": "Basic Plan", "revenue": 156000, "growth": -3.2, "units": 3900},
    {"product": "Enterprise", "revenue": 298000, "growth": 25.7, "units": 180},
    {"product": "Starter", "revenue": 89000, "growth": 8.9, "units": 2800},
  ];

  List<Map<String, dynamic>> regionData = [
    {"region": "North America", "sales": 450000, "percentage": 35, "color": Colors.blue},
    {"region": "Europe", "sales": 380000, "percentage": 29, "color": Colors.green},
    {"region": "Asia Pacific", "sales": 290000, "percentage": 22, "color": Colors.orange},
    {"region": "Latin America", "sales": 120000, "percentage": 9, "color": Colors.purple},
    {"region": "Others", "sales": 65000, "percentage": 5, "color": Colors.grey},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Business Intelligence"),
        actions: [
          Icon(Icons.filter_list, color: primaryColor),
          SizedBox(width: spSm),
          Icon(Icons.share, color: primaryColor),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildControlPanel(),
            _buildKPICards(),
            _buildSalesChart(),
            _buildProductPerformance(),
            _buildRegionalAnalysis(),
            _buildForecastingCard(),
            _buildActionItems(),
          ],
        ),
      ),
    );
  }

  Widget _buildControlPanel() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Dashboard Controls",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categories,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QCategoryPicker(
                  items: quarters.map((q) => {"label": q, "value": q}).toList(),
                  value: quarters[selectedQuarter],
                  onChanged: (index, label, value, item) {
                    selectedQuarter = index;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QSwitch(
            items: [{
              "label": "Show Comparison",
              "value": true,
              "checked": showComparison,
            }],
            value: showComparison ? [{
              "label": "Show Comparison",
              "value": true,
              "checked": true
            }] : [],
            onChanged: (values, ids) {
              showComparison = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildKPICards() {
    List<Map<String, dynamic>> kpis = [
      {"title": "Total Revenue", "value": "\$1.29M", "change": "+24.3%", "icon": Icons.attach_money, "positive": true},
      {"title": "Growth Rate", "value": "18.7%", "change": "+5.2%", "icon": Icons.trending_up, "positive": true},
      {"title": "Avg Deal Size", "value": "\$12.4K", "change": "+8.9%", "icon": Icons.business_center, "positive": true},
      {"title": "Conversion", "value": "34.2%", "change": "-2.1%", "icon": Icons.swap_horiz, "positive": false},
    ];

    return ResponsiveGridView(
      minItemWidth: 200,
      children: kpis.map((kpi) {
        return Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                kpi["positive"] ? successColor.withAlpha(25) : dangerColor.withAlpha(25),
                kpi["positive"] ? successColor.withAlpha(51) : dangerColor.withAlpha(51),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radiusLg),
            border: Border(
              left: BorderSide(
                color: kpi["positive"] ? successColor : dangerColor,
                width: 4,
              ),
            ),
            boxShadow: [shadowMd],
          ),
          child: Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    kpi["icon"],
                    size: 28,
                    color: kpi["positive"] ? successColor : dangerColor,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: kpi["positive"] ? successColor : dangerColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${kpi["change"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "${kpi["title"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "${kpi["value"]}",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSalesChart() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Sales Performance Trends",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Row(
                spacing: spSm,
                children: [
                  _buildChartLegend("Current", primaryColor),
                  if (showComparison) _buildChartLegend("Previous", Colors.grey),
                  _buildChartLegend("Target", successColor),
                ],
              ),
            ],
          ),
          Container(
            height: 250,
            child: Column(
              spacing: spSm,
              children: salesData.map((data) {
                final maxValue = salesData.map((e) => [e["current"], e["previous"], e["target"]].reduce((a, b) => (a as int) > (b as int) ? a : b) as int).reduce((a, b) => a > b ? a : b);
                
                final currentHeight = ((data["current"] as int) / maxValue) * 180;
                final previousHeight = showComparison ? ((data["previous"] as int) / maxValue) * 180 : 0.0;
                final targetHeight = ((data["target"] as int) / maxValue) * 180;
                
                return Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 50,
                        child: Text(
                          "${data["month"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Row(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Current Bar
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "\$${((data["current"] as int) / 1000).toInt()}K",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Container(
                                    width: double.infinity,
                                    height: currentHeight,
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Previous Bar (if comparison enabled)
                            if (showComparison)
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "\$${((data["previous"] as int) / 1000).toInt()}K",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Container(
                                      width: double.infinity,
                                      height: previousHeight,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            // Target Line
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "\$${((data["target"] as int) / 1000).toInt()}K",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Container(
                                    width: double.infinity,
                                    height: 2,
                                    margin: EdgeInsets.only(bottom: targetHeight - 2),
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      borderRadius: BorderRadius.circular(1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
    );
  }

  Widget _buildChartLegend(String label, Color color) {
    return Row(
      spacing: spXs,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildProductPerformance() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Product Performance Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...productData.map((product) {
            final growth = product["growth"] as double;
            final isPositive = growth >= 0;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${product["product"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${product["units"]} units sold",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "\$${((product["revenue"] as int) / 1000).toInt()}K",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: isPositive ? successColor : dangerColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      spacing: spXs,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isPositive ? Icons.trending_up : Icons.trending_down,
                          size: 14,
                          color: Colors.white,
                        ),
                        Text(
                          "${isPositive ? '+' : ''}${growth.toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
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

  Widget _buildRegionalAnalysis() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Regional Sales Distribution",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            spacing: spMd,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  spacing: spSm,
                  children: regionData.map((region) {
                    final totalSales = regionData.fold(0, (sum, r) => sum + (r["sales"] as int));
                    final percentage = ((region["sales"] as int) / totalSales) * 100;
                    
                    return Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: region["color"] as Color,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${region["region"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "\$${((region["sales"] as int) / 1000).toInt()}K",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${percentage.toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: region["color"] as Color,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                child: Container(
                  height: 160,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(51),
                          borderRadius: BorderRadius.circular(60),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Total Sales",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${((regionData.fold(0, (sum, r) => sum + (r["sales"] as int))) / 1000000).toStringAsFixed(1)}M",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForecastingCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [warningColor.withAlpha(25), warningColor.withAlpha(51)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border(left: BorderSide(color: warningColor, width: 4)),
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.psychology, color: warningColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "AI Sales Forecasting",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
            ],
          ),
          Text(
            "Based on current trends, projected Q4 revenue is \$1.45M with 89% confidence. Consider increasing marketing spend in North America for optimal results.",
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              height: 1.4,
            ),
          ),
          Row(
            spacing: spMd,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Text(
                      "Next Month",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$132K",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Text(
                      "Confidence",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "89%",
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
        ],
      ),
    );
  }

  Widget _buildActionItems() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recommended Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Generate Report",
                  icon: Icons.assessment,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Export Data",
                  icon: Icons.download,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
