import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaMarketTrendsView extends StatefulWidget {
  const RmaMarketTrendsView({super.key});

  @override
  State<RmaMarketTrendsView> createState() => _RmaMarketTrendsViewState();
}

class _RmaMarketTrendsViewState extends State<RmaMarketTrendsView> {
  String selectedMarket = "All Markets";
  String selectedTimeframe = "12months";
  int currentTab = 0;

  List<Map<String, dynamic>> marketOptions = [
    {"label": "All Markets", "value": "all"},
    {"label": "Downtown", "value": "downtown"},
    {"label": "Suburban", "value": "suburban"},
    {"label": "Waterfront", "value": "waterfront"},
  ];

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "6 Months", "value": "6months"},
    {"label": "12 Months", "value": "12months"},
    {"label": "2 Years", "value": "2years"},
    {"label": "5 Years", "value": "5years"},
  ];

  List<Map<String, dynamic>> marketData = [
    {
      "area": "Downtown",
      "avg_price": 675000,
      "price_change": 8.5,
      "inventory": 145,
      "days_on_market": 28,
      "sold_units": 89,
      "trend": "up"
    },
    {
      "area": "Suburban",
      "avg_price": 485000,
      "price_change": 12.3,
      "inventory": 312,
      "days_on_market": 35,
      "sold_units": 156,
      "trend": "up"
    },
    {
      "area": "Waterfront",
      "avg_price": 925000,
      "price_change": -2.1,
      "inventory": 87,
      "days_on_market": 52,
      "sold_units": 34,
      "trend": "down"
    },
    {
      "area": "Industrial",
      "avg_price": 320000,
      "price_change": 15.7,
      "inventory": 67,
      "days_on_market": 21,
      "sold_units": 45,
      "trend": "up"
    },
  ];

  List<Map<String, dynamic>> priceHistory = [
    {"month": "Jan", "price": 550000, "volume": 234},
    {"month": "Feb", "price": 565000, "volume": 267},
    {"month": "Mar", "price": 578000, "volume": 289},
    {"month": "Apr", "price": 592000, "volume": 312},
    {"month": "May", "price": 605000, "volume": 298},
    {"month": "Jun", "price": 618000, "volume": 276},
  ];

  List<Map<String, dynamic>> marketIndicators = [
    {"name": "Absorption Rate", "value": 68.5, "change": 3.2, "unit": "%"},
    {"name": "Price per Sq Ft", "value": 385, "change": 7.8, "unit": "\$"},
    {"name": "Inventory Turnover", "value": 4.2, "change": -1.5, "unit": "months"},
    {"name": "Market Velocity", "value": 1.8, "change": 12.4, "unit": "ratio"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Market Trends",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.trending_up)),
        Tab(text: "Areas", icon: Icon(Icons.location_city)),
        Tab(text: "Analysis", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildAreasTab(),
        _buildAnalysisTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildFilters(),
          _buildMarketSummary(),
          _buildPriceTrendChart(),
          _buildKeyIndicators(),
        ],
      ),
    );
  }

  Widget _buildAreasTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAreaComparison(),
          _buildAreaDetails(),
        ],
      ),
    );
  }

  Widget _buildAnalysisTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildMarketAnalysis(),
          _buildSeasonalTrends(),
          _buildForecastInsights(),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Row(
      spacing: spMd,
      children: [
        Expanded(
          child: QDropdownField(
            label: "Market Area",
            items: marketOptions,
            value: selectedMarket,
            onChanged: (value, label) {
              selectedMarket = value;
              setState(() {});
            },
          ),
        ),
        Expanded(
          child: QDropdownField(
            label: "Timeframe",
            items: timeframeOptions,
            value: selectedTimeframe,
            onChanged: (value, label) {
              selectedTimeframe = value;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMarketSummary() {
    double avgPrice = marketData.fold(0.0, (sum, item) => sum + (item["avg_price"] as int).toDouble()) / marketData.length;
    double avgChange = marketData.fold(0.0, (sum, item) => sum + (item["price_change"] as double)) / marketData.length;
    int totalInventory = marketData.fold(0, (sum, item) => sum + (item["inventory"] as int));
    int totalSold = marketData.fold(0, (sum, item) => sum + (item["sold_units"] as int));

    return ResponsiveGridView(
      minItemWidth: 200,
      children: [
        _buildSummaryCard("Average Price", avgPrice.currency, Icons.home, primaryColor, "+${avgChange.toStringAsFixed(1)}%"),
        _buildSummaryCard("Total Inventory", totalInventory.toString(), Icons.inventory, infoColor, null),
        _buildSummaryCard("Units Sold", totalSold.toString(), Icons.trending_up, successColor, "This month"),
        _buildSummaryCard("Market Health", "Strong", Icons.health_and_safety, warningColor, "Trending up"),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color, String? subtitle) {
    return Container(
      padding: EdgeInsets.all(spLg),
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
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              Spacer(),
              if (subtitle != null)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: color.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 10,
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceTrendChart() {
    return Container(
      padding: EdgeInsets.all(spLg),
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
              Text(
                "Price Trend Analysis",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.fullscreen,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spLg),
          Container(
            height: 240,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.show_chart,
                        size: 56,
                        color: primaryColor.withAlpha(60),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Price Trend Chart",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "6-Month Price Movement",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildChartLegendItem("Average Price", primaryColor),
              _buildChartLegendItem("Volume", successColor),
              _buildChartLegendItem("Trend", warningColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spXs),
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

  Widget _buildKeyIndicators() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Key Market Indicators",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spLg),
          ...marketIndicators.map((indicator) => _buildIndicatorRow(indicator)),
        ],
      ),
    );
  }

  Widget _buildIndicatorRow(Map<String, dynamic> indicator) {
    bool isPositive = (indicator["change"] as double) > 0;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
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
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${(indicator["value"] as num).toStringAsFixed(1)}${indicator["unit"]}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                isPositive ? Icons.trending_up : Icons.trending_down,
                color: isPositive ? successColor : dangerColor,
                size: 20,
              ),
              SizedBox(height: spXs),
              Text(
                "${isPositive ? '+' : ''}${(indicator["change"] as double).toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isPositive ? successColor : dangerColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAreaComparison() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Area Comparison",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spLg),
          ...marketData.map((area) => _buildAreaComparisonRow(area)),
        ],
      ),
    );
  }

  Widget _buildAreaComparisonRow(Map<String, dynamic> area) {
    bool isPositiveTrend = area["trend"] == "up";
    Color trendColor = isPositiveTrend ? successColor : dangerColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: trendColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: trendColor,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${area["area"]}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: trendColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  children: [
                    Icon(
                      isPositiveTrend ? Icons.trending_up : Icons.trending_down,
                      color: trendColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${(area["price_change"] as double) > 0 ? '+' : ''}${(area["price_change"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: trendColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Avg Price",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${((area["avg_price"] as int).toDouble()).currency}",
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
                      "Inventory",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${area["inventory"]} units",
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
                      "DOM",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${area["days_on_market"]} days",
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

  Widget _buildAreaDetails() {
    return Container(
      height: 300,
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Market Map",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spLg),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map,
                    size: 48,
                    color: primaryColor.withAlpha(60),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Interactive Market Map",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketAnalysis() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Market Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spLg),
          _buildAnalysisInsight("Market Strength", "Strong buyer demand with moderate inventory levels", Icons.trending_up, successColor),
          _buildAnalysisInsight("Price Movement", "Steady appreciation across most market segments", Icons.show_chart, primaryColor),
          _buildAnalysisInsight("Supply/Demand", "Balanced market with seasonal variations", Icons.balance, warningColor),
          _buildAnalysisInsight("Investment Climate", "Favorable for both buyers and investors", Icons.attach_money, infoColor),
        ],
      ),
    );
  }

  Widget _buildAnalysisInsight(String title, String insight, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
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
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  insight,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeasonalTrends() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Seasonal Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spLg),
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_month,
                  size: 48,
                  color: primaryColor.withAlpha(60),
                ),
                SizedBox(height: spSm),
                Text(
                  "Seasonal Trends Chart",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForecastInsights() {
    List<Map<String, dynamic>> forecasts = [
      {"period": "Next Quarter", "prediction": "3-5% price increase", "confidence": "High"},
      {"period": "6 Months", "prediction": "Inventory normalization", "confidence": "Medium"},
      {"period": "1 Year", "prediction": "Market stabilization", "confidence": "Medium"},
    ];

    return Container(
      padding: EdgeInsets.all(spLg),
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
          SizedBox(height: spLg),
          ...forecasts.map((forecast) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${forecast["period"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${forecast["prediction"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: forecast["confidence"] == "High" ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${forecast["confidence"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: forecast["confidence"] == "High" ? successColor : warningColor,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
