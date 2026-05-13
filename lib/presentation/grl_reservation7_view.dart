import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReservation7View extends StatefulWidget {
  @override
  State<GrlReservation7View> createState() => _GrlReservation7ViewState();
}

class _GrlReservation7ViewState extends State<GrlReservation7View> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedLocation = "All Locations";
  String selectedPriceRange = "Any Price";
  String selectedRating = "Any Rating";
  bool isMapView = false;

  List<Map<String, dynamic>> venues = [
    {
      "id": "1",
      "name": "Ocean View Resort",
      "category": "Hotel",
      "location": "Miami Beach, FL",
      "rating": 4.8,
      "reviews": 1250,
      "priceRange": "\$\$\$",
      "price": 180.0,
      "image": "https://picsum.photos/400/250?random=1&keyword=resort",
      "amenities": ["Pool", "Beach Access", "Spa", "Restaurant"],
      "distance": "2.3 miles",
      "available": true,
      "featured": true
    },
    {
      "id": "2",
      "name": "La Petite Maison",
      "category": "Restaurant",
      "location": "Beverly Hills, CA",
      "rating": 4.9,
      "reviews": 890,
      "priceRange": "\$\$\$\$",
      "price": 85.0,
      "image": "https://picsum.photos/400/250?random=2&keyword=restaurant",
      "amenities": ["French Cuisine", "Wine Bar", "Outdoor Seating"],
      "distance": "1.8 miles",
      "available": true,
      "featured": false
    },
    {
      "id": "3",
      "name": "Metropolitan Conference Center",
      "category": "Event Venue",
      "location": "Chicago, IL",
      "rating": 4.6,
      "reviews": 430,
      "priceRange": "\$\$",
      "price": 250.0,
      "image": "https://picsum.photos/400/250?random=3&keyword=conference",
      "amenities": ["AV Equipment", "Catering", "Parking", "WiFi"],
      "distance": "3.7 miles",
      "available": false,
      "featured": true
    },
    {
      "id": "4",
      "name": "Skyline Lounge",
      "category": "Bar",
      "location": "New York, NY",
      "rating": 4.7,
      "reviews": 670,
      "priceRange": "\$\$\$",
      "price": 45.0,
      "image": "https://picsum.photos/400/250?random=4&keyword=rooftop",
      "amenities": ["Rooftop", "City View", "Live Music", "Cocktails"],
      "distance": "0.9 miles",
      "available": true,
      "featured": false
    },
    {
      "id": "5",
      "name": "Wellness Spa & Retreat",
      "category": "Spa",
      "location": "Sedona, AZ",
      "rating": 4.9,
      "reviews": 320,
      "priceRange": "\$\$\$",
      "price": 120.0,
      "image": "https://picsum.photos/400/250?random=5&keyword=spa",
      "amenities": ["Massage", "Yoga", "Meditation", "Organic Food"],
      "distance": "5.2 miles",
      "available": true,
      "featured": true
    },
    {
      "id": "6",
      "name": "Adventure Sports Center",
      "category": "Recreation",
      "location": "Denver, CO",
      "rating": 4.4,
      "reviews": 540,
      "priceRange": "\$\$",
      "price": 75.0,
      "image": "https://picsum.photos/400/250?random=6&keyword=adventure",
      "amenities": ["Rock Climbing", "Kayaking", "Equipment Rental"],
      "distance": "4.1 miles",
      "available": true,
      "featured": false
    }
  ];

  List<String> categories = ["All", "Hotel", "Restaurant", "Event Venue", "Bar", "Spa", "Recreation"];
  List<String> locations = ["All Locations", "Miami Beach, FL", "Beverly Hills, CA", "Chicago, IL", "New York, NY", "Sedona, AZ", "Denver, CO"];
  List<String> priceRanges = ["Any Price", "\$", "\$\$", "\$\$\$", "\$\$\$\$"];
  List<String> ratings = ["Any Rating", "4.5+", "4.0+", "3.5+"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Find Venues"),
        actions: [
          IconButton(
            icon: Icon(isMapView ? Icons.list : Icons.map),
            onPressed: () {
              isMapView = !isMapView;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchSection(),
          _buildQuickFilters(),
          Expanded(
            child: isMapView ? _buildMapView() : _buildListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search venues, locations...",
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
                  // Perform search
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFilters() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      color: Colors.white,
      child: Column(
        children: [
          QCategoryPicker(
            items: categories.map((category) => {
              "label": category,
              "value": category,
            }).toList(),
            value: selectedCategory,
            onChanged: (index, label, value, item) {
              selectedCategory = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
        ],
      ),
    );
  }

  Widget _buildListView() {
    List<Map<String, dynamic>> filteredVenues = _getFilteredVenues();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "${filteredVenues.length} venues found",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.sort, size: 16, color: primaryColor),
                    SizedBox(width: spXs),
                    Text(
                      "Sort by Distance",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          // Featured venues section
          if (filteredVenues.any((venue) => venue["featured"])) ...[
            Text(
              "Featured Venues",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Container(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filteredVenues.where((venue) => venue["featured"]).length,
                itemBuilder: (context, index) {
                  final featuredVenues = filteredVenues.where((venue) => venue["featured"]).toList();
                  return Container(
                    width: 280,
                    margin: EdgeInsets.only(right: spSm),
                    child: _buildFeaturedVenueCard(featuredVenues[index]),
                  );
                },
              ),
            ),
            SizedBox(height: spMd),
          ],

          // All venues section
          Text(
            "All Venues",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          ...filteredVenues.map((venue) {
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              child: _buildVenueCard(venue),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildFeaturedVenueCard(Map<String, dynamic> venue) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                child: Image.network(
                  "${venue["image"]}",
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                  decoration: BoxDecoration(
                    color: warningColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "FEATURED",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: spSm,
                right: spSm,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(200),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.favorite_border,
                    color: primaryColor,
                    size: 20,
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
                  "${venue["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        "${venue["location"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: Colors.white, size: 12),
                          SizedBox(width: 2),
                          Text(
                            "${venue["rating"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "(${venue["reviews"]})",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "From \$${(venue["price"] as double).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
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
  }

  Widget _buildVenueCard(Map<String, dynamic> venue) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(radiusLg)),
            child: Stack(
              children: [
                Image.network(
                  "${venue["image"]}",
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                if (!venue["available"])
                  Container(
                    width: 120,
                    height: 120,
                    color: Colors.black.withAlpha(100),
                    child: Center(
                      child: Text(
                        "UNAVAILABLE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
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
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${venue["category"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.favorite_border,
                        size: 18,
                        color: disabledBoldColor,
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${venue["name"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "${venue["location"]} • ${venue["distance"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: Colors.white, size: 12),
                            SizedBox(width: 2),
                            Text(
                              "${venue["rating"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "(${venue["reviews"]})",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${venue["priceRange"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Wrap(
                    spacing: 4,
                    children: (venue["amenities"] as List).take(3).map((amenity) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "$amenity",
                          style: TextStyle(
                            fontSize: 10,
                            color: infoColor,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Text(
                        "From \$${(venue["price"] as double).toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: venue["available"] ? "Book Now" : "Contact",
                        size: bs.sm,
                        color: venue["available"] ? primaryColor : disabledBoldColor,
                        onPressed: () {
                          _bookVenue(venue);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapView() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.map,
                      size: 64,
                      color: primaryColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Map View",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Interactive map with venue locations",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "List View",
                  color: disabledBoldColor,
                  size: bs.md,
                  onPressed: () {
                    isMapView = false;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Directions",
                  size: bs.md,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredVenues() {
    List<Map<String, dynamic>> filtered = venues;

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((venue) {
        return venue["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               venue["location"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               venue["category"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    if (selectedCategory != "All") {
      filtered = filtered.where((venue) => venue["category"] == selectedCategory).toList();
    }

    return filtered;
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Advanced Filters"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Location"),
              SizedBox(height: spXs),
              QDropdownField(
                label: "Select Location",
                value: selectedLocation,
                items: locations.map((location) => {
                  "label": location,
                  "value": location,
                }).toList(),
                onChanged: (value, label) {
                  selectedLocation = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              
              Text("Price Range"),
              SizedBox(height: spXs),
              QDropdownField(
                label: "Select Price Range",
                value: selectedPriceRange,
                items: priceRanges.map((range) => {
                  "label": range,
                  "value": range,
                }).toList(),
                onChanged: (value, label) {
                  selectedPriceRange = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              
              Text("Minimum Rating"),
              SizedBox(height: spXs),
              QDropdownField(
                label: "Select Rating",
                value: selectedRating,
                items: ratings.map((rating) => {
                  "label": rating,
                  "value": rating,
                }).toList(),
                onChanged: (value, label) {
                  selectedRating = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Reset filters
              selectedLocation = "All Locations";
              selectedPriceRange = "Any Price";
              selectedRating = "Any Rating";
              setState(() {});
              Navigator.pop(context);
            },
            child: Text("Reset"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {});
            },
            child: Text("Apply"),
          ),
        ],
      ),
    );
  }

  void _bookVenue(Map<String, dynamic> venue) {
    if (venue["available"]) {
      ss("Redirecting to booking page for ${venue["name"]}");
    } else {
      si("Contacting venue for availability");
    }
  }
}
