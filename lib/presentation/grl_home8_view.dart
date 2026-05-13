import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHome8View extends StatefulWidget {
  @override
  State<GrlHome8View> createState() => _GrlHome8ViewState();
}

class _GrlHome8ViewState extends State<GrlHome8View> {
  String searchQuery = "";
  int selectedFilter = 0;
  
  final List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "all"},
    {"label": "Properties", "value": "properties"},
    {"label": "Vehicles", "value": "vehicles"},
    {"label": "Electronics", "value": "electronics"},
  ];

  final List<Map<String, dynamic>> featuredListings = [
    {
      "id": 1,
      "title": "Modern Downtown Apartment",
      "description": "2BR/2BA luxury apartment in city center",
      "price": 2500.00,
      "location": "Downtown District",
      "type": "Apartment",
      "category": "Properties",
      "image": "https://picsum.photos/300/200?random=1&keyword=apartment",
      "rating": 4.8,
      "reviews": 245,
      "features": ["Furnished", "Parking", "Gym", "Pool"],
      "isVerified": true,
      "isFeatured": true,
      "postedDate": "2024-01-15",
    },
    {
      "id": 2,
      "title": "2018 Tesla Model 3",
      "description": "Electric vehicle in excellent condition",
      "price": 35000.00,
      "location": "Suburban Area",
      "type": "Car",
      "category": "Vehicles",
      "image": "https://picsum.photos/300/200?random=2&keyword=tesla",
      "rating": 4.9,
      "reviews": 89,
      "features": ["Autopilot", "Full Charge", "Clean Title", "Low Miles"],
      "isVerified": true,
      "isFeatured": false,
      "postedDate": "2024-01-18",
    },
    {
      "id": 3,
      "title": "MacBook Pro 16-inch",
      "description": "Latest model with M2 chip, 32GB RAM",
      "price": 2899.00,
      "location": "Tech District",
      "type": "Laptop",
      "category": "Electronics",
      "image": "https://picsum.photos/300/200?random=3&keyword=macbook",
      "rating": 4.7,
      "reviews": 156,
      "features": ["M2 Chip", "32GB RAM", "1TB SSD", "Warranty"],
      "isVerified": true,
      "isFeatured": true,
      "postedDate": "2024-01-20",
    },
    {
      "id": 4,
      "title": "Cozy Studio Near Beach",
      "description": "Perfect vacation rental with ocean view",
      "price": 89.00,
      "location": "Beachfront",
      "type": "Studio",
      "category": "Properties",
      "image": "https://picsum.photos/300/200?random=4&keyword=beach-studio",
      "rating": 4.6,
      "reviews": 78,
      "features": ["Ocean View", "WiFi", "Kitchen", "Balcony"],
      "isVerified": false,
      "isFeatured": false,
      "postedDate": "2024-01-22",
    },
  ];

  final List<Map<String, dynamic>> categories = [
    {
      "name": "Real Estate",
      "icon": Icons.home,
      "color": primaryColor,
      "itemCount": 1245,
      "subtitle": "Houses, apartments, land",
    },
    {
      "name": "Vehicles",
      "icon": Icons.directions_car,
      "color": infoColor,
      "itemCount": 567,
      "subtitle": "Cars, bikes, boats",
    },
    {
      "name": "Electronics",
      "icon": Icons.devices,
      "color": warningColor,
      "itemCount": 789,
      "subtitle": "Phones, laptops, gadgets",
    },
    {
      "name": "Furniture",
      "icon": Icons.weekend,
      "color": successColor,
      "itemCount": 345,
      "subtitle": "Home & office furniture",
    },
    {
      "name": "Fashion",
      "icon": Icons.checkroom,
      "color": dangerColor,
      "itemCount": 456,
      "subtitle": "Clothing, accessories",
    },
    {
      "name": "Sports",
      "icon": Icons.sports_soccer,
      "color": infoColor,
      "itemCount": 234,
      "subtitle": "Equipment, gear",
    },
  ];

  final List<Map<String, dynamic>> recentActivity = [
    {
      "action": "New listing posted",
      "title": "Vintage Guitar Collection",
      "location": "Music District",
      "time": "2 hours ago",
      "type": "Musical Instruments",
      "price": 1250.00,
    },
    {
      "action": "Price reduced",
      "title": "Gaming Setup Complete",
      "location": "Tech Area",
      "time": "4 hours ago",
      "type": "Electronics",
      "price": 899.00,
    },
    {
      "action": "New listing posted",
      "title": "Luxury Watch Collection",
      "location": "Business District",
      "time": "6 hours ago",
      "type": "Accessories",
      "price": 5600.00,
    },
  ];

  final List<Map<String, dynamic>> trendingSearches = [
    {"term": "iPhone 15", "count": 2341},
    {"term": "Apartment rental", "count": 1876},
    {"term": "Gaming laptop", "count": 1234},
    {"term": "Electric bike", "count": 987},
    {"term": "Office chair", "count": 765},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Marketplace"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [infoColor, infoColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Buy & Sell Anything",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Find great deals or sell your items quickly",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(220),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.storefront,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      QButton(
                        label: "Start Selling",
                        color: Colors.white,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Browse Items",
                        color: Colors.white.withAlpha(100),
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search for anything...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
                SizedBox(width: spXs),
                QButton(
                  icon: Icons.tune,
                  color: infoColor,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            // Categories Filter
            Text(
              "Browse Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QCategoryPicker(
              items: filterOptions,
              value: filterOptions[selectedFilter]["value"],
              onChanged: (index, label, value, item) {
                selectedFilter = index;
                setState(() {});
              },
            ),

            // Main Categories Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 160,
              children: categories.map((category) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: (category["color"] as Color).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              category["icon"] as IconData,
                              size: 24,
                              color: category["color"] as Color,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      Text(
                        "${category["name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${category["subtitle"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${category["itemCount"]} items",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Featured Listings
            Row(
              children: [
                Text(
                  "Featured Listings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Column(
              spacing: spSm,
              children: featuredListings.map((listing) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                            child: Image.network(
                              "${listing["image"]}",
                              width: double.infinity,
                              height: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                          if (listing["isFeatured"] as bool)
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "FEATURED",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          if (listing["isVerified"] as bool)
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Icon(
                                  Icons.verified,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          Positioned(
                            bottom: spSm,
                            right: spSm,
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(230),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Icon(
                                Icons.favorite_border,
                                size: 18,
                                color: dangerColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${listing["type"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                if ((listing["reviews"] as int) > 0)
                                  Row(
                                    spacing: 2,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 12,
                                        color: warningColor,
                                      ),
                                      Text(
                                        "${(listing["rating"] as num).toStringAsFixed(1)}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "(${listing["reviews"]})",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledColor,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                            Text(
                              "${listing["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "${listing["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 12,
                                  color: disabledColor,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${listing["location"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${listing["postedDate"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (listing["features"] as List<String>).take(3).map((feature) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    feature,
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w600,
                                      color: infoColor,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "\$${((listing["price"] as num).toDouble()).currency}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                QButton(
                                  label: "Contact Seller",
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
                );
              }).toList(),
            ),

            // Trending Searches
            Row(
              children: [
                Text(
                  "Trending Searches",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
              ],
            ),
            Column(
              spacing: spXs,
              children: trendingSearches.map((search) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: disabledColor.withAlpha(100)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.trending_up,
                        size: 16,
                        color: successColor,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${search["term"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "${search["count"]} searches",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Recent Activity
            Row(
              children: [
                Text(
                  "Recent Activity",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
              ],
            ),
            Column(
              spacing: spSm,
              children: recentActivity.map((activity) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.fiber_new,
                          size: 20,
                          color: infoColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${activity["action"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${activity["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "${activity["location"]} • ${activity["time"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "\$${((activity["price"] as num).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
