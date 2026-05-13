import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaMarketAnalysisView extends StatefulWidget {
  const AmaMarketAnalysisView({super.key});

  @override
  State<AmaMarketAnalysisView> createState() => _AmaMarketAnalysisViewState();
}

class _AmaMarketAnalysisViewState extends State<AmaMarketAnalysisView> {
  String selectedAnalysisType = "Comprehensive";
  String selectedTimeframe = "Monthly";
  String selectedRegion = "National";

  List<Map<String, dynamic>> marketInsights = [
    {
      "title": "Rice Market Surge",
      "category": "Price Analysis",
      "insight": "Rice prices increased by 8.5% this month due to favorable weather conditions and increased export demand",
      "impact": "High",
      "confidence": 94,
      "trend": "Upward",
      "timeframe": "30 days",
      "icon": Icons.trending_up,
      "color": successColor,
    },
    {
      "title": "Corn Supply Shortage",
      "category": "Supply Chain",
      "insight": "Corn inventory levels dropped 15% below seasonal average, indicating potential supply constraints",
      "impact": "Medium",
      "confidence": 87,
      "trend": "Concerning",
      "timeframe": "14 days",
      "icon": Icons.warning,
      "color": warningColor,
    },
    {
      "title": "Export Opportunity",
      "category": "Trade Analysis",
      "insight": "Southeast Asian markets showing 22% increased demand for Indonesian coffee beans",
      "impact": "High",
      "confidence": 91,
      "trend": "Opportunity",
      "timeframe": "7 days",
      "icon": Icons.flight_takeoff,
      "color": infoColor,
    },
    {
      "title": "Storage Optimization",
      "category": "Infrastructure",
      "insight": "Warehouse utilization at 78% efficiency, recommend capacity expansion in Java region",
      "impact": "Medium",
      "confidence": 82,
      "trend": "Recommendation",
      "timeframe": "90 days",
      "icon": Icons.warehouse,
      "color": primaryColor,
    },
  ];

  List<Map<String, dynamic>> marketPerformance = [
    {
      "metric": "Total Market Value",
      "current": 2400000000,
      "previous": 2200000000,
      "change": 9.09,
      "unit": "IDR",
      "period": "Monthly",
    },
    {
      "metric": "Trading Volume",
      "current": 45600,
      "previous": 42800,
      "change": 6.54,
      "unit": "tons",
      "period": "Monthly",
    },
    {
      "metric": "Price Volatility",
      "current": 12.3,
      "previous": 15.7,
      "change": -21.66,
      "unit": "%",
      "period": "Monthly",
    },
    {
      "metric": "Market Efficiency",
      "current": 87.5,
      "previous": 85.2,
      "change": 2.70,
      "unit": "%",
      "period": "Monthly",
    },
  ];

  List<Map<String, dynamic>> commodityAnalysis = [
    {
      "commodity": "Rice",
      "marketShare": 28.5,
      "priceStability": "High",
      "demandTrend": "Increasing",
      "supplyStatus": "Adequate",
      "profitability": 15.2,
      "riskLevel": "Low",
      "recommendation": "Strong Buy",
      "icon": Icons.rice_bowl,
    },
    {
      "commodity": "Corn",
      "marketShare": 22.3,
      "priceStability": "Medium",
      "demandTrend": "Stable",
      "supplyStatus": "Tight",
      "profitability": 8.7,
      "riskLevel": "Medium",
      "recommendation": "Hold",
      "icon": Icons.grass,
    },
    {
      "commodity": "Coffee",
      "marketShare": 18.9,
      "priceStability": "Low",
      "demandTrend": "Increasing",
      "supplyStatus": "Good",
      "profitability": 22.4,
      "riskLevel": "High",
      "recommendation": "Buy",
      "icon": Icons.coffee,
    },
    {
      "commodity": "Palm Oil",
      "marketShare": 15.7,
      "priceStability": "Medium",
      "demandTrend": "Declining",
      "supplyStatus": "Oversupply",
      "profitability": 5.3,
      "riskLevel": "High",
      "recommendation": "Sell",
      "icon": Icons.oil_barrel,
    },
  ];

  List<Map<String, dynamic>> regionalAnalysis = [
    {
      "region": "Java",
      "marketValue": 980000000,
      "growth": 12.5,
      "mainCommodities": ["Rice", "Corn", "Sugar"],
      "marketScore": 92,
      "opportunities": 15,
      "challenges": 3,
    },
    {
      "region": "Sumatra",
      "marketValue": 750000000,
      "growth": 8.3,
      "mainCommodities": ["Palm Oil", "Rubber", "Coffee"],
      "marketScore": 87,
      "opportunities": 12,
      "challenges": 5,
    },
    {
      "region": "Sulawesi",
      "marketValue": 420000000,
      "growth": 15.7,
      "mainCommodities": ["Cocoa", "Coffee", "Rice"],
      "marketScore": 83,
      "opportunities": 18,
      "challenges": 7,
    },
    {
      "region": "Kalimantan",
      "marketValue": 250000000,
      "growth": 6.2,
      "mainCommodities": ["Palm Oil", "Rubber"],
      "marketScore": 75,
      "opportunities": 8,
      "challenges": 9,
    },
  ];

  List<Map<String, dynamic>> analysisTypeItems = [
    {"label": "Comprehensive", "value": "Comprehensive"},
    {"label": "Price Focus", "value": "Price Focus"},
    {"label": "Supply Chain", "value": "Supply Chain"},
    {"label": "Trade Analysis", "value": "Trade Analysis"},
  ];

