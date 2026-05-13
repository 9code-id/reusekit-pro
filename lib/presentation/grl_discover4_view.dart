import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDiscover4View extends StatefulWidget {
  @override
  State<GrlDiscover4View> createState() => _GrlDiscover4ViewState();
}

class _GrlDiscover4ViewState extends State<GrlDiscover4View> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedPriceRange = "Any";
  String selectedLocation = "Anywhere";
  bool showFilters = false;
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Hotels", "value": "Hotels"},
    {"label": "Restaurants", "value": "Restaurants"},
    {"label": "Activities", "value": "Activities"},
    {"label": "Transportation", "value": "Transportation"},
  ];
  
  List<Map<String, dynamic>> priceRanges = [
    {"label": "Any", "value": "Any"},
    {"label": "\$1-50", "value": "1-50"},
    {"label": "\$51-100", "value": "51-100"},
    {"label": "\$101-200", "value": "101-200"},
    {"label": "\$200+", "value": "200+"},
  ];
  
  List<Map<String, dynamic>> locations = [
    {"label": "Anywhere", "value": "Anywhere"},
    {"label": "New York", "value": "New York"},
    {"label": "Los Angeles", "value": "Los Angeles"},
    {"label": "Chicago", "value": "Chicago"},
    {"label": "Miami", "value": "Miami"},
  ];
  
  List<Map<String, dynamic>> destinations = [
    {
      "id": 1,
      "name": "Grand Canyon National Park",
      "location": "Arizona, USA",
      "category": "Activities",
      "price": 45.0,
      "rating": 4.8,
      "reviews": 2847,
      "image": "https://picsum.photos/300/200?random=1&keyword=canyon",
      "description": "Experience breathtaking views and hiking trails at one of America's most iconic landmarks.",
      "duration": "Full Day",
      "features": ["Guided Tours", "Photography", "Hiking", "Scenic Views"],
      "isBookmarked": false,
    },
    {
      "id": 2,
      "name": "Luxury Ocean Resort",
      "location": "Malibu, CA",
      "category": "Hotels",
      "price": 350.0,
      "rating": 4.9,
      "reviews": 1256,
      "image": "https://picsum.photos/300/200?random=2&keyword=resort",
      "description": "Beachfront luxury resort with world-class amenities and stunning ocean views.",
      "duration": "Per Night",
      "features": ["Ocean View", "Spa", "Pool", "Fine Dining"],
      "isBookmarked": true,
    },
    {
      "id": 3,
      "name": "Metropolitan Food Tour",
      "location": "New York, NY",
      "category": "Restaurants",
      "price": 85.0,
      "rating": 4.7,
      "reviews": 892,
      "image": "https://picsum.photos/300/200?random=3&keyword=food",
      "description": "Discover the best local cuisine with our expert food guides through the city.",
      "duration": "4 Hours",
      "features": ["Local Cuisine", "Expert Guide", "Multiple Stops", "Tastings"],
      "isBookmarked": false,
    },
    {
      "id": 4,
      "name": "Private Helicopter Tour",
      "location": "Los Angeles, CA",
      "category": "Transportation",
      "price": 299.0,
      "rating": 4.9,
      "reviews": 567,
      "image": "https://picsum.photos/300/200?random=4&keyword=helicopter",
      "description": "See the city from above with our premium helicopter tour experience.",
      "duration": "1 Hour",
      "features": ["Aerial Views", "Professional Pilot", "Photo Opportunities", "Luxury"],
      "isBookmarked": true,
    },
    {
      "id": 5,
      "name": "Art Museum Experience",
      "location": "Chicago, IL",
      "category": "Activities",
      "price": 25.0,
      "rating": 4.6,
      "reviews": 1423,
      "image": "https://picsum.photos/300/200?random=5&keyword=museum",
      "description": "Explore world-renowned art collections with interactive exhibits and guided tours.",
      "duration": "3 Hours",
      "features": ["Art Collections", "Interactive Exhibits", "Audio Guide", "Gift Shop"],
      "isBookmarked": false,
    },
    {
      "id": 6,
      "name": "Boutique Downtown Hotel",
      "location": "Miami, FL",
      "category": "Hotels",
      "price": 189.0,
      "rating": 4.4,
      "reviews": 734,
      "image": "https://picsum.photos/300/200?random=6&keyword=hotel",
      "description": "Stylish boutique hotel in the heart of downtown with modern amenities.",
      "duration": "Per Night",
      "features": ["Downtown Location", "Modern Design", "Rooftop Bar", "Fitness Center"],
      "isBookmarked": false,
    },
  ];

  List<Map<String, dynamic>> get filteredDestinations {
    return destinations.where((destination) {
      bool matchesSearch = destination["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          destination["location"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || destination["category"] == selectedCategory;
      bool matchesLocation = selectedLocation == "Anywhere" || destination["location"].contains(selectedLocation);
      
      bool matchesPrice = true;
      if (selectedPriceRange != "Any") {
        double price = destination["price"] as double;
        switch (selectedPriceRange) {
          case "1-50":
            matchesPrice = price >= 1 && price <= 50;
            break;
          case "51-100":
            matchesPrice = price >= 51 && price <= 100;
            break;
          case "101-200":
            matchesPrice = price >= 101 && price <= 200;
            break;
          case "200+":
            matchesPrice = price > 200;
            break;
        }
      }
      
      return matchesSearch && matchesCategory && matchesLocation && matchesPrice;
    }).toList();
  }

  void _toggleBookmark(int destinationId) {
    setState(() {
      int index = destinations.indexWhere((dest) => dest["id"] == destinationId);
      if (index != -1) {
        destinations[index]["isBookmarked"] = !destinations[index]["isBookmarked"];
        String action = destinations[index]["isBookmarked"] ? "added to" : "removed from";
        si("Destination $action bookmarks");
      }
    });
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
              ),
              child: Row(
                children: [
                  Text(
                    "Filters",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, size: 24),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  spacing: spMd,
                  children: [
                    QDropdownField(
                      label: "Category",
                      items: categories,
                      value: selectedCategory,
                      onChanged: (value, label) {
                        selectedCategory = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Price Range",
                      items: priceRanges,
                      value: selectedPriceRange,
                      onChanged: (value, label) {
                        selectedPriceRange = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Location",
                      items: locations,
                      value: selectedLocation,
                      onChanged: (value, label) {
                        selectedLocation = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: disabledOutlineBorderColor)),
              ),
              child: Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QButton(
                      label: "Reset",
                      color: disabledColor,
                      size: bs.md,
                      onPressed: () {
                        selectedCategory = "All";
                        selectedPriceRange = "Any";
                        selectedLocation = "Anywhere";
                        setState(() {});
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Expanded(
                    child: QButton(
                      label: "Apply Filters",
                      size: bs.md,
                      onPressed: () {
                        Navigator.pop(context);
                        si("Filters applied successfully");
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDestinationDetails(Map<String, dynamic> destination) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                image: DecorationImage(
                  image: NetworkImage("${destination["image"]}"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withAlpha(100),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: spMd,
                    right: spMd,
                    child: Row(
                      spacing: spXs,
                      children: [
                        GestureDetector(
                          onTap: () => _toggleBookmark(destination["id"]),
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(200),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(
                              destination["isBookmarked"] ? Icons.bookmark : Icons.bookmark_border,
                              color: destination["isBookmarked"] ? primaryColor : disabledBoldColor,
                              size: 20,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(200),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(Icons.close, size: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${destination["name"]}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: disabledBoldColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${destination["location"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, color: warningColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${destination["rating"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "(${destination["reviews"]} reviews)",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.schedule, color: primaryColor, size: 16),
                          SizedBox(width: spXs),
                          Text(
                            "${destination["duration"]}",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "\$${(destination["price"] as double).toStringAsFixed(0)}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "Description",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${destination["description"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "Features",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (destination["features"] as List).map((feature) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusLg),
                                border: Border.all(color: successColor.withAlpha(50)),
                              ),
                              child: Text(
                                "$feature",
                                style: TextStyle(
                                  color: successColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: disabledOutlineBorderColor)),
              ),
              child: QButton(
                label: "Book Now - \$${(destination["price"] as double).toStringAsFixed(0)}",
                size: bs.md,
                onPressed: () {
                  Navigator.pop(context);
                  ss("Booking request sent successfully!");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discover Destinations"),
        actions: [
          GestureDetector(
            onTap: _showFilters,
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(Icons.tune, color: primaryColor, size: 24),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowXs],
            ),
            child: Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search destinations...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                QButton(
                  icon: Icons.search,
                  size: bs.md,
                  onPressed: () {
                    if (searchQuery.isNotEmpty) {
                      si("Searching for: $searchQuery");
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredDestinations.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: spMd,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: disabledColor,
                        ),
                        Text(
                          "No destinations found",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Try adjusting your search or filters",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                        QButton(
                          label: "Clear Filters",
                          size: bs.sm,
                          onPressed: () {
                            searchQuery = "";
                            selectedCategory = "All";
                            selectedPriceRange = "Any";
                            selectedLocation = "Anywhere";
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      spacing: spMd,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${filteredDestinations.length} destinations found",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            if (searchQuery.isNotEmpty || selectedCategory != "All" || selectedPriceRange != "Any" || selectedLocation != "Anywhere")
                              GestureDetector(
                                onTap: () {
                                  searchQuery = "";
                                  selectedCategory = "All";
                                  selectedPriceRange = "Any";
                                  selectedLocation = "Anywhere";
                                  setState(() {});
                                },
                                child: Text(
                                  "Clear all",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        ...filteredDestinations.map((destination) {
                          return GestureDetector(
                            onTap: () => _showDestinationDetails(destination),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusLg),
                                boxShadow: [shadowSm],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                                      image: DecorationImage(
                                        image: NetworkImage("${destination["image"]}"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: spSm,
                                          right: spSm,
                                          child: GestureDetector(
                                            onTap: () => _toggleBookmark(destination["id"]),
                                            child: Container(
                                              padding: EdgeInsets.all(spXs),
                                              decoration: BoxDecoration(
                                                color: Colors.white.withAlpha(200),
                                                borderRadius: BorderRadius.circular(radiusLg),
                                              ),
                                              child: Icon(
                                                destination["isBookmarked"] ? Icons.bookmark : Icons.bookmark_border,
                                                color: destination["isBookmarked"] ? primaryColor : disabledBoldColor,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: spSm,
                                          left: spSm,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: BorderRadius.circular(radiusLg),
                                            ),
                                            child: Text(
                                              "${destination["category"]}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(spMd),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: spSm,
                                      children: [
                                        Text(
                                          "${destination["name"]}",
                                          style: TextStyle(
                                            fontSize: fsH6,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.location_on, color: disabledBoldColor, size: 16),
                                            SizedBox(width: spXs),
                                            Expanded(
                                              child: Text(
                                                "${destination["location"]}",
                                                style: TextStyle(
                                                  color: disabledBoldColor,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.star, color: warningColor, size: 16),
                                            SizedBox(width: spXs),
                                            Text(
                                              "${destination["rating"]}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "(${destination["reviews"]} reviews)",
                                              style: TextStyle(
                                                color: disabledBoldColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              "\$${(destination["price"] as double).toStringAsFixed(0)}",
                                              style: TextStyle(
                                                fontSize: fsH6,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: double.infinity,
                                          child: QButton(
                                            label: "View Details",
                                            size: bs.sm,
                                            onPressed: () => _showDestinationDetails(destination),
                                          ),
                                        ),
                                      ],
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
        ],
      ),
    );
  }
}
