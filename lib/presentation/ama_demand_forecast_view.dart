import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaDemandForecastView extends StatefulWidget {
  const AmaDemandForecastView({super.key});

  @override
  State<AmaDemandForecastView> createState() => _AmaDemandForecastViewState();
}

class _AmaDemandForecastViewState extends State<AmaDemandForecastView> {
  String selectedCommodity = "Rice";
  String selectedForecastPeriod = "3 Months";
  String selectedRegion = "National";

  List<Map<String, dynamic>> demandForecasts = [
    {
      "commodity": "Rice",
      "currentDemand": 2500000,
      "forecastedDemand": 2750000,
      "demandGrowth": 10.0,
      "confidence": 92,
      "period": "3 Months",
      "factors": ["Population growth", "Export increase", "Festival season"],
      "riskFactors": ["Weather dependency"],
      "recommendation": "Increase production capacity",
      "icon": Icons.rice_bowl,
      "trend": "Increasing",
    },
    {
      "commodity": "Corn",
      "currentDemand": 1800000,
      "forecastedDemand": 1850000,
      "demandGrowth": 2.8,
      "confidence": 87,
      "period": "3 Months",
      "factors": ["Livestock feed demand", "Industrial use"],
      "riskFactors": ["Import competition", "Price volatility"],
      "recommendation": "Maintain current production",
      "icon": Icons.grass,
      "trend": "Stable",
    },
    {
      "commodity": "Coffee",
      "currentDemand": 450000,
      "forecastedDemand": 520000,
      "demandGrowth": 15.6,
      "confidence": 89,
      "period": "3 Months",
      "factors": ["Export orders", "Premium quality demand"],
      "riskFactors": ["Climate change", "Processing capacity"],
      "recommendation": "Expand premium segments",
      "icon": Icons.coffee,
      "trend": "Increasing",
    },
    {
      "commodity": "Palm Oil",
      "currentDemand": 3200000,
      "forecastedDemand": 3050000,
      "demandGrowth": -4.7,
      "confidence": 84,
      "period": "3 Months",
      "factors": ["Alternative oils competition"],
      "riskFactors": ["Environmental concerns", "Export restrictions"],
      "recommendation": "Diversify product portfolio",
      "icon": Icons.oil_barrel,
      "trend": "Declining",
    },
    {
      "commodity": "Sugar",
      "currentDemand": 950000,
      "forecastedDemand": 1020000,
      "demandGrowth": 7.4,
      "confidence": 88,
      "period": "3 Months",
      "factors": ["Food industry growth", "Beverage sector"],
      "riskFactors": ["Health consciousness", "Sugar tax policies"],
      "recommendation": "Focus on industrial segments",
      "icon": Icons.grain,
      "trend": "Increasing",
    },
  ];

  List<Map<String, dynamic>> seasonalPatterns = [
    {
      "month": "Jan",
      "demand": 85,
      "historical": 82,
      "forecast": 88,
    },
    {
      "month": "Feb",
      "demand": 78,
      "historical": 75,
      "forecast": 82,
    },
    {
      "month": "Mar",
      "demand": 92,
      "historical": 89,
      "forecast": 95,
    },
    {
      "month": "Apr",
      "demand": 88,
      "historical": 85,
      "forecast": 91,
    },
    {
      "month": "May",
      "demand": 96,
      "historical": 94,
      "forecast": 99,
    },
    {
      "month": "Jun",
      "demand": 105,
      "historical": 102,
      "forecast": 108,
    },
  ];