  List<Map<String, dynamic>> timeframeItems = [
    {"label": "Weekly", "value": "Weekly"},
    {"label": "Monthly", "value": "Monthly"},
    {"label": "Quarterly", "value": "Quarterly"},
    {"label": "Yearly", "value": "Yearly"},
  ];

  List<Map<String, dynamic>> regionItems = [
    {"label": "National", "value": "National"},
    {"label": "Java", "value": "Java"},
    {"label": "Sumatra", "value": "Sumatra"},
    {"label": "Sulawesi", "value": "Sulawesi"},
    {"label": "Kalimantan", "value": "Kalimantan"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Market Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // Navigate to detailed analytics
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export analysis report
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
            // Analysis Overview Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildAnalysisCard(
                  "Market Score",
                  "87.5",
                  Icons.analytics,
                  successColor,
                  "Overall health",
                ),
                _buildAnalysisCard(
                  "Active Insights",
                  "${marketInsights.length}",
                  Icons.lightbulb,
                  infoColor,
                  "Generated today",
                ),
                _buildAnalysisCard(
                  "Growth Rate",
                  "+9.1%",
                  Icons.trending_up,
                  successColor,
                  "Month over month",
                ),
                _buildAnalysisCard(
                  "Risk Level",
                  "Medium",
                  Icons.security,
                  warningColor,
                  "Market stability",
                ),
              ],
            ),

            // Filter Section
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                QDropdownField(
                  label: "Analysis Type",
                  items: analysisTypeItems,
                  value: selectedAnalysisType,
                  onChanged: (value, label) {
                    selectedAnalysisType = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Timeframe",
                  items: timeframeItems,
                  value: selectedTimeframe,
                  onChanged: (value, label) {
                    selectedTimeframe = value;
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
              ],
            ),

            // Market Insights
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
                        Icons.insights,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Market Insights",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
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
                          "AI Powered",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...marketInsights.map((insight) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (insight["color"] as Color).withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border(
                          left: BorderSide(
                            width: 3,
                            color: insight["color"] as Color,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                insight["icon"] as IconData,
                                color: insight["color"] as Color,
                                size: 18,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${insight["title"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: (insight["color"] as Color).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${insight["impact"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: insight["color"] as Color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${insight["insight"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              height: 1.4,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: disabledColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${insight["category"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "•",
                                style: TextStyle(color: disabledColor),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${insight["timeframe"]} analysis",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledColor,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.verified,
                                color: successColor,
                                size: 12,
                              ),
                              SizedBox(width: 2),
                              Text(
                                "${insight["confidence"]}% confidence",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
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

            // Market Performance
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
                        Icons.assessment,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Market Performance",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: marketPerformance.map((performance) {
                      bool isPositive = (performance["change"] as num) >= 0;
                      Color changeColor = isPositive ? successColor : dangerColor;
                      
                      return Container(
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
                              "${performance["metric"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            if (performance["unit"] == "IDR") ...[
                              Text(
                                "Rp ${((performance["current"] as int).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ] else ...[
                              Text(
                                "${(performance["current"] as num).toStringAsFixed(1)} ${performance["unit"]}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                                  color: changeColor,
                                  size: 12,
                                ),
                                Text(
                                  "${(performance["change"] as num).abs().toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: changeColor,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${performance["period"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Commodity Analysis
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
                        Icons.inventory,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Commodity Analysis",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...commodityAnalysis.map((commodity) {
                    Color recommendationColor = commodity["recommendation"] == "Strong Buy" || commodity["recommendation"] == "Buy"
                      ? successColor
                      : commodity["recommendation"] == "Hold"
                      ? warningColor
                      : dangerColor;
                    
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
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  commodity["icon"] as IconData,
                                  color: primaryColor,
                                  size: 20,
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
                                          "${commodity["commodity"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: recommendationColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${commodity["recommendation"]}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: recommendationColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Market Share: ${(commodity["marketShare"] as num).toStringAsFixed(1)}%",
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
                                child: _buildAnalysisMetric(
                                  "Profitability",
                                  "${(commodity["profitability"] as num).toStringAsFixed(1)}%",
                                ),
                              ),
                              Expanded(
                                child: _buildAnalysisMetric(
                                  "Price Stability",
                                  "${commodity["priceStability"]}",
                                ),
                              ),
                              Expanded(
                                child: _buildAnalysisMetric(
                                  "Risk Level",
                                  "${commodity["riskLevel"]}",
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: _buildAnalysisMetric(
                                  "Demand Trend",
                                  "${commodity["demandTrend"]}",
                                ),
                              ),
                              Expanded(
                                child: _buildAnalysisMetric(
                                  "Supply Status",
                                  "${commodity["supplyStatus"]}",
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

            // Regional Analysis
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
                        Icons.map,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Regional Analysis",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: regionalAnalysis.map((region) {
                      return Container(
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
                            Row(
                              children: [
                                Text(
                                  "${region["region"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
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
                                    "Score: ${region["marketScore"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: successColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "Rp ${((region["marketValue"] as int).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "+${(region["growth"] as num).toStringAsFixed(1)}% growth",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "Main commodities:",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledColor,
                              ),
                            ),
                            Text(
                              "${(region["mainCommodities"] as List).join(", ")}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Opportunities",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledColor,
                                        ),
                                      ),
                                      Text(
                                        "${region["opportunities"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: successColor,
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
                                        "Challenges",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledColor,
                                        ),
                                      ),
                                      Text(
                                        "${region["challenges"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: warningColor,
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
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalysisCard(String title, String value, IconData icon, Color color, String subtitle) {
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
                Icons.auto_awesome,
                color: infoColor,
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

  Widget _buildAnalysisMetric(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 10,
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
      ],
    );
  }
}
