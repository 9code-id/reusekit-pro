import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaLocationTaggingView extends StatefulWidget {
  const SmaLocationTaggingView({super.key});

  @override
  State<SmaLocationTaggingView> createState() => _SmaLocationTaggingViewState();
}

class _SmaLocationTaggingViewState extends State<SmaLocationTaggingView> {
  String searchQuery = "";
  String selectedLocationId = "";
  bool isSearching = false;
  bool allowCustomLocation = true;
  String customLocationName = "";

  List<Map<String, dynamic>> nearbyLocations = [
    {
      "id": "loc_001",
      "name": "Starbucks Coffee - Downtown",
      "address": "123 Main Street, Downtown",
      "distance": 0.2,
      "category": "Coffee Shop",
      "verified": true,
      "latitude": 37.7749,
      "longitude": -122.4194,
      "checkins": 1250,
    },
    {
      "id": "loc_002", 
      "name": "Central Park",
      "address": "Central Park, New York",
      "distance": 0.5,
      "category": "Park",
      "verified": true,
      "latitude": 40.7829,
      "longitude": -73.9654,
      "checkins": 8900,
    },
    {
      "id": "loc_003",
      "name": "The Grand Mall",
      "address": "456 Shopping Blvd",
      "distance": 1.2,
      "category": "Shopping Mall",
      "verified": true,
      "latitude": 37.7849,
      "longitude": -122.4094,
      "checkins": 3400,
    },
    {
      "id": "loc_004",
      "name": "Burger Palace",
      "address": "789 Food Street",
      "distance": 0.8,
      "category": "Restaurant",
      "verified": false,
      "latitude": 37.7649,
      "longitude": -122.4294,
      "checkins": 567,
    },
    {
      "id": "loc_005",
      "name": "City Gym & Fitness",
      "address": "321 Health Ave",
      "distance": 1.5,
      "category": "Fitness Center",
      "verified": true,
      "latitude": 37.7549,
      "longitude": -122.4394,
      "checkins": 890,
    },
    {
      "id": "loc_006",
      "name": "University Library",
      "address": "University Campus",
      "distance": 2.1,
      "category": "Library",
      "verified": true,
      "latitude": 37.7949,
      "longitude": -122.4094,
      "checkins": 2100,
    },
  ];

  List<Map<String, dynamic>> get filteredLocations {
    if (searchQuery.isEmpty) {
      return nearbyLocations;
    }

    return nearbyLocations.where((location) {
      return "${location["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
             "${location["address"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
             "${location["category"]}".toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  void _selectLocation(String locationId) {
    selectedLocationId = locationId;
    setState(() {});
  }

  void _confirmLocation() {
    if (selectedLocationId.isNotEmpty) {
      Map<String, dynamic> location = nearbyLocations.firstWhere((loc) => loc["id"] == selectedLocationId);
      ss("Location tagged: ${location["name"]}");
      back();
    } else if (allowCustomLocation && customLocationName.trim().isNotEmpty) {
      ss("Custom location tagged: $customLocationName");
      back();
    } else {
      se("Please select a location or enter a custom location");
    }
  }

  void _searchLocations() async {
    if (searchQuery.trim().isEmpty) return;

    isSearching = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 1));

    isSearching = false;
    setState(() {});
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case "coffee shop":
        return Icons.local_cafe;
      case "park":
        return Icons.park;
      case "shopping mall":
        return Icons.shopping_bag;
      case "restaurant":
        return Icons.restaurant;
      case "fitness center":
        return Icons.fitness_center;
      case "library":
        return Icons.local_library;
      default:
        return Icons.place;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tag Location"),
        actions: [
          QButton(
            label: "Done",
            size: bs.sm,
            onPressed: _confirmLocation,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.grey.withValues(alpha: 0.05),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search locations...",
                        value: searchQuery,
                        hint: "Restaurant, park, coffee shop...",
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                          if (value.length > 2) {
                            _searchLocations();
                          }
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: isSearching ? Icons.hourglass_empty : Icons.search,
                      size: bs.sm,
                      onPressed: isSearching ? null : _searchLocations,
                    ),
                  ],
                ),
                
                if (isSearching)
                  Container(
                    margin: EdgeInsets.only(top: spSm),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(strokeWidth: 2),
                        SizedBox(width: spSm),
                        Text(
                          "Searching nearby locations...",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // Current Location Button
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(spMd),
            child: QButton(
              label: "Use Current Location",
              icon: Icons.my_location,
              size: bs.md,
              onPressed: () {
                ss("Using current location");
                back();
              },
            ),
          ),

          // Custom Location Input
          if (allowCustomLocation)
            Container(
              margin: EdgeInsets.symmetric(horizontal: spMd),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: Colors.grey.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Custom Location",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QTextField(
                    label: "Enter location name",
                    value: customLocationName,
                    hint: "e.g., My Home, Office, etc.",
                    onChanged: (value) {
                      customLocationName = value;
                      selectedLocationId = ""; // Clear selected location
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

          // Section Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            child: Text(
              "Nearby Locations",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),

          // Locations List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredLocations.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> location = filteredLocations[index];
                bool isSelected = selectedLocationId == location["id"];
                
                return GestureDetector(
                  onTap: () {
                    _selectLocation("${location["id"]}");
                    customLocationName = ""; // Clear custom location
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor.withValues(alpha: 0.1) : Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border.all(
                        color: isSelected ? primaryColor : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            _getCategoryIcon("${location["category"]}"),
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${location["name"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (location["verified"] as bool)
                                    Icon(
                                      Icons.verified,
                                      color: successColor,
                                      size: 16,
                                    ),
                                ],
                              ),
                              SizedBox(height: 2),
                              Text(
                                "${location["address"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: secondaryColor.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${location["category"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: secondaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(
                                    Icons.location_on,
                                    size: 12,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    "${(location["distance"] as double).toStringAsFixed(1)} km",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(
                                    Icons.people,
                                    size: 12,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    "${(location["checkins"] as int)} check-ins",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(width: spSm),
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: primaryColor,
                            size: 20,
                          )
                        else
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.withValues(alpha: 0.4),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Bottom Info
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.05),
              border: Border(
                top: BorderSide(
                  color: Colors.grey.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: infoColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Your location will be visible to your friends and followers",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
