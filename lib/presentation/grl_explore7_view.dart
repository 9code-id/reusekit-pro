import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlExplore7View extends StatefulWidget {
  @override
  State<GrlExplore7View> createState() => _GrlExplore7ViewState();
}

class _GrlExplore7ViewState extends State<GrlExplore7View> {
  String searchQuery = "";
  String selectedCuisine = "All Cuisines";
  String selectedPriceRange = "All Prices";
  String selectedRating = "All Ratings";
  String selectedDistance = "Any Distance";
  bool isOpenNow = false;
  
  List<Map<String, dynamic>> cuisineOptions = [
    {"label": "All Cuisines", "value": "All Cuisines"},
    {"label": "Italian", "value": "Italian"},
    {"label": "Asian", "value": "Asian"},
    {"label": "Mexican", "value": "Mexican"},
    {"label": "American", "value": "American"},
    {"label": "French", "value": "French"},
    {"label": "Indian", "value": "Indian"},
    {"label": "Mediterranean", "value": "Mediterranean"},
  ];
  
  List<Map<String, dynamic>> priceOptions = [
    {"label": "All Prices", "value": "All Prices"},
    {"label": "\$ - Budget", "value": "Budget"},
    {"label": "\$\$ - Moderate", "value": "Moderate"},
    {"label": "\$\$\$ - Expensive", "value": "Expensive"},
    {"label": "\$\$\$\$ - Fine Dining", "value": "Fine Dining"},
  ];
  
  List<Map<String, dynamic>> ratingOptions = [
    {"label": "All Ratings", "value": "All Ratings"},
    {"label": "4.5+ Stars", "value": "4.5+"},
    {"label": "4.0+ Stars", "value": "4.0+"},
    {"label": "3.5+ Stars", "value": "3.5+"},
    {"label": "3.0+ Stars", "value": "3.0+"},
  ];
  
  List<Map<String, dynamic>> distanceOptions = [
    {"label": "Any Distance", "value": "Any Distance"},
    {"label": "Within 1 mile", "value": "1 mile"},
    {"label": "Within 5 miles", "value": "5 miles"},
    {"label": "Within 10 miles", "value": "10 miles"},
    {"label": "Within 25 miles", "value": "25 miles"},
  ];
  
  List<Map<String, dynamic>> restaurants = [
    {
      "id": 1,
      "name": "Bella Vista",
      "cuisine": "Italian",
      "rating": 4.8,
      "reviews": 1247,
      "priceRange": "Expensive",
      "priceSymbol": "\$\$\$",
      "distance": "0.8 miles",
      "estimatedTime": "25-35 min",
      "address": "123 Main St, Downtown",
      "phone": "(555) 123-4567",
      "image": "https://picsum.photos/400/250?random=1&keyword=italian",
      "isOpen": true,
      "openUntil": "10:00 PM",
      "specialties": ["Pasta", "Pizza", "Wine"],
      "features": ["Outdoor Seating", "Delivery", "Reservations"],
      "avgDeliveryTime": 30,
      "deliveryFee": 3.99,
      "isPopular": true,
      "discount": "20% off first order",
    },
    {
      "id": 2,
      "name": "Sakura Sushi",
      "cuisine": "Asian",
      "rating": 4.6,
      "reviews": 892,
      "priceRange": "Moderate",
      "priceSymbol": "\$\$",
      "distance": "1.2 miles",
      "estimatedTime": "20-30 min",
      "address": "456 Oak Ave, Midtown",
      "phone": "(555) 234-5678",
      "image": "https://picsum.photos/400/250?random=2&keyword=sushi",
      "isOpen": true,
      "openUntil": "9:30 PM",
      "specialties": ["Sushi", "Ramen", "Tempura"],
      "features": ["Fresh Fish", "Chef's Special", "Sake Bar"],
      "avgDeliveryTime": 25,
      "deliveryFee": 2.99,
      "isPopular": false,
      "discount": null,
    },
    {
      "id": 3,
      "name": "Taco Libre",
      "cuisine": "Mexican",
      "rating": 4.4,
      "reviews": 1534,
      "priceRange": "Budget",
      "priceSymbol": "\$",
      "distance": "0.5 miles",
      "estimatedTime": "15-25 min",
      "address": "789 Elm St, Westside",
      "phone": "(555) 345-6789",
      "image": "https://picsum.photos/400/250?random=3&keyword=tacos",
      "isOpen": true,
      "openUntil": "11:00 PM",
      "specialties": ["Tacos", "Burritos", "Margaritas"],
      "features": ["Late Night", "Vegetarian Options", "Catering"],
      "avgDeliveryTime": 20,
      "deliveryFee": 1.99,
      "isPopular": true,
      "discount": "Free delivery on \$25+",
    },
    {
      "id": 4,
      "name": "The Golden Spoon",
      "cuisine": "American",
      "rating": 4.7,
      "reviews": 967,
      "priceRange": "Moderate",
      "priceSymbol": "\$\$",
      "distance": "2.1 miles",
      "estimatedTime": "30-40 min",
      "address": "321 Pine Rd, Uptown",
      "phone": "(555) 456-7890",
      "image": "https://picsum.photos/400/250?random=4&keyword=american",
      "isOpen": false,
      "openUntil": "Closed",
      "specialties": ["Burgers", "Steaks", "Craft Beer"],
      "features": ["Sports Bar", "Happy Hour", "Private Dining"],
      "avgDeliveryTime": 35,
      "deliveryFee": 4.99,
      "isPopular": false,
      "discount": null,
    },
    {
      "id": 5,
      "name": "Le Petit Café",
      "cuisine": "French",
      "rating": 4.9,
      "reviews": 543,
      "priceRange": "Fine Dining",
      "priceSymbol": "\$\$\$\$",
      "distance": "3.2 miles",
      "estimatedTime": "45-55 min",
      "address": "567 Maple Ave, Heritage District",
      "phone": "(555) 567-8901",
      "image": "https://picsum.photos/400/250?random=5&keyword=french",
      "isOpen": true,
      "openUntil": "10:30 PM",
      "specialties": ["French Cuisine", "Wine Pairing", "Desserts"],
      "features": ["Fine Dining", "Sommelier", "Prix Fixe Menu"],
      "avgDeliveryTime": 50,
      "deliveryFee": 6.99,
      "isPopular": true,
      "discount": null,
    },
    {
      "id": 6,
      "name": "Spice Palace",
      "cuisine": "Indian",
      "rating": 4.5,
      "reviews": 1123,
      "priceRange": "Moderate",
      "priceSymbol": "\$\$",
      "distance": "1.8 miles",
      "estimatedTime": "25-35 min",
      "address": "890 Cedar St, Little India",
      "phone": "(555) 678-9012",
      "image": "https://picsum.photos/400/250?random=6&keyword=indian",
      "isOpen": true,
      "openUntil": "9:45 PM",
      "specialties": ["Curry", "Tandoor", "Naan"],
      "features": ["Halal", "Vegetarian", "Spice Levels"],
      "avgDeliveryTime": 30,
      "deliveryFee": 3.49,
      "isPopular": false,
      "discount": "15% off lunch menu",
    },
  ];
  
