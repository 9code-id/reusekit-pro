import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDiscover8View extends StatefulWidget {
  @override
  State<GrlDiscover8View> createState() => _GrlDiscover8ViewState();
}

class _GrlDiscover8ViewState extends State<GrlDiscover8View> {
  String searchQuery = "";
  String selectedCategory = "All";
  bool showFavorites = false;
  
  List<Map<String, dynamic>> discoverItems = [
    {
      "id": 1,
      "title": "Mountain Adventures",
      "type": "Experience",
      "rating": 4.8,
      "price": 89.99,
      "image": "https://picsum.photos/400/300?random=1&keyword=mountain",
      "category": "Adventure",
      "duration": "Full Day",
      "location": "Rocky Mountains",
      "isFavorite": false,
      "participants": 156,
      "difficulty": "Moderate",
      "includes": ["Guide", "Equipment", "Lunch"],
      "provider": "Mountain Explorers"
    },
    {
      "id": 2,
      "title": "Culinary Workshop",
      "type": "Class",
      "rating": 4.9,
      "price": 75.00,
      "image": "https://picsum.photos/400/300?random=2&keyword=cooking",
      "category": "Cooking",
      "duration": "3 hours",
      "location": "Downtown Studio",
      "isFavorite": true,
      "participants": 89,
      "difficulty": "Beginner",
      "includes": ["Ingredients", "Recipes", "Certificate"],
      "provider": "Chef Academy"
    },
    {
      "id": 3,
      "title": "Photography Safari",
      "type": "Tour",
      "rating": 4.7,
      "price": 120.00,
      "image": "https://picsum.photos/400/300?random=3&keyword=wildlife",
      "category": "Photography",
      "duration": "2 Days",
      "location": "National Park",
      "isFavorite": false,
      "participants": 234,
      "difficulty": "All Levels",
      "includes": ["Transportation", "Guide", "Permits"],
      "provider": "Nature Photos"
    },
    {
      "id": 4,
      "title": "Art & Paint Workshop",
      "type": "Class",
      "rating": 4.6,
      "price": 45.00,
      "image": "https://picsum.photos/400/300?random=4&keyword=painting",
      "category": "Art",
      "duration": "2 hours",
      "location": "Art Studio",
      "isFavorite": true,
      "participants": 67,
      "difficulty": "Beginner",
      "includes": ["Materials", "Canvas", "Refreshments"],
      "provider": "Creative Space"
    },
    {
      "id": 5,
      "title": "Yoga Retreat",
      "type": "Wellness",
      "rating": 4.9,
      "price": 150.00,
      "image": "https://picsum.photos/400/300?random=5&keyword=yoga",
      "category": "Wellness",
      "duration": "Weekend",
      "location": "Peaceful Valley",
      "isFavorite": false,
      "participants": 145,
      "difficulty": "All Levels",
      "includes": ["Meals", "Accommodation", "Sessions"],
      "provider": "Zen Retreats"
    },
    {
      "id": 6,
      "title": "Wine Tasting Experience",
      "type": "Experience",
      "rating": 4.5,
      "price": 65.00,
      "image": "https://picsum.photos/400/300?random=6&keyword=wine",
      "category": "Food & Drink",
      "duration": "3 hours",
      "location": "Vineyard Estate",
      "isFavorite": true,
      "participants": 98,
      "difficulty": "Beginner",
      "includes": ["Tastings", "Snacks", "Tour"],
      "provider": "Wine Masters"
    }
  ];

  List<String> categories = [
    "All", "Adventure", "Cooking", "Photography", "Art", "Wellness", "Food & Drink"
  ];