  List<Map<String, dynamic>> demandDrivers = [
    {
      "driver": "Population Growth",
      "impact": "High",
      "contribution": 35,
      "trend": "Positive",
      "description": "Steady population increase driving base demand",
      "icon": Icons.people,
      "color": successColor,
    },
    {
      "driver": "Economic Growth",
      "impact": "High",
      "contribution": 28,
      "trend": "Positive",
      "description": "Rising purchasing power increasing consumption",
      "icon": Icons.trending_up,
      "color": successColor,
    },
    {
      "driver": "Export Demand",
      "impact": "Medium",
      "contribution": 22,
      "trend": "Positive",
      "description": "International market opportunities",
      "icon": Icons.flight_takeoff,
      "color": infoColor,
    },
    {
      "driver": "Industrial Usage",
      "impact": "Medium",
      "contribution": 15,
      "trend": "Stable",
      "description": "Consistent industrial consumption patterns",
      "icon": Icons.factory,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> riskFactors = [
    {
      "risk": "Climate Change",
      "severity": "High",
      "probability": 75,
      "impact": "Production disruption affecting supply-demand balance",
      "mitigation": "Diversified growing regions, climate-resistant varieties",
      "timeframe": "Long-term",
      "icon": Icons.wb_cloudy,
      "color": dangerColor,
    },
    {
      "risk": "Trade Policies",
      "severity": "Medium",
      "probability": 45,
      "impact": "Export restrictions or tariffs affecting demand",
      "mitigation": "Diversified export markets, trade agreements",
      "timeframe": "Medium-term",
      "icon": Icons.policy,
      "color": warningColor,
    },
    {
      "risk": "Price Volatility",
      "severity": "Medium",
      "probability": 60,
      "impact": "Demand fluctuations due to price changes",
      "mitigation": "Price stabilization mechanisms, forward contracts",
      "timeframe": "Short-term",
      "icon": Icons.show_chart,
      "color": warningColor,
    },
    {
      "risk": "Competition",
      "severity": "Low",
      "probability": 35,
      "impact": "Market share loss to alternative products",
      "mitigation": "Product differentiation, quality improvement",
      "timeframe": "Medium-term",
      "icon": Icons.sports,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> commodityItems = [
    {"label": "Rice", "value": "Rice"},
    {"label": "Corn", "value": "Corn"},
    {"label": "Coffee", "value": "Coffee"},
    {"label": "Palm Oil", "value": "Palm Oil"},
    {"label": "Sugar", "value": "Sugar"},
  ];

  List<Map<String, dynamic>> periodItems = [
    {"label": "1 Month", "value": "1 Month"},
    {"label": "3 Months", "value": "3 Months"},
    {"label": "6 Months", "value": "6 Months"},
    {"label": "1 Year", "value": "1 Year"},
  ];

  List<Map<String, dynamic>> regionItems = [
    {"label": "National", "value": "National"},
    {"label": "Java", "value": "Java"},
    {"label": "Sumatra", "value": "Sumatra"},
    {"label": "Sulawesi", "value": "Sulawesi"},
  ];

  @override
  Widget build(BuildContext context) {
    var selectedForecast = demandForecasts.firstWhere(
      (f) => f["commodity"] == selectedCommodity,
      orElse: () => demandForecasts[0],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Demand Forecast"),
        actions: [
          IconButton(
            icon: Icon(Icons.auto_awesome),
            onPressed: () {
              // Navigate to AI insights
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export forecast data
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
            // Forecast Overview Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildForecastCard(
                  "Current Demand",
                  "${((selectedForecast["currentDemand"] as int) / 1000).toStringAsFixed(0)}K tons",
                  Icons.inventory_2,
                  primaryColor,
                  "Total market",
                ),
                _buildForecastCard(
                  "Forecasted Demand",
                  "${((selectedForecast["forecastedDemand"] as int) / 1000).toStringAsFixed(0)}K tons",
                  Icons.trending_up,
                  selectedForecast["demandGrowth"] >= 0 ? successColor : dangerColor,
                  selectedForecast["period"],
                ),
                _buildForecastCard(
                  "Growth Rate",
                  "${(selectedForecast["demandGrowth"] as num) >= 0 ? '+' : ''}${(selectedForecast["demandGrowth"] as num).toStringAsFixed(1)}%",
                  selectedForecast["demandGrowth"] >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
                  selectedForecast["demandGrowth"] >= 0 ? successColor : dangerColor,
                  "Projected growth",
                ),
                _buildForecastCard(
                  "Confidence Level",
                  "${selectedForecast["confidence"]}%",
                  Icons.verified,
                  infoColor,
                  "Forecast accuracy",
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
                  label: "Forecast Period",
                  items: periodItems,
                  value: selectedForecastPeriod,
                  onChanged: (value, label) {
                    selectedForecastPeriod = value;
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

            // Forecast Chart Placeholder
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
                        "Demand Forecast - $selectedCommodity",
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
                          "AI-Powered",
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
                              "Demand Forecast Chart",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Interactive demand visualization",
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

            // Commodity Forecasts
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
                        "Demand Forecasts by Commodity",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...demandForecasts.map((forecast) {
                    bool isPositiveGrowth = (forecast["demandGrowth"] as num) >= 0;
                    Color trendColor = isPositiveGrowth ? successColor : dangerColor;
                    
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
                                  forecast["icon"] as IconData,
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
                                          "${forecast["commodity"]}",
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
                                            color: trendColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${forecast["trend"]}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: trendColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Confidence: ${forecast["confidence"]}%",
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
                                      "Current",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
                                    ),
                                    Text(
                                      "${((forecast["currentDemand"] as int) / 1000).toStringAsFixed(0)}K tons",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
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
                                      "Forecasted",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
                                    ),
                                    Text(
                                      "${((forecast["forecastedDemand"] as int) / 1000).toStringAsFixed(0)}K tons",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
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
                                      "Growth",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          isPositiveGrowth ? Icons.arrow_upward : Icons.arrow_downward,
                                          color: trendColor,
                                          size: 12,
                                        ),
                                        Text(
                                          "${(forecast["demandGrowth"] as num).abs().toStringAsFixed(1)}%",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: trendColor,
                                          ),
                                        ),
                                      ],
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
                                  "Recommendation:",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
                                  ),
                                ),
                                Text(
                                  "${forecast["recommendation"]}",
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
                    );
                  }),
                ],
              ),
            ),

            // Demand Drivers
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
                        Icons.psychology,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Demand Drivers",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...demandDrivers.map((driver) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (driver["color"] as Color).withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border(
                          left: BorderSide(
                            width: 3,
                            color: driver["color"] as Color,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            driver["icon"] as IconData,
                            color: driver["color"] as Color,
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
                                      "${driver["driver"]}",
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
                                        color: (driver["color"] as Color).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${driver["impact"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: driver["color"] as Color,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${driver["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Text(
                                      "Contribution: ${driver["contribution"]}%",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: driver["color"] as Color,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "Trend: ${driver["trend"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
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

            // Risk Factors
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
                        Icons.warning,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Risk Factors",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...riskFactors.map((risk) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (risk["color"] as Color).withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border(
                          left: BorderSide(
                            width: 3,
                            color: risk["color"] as Color,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                risk["icon"] as IconData,
                                color: risk["color"] as Color,
                                size: 18,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${risk["risk"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
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
                                  color: (risk["color"] as Color).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${risk["severity"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: risk["color"] as Color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${risk["impact"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Mitigation: ${risk["mitigation"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "Probability: ${risk["probability"]}%",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: risk["color"] as Color,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "Timeframe: ${risk["timeframe"]}",
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
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForecastCard(String title, String value, IconData icon, Color color, String subtitle) {
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
}
