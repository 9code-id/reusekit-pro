import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaSellingPlatformView extends StatefulWidget {
  const AmaSellingPlatformView({super.key});

  @override
  State<AmaSellingPlatformView> createState() => _AmaSellingPlatformViewState();
}

class _AmaSellingPlatformViewState extends State<AmaSellingPlatformView> {
  String selectedPlatform = "All Platforms";
  String selectedStatus = "All Status";
  String selectedCommodity = "All Commodities";

  List<Map<String, dynamic>> sellingPlatforms = [
    {
      "platform": "AgriMarket Online",
      "type": "Digital Marketplace",
      "commission": 3.5,
      "reach": "National",
      "activeBuyers": 2500,
      "averagePrice": 12500,
      "paymentTerms": "T+7",
      "status": "Active",
      "rating": 4.8,
      "icon": Icons.shopping_cart,
      "features": ["Real-time pricing", "Quality verification", "Logistics support"],
      "supportedCommodities": ["Rice", "Corn", "Soybeans"],
    },
    {
      "platform": "Local Wholesale Market",
      "type": "Traditional Market",
      "commission": 2.0,
      "reach": "Regional",
      "activeBuyers": 850,
      "averagePrice": 12200,
      "paymentTerms": "Cash",
      "status": "Active",
      "rating": 4.2,
      "icon": Icons.store,
      "features": ["Direct negotiation", "Physical inspection", "Immediate payment"],
      "supportedCommodities": ["Rice", "Corn", "Sugar"],
    },
    {
      "platform": "Export Trading Hub",
      "type": "International Trade",
      "commission": 5.0,
      "reach": "International",
      "activeBuyers": 120,
      "averagePrice": 15800,
      "paymentTerms": "LC",
      "status": "Active",
      "rating": 4.9,
      "icon": Icons.flight_takeoff,
      "features": ["Export certification", "Currency hedging", "International logistics"],
      "supportedCommodities": ["Coffee", "Palm Oil", "Cocoa"],
    },
    {
      "platform": "Commodity Exchange",
      "type": "Futures Market",
      "commission": 1.5,
      "reach": "National",
      "activeBuyers": 450,
      "averagePrice": 12800,
      "paymentTerms": "T+2",
      "status": "Active",
      "rating": 4.6,
      "icon": Icons.trending_up,
      "features": ["Price discovery", "Risk management", "Standardized contracts"],
      "supportedCommodities": ["Rice", "Corn", "Soybeans", "Sugar"],
    },
    {
      "platform": "Farm Direct Co-op",
      "type": "Cooperative",
      "commission": 1.0,
      "reach": "Local",
      "activeBuyers": 180,
      "averagePrice": 11900,
      "paymentTerms": "T+14",
      "status": "Limited",
      "rating": 4.1,
      "icon": Icons.agriculture,
      "features": ["Farmer ownership", "Shared logistics", "Bulk purchasing"],
      "supportedCommodities": ["Rice", "Corn"],
    },
    {
      "platform": "AgriTech Solutions",
      "type": "Technology Platform",
      "commission": 4.0,
      "reach": "National",
      "activeBuyers": 1200,
      "averagePrice": 13200,
      "paymentTerms": "T+5",
      "status": "Beta",
      "rating": 4.5,
      "icon": Icons.smartphone,
      "features": ["AI pricing", "Smart contracts", "Supply chain tracking"],
      "supportedCommodities": ["Rice", "Corn", "Coffee", "Soybeans"],
    },
  ];

  List<Map<String, dynamic>> platformPerformance = [
    {
      "platform": "AgriMarket Online",
      "volume": 4500,
      "revenue": 562500000,
      "orders": 128,
      "avgOrderSize": 35.2,
      "customerSatisfaction": 4.8,
      "growth": 12.5,
    },
    {
      "platform": "Local Wholesale Market",
      "volume": 2800,
      "revenue": 341600000,
      "orders": 89,
      "avgOrderSize": 31.5,
      "customerSatisfaction": 4.2,
      "growth": 5.3,
    },
    {
      "platform": "Export Trading Hub",
      "volume": 1200,
      "revenue": 189600000,
      "orders": 24,
      "avgOrderSize": 50.0,
      "customerSatisfaction": 4.9,
      "growth": 18.7,
    },
    {
      "platform": "Commodity Exchange",
      "volume": 3200,
      "revenue": 409600000,
      "orders": 76,
      "avgOrderSize": 42.1,
      "customerSatisfaction": 4.6,
      "growth": 8.9,
    },
  ];

