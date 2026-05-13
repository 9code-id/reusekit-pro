import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReservation2View extends StatefulWidget {
  @override
  State<GrlReservation2View> createState() => _GrlReservation2ViewState();
}

class _GrlReservation2ViewState extends State<GrlReservation2View> {
  String selectedCategory = "";
  String selectedLocation = "";
  String selectedDate = "";
  String selectedTime = "";
  int guestCount = 2;
  String searchQuery = "";
  String sortBy = "rating";

  List<Map<String, dynamic>> venues = [
    {
      "id": 1,
      "name": "Skyline Restaurant",
      "category": "restaurant",
      "rating": 4.8,
      "reviewCount": 256,
      "location": "Downtown",
      "address": "123 Main St, Downtown District",
      "phone": "+1 (555) 123-4567",
      "priceRange": "\$\$\$",
      "image": "https://picsum.photos/120/120?random=1&keyword=restaurant",
      "gallery": [
        "https://picsum.photos/300/200?random=11&keyword=restaurant",
        "https://picsum.photos/300/200?random=12&keyword=restaurant",
        "https://picsum.photos/300/200?random=13&keyword=restaurant",
      ],
      "cuisine": "Italian",
      "features": ["Fine Dining", "Wine Bar", "Outdoor Seating"],
      "openTime": "17:00",
      "closeTime": "23:00",
      "availableSlots": ["17:00", "17:30", "18:00", "19:00", "19:30", "20:00", "20:30"],
      "minGuests": 1,
      "maxGuests": 8,
      "description": "Elegant rooftop restaurant with panoramic city views and award-winning Italian cuisine.",
    },
    {
      "id": 2,
      "name": "Grand Hotel Spa",
      "category": "hotel",
      "rating": 4.9,
      "reviewCount": 189,
      "location": "Resort District",
      "address": "456 Luxury Ave, Resort District",
      "phone": "+1 (555) 987-6543",
      "priceRange": "\$\$\$\$",
      "image": "https://picsum.photos/120/120?random=2&keyword=hotel",
      "gallery": [
        "https://picsum.photos/300/200?random=21&keyword=hotel",
        "https://picsum.photos/300/200?random=22&keyword=hotel",
        "https://picsum.photos/300/200?random=23&keyword=hotel",
      ],
      "type": "Luxury Resort",
      "features": ["Spa Services", "Pool", "Golf Course", "Beach Access"],
      "checkInTime": "15:00",
      "checkOutTime": "11:00",
      "roomTypes": ["Standard", "Deluxe", "Suite", "Presidential"],
      "description": "Luxurious beachfront resort with world-class spa facilities and championship golf course.",
    },
    {
      "id": 3,
      "name": "Elite Conference Hall",
      "category": "event",
      "rating": 4.7,
      "reviewCount": 94,
      "location": "Business District",
      "address": "789 Corporate Blvd, Business District",
      "phone": "+1 (555) 456-7890",
      "priceRange": "\$\$\$",
      "image": "https://picsum.photos/120/120?random=3&keyword=conference",
      "gallery": [
        "https://picsum.photos/300/200?random=31&keyword=conference",
        "https://picsum.photos/300/200?random=32&keyword=conference",
        "https://picsum.photos/300/200?random=33&keyword=conference",
      ],
      "capacity": 500,
      "features": ["AV Equipment", "Catering", "Parking", "WiFi"],
      "openTime": "08:00",
      "closeTime": "22:00",
      "rooms": ["Main Hall", "Conference Room A", "Conference Room B", "Boardroom"],
      "description": "State-of-the-art conference facility with flexible spaces for corporate events and meetings.",
    },
    {
      "id": 4,
      "name": "Marina Yacht Club",
      "category": "recreation",
      "rating": 4.6,
      "reviewCount": 127,
      "location": "Waterfront",
      "address": "321 Marina Drive, Waterfront District",
      "phone": "+1 (555) 321-9876",
      "priceRange": "\$\$\$\$",
      "image": "https://picsum.photos/120/120?random=4&keyword=yacht",
      "gallery": [
        "https://picsum.photos/300/200?random=41&keyword=yacht",
        "https://picsum.photos/300/200?random=42&keyword=yacht",
        "https://picsum.photos/300/200?random=43&keyword=yacht",
      ],
      "activities": ["Sailing", "Fishing", "Water Sports", "Dining"],
      "features": ["Private Dock", "Catering", "Bar Service", "Equipment Rental"],
      "openTime": "06:00",
      "closeTime": "20:00",
      "yachtTypes": ["Sport Yacht", "Luxury Yacht", "Sailing Yacht"],
      "description": "Premium marina with luxury yacht rentals and exclusive waterfront dining experiences.",
    },
    {
      "id": 5,
      "name": "City Sports Center",
      "category": "sports",
      "rating": 4.5,
      "reviewCount": 203,
      "location": "Athletic District",
      "address": "654 Sports Ave, Athletic District",
      "phone": "+1 (555) 654-3210",
      "priceRange": "\$\$",
      "image": "https://picsum.photos/120/120?random=5&keyword=sports",
      "gallery": [
        "https://picsum.photos/300/200?random=51&keyword=sports",
        "https://picsum.photos/300/200?random=52&keyword=sports",
        "https://picsum.photos/300/200?random=53&keyword=sports",
      ],
      "sports": ["Tennis", "Basketball", "Swimming", "Fitness"],
      "features": ["Professional Courts", "Equipment Rental", "Coaching", "Locker Rooms"],
      "openTime": "06:00",
      "closeTime": "22:00",
      "facilities": ["Tennis Courts", "Basketball Courts", "Swimming Pool", "Gym"],
      "description": "Modern sports complex with professional-grade facilities for various athletic activities.",
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": ""},
    {"label": "Restaurant", "value": "restaurant"},
    {"label": "Hotel", "value": "hotel"},
    {"label": "Event Venue", "value": "event"},
    {"label": "Recreation", "value": "recreation"},
    {"label": "Sports", "value": "sports"},
  ];

  List<Map<String, dynamic>> locations = [
    {"label": "All Locations", "value": ""},
    {"label": "Downtown", "value": "Downtown"},
    {"label": "Resort District", "value": "Resort District"},
    {"label": "Business District", "value": "Business District"},
    {"label": "Waterfront", "value": "Waterfront"},
    {"label": "Athletic District", "value": "Athletic District"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Rating", "value": "rating"},
    {"label": "Price (Low to High)", "value": "price_asc"},
    {"label": "Price (High to Low)", "value": "price_desc"},
    {"label": "Reviews", "value": "reviews"},
    {"label": "Name", "value": "name"},
  ];

  List<Map<String, dynamic>> get filteredVenues {
    List<Map<String, dynamic>> filtered = venues;

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((venue) =>
        "${venue["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${venue["category"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${venue["location"]}".toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }

    // Filter by category
    if (selectedCategory.isNotEmpty) {
      filtered = filtered.where((venue) => 
        "${venue["category"]}" == selectedCategory
      ).toList();
    }

    // Filter by location
    if (selectedLocation.isNotEmpty) {
      filtered = filtered.where((venue) => 
        "${venue["location"]}" == selectedLocation
      ).toList();
    }

    // Sort results
    switch (sortBy) {
      case "rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "reviews":
        filtered.sort((a, b) => (b["reviewCount"] as int).compareTo(a["reviewCount"] as int));
        break;
      case "name":
        filtered.sort((a, b) => "${a["name"]}".compareTo("${b["name"]}"));
        break;
    }

    return filtered;
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "restaurant":
        return Icons.restaurant;
      case "hotel":
        return Icons.hotel;
      case "event":
        return Icons.event;
      case "recreation":
        return Icons.directions_boat;
      case "sports":
        return Icons.sports_tennis;
      default:
        return Icons.place;
    }
  }

  String _getCategoryLabel(String category) {
    switch (category) {
      case "restaurant":
        return "Restaurant";
      case "hotel":
        return "Hotel";
      case "event":
        return "Event Venue";
      case "recreation":
        return "Recreation";
      case "sports":
        return "Sports";
      default:
        return "Venue";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Find Venues"),
        actions: [
          QButton(
            icon: Icons.map,
            size: bs.sm,
            onPressed: () {
              // Navigate to map view
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Column(
        children: [
          // Search and Filters Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search venues",
                        value: searchQuery,
                        hint: "e.g., Skyline Restaurant, Downtown",
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

                SizedBox(height: spMd),

                // Quick Filters
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

                SizedBox(height: spMd),

                // Guest Count and Sort
                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Guests",
                        value: guestCount.toString(),
                        onChanged: (value) {
                          guestCount = int.tryParse(value) ?? 2;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Sort by",
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
              ],
            ),
          ),

          // Results Counter
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            color: disabledColor.withAlpha(10),
            child: Row(
              children: [
                Text(
                  "${filteredVenues.length} venues found",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                if (searchQuery.isNotEmpty || selectedCategory.isNotEmpty || selectedLocation.isNotEmpty) ...[
                  GestureDetector(
                    onTap: () {
                      searchQuery = "";
                      selectedCategory = "";
                      selectedLocation = "";
                      setState(() {});
                    },
                    child: Text(
                      "Clear filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Venues List
          Expanded(
            child: filteredVenues.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 80,
                          color: disabledColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "No venues found",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Try adjusting your search criteria",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(spMd),
                    itemCount: filteredVenues.length,
                    itemBuilder: (context, index) {
                      final venue = filteredVenues[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Venue Image
                            Container(
                              height: 160,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(radiusLg),
                                  topRight: Radius.circular(radiusLg),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage("${venue["image"]}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  // Category badge
                                  Positioned(
                                    top: spSm,
                                    left: spSm,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            _getCategoryIcon("${venue["category"]}"),
                                            size: 16,
                                            color: primaryColor,
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            _getCategoryLabel("${venue["category"]}"),
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Rating badge
                                  Positioned(
                                    top: spSm,
                                    right: spSm,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withAlpha(150),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 16,
                                            color: warningColor,
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${venue["rating"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Favorite button
                                  Positioned(
                                    bottom: spSm,
                                    right: spSm,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: QButton(
                                        icon: Icons.favorite_border,
                                        size: bs.sm,
                                        onPressed: () {
                                          ss("Added to favorites");
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Content
                            Padding(
                              padding: EdgeInsets.all(spMd),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${venue["name"]}",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                            SizedBox(height: spXs),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  size: 16,
                                                  color: disabledColor,
                                                ),
                                                SizedBox(width: spXs),
                                                Text(
                                                  "${venue["location"]}",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: disabledBoldColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "${venue["priceRange"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: successColor,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: spSm),

                                  // Rating and Reviews
                                  Row(
                                    children: [
                                      Row(
                                        children: List.generate(5, (starIndex) {
                                          return Icon(
                                            starIndex < (venue["rating"] as double).floor()
                                                ? Icons.star
                                                : Icons.star_border,
                                            size: 16,
                                            color: warningColor,
                                          );
                                        }),
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        "(${venue["reviewCount"]} reviews)",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledColor,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: spSm),

                                  // Description
                                  Text(
                                    "${venue["description"]}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                      height: 1.4,
                                    ),
                                  ),

                                  SizedBox(height: spMd),

                                  // Features
                                  if (venue.containsKey("features")) ...[
                                    Wrap(
                                      spacing: spSm,
                                      runSpacing: spSm,
                                      children: (venue["features"] as List).take(3).map((feature) =>
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spSm,
                                            vertical: spXs,
                                          ),
                                          decoration: BoxDecoration(
                                            color: infoColor.withAlpha(10),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "$feature",
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: infoColor,
                                            ),
                                          ),
                                        )
                                      ).toList(),
                                    ),
                                    SizedBox(height: spMd),
                                  ],

                                  // Action Buttons
                                  Row(
                                    children: [
                                      Expanded(
                                        child: QButton(
                                          label: "View Details",
                                          size: bs.sm,
                                          onPressed: () {
                                            // Navigate to venue details
                                          },
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: QButton(
                                          label: "Reserve Now",
                                          size: bs.sm,
                                          onPressed: () {
                                            // Navigate to reservation
                                          },
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      QButton(
                                        icon: Icons.phone,
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
