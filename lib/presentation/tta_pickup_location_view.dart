import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaPickupLocationView extends StatefulWidget {
  const TtaPickupLocationView({super.key});

  @override
  State<TtaPickupLocationView> createState() => _TtaPickupLocationViewState();
}

class _TtaPickupLocationViewState extends State<TtaPickupLocationView> {
  String searchQuery = "";
  String selectedLocation = "";
  String filterType = "All";

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Locations", "value": "All"},
    {"label": "Airport", "value": "Airport"},
    {"label": "Hotel", "value": "Hotel"},
    {"label": "Train Station", "value": "Train Station"},
    {"label": "Shopping Center", "value": "Shopping Center"},
    {"label": "City Center", "value": "City Center"},
  ];

  List<Map<String, dynamic>> locations = [
    {
      "name": "John F. Kennedy International Airport",
      "address": "Queens, NY 11430, United States",
      "type": "Airport",
      "distance": 15.2,
      "rating": 4.5,
      "reviews": 1250,
      "openHours": "24/7",
      "phone": "+1 (718) 244-4444",
      "amenities": ["Free Shuttle", "Car Wash", "GPS", "Child Seats"],
      "lat": 40.6413,
      "lng": -73.7781,
      "isOpen": true,
      "hasAvailableCars": true,
      "image": "https://picsum.photos/300/200?random=1&keyword=airport",
    },
    {
      "name": "Grand Central Terminal",
      "address": "89 E 42nd St, New York, NY 10017, USA",
      "type": "Train Station",
      "distance": 2.8,
      "rating": 4.7,
      "reviews": 890,
      "openHours": "6:00 AM - 11:00 PM",
      "phone": "+1 (212) 340-2583",
      "amenities": ["Valet Service", "Express Pickup", "GPS", "Insurance"],
      "lat": 40.7527,
      "lng": -73.9772,
      "isOpen": true,
      "hasAvailableCars": true,
      "image": "https://picsum.photos/300/200?random=2&keyword=station",
    },
    {
      "name": "Times Square Marriott",
      "address": "1535 Broadway, New York, NY 10036, USA",
      "type": "Hotel",
      "distance": 1.5,
      "rating": 4.3,
      "reviews": 567,
      "openHours": "24/7",
      "phone": "+1 (212) 398-1900",
      "amenities": ["Concierge Service", "Valet Parking", "GPS"],
      "lat": 40.7590,
      "lng": -73.9845,
      "isOpen": true,
      "hasAvailableCars": true,
      "image": "https://picsum.photos/300/200?random=3&keyword=hotel",
    },
    {
      "name": "Brooklyn Bridge Plaza",
      "address": "300 Cadman Plaza W, Brooklyn, NY 11201, USA",
      "type": "City Center",
      "distance": 5.7,
      "rating": 4.2,
      "reviews": 423,
      "openHours": "7:00 AM - 9:00 PM",
      "phone": "+1 (718) 596-2222",
      "amenities": ["Free Parking", "Car Wash", "Child Seats"],
      "lat": 40.6974,
      "lng": -73.9776,
      "isOpen": true,
      "hasAvailableCars": false,
      "image": "https://picsum.photos/300/200?random=4&keyword=city",
    },
    {
      "name": "Westfield World Trade Center",
      "address": "185 Greenwich St, New York, NY 10007, USA",
      "type": "Shopping Center",
      "distance": 3.2,
      "rating": 4.4,
      "reviews": 678,
      "openHours": "10:00 AM - 9:00 PM",
      "phone": "+1 (212) 284-9982",
      "amenities": ["Valet Service", "GPS", "Insurance", "Car Wash"],
      "lat": 40.7115,
      "lng": -74.0134,
      "isOpen": false,
      "hasAvailableCars": true,
      "image": "https://picsum.photos/300/200?random=5&keyword=shopping",
    },
    {
      "name": "LaGuardia Airport Terminal B",
      "address": "LaGuardia Airport, Queens, NY 11371, USA",
      "type": "Airport",
      "distance": 12.8,
      "rating": 4.1,
      "reviews": 934,
      "openHours": "24/7",
      "phone": "+1 (718) 533-3400",
      "amenities": ["Free Shuttle", "Express Pickup", "GPS", "Child Seats"],
      "lat": 40.7769,
      "lng": -73.8740,
      "isOpen": true,
      "hasAvailableCars": true,
      "image": "https://picsum.photos/300/200?random=6&keyword=airport",
    },
    {
      "name": "Hudson Yards Mall",
      "address": "20 Hudson Yards, New York, NY 10001, USA",
      "type": "Shopping Center",
      "distance": 4.1,
      "rating": 4.6,
      "reviews": 512,
      "openHours": "10:00 AM - 8:00 PM",
      "phone": "+1 (212) 805-4650",
      "amenities": ["Valet Parking", "Car Wash", "GPS", "Insurance"],
      "lat": 40.7539,
      "lng": -74.0018,
      "isOpen": true,
      "hasAvailableCars": true,
      "image": "https://picsum.photos/300/200?random=7&keyword=mall",
    },
    {
      "name": "The Plaza Hotel",
      "address": "768 5th Ave, New York, NY 10019, USA",
      "type": "Hotel",
      "distance": 2.1,
      "rating": 4.8,
      "reviews": 789,
      "openHours": "24/7",
      "phone": "+1 (212) 759-3000",
      "amenities": ["Concierge Service", "Valet Parking", "Premium Cars"],
      "lat": 40.7643,
      "lng": -73.9759,
      "isOpen": true,
      "hasAvailableCars": true,
      "image": "https://picsum.photos/300/200?random=8&keyword=hotel",
    },
  ];

  List<Map<String, dynamic>> get filteredLocations {
    return locations.where((location) {
      bool typeMatch = filterType == "All" || location["type"] == filterType;
      bool searchMatch = searchQuery.isEmpty ||
                        (location["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
                        (location["address"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return typeMatch && searchMatch;
    }).toList()..sort((a, b) => (a["distance"] as double).compareTo(b["distance"] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pickup Locations"),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              ss("Map view opened");
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterSheet();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search locations...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Filter Chips
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: QCategoryPicker(
              items: filterOptions,
              value: filterType,
              onChanged: (index, label, value, item) {
                filterType = value;
                setState(() {});
              },
            ),
          ),

          SizedBox(height: spSm),

          // Results Count
          Padding(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: [
                Text(
                  "${filteredLocations.length} location${filteredLocations.length != 1 ? 's' : ''} found",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    ss("Sort options opened");
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.sort,
                        color: primaryColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Sort by distance",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spSm),

          // Locations List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredLocations.length,
              itemBuilder: (context, index) {
                final location = filteredLocations[index];
                final isOpen = location["isOpen"] as bool;
                final hasAvailableCars = location["hasAvailableCars"] as bool;
                final isSelected = selectedLocation == location["name"];
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withAlpha(30) : Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Location Image
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusMd),
                          topRight: Radius.circular(radiusMd),
                        ),
                        child: Stack(
                          children: [
                            Image.network(
                              "${location["image"]}",
                              width: double.infinity,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: _getTypeColor(location["type"] as String).withAlpha(230),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      _getTypeIcon(location["type"] as String),
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${location["type"]}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: (isOpen ? successColor : dangerColor).withAlpha(230),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  isOpen ? "Open" : "Closed",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            if (!hasAvailableCars)
                              Positioned.fill(
                                child: Container(
                                  color: Colors.black.withAlpha(120),
                                  child: Center(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spMd,
                                        vertical: spSm,
                                      ),
                                      decoration: BoxDecoration(
                                        color: warningColor,
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "No Cars Available",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      // Location Details
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${location["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${(location["distance"] as double).toStringAsFixed(1)} mi",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: infoColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: dangerColor,
                                  size: 14,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${location["address"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.star, color: warningColor, size: 14),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${location["rating"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      " (${location["reviews"]})",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: spMd),
                                Row(
                                  children: [
                                    Icon(Icons.schedule, color: infoColor, size: 14),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${location["openHours"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: spMd),
                            
                            // Amenities
                            Text(
                              "Amenities:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (location["amenities"] as List).map((amenity) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "$amenity",
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
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
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          ss("Calling ${location["phone"]}");
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(spSm),
                                          decoration: BoxDecoration(
                                            color: successColor.withAlpha(30),
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: Icon(
                                            Icons.phone,
                                            color: successColor,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      GestureDetector(
                                        onTap: () {
                                          ss("Opening directions to ${location["name"]}");
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(spSm),
                                          decoration: BoxDecoration(
                                            color: infoColor.withAlpha(30),
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: Icon(
                                            Icons.directions,
                                            color: infoColor,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                QButton(
                                  label: isSelected ? "Selected" : (hasAvailableCars && isOpen ? "Select Location" : "Unavailable"),
                                  size: bs.sm,
                                  onPressed: (hasAvailableCars && isOpen) ? () {
                                    selectedLocation = isSelected ? "" : location["name"] as String;
                                    setState(() {});
                                    if (!isSelected) {
                                      ss("${location["name"]} selected as pickup location");
                                    }
                                  } : null,
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
      floatingActionButton: selectedLocation.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                ss("Confirming pickup location: $selectedLocation");
              },
              backgroundColor: primaryColor,
              label: Text(
                "Confirm Location",
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(Icons.check, color: Colors.white),
            )
          : null,
    );
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "Airport":
        return Icons.flight;
      case "Hotel":
        return Icons.hotel;
      case "Train Station":
        return Icons.train;
      case "Shopping Center":
        return Icons.shopping_cart;
      case "City Center":
        return Icons.location_city;
      default:
        return Icons.location_on;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Airport":
        return infoColor;
      case "Hotel":
        return primaryColor;
      case "Train Station":
        return successColor;
      case "Shopping Center":
        return warningColor;
      case "City Center":
        return secondaryColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    "Filter Locations",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              QDropdownField(
                label: "Location Type",
                items: filterOptions,
                value: filterType,
                onChanged: (value, label) {
                  filterType = value;
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: spMd),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Apply Filter",
                  size: bs.md,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
