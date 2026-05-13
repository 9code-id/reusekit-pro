import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaRestaurantSearchView extends StatefulWidget {
  const TtaRestaurantSearchView({super.key});

  @override
  State<TtaRestaurantSearchView> createState() => _TtaRestaurantSearchViewState();
}

class _TtaRestaurantSearchViewState extends State<TtaRestaurantSearchView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedLocation = "All Locations";
  String selectedPriceRange = "All Prices";
  String selectedRating = "All Ratings";
  bool isListView = false;

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Fine Dining", "value": "Fine Dining"},
    {"label": "Casual", "value": "Casual"},
    {"label": "Fast Food", "value": "Fast Food"},
    {"label": "Cafe", "value": "Cafe"},
    {"label": "Local", "value": "Local"},
  ];

  List<Map<String, dynamic>> locations = [
    {"label": "All Locations", "value": "All Locations"},
    {"label": "City Center", "value": "City Center"},
    {"label": "Old Town", "value": "Old Town"},
    {"label": "Beach Area", "value": "Beach Area"},
    {"label": "Shopping District", "value": "Shopping District"},
  ];

  List<Map<String, dynamic>> priceRanges = [
    {"label": "All Prices", "value": "All Prices"},
    {"label": "\$ (Under \$20)", "value": "budget"},
    {"label": "\$\$ (\$20-50)", "value": "moderate"},
    {"label": "\$\$\$ (\$50-100)", "value": "expensive"},
    {"label": "\$\$\$\$ (Over \$100)", "value": "luxury"},
  ];

  List<Map<String, dynamic>> ratings = [
    {"label": "All Ratings", "value": "All Ratings"},
    {"label": "4.5+ Stars", "value": "4.5"},
    {"label": "4.0+ Stars", "value": "4.0"},
    {"label": "3.5+ Stars", "value": "3.5"},
    {"label": "3.0+ Stars", "value": "3.0"},
  ];

  List<Map<String, dynamic>> restaurants = [
    {
      "id": 1,
      "name": "La Bella Vista",
      "category": "Fine Dining",
      "cuisine": "Italian",
      "rating": 4.8,
      "reviews": 324,
      "priceRange": "\$\$\$",
      "location": "City Center",
      "distance": "0.5 km",
      "openNow": true,
      "image": "https://picsum.photos/300/200?random=1&keyword=restaurant",
      "features": ["Romantic", "View", "Wine Bar"],
      "avgPrice": 85,
      "deliveryTime": "45-60 min",
    },
    {
      "id": 2,
      "name": "Street Food Paradise",
      "category": "Local",
      "cuisine": "Asian",
      "rating": 4.6,
      "reviews": 156,
      "priceRange": "\$",
      "location": "Old Town",
      "distance": "1.2 km",
      "openNow": true,
      "image": "https://picsum.photos/300/200?random=2&keyword=streetfood",
      "features": ["Authentic", "Outdoor", "Spicy"],
      "avgPrice": 12,
      "deliveryTime": "20-30 min",
    },
    {
      "id": 3,
      "name": "Ocean Breeze Cafe",
      "category": "Cafe",
      "cuisine": "International",
      "rating": 4.4,
      "reviews": 89,
      "priceRange": "\$\$",
      "location": "Beach Area",
      "distance": "2.8 km",
      "openNow": false,
      "image": "https://picsum.photos/300/200?random=3&keyword=cafe",
      "features": ["Sea View", "Coffee", "Breakfast"],
      "avgPrice": 28,
      "deliveryTime": "30-45 min",
    },
    {
      "id": 4,
      "name": "The Burger Joint",
      "category": "Fast Food",
      "cuisine": "American",
      "rating": 4.2,
      "reviews": 267,
      "priceRange": "\$",
      "location": "Shopping District",
      "distance": "0.8 km",
      "openNow": true,
      "image": "https://picsum.photos/300/200?random=4&keyword=burger",
      "features": ["Quick", "Family", "Takeaway"],
      "avgPrice": 15,
      "deliveryTime": "15-25 min",
    },
    {
      "id": 5,
      "name": "Garden Bistro",
      "category": "Casual",
      "cuisine": "Mediterranean",
      "rating": 4.7,
      "reviews": 198,
      "priceRange": "\$\$",
      "location": "City Center",
      "distance": "1.5 km",
      "openNow": true,
      "image": "https://picsum.photos/300/200?random=5&keyword=garden",
      "features": ["Garden", "Healthy", "Vegetarian"],
      "avgPrice": 42,
      "deliveryTime": "35-50 min",
    },
    {
      "id": 6,
      "name": "Sakura Sushi",
      "category": "Fine Dining",
      "cuisine": "Japanese",
      "rating": 4.9,
      "reviews": 412,
      "priceRange": "\$\$\$",
      "location": "City Center",
      "distance": "0.3 km",
      "openNow": true,
      "image": "https://picsum.photos/300/200?random=6&keyword=sushi",
      "features": ["Fresh", "Traditional", "Omakase"],
      "avgPrice": 95,
      "deliveryTime": "50-70 min",
    },
  ];

  List<Map<String, dynamic>> get filteredRestaurants {
    return restaurants.where((restaurant) {
      bool matchesSearch = searchQuery.isEmpty ||
          (restaurant["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (restaurant["cuisine"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || restaurant["category"] == selectedCategory;
      bool matchesLocation = selectedLocation == "All Locations" || restaurant["location"] == selectedLocation;
      
      return matchesSearch && matchesCategory && matchesLocation;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant Search"),
        actions: [
          IconButton(
            icon: Icon(isListView ? Icons.grid_view : Icons.list),
            onPressed: () {
              isListView = !isListView;
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.grey[50],
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search restaurants or cuisine",
                        value: searchQuery,
                        hint: "Enter restaurant name or cuisine type",
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.search,
                      size: bs.md,
                      onPressed: () {
                        // Perform search
                      },
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
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
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Location",
                        items: locations,
                        value: selectedLocation,
                        onChanged: (value, label) {
                          selectedLocation = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Price Range",
                        items: priceRanges,
                        value: selectedPriceRange,
                        onChanged: (value, label) {
                          selectedPriceRange = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Rating",
                        items: ratings,
                        value: selectedRating,
                        onChanged: (value, label) {
                          selectedRating = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            child: Row(
              children: [
                Text(
                  "${filteredRestaurants.length} restaurants found",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "Filters",
                  icon: Icons.tune,
                  size: bs.sm,
                  onPressed: () {
                    _showFiltersDialog();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredRestaurants.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.restaurant,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "No restaurants found",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Try adjusting your search criteria",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : isListView
                    ? ListView.builder(
                        padding: EdgeInsets.all(spMd),
                        itemCount: filteredRestaurants.length,
                        itemBuilder: (context, index) {
                          return _buildRestaurantListItem(filteredRestaurants[index]);
                        },
                      )
                    : ResponsiveGridView(
                        padding: EdgeInsets.all(spMd),
                        minItemWidth: 200,
                        children: filteredRestaurants.map((restaurant) {
                          return _buildRestaurantCard(restaurant);
                        }).toList(),
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantCard(Map<String, dynamic> restaurant) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                child: Image.network(
                  "${restaurant["image"]}",
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: restaurant["openNow"] ? successColor : dangerColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    restaurant["openNow"] ? "Open" : "Closed",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${restaurant["priceRange"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
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
              children: [
                Text(
                  "${restaurant["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spXs),
                Text(
                  "${restaurant["cuisine"]} • ${restaurant["category"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.amber,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${restaurant["rating"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "(${restaurant["reviews"]})",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${restaurant["distance"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${restaurant["deliveryTime"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                QHorizontalScroll(
                  children: (restaurant["features"] as List).map((feature) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "$feature",
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () {
                      // Navigate to restaurant detail
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

  Widget _buildRestaurantListItem(Map<String, dynamic> restaurant) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(radiusLg)),
            child: Image.network(
              "${restaurant["image"]}",
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(spSm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${restaurant["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: restaurant["openNow"] ? successColor : dangerColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          restaurant["openNow"] ? "Open" : "Closed",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${restaurant["cuisine"]} • ${restaurant["category"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 14,
                        color: Colors.amber,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${restaurant["rating"]} (${restaurant["reviews"]})",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${restaurant["priceRange"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${restaurant["distance"]} • ${restaurant["deliveryTime"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: QButton(
              label: "View",
              size: bs.sm,
              onPressed: () {
                // Navigate to restaurant detail
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showFiltersDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Advanced Filters"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Additional filter options coming soon"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}