  List<Map<String, dynamic>> get filteredRestaurants {
    return restaurants.where((restaurant) {
      bool matchesSearch = restaurant["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          restaurant["cuisine"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCuisine = selectedCuisine == "All Cuisines" || restaurant["cuisine"] == selectedCuisine;
      bool matchesPrice = selectedPriceRange == "All Prices" || restaurant["priceRange"] == selectedPriceRange;
      bool matchesOpen = !isOpenNow || restaurant["isOpen"];
      
      return matchesSearch && matchesCuisine && matchesPrice && matchesOpen;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Explorer"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_border),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Info Banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(40),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.delivery_dining,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Delivering to Downtown",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "123 Main Street • Change",
                          style: TextStyle(
                            color: Colors.white.withAlpha(220),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Search Bar
            QTextField(
              label: "Search restaurants, cuisines...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spLg),
            
            // Quick Filters
            Text(
              "Quick Filters",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            QHorizontalScroll(
              children: [
                _buildQuickFilter("Fast Delivery", Icons.timer, Colors.green),
                _buildQuickFilter("Top Rated", Icons.star, Colors.orange),
                _buildQuickFilter("Free Delivery", Icons.local_shipping, Colors.blue),
                _buildQuickFilter("New", Icons.fiber_new, Colors.purple),
                _buildQuickFilter("Offers", Icons.local_offer, Colors.red),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Filter Options
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Cuisine",
                    items: cuisineOptions,
                    value: selectedCuisine,
                    onChanged: (value, label) {
                      selectedCuisine = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Price",
                    items: priceOptions,
                    value: selectedPriceRange,
                    onChanged: (value, label) {
                      selectedPriceRange = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Open Now Toggle
            Row(
              children: [
                Text(
                  "Show only restaurants open now",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Switch(
                  value: isOpenNow,
                  onChanged: (value) {
                    isOpenNow = value;
                    setState(() {});
                  },
                  activeColor: primaryColor,
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Results Header
            Row(
              children: [
                Text(
                  "${filteredRestaurants.length} Restaurants",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Text(
                        "Sort",
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Icon(
                        Icons.tune,
                        color: secondaryColor,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Restaurant List
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredRestaurants.length,
              itemBuilder: (context, index) {
                final restaurant = filteredRestaurants[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Restaurant Image with Badges
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(radiusMd),
                            ),
                            child: Image.network(
                              "${restaurant["image"]}",
                              width: double.infinity,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                          
                          // Status Badge
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: restaurant["isOpen"] ? successColor : dangerColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                restaurant["isOpen"] ? "Open" : "Closed",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          
                          // Popular Badge
                          if (restaurant["isPopular"])
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "Popular",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          
                          // Discount Badge
                          if (restaurant["discount"] != null)
                            Positioned(
                              bottom: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: dangerColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${restaurant["discount"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      
                      // Restaurant Details
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Name and Rating
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${restaurant["name"]}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${restaurant["cuisine"]} • ${restaurant["priceSymbol"]}",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: warningColor,
                                        size: 14,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${restaurant["rating"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Delivery Info
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${restaurant["estimatedTime"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Icon(
                                  Icons.local_shipping,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "\$${restaurant["deliveryFee"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${restaurant["distance"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Specialties
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (restaurant["specialties"] as List).take(3).map((specialty) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: secondaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    border: Border.all(
                                      color: secondaryColor.withAlpha(50),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    "$specialty",
                                    style: TextStyle(
                                      color: secondaryColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            
                            SizedBox(height: spMd),
                            
                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "Order Now",
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(width: spSm),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: disabledOutlineBorderColor,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: disabledOutlineBorderColor,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Icon(
                                      Icons.info_outline,
                                      color: primaryColor,
                                      size: 20,
                                    ),
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
              },
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildQuickFilter(String label, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(right: spSm),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: spSm,
            vertical: spSm,
          ),
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(
              color: color.withAlpha(50),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: color,
              ),
              SizedBox(width: spXs),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
