import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaAmenitiesView extends StatefulWidget {
  const ReaAmenitiesView({super.key});

  @override
  State<ReaAmenitiesView> createState() => _ReaAmenitiesViewState();
}

class _ReaAmenitiesViewState extends State<ReaAmenitiesView> {
  String selectedCategory = "All";
  String searchQuery = "";
  
  final List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Sports & Recreation", "value": "Sports"},
    {"label": "Healthcare", "value": "Healthcare"},
    {"label": "Education", "value": "Education"},
    {"label": "Shopping", "value": "Shopping"},
    {"label": "Entertainment", "value": "Entertainment"},
    {"label": "Transportation", "value": "Transportation"},
  ];

  final List<Map<String, dynamic>> amenities = [
    {
      "name": "Swimming Pool",
      "category": "Sports",
      "distance": "0.2 km",
      "rating": 4.5,
      "reviews": 124,
      "image": "https://picsum.photos/100/100?random=1&keyword=pool",
      "type": "Premium",
      "openTime": "6:00 AM - 10:00 PM",
      "phone": "+1 234 567 8900",
      "features": ["Olympic Size", "Heated", "Kids Pool", "Locker Room"],
      "price": "Free for residents",
      "status": "Open"
    },
    {
      "name": "Fitness Center",
      "category": "Sports",
      "distance": "0.1 km",
      "rating": 4.7,
      "reviews": 89,
      "image": "https://picsum.photos/100/100?random=2&keyword=gym",
      "type": "Premium",
      "openTime": "24/7",
      "phone": "+1 234 567 8901",
      "features": ["Modern Equipment", "Personal Trainer", "Yoga Studio", "Steam Room"],
      "price": "Free for residents",
      "status": "Open"
    },
    {
      "name": "Children's Playground",
      "category": "Sports",
      "distance": "0.3 km",
      "rating": 4.3,
      "reviews": 156,
      "image": "https://picsum.photos/100/100?random=3&keyword=playground",
      "type": "Community",
      "openTime": "6:00 AM - 8:00 PM",
      "phone": "N/A",
      "features": ["Safe Equipment", "Rubber Flooring", "Shaded Area", "Benches"],
      "price": "Free",
      "status": "Open"
    },
    {
      "name": "Grocery Store",
      "category": "Shopping",
      "distance": "0.4 km",
      "rating": 4.2,
      "reviews": 234,
      "image": "https://picsum.photos/100/100?random=4&keyword=grocery",
      "type": "Essential",
      "openTime": "7:00 AM - 11:00 PM",
      "phone": "+1 234 567 8902",
      "features": ["Fresh Produce", "Organic Options", "Pharmacy", "Delivery"],
      "price": "Varies",
      "status": "Open"
    },
    {
      "name": "Medical Clinic",
      "category": "Healthcare",
      "distance": "0.6 km",
      "rating": 4.6,
      "reviews": 78,
      "image": "https://picsum.photos/100/100?random=5&keyword=medical",
      "type": "Essential",
      "openTime": "8:00 AM - 6:00 PM",
      "phone": "+1 234 567 8903",
      "features": ["General Practice", "Emergency Care", "Lab Services", "Pharmacy"],
      "price": "Insurance Accepted",
      "status": "Open"
    },
    {
      "name": "Shopping Mall",
      "category": "Shopping",
      "distance": "1.2 km",
      "rating": 4.4,
      "reviews": 567,
      "image": "https://picsum.photos/100/100?random=6&keyword=mall",
      "type": "Commercial",
      "openTime": "10:00 AM - 10:00 PM",
      "phone": "+1 234 567 8904",
      "features": ["200+ Stores", "Food Court", "Cinema", "Parking"],
      "price": "Free Entry",
      "status": "Open"
    },
    {
      "name": "Elementary School",
      "category": "Education",
      "distance": "0.8 km",
      "rating": 4.8,
      "reviews": 45,
      "image": "https://picsum.photos/100/100?random=7&keyword=school",
      "type": "Public",
      "openTime": "7:30 AM - 3:30 PM",
      "phone": "+1 234 567 8905",
      "features": ["Excellent Rating", "STEM Program", "Arts Center", "Sports Field"],
      "price": "Public School",
      "status": "Open"
    },
    {
      "name": "Coffee Shop",
      "category": "Entertainment",
      "distance": "0.3 km",
      "rating": 4.5,
      "reviews": 189,
      "image": "https://picsum.photos/100/100?random=8&keyword=coffee",
      "type": "Commercial",
      "openTime": "6:00 AM - 9:00 PM",
      "phone": "+1 234 567 8906",
      "features": ["WiFi", "Outdoor Seating", "Fresh Pastries", "Local Roasters"],
      "price": "\$3 - \$8",
      "status": "Open"
    },
    {
      "name": "Bus Stop",
      "category": "Transportation",
      "distance": "0.2 km",
      "rating": 4.0,
      "reviews": 67,
      "image": "https://picsum.photos/100/100?random=9&keyword=bus",
      "type": "Public",
      "openTime": "24/7",
      "phone": "N/A",
      "features": ["Covered Shelter", "Digital Display", "Multiple Routes", "Wheelchair Access"],
      "price": "Free",
      "status": "Active"
    },
    {
      "name": "Community Center",
      "category": "Entertainment",
      "distance": "0.5 km",
      "rating": 4.3,
      "reviews": 98,
      "image": "https://picsum.photos/100/100?random=10&keyword=community",
      "type": "Community",
      "openTime": "9:00 AM - 9:00 PM",
      "phone": "+1 234 567 8907",
      "features": ["Event Hall", "Meeting Rooms", "Classes", "Senior Programs"],
      "price": "Membership Required",
      "status": "Open"
    },
  ];

  List<Map<String, dynamic>> get filteredAmenities {
    var filtered = amenities;
    
    if (selectedCategory != "All") {
      filtered = filtered.where((amenity) => amenity["category"] == selectedCategory).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((amenity) => 
        (amenity["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (amenity["category"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Sports": return successColor;
      case "Healthcare": return dangerColor;
      case "Education": return infoColor;
      case "Shopping": return warningColor;
      case "Entertainment": return primaryColor;
      case "Transportation": return secondaryColor;
      default: return disabledBoldColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Premium": return primaryColor;
      case "Essential": return successColor;
      case "Community": return infoColor;
      case "Commercial": return warningColor;
      case "Public": return secondaryColor;
      default: return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nearby Amenities"),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              ss("Opening map view");
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              ss("Opening advanced filters");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Stats
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Amenities Overview",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${amenities.length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Total Amenities",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(180),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "0.4 km",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Average Distance",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(180),
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
            
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search amenities...",
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
                  onPressed: () {
                    // Search functionality
                  },
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Category Filter
            QCategoryPicker(
              label: "Filter by Category",
              items: categories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spLg),
            
            // Quick Stats Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.directions_walk, color: successColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "6",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Walking Distance",
                          style: TextStyle(
                            fontSize: 11,
                            color: successColor,
                          ),
                          textAlign: TextAlign.center,
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
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: primaryColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.star, color: primaryColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "4.4",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Avg Rating",
                          style: TextStyle(
                            fontSize: 11,
                            color: primaryColor,
                          ),
                          textAlign: TextAlign.center,
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
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: infoColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.access_time, color: infoColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "24/7",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Always Open",
                          style: TextStyle(
                            fontSize: 11,
                            color: infoColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Section Header
            Text(
              "Amenities List (${filteredAmenities.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Amenities List
            ...filteredAmenities.map((amenity) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${amenity["image"]}",
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
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${amenity["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: _getTypeColor(amenity["type"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${amenity["type"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: _getTypeColor(amenity["type"]),
                                      ),
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
                                  SizedBox(width: 4),
                                  Text(
                                    "${amenity["distance"]} away",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(
                                    Icons.star,
                                    size: 14,
                                    color: warningColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${amenity["rating"]} (${amenity["reviews"]})",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getCategoryColor(amenity["category"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${amenity["category"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: _getCategoryColor(amenity["category"]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Amenity Details
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                                    SizedBox(width: spXs),
                                    Expanded(
                                      child: Text(
                                        "${amenity["openTime"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (amenity["phone"] != "N/A")
                                Row(
                                  children: [
                                    Icon(Icons.phone, size: 16, color: disabledBoldColor),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${amenity["phone"]}",
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
                          Row(
                            children: [
                              Icon(Icons.attach_money, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${amenity["price"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${amenity["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Features
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (amenity["features"] as List).map((feature) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                            border: Border.all(color: primaryColor.withAlpha(30)),
                          ),
                          child: Text(
                            "$feature",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
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
                            label: "Get Directions",
                            icon: Icons.directions,
                            size: bs.sm,
                            onPressed: () {
                              ss("Opening directions for ${amenity["name"]}");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.phone,
                          size: bs.sm,
                          onPressed: amenity["phone"] != "N/A" ? () {
                            ss("Calling ${amenity["name"]}");
                          } : null,
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.share,
                          size: bs.sm,
                          onPressed: () {
                            ss("Sharing ${amenity["name"]}");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
            
            if (filteredAmenities.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.location_off,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No amenities found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your search or category filter",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            
            SizedBox(height: spLg),
            
            // Add Amenity Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Suggest New Amenity",
                icon: Icons.add_location_alt,
                size: bs.md,
                onPressed: () {
                  ss("Opening amenity suggestion form");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