  List<Map<String, dynamic>> marketInsights = [
    {
      "insight": "Digital platforms showing 45% higher engagement",
      "category": "Platform Trend",
      "impact": "High",
      "recommendation": "Increase digital platform focus",
      "icon": Icons.trending_up,
      "color": successColor,
    },
    {
      "insight": "Export platforms offer 25% price premium",
      "category": "Pricing Analysis",
      "impact": "High",
      "recommendation": "Expand international market presence",
      "icon": Icons.attach_money,
      "color": successColor,
    },
    {
      "insight": "Cooperative platforms have lower commission rates",
      "category": "Cost Analysis",
      "impact": "Medium",
      "recommendation": "Consider cooperative partnerships",
      "icon": Icons.savings,
      "color": infoColor,
    },
    {
      "insight": "Technology platforms show fastest growth",
      "category": "Growth Analysis",
      "impact": "High",
      "recommendation": "Invest in technology adoption",
      "icon": Icons.rocket_launch,
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> platformItems = [
    {"label": "All Platforms", "value": "All Platforms"},
    {"label": "Digital Marketplace", "value": "Digital Marketplace"},
    {"label": "Traditional Market", "value": "Traditional Market"},
    {"label": "International Trade", "value": "International Trade"},
    {"label": "Futures Market", "value": "Futures Market"},
    {"label": "Cooperative", "value": "Cooperative"},
    {"label": "Technology Platform", "value": "Technology Platform"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "All Status"},
    {"label": "Active", "value": "Active"},
    {"label": "Limited", "value": "Limited"},
    {"label": "Beta", "value": "Beta"},
  ];

  List<Map<String, dynamic>> commodityItems = [
    {"label": "All Commodities", "value": "All Commodities"},
    {"label": "Rice", "value": "Rice"},
    {"label": "Corn", "value": "Corn"},
    {"label": "Soybeans", "value": "Soybeans"},
    {"label": "Coffee", "value": "Coffee"},
    {"label": "Sugar", "value": "Sugar"},
    {"label": "Palm Oil", "value": "Palm Oil"},
    {"label": "Cocoa", "value": "Cocoa"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selling Platforms"),
        actions: [
          IconButton(
            icon: Icon(Icons.compare),
            onPressed: () {
              // Navigate to platform comparison
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add new platform
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
            // Platform Overview Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildOverviewCard(
                  "Active Platforms",
                  "${sellingPlatforms.where((p) => p["status"] == "Active").length}",
                  Icons.storefront,
                  primaryColor,
                  "Available for selling",
                ),
                _buildOverviewCard(
                  "Total Buyers",
                  "${sellingPlatforms.map((p) => p["activeBuyers"] as int).reduce((a, b) => a + b)}",
                  Icons.people,
                  successColor,
                  "Across all platforms",
                ),
                _buildOverviewCard(
                  "Avg Commission",
                  "${(sellingPlatforms.map((p) => p["commission"] as num).reduce((a, b) => a + b) / sellingPlatforms.length).toStringAsFixed(1)}%",
                  Icons.percent,
                  warningColor,
                  "Platform fees",
                ),
                _buildOverviewCard(
                  "Best Price",
                  "Rp ${sellingPlatforms.map((p) => p["averagePrice"] as int).reduce((a, b) => a > b ? a : b)}",
                  Icons.trending_up,
                  successColor,
                  "Highest offer",
                ),
              ],
            ),

            // Filter Section
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                QDropdownField(
                  label: "Platform Type",
                  items: platformItems,
                  value: selectedPlatform,
                  onChanged: (value, label) {
                    selectedPlatform = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Status",
                  items: statusItems,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
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
                        "Platform Insights",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
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
                      child: Row(
                        children: [
                          Icon(
                            insight["icon"] as IconData,
                            color: insight["color"] as Color,
                            size: 18,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${insight["category"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: insight["color"] as Color,
                                      ),
                                    ),
                                    Spacer(),
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
                                Text(
                                  "${insight["insight"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${insight["recommendation"]}",
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

            // Platform Performance
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
                        "Platform Performance",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...platformPerformance.map((performance) {
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${performance["platform"]}",
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
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.arrow_upward,
                                      color: successColor,
                                      size: 10,
                                    ),
                                    Text(
                                      "+${(performance["growth"] as num).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: successColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          ResponsiveGridView(
                            padding: EdgeInsets.zero,
                            minItemWidth: 200,
                            children: [
                              _buildPerformanceMetric(
                                "Volume",
                                "${(performance["volume"] as int)} tons",
                                Icons.inventory_2,
                              ),
                              _buildPerformanceMetric(
                                "Revenue",
                                "Rp ${((performance["revenue"] as int).toDouble()).currency}",
                                Icons.attach_money,
                              ),
                              _buildPerformanceMetric(
                                "Orders",
                                "${performance["orders"]}",
                                Icons.receipt,
                              ),
                              _buildPerformanceMetric(
                                "Avg Order",
                                "${(performance["avgOrderSize"] as num).toStringAsFixed(1)} tons",
                                Icons.shopping_cart,
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: warningColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${(performance["customerSatisfaction"] as num).toStringAsFixed(1)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                " Customer Satisfaction",
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
                  }),
                ],
              ),
            ),

            // Platform List
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
                        Icons.storefront,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Available Platforms",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...sellingPlatforms.map((platform) {
                    Color statusColor = platform["status"] == "Active" 
                      ? successColor
                      : platform["status"] == "Beta"
                      ? infoColor
                      : warningColor;
                    
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
                                  platform["icon"] as IconData,
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
                                          "${platform["platform"]}",
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
                                            color: statusColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${platform["status"]}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: statusColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${platform["type"]} • ${platform["reach"]}",
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
                                      "Commission",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
                                    ),
                                    Text(
                                      "${(platform["commission"] as num).toStringAsFixed(1)}%",
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
                                      "Avg Price",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
                                    ),
                                    Text(
                                      "Rp ${((platform["averagePrice"] as int).toDouble()).currency}",
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
                                      "Buyers",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
                                    ),
                                    Text(
                                      "${platform["activeBuyers"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
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
                              Icon(
                                Icons.star,
                                color: warningColor,
                                size: 14,
                              ),
                              SizedBox(width: 2),
                              Text(
                                "${(platform["rating"] as num).toStringAsFixed(1)}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "•",
                                style: TextStyle(color: disabledColor),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Payment: ${platform["paymentTerms"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
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
                                  "Key Features:",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
                                  ),
                                ),
                                Text(
                                  "${(platform["features"] as List).join(" • ")}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Text(
                                "Commodities: ${(platform["supportedCommodities"] as List).join(", ")}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to platform details
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                label: "Sell Here",
                                size: bs.sm,
                                onPressed: () {
                                  // Navigate to sell on platform
                                },
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

  Widget _buildPerformanceMetric(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 14,
          ),
          SizedBox(width: spXs),
          Expanded(
            child: Column(
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
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
