import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPromo5View extends StatefulWidget {
  @override
  State<GrlPromo5View> createState() => _GrlPromo5ViewState();
}

class _GrlPromo5ViewState extends State<GrlPromo5View> {
  String selectedFilter = "Today";
  bool showOnlyFavorites = false;
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Popular", "value": "Popular"},
  ];

  List<Map<String, dynamic>> todayDeals = [
    {
      "id": "1",
      "title": "Lightning Deal",
      "description": "Wireless Headphones - Premium Sound Quality",
      "originalPrice": 199.99,
      "salePrice": 79.99,
      "discountPercent": 60,
      "brand": "AudioTech",
      "category": "Electronics",
      "image": "https://picsum.photos/300/200?random=1&keyword=headphones",
      "timeLeft": "2h 15m",
      "soldCount": 234,
      "totalStock": 500,
      "rating": 4.8,
      "reviewCount": 1247,
      "isLightningDeal": true,
      "isFavorite": false,
      "freeShipping": true,
      "color": Color(0xFFE91E63),
    },
    {
      "id": "2",
      "title": "Flash Sale",
      "description": "Designer Handbag - Genuine Leather",
      "originalPrice": 299.99,
      "salePrice": 149.99,
      "discountPercent": 50,
      "brand": "LuxeBags",
      "category": "Fashion",
      "image": "https://picsum.photos/300/200?random=2&keyword=handbag",
      "timeLeft": "5h 42m",
      "soldCount": 89,
      "totalStock": 200,
      "rating": 4.6,
      "reviewCount": 456,
      "isLightningDeal": false,
      "isFavorite": true,
      "freeShipping": true,
      "color": Color(0xFF9C27B0),
    },
    {
      "id": "3",
      "title": "Daily Special",
      "description": "Smart Watch - Fitness Tracker with GPS",
      "originalPrice": 399.99,
      "salePrice": 199.99,
      "discountPercent": 50,
      "brand": "FitTech",
      "category": "Electronics",
      "image": "https://picsum.photos/300/200?random=3&keyword=smartwatch",
      "timeLeft": "8h 23m",
      "soldCount": 156,
      "totalStock": 300,
      "rating": 4.7,
      "reviewCount": 892,
      "isLightningDeal": false,
      "isFavorite": false,
      "freeShipping": true,
      "color": Color(0xFF2196F3),
    },
    {
      "id": "4",
      "title": "Weekend Deal",
      "description": "Coffee Machine - Espresso & Cappuccino Maker",
      "originalPrice": 599.99,
      "salePrice": 359.99,
      "discountPercent": 40,
      "brand": "BrewMaster",
      "category": "Home",
      "image": "https://picsum.photos/300/200?random=4&keyword=coffee",
      "timeLeft": "1d 4h",
      "soldCount": 67,
      "totalStock": 150,
      "rating": 4.9,
      "reviewCount": 234,
      "isLightningDeal": false,
      "isFavorite": true,
      "freeShipping": false,
      "color": Color(0xFF795548),
    },
    {
      "id": "5",
      "title": "Hot Deal",
      "description": "Gaming Chair - Ergonomic Design with RGB Lighting",
      "originalPrice": 449.99,
      "salePrice": 269.99,
      "discountPercent": 40,
      "brand": "GameZone",
      "category": "Electronics",
      "image": "https://picsum.photos/300/200?random=5&keyword=gaming",
      "timeLeft": "6h 15m",
      "soldCount": 123,
      "totalStock": 250,
      "rating": 4.5,
      "reviewCount": 678,
      "isLightningDeal": false,
      "isFavorite": false,
      "freeShipping": true,
      "color": Color(0xFF673AB7),
    },
    {
      "id": "6",
      "title": "Quick Sale",
      "description": "Skincare Set - Anti-Aging & Moisturizing",
      "originalPrice": 159.99,
      "salePrice": 79.99,
      "discountPercent": 50,
      "brand": "GlowSkin",
      "category": "Beauty",
      "image": "https://picsum.photos/300/200?random=6&keyword=skincare",
      "timeLeft": "3h 45m",
      "soldCount": 89,
      "totalStock": 180,
      "rating": 4.4,
      "reviewCount": 345,
      "isLightningDeal": true,
      "isFavorite": false,
      "freeShipping": true,
      "color": Color(0xFFFF9800),
    },
  ];

  List<Map<String, dynamic>> get filteredDeals {
    var deals = List<Map<String, dynamic>>.from(todayDeals);
    
    if (showOnlyFavorites) {
      deals = deals.where((deal) => deal["isFavorite"] as bool).toList();
    }
    
    // Sort based on filter
    deals.sort((a, b) {
      switch (selectedFilter) {
        case "Popular":
          return (b["rating"] as double).compareTo(a["rating"] as double);
        case "Today":
          return (a["isLightningDeal"] as bool) ? -1 : 1;
        default:
          return (b["discountPercent"] as int).compareTo(a["discountPercent"] as int);
      }
    });
    
    return deals;
  }

  double get totalSavings {
    double total = 0;
    for (var deal in todayDeals) {
      if (deal["isFavorite"] as bool) {
        total += ((deal["originalPrice"] as double) - (deal["salePrice"] as double));
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Today's Deals"),
        actions: [
          IconButton(
            icon: Icon(
              showOnlyFavorites ? Icons.favorite : Icons.favorite_border,
              color: showOnlyFavorites ? dangerColor : null,
            ),
            onPressed: () {
              showOnlyFavorites = !showOnlyFavorites;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Banner
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(spMd),
              padding: EdgeInsets.all(spLg),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.flash_on,
                        color: Colors.yellow,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Lightning Deals",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Limited time offers with huge discounts",
                    style: TextStyle(
                      color: Colors.white.withAlpha(180),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${filteredDeals.length}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Active Deals",
                                style: TextStyle(
                                  color: Colors.white.withAlpha(200),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "\$${totalSavings.currency}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Your Savings",
                                style: TextStyle(
                                  color: Colors.white.withAlpha(200),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Filter Options
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Filter Deals",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Show favorites only",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  QHorizontalScroll(
                    children: filterOptions.map((option) {
                      bool isSelected = selectedFilter == option["value"];
                      return Container(
                        margin: EdgeInsets.only(right: spSm),
                        child: GestureDetector(
                          onTap: () {
                            selectedFilter = option["value"];
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : Colors.grey[100],
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              ),
                            ),
                            child: Text(
                              "${option["label"]}",
                              style: TextStyle(
                                color: isSelected ? Colors.white : disabledBoldColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Deals List
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${filteredDeals.length} Deals Available",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  ...filteredDeals.map((deal) {
                    double stockPercentage = ((deal["soldCount"] as int) / (deal["totalStock"] as int)) * 100;
                    double savedAmount = (deal["originalPrice"] as double) - (deal["salePrice"] as double);
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                        border: (deal["isLightningDeal"] as bool) 
                            ? Border.all(color: dangerColor.withAlpha(100), width: 2)
                            : null,
                      ),
                      child: Column(
                        children: [
                          // Image and Badge Section
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(radiusLg),
                                  topRight: Radius.circular(radiusLg),
                                ),
                                child: Image.network(
                                  "${deal["image"]}",
                                  height: 180,
                                  width: double.infinity,
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
                                    color: deal["color"] as Color,
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Text(
                                    "${deal["discountPercent"]}% OFF",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              
                              // Lightning Deal Badge
                              if (deal["isLightningDeal"] as bool)
                                Positioned(
                                  top: spSm,
                                  right: spSm,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: dangerColor,
                                      borderRadius: BorderRadius.circular(radiusLg),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.flash_on,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          "Lightning",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              
                              // Free Shipping Badge
                              if (deal["freeShipping"] as bool)
                                Positioned(
                                  bottom: spSm,
                                  left: spSm,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      borderRadius: BorderRadius.circular(radiusLg),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.local_shipping,
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "Free Ship",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              
                              // Favorite Button
                              Positioned(
                                bottom: spSm,
                                right: spSm,
                                child: GestureDetector(
                                  onTap: () {
                                    deal["isFavorite"] = !(deal["isFavorite"] as bool);
                                    setState(() {});
                                    ss(deal["isFavorite"] as bool 
                                        ? "Added to favorites" 
                                        : "Removed from favorites");
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withAlpha(200),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      deal["isFavorite"] as bool ? Icons.favorite : Icons.favorite_border,
                                      color: deal["isFavorite"] as bool ? dangerColor : disabledBoldColor,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          // Content Section
                          Padding(
                            padding: EdgeInsets.all(spMd),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Brand and Rating
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${deal["brand"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.orange,
                                          size: 16,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "${deal["rating"]} (${deal["reviewCount"]})",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                
                                SizedBox(height: spXs),
                                
                                // Title and Time Left
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${deal["title"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
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
                                          Icon(
                                            Icons.access_time,
                                            color: warningColor,
                                            size: 12,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            "${deal["timeLeft"]}",
                                            style: TextStyle(
                                              color: warningColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                
                                SizedBox(height: spXs),
                                
                                // Description
                                Text(
                                  "${deal["description"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                    height: 1.4,
                                  ),
                                ),
                                
                                SizedBox(height: spMd),
                                
                                // Prices
                                Row(
                                  children: [
                                    Text(
                                      "\$${((deal["originalPrice"] as double)).currency}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "\$${((deal["salePrice"] as double)).currency}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: deal["color"] as Color,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "Save \$${savedAmount.currency}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                
                                SizedBox(height: spMd),
                                
                                // Stock Progress
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          "${stockPercentage.toInt()}% claimed",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: stockPercentage > 70 ? dangerColor : disabledBoldColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spXs),
                                    LinearProgressIndicator(
                                      value: stockPercentage / 100,
                                      backgroundColor: Colors.grey[300],
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        stockPercentage > 80 ? dangerColor : 
                                        stockPercentage > 50 ? warningColor : successColor,
                                      ),
                                      minHeight: 6,
                                    ),
                                  ],
                                ),
                                
                                SizedBox(height: spMd),
                                
                                // Action Button
                                Container(
                                  width: double.infinity,
                                  child: QButton(
                                    label: "Shop Now",
                                    size: bs.md,
                                    onPressed: () {
                                      ss("Opening ${deal["title"]} deal...");
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
          ],
        ),
      ),
    );
  }
}
