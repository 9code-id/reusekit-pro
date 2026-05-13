import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaNewRestaurantsView extends StatefulWidget {
  const FdaNewRestaurantsView({super.key});

  @override
  State<FdaNewRestaurantsView> createState() => _FdaNewRestaurantsViewState();
}

class _FdaNewRestaurantsViewState extends State<FdaNewRestaurantsView> {
  String selectedFilter = "This Week";
  String searchQuery = "";

  List<Map<String, dynamic>> filterOptions = [
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "Last 3 Months", "value": "3months"},
  ];

  List<Map<String, dynamic>> newRestaurants = [
    {
      "id": "1",
      "name": "Urban Bites",
      "category": "International Fusion",
      "image": "https://picsum.photos/300/200?random=101&keyword=restaurant",
      "rating": 0.0,
      "reviews": 0,
      "deliveryTime": "25-35 min",
      "deliveryFee": 2.99,
      "distance": 1.5,
      "openedDate": "2024-06-10",
      "isGrandOpening": true,
      "cuisines": ["Fusion", "International"],
      "priceRange": "\$\$\$",
      "specialOffer": "50% off on first 100 orders",
      "badges": ["New", "Grand Opening"],
      "description": "Experience unique fusion flavors in our brand new location"
    },
    {
      "id": "2",
      "name": "Artisan Coffee & Brunch",
      "category": "Cafe & Breakfast",
      "image": "https://picsum.photos/300/200?random=102&keyword=coffee",
      "rating": 4.2,
      "reviews": 23,
      "deliveryTime": "15-25 min",
      "deliveryFee": 1.99,
      "distance": 0.8,
      "openedDate": "2024-06-08",
      "isGrandOpening": false,
      "cuisines": ["Coffee", "Breakfast", "Brunch"],
      "priceRange": "\$\$",
      "specialOffer": "Free coffee with any breakfast order",
      "badges": ["New", "Trending"],
      "description": "Handcrafted coffee and artisan breakfast items"
    },
    {
      "id": "3",
      "name": "Spice Route Indian",
      "category": "Indian Cuisine",
      "image": "https://picsum.photos/300/200?random=103&keyword=indian",
      "rating": 4.5,
      "reviews": 47,
      "deliveryTime": "30-40 min",
      "deliveryFee": 3.49,
      "distance": 2.2,
      "openedDate": "2024-06-05",
      "isGrandOpening": true,
      "cuisines": ["Indian", "Curry", "Vegetarian"],
      "priceRange": "\$\$",
      "specialOffer": "Free appetizer with orders over \$25",
      "badges": ["New", "Authentic", "Vegetarian Friendly"],
      "description": "Authentic Indian spices and traditional recipes"
    },
    {
      "id": "4",
      "name": "Green Bowl Co.",
      "category": "Healthy & Organic",
      "image": "https://picsum.photos/300/200?random=104&keyword=salad",
      "rating": 4.7,
      "reviews": 89,
      "deliveryTime": "20-30 min",
      "deliveryFee": 2.49,
      "distance": 1.1,
      "openedDate": "2024-05-28",
      "isGrandOpening": false,
      "cuisines": ["Healthy", "Salads", "Smoothies"],
      "priceRange": "\$\$",
      "specialOffer": "Buy 2 bowls, get 1 smoothie free",
      "badges": ["New", "Healthy", "Organic"],
      "description": "Fresh, organic ingredients in every bowl"
    },
    {
      "id": "5",
      "name": "Noodle Master",
      "category": "Asian Noodles",
      "image": "https://picsum.photos/300/200?random=105&keyword=noodles",
      "rating": 4.3,
      "reviews": 156,
      "deliveryTime": "25-35 min",
      "deliveryFee": 2.99,
      "distance": 1.8,
      "openedDate": "2024-05-15",
      "isGrandOpening": false,
      "cuisines": ["Asian", "Noodles", "Ramen"],
      "priceRange": "\$\$",
      "specialOffer": "Free gyoza with any ramen order",
      "badges": ["New", "Popular"],
      "description": "Hand-pulled noodles and authentic Asian flavors"
    },
    {
      "id": "6",
      "name": "Burger Craft",
      "category": "Gourmet Burgers",
      "image": "https://picsum.photos/300/200?random=106&keyword=gourmet",
      "rating": 4.1,
      "reviews": 67,
      "deliveryTime": "30-40 min",
      "deliveryFee": 3.99,
      "distance": 2.5,
      "openedDate": "2024-05-10",
      "isGrandOpening": false,
      "cuisines": ["American", "Burgers", "Gourmet"],
      "priceRange": "\$\$\$",
      "specialOffer": "Free fries with premium burger combo",
      "badges": ["New", "Gourmet"],
      "description": "Premium ingredients, artisan-crafted burgers"
    }
  ];

  List<Map<String, dynamic>> get filteredRestaurants {
    var filtered = newRestaurants.where((restaurant) {
      bool matchesSearch = searchQuery.isEmpty || 
        "${restaurant["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${restaurant["category"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        (restaurant["cuisines"] as List).any((cuisine) => 
          "$cuisine".toLowerCase().contains(searchQuery.toLowerCase()));
      return matchesSearch;
    }).toList();
    
    // Sort by opening date (newest first)
    filtered.sort((a, b) => 
      DateTime.parse("${b["openedDate"]}").compareTo(DateTime.parse("${a["openedDate"]}")));
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Restaurants"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notification settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search new restaurants",
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
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Welcome Banner
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.new_releases,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Discover New Flavors",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Fresh restaurants joining our platform",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Filter Options
            QCategoryPicker(
              label: "Filter by Period",
              items: filterOptions,
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = label;
                setState(() {});
              },
            ),
            
            SizedBox(height: spLg),
            
            // Stats Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${newRestaurants.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "New This Month",
                          style: TextStyle(
                            color: disabledBoldColor,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${newRestaurants.where((r) => r["isGrandOpening"] as bool).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Grand Openings",
                          style: TextStyle(
                            color: disabledBoldColor,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${newRestaurants.where((r) => (r["specialOffer"] as String).isNotEmpty).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Special Offers",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Results Header
            Text(
              "${filteredRestaurants.length} New Restaurants",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            SizedBox(height: spSm),
            
            // Restaurant List
            ...filteredRestaurants.map((restaurant) {
              bool hasGrandOpening = restaurant["isGrandOpening"] as bool;
              bool hasSpecialOffer = (restaurant["specialOffer"] as String).isNotEmpty;
              DateTime openedDate = DateTime.parse("${restaurant["openedDate"]}");
              int daysAgo = DateTime.now().difference(openedDate).inDays;
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: hasGrandOpening 
                    ? Border.all(color: warningColor.withAlpha(100), width: 2)
                    : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Restaurant Image
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(radiusMd),
                          ),
                          child: Image.network(
                            "${restaurant["image"]}",
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (hasGrandOpening)
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: warningColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "GRAND OPENING",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        Positioned(
                          top: spSm,
                          right: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "NEW",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: spSm,
                          right: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(150),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${daysAgo == 0 ? 'Today' : '$daysAgo days ago'}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    // Restaurant Info
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${restaurant["name"]}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              if ((restaurant["rating"] as double) > 0)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        "${restaurant["rating"]}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              else
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: disabledColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "New",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          
                          SizedBox(height: spXs),
                          
                          Text(
                            "${restaurant["category"]}",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          
                          SizedBox(height: spXs),
                          
                          Text(
                            "${restaurant["description"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                          
                          SizedBox(height: spSm),
                          
                          Row(
                            children: [
                              Text(
                                "${restaurant["priceRange"]}",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                Icons.access_time,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: 2),
                              Text(
                                "${restaurant["deliveryTime"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                Icons.delivery_dining,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: 2),
                              Text(
                                "\$${(restaurant["deliveryFee"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Badges
                          QHorizontalScroll(
                            children: (restaurant["badges"] as List).map((badge) {
                              Color badgeColor = badge == "New" ? primaryColor :
                                              badge == "Grand Opening" ? warningColor :
                                              badge == "Trending" ? infoColor :
                                              badge == "Popular" ? successColor :
                                              disabledBoldColor;
                              
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: badgeColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "$badge",
                                  style: TextStyle(
                                    color: badgeColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          
                          if (hasSpecialOffer) ...[
                            SizedBox(height: spSm),
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.local_offer,
                                    size: 14,
                                    color: successColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "${restaurant["specialOffer"]}",
                                      style: TextStyle(
                                        color: successColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          
                          SizedBox(height: spSm),
                          
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Explore Menu",
                                  size: bs.sm,
                                  onPressed: () {},
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
            }).toList(),
            
            SizedBox(height: spLg),
            
            // Notification Settings
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.notifications_active,
                        color: infoColor,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Stay Updated",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Get notified when new restaurants join our platform in your area",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Enable Notifications",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
