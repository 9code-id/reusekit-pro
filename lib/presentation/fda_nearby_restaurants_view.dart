import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaNearbyRestaurantsView extends StatefulWidget {
  const FdaNearbyRestaurantsView({super.key});

  @override
  State<FdaNearbyRestaurantsView> createState() => _FdaNearbyRestaurantsViewState();
}

class _FdaNearbyRestaurantsViewState extends State<FdaNearbyRestaurantsView> {
  String sortBy = "distance";
  String selectedRadius = "2 km";
  bool isMapView = false;
  String searchQuery = "";

  List<Map<String, dynamic>> radiusOptions = [
    {"label": "1 km", "value": "1"},
    {"label": "2 km", "value": "2"},
    {"label": "5 km", "value": "5"},
    {"label": "10 km", "value": "10"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Nearest First", "value": "distance"},
    {"label": "Fastest Delivery", "value": "delivery_time"},
    {"label": "Highest Rated", "value": "rating"},
    {"label": "Most Popular", "value": "popularity"},
  ];

  List<Map<String, dynamic>> nearbyRestaurants = [
    {
      "id": "1",
      "name": "Corner Deli",
      "category": "Sandwiches & Deli",
      "image": "https://picsum.photos/300/200?random=201&keyword=deli",
      "rating": 4.3,
      "reviews": 487,
      "deliveryTime": "10-15 min",
      "deliveryFee": 1.99,
      "distance": 0.3,
      "latitude": 37.7749,
      "longitude": -122.4194,
      "isOpen": true,
      "cuisines": ["American", "Sandwiches"],
      "priceRange": "\$",
      "walkingTime": "4 min walk",
      "offers": ["Free delivery on orders over \$15"]
    },
    {
      "id": "2",
      "name": "Local Coffee House",
      "category": "Coffee & Pastries",
      "image": "https://picsum.photos/300/200?random=202&keyword=coffee",
      "rating": 4.6,
      "reviews": 234,
      "deliveryTime": "5-12 min",
      "deliveryFee": 0.99,
      "distance": 0.5,
      "latitude": 37.7751,
      "longitude": -122.4181,
      "isOpen": true,
      "cuisines": ["Coffee", "Pastries", "Breakfast"],
      "priceRange": "\$",
      "walkingTime": "6 min walk",
      "offers": ["Buy 2 coffees, get 1 free pastry"]
    },
    {
      "id": "3",
      "name": "Neighborhood Pizza",
      "category": "Pizza & Italian",
      "image": "https://picsum.photos/300/200?random=203&keyword=pizza",
      "rating": 4.4,
      "reviews": 892,
      "deliveryTime": "15-25 min",
      "deliveryFee": 2.49,
      "distance": 0.8,
      "latitude": 37.7745,
      "longitude": -122.4205,
      "isOpen": true,
      "cuisines": ["Italian", "Pizza"],
      "priceRange": "\$\$",
      "walkingTime": "10 min walk",
      "offers": ["20% off orders over \$30"]
    },
    {
      "id": "4",
      "name": "Fresh Salad Bar",
      "category": "Healthy & Salads",
      "image": "https://picsum.photos/300/200?random=204&keyword=salad",
      "rating": 4.7,
      "reviews": 156,
      "deliveryTime": "12-18 min",
      "deliveryFee": 1.49,
      "distance": 1.1,
      "latitude": 37.7755,
      "longitude": -122.4175,
      "isOpen": true,
      "cuisines": ["Healthy", "Salads", "Wraps"],
      "priceRange": "\$\$",
      "walkingTime": "14 min walk",
      "offers": ["Free drink with any salad"]
    },
    {
      "id": "5",
      "name": "Taco Express",
      "category": "Mexican Food",
      "image": "https://picsum.photos/300/200?random=205&keyword=tacos",
      "rating": 4.2,
      "reviews": 678,
      "deliveryTime": "18-25 min",
      "deliveryFee": 2.99,
      "distance": 1.4,
      "latitude": 37.7742,
      "longitude": -122.4212,
      "isOpen": true,
      "cuisines": ["Mexican", "Tacos"],
      "priceRange": "\$",
      "walkingTime": "17 min walk",
      "offers": ["Free chips and salsa"]
    },
    {
      "id": "6",
      "name": "Asia Kitchen",
      "category": "Asian Fusion",
      "image": "https://picsum.photos/300/200?random=206&keyword=asian",
      "rating": 4.5,
      "reviews": 543,
      "deliveryTime": "20-30 min",
      "deliveryFee": 3.49,
      "distance": 1.8,
      "latitude": 37.7760,
      "longitude": -122.4160,
      "isOpen": false,
      "cuisines": ["Asian", "Chinese", "Thai"],
      "priceRange": "\$\$\$",
      "walkingTime": "22 min walk",
      "offers": ["15% off first order"]
    }
  ];

  List<Map<String, dynamic>> get filteredRestaurants {
    var filtered = nearbyRestaurants.where((restaurant) {
      double maxDistance = double.parse(selectedRadius.split(" ")[0]);
      bool withinRadius = (restaurant["distance"] as double) <= maxDistance;
      bool matchesSearch = searchQuery.isEmpty || 
        "${restaurant["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${restaurant["category"]}".toLowerCase().contains(searchQuery.toLowerCase());
      return withinRadius && matchesSearch;
    }).toList();
    
    // Sort restaurants
    filtered.sort((a, b) {
      switch (sortBy) {
        case "delivery_time":
          String aTime = "${a["deliveryTime"]}".split("-")[0];
          String bTime = "${b["deliveryTime"]}".split("-")[0];
          return int.parse(aTime).compareTo(int.parse(bTime));
        case "rating":
          return (b["rating"] as double).compareTo(a["rating"] as double);
        case "popularity":
          return (b["reviews"] as int).compareTo(a["reviews"] as int);
        default: // distance
          return (a["distance"] as double).compareTo(b["distance"] as double);
      }
    });
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nearby Restaurants"),
        actions: [
          IconButton(
            icon: Icon(isMapView ? Icons.list : Icons.map),
            onPressed: () {
              isMapView = !isMapView;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              // Refresh location
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
                    label: "Search nearby restaurants",
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
            
            // Location Info
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: primaryColor,
                    size: 32,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Location",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "123 Main Street, Downtown",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Change location
                    },
                    child: Text(
                      "Change",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Filter Row
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Search Radius",
                    items: radiusOptions,
                    value: selectedRadius,
                    onChanged: (value, label) {
                      selectedRadius = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Sort By",
                    items: sortOptions,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Quick Stats
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
                          "${filteredRestaurants.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Nearby",
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
                          "${filteredRestaurants.where((r) => r["isOpen"] as bool).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Open Now",
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
                          "${filteredRestaurants.isNotEmpty ? (filteredRestaurants.map((r) => r["distance"] as double).reduce((a, b) => a < b ? a : b)).toStringAsFixed(1) : '0'}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Closest (km)",
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
              "Restaurants Near You",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            // Restaurant List
            ...filteredRestaurants.map((restaurant) {
              bool isOpen = restaurant["isOpen"] as bool;
              double distance = restaurant["distance"] as double;
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: !isOpen 
                    ? Border.all(color: disabledColor.withAlpha(100))
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
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (!isOpen)
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(radiusMd),
                                ),
                              ),
                              child: Center(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "CLOSED",
                                    style: TextStyle(
                                      color: dangerColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        Positioned(
                          top: spSm,
                          left: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 12,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${distance.toStringAsFixed(1)} km",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (isOpen)
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "OPEN",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
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
                                    color: isOpen ? null : disabledBoldColor,
                                  ),
                                ),
                              ),
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
                          
                          Row(
                            children: [
                              Icon(
                                Icons.directions_walk,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${restaurant["walkingTime"]}",
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
                              SizedBox(width: 4),
                              Text(
                                "${restaurant["deliveryTime"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spXs),
                          
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
                              Text(
                                "Delivery: \$${(restaurant["deliveryFee"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "(${restaurant["reviews"]} reviews)",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          
                          if ((restaurant["offers"] as List).isNotEmpty) ...[
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
                                      "${(restaurant["offers"] as List)[0]}",
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
                                  label: isOpen ? "Order Now" : "View Menu",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.directions,
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
            
            if (filteredRestaurants.isEmpty) ...[
              SizedBox(height: spXl),
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.location_off,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No restaurants found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try expanding your search radius",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
