import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaLocalAmenitiesView extends StatefulWidget {
  const RmaLocalAmenitiesView({super.key});

  @override
  State<RmaLocalAmenitiesView> createState() => _RmaLocalAmenitiesViewState();
}

class _RmaLocalAmenitiesViewState extends State<RmaLocalAmenitiesView> {
  String selectedCategory = "All";
  String selectedDistance = "1 mile";
  bool showMap = false;

  List<Map<String, dynamic>> amenityCategories = [
    {"label": "All", "value": "All", "count": 124},
    {"label": "Restaurants", "value": "Restaurants", "count": 28},
    {"label": "Shopping", "value": "Shopping", "count": 15},
    {"label": "Healthcare", "value": "Healthcare", "count": 12},
    {"label": "Entertainment", "value": "Entertainment", "count": 18},
    {"label": "Fitness", "value": "Fitness", "count": 8},
    {"label": "Education", "value": "Education", "count": 6},
    {"label": "Transportation", "value": "Transportation", "count": 11},
    {"label": "Banking", "value": "Banking", "count": 9},
    {"label": "Services", "value": "Services", "count": 17},
  ];

  List<Map<String, dynamic>> distanceOptions = [
    {"label": "0.5 miles", "value": "0.5 mile"},
    {"label": "1 mile", "value": "1 mile"},
    {"label": "2 miles", "value": "2 mile"},
    {"label": "5 miles", "value": "5 mile"},
    {"label": "10 miles", "value": "10 mile"},
  ];

  List<Map<String, dynamic>> amenities = [
    {
      "name": "Whole Foods Market",
      "category": "Shopping",
      "type": "Grocery Store",
      "distance": 0.3,
      "rating": 4.5,
      "reviews": 2847,
      "address": "2101 3rd Ave, Seattle, WA",
      "hours": "7:00 AM - 10:00 PM",
      "phone": "(206) 621-9700",
      "features": ["Organic", "Prepared Foods", "Pharmacy"],
      "image": "https://picsum.photos/400/300?random=1&keyword=grocery",
      "walkTime": 4,
      "driveTime": 1,
    },
    {
      "name": "Pike Place Market",
      "category": "Entertainment",
      "type": "Market",
      "distance": 0.8,
      "rating": 4.7,
      "reviews": 15623,
      "address": "85 Pike St, Seattle, WA",
      "hours": "9:00 AM - 6:00 PM",
      "phone": "(206) 682-7453",
      "features": ["Historic", "Food", "Crafts", "Tourist Attraction"],
      "image": "https://picsum.photos/400/300?random=2&keyword=market",
      "walkTime": 12,
      "driveTime": 3,
    },
    {
      "name": "Seattle Children's Hospital",
      "category": "Healthcare",
      "type": "Hospital",
      "distance": 1.2,
      "rating": 4.3,
      "reviews": 892,
      "address": "4800 Sand Point Way NE, Seattle, WA",
      "hours": "24 Hours",
      "phone": "(206) 987-2000",
      "features": ["Emergency", "Pediatric", "Specialty Care"],
      "image": "https://picsum.photos/400/300?random=3&keyword=hospital",
      "walkTime": 18,
      "driveTime": 4,
    },
    {
      "name": "The Cheesecake Factory",
      "category": "Restaurants",
      "type": "American Restaurant",
      "distance": 0.5,
      "rating": 4.2,
      "reviews": 3241,
      "address": "700 Pine St, Seattle, WA",
      "hours": "11:00 AM - 11:00 PM",
      "phone": "(206) 652-5400",
      "features": ["Full Bar", "Outdoor Seating", "Takeout"],
      "image": "https://picsum.photos/400/300?random=4&keyword=restaurant",
      "walkTime": 7,
      "driveTime": 2,
    },
    {
      "name": "Seattle Central Library",
      "category": "Education",
      "type": "Public Library",
      "distance": 0.6,
      "rating": 4.6,
      "reviews": 1563,
      "address": "1000 4th Ave, Seattle, WA",
      "hours": "10:00 AM - 8:00 PM",
      "phone": "(206) 386-4636",
      "features": ["Free WiFi", "Study Rooms", "Events"],
      "image": "https://picsum.photos/400/300?random=5&keyword=library",
      "walkTime": 9,
      "driveTime": 2,
    },
    {
      "name": "Equinox",
      "category": "Fitness",
      "type": "Gym",
      "distance": 0.4,
      "rating": 4.1,
      "reviews": 567,
      "address": "1520 Westlake Ave N, Seattle, WA",
      "hours": "5:00 AM - 11:00 PM",
      "phone": "(206) 467-1400",
      "features": ["Personal Training", "Pool", "Classes"],
      "image": "https://picsum.photos/400/300?random=6&keyword=gym",
      "walkTime": 6,
      "driveTime": 1,
    },
    {
      "name": "Westlake Station",
      "category": "Transportation",
      "type": "Light Rail Station",
      "distance": 0.2,
      "rating": 4.0,
      "reviews": 234,
      "address": "401 Pine St, Seattle, WA",
      "hours": "5:00 AM - 1:00 AM",
      "phone": "(206) 398-5000",
      "features": ["Light Rail", "Bus Terminal", "Underground"],
      "image": "https://picsum.photos/400/300?random=7&keyword=station",
      "walkTime": 3,
      "driveTime": 1,
    },
    {
      "name": "Chase Bank",
      "category": "Banking",
      "type": "Bank",
      "distance": 0.3,
      "rating": 3.8,
      "reviews": 189,
      "address": "1200 3rd Ave, Seattle, WA",
      "hours": "9:00 AM - 5:00 PM",
      "phone": "(206) 270-1200",
      "features": ["ATM", "Drive-Through", "Notary"],
      "image": "https://picsum.photos/400/300?random=8&keyword=bank",
      "walkTime": 4,
      "driveTime": 1,
    },
  ];

