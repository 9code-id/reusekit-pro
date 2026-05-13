import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaHotelSearchView extends StatefulWidget {
  const TtaHotelSearchView({super.key});

  @override
  State<TtaHotelSearchView> createState() => _TtaHotelSearchViewState();
}

class _TtaHotelSearchViewState extends State<TtaHotelSearchView> {
  String destination = "";
  String checkInDate = "2024-06-25";
  String checkOutDate = "2024-06-28";
  int rooms = 1;
  int adults = 2;
  int children = 0;
  String propertyType = "all";
  double minPrice = 0;
  double maxPrice = 500;
  List<String> amenities = [];
  
  List<Map<String, dynamic>> propertyTypes = [
    {"label": "All Properties", "value": "all"},
    {"label": "Hotels", "value": "hotel"},
    {"label": "Resorts", "value": "resort"},
    {"label": "Apartments", "value": "apartment"},
    {"label": "Villas", "value": "villa"},
    {"label": "Bed & Breakfast", "value": "bnb"},
  ];
  
  List<Map<String, dynamic>> amenityOptions = [
    {"label": "Free WiFi", "value": "wifi", "selected": false},
    {"label": "Pool", "value": "pool", "selected": false},
    {"label": "Spa", "value": "spa", "selected": false},
    {"label": "Gym", "value": "gym", "selected": false},
    {"label": "Restaurant", "value": "restaurant", "selected": false},
    {"label": "Pet Friendly", "value": "pet_friendly", "selected": false},
    {"label": "Business Center", "value": "business", "selected": false},
    {"label": "Airport Shuttle", "value": "shuttle", "selected": false},
  ];

