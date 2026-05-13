import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaVenueListView extends StatefulWidget {
  const EmaVenueListView({super.key});

  @override
  State<EmaVenueListView> createState() => _EmaVenueListViewState();
}

class _EmaVenueListViewState extends State<EmaVenueListView> {
  String searchQuery = "";
  String selectedCategory = "";
  String selectedRating = "";
  String selectedPrice = "";
  String selectedLocation = "";
  String sortBy = "distance";
  bool showMap = false;
  
  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": ""},
    {"label": "Conference Centers", "value": "conference"},
    {"label": "Hotels", "value": "hotels"},
    {"label": "Restaurants", "value": "restaurants"},
    {"label": "Event Halls", "value": "halls"},
    {"label": "Outdoor Spaces", "value": "outdoor"},
    {"label": "Coworking Spaces", "value": "coworking"},
  ];

  List<Map<String, dynamic>> ratingFilters = [
    {"label": "All Ratings", "value": ""},
    {"label": "4+ Stars", "value": "4+"},
    {"label": "3+ Stars", "value": "3+"},
    {"label": "2+ Stars", "value": "2+"},
  ];

  List<Map<String, dynamic>> priceFilters = [
    {"label": "All Prices", "value": ""},
    {"label": "Budget (\$)", "value": "budget"},
    {"label": "Moderate (\$\$)", "value": "moderate"},
    {"label": "Premium (\$\$\$)", "value": "premium"},
    {"label": "Luxury (\$\$\$\$)", "value": "luxury"},
  ];

  List<Map<String, dynamic>> venues = [
    {
      "id": "1",
      "name": "Grand Convention Center",
      "category": "Conference Centers",
      "location": "Downtown District",
      "address": "123 Main Street, City Center",
      "distance": "0.8 km",
      "rating": 4.8,
      "reviews": 342,
      "price": "premium",
      "priceRange": "\$\$\$",
      "capacity": 1500,
      "amenities": ["WiFi", "Parking", "Catering", "AV Equipment"],
      "image": "https://picsum.photos/300/200?random=1&keyword=convention",
      "available": true,
      "featuredSpaces": [
        {"name": "Main Hall", "capacity": 800},
        {"name": "Conference Room A", "capacity": 150},
        {"name": "Exhibition Area", "capacity": 500},
      ],
    },
    {
      "id": "2", 
      "name": "Riverside Hotel & Spa",
      "category": "Hotels",
      "location": "Waterfront",
      "address": "456 River Road, Waterfront District",
      "distance": "1.2 km",
      "rating": 4.6,
      "reviews": 289,
      "price": "luxury",
      "priceRange": "\$\$\$\$",
      "capacity": 800,
      "amenities": ["Pool", "Spa", "Restaurant", "Valet Parking"],
      "image": "https://picsum.photos/300/200?random=2&keyword=hotel",
      "available": true,
      "featuredSpaces": [
        {"name": "Grand Ballroom", "capacity": 400},
        {"name": "Rooftop Terrace", "capacity": 200},
        {"name": "Garden Pavilion", "capacity": 150},
      ],
    },
    {
      "id": "3",
      "name": "The Modern Loft",
      "category": "Event Halls", 
      "location": "Arts District",
      "address": "789 Creative Avenue, Arts District",
      "distance": "2.1 km",
      "rating": 4.4,
      "reviews": 156,
      "price": "moderate",
      "priceRange": "\$\$",
      "capacity": 300,
      "amenities": ["Industrial Design", "Sound System", "Bar Area"],
      "image": "https://picsum.photos/300/200?random=3&keyword=loft",
      "available": false,
      "featuredSpaces": [
        {"name": "Main Loft", "capacity": 200},
        {"name": "Mezzanine", "capacity": 100},
      ],
    },
    {
      "id": "4",
      "name": "Skyline Restaurant",
      "category": "Restaurants",
      "location": "Business District",
      "address": "321 Tower Street, Floor 25",
      "distance": "1.5 km",
      "rating": 4.7,
      "reviews": 428,
      "price": "premium",
      "priceRange": "\$\$\$",
      "capacity": 120,
      "amenities": ["City Views", "Fine Dining", "Private Rooms"],
      "image": "https://picsum.photos/300/200?random=4&keyword=restaurant",
      "available": true,
      "featuredSpaces": [
        {"name": "Main Dining", "capacity": 80},
        {"name": "Private Room", "capacity": 40},
      ],
    },
    {
      "id": "5",
      "name": "Central Park Pavilion",
      "category": "Outdoor Spaces",
      "location": "Central Park",
      "address": "Central Park, Section C",
      "distance": "3.2 km",
      "rating": 4.2,
      "reviews": 89,
      "price": "budget",
      "priceRange": "\$",
      "capacity": 500,
      "amenities": ["Natural Setting", "Gazebo", "Parking"],
      "image": "https://picsum.photos/300/200?random=5&keyword=park",
      "available": true,
      "featuredSpaces": [
        {"name": "Main Pavilion", "capacity": 300},
        {"name": "Garden Area", "capacity": 200},
      ],
    },
    {
      "id": "6",
      "name": "TechHub Coworking",
      "category": "Coworking Spaces",
      "location": "Tech Quarter",
      "address": "654 Innovation Drive, Tech Quarter",
      "distance": "2.8 km", 
      "rating": 4.5,
      "reviews": 203,
      "price": "moderate",
      "priceRange": "\$\$",
      "capacity": 200,
      "amenities": ["High-Speed Internet", "Meeting Rooms", "Coffee Bar"],
      "image": "https://picsum.photos/300/200?random=6&keyword=coworking",
      "available": true,
      "featuredSpaces": [
        {"name": "Main Space", "capacity": 120},
        {"name": "Conference Room", "capacity": 50},
        {"name": "Event Area", "capacity": 80},
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredVenues {
    return venues.where((venue) {
      bool matchesSearch = searchQuery.isEmpty || 
          "${venue["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${venue["location"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory.isEmpty || 
          "${venue["category"]}".toLowerCase().contains(selectedCategory.toLowerCase());
      
      bool matchesRating = selectedRating.isEmpty || 
          (selectedRating == "4+" && (venue["rating"] as double) >= 4.0) ||
          (selectedRating == "3+" && (venue["rating"] as double) >= 3.0) ||
          (selectedRating == "2+" && (venue["rating"] as double) >= 2.0);
      
      bool matchesPrice = selectedPrice.isEmpty || venue["price"] == selectedPrice;
      
      return matchesSearch && matchesCategory && matchesRating && matchesPrice;
    }).toList();
  }

  void _sortVenues() {
    filteredVenues.sort((a, b) {
      switch (sortBy) {
        case "distance":
          return double.parse("${a["distance"]}".replaceAll(" km", ""))
              .compareTo(double.parse("${b["distance"]}".replaceAll(" km", "")));
        case "rating":
          return (b["rating"] as double).compareTo(a["rating"] as double);
        case "price":
          List<String> priceOrder = ["budget", "moderate", "premium", "luxury"];
          return priceOrder.indexOf("${a["price"]}")
              .compareTo(priceOrder.indexOf("${b["price"]}"));
        case "capacity":
          return (b["capacity"] as int).compareTo(a["capacity"] as int);
        default:
          return 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _sortVenues();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Find Venues"),
        actions: [
          IconButton(
            icon: Icon(showMap ? Icons.list : Icons.map),
            onPressed: () {
              showMap = !showMap;
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Quick Filters
            _buildSearchSection(),
            
            // Filter and Sort Controls
            _buildFilterSection(),
            
            // Results Count
            _buildResultsHeader(),
            
            // Map or List View
            if (showMap) _buildMapView() else _buildVenuesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(204)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.search, color: Colors.white, size: 24),
              SizedBox(width: spSm),
              Text(
                "Find Perfect Venues",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search venues or locations",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.tune,
                size: bs.sm,
                onPressed: () {
                  // Navigate to advanced filters
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
                  label: "Rating",
                  items: ratingFilters,
                  value: selectedRating,
                  onChanged: (value, label) {
                    selectedRating = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Price Range",
                  items: priceFilters,
                  value: selectedPrice,
                  onChanged: (value, label) {
                    selectedPrice = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Sort by",
                  items: [
                    {"label": "Distance", "value": "distance"},
                    {"label": "Rating", "value": "rating"},
                    {"label": "Price", "value": "price"},
                    {"label": "Capacity", "value": "capacity"},
                  ],
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
    );
  }

  Widget _buildResultsHeader() {
    return Row(
      children: [
        Text(
          "${filteredVenues.length} venues found",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Spacer(),
        QButton(
          label: "Clear Filters",
          size: bs.sm,
          onPressed: () {
            searchQuery = "";
            selectedCategory = "";
            selectedRating = "";
            selectedPrice = "";
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildMapView() {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: disabledColor,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Stack(
        children: [
          // Map placeholder
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map, size: 48, color: disabledBoldColor),
                  SizedBox(height: spSm),
                  Text(
                    "Map View",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${filteredVenues.length} venues in this area",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Map controls
          Positioned(
            top: spSm,
            right: spSm,
            child: Column(
              spacing: spXs,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: IconButton(
                    icon: Icon(Icons.my_location),
                    onPressed: () {
                      ss("Finding your location...");
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: IconButton(
                    icon: Icon(Icons.fullscreen),
                    onPressed: () {
                      // Navigate to full map view
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

  Widget _buildVenuesList() {
    if (filteredVenues.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spLg),
        child: Column(
          children: [
            Icon(Icons.location_off, size: 64, color: disabledBoldColor),
            SizedBox(height: spMd),
            Text(
              "No venues found",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Try adjusting your search criteria",
              style: TextStyle(color: disabledBoldColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: filteredVenues.map((venue) {
        return _buildVenueCard(venue);
      }).toList(),
    );
  }

  Widget _buildVenueCard(Map<String, dynamic> venue) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Venue Image
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Image.network(
                  "${venue["image"]}",
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              
              // Availability badge
              Positioned(
                top: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: venue["available"] ? successColor : dangerColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    venue["available"] ? "Available" : "Booked",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              
              // Price badge
              Positioned(
                top: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(230),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${venue["priceRange"]}",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          // Venue Details
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${venue["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                
                Text(
                  "${venue["category"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${venue["location"]} • ${venue["distance"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                
                Row(
                  children: [
                    Icon(Icons.star, size: 16, color: warningColor),
                    SizedBox(width: spXs),
                    Text(
                      "${venue["rating"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "(${venue["reviews"]} reviews)",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                Row(
                  children: [
                    Icon(Icons.people, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "Up to ${venue["capacity"]} guests",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                // Featured spaces
                if ((venue["featuredSpaces"] as List).isNotEmpty)
                  Container(
                    margin: EdgeInsets.only(top: spXs),
                    child: Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (venue["featuredSpaces"] as List).take(2).map((space) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${space["name"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                
                SizedBox(height: spSm),
                
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to venue detail
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.favorite_border,
                      size: bs.sm,
                      onPressed: () {
                        ss("Added to favorites");
                      },
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
}
