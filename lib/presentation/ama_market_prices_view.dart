import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaMarketPricesView extends StatefulWidget {
  const AmaMarketPricesView({super.key});

  @override
  State<AmaMarketPricesView> createState() => _AmaMarketPricesViewState();
}

class _AmaMarketPricesViewState extends State<AmaMarketPricesView> {
  String selectedRegion = "All Regions";
  String selectedCommodity = "All Commodities";
  String selectedTimeframe = "Today";

  List<Map<String, dynamic>> marketPrices = [
    {
      "commodity": "Rice",
      "currentPrice": 12500,
      "previousPrice": 12000,
      "change": 500,
      "changePercent": 4.17,
      "market": "Central Market",
      "region": "Jakarta",
      "quality": "Premium",
      "unit": "kg",
      "lastUpdate": "2024-01-15 14:30",
      "volume": "850 tons",
      "icon": Icons.rice_bowl,
    },
    {
      "commodity": "Corn",
      "currentPrice": 8500,
      "previousPrice": 8800,
      "change": -300,
      "changePercent": -3.41,
      "market": "Wholesale Market",
      "region": "Surabaya",
      "quality": "Grade A",
      "unit": "kg",
      "lastUpdate": "2024-01-15 14:15",
      "volume": "1200 tons",
      "icon": Icons.grass,
    },
    {
      "commodity": "Soybeans",
      "currentPrice": 15000,
      "previousPrice": 14500,
      "change": 500,
      "changePercent": 3.45,
      "market": "Agricultural Center",
      "region": "Medan",
      "quality": "Grade A",
      "unit": "kg",
      "lastUpdate": "2024-01-15 13:45",
      "volume": "600 tons",
      "icon": Icons.eco,
    },
    {
      "commodity": "Coffee",
      "currentPrice": 35000,
      "previousPrice": 34000,
      "change": 1000,
      "changePercent": 2.94,
      "market": "Export Hub",
      "region": "Bandung",
      "quality": "Arabica",
      "unit": "kg",
      "lastUpdate": "2024-01-15 13:30",
      "volume": "300 tons",
      "icon": Icons.coffee,
    },
    {
      "commodity": "Sugar",
      "currentPrice": 14000,
      "previousPrice": 14200,
      "change": -200,
      "changePercent": -1.41,
      "market": "Central Market",
      "region": "Jakarta",
      "quality": "Refined",
      "unit": "kg",
      "lastUpdate": "2024-01-15 14:00",
      "volume": "750 tons",
      "icon": Icons.grain,
    },
    {
      "commodity": "Palm Oil",
      "currentPrice": 11500,
      "previousPrice": 11800,
      "change": -300,
      "changePercent": -2.54,
      "market": "Industrial Market",
      "region": "Riau",
      "quality": "Crude",
      "unit": "kg",
      "lastUpdate": "2024-01-15 12:45",
      "volume": "2000 tons",
      "icon": Icons.oil_barrel,
    },
  ];

  List<Map<String, dynamic>> priceAlerts = [
    {
      "commodity": "Rice",
      "alertType": "Price Surge",
      "currentPrice": 12500,
      "threshold": 12000,
      "change": 4.17,
      "priority": "High",
      "region": "Jakarta",
      "timestamp": "2024-01-15 14:30",
    },
    {
      "commodity": "Corn",
      "alertType": "Price Drop",
      "currentPrice": 8500,
      "threshold": 9000,
      "change": -3.41,
      "priority": "Medium",
      "region": "Surabaya",
      "timestamp": "2024-01-15 14:15",
    },
    {
      "commodity": "Coffee",
      "alertType": "Volatile Movement",
      "currentPrice": 35000,
      "threshold": 30000,
      "change": 2.94,
      "priority": "Medium",
      "region": "Bandung",
      "timestamp": "2024-01-15 13:30",
    },
  ];

  List<Map<String, dynamic>> regionItems = [
    {"label": "All Regions", "value": "All Regions"},
    {"label": "Jakarta", "value": "Jakarta"},
    {"label": "Surabaya", "value": "Surabaya"},
    {"label": "Medan", "value": "Medan"},
    {"label": "Bandung", "value": "Bandung"},
    {"label": "Riau", "value": "Riau"},
  ];

  List<Map<String, dynamic>> commodityItems = [
    {"label": "All Commodities", "value": "All Commodities"},
    {"label": "Rice", "value": "Rice"},
    {"label": "Corn", "value": "Corn"},
    {"label": "Soybeans", "value": "Soybeans"},
    {"label": "Coffee", "value": "Coffee"},
    {"label": "Sugar", "value": "Sugar"},
    {"label": "Palm Oil", "value": "Palm Oil"},
  ];

  List<Map<String, dynamic>> timeframeItems = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Market Prices"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Refresh market prices
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Navigate to price alerts
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
            // Market Overview Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildOverviewCard(
                  "Active Markets",
                  "24",
                  Icons.store,
                  primaryColor,
                  "8 regions",
                ),
                _buildOverviewCard(
                  "Commodities",
                  "156",
                  Icons.inventory,
                  successColor,
                  "6 categories",
                ),
                _buildOverviewCard(
                  "Price Updates",
                  "342",
                  Icons.update,
                  infoColor,
                  "Last hour",
                ),
                _buildOverviewCard(
                  "Market Value",
                  "\$2.4M",
                  Icons.attach_money,
                  warningColor,
                  "Daily volume",
                ),
              ],
            ),

            // Filter Section
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
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
                  label: "Commodity",
                  items: commodityItems,
                  value: selectedCommodity,
                  onChanged: (value, label) {
                    selectedCommodity = value;
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
              ],
            ),

            // Price Alerts
            if (priceAlerts.isNotEmpty) ...[
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
                          "Price Alerts",
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
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${priceAlerts.length}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: warningColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    ...priceAlerts.map((alert) {
                      Color alertColor = alert["alertType"] == "Price Surge" 
                        ? successColor
                        : alert["alertType"] == "Price Drop"
                        ? dangerColor
                        : warningColor;
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spXs),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: alertColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 3,
                              color: alertColor,
                            ),
                          ),
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
                                        "${alert["commodity"]} - ${alert["alertType"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${(alert["change"] as num) >= 0 ? '+' : ''}${(alert["change"] as num).toStringAsFixed(1)}%",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: alertColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Rp ${((alert["currentPrice"] as int).toDouble()).currency} • ${alert["region"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${alert["timestamp"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledColor,
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
            ],

            // Market Prices List
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
                        "Live Market Prices",
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
                        "Live",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...marketPrices.map((price) {
                    bool isPositive = (price["change"] as num) >= 0;
                    Color changeColor = isPositive ? successColor : dangerColor;
                    
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
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              price["icon"] as IconData,
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
                                      "${price["commodity"]}",
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
                                        "${price["quality"]}",
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
                                        color: changeColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                                            color: changeColor,
                                            size: 10,
                                          ),
                                          Text(
                                            "${(price["changePercent"] as num).abs().toStringAsFixed(1)}%",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: changeColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${price["market"]} • ${price["region"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Text(
                                      "Rp ${((price["currentPrice"] as int).toDouble()).currency}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "/${price["unit"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${price["volume"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: infoColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Prev: Rp ${((price["previousPrice"] as int).toDouble()).currency}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${price["lastUpdate"]}",
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

            // Quick Actions
            Container(
              width: double.infinity,
              child: QButton(
                label: "Set Price Alert",
                icon: Icons.add_alert,
                onPressed: () {
                  // Navigate to create price alert
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color, String subtitle) {
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
}
