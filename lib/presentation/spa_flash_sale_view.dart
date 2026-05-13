import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaFlashSaleView extends StatefulWidget {
  const SpaFlashSaleView({Key? key}) : super(key: key);

  @override
  State<SpaFlashSaleView> createState() => _SpaFlashSaleViewState();
}

class _SpaFlashSaleViewState extends State<SpaFlashSaleView> {
  String selectedCategory = "all";
  bool notificationsEnabled = true;

  List<Map<String, dynamic>> flashDeals = [
    {
      "id": 1,
      "title": "Diamond Facial Treatment",
      "originalPrice": 599.0,
      "salePrice": 299.0,
      "discount": 50,
      "image": "https://picsum.photos/300/200?random=1&keyword=diamond",
      "spa": "Platinum Spa & Wellness",
      "category": "facial",
      "timeLeft": "02:35:42",
      "sold": 45,
      "available": 15,
      "rating": 4.9,
      "reviews": 67,
      "features": ["Diamond powder", "24K gold mask", "Collagen boost"],
      "isPopular": true,
      "isAlmostSoldOut": false,
    },
    {
      "id": 2,
      "title": "Hot Stone Massage",
      "originalPrice": 280.0,
      "salePrice": 168.0,
      "discount": 40,
      "image": "https://picsum.photos/300/200?random=2&keyword=hotstone",
      "spa": "Zen Retreat Center",
      "category": "massage",
      "timeLeft": "01:18:23",
      "sold": 38,
      "available": 2,
      "rating": 4.7,
      "reviews": 89,
      "features": ["90 minutes", "Aromatherapy", "Muscle relief"],
      "isPopular": false,
      "isAlmostSoldOut": true,
    },
    {
      "id": 3,
      "title": "Couples Romantic Package",
      "originalPrice": 890.0,
      "salePrice": 534.0,
      "discount": 40,
      "image": "https://picsum.photos/300/200?random=3&keyword=couples",
      "spa": "Romance Spa Suite",
      "category": "package",
      "timeLeft": "04:45:12",
      "sold": 12,
      "available": 8,
      "rating": 4.8,
      "reviews": 34,
      "features": ["Private suite", "Champagne", "Rose petals", "2 massages"],
      "isPopular": true,
      "isAlmostSoldOut": false,
    },
    {
      "id": 4,
      "title": "Anti-Cellulite Treatment",
      "originalPrice": 340.0,
      "salePrice": 204.0,
      "discount": 40,
      "image": "https://picsum.photos/300/200?random=4&keyword=cellulite",
      "spa": "Body Sculpt Clinic",
      "category": "body",
      "timeLeft": "00:52:18",
      "sold": 23,
      "available": 7,
      "rating": 4.6,
      "reviews": 56,
      "features": ["Radiofrequency", "Lymphatic drainage", "Firming cream"],
      "isPopular": false,
      "isAlmostSoldOut": false,
    },
    {
      "id": 5,
      "title": "Luxury Manicure & Pedicure",
      "originalPrice": 180.0,
      "salePrice": 99.0,
      "discount": 45,
      "image": "https://picsum.photos/300/200?random=5&keyword=manicure",
      "spa": "Nail Artistry Studio",
      "category": "nails",
      "timeLeft": "03:22:07",
      "sold": 67,
      "available": 3,
      "rating": 4.5,
      "reviews": 124,
      "features": ["Gel polish", "Nail art", "Hand massage", "Cuticle care"],
      "isPopular": false,
      "isAlmostSoldOut": true,
    },
    {
      "id": 6,
      "title": "Detox Body Wrap",
      "originalPrice": 250.0,
      "salePrice": 125.0,
      "discount": 50,
      "image": "https://picsum.photos/300/200?random=6&keyword=bodywrap",
      "spa": "Wellness Detox Center",
      "category": "body",
      "timeLeft": "02:08:45",
      "sold": 31,
      "available": 9,
      "rating": 4.4,
      "reviews": 78,
      "features": ["Seaweed wrap", "Infrared therapy", "Slimming effect"],
      "isPopular": false,
      "isAlmostSoldOut": false,
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Facial Treatments", "value": "facial"},
    {"label": "Massage Therapy", "value": "massage"},
    {"label": "Body Treatments", "value": "body"},
    {"label": "Nail Services", "value": "nails"},
    {"label": "Spa Packages", "value": "package"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("⚡ Flash Sale"),
        actions: [
          QButton(
            icon: notificationsEnabled ? Icons.notifications : Icons.notifications_off,
            size: bs.sm,
            onPressed: () {
              _toggleNotifications();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Flash Sale Header
          _buildFlashSaleHeader(),

          // Category Filter
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            color: Colors.grey[50],
            child: QDropdownField(
              label: "Category",
              items: categories,
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
              },
            ),
          ),

          // Flash Deals Grid
          Expanded(
            child: ResponsiveGridView(
              padding: EdgeInsets.all(spMd),
              minItemWidth: 200,
              children: _getFilteredDeals().map((deal) {
                return _buildFlashDealCard(deal);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlashSaleHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [dangerColor, warningColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.flash_on, color: Colors.white, size: 28),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Flash Sale",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Limited time offers - hurry up!",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  "Up to 50% OFF",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          // Notification Toggle
          Row(
            children: [
              Icon(Icons.notification_important, color: Colors.white, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Get notified when new flash sales start",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
              ),
              Switch(
                value: notificationsEnabled,
                onChanged: (value) {
                  _toggleNotifications();
                },
                activeColor: Colors.white,
                activeTrackColor: Colors.white.withAlpha(100),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFlashDealCard(Map<String, dynamic> deal) {
    double progressPercentage = (deal["sold"] as int) / ((deal["sold"] as int) + (deal["available"] as int));
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image and Badges
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Image.network(
                  "${deal["image"]}",
                  width: double.infinity,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
              
              // Discount Badge
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
                    "${deal["discount"]}% OFF",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // Popular Badge
              if (deal["isPopular"] as bool)
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "POPULAR",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

              // Almost Sold Out Badge
              if (deal["isAlmostSoldOut"] as bool)
                Positioned(
                  bottom: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: warningColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "ALMOST SOLD OUT",
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

          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                // Title and Spa
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${deal["title"]}",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${deal["spa"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),

                // Price
                Row(
                  children: [
                    Text(
                      "\$${((deal["salePrice"] as double)).currency}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "\$${((deal["originalPrice"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),

                // Rating
                Row(
                  children: [
                    Icon(Icons.star, color: warningColor, size: 14),
                    SizedBox(width: spXs),
                    Text(
                      "${deal["rating"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      " (${deal["reviews"]})",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),

                // Features
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (deal["features"] as List<String>).take(2).map((feature) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        feature,
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                // Progress Bar
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sold: ${deal["sold"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Left: ${deal["available"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: progressPercentage,
                        child: Container(
                          decoration: BoxDecoration(
                            color: progressPercentage > 0.8 ? dangerColor : primaryColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Time Left
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: dangerColor.withAlpha(100),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time,
                        color: dangerColor,
                        size: 14,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${deal["timeLeft"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),

                // Book Button
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Buy Now",
                    size: bs.sm,
                    onPressed: () {
                      _buyFlashDeal(deal);
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

  List<Map<String, dynamic>> _getFilteredDeals() {
    List<Map<String, dynamic>> filtered = List.from(flashDeals);

    if (selectedCategory != "all") {
      filtered = filtered.where((deal) => deal["category"] == selectedCategory).toList();
    }

    // Sort by time left (ending soon first)
    filtered.sort((a, b) {
      List<String> aParts = (a["timeLeft"] as String).split(":");
      List<String> bParts = (b["timeLeft"] as String).split(":");
      
      int aMinutes = (int.parse(aParts[0]) * 60) + int.parse(aParts[1]);
      int bMinutes = (int.parse(bParts[0]) * 60) + int.parse(bParts[1]);
      
      return aMinutes.compareTo(bMinutes);
    });

    return filtered;
  }

  void _toggleNotifications() {
    setState(() {
      notificationsEnabled = !notificationsEnabled;
    });
    
    if (notificationsEnabled) {
      ss("Flash sale notifications enabled");
    } else {
      si("Flash sale notifications disabled");
    }
  }

  void _buyFlashDeal(Map<String, dynamic> deal) {
    if ((deal["available"] as int) > 0) {
      ss("Purchasing ${deal["title"]}...");
      //navigateTo ( SpaBookingView )
    } else {
      se("This deal is sold out!");
    }
  }
}
