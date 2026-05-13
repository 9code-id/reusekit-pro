import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaRestaurantListView extends StatefulWidget {
  const TtaRestaurantListView({super.key});

  @override
  State<TtaRestaurantListView> createState() => _TtaRestaurantListViewState();
}

class _TtaRestaurantListViewState extends State<TtaRestaurantListView> {
  String searchQuery = "";
  String selectedCuisine = "All";
  String priceRange = "All";
  String sortBy = "Rating";
  bool showFilters = false;

  List<Map<String, dynamic>> cuisineTypes = [
    {"label": "All", "value": "All"},
    {"label": "Italian", "value": "Italian"},
    {"label": "Chinese", "value": "Chinese"},
    {"label": "Japanese", "value": "Japanese"},
    {"label": "Mexican", "value": "Mexican"},
    {"label": "Indian", "value": "Indian"},
    {"label": "French", "value": "French"},
    {"label": "Thai", "value": "Thai"},
    {"label": "Mediterranean", "value": "Mediterranean"},
  ];

  List<Map<String, dynamic>> priceRanges = [
    {"label": "All", "value": "All"},
    {"label": "\$", "value": "budget"},
    {"label": "\$\$", "value": "moderate"},
    {"label": "\$\$\$", "value": "expensive"},
    {"label": "\$\$\$\$", "value": "luxury"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Rating", "value": "Rating"},
    {"label": "Distance", "value": "Distance"},
    {"label": "Price", "value": "Price"},
    {"label": "Popularity", "value": "Popularity"},
  ];

  List<Map<String, dynamic>> restaurants = [
    {
      "id": 1,
      "name": "Mama's Italian Kitchen",
      "cuisine": "Italian",
      "rating": 4.8,
      "reviewCount": 324,
      "priceRange": "moderate",
      "distance": "0.5 km",
      "image": "https://picsum.photos/300/200?random=1&keyword=restaurant",
      "address": "123 Main Street, Downtown",
      "openNow": true,
      "deliveryTime": "25-35 min",
      "features": ["Outdoor Seating", "Takeaway", "Reservations"],
      "specialties": ["Pasta", "Pizza", "Wine"],
      "phone": "+1 234-567-8901"
    },
    {
      "id": 2,
      "name": "Dragon Palace",
      "cuisine": "Chinese",
      "rating": 4.6,
      "reviewCount": 189,
      "priceRange": "budget",
      "distance": "1.2 km",
      "image": "https://picsum.photos/300/200?random=2&keyword=chinese",
      "address": "456 China Town, East District",
      "openNow": true,
      "deliveryTime": "30-40 min",
      "features": ["Dim Sum", "Delivery", "Family Style"],
      "specialties": ["Kung Pao", "Sweet & Sour", "Fried Rice"],
      "phone": "+1 234-567-8902"
    },
    {
      "id": 3,
      "name": "Sakura Sushi Bar",
      "cuisine": "Japanese",
      "rating": 4.9,
      "reviewCount": 567,
      "priceRange": "expensive",
      "distance": "0.8 km",
      "image": "https://picsum.photos/300/200?random=3&keyword=sushi",
      "address": "789 Bamboo Lane, Central",
      "openNow": false,
      "deliveryTime": "40-50 min",
      "features": ["Sushi Bar", "Private Rooms", "Omakase"],
      "specialties": ["Sashimi", "Nigiri", "Maki Rolls"],
      "phone": "+1 234-567-8903"
    },
    {
      "id": 4,
      "name": "El Mariachi Cantina",
      "cuisine": "Mexican",
      "rating": 4.5,
      "reviewCount": 298,
      "priceRange": "moderate",
      "distance": "1.5 km",
      "image": "https://picsum.photos/300/200?random=4&keyword=mexican",
      "address": "321 Fiesta Street, West Side",
      "openNow": true,
      "deliveryTime": "20-30 min",
      "features": ["Live Music", "Happy Hour", "Patio"],
      "specialties": ["Tacos", "Margaritas", "Fajitas"],
      "phone": "+1 234-567-8904"
    },
    {
      "id": 5,
      "name": "Spice Route",
      "cuisine": "Indian",
      "rating": 4.7,
      "reviewCount": 412,
      "priceRange": "moderate",
      "distance": "2.1 km",
      "image": "https://picsum.photos/300/200?random=5&keyword=indian",
      "address": "654 Curry Lane, South District",
      "openNow": true,
      "deliveryTime": "35-45 min",
      "features": ["Vegetarian Options", "Buffet", "Tandoor"],
      "specialties": ["Biryani", "Curry", "Naan"],
      "phone": "+1 234-567-8905"
    },
    {
      "id": 6,
      "name": "Le Petit Bistro",
      "cuisine": "French",
      "rating": 4.8,
      "reviewCount": 156,
      "priceRange": "luxury",
      "distance": "0.7 km",
      "image": "https://picsum.photos/300/200?random=6&keyword=french",
      "address": "987 Rue de la Paix, Old Town",
      "openNow": false,
      "deliveryTime": "45-60 min",
      "features": ["Wine Cellar", "Fine Dining", "Romantic"],
      "specialties": ["Coq au Vin", "Escargot", "Soufflé"],
      "phone": "+1 234-567-8906"
    }
  ];

  List<Map<String, dynamic>> get filteredRestaurants {
    return restaurants.where((restaurant) {
      bool matchesSearch = "${restaurant["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${restaurant["cuisine"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCuisine = selectedCuisine == "All" || restaurant["cuisine"] == selectedCuisine;
      bool matchesPrice = priceRange == "All" || restaurant["priceRange"] == priceRange;
      
      return matchesSearch && matchesCuisine && matchesPrice;
    }).toList();
  }

  String _getPriceDisplay(String priceRange) {
    switch (priceRange) {
      case "budget": return "\$";
      case "moderate": return "\$\$";
      case "expensive": return "\$\$\$";
      case "luxury": return "\$\$\$\$";
      default: return "\$\$";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurants"),
        actions: [
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {
              showFilters = !showFilters;
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search restaurants or cuisine",
                    value: searchQuery,
                    hint: "Italian, Pizza, Sushi...",
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
          ),

          // Filters Section
          if (showFilters)
            Container(
              padding: EdgeInsets.all(spMd),
              color: Colors.grey[50],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filters",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Cuisine",
                          items: cuisineTypes,
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
                          label: "Price Range",
                          items: priceRanges,
                          value: priceRange,
                          onChanged: (value, label) {
                            priceRange = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Sort By",
                    items: sortOptions,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

          // Results Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            child: Row(
              children: [
                Text(
                  "${filteredRestaurants.length} restaurants found",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: primaryColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Near you",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Restaurant List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredRestaurants.length,
              itemBuilder: (context, index) {
                final restaurant = filteredRestaurants[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Restaurant Image
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                        child: Stack(
                          children: [
                            Image.network(
                              "${restaurant["image"]}",
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: restaurant["openNow"] ? successColor : dangerColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  restaurant["openNow"] ? "Open Now" : "Closed",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(153),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${restaurant["deliveryTime"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Restaurant Info
                      Padding(
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
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  _getPriceDisplay("${restaurant["priceRange"]}"),
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: warningColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${restaurant["rating"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "(${restaurant["reviewCount"]} reviews)",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
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
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${restaurant["cuisine"]} • ${restaurant["address"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            
                            // Specialties
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (restaurant["specialties"] as List).map((specialty) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(25),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${specialty}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "View Menu",
                                    size: bs.sm,
                                    onPressed: () {
                                      //navigateTo('TtaMenuView')
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.call,
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.favorite_border,
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
