import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaPriceTrendsView extends StatefulWidget {
  const AmaPriceTrendsView({super.key});

  @override
  State<AmaPriceTrendsView> createState() => _AmaPriceTrendsViewState();
}

class _AmaPriceTrendsViewState extends State<AmaPriceTrendsView> {
  String selectedCommodity = "Rice";
  String selectedPeriod = "7 Days";
  String selectedRegion = "Jakarta";

  List<Map<String, dynamic>> commodities = [
    {
      "name": "Rice",
      "currentPrice": 12500,
      "weeklyChange": 4.2,
      "monthlyChange": 8.5,
      "yearlyChange": 15.3,
      "volatility": "Low",
      "trend": "Upward",
      "icon": Icons.rice_bowl,
      "color": successColor,
    },
    {
      "name": "Corn",
      "currentPrice": 8500,
      "weeklyChange": -2.1,
      "monthlyChange": -5.8,
      "yearlyChange": 3.2,
      "volatility": "Medium",
      "trend": "Downward",
      "icon": Icons.grass,
      "color": dangerColor,
    },
    {
      "name": "Soybeans",
      "currentPrice": 15000,
      "weeklyChange": 3.7,
      "monthlyChange": 12.4,
      "yearlyChange": 22.1,
      "volatility": "High",
      "trend": "Upward",
      "icon": Icons.eco,
      "color": successColor,
    },
    {
      "name": "Coffee",
      "currentPrice": 35000,
      "weeklyChange": 1.8,
      "monthlyChange": 6.3,
      "yearlyChange": 18.7,
      "volatility": "High",
      "trend": "Upward",
      "icon": Icons.coffee,
      "color": successColor,
    },
    {
      "name": "Sugar",
      "currentPrice": 14000,
      "weeklyChange": -1.2,
      "monthlyChange": 2.1,
      "yearlyChange": 9.4,
      "volatility": "Medium",
      "trend": "Stable",
      "icon": Icons.grain,
      "color": warningColor,
    },
    {
      "name": "Palm Oil",
      "currentPrice": 11500,
      "weeklyChange": -3.5,
      "monthlyChange": -8.2,
      "yearlyChange": -2.1,
      "volatility": "High",
      "trend": "Downward",
      "icon": Icons.oil_barrel,
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> priceHistory = [
    {"date": "Jan 1", "price": 11800, "volume": 850},
    {"date": "Jan 2", "price": 11950, "volume": 920},
    {"date": "Jan 3", "price": 11700, "volume": 780},
    {"date": "Jan 4", "price": 12100, "volume": 1050},
    {"date": "Jan 5", "price": 12250, "volume": 1120},
    {"date": "Jan 6", "price": 12300, "volume": 980},
    {"date": "Jan 7", "price": 12500, "volume": 1200},
  ];

  List<Map<String, dynamic>> marketFactors = [
    {
      "factor": "Weather Conditions",
      "impact": "Positive",
      "strength": "High",
      "description": "Favorable weather supporting good harvest",
      "icon": Icons.wb_sunny,
      "color": successColor,
    },
    {
      "factor": "Export Demand",
      "impact": "Positive",
      "strength": "Medium",
      "description": "Increased international orders",
      "icon": Icons.flight_takeoff,
      "color": successColor,
    },
    {
      "factor": "Storage Capacity",
      "impact": "Negative",
      "strength": "Low",
      "description": "Limited warehouse availability",
      "icon": Icons.warehouse,
      "color": dangerColor,
    },
    {
      "factor": "Transportation Cost",
      "impact": "Negative",
      "strength": "Medium",
      "description": "Rising fuel prices affecting logistics",
      "icon": Icons.local_shipping,
      "color": dangerColor,
    },
    {
      "factor": "Government Policy",
      "impact": "Neutral",
      "strength": "Low",
      "description": "New agricultural subsidies announced",
      "icon": Icons.account_balance,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> priceForecasts = [
    {
      "period": "Next Week",
      "predictedPrice": 12800,
      "change": 2.4,
      "confidence": "High",
      "range": "12600 - 13000",
    },
    {
      "period": "Next Month",
      "predictedPrice": 13200,
      "change": 5.6,
      "confidence": "Medium",
      "range": "12800 - 13600",
    },
    {
      "period": "Next Quarter",
      "predictedPrice": 13800,
      "change": 10.4,
      "confidence": "Low",
      "range": "13000 - 14600",
    },
  ];

  List<Map<String, dynamic>> commodityItems = [
    {"label": "Rice", "value": "Rice"},
    {"label": "Corn", "value": "Corn"},
    {"label": "Soybeans", "value": "Soybeans"},
    {"label": "Coffee", "value": "Coffee"},
    {"label": "Sugar", "value": "Sugar"},
    {"label": "Palm Oil", "value": "Palm Oil"},
  ];

  List<Map<String, dynamic>> periodItems = [
    {"label": "7 Days", "value": "7 Days"},
    {"label": "30 Days", "value": "30 Days"},
    {"label": "90 Days", "value": "90 Days"},
    {"label": "1 Year", "value": "1 Year"},
  ];

  List<Map<String, dynamic>> regionItems = [
    {"label": "Jakarta", "value": "Jakarta"},
    {"label": "Surabaya", "value": "Surabaya"},
    {"label": "Medan", "value": "Medan"},
    {"label": "Bandung", "value": "Bandung"},
  ];

  @override
  Widget build(BuildContext context) {
    var selectedCommodityData = commodities.firstWhere(
      (c) => c["name"] == selectedCommodity,
      orElse: () => commodities[0],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Price Trends"),
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
              // Export trend data
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
            // Trend Overview Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildTrendCard(
                  "Current Price",
                  "Rp ${((selectedCommodityData["currentPrice"] as int).toDouble()).currency}/kg",
                  Icons.trending_up,
                  primaryColor,
                  "Live market rate",
                ),
                _buildTrendCard(
                  "Weekly Change",
                  "${(selectedCommodityData["weeklyChange"] as num) >= 0 ? '+' : ''}${(selectedCommodityData["weeklyChange"] as num).toStringAsFixed(1)}%",
                  (selectedCommodityData["weeklyChange"] as num) >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
                  (selectedCommodityData["weeklyChange"] as num) >= 0 ? successColor : dangerColor,
                  "7-day comparison",
                ),
                _buildTrendCard(
                  "Monthly Change",
                  "${(selectedCommodityData["monthlyChange"] as num) >= 0 ? '+' : ''}${(selectedCommodityData["monthlyChange"] as num).toStringAsFixed(1)}%",
                  (selectedCommodityData["monthlyChange"] as num) >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
                  (selectedCommodityData["monthlyChange"] as num) >= 0 ? successColor : dangerColor,
                  "30-day comparison",
                ),
                _buildTrendCard(
                  "Volatility",
                  "${selectedCommodityData["volatility"]}",
                  Icons.show_chart,
                  selectedCommodityData["volatility"] == "High" ? dangerColor : 
                  selectedCommodityData["volatility"] == "Medium" ? warningColor : successColor,
                  "Price stability",
                ),
              ],
            ),

            // Filter Section
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                QDropdownField(
                  label: "Commodity",
                  items: commodityItems,
                  value: selectedCommodity,
                  onChanged: (value, label) {
                    selectedCommodity = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Period",
                  items: periodItems,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
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

            // Price Chart Placeholder
            Container(
              height: 250,
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
                        Icons.show_chart,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Price Trend - $selectedCommodity",
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
                          color: (selectedCommodityData["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${selectedCommodityData["trend"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: selectedCommodityData["color"] as Color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.analytics,
                              color: disabledColor,
                              size: 48,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Price Chart",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Interactive price visualization",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Price History
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
                        Icons.history,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Recent Price History",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...priceHistory.map((history) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.calendar_today,
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
                                  "${history["date"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Volume: ${history["volume"]} tons",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Rp ${((history["price"] as int).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Market Factors
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
                        Icons.analytics,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Market Factors",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...marketFactors.map((factor) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (factor["color"] as Color).withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border(
                          left: BorderSide(
                            width: 3,
                            color: factor["color"] as Color,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            factor["icon"] as IconData,
                            color: factor["color"] as Color,
                            size: 20,
                          ),
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
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
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
                                        color: (factor["color"] as Color).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${factor["strength"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: factor["color"] as Color,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${factor["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Impact: ${factor["impact"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: factor["color"] as Color,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Price Forecasts
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
                        Icons.trending_up,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Price Forecasts",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...priceForecasts.map((forecast) {
                    Color confidenceColor = forecast["confidence"] == "High" 
                      ? successColor
                      : forecast["confidence"] == "Medium"
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
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: confidenceColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.trending_up,
                              color: confidenceColor,
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
                                      "${forecast["period"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
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
                                        color: confidenceColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${forecast["confidence"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: confidenceColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Range: Rp ${forecast["range"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Rp ${((forecast["predictedPrice"] as int).toDouble()).currency}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "+${(forecast["change"] as num).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: successColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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

  Widget _buildTrendCard(String title, String value, IconData icon, Color color, String subtitle) {
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
                Icons.more_horiz,
                color: disabledColor,
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
              fontSize: fsH5,
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
}
