import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsDealsView extends StatefulWidget {
  const EcsDealsView({super.key});

  @override
  State<EcsDealsView> createState() => _EcsDealsViewState();
}

class _EcsDealsViewState extends State<EcsDealsView> {
  String selectedCategory = "All";
  int currentTab = 0;

  List<Map<String, dynamic>> dealCategories = [
    {"label": "All", "value": "All"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Fashion", "value": "Fashion"},
    {"label": "Home", "value": "Home"},
    {"label": "Beauty", "value": "Beauty"},
    {"label": "Sports", "value": "Sports"},
  ];

  List<Map<String, dynamic>> deals = [
    {
      "id": 1,
      "title": "Wireless Headphones Pro",
      "originalPrice": 199.99,
      "discountPrice": 99.99,
      "discount": 50,
      "image": "https://picsum.photos/300/300?random=1&keyword=headphones",
      "category": "Electronics",
      "rating": 4.8,
      "reviews": 1250,
      "timeLeft": "2d 14h 30m",
      "soldCount": 856,
      "totalStock": 1000,
      "isFeatured": true
    },
    {
      "id": 2,
      "title": "Summer Dress Collection",
      "originalPrice": 89.99,
      "discountPrice": 54.99,
      "discount": 39,
      "image": "https://picsum.photos/300/300?random=2&keyword=dress",
      "category": "Fashion",
      "rating": 4.6,
      "reviews": 892,
      "timeLeft": "1d 8h 45m",
      "soldCount": 324,
      "totalStock": 500,
      "isFeatured": false
    },
    {
      "id": 3,
      "title": "Smart Coffee Maker",
      "originalPrice": 259.99,
      "discountPrice": 159.99,
      "discount": 38,
      "image": "https://picsum.photos/300/300?random=3&keyword=coffee",
      "category": "Home",
      "rating": 4.7,
      "reviews": 456,
      "timeLeft": "3d 2h 15m",
      "soldCount": 167,
      "totalStock": 300,
      "isFeatured": true
    },
    {
      "id": 4,
      "title": "Skincare Bundle Set",
      "originalPrice": 149.99,
      "discountPrice": 89.99,
      "discount": 40,
      "image": "https://picsum.photos/300/300?random=4&keyword=skincare",
      "category": "Beauty",
      "rating": 4.9,
      "reviews": 678,
      "timeLeft": "4h 22m",
      "soldCount": 445,
      "totalStock": 600,
      "isFeatured": false
    },
    {
      "id": 5,
      "title": "Fitness Tracker Watch",
      "originalPrice": 179.99,
      "discountPrice": 119.99,
      "discount": 33,
      "image": "https://picsum.photos/300/300?random=5&keyword=watch",
      "category": "Sports",
      "rating": 4.5,
      "reviews": 789,
      "timeLeft": "1d 16h 5m",
      "soldCount": 523,
      "totalStock": 800,
      "isFeatured": true
    },
    {
      "id": 6,
      "title": "Gaming Mechanical Keyboard",
      "originalPrice": 129.99,
      "discountPrice": 79.99,
      "discount": 38,
      "image": "https://picsum.photos/300/300?random=6&keyword=keyboard",
      "category": "Electronics",
      "rating": 4.6,
      "reviews": 334,
      "timeLeft": "2d 3h 48m",
      "soldCount": 212,
      "totalStock": 400,
      "isFeatured": false
    }
  ];

  List<Map<String, dynamic>> get filteredDeals {
    if (selectedCategory == "All") {
      return deals;
    }
    return deals.where((deal) => deal["category"] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Special Deals",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All Deals", icon: Icon(Icons.local_offer)),
        Tab(text: "Featured", icon: Icon(Icons.star)),
        Tab(text: "Ending Soon", icon: Icon(Icons.access_time)),
      ],
      tabChildren: [
        _buildAllDealsTab(),
        _buildFeaturedDealsTab(),
        _buildEndingSoonTab(),
      ],
    );
  }

  Widget _buildAllDealsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          _buildDealsBanner(),
          _buildCategoryFilter(),
          _buildDealsStats(),
          _buildDealsGrid(),
        ],
      ),
    );
  }

  Widget _buildFeaturedDealsTab() {
    List<Map<String, dynamic>> featuredDeals = deals.where((deal) => deal["isFeatured"] == true).toList();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: primaryColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.star, color: primaryColor, size: 24),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Featured Deals",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Hand-picked deals with the best discounts",
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
          ),
          _buildDealsGrid(deals: featuredDeals),
        ],
      ),
    );
  }

  Widget _buildEndingSoonTab() {
    // Sort by time left (shortest first)
    List<Map<String, dynamic>> endingSoonDeals = [...deals];
    endingSoonDeals.sort((a, b) => a["timeLeft"].toString().compareTo(b["timeLeft"].toString()));
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: dangerColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.access_time, color: dangerColor, size: 24),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ending Soon",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Grab these deals before they expire!",
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
          ),
          ...endingSoonDeals.take(3).map((deal) => _buildUrgentDealCard(deal)),
          _buildDealsGrid(deals: endingSoonDeals),
        ],
      ),
    );
  }

  Widget _buildDealsBanner() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primaryColor,
            primaryColor.withAlpha(200),
          ],
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.local_fire_department, color: Colors.white, size: 28),
              SizedBox(width: spSm),
              Text(
                "Hot Deals",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            "Up to 70% OFF",
            style: TextStyle(
              fontSize: fsH2,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            "Limited time offers on trending products",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withAlpha(220),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Categories",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        QCategoryPicker(
          items: dealCategories,
          value: selectedCategory,
          onChanged: (index, label, value, item) {
            selectedCategory = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildDealsStats() {
    int totalDeals = filteredDeals.length;
    double avgDiscount = filteredDeals.fold(0.0, (sum, deal) => sum + (deal["discount"] as int)) / totalDeals;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem("Total Deals", "${totalDeals}", Icons.local_offer, primaryColor),
          ),
          Container(width: 1, height: 40, color: disabledColor),
          Expanded(
            child: _buildStatItem("Avg Discount", "${avgDiscount.toInt()}%", Icons.percent, successColor),
          ),
          Container(width: 1, height: 40, color: disabledColor),
          Expanded(
            child: _buildStatItem("Active Now", "${totalDeals}", Icons.schedule, warningColor),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      spacing: spXs,
      children: [
        Icon(icon, color: color, size: 24),
        Text(
          value,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildDealsGrid({List<Map<String, dynamic>>? deals}) {
    List<Map<String, dynamic>> dealsToShow = deals ?? filteredDeals;
    
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: dealsToShow.map((deal) {
        return _buildDealCard(deal);
      }).toList(),
    );
  }

  Widget _buildDealCard(Map<String, dynamic> deal) {
    double progressValue = (deal["soldCount"] as int) / (deal["totalStock"] as int);
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Image.network(
                  "${deal["image"]}",
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: dangerColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "-${deal["discount"]}%",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              if (deal["isFeatured"])
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: warningColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(Icons.star, color: Colors.white, size: 16),
                  ),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "${deal["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < (deal["rating"] as double).floor() 
                              ? Icons.star 
                              : Icons.star_border,
                          color: warningColor,
                          size: 16,
                        );
                      }),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${deal["rating"]} (${deal["reviews"]})",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "\$${((deal["originalPrice"] as double).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "\$${((deal["discountPrice"] as double).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.access_time, color: warningColor, size: 14),
                      SizedBox(width: spXs),
                      Text(
                        "${deal["timeLeft"]} left",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sold: ${deal["soldCount"]}/${deal["totalStock"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${(progressValue * 100).toInt()}%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    LinearProgressIndicator(
                      value: progressValue,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Shop Now",
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo EcsProductDetailView
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUrgentDealCard(Map<String, dynamic> deal) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: dangerColor.withAlpha(50)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${deal["image"]}",
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${deal["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text(
                      "\$${((deal["discountPrice"] as double).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "\$${((deal["originalPrice"] as double).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: dangerColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "⏰ ${deal["timeLeft"]} left",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Buy Now",
            size: bs.sm,
            onPressed: () {
              //navigateTo EcsProductDetailView
            },
          ),
        ],
      ),
    );
  }
}
