import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWallet8View extends StatefulWidget {
  @override
  State<GrlWallet8View> createState() => _GrlWallet8ViewState();
}

class _GrlWallet8ViewState extends State<GrlWallet8View> {
  List<Map<String, dynamic>> cryptoAssets = [
    {
      "symbol": "BTC",
      "name": "Bitcoin",
      "balance": 0.2568,
      "currentPrice": 45850.0,
      "change24h": 1250.0,
      "changePercent": 2.8,
      "totalValue": 11774.088,
      "icon": "₿",
      "color": Colors.orange
    },
    {
      "symbol": "ETH",
      "name": "Ethereum",
      "balance": 3.4521,
      "currentPrice": 3150.0,
      "change24h": -85.0,
      "changePercent": -2.6,
      "totalValue": 10874.115,
      "icon": "Ξ",
      "color": Colors.blue
    },
    {
      "symbol": "BNB",
      "name": "Binance Coin",
      "balance": 12.75,
      "currentPrice": 420.0,
      "change24h": 15.0,
      "changePercent": 3.7,
      "totalValue": 5355.0,
      "icon": "B",
      "color": Colors.yellow
    },
    {
      "symbol": "ADA",
      "name": "Cardano",
      "balance": 1250.0,
      "currentPrice": 0.65,
      "change24h": 0.03,
      "changePercent": 4.8,
      "totalValue": 812.5,
      "icon": "₳",
      "color": Colors.blue
    },
    {
      "symbol": "SOL",
      "name": "Solana",
      "balance": 25.8,
      "currentPrice": 125.0,
      "change24h": -8.5,
      "changePercent": -6.4,
      "totalValue": 3225.0,
      "icon": "◎",
      "color": Colors.purple
    },
    {
      "symbol": "DOT",
      "name": "Polkadot",
      "balance": 85.5,
      "currentPrice": 18.5,
      "change24h": 0.8,
      "changePercent": 4.5,
      "totalValue": 1581.75,
      "icon": "●",
      "color": Colors.pink
    }
  ];

  String selectedTimeframe = "24H";
  List<String> timeframes = ["1H", "24H", "7D", "30D", "1Y"];

  double get totalPortfolioValue {
    return cryptoAssets.fold(0.0, (sum, asset) => sum + (asset["totalValue"] as double));
  }

  double get total24hChange {
    return cryptoAssets.fold(0.0, (sum, asset) {
      double balance = asset["balance"] as double;
      double change = asset["change24h"] as double;
      return sum + (balance * change);
    });
  }

  double get total24hChangePercent {
    double totalYesterday = totalPortfolioValue - total24hChange;
    return totalYesterday > 0 ? (total24hChange / totalYesterday) * 100 : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crypto Wallet"),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
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
                        total24hChange >= 0 ? Icons.trending_up : Icons.trending_down,
                        color: total24hChange >= 0 ? Colors.green : Colors.red,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${total24hChange >= 0 ? '+' : ''}\$${total24hChange.abs().currency} (${total24hChangePercent >= 0 ? '+' : ''}${total24hChangePercent.toStringAsFixed(2)}%)",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "24h Change",
                    style: TextStyle(
                      color: Colors.white.withAlpha(180),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
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
                    label: "Buy Crypto",
                    icon: Icons.add,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Sell Crypto",
                    icon: Icons.remove,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Swap",
                    icon: Icons.swap_horiz,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
              ],
            ),

            // Assets List
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
                    "My Assets",
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
                    itemCount: cryptoAssets.length,
                    itemBuilder: (context, index) {
                      final asset = cryptoAssets[index];
                      return _buildAssetItem(asset);
                    },
                  ),
                ],
              ),
            ),

            // Market Trends
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
                    "Market Trends",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  _buildTrendItem(
                    "Top Gainer",
                    "ADA",
                    "+4.8%",
                    Icons.trending_up,
                    successColor,
                  ),
                  _buildTrendItem(
                    "Top Loser",
                    "SOL",
                    "-6.4%",
                    Icons.trending_down,
                    dangerColor,
                  ),
                  _buildTrendItem(
                    "Most Volatile",
                    "BTC",
                    "±2.8%",
                    Icons.show_chart,
                    warningColor,
                  ),
                  _buildTrendItem(
                    "Market Cap",
                    "\$2.1T",
                    "Global crypto market",
                    Icons.public,
                    infoColor,
                  ),
                ],
              ),
            ),

            // Portfolio Allocation
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
                    "Portfolio Allocation",
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
                    itemCount: cryptoAssets.length,
                    itemBuilder: (context, index) {
                      final asset = cryptoAssets[index];
                      double percentage = (asset["totalValue"] as double) / totalPortfolioValue * 100;
                      return _buildAllocationItem(asset, percentage);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssetItem(Map<String, dynamic> asset) {
    double change = asset["change24h"] as double;
    double changePercent = asset["changePercent"] as double;
    bool isPositive = change >= 0;
    Color assetColor = asset["color"] as Color;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: assetColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: assetColor.withAlpha(100)),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: assetColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Text(
                "${asset["icon"]}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
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
                  "${asset["symbol"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${asset["name"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${(asset["balance"] as double).toStringAsFixed(4)} ${asset["symbol"]}",
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
                "\$${(asset["totalValue"] as double).currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "\$${(asset["currentPrice"] as double).currency}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "${isPositive ? '+' : ''}${changePercent.toStringAsFixed(2)}%",
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
    );
  }

  Widget _buildTrendItem(String title, String subtitle, String value, IconData icon, Color color) {
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

  Widget _buildAllocationItem(Map<String, dynamic> asset, double percentage) {
    Color assetColor = asset["color"] as Color;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: assetColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Center(
                  child: Text(
                    "${asset["icon"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${asset["symbol"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "${percentage.toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: assetColor,
                ),
              ),
            ],
          ),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: assetColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (percentage / 100).clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: assetColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
