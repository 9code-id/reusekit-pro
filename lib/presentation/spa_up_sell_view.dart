import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaUpSellView extends StatefulWidget {
  const SpaUpSellView({super.key});

  @override
  State<SpaUpSellView> createState() => _SpaUpSellViewState();
}

class _SpaUpSellViewState extends State<SpaUpSellView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedCategory = "All";
  String tierFilter = "All";
  
  List<String> categories = ["All", "Skincare", "Hair Care", "Aromatherapy", "Equipment", "Accessories"];
  List<String> tierOptions = ["All", "Premium", "Luxury", "Professional", "Basic"];
  
  Map<String, dynamic> selectedProduct = {
    "id": "PROD001",
    "name": "Basic Facial Cleanser",
    "category": "Skincare",
    "price": 24.99,
    "tier": "Basic",
    "image": "https://picsum.photos/200/200?random=1&keyword=cleanser",
    "sales": 234,
    "conversionRate": 8.5
  };
  
  List<Map<String, dynamic>> upSellStrategies = [
    {
      "id": "UPSELL001",
      "baseProduct": {
        "id": "PROD001",
        "name": "Basic Facial Cleanser",
        "price": 24.99,
        "tier": "Basic",
        "image": "https://picsum.photos/100/100?random=1&keyword=cleanser",
        "category": "Skincare"
      },
      "upSellProducts": [
        {
          "id": "PROD002",
          "name": "Premium Vitamin C Cleanser",
          "price": 49.99,
          "tier": "Premium",
          "image": "https://picsum.photos/100/100?random=2&keyword=vitamin",
          "priceIncrease": 25.00,
          "conversionRate": 15.8,
          "features": ["Vitamin C", "Anti-aging", "Brightening"]
        },
        {
          "id": "PROD003",
          "name": "Luxury Rose Gold Cleanser",
          "price": 89.99,
          "tier": "Luxury",
          "image": "https://picsum.photos/100/100?random=3&keyword=luxury",
          "priceIncrease": 65.00,
          "conversionRate": 8.2,
          "features": ["24k Rose Gold", "Collagen", "Premium Formula"]
        }
      ],
      "conversionRate": 12.3,
      "totalRevenue": 3457.80,
      "avgUpSellValue": 37.50,
      "displayTrigger": "Add to Cart",
      "isActive": true,
      "createdDate": "December 5, 2024",
      "lastUpdated": "January 8, 2025"
    },
    {
      "id": "UPSELL002",
      "baseProduct": {
        "id": "PROD004",
        "name": "Standard Hair Dryer",
        "price": 89.99,
        "tier": "Basic",
        "image": "https://picsum.photos/100/100?random=4&keyword=dryer",
        "category": "Hair Care"
      },
      "upSellProducts": [
        {
          "id": "PROD005",
          "name": "Professional Ionic Hair Dryer",
          "price": 159.99,
          "tier": "Professional",
          "image": "https://picsum.photos/100/100?random=5&keyword=ionic",
          "priceIncrease": 70.00,
          "conversionRate": 22.5,
          "features": ["Ionic Technology", "3 Heat Settings", "Professional Grade"]
        },
        {
          "id": "PROD006",
          "name": "Luxury Salon Master Dryer",
          "price": 299.99,
          "tier": "Luxury",
          "image": "https://picsum.photos/100/100?random=6&keyword=salon",
          "priceIncrease": 210.00,
          "conversionRate": 6.8,
          "features": ["Tourmaline Ceramic", "Digital Display", "Salon Professional"]
        }
      ],
      "conversionRate": 14.7,
      "totalRevenue": 5623.45,
      "avgUpSellValue": 140.00,
      "displayTrigger": "Product View",
      "isActive": true,
      "createdDate": "November 20, 2024",
      "lastUpdated": "December 30, 2024"
    },
    {
      "id": "UPSELL003",
      "baseProduct": {
        "id": "PROD007",
        "name": "Basic Essential Oil Set",
        "price": 39.99,
        "tier": "Basic",
        "image": "https://picsum.photos/100/100?random=7&keyword=essential",
        "category": "Aromatherapy"
      },
      "upSellProducts": [
        {
          "id": "PROD008",
          "name": "Premium Organic Oil Collection",
          "price": 79.99,
          "tier": "Premium",
          "image": "https://picsum.photos/100/100?random=8&keyword=organic",
          "priceIncrease": 40.00,
          "conversionRate": 18.9,
          "features": ["100% Organic", "10 Oil Varieties", "Premium Quality"]
        },
        {
          "id": "PROD009",
          "name": "Luxury Rare Oil Signature Set",
          "price": 149.99,
          "tier": "Luxury",
          "image": "https://picsum.photos/100/100?random=9&keyword=rare",
          "priceIncrease": 110.00,
          "conversionRate": 9.1,
          "features": ["Rare Botanicals", "Limited Edition", "Artisan Crafted"]
        }
      ],
      "conversionRate": 14.0,
      "totalRevenue": 2134.50,
      "avgUpSellValue": 75.00,
      "displayTrigger": "Checkout",
      "isActive": false,
      "createdDate": "October 10, 2024",
      "lastUpdated": "November 15, 2024"
    }
  ];
  
  List<Map<String, dynamic>> upSellAnalytics = [
    {
      "product": "Basic Facial Cleanser",
      "category": "Skincare",
      "tier": "Basic",
      "totalViews": 1867,
      "upSellShown": 1456,
      "upSellClicked": 189,
      "upSellPurchased": 67,
      "conversionRate": 4.6,
      "revenueIncrease": 2547.80,
      "avgUpSellAmount": 38.03,
      "bestPerformingUpSell": "Premium Vitamin C Cleanser",
      "tierPreference": "Premium"
    },
    {
      "product": "Standard Hair Dryer",
      "category": "Hair Care",
      "tier": "Basic",
      "totalViews": 934,
      "upSellShown": 712,
      "upSellClicked": 156,
      "upSellPurchased": 89,
      "conversionRate": 12.5,
      "revenueIncrease": 8934.67,
      "avgUpSellAmount": 100.39,
      "bestPerformingUpSell": "Professional Ionic Hair Dryer",
      "tierPreference": "Professional"
    },
    {
      "product": "Basic Essential Oil Set",
      "category": "Aromatherapy",
      "tier": "Basic",
      "totalViews": 1245,
      "upSellShown": 934,
      "upSellClicked": 98,
      "upSellPurchased": 34,
      "conversionRate": 3.6,
      "revenueIncrease": 1876.45,
      "avgUpSellAmount": 55.19,
      "bestPerformingUpSell": "Premium Organic Oil Collection",
      "tierPreference": "Premium"
    }
  ];
  
  List<Map<String, dynamic>> tierUpgrades = [
    {
      "currentTier": "Basic",
      "upgradeTier": "Premium",
      "priceIncrease": "100-200%",
      "conversionRate": 18.5,
      "popularUpgrades": ["Vitamin C Cleanser", "Ionic Hair Dryer", "Organic Oil Set"],
      "revenueImpact": 12567.89
    },
    {
      "currentTier": "Premium", 
      "upgradeTier": "Luxury",
      "priceIncrease": "150-300%",
      "conversionRate": 8.2,
      "popularUpgrades": ["24k Rose Gold Serum", "Salon Master Dryer", "Rare Oil Collection"],
      "revenueImpact": 8934.56
    },
    {
      "currentTier": "Basic",
      "upgradeTier": "Professional",
      "priceIncrease": "200-250%",
      "conversionRate": 12.8,
      "popularUpgrades": ["Professional Equipment", "Salon Grade Tools", "Commercial Products"],
      "revenueImpact": 15678.23
    }
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredStrategies = _getFilteredStrategies();
    
    return QTabBar(
      title: "Up-Sell Management",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Up-Sell Strategies", icon: Icon(Icons.trending_up)),
        Tab(text: "Analytics", icon: Icon(Icons.insights)),
        Tab(text: "Tier Analysis", icon: Icon(Icons.stairs)),
      ],
      tabChildren: [
        _buildUpSellStrategiesTab(filteredStrategies),
        _buildAnalyticsTab(),
        _buildTierAnalysisTab(),
      ],
    );
  }
  
  Widget _buildUpSellStrategiesTab(List<Map<String, dynamic>> strategies) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filters
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spMd,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search up-sell strategies...",
                        value: searchQuery,
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spMd),
                    QButton(
                      icon: Icons.search,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categories.map((cat) => {"label": cat, "value": cat}).toList(),
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: QDropdownField(
                        label: "Tier",
                        items: tierOptions.map((tier) => {"label": tier, "value": tier}).toList(),
                        value: tierFilter,
                        onChanged: (value, label) {
                          tierFilter = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Up-Sell Overview
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Row(
                  children: [
                    Text(
                      "Up-Sell Strategy Overview",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Create Strategy",
                      size: bs.sm,
                      icon: Icons.add,
                      onPressed: () {
                        _createUpSellStrategy();
                      },
                    ),
                  ],
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    _buildStatCard("Active Strategies", "${strategies.where((s) => s["isActive"]).length}", primaryColor, Icons.trending_up),
                    _buildStatCard("Total Revenue", "\$${strategies.fold(0.0, (sum, strategy) => sum + (strategy["totalRevenue"] as double)).toStringAsFixed(2)}", successColor, Icons.attach_money),
                    _buildStatCard("Avg Conversion", "${(strategies.fold(0.0, (sum, strategy) => sum + (strategy["conversionRate"] as double)) / strategies.length).toStringAsFixed(1)}%", warningColor, Icons.percent),
                    _buildStatCard("Avg Up-Sell Value", "\$${(strategies.fold(0.0, (sum, strategy) => sum + (strategy["avgUpSellValue"] as double)) / strategies.length).toStringAsFixed(2)}", infoColor, Icons.trending_up),
                  ],
                ),
              ],
            ),
          ),
          
          // Up-Sell Strategies List
          if (strategies.isNotEmpty)
            ...strategies.map((strategy) => _buildUpSellStrategyCard(strategy)).toList()
          else
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.trending_up,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "No up-sell strategies found",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Create your first up-sell strategy to increase revenue",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  QButton(
                    label: "Create Strategy",
                    size: bs.md,
                    icon: Icons.add,
                    onPressed: () {
                      _createUpSellStrategy();
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Analytics Overview
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Up-Sell Performance Analytics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    _buildStatCard("Total Views", "${upSellAnalytics.fold(0, (sum, item) => sum + (item["totalViews"] as int))}", primaryColor, Icons.visibility),
                    _buildStatCard("Up-Sell Shown", "${upSellAnalytics.fold(0, (sum, item) => sum + (item["upSellShown"] as int))}", infoColor, Icons.ads_click),
                    _buildStatCard("Total Purchases", "${upSellAnalytics.fold(0, (sum, item) => sum + (item["upSellPurchased"] as int))}", warningColor, Icons.shopping_cart),
                    _buildStatCard("Revenue Increase", "\$${upSellAnalytics.fold(0.0, (sum, item) => sum + (item["revenueIncrease"] as double)).toStringAsFixed(2)}", successColor, Icons.trending_up),
                  ],
                ),
              ],
            ),
          ),
          
          // Product Performance
          ...upSellAnalytics.map((analytics) => _buildAnalyticsCard(analytics)).toList(),
        ],
      ),
    );
  }
  
  Widget _buildTierAnalysisTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Tier Overview
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Product Tier Analysis",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Analyze customer preferences for product tier upgrades",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    _buildStatCard("Tier Upgrades", "${tierUpgrades.length}", primaryColor, Icons.stairs),
                    _buildStatCard("Total Impact", "\$${tierUpgrades.fold(0.0, (sum, tier) => sum + (tier["revenueImpact"] as double)).toStringAsFixed(2)}", successColor, Icons.attach_money),
                    _buildStatCard("Best Conversion", "${tierUpgrades.map((t) => t["conversionRate"] as double).reduce((a, b) => a > b ? a : b).toStringAsFixed(1)}%", warningColor, Icons.star),
                    _buildStatCard("Popular Upgrade", "Basic → Premium", infoColor, Icons.upgrade),
                  ],
                ),
              ],
            ),
          ),
          
          // Tier Upgrades
          ...tierUpgrades.map((tier) => _buildTierUpgradeCard(tier)).toList(),
        ],
      ),
    );
  }
  
  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: color.withAlpha(60)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildUpSellStrategyCard(Map<String, dynamic> strategy) {
    Map<String, dynamic> baseProduct = strategy["baseProduct"];
    List<Map<String, dynamic>> upSellProducts = strategy["upSellProducts"] as List<Map<String, dynamic>>;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
        border: Border(
          left: BorderSide(
            width: 4,
            color: strategy["isActive"] ? successColor : disabledColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Strategy Header
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${baseProduct["image"]}",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getTierColor(baseProduct["tier"]),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${baseProduct["tier"]}".toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "\$${(baseProduct["price"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14,
                            color: successColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${baseProduct["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${baseProduct["category"]} • Trigger: ${strategy["displayTrigger"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: strategy["isActive"] ? successColor : disabledColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  strategy["isActive"] ? "ACTIVE" : "INACTIVE",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          
          // Performance Metrics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStrategyMetric("Conversion Rate", "${(strategy["conversionRate"] as double).toStringAsFixed(1)}%", Icons.trending_up),
              _buildStrategyMetric("Total Revenue", "\$${(strategy["totalRevenue"] as double).toStringAsFixed(2)}", Icons.attach_money),
              _buildStrategyMetric("Avg Up-Sell", "\$${(strategy["avgUpSellValue"] as double).toStringAsFixed(2)}", Icons.add_box),
              _buildStrategyMetric("Up-Sell Options", "${upSellProducts.length}", Icons.layers),
            ],
          ),
          
          // Up-Sell Products
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Up-Sell Options:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QHorizontalScroll(
                  children: upSellProducts.map((product) => 
                    Container(
                      margin: EdgeInsets.only(right: spMd),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusSm),
                                child: Image.network(
                                  "${product["image"]}",
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: spXs,
                                right: spXs,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: _getTierColor(product["tier"]),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${product["tier"]}".toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Container(
                            width: 100,
                            child: Column(
                              children: [
                                Text(
                                  "${product["name"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "\$${(product["price"] as double).toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: successColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "+\$${(product["priceIncrease"] as double).toStringAsFixed(0)}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: warningColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${(product["conversionRate"] as double).toStringAsFixed(1)}% conv",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).toList(),
                ),
              ],
            ),
          ),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Edit Strategy",
                  size: bs.sm,
                  icon: Icons.edit,
                  color: infoColor,
                  onPressed: () {
                    _editUpSellStrategy(strategy);
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QButton(
                  label: strategy["isActive"] ? "Deactivate" : "Activate",
                  size: bs.sm,
                  icon: strategy["isActive"] ? Icons.pause : Icons.play_arrow,
                  color: strategy["isActive"] ? warningColor : successColor,
                  onPressed: () {
                    _toggleStrategyStatus(strategy);
                  },
                ),
              ),
              SizedBox(width: spMd),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                color: primaryColor,
                onPressed: () {
                  _showStrategyOptions(strategy);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildAnalyticsCard(Map<String, dynamic> analytics) {
    double showRate = ((analytics["upSellShown"] as int) / (analytics["totalViews"] as int)) * 100;
    double clickRate = ((analytics["upSellClicked"] as int) / (analytics["upSellShown"] as int)) * 100;
    double purchaseRate = ((analytics["upSellPurchased"] as int) / (analytics["upSellClicked"] as int)) * 100;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Product Header
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: _getTierColor(analytics["tier"]).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(
                  Icons.trending_up,
                  color: _getTierColor(analytics["tier"]),
                  size: 24,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${analytics["product"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${analytics["category"]} • ${analytics["tier"]} Tier",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Best: ${analytics["bestPerformingUpSell"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                decoration: BoxDecoration(
                  color: successColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${(analytics["conversionRate"] as double).toStringAsFixed(1)}%",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          
          // Analytics Metrics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildAnalyticsMetric("Show Rate", "${showRate.toStringAsFixed(1)}%", Icons.visibility, primaryColor),
              _buildAnalyticsMetric("Click Rate", "${clickRate.toStringAsFixed(1)}%", Icons.mouse, infoColor),
              _buildAnalyticsMetric("Purchase Rate", "${purchaseRate.toStringAsFixed(1)}%", Icons.shopping_cart, warningColor),
              _buildAnalyticsMetric("Revenue Impact", "\$${(analytics["revenueIncrease"] as double).toStringAsFixed(2)}", Icons.trending_up, successColor),
            ],
          ),
          
          // Customer Preference
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.psychology,
                  color: infoColor,
                  size: 20,
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Customer Preference: ${analytics["tierPreference"]} Tier",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Average up-sell amount: \$${(analytics["avgUpSellAmount"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTierUpgradeCard(Map<String, dynamic> tier) {
    List<String> popularUpgrades = tier["popularUpgrades"] as List<String>;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Tier Upgrade Header
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: _getTierColor(tier["currentTier"]).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(
                  Icons.stairs,
                  color: _getTierColor(tier["currentTier"]),
                  size: 32,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getTierColor(tier["currentTier"]),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${tier["currentTier"]}".toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          Icons.arrow_forward,
                          color: primaryColor,
                          size: 16,
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getTierColor(tier["upgradeTier"]),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${tier["upgradeTier"]}".toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${tier["currentTier"]} to ${tier["upgradeTier"]} Upgrade",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Price increase: ${tier["priceIncrease"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                decoration: BoxDecoration(
                  color: successColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${(tier["conversionRate"] as double).toStringAsFixed(1)}%",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          
          // Popular Upgrades
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Popular Upgrade Products:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Wrap(
                  spacing: spSm,
                  runSpacing: spXs,
                  children: popularUpgrades.map((upgrade) =>
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        upgrade,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ).toList(),
                ),
              ],
            ),
          ),
          
          // Revenue Impact
          Row(
            children: [
              Icon(
                Icons.trending_up,
                color: successColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Revenue Impact: \$${(tier["revenueImpact"] as double).toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View Details",
                size: bs.sm,
                icon: Icons.visibility,
                color: infoColor,
                onPressed: () {
                  _viewTierDetails(tier);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildStrategyMetric(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: primaryColor,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 11,
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
  
  Widget _buildAnalyticsMetric(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: color,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 11,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  List<Map<String, dynamic>> _getFilteredStrategies() {
    List<Map<String, dynamic>> filtered = List.from(upSellStrategies);
    
    // Filter by category
    if (selectedCategory != "All") {
      filtered = filtered.where((strategy) => 
        strategy["baseProduct"]["category"] == selectedCategory
      ).toList();
    }
    
    // Filter by tier
    if (tierFilter != "All") {
      filtered = filtered.where((strategy) => 
        strategy["baseProduct"]["tier"] == tierFilter
      ).toList();
    }
    
    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((strategy) => 
        (strategy["baseProduct"]["name"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }
  
  Color _getTierColor(String tier) {
    switch (tier) {
      case "Basic":
        return infoColor;
      case "Premium":
        return warningColor;
      case "Professional":
        return primaryColor;
      case "Luxury":
        return dangerColor;
      default:
        return disabledColor;
    }
  }
  
  void _createUpSellStrategy() {
    ss("Creating new up-sell strategy");
  }
  
  void _editUpSellStrategy(Map<String, dynamic> strategy) {
    ss("Editing up-sell strategy for ${strategy["baseProduct"]["name"]}");
  }
  
  void _toggleStrategyStatus(Map<String, dynamic> strategy) {
    bool newStatus = !strategy["isActive"];
    strategy["isActive"] = newStatus;
    setState(() {});
    ss("Up-sell strategy ${newStatus ? "activated" : "deactivated"}");
  }
  
  void _showStrategyOptions(Map<String, dynamic> strategy) {
    ss("Showing options for up-sell strategy");
  }
  
  void _viewTierDetails(Map<String, dynamic> tier) {
    ss("Viewing details for ${tier["currentTier"]} to ${tier["upgradeTier"]} upgrade");
  }
}
