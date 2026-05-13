import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWallet5View extends StatefulWidget {
  @override
  State<GrlWallet5View> createState() => _GrlWallet5ViewState();
}

class _GrlWallet5ViewState extends State<GrlWallet5View> {
  List<Map<String, dynamic>> investments = [
    {
      "symbol": "AAPL",
      "name": "Apple Inc.",
      "shares": 25.0,
      "currentPrice": 180.50,
      "purchasePrice": 165.00,
      "change": 15.50,
      "changePercent": 9.39,
      "totalValue": 4512.50,
      "gainLoss": 387.50,
      "color": Colors.blue
    },
    {
      "symbol": "GOOGL",
      "name": "Alphabet Inc.",
      "shares": 8.0,
      "currentPrice": 2750.00,
      "purchasePrice": 2650.00,
      "change": 100.00,
      "changePercent": 3.77,
      "totalValue": 22000.00,
      "gainLoss": 800.00,
      "color": Colors.red
    },
    {
      "symbol": "TSLA",
      "name": "Tesla Inc.",
      "shares": 12.0,
      "currentPrice": 220.80,
      "purchasePrice": 245.00,
      "change": -24.20,
      "changePercent": -9.88,
      "totalValue": 2649.60,
      "gainLoss": -290.40,
      "color": Colors.green
    },
    {
      "symbol": "MSFT",
      "name": "Microsoft Corp.",
      "shares": 18.0,
      "currentPrice": 415.20,
      "purchasePrice": 390.00,
      "change": 25.20,
      "changePercent": 6.46,
      "totalValue": 7473.60,
      "gainLoss": 453.60,
      "color": Colors.orange
    },
    {
      "symbol": "AMZN",
      "name": "Amazon.com Inc.",
      "shares": 15.0,
      "currentPrice": 145.75,
      "purchasePrice": 155.00,
      "change": -9.25,
      "changePercent": -5.97,
      "totalValue": 2186.25,
      "gainLoss": -138.75,
      "color": Colors.purple
    }
  ];

  String selectedTimeframe = "1D";
  List<String> timeframes = ["1D", "1W", "1M", "3M", "1Y", "ALL"];

  double get totalPortfolioValue {
    return investments.fold(0.0, (sum, investment) => sum + (investment["totalValue"] as double));
  }

  double get totalGainLoss {
    return investments.fold(0.0, (sum, investment) => sum + (investment["gainLoss"] as double));
  }

  double get totalGainLossPercent {
    double totalCost = investments.fold(0.0, (sum, investment) {
      return sum + ((investment["shares"] as double) * (investment["purchasePrice"] as double));
    });
    return totalCost > 0 ? (totalGainLoss / totalCost) * 100 : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Investment Portfolio"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Portfolio Summary
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Text(
                    "Total Portfolio Value",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "\$${totalPortfolioValue.currency}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        totalGainLoss >= 0 ? Icons.trending_up : Icons.trending_down,
                        color: totalGainLoss >= 0 ? Colors.green : Colors.red,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${totalGainLoss >= 0 ? '+' : ''}\$${totalGainLoss.abs().currency} (${totalGainLossPercent >= 0 ? '+' : ''}${totalGainLossPercent.toStringAsFixed(2)}%)",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Timeframe Selector
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: timeframes.map((timeframe) {
                  bool isSelected = selectedTimeframe == timeframe;
                  return GestureDetector(
                    onTap: () {
                      selectedTimeframe = timeframe;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        timeframe,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Buy Stocks",
                    icon: Icons.add,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Sell Stocks",
                    icon: Icons.remove,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
              ],
            ),

            // Holdings List
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My Holdings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: investments.length,
                    itemBuilder: (context, index) {
                      final investment = investments[index];
                      return _buildInvestmentItem(investment);
                    },
                  ),
                ],
              ),
            ),

            // Market Insights
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Market Insights",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  _buildInsightItem(
                    "Best Performer",
                    "AAPL",
                    "+${((investments[0]["changePercent"] as double)).toStringAsFixed(2)}%",
                    Icons.trending_up,
                    successColor,
                  ),
                  _buildInsightItem(
                    "Worst Performer",
                    "TSLA",
                    "${((investments[2]["changePercent"] as double)).toStringAsFixed(2)}%",
                    Icons.trending_down,
                    dangerColor,
                  ),
                  _buildInsightItem(
                    "Total Positions",
                    "${investments.length} stocks",
                    "Diversified portfolio",
                    Icons.pie_chart,
                    infoColor,
                  ),
                  _buildInsightItem(
                    "Portfolio Health",
                    "Good",
                    "3 gainers, 2 losers",
                    Icons.health_and_safety,
                    successColor,
                  ),
                ],
              ),
            ),

            // Performance Chart Placeholder
            Container(
              height: 200,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Portfolio Performance",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.show_chart,
                            size: 60,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Chart visualization would appear here",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInvestmentItem(Map<String, dynamic> investment) {
    double gainLoss = investment["gainLoss"] as double;
    double changePercent = investment["changePercent"] as double;
    bool isGain = gainLoss >= 0;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: (investment["color"] as Color).withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: (investment["color"] as Color).withAlpha(100)),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: investment["color"] as Color,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Text(
                "${investment["symbol"]}".substring(0, 2),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
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
                  "${investment["symbol"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${investment["name"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "${(investment["shares"] as double).toStringAsFixed(1)} shares",
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
                "\$${(investment["totalValue"] as double).currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${isGain ? '+' : ''}\$${gainLoss.abs().currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isGain ? successColor : dangerColor,
                ),
              ),
              Text(
                "${changePercent >= 0 ? '+' : ''}${changePercent.toStringAsFixed(2)}%",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isGain ? successColor : dangerColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(String title, String subtitle, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      child: Row(
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: color.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 18,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
