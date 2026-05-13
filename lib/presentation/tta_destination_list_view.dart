import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaDestinationListView extends StatefulWidget {
  const TtaDestinationListView({super.key});

  @override
  State<TtaDestinationListView> createState() => _TtaDestinationListViewState();
}

class _TtaDestinationListViewState extends State<TtaDestinationListView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedSort = "Popularity";
  
  List<Map<String, dynamic>> destinations = [
    {
      "id": 1,
      "name": "Bali Paradise Beach",
      "location": "Bali, Indonesia",
      "category": "Beach",
      "rating": 4.8,
      "reviews": 1234,
      "price": 125.00,
      "image": "https://picsum.photos/300/200?random=1&keyword=beach",
      "description": "Beautiful tropical beach with crystal clear waters",
      "duration": "3-5 days",
      "difficulty": "Easy",
      "tags": ["Beach", "Relaxation", "Swimming"],
      "featured": true,
    },
    {
      "id": 2,
      "name": "Mount Fuji Adventure",
      "location": "Tokyo, Japan",
      "category": "Mountain",
      "rating": 4.9,
      "reviews": 856,
      "price": 289.50,
      "image": "https://picsum.photos/300/200?random=2&keyword=mountain",
      "description": "Spectacular mountain climbing experience",
      "duration": "5-7 days",
      "difficulty": "Hard",
      "tags": ["Mountain", "Adventure", "Hiking"],
      "featured": false,
    },
    {
      "id": 3,
      "name": "Paris City Tour",
      "location": "Paris, France",
      "category": "City",
      "rating": 4.7,
      "reviews": 2341,
      "price": 199.99,
      "image": "https://picsum.photos/300/200?random=3&keyword=city",
      "description": "Explore the romantic city of lights",
      "duration": "2-4 days",
      "difficulty": "Easy",
      "tags": ["City", "Culture", "History"],
      "featured": true,
    },
    {
      "id": 4,
      "name": "Safari Adventure",
      "location": "Serengeti, Tanzania",
      "category": "Wildlife",
      "rating": 4.9,
      "reviews": 687,
      "price": 450.00,
      "image": "https://picsum.photos/300/200?random=4&keyword=safari",
      "description": "Amazing wildlife safari experience",
      "duration": "7-10 days",
      "difficulty": "Medium",
      "tags": ["Wildlife", "Safari", "Nature"],
      "featured": false,
    },
    {
      "id": 5,
      "name": "Aurora Northern Lights",
      "location": "Reykjavik, Iceland",
      "category": "Nature",
      "rating": 4.8,
      "reviews": 543,
      "price": 350.75,
      "image": "https://picsum.photos/300/200?random=5&keyword=aurora",
      "description": "Witness the magical northern lights",
      "duration": "4-6 days",
      "difficulty": "Medium",
      "tags": ["Aurora", "Nature", "Photography"],
      "featured": true,
    },
    {
      "id": 6,
      "name": "Tropical Island Hopping",
      "location": "Maldives",
      "category": "Beach",
      "rating": 4.9,
      "reviews": 1876,
      "price": 650.00,
      "image": "https://picsum.photos/300/200?random=6&keyword=island",
      "description": "Luxury island hopping experience",
      "duration": "7-14 days",
      "difficulty": "Easy",
      "tags": ["Island", "Luxury", "Beach"],
      "featured": false,
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Beach", "value": "Beach"},
    {"label": "Mountain", "value": "Mountain"},
    {"label": "City", "value": "City"},
    {"label": "Wildlife", "value": "Wildlife"},
    {"label": "Nature", "value": "Nature"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Popularity", "value": "Popularity"},
    {"label": "Price: Low to High", "value": "PriceLow"},
    {"label": "Price: High to Low", "value": "PriceHigh"},
    {"label": "Rating", "value": "Rating"},
    {"label": "Name A-Z", "value": "NameAZ"},
  ];

  List<Map<String, dynamic>> get filteredDestinations {
    var filtered = destinations.where((dest) {
      bool matchesSearch = "${dest["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${dest["location"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || dest["category"] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    // Sort destinations
    switch (selectedSort) {
      case "PriceLow":
        filtered.sort((a, b) => (a["price"] as double).compareTo(b["price"] as double));
        break;
      case "PriceHigh":
        filtered.sort((a, b) => (b["price"] as double).compareTo(a["price"] as double));
        break;
      case "Rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "NameAZ":
        filtered.sort((a, b) => "${a["name"]}".compareTo("${b["name"]}"));
        break;
      default: // Popularity
        filtered.sort((a, b) => (b["reviews"] as int).compareTo(a["reviews"] as int));
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Destinations"),
        actions: [
          IconButton(
            onPressed: () => _showFilterSheet(),
            icon: Icon(Icons.tune),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            Row(
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
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {
                    // Search action
                  },
                ),
              ],
            ),

            // Categories
            QCategoryPicker(
              label: "Categories",
              items: categories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            // Sort & Filter Row
            Row(
              children: [
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
                SizedBox(width: spSm),
                QButton(
                  label: "Filter",
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: () => _showFilterSheet(),
                ),
              ],
            ),

            // Results Count
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: primaryColor, size: 20),
                  SizedBox(width: spXs),
                  Text(
                    "${filteredDestinations.length} destinations found",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            // Destinations List
            ...filteredDestinations.map((destination) => _buildDestinationCard(destination)),
          ],
        ),
      ),
    );
  }

  Widget _buildDestinationCard(Map<String, dynamic> destination) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with Featured Badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusMd),
                  topRight: Radius.circular(radiusMd),
                ),
                child: Image.network(
                  "${destination["image"]}",
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              if (destination["featured"] as bool)
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: warningColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "FEATURED",
                      style: TextStyle(
                        fontSize: 12,
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
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
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

          // Content
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                // Title & Location
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${destination["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(Icons.location_on, color: disabledBoldColor, size: 16),
                              SizedBox(width: spXs),
                              Text(
                                "${destination["location"]}",
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
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${destination["category"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),

                // Description
                Text(
                  "${destination["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),

                // Duration & Difficulty
                Row(
                  children: [
                    Icon(Icons.schedule, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${destination["duration"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.trending_up, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${destination["difficulty"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),

                // Tags
                Wrap(
                  spacing: spXs,
                  children: (destination["tags"] as List).map((tag) => Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "$tag",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  )).toList(),
                ),

                // Rating & Price
                Row(
                  children: [
                    Icon(Icons.star, color: warningColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${destination["rating"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "(${destination["reviews"]} reviews)",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$${(destination["price"] as double).currency}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to detail
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.bookmark_border,
                      size: bs.sm,
                      onPressed: () {
                        // Save destination
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

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            // Handle
            Container(
              margin: EdgeInsets.only(top: spSm),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Header
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Row(
                children: [
                  Text(
                    "Filter Destinations",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close),
                  ),
                ],
              ),
            ),
            
            // Filter Content
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                padding: EdgeInsets.symmetric(horizontal: spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    // Price Range
                    Text(
                      "Price Range",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QNumberField(
                            label: "Min Price",
                            value: "0",
                            onChanged: (value) {},
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QNumberField(
                            label: "Max Price",
                            value: "1000",
                            onChanged: (value) {},
                          ),
                        ),
                      ],
                    ),

                    // Rating Filter
                    Text(
                      "Minimum Rating",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    QDropdownField(
                      label: "Select minimum rating",
                      items: [
                        {"label": "Any Rating", "value": "0"},
                        {"label": "4+ Stars", "value": "4"},
                        {"label": "4.5+ Stars", "value": "4.5"},
                      ],
                      value: "0",
                      onChanged: (value, label) {},
                    ),

                    // Duration Filter
                    Text(
                      "Trip Duration",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    QDropdownField(
                      label: "Select duration",
                      items: [
                        {"label": "Any Duration", "value": "any"},
                        {"label": "1-3 days", "value": "short"},
                        {"label": "4-7 days", "value": "medium"},
                        {"label": "8+ days", "value": "long"},
                      ],
                      value: "any",
                      onChanged: (value, label) {},
                    ),

                    // Difficulty Filter
                    Text(
                      "Difficulty Level",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    QDropdownField(
                      label: "Select difficulty",
                      items: [
                        {"label": "Any Level", "value": "any"},
                        {"label": "Easy", "value": "Easy"},
                        {"label": "Medium", "value": "Medium"},
                        {"label": "Hard", "value": "Hard"},
                      ],
                      value: "any",
                      onChanged: (value, label) {},
                    ),

                    SizedBox(height: spXl),
                  ],
                ),
              ),
            ),
            
            // Apply Filter Button
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: disabledColor)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Reset",
                      size: bs.sm,
                      onPressed: () {
                        // Reset filters
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    flex: 2,
                    child: QButton(
                      label: "Apply Filter",
                      size: bs.sm,
                      onPressed: () {
                        // Apply filters
                        Navigator.pop(context);
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
}