  List<Map<String, dynamic>> get filteredAmenities {
    return amenities.where((amenity) {
      bool categoryMatch = selectedCategory == "All" || amenity["category"] == selectedCategory;
      double maxDistance = double.parse(selectedDistance.split(" ")[0]);
      bool distanceMatch = (amenity["distance"] as double) <= maxDistance;
      return categoryMatch && distanceMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Local Amenities"),
        actions: [
          GestureDetector(
            onTap: () {
              showMap = !showMap;
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              margin: EdgeInsets.only(right: spSm),
              decoration: BoxDecoration(
                color: showMap ? primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: showMap ? primaryColor : disabledColor,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    showMap ? Icons.list : Icons.map,
                    size: 16,
                    color: showMap ? Colors.white : disabledBoldColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    showMap ? "List" : "Map",
                    style: TextStyle(
                      fontSize: 12,
                      color: showMap ? Colors.white : disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: QDropdownField(
                    label: "Category",
                    items: amenityCategories,
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
                    label: "Distance",
                    items: distanceOptions,
                    value: selectedDistance,
                    onChanged: (value, label) {
                      selectedDistance = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Stats Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Amenities Summary",
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
                        child: _buildStatCard(
                          "Total Found",
                          "${filteredAmenities.length}",
                          Icons.location_on,
                          primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "Avg Rating",
                          "${(filteredAmenities.map((a) => a["rating"] as double).reduce((a, b) => a + b) / filteredAmenities.length).toStringAsFixed(1)}",
                          Icons.star,
                          warningColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "Closest",
                          "${filteredAmenities.map((a) => a["distance"]).reduce((a, b) => a < b ? a : b)} mi",
                          Icons.near_me,
                          successColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            if (showMap) ...[
              // Map View
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.map,
                            size: 64,
                            color: disabledBoldColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Interactive Map View",
                            style: TextStyle(
                              fontSize: 16,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Showing ${filteredAmenities.length} amenities",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Map pins simulation
                    ...List.generate(
                      (filteredAmenities.length > 8 ? 8 : filteredAmenities.length),
                      (index) {
                        final amenity = filteredAmenities[index];
                        return Positioned(
                          left: 50.0 + (index * 30.0),
                          top: 80.0 + (index % 3 * 40.0),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: _getCategoryColor(amenity["category"]),
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: Border.all(color: Colors.white, width: 2),
                              boxShadow: [shadowSm],
                            ),
                            child: Icon(
                              _getCategoryIcon(amenity["category"]),
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: spMd),
            ],

            // Category Grid
            QCategoryPicker(
              label: "Quick Filters",
              items: amenityCategories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            SizedBox(height: spMd),

            // Amenities List
            Text(
              "Nearby Amenities (${filteredAmenities.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...List.generate(filteredAmenities.length, (index) {
              final amenity = filteredAmenities[index];
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusSm),
                            image: DecorationImage(
                              image: NetworkImage("${amenity["image"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${amenity["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${amenity["type"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
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
                                    "${amenity["rating"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "(${amenity["reviews"]})",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getCategoryColor(amenity["category"]),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${amenity["category"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
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
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: dangerColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${amenity["distance"]} miles",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          Icons.directions_walk,
                          size: 16,
                          color: successColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${amenity["walkTime"]} min",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          Icons.directions_car,
                          size: 16,
                          color: primaryColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${amenity["driveTime"]} min",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${amenity["address"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: infoColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${amenity["hours"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            si("Calling ${amenity["phone"]}");
                          },
                          child: Icon(
                            Icons.phone,
                            size: 16,
                            color: successColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        GestureDetector(
                          onTap: () {
                            si("Opening directions to ${amenity["name"]}");
                          },
                          child: Icon(
                            Icons.directions,
                            size: 16,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    if ((amenity["features"] as List).isNotEmpty) ...[
                      SizedBox(height: spSm),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (amenity["features"] as List).map((feature) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$feature",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {
                              si("Viewing details for ${amenity["name"]}");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.favorite_border,
                          size: bs.sm,
                          onPressed: () {
                            ss("Added ${amenity["name"]} to favorites");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 24,
            color: color,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Restaurants":
        return dangerColor;
      case "Shopping":
        return primaryColor;
      case "Healthcare":
        return successColor;
      case "Entertainment":
        return warningColor;
      case "Fitness":
        return infoColor;
      case "Education":
        return secondaryColor;
      case "Transportation":
        return primaryColor;
      case "Banking":
        return successColor;
      case "Services":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Restaurants":
        return Icons.restaurant;
      case "Shopping":
        return Icons.shopping_bag;
      case "Healthcare":
        return Icons.local_hospital;
      case "Entertainment":
        return Icons.movie;
      case "Fitness":
        return Icons.fitness_center;
      case "Education":
        return Icons.school;
      case "Transportation":
        return Icons.train;
      case "Banking":
        return Icons.account_balance;
      case "Services":
        return Icons.build;
      default:
        return Icons.place;
    }
  }
}
