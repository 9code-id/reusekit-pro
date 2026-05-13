import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaMarketAnalysisView extends StatefulWidget {
  const RmaMarketAnalysisView({super.key});

  @override
  State<RmaMarketAnalysisView> createState() => _RmaMarketAnalysisViewState();
}

class _RmaMarketAnalysisViewState extends State<RmaMarketAnalysisView> {
  Map<String, dynamic> marketData = {
    "area": "Downtown District",
    "median_price": 785000.0,
    "price_change": 8.3,
    "days_on_market": 21,
    "inventory_level": "Low",
    "market_temperature": "Hot",
    "last_updated": "2024-12-15",
  };

  List<Map<String, dynamic>> marketTrends = [
    {
      "period": "Q4 2024",
      "median_price": 785000.0,
      "price_change": 8.3,
      "sales_volume": 156,
      "days_on_market": 21,
    },
    {
      "period": "Q3 2024", 
      "median_price": 724000.0,
      "price_change": 6.7,
      "sales_volume": 189,
      "days_on_market": 28,
    },
    {
      "period": "Q2 2024",
      "median_price": 678000.0,
      "price_change": 4.2,
      "sales_volume": 203,
      "days_on_market": 35,
    },
    {
      "period": "Q1 2024",
      "median_price": 651000.0,
      "price_change": 2.8,
      "sales_volume": 167,
      "days_on_market": 42,
    },
  ];

  List<Map<String, dynamic>> marketIndicators = [
    {
      "name": "Price-to-Income Ratio",
      "value": 4.2,
      "benchmark": 3.5,
      "status": "Above Average",
      "trend": "rising",
    },
    {
      "name": "Absorption Rate",
      "value": 2.8,
      "benchmark": 6.0,
      "status": "Seller's Market",
      "trend": "stable",
    },
    {
      "name": "Inventory Months",
      "value": 1.4,
      "benchmark": 6.0,
      "status": "Low Supply",
      "trend": "decreasing",
    },
    {
      "name": "Price Per Sq Ft",
      "value": 425.0,
      "benchmark": 380.0,
      "status": "Premium",
      "trend": "rising",
    },
  ];

  List<Map<String, dynamic>> neighborhoodComparison = [
    {
      "neighborhood": "Downtown District",
      "median_price": 785000.0,
      "price_change": 8.3,
      "days_on_market": 21,
      "is_current": true,
    },
    {
      "neighborhood": "Riverside Heights",
      "median_price": 920000.0,
      "price_change": 5.2,
      "days_on_market": 18,
      "is_current": false,
    },
    {
      "neighborhood": "Oak Valley",
      "median_price": 650000.0,
      "price_change": 12.1,
      "days_on_market": 25,
      "is_current": false,
    },
    {
      "neighborhood": "Maple Commons",
      "median_price": 580000.0,
      "price_change": 7.8,
      "days_on_market": 33,
      "is_current": false,
    },
  ];

  List<Map<String, dynamic>> marketForecast = [
    {
      "period": "Q1 2025",
      "predicted_change": 4.2,
      "confidence": 78,
      "factors": ["Interest rates", "Employment growth"],
    },
    {
      "period": "Q2 2025", 
      "predicted_change": 3.8,
      "confidence": 72,
      "factors": ["Seasonal trends", "New developments"],
    },
    {
      "period": "Q3 2025",
      "predicted_change": 2.1,
      "confidence": 65,
      "factors": ["Market cooling", "Increased supply"],
    },
  ];

