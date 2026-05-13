import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPromo1View extends StatefulWidget {
  @override
  State<GrlPromo1View> createState() => _GrlPromo1ViewState();
}

class _GrlPromo1ViewState extends State<GrlPromo1View> {
  String selectedCategory = 'featured';
  
  List<Map<String, dynamic>> featuredPromos = [
    {
      "id": 1,
      "title": "Black Friday Bonanza",
      "subtitle": "Up to 80% Off Everything",
      "description": "The biggest sale of the year is here! Shop now and save on thousands of products across all categories.",
      "image": "https://picsum.photos/400/250?random=1&keyword=sale",
      "discount": "80% OFF",
      "validUntil": "3 days left",
      "color": primaryColor,
      "participants": 25600,
    },
    {
      "id": 2,
      "title": "Flash Weekend Sale",
      "subtitle": "Limited Time Only",
      "description": "Grab amazing deals before they're gone! Flash sales on selected items with unbeatable prices.",
      "image": "https://picsum.photos/400/250?random=2&keyword=flash",
      "discount": "60% OFF",
      "validUntil": "12 hours left",
      "color": dangerColor,
      "participants": 18900,
    },
    {
      "id": 3,
      "title": "New User Special",
      "subtitle": "Welcome Offer",
      "description": "First-time shopping? Enjoy exclusive discounts and free shipping on your first order.",
      "image": "https://picsum.photos/400/250?random=3&keyword=welcome",
      "discount": "50% OFF",
      "validUntil": "7 days left",
      "color": successColor,
      "participants": 8750,
    },
  ];

  List<Map<String, dynamic>> categoryPromos = [
    {
      "category": "Electronics",
      "icon": Icons.devices,
      "color": primaryColor,
      "totalDeals": 156,
      "bestDiscount": "70% OFF",
      "image": "https://picsum.photos/300/200?random=4&keyword=electronics",
      "description": "Latest gadgets at unbeatable prices",
    },
    {
      "category": "Fashion",
      "icon": Icons.checkroom,
      "color": warningColor,
      "totalDeals": 298,
      "bestDiscount": "65% OFF",
      "image": "https://picsum.photos/300/200?random=5&keyword=fashion",
      "description": "Trendy styles for every occasion",
    },
    {
      "category": "Home & Garden",
      "icon": Icons.home,
      "color": successColor,
      "totalDeals": 87,
      "bestDiscount": "55% OFF",
      "image": "https://picsum.photos/300/200?random=6&keyword=home",
      "description": "Transform your living space",
    },
    {
      "category": "Sports",
      "icon": Icons.sports,
      "color": infoColor,
      "totalDeals": 124,
      "bestDiscount": "60% OFF",
      "image": "https://picsum.photos/300/200?random=7&keyword=sports",
      "description": "Gear up for your active lifestyle",
    },
  ];

  List<Map<String, dynamic>> limitedTimeOffers = [
    {
      "title": "Lightning Deal",
      "product": "Wireless Headphones",
      "originalPrice": 299.99,
      "salePrice": 89.99,
      "discount": 70,
      "timeLeft": "2h 35m",
      "image": "https://picsum.photos/150/150?random=8&keyword=headphones",
      "claimed": 85,
      "total": 100,
    },
    {
      "title": "Daily Special",
      "product": "Smart Watch",
      "originalPrice": 449.99,
      "salePrice": 199.99,
      "discount": 56,
      "timeLeft": "5h 20m",
      "image": "https://picsum.photos/150/150?random=9&keyword=watch",
      "claimed": 67,
      "total": 150,
    },
    {
      "title": "Mega Offer",
      "product": "Laptop Backpack",
      "originalPrice": 89.99,
      "salePrice": 29.99,
      "discount": 67,
      "timeLeft": "8h 45m",
      "image": "https://picsum.photos/150/150?random=10&keyword=backpack",
      "claimed": 123,
      "total": 200,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Promotions"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Selector
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: [
                'featured', 'categories', 'limited'
              ].map((category) => Expanded(
                child: GestureDetector(
                  onTap: () {
                    selectedCategory = category;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    padding: EdgeInsets.symmetric(vertical: spSm),
                    decoration: BoxDecoration(
                      color: selectedCategory == category ? primaryColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      category == 'featured' ? 'Featured' :
                      category == 'categories' ? 'Categories' : 'Limited Time',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: selectedCategory == category ? Colors.white : primaryColor,
                      ),
                    ),
                  ),
                ),
              )).toList(),
            ),
          ),
          
          // Content
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigateTo(CreatePromoView());
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (selectedCategory) {
      case 'featured':
        return _buildFeaturedTab();
      case 'categories':
        return _buildCategoriesTab();
      case 'limited':
        return _buildLimitedTimeTab();
      default:
        return _buildFeaturedTab();
    }
  }

  Widget _buildFeaturedTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Promo
          Container(
            width: double.infinity,
            height: 200,
            margin: EdgeInsets.only(bottom: spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -30,
                  top: -30,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(20),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "🎉 Mega Sale Event",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Discover thousands of products at incredible prices",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: spMd),
                      QButton(
                        label: "Shop Now",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          Text(
            "Featured Promotions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          
          ...featuredPromos.map((promo) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusLg),
                    topRight: Radius.circular(radiusLg),
                  ),
                  child: Stack(
                    children: [
                      Image.network(
                        "${promo["image"]}",
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: spSm,
                        right: spSm,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: promo["color"] as Color,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${promo["discount"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: spSm,
                        left: spSm,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(150),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${promo["validUntil"]}",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${promo["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${promo["subtitle"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: promo["color"] as Color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${promo["description"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spMd),
                      Row(
                        children: [
                          Icon(
                            Icons.people,
                            size: 16,
                            color: primaryColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${(promo["participants"] as int)}+ joined",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          QButton(
                            label: "Join Now",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab() {
    return ResponsiveGridView(
      padding: EdgeInsets.all(spMd),
      minItemWidth: 200,
      children: categoryPromos.map((category) => Container(
        margin: EdgeInsets.only(bottom: spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          boxShadow: [shadowMd],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusLg),
                topRight: Radius.circular(radiusLg),
              ),
              child: Stack(
                children: [
                  Image.network(
                    "${category["image"]}",
                    width: double.infinity,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black.withAlpha(100)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: spSm,
                    left: spSm,
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: category["color"] as Color,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            category["icon"] as IconData,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${category["category"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${category["description"]}",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Text(
                        "Up to ${category["bestDiscount"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: category["color"] as Color,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${category["totalDeals"]} deals",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Explore Deals",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildLimitedTimeTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timer Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [dangerColor, dangerColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.flash_on,
                  color: Colors.white,
                  size: 32,
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Lightning Deals",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Limited time offers - Grab them fast!",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          Text(
            "Today's Special Offers",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          SizedBox(height: spMd),
          
          ...limitedTimeOffers.map((offer) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Padding(
              padding: EdgeInsets.all(spMd),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusLg),
                    child: Image.network(
                      "${offer["image"]}",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${offer["title"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: dangerColor,
                            ),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${offer["product"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "\$${(offer["salePrice"] as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "\$${(offer["originalPrice"] as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 14,
                              color: dangerColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${offer["timeLeft"]} left",
                              style: TextStyle(
                                fontSize: 12,
                                color: dangerColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        LinearProgressIndicator(
                          value: (offer["claimed"] as int) / (offer["total"] as int),
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(dangerColor),
                          minHeight: 4,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${offer["claimed"]}/${offer["total"]} claimed",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: spMd),
                  QButton(
                    label: "Grab Deal",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          )).toList(),
        ],
      ),
    );
  }
}
