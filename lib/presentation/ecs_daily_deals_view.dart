import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsDailyDealsView extends StatefulWidget {
  const EcsDailyDealsView({super.key});

  @override
  State<EcsDailyDealsView> createState() => _EcsDailyDealsViewState();
}

class _EcsDailyDealsViewState extends State<EcsDailyDealsView> {
  DateTime dealRefreshTime = DateTime.now().add(Duration(hours: 18, minutes: 42));
  
  List<Map<String, dynamic>> dailyDeals = [
    {
      "id": 1,
      "title": "Bluetooth Speaker Pro",
      "originalPrice": 149.99,
      "dealPrice": 79.99,
      "discount": 47,
      "image": "https://picsum.photos/400/400?random=1&keyword=speaker",
      "category": "Electronics",
      "rating": 4.6,
      "reviews": 1234,
      "dealType": "Deal of the Day",
      "timeLeft": "18h 42m",
      "isExpiring": false,
      "soldToday": 234,
      "badge": "BESTSELLER"
    },
    {
      "id": 2,
      "title": "Yoga Mat Premium",
      "originalPrice": 59.99,
      "dealPrice": 29.99,
      "discount": 50,
      "image": "https://picsum.photos/400/400?random=2&keyword=yoga",
      "category": "Sports",
      "rating": 4.8,
      "reviews": 856,
      "dealType": "Daily Special",
      "timeLeft": "6h 15m",
      "isExpiring": true,
      "soldToday": 89,
      "badge": "HOT DEAL"
    },
    {
      "id": 3,
      "title": "Coffee Subscription Box",
      "originalPrice": 39.99,
      "dealPrice": 19.99,
      "discount": 50,
      "image": "https://picsum.photos/400/400?random=3&keyword=coffee",
      "category": "Food",
      "rating": 4.7,
      "reviews": 567,
      "dealType": "Morning Deal",
      "timeLeft": "4h 22m",
      "isExpiring": true,
      "soldToday": 156,
      "badge": "LIMITED"
    },
    {
      "id": 4,
      "title": "Organic Face Mask Set",
      "originalPrice": 79.99,
      "dealPrice": 39.99,
      "discount": 50,
      "image": "https://picsum.photos/400/400?random=4&keyword=facemask",
      "category": "Beauty",
      "rating": 4.9,
      "reviews": 923,
      "dealType": "Beauty Deal",
      "timeLeft": "12h 30m",
      "isExpiring": false,
      "soldToday": 67,
      "badge": "NEW"
    },
    {
      "id": 5,
      "title": "Reading Lamp LED",
      "originalPrice": 89.99,
      "dealPrice": 49.99,
      "discount": 44,
      "image": "https://picsum.photos/400/400?random=5&keyword=lamp",
      "category": "Home",
      "rating": 4.5,
      "reviews": 445,
      "dealType": "Evening Deal",
      "timeLeft": "20h 18m",
      "isExpiring": false,
      "soldToday": 34,
      "badge": "ECO-FRIENDLY"
    },
    {
      "id": 6,
      "title": "Smart Watch Fitness",
      "originalPrice": 199.99,
      "dealPrice": 119.99,
      "discount": 40,
      "image": "https://picsum.photos/400/400?random=6&keyword=smartwatch",
      "category": "Electronics",
      "rating": 4.4,
      "reviews": 1456,
      "dealType": "Tech Deal",
      "timeLeft": "8h 55m",
      "isExpiring": false,
      "soldToday": 178,
      "badge": "TRENDING"
    }
  ];

  List<Map<String, dynamic>> dealCategories = [
    {"label": "All Categories", "value": "All", "icon": Icons.apps},
    {"label": "Electronics", "value": "Electronics", "icon": Icons.devices},
    {"label": "Fashion", "value": "Fashion", "icon": Icons.checkroom},
    {"label": "Home", "value": "Home", "icon": Icons.home},
    {"label": "Beauty", "value": "Beauty", "icon": Icons.face},
    {"label": "Sports", "value": "Sports", "icon": Icons.sports},
    {"label": "Food", "value": "Food", "icon": Icons.restaurant},
  ];

  String selectedCategory = "All";

