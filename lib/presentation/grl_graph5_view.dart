import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlGraph5View extends StatefulWidget {
  @override
  State<GrlGraph5View> createState() => _GrlGraph5ViewState();
}

class _GrlGraph5ViewState extends State<GrlGraph5View> {
  List<Map<String, dynamic>> stockData = [
    {"symbol": "AAPL", "price": 175.23, "change": 2.45, "changePercent": 1.42, "volume": "52.3M"},
    {"symbol": "GOOGL", "price": 2834.56, "change": -15.23, "changePercent": -0.53, "volume": "28.7M"},
    {"symbol": "MSFT", "price": 398.12, "change": 5.67, "changePercent": 1.45, "volume": "35.8M"},
    {"symbol": "TSLA", "price": 245.78, "change": -8.34, "changePercent": -3.28, "volume": "89.2M"},
    {"symbol": "AMZN", "price": 3256.89, "change": 45.23, "changePercent": 1.41, "volume": "41.6M"},
  ];

  List<Map<String, dynamic>> portfolioData = [
    {"name": "Technology", "value": 125000, "allocation": 42, "color": primaryColor},
    {"name": "Healthcare", "value": 85000, "allocation": 28, "color": successColor},
    {"name": "Finance", "value": 60000, "allocation": 20, "color": warningColor},
    {"name": "Energy", "value": 30000, "allocation": 10, "color": infoColor},
  ];

  List<Map<String, dynamic>> marketTrends = [
    {"period": "1D", "spy": 0.8, "nasdaq": 1.2, "dow": 0.5},
    {"period": "1W", "spy": 2.1, "nasdaq": 3.4, "dow": 1.8},
    {"period": "1M", "spy": 5.6, "nasdaq": 7.2, "dow": 4.3},
    {"period": "3M", "spy": 12.4, "nasdaq": 15.8, "dow": 9.7},
    {"period": "YTD", "spy": 18.3, "nasdaq": 22.6, "dow": 15.1},
  ];

  int selectedPeriod = 2;
  bool showPortfolioDetails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Market Analytics"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Show market alerts
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Open settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildPortfolioSummary(),
            _buildMarketIndexes(),
            _buildStockWatchlist(),
            _buildPortfolioAllocation(),
            _buildMarketTrends(),
            _buildTradingActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildPortfolioSummary() {
    double totalValue = portfolioData.map((item) => item["value"] as int).reduce((a, b) => a + b).toDouble();
    double dayChange = 2840.50;
    double dayChangePercent = 0.95;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.account_balance_wallet,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Portfolio Value",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withAlpha(230),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  showPortfolioDetails = !showPortfolioDetails;
                  setState(() {});
                },
                child: Icon(
                  showPortfolioDetails ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white.withAlpha(230),
                  size: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${(totalValue / 1000).toStringAsFixed(0)}K",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                decoration: BoxDecoration(
                  color: dayChangePercent >= 0 ? successColor : dangerColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${dayChangePercent >= 0 ? '+' : ''}${dayChangePercent.toStringAsFixed(2)}%",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Text(
                "${dayChange >= 0 ? '+' : ''}\$${dayChange.toStringAsFixed(2)} today",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withAlpha(230),
                ),
              ),
            ],
          ),
          if (showPortfolioDetails) ...[
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: _buildPortfolioMetric("Invested", "\$285K", Icons.trending_up),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildPortfolioMetric("Gains", "\$15K", Icons.show_chart),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPortfolioMetric(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
          SizedBox(width: spXs),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withAlpha(200),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMarketIndexes() {
    List<Map<String, dynamic>> indexes = [
      {"name": "S&P 500", "value": 4567.89, "change": 1.23, "changePercent": 0.85},
      {"name": "NASDAQ", "value": 14250.12, "change": -23.45, "changePercent": -0.16},
      {"name": "DOW", "value": 34890.45, "change": 156.78, "changePercent": 0.45},
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
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
              SizedBox(width: spSm),
              Text(
                "Market Indexes",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: indexes.map((index) {
              bool isPositive = (index["change"] as double) >= 0;
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isPositive ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isPositive ? successColor.withAlpha(50) : dangerColor.withAlpha(50),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${index["name"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${(index["value"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${isPositive ? '+' : ''}${(index["changePercent"] as double).toStringAsFixed(2)}%",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isPositive ? successColor : dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStockWatchlist() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.list_alt,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Watchlist",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  // Add to watchlist
                },
                child: Icon(
                  Icons.add,
                  color: primaryColor,
                  size: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            children: stockData.map((stock) {
              bool isPositive = (stock["change"] as double) >= 0;
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Center(
                        child: Text(
                          "${stock["symbol"]}".substring(0, 2),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${stock["symbol"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Vol: ${stock["volume"]}",
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
                        Text(
                          "\$${(stock["price"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                              color: isPositive ? successColor : dangerColor,
                              size: 12,
                            ),
                            Text(
                              "${(stock["changePercent"] as double).toStringAsFixed(2)}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isPositive ? successColor : dangerColor,
                              ),
                            ),
                          ],
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

  Widget _buildPortfolioAllocation() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.pie_chart,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Portfolio Allocation",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            children: portfolioData.map((sector) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: sector["color"] as Color,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${sector["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "\$${((sector["value"] as int) / 1000).toStringAsFixed(0)}K",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${sector["allocation"]}%",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: sector["color"] as Color,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: (sector["allocation"] as int) / 100,
                        child: Container(
                          decoration: BoxDecoration(
                            color: sector["color"] as Color,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                      ),
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

  Widget _buildMarketTrends() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
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
              SizedBox(width: spSm),
              Text(
                "Market Trends",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            height: 200,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(width: 60),
                    Expanded(
                      child: Row(
                        children: [
                          _buildLegendItem("S&P 500", primaryColor),
                          SizedBox(width: spSm),
                          _buildLegendItem("NASDAQ", successColor),
                          SizedBox(width: spSm),
                          _buildLegendItem("DOW", warningColor),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: marketTrends.map((trend) {
                      double spyHeight = ((trend["spy"] as double) / 25) * 140;
                      double nasdaqHeight = ((trend["nasdaq"] as double) / 25) * 140;
                      double dowHeight = ((trend["dow"] as double) / 25) * 140;
                      
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: spyHeight,
                                      decoration: BoxDecoration(
                                        color: primaryColor.withAlpha(200),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 1),
                                  Expanded(
                                    child: Container(
                                      height: nasdaqHeight,
                                      decoration: BoxDecoration(
                                        color: successColor.withAlpha(200),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 1),
                                  Expanded(
                                    child: Container(
                                      height: dowHeight,
                                      decoration: BoxDecoration(
                                        color: warningColor.withAlpha(200),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${trend["period"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
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
        SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTradingActions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.bolt,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Buy Order",
                  icon: Icons.add_shopping_cart,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Sell Order",
                  icon: Icons.sell,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Market Analysis",
                  icon: Icons.analytics,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "News & Alerts",
                  icon: Icons.notifications_active,
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
