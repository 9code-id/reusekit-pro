import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaParkingLocatorView extends StatefulWidget {
  const CmaParkingLocatorView({super.key});

  @override
  State<CmaParkingLocatorView> createState() => _CmaParkingLocatorViewState();
}

class _CmaParkingLocatorViewState extends State<CmaParkingLocatorView> {
  List<Map<String, dynamic>> parkingSpots = [
    {
      "id": "PS001",
      "name": "Downtown Parking Garage",
      "address": "123 Main Street, San Francisco, CA",
      "distance": 0.5,
      "availableSpots": 45,
      "totalSpots": 120,
      "hourlyRate": 8.00,
      "maxDailyRate": 24.00,
      "amenities": ["EV Charging", "Covered", "Security"],
      "rating": 4.5,
      "reviews": 128,
      "isOpen": true,
      "operatingHours": "24/7",
      "latitude": 37.7749,
      "longitude": -122.4194,
      "type": "Garage"
    },
    {
      "id": "PS002", 
      "name": "Central Business District Lot",
      "address": "456 Market Street, San Francisco, CA",
      "distance": 0.8,
      "availableSpots": 12,
      "totalSpots": 80,
      "hourlyRate": 6.50,
      "maxDailyRate": 20.00,
      "amenities": ["Outdoor", "Validated Parking"],
      "rating": 4.2,
      "reviews": 86,
      "isOpen": true,
      "operatingHours": "6:00 AM - 10:00 PM",
      "latitude": 37.7849,
      "longitude": -122.4094,
      "type": "Lot"
    },
    {
      "id": "PS003",
      "name": "Shopping Mall Parking",
      "address": "789 Union Square, San Francisco, CA", 
      "distance": 1.2,
      "availableSpots": 0,
      "totalSpots": 200,
      "hourlyRate": 5.00,
      "maxDailyRate": 15.00,
      "amenities": ["Covered", "Retail Access", "Wheelchair Accessible"],
      "rating": 4.7,
      "reviews": 234,
      "isOpen": false,
      "operatingHours": "8:00 AM - 9:00 PM",
      "latitude": 37.7949,
      "longitude": -122.3994,
      "type": "Mall"
    },
    {
      "id": "PS004",
      "name": "Financial District Garage",
      "address": "321 Montgomery Street, San Francisco, CA",
      "distance": 0.3,
      "availableSpots": 78,
      "totalSpots": 150,
      "hourlyRate": 12.00,
      "maxDailyRate": 35.00,
      "amenities": ["Valet Service", "Car Wash", "EV Charging"],
      "rating": 4.8,
      "reviews": 156,
      "isOpen": true,
      "operatingHours": "24/7",
      "latitude": 37.7649,
      "longitude": -122.4294,
      "type": "Premium"
    }
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Garage", "value": "garage"},
    {"label": "Lot", "value": "lot"},
    {"label": "Mall", "value": "mall"},
    {"label": "Premium", "value": "premium"}
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Distance", "value": "distance"},
    {"label": "Price", "value": "price"},
    {"label": "Availability", "value": "availability"},
    {"label": "Rating", "value": "rating"}
  ];

  String selectedFilter = "all";
  String selectedSort = "distance";
  String searchQuery = "";
  bool showAvailableOnly = false;

  List<Map<String, dynamic>> get filteredParkingSpots {
    List<Map<String, dynamic>> filtered = parkingSpots.where((spot) {
      bool matchesType = selectedFilter == "all" || 
          (spot["type"] as String).toLowerCase() == selectedFilter.toLowerCase();
      bool matchesSearch = searchQuery.isEmpty ||
          (spot["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (spot["address"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesAvailability = !showAvailableOnly || 
          (spot["availableSpots"] as int) > 0;
      
      return matchesType && matchesSearch && matchesAvailability;
    }).toList();

    // Sort results
    filtered.sort((a, b) {
      switch (selectedSort) {
        case "distance":
          return (a["distance"] as double).compareTo(b["distance"] as double);
        case "price":
          return (a["hourlyRate"] as double).compareTo(b["hourlyRate"] as double);
        case "availability":
          return (b["availableSpots"] as int).compareTo(a["availableSpots"] as int);
        case "rating":
          return (b["rating"] as double).compareTo(a["rating"] as double);
        default:
          return 0;
      }
    });

    return filtered;
  }

  Color _getAvailabilityColor(int available, int total) {
    double percentage = available / total;
    if (percentage > 0.5) return successColor;
    if (percentage > 0.2) return warningColor;
    return dangerColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parking Locator"),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              // Navigate to map view
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Quick Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search parking spots...",
                          value: searchQuery,
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.gps_fixed,
                        size: bs.sm,
                        onPressed: () {
                          // Get current location
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Type",
                          items: filterOptions,
                          value: selectedFilter,
                          onChanged: (value, label) {
                            selectedFilter = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Sort by",
                          items: sortOptions,
                          value: selectedSort,
                          onChanged: (value, label) {
                            selectedSort = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Show available spots only",
                        "value": true,
                        "checked": showAvailableOnly,
                      }
                    ],
                    value: [
                      if (showAvailableOnly)
                        {
                          "label": "Show available spots only",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      setState(() {
                        showAvailableOnly = values.isNotEmpty;
                      });
                    },
                  ),
                ],
              ),
            ),

            // Results Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.local_parking,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Found ${filteredParkingSpots.length} parking spots near you",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Parking Spots List
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredParkingSpots.length,
              separatorBuilder: (context, index) => SizedBox(height: spSm),
              itemBuilder: (context, index) {
                final spot = filteredParkingSpots[index];
                final availabilityColor = _getAvailabilityColor(
                  spot["availableSpots"] as int,
                  spot["totalSpots"] as int,
                );
                
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: (spot["availableSpots"] as int) > 0 
                          ? successColor.withAlpha(100)
                          : disabledOutlineBorderColor,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${spot["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: primaryColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "${spot["type"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${spot["address"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: availabilityColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${spot["availableSpots"]}/${spot["totalSpots"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: availabilityColor,
                                  ),
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${(spot["distance"] as double).toStringAsFixed(1)} mi",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      
                      // Pricing and Rating
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.attach_money,
                                  color: successColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "\$${(spot["hourlyRate"] as double).currency}/hr",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  " • Max \$${(spot["maxDailyRate"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: warningColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${(spot["rating"] as double).toStringAsFixed(1)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                " (${spot["reviews"]})",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),

                      // Operating Hours and Status
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  color: disabledBoldColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${spot["operatingHours"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
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
                              color: (spot["isOpen"] as bool) 
                                  ? successColor.withAlpha(20)
                                  : dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              (spot["isOpen"] as bool) ? "Open" : "Closed",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: (spot["isOpen"] as bool) ? successColor : dangerColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),

                      // Amenities
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (spot["amenities"] as List).map<Widget>((amenity) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "$amenity",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
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
                              label: "Directions",
                              icon: Icons.directions,
                              size: bs.sm,
                              onPressed: () {
                                // Navigate to directions
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Reserve",
                              icon: Icons.book_online,
                              size: bs.sm,
                              onPressed: (spot["availableSpots"] as int) > 0 ? () {
                                // Navigate to reservation
                              } : null,
                            ),
                          ),
                        ],
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
}