  List<Map<String, dynamic>> popularDestinations = [
    {
      "name": "New York",
      "country": "United States",
      "image": "https://picsum.photos/150/100?random=1&keyword=newyork",
      "hotels": 1250,
      "avgPrice": 280,
    },
    {
      "name": "Paris",
      "country": "France", 
      "image": "https://picsum.photos/150/100?random=2&keyword=paris",
      "hotels": 890,
      "avgPrice": 195,
    },
    {
      "name": "Tokyo",
      "country": "Japan",
      "image": "https://picsum.photos/150/100?random=3&keyword=tokyo",
      "hotels": 650,
      "avgPrice": 220,
    },
    {
      "name": "London",
      "country": "United Kingdom",
      "image": "https://picsum.photos/150/100?random=4&keyword=london",
      "hotels": 780,
      "avgPrice": 240,
    },
    {
      "name": "Dubai",
      "country": "United Arab Emirates",
      "image": "https://picsum.photos/150/100?random=5&keyword=dubai",
      "hotels": 420,
      "avgPrice": 320,
    },
    {
      "name": "Bali",
      "country": "Indonesia",
      "image": "https://picsum.photos/150/100?random=6&keyword=bali",
      "hotels": 580,
      "avgPrice": 150,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Find Hotels"),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              si("Opening map view");
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showAdvancedFilters();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.hotel,
                    size: 48,
                    color: Colors.white,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Find Your Perfect Stay",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Search from thousands of hotels worldwide",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(Icons.search, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Search Hotels",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  QTextField(
                    label: "Destination",
                    value: destination,
                    hint: "Where are you going?",
                    onChanged: (value) {
                      destination = value;
                      setState(() {});
                    },
                  ),
                  
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDatePicker(
                          label: "Check-in",
                          value: DateTime.parse(checkInDate),
                          onChanged: (value) {
                            checkInDate = value.toString().split(' ')[0];
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDatePicker(
                          label: "Check-out",
                          value: DateTime.parse(checkOutDate),
                          onChanged: (value) {
                            checkOutDate = value.toString().split(' ')[0];
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: _buildGuestSelector("Rooms", rooms, Icons.meeting_room, (value) {
                          rooms = value;
                          setState(() {});
                        }),
                      ),
                      Expanded(
                        child: _buildGuestSelector("Adults", adults, Icons.person, (value) {
                          adults = value;
                          setState(() {});
                        }),
                      ),
                      Expanded(
                        child: _buildGuestSelector("Children", children, Icons.child_care, (value) {
                          children = value;
                          setState(() {});
                        }),
                      ),
                    ],
                  ),
                  
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Search Hotels",
                      size: bs.md,
                      icon: Icons.search,
                      onPressed: destination.isNotEmpty ? () {
                        //navigateTo(TtaHotelResultsView());
                        ss("Searching hotels in $destination...");
                      } : null,
                    ),
                  ),
                ],
              ),
            ),

            QCategoryPicker(
              label: "Property Type",
              items: propertyTypes,
              value: propertyType,
              onChanged: (index, label, value, item) {
                propertyType = value;
                setState(() {});
              },
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(Icons.tune, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Quick Filters",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Text(
                    "Price Range: \$${minPrice.toInt()} - \$${maxPrice.toInt()} per night",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  
                  RangeSlider(
                    values: RangeValues(minPrice, maxPrice),
                    min: 0,
                    max: 1000,
                    divisions: 20,
                    activeColor: primaryColor,
                    onChanged: (RangeValues values) {
                      minPrice = values.start;
                      maxPrice = values.end;
                      setState(() {});
                    },
                  ),
                  
                  Text(
                    "Popular Amenities",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  
                  Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: amenityOptions.take(4).map((amenity) {
                      bool isSelected = amenities.contains(amenity["value"]);
                      return GestureDetector(
                        onTap: () {
                          if (isSelected) {
                            amenities.remove(amenity["value"]);
                          } else {
                            amenities.add(amenity["value"]);
                          }
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.grey.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : Colors.grey.withAlpha(50),
                            ),
                          ),
                          child: Text(
                            "${amenity["label"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? Colors.white : disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(Icons.explore, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Popular Destinations",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  QHorizontalScroll(
                    children: popularDestinations.map((dest) {
                      return Container(
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusMd),
                                topRight: Radius.circular(radiusMd),
                              ),
                              child: Stack(
                                children: [
                                  Image.network(
                                    "${dest["image"]}",
                                    width: double.infinity,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    top: spSm,
                                    right: spSm,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withAlpha(120),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "${(dest["hotels"] as int)} hotels",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "${dest["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${dest["country"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Text(
                                        "From \$${(dest["avgPrice"] as int)}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "/night",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spSm),
                                  Container(
                                    width: double.infinity,
                                    child: QButton(
                                      label: "Explore",
                                      size: bs.sm,
                                      onPressed: () {
                                        destination = "${dest["name"]}";
                                        setState(() {});
                                        si("Destination set to ${dest["name"]}");
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.tips_and_updates, color: infoColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Booking Tips",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "• Book in advance for better rates\n• Check cancellation policies\n• Compare prices across dates\n• Read recent guest reviews\n• Consider location and transportation",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "My Bookings",
                    size: bs.md,
                    icon: Icons.bookmark,
                    onPressed: () {
                      si("Opening my bookings");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Saved Hotels",
                    size: bs.md,
                    icon: Icons.favorite,
                    onPressed: () {
                      si("Opening saved hotels");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuestSelector(String label, int value, IconData icon, Function(int) onChanged) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: Colors.grey.withAlpha(50)),
      ),
      child: Column(
        children: [
          Icon(icon, color: primaryColor, size: 16),
          SizedBox(height: spXs),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: value > (label == "Rooms" || label == "Adults" ? 1 : 0) ? () {
                  onChanged(value - 1);
                } : null,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: value > (label == "Rooms" || label == "Adults" ? 1 : 0) 
                        ? primaryColor 
                        : disabledColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.remove,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "$value",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: spSm),
              GestureDetector(
                onTap: value < 10 ? () {
                  onChanged(value + 1);
                } : null,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: value < 10 ? primaryColor : disabledColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAdvancedFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(50),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text(
              "Advanced Filters",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "All Amenities",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    ...amenityOptions.map((amenity) {
                      bool isSelected = amenities.contains(amenity["value"]);
                      return GestureDetector(
                        onTap: () {
                          if (isSelected) {
                            amenities.remove(amenity["value"]);
                          } else {
                            amenities.add(amenity["value"]);
                          }
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor.withAlpha(20) : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor.withAlpha(50) : Colors.grey.withAlpha(30),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isSelected ? Icons.check_circle : Icons.circle,
                                color: isSelected ? primaryColor : disabledBoldColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${amenity["label"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: isSelected ? primaryColor : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
            
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Clear All",
                    size: bs.md,
                    onPressed: () {
                      amenities.clear();
                      minPrice = 0;
                      maxPrice = 500;
                      setState(() {});
                      back();
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Apply Filters",
                    size: bs.md,
                    onPressed: () {
                      back();
                      ss("Filters applied successfully");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