  String selectedMetric = "median_price";
  List<String> metrics = ["median_price", "price_change", "sales_volume", "days_on_market"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Market Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () => _changeLocation(),
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => _refreshData(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMarketOverview(),
            SizedBox(height: spLg),
            _buildMarketTemperature(),
            SizedBox(height: spLg),
            _buildKeyMetrics(),
            SizedBox(height: spLg),
            _buildMarketTrends(),
            SizedBox(height: spLg),
            _buildMarketIndicators(),
            SizedBox(height: spLg),
            _buildNeighborhoodComparison(),
            SizedBox(height: spLg),
            _buildMarketForecast(),
          ],
        ),
      ),
    );
  }

  Widget _buildMarketOverview() {
    return Container(
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
              Icon(Icons.location_city, size: 24, color: primaryColor),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${marketData["area"]}",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "\$${(marketData["median_price"] as double).currency}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Median Price",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          (marketData["price_change"] as double) >= 0 
                              ? Icons.trending_up 
                              : Icons.trending_down,
                          size: 16,
                          color: (marketData["price_change"] as double) >= 0 
                              ? successColor 
                              : dangerColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${(marketData["price_change"] as double) >= 0 ? '+' : ''}${(marketData["price_change"] as double).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: (marketData["price_change"] as double) >= 0 
                                ? successColor 
                                : dangerColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "YoY Change",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${marketData["days_on_market"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Days on Market",
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
      ),
    );
  }

  Widget _buildMarketTemperature() {
    String temperature = marketData["market_temperature"];
    Color temperatureColor = temperature == "Hot" 
        ? dangerColor 
        : temperature == "Warm" 
            ? warningColor 
            : temperature == "Cool" 
                ? infoColor 
                : successColor;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [temperatureColor, temperatureColor.withAlpha(179)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(
            temperature == "Hot" 
                ? Icons.whatshot 
                : temperature == "Warm" 
                    ? Icons.trending_up 
                    : Icons.ac_unit,
            size: 48,
            color: Colors.white,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Market Temperature",
                  style: TextStyle(
                    color: Colors.white.withAlpha(230),
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "$temperature Market",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${marketData["inventory_level"]} inventory, fast sales",
                  style: TextStyle(
                    color: Colors.white.withAlpha(204),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyMetrics() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Key Market Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildMetricCard("Median Price", "\$${(marketData["median_price"] as double).currency}", Icons.attach_money, primaryColor),
              _buildMetricCard("Price Change", "${(marketData["price_change"] as double) >= 0 ? '+' : ''}${(marketData["price_change"] as double).toStringAsFixed(1)}%", Icons.trending_up, successColor),
              _buildMetricCard("Days on Market", "${marketData["days_on_market"]}", Icons.access_time, warningColor),
              _buildMetricCard("Inventory Level", "${marketData["inventory_level"]}", Icons.inventory, infoColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(26),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(51)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: color),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketTrends() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Market Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QHorizontalScroll(
            children: marketTrends.map((trend) {
              return Container(
                width: 180,
                margin: EdgeInsets.only(right: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border.all(color: disabledOutlineBorderColor),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${trend["period"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    _buildTrendRow("Median Price", "\$${((trend["median_price"] as double) / 1000).toStringAsFixed(0)}K"),
                    _buildTrendRow("Price Change", "${(trend["price_change"] as double) >= 0 ? '+' : ''}${(trend["price_change"] as double).toStringAsFixed(1)}%"),
                    _buildTrendRow("Sales Volume", "${trend["sales_volume"]}"),
                    _buildTrendRow("Days on Market", "${trend["days_on_market"]}"),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
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
      ),
    );
  }

  Widget _buildMarketIndicators() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Market Indicators",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spSm,
            children: marketIndicators.map((indicator) {
              return _buildIndicatorCard(indicator);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicatorCard(Map<String, dynamic> indicator) {
    Color trendColor = indicator["trend"] == "rising" 
        ? successColor 
        : indicator["trend"] == "decreasing" 
            ? dangerColor 
            : warningColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${indicator["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${indicator["value"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "vs ${indicator["benchmark"]}",
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: trendColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${indicator["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: trendColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: spXs),
              Row(
                children: [
                  Icon(
                    indicator["trend"] == "rising" 
                        ? Icons.trending_up 
                        : indicator["trend"] == "decreasing" 
                            ? Icons.trending_down 
                            : Icons.trending_flat,
                    size: 16,
                    color: trendColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${indicator["trend"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: trendColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNeighborhoodComparison() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Neighborhood Comparison",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spSm,
            children: neighborhoodComparison.map((neighborhood) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (neighborhood["is_current"] as bool) 
                      ? primaryColor.withAlpha(26) 
                      : Colors.transparent,
                  border: Border.all(
                    color: (neighborhood["is_current"] as bool) 
                        ? primaryColor 
                        : disabledOutlineBorderColor,
                  ),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${neighborhood["neighborhood"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              if (neighborhood["is_current"] as bool) ...[
                                SizedBox(width: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "CURRENT",
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "\$${((neighborhood["median_price"] as double) / 1000).toStringAsFixed(0)}K median",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(
                              (neighborhood["price_change"] as double) >= 0 
                                  ? Icons.trending_up 
                                  : Icons.trending_down,
                              size: 14,
                              color: (neighborhood["price_change"] as double) >= 0 
                                  ? successColor 
                                  : dangerColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${(neighborhood["price_change"] as double) >= 0 ? '+' : ''}${(neighborhood["price_change"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: (neighborhood["price_change"] as double) >= 0 
                                    ? successColor 
                                    : dangerColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${neighborhood["days_on_market"]} days",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
    );
  }

  Widget _buildMarketForecast() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Market Forecast",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spSm,
            children: marketForecast.map((forecast) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border.all(color: disabledOutlineBorderColor),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${forecast["period"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "${(forecast["predicted_change"] as double) >= 0 ? '+' : ''}${(forecast["predicted_change"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: (forecast["predicted_change"] as double) >= 0 
                                    ? successColor 
                                    : dangerColor,
                              ),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "(${forecast["confidence"]}%)",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Wrap(
                      spacing: spXs,
                      children: (forecast["factors"] as List<dynamic>).map((factor) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "$factor",
                            style: TextStyle(
                              fontSize: 10,
                              color: infoColor,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Detailed Report",
                  size: bs.sm,
                  icon: Icons.assessment,
                  onPressed: () => _viewDetailedReport(),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Export Data",
                  size: bs.sm,
                  icon: Icons.download,
                  color: disabledColor,
                  onPressed: () => _exportData(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _changeLocation() {
    ss("Changing market analysis location");
  }

  void _refreshData() {
    ss("Refreshing market analysis data");
  }

  void _viewDetailedReport() {
    ss("Opening detailed market report");
  }

  void _exportData() {
    ss("Exporting market analysis data");
  }
}