  List<Map<String, dynamic>> get filteredItems {
    var filtered = discoverItems.where((item) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${item["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${item["location"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${item["provider"]}".toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesCategory = selectedCategory == "All" ||
          item["category"] == selectedCategory;

      bool matchesFavorites = !showFavorites || item["isFavorite"];

      return matchesSearch && matchesCategory && matchesFavorites;
    }).toList();

    // Sort by rating
    filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discover Experiences"),
        actions: [
          IconButton(
            icon: Icon(showFavorites ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              showFavorites = !showFavorites;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () => _showMapView(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Hero Section
            Container(
              height: 160,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -20,
                    top: -20,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(20),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    left: -30,
                    bottom: -30,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(10),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "Discover New Experiences",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Find amazing activities, classes, and adventures near you",
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 14,
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            _buildStatCard("${discoverItems.length}", "Experiences"),
                            SizedBox(width: spMd),
                            _buildStatCard("${categories.length - 1}", "Categories"),
                            SizedBox(width: spMd),
                            _buildStatCard("4.8", "Avg Rating"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Search Section
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search experiences...",
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
                  onPressed: () => _showAdvancedFilters(),
                ),
              ],
            ),

            // Category Filter
            QCategoryPicker(
              label: "Categories",
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

            // Filter Status
            if (showFavorites || searchQuery.isNotEmpty || selectedCategory != "All")
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: primaryColor.withAlpha(30)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.filter_list,
                      size: 16,
                      color: primaryColor,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "Filters applied: ${_getActiveFiltersText()}",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _clearAllFilters(),
                      child: Icon(
                        Icons.clear,
                        size: 16,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),

            // Results Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${filteredItems.length} experiences found",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () => _showSortOptions(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.sort,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Sort by Rating",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Items Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredItems.map((item) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                        child: Stack(
                          children: [
                            Image.network(
                              "${item["image"]}",
                              height: 140,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getCategoryColor("${item["category"]}"),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${item["type"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: GestureDetector(
                                onTap: () => _toggleFavorite(item["id"]),
                                child: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    boxShadow: [shadowSm],
                                  ),
                                  child: Icon(
                                    item["isFavorite"] ? Icons.favorite : Icons.favorite_border,
                                    size: 18,
                                    color: item["isFavorite"] ? dangerColor : disabledBoldColor,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(150),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${item["duration"]}",
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
                          ],
                        ),
                      ),

                      // Content
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${item["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${item["location"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 14,
                                  color: warningColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${item["rating"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  " (${item["participants"]})",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 10,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: _getDifficultyColor("${item["difficulty"]}").withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${item["difficulty"]}",
                                    style: TextStyle(
                                      color: _getDifficultyColor("${item["difficulty"]}"),
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Includes
                            QHorizontalScroll(
                              children: (item["includes"] as List).take(3).map((include) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "$include",
                                    style: TextStyle(
                                      color: successColor,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),

                            SizedBox(height: spXs),

                            // Price and Book Button
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "From",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 10,
                                        ),
                                      ),
                                      Text(
                                        "\$${(item["price"] as double).currency}",
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                QButton(
                                  label: "Book Now",
                                  size: bs.sm,
                                  onPressed: () {
                                    _showBookingModal(item);
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
              }).toList(),
            ),

            // Load More Button
            if (filteredItems.isNotEmpty)
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Load More Experiences",
                  color: secondaryColor,
                  onPressed: () {
                    si("Loading more experiences...");
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withAlpha(200),
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Adventure":
        return successColor;
      case "Cooking":
        return warningColor;
      case "Photography":
        return infoColor;
      case "Art":
        return secondaryColor;
      case "Wellness":
        return primaryColor;
      case "Food & Drink":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Beginner":
        return successColor;
      case "Moderate":
        return warningColor;
      case "Advanced":
        return dangerColor;
      default:
        return infoColor;
    }
  }

  String _getActiveFiltersText() {
    List<String> filters = [];
    if (showFavorites) filters.add("Favorites");
    if (selectedCategory != "All") filters.add(selectedCategory);
    if (searchQuery.isNotEmpty) filters.add("Search");
    return filters.join(", ");
  }

  void _clearAllFilters() {
    showFavorites = false;
    selectedCategory = "All";
    searchQuery = "";
    setState(() {});
  }

  void _toggleFavorite(int itemId) {
    final itemIndex = discoverItems.indexWhere((item) => item["id"] == itemId);
    if (itemIndex != -1) {
      discoverItems[itemIndex]["isFavorite"] = !discoverItems[itemIndex]["isFavorite"];
      setState(() {});
      
      if (discoverItems[itemIndex]["isFavorite"]) {
        ss("Added to favorites!");
      } else {
        si("Removed from favorites");
      }
    }
  }

  void _showBookingModal(Map<String, dynamic> item) {
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
            // Header
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
              child: Stack(
                children: [
                  Image.network(
                    "${item["image"]}",
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: spMd,
                    right: spMd,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [shadowSm],
                        ),
                        child: Icon(
                          Icons.close,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    // Title and Rating
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${item["title"]}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: warningColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${item["rating"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Details
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text("${item["location"]}"),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text("${item["duration"]}"),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.people, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text("${item["participants"]} participants"),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Includes
                    Text(
                      "What's Included:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QHorizontalScroll(
                      children: (item["includes"] as List).map((include) {
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: successColor.withAlpha(30)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: successColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "$include",
                                style: TextStyle(
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),

                    Spacer(),

                    // Price and Book Button
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Price",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "\$${(item["price"] as double).currency}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: fsH4,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          QButton(
                            label: "Book Experience",
                            onPressed: () {
                              Navigator.pop(context);
                              ss("Booking confirmed for ${item["title"]}!");
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMapView() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
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
                  Expanded(
                    child: Text(
                      "Experiences Map",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: Container(
                color: Colors.blue[50],
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.map,
                        size: 64,
                        color: primaryColor.withAlpha(100),
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "Interactive Map",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Map integration would show experience locations",
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAdvancedFilters() {
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
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Advanced Filters",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.close,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.tune,
                            size: 48,
                            color: primaryColor.withAlpha(100),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Advanced Filter Options",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Price range, duration, difficulty level, and more filtering options would be available here",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                    color: disabledBoldColor,
                    onPressed: () {
                      _clearAllFilters();
                      Navigator.pop(context);
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Apply Filters",
                    onPressed: () {
                      Navigator.pop(context);
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

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Text(
              "Sort by",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Icon(Icons.star, color: warningColor),
                    SizedBox(width: spSm),
                    Text("Highest Rating"),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Icon(Icons.attach_money, color: successColor),
                    SizedBox(width: spSm),
                    Text("Lowest Price"),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Icon(Icons.trending_up, color: primaryColor),
                    SizedBox(width: spSm),
                    Text("Most Popular"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