  List<Map<String, dynamic>> get filteredDeals {
    if (selectedCategory == "All") {
      return dailyDeals;
    }
    return dailyDeals.where((deal) => deal["category"] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Deals"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Deals refreshed!");
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildDailyDealsHeader(),
            _buildNextRefreshTimer(),
            _buildDealStats(),
            _buildCategoryTabs(),
            _buildTodaysDealOfTheDay(),
            _buildExpiringDeals(),
            _buildAllDailyDeals(),
            _buildTomorrowsPreview(),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyDealsHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primaryColor,
            primaryColor.withAlpha(180),
          ],
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.today, color: Colors.white, size: 28),
              SizedBox(width: spSm),
              Text(
                "Daily Deals",
                style: TextStyle(
                  fontSize: fsH3,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "Fresh deals every 24 hours",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withAlpha(220),
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "New deals added daily at midnight",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(180),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextRefreshTimer() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: warningColor.withAlpha(50)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.update, color: warningColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Next Deal Refresh",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTimeUnit("18", "Hours"),
              Text(":", style: TextStyle(fontSize: fsH5, fontWeight: FontWeight.bold)),
              _buildTimeUnit("42", "Minutes"),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "💡 Set reminders to never miss a deal!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: infoColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeUnit(String value, String label) {
    return Column(
      spacing: spXs,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
          decoration: BoxDecoration(
            color: warningColor,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildDealStats() {
    int totalDeals = filteredDeals.length;
    int totalSoldToday = filteredDeals.fold(0, (sum, deal) => sum + (deal["soldToday"] as int));
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
            child: _buildStatItem("Today's Deals", "${totalDeals}", Icons.local_offer, primaryColor),
          ),
          Container(width: 1, height: 40, color: disabledColor),
          Expanded(
            child: _buildStatItem("Sold Today", "${totalSoldToday}", Icons.shopping_cart, successColor),
          ),
          Container(width: 1, height: 40, color: disabledColor),
          Expanded(
            child: _buildStatItem("Avg Save", "${avgDiscount.toInt()}%", Icons.savings, warningColor),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      spacing: spXs,
      children: [
        Icon(icon, color: color, size: 20),
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
            fontSize: 11,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryTabs() {
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
        QHorizontalScroll(
          children: dealCategories.map((category) {
            bool isSelected = selectedCategory == category["value"];
            return GestureDetector(
              onTap: () {
                selectedCategory = category["value"];
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                margin: EdgeInsets.only(right: spSm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                  ),
                  boxShadow: isSelected ? [shadowSm] : [],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      category["icon"],
                      color: isSelected ? Colors.white : disabledBoldColor,
                      size: 18,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${category["label"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTodaysDealOfTheDay() {
    Map<String, dynamic> dealOfTheDay = dailyDeals.first;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Icon(Icons.star, color: warningColor, size: 20),
            SizedBox(width: spXs),
            Text(
              "Deal of the Day",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowMd],
            border: Border.all(color: warningColor.withAlpha(100)),
          ),
          child: Column(
            spacing: spMd,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${dealOfTheDay["image"]}",
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: spXs,
                        left: spXs,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: warningColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${dealOfTheDay["badge"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "${dealOfTheDay["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Row(
                          children: [
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < (dealOfTheDay["rating"] as double).floor() 
                                      ? Icons.star 
                                      : Icons.star_border,
                                  color: warningColor,
                                  size: 14,
                                );
                              }),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${dealOfTheDay["rating"]} (${dealOfTheDay["reviews"]})",
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
                              "\$${((dealOfTheDay["originalPrice"] as double).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "\$${((dealOfTheDay["dealPrice"] as double).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${dealOfTheDay["soldToday"]} sold today",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Get Deal of the Day",
                  size: bs.md,
                  onPressed: () {
                    //navigateTo EcsProductDetailView
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExpiringDeals() {
    List<Map<String, dynamic>> expiringDeals = dailyDeals.where((deal) => deal["isExpiring"] == true).toList();
    
    if (expiringDeals.isEmpty) return SizedBox.shrink();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Icon(Icons.access_time, color: dangerColor, size: 20),
            SizedBox(width: spXs),
            Text(
              "Expiring Soon",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: dangerColor,
              ),
            ),
          ],
        ),
        QHorizontalScroll(
          children: expiringDeals.map((deal) {
            return Container(
              width: 280,
              margin: EdgeInsets.only(right: spSm),
              child: _buildDealCard(deal, isUrgent: true),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAllDailyDeals() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "All Daily Deals",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: filteredDeals.map((deal) {
            return _buildDealCard(deal);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDealCard(Map<String, dynamic> deal, {bool isUrgent = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: isUrgent ? Border.all(color: dangerColor.withAlpha(100)) : null,
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
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: deal["isExpiring"] ? dangerColor : successColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${deal["badge"]}",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    borderRadius: BorderRadius.circular(radiusXs),
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${deal["dealType"]}",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
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
                      "\$${((deal["dealPrice"] as double).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
                if (deal["isExpiring"])
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.access_time, color: dangerColor, size: 12),
                        SizedBox(width: spXs),
                        Text(
                          "${deal["timeLeft"]} left",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Get Deal",
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

  Widget _buildTomorrowsPreview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: infoColor.withAlpha(50)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.preview, color: infoColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Tomorrow's Deals Preview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
            ],
          ),
          Text(
            "Get a sneak peek at tomorrow's deals",
            style: TextStyle(
              fontSize: 16,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "• Premium Headphones 60% OFF\n• Home Decor Collection 45% OFF\n• Fitness Equipment 55% OFF",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Set Deal Alerts",
              size: bs.sm,
              onPressed: () {
                ss("Deal alerts set! You'll be notified when tomorrow's deals go live.");
              },
            ),
          ),
        ],
      ),
    );
  }
}
