import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaExploreView extends StatefulWidget {
  const TtaExploreView({super.key});

  @override
  State<TtaExploreView> createState() => _TtaExploreViewState();
}

class _TtaExploreViewState extends State<TtaExploreView> {
  String searchQuery = "";
  String selectedCategory = "all";
  String selectedSort = "popular";
  bool showFilters = false;

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "all"},
    {"label": "Popular", "value": "popular"},
    {"label": "Beach", "value": "beach"},
    {"label": "Mountain", "value": "mountain"},
    {"label": "City", "value": "city"},
    {"label": "Culture", "value": "culture"},
    {"label": "Adventure", "value": "adventure"},
    {"label": "Food", "value": "food"},
  ];

  List<Map<String, dynamic>> destinations = [
    {
      "id": 1,
      "name": "Maldives Paradise Resort",
      "location": "Maldives",
      "image": "https://picsum.photos/300/200?random=1&keyword=maldives",
      "rating": 4.9,
      "reviews": 2847,
      "price": 2999,
      "duration": "7 days",
      "category": "beach",
      "featured": true,
      "discount": 25,
      "highlights": ["Overwater Villa", "Private Beach", "All Inclusive"],
    },
    {
      "id": 2,
      "name": "Swiss Alps Adventure",
      "location": "Switzerland",
      "image": "https://picsum.photos/300/200?random=2&keyword=alps",
      "rating": 4.8,
      "reviews": 1923,
      "price": 3299,
      "duration": "8 days",
      "category": "mountain",
      "featured": true,
      "discount": 15,
      "highlights": ["Skiing", "Mountain Views", "Luxury Resort"],
    },
    {
      "id": 3,
      "name": "Tokyo Cultural Experience",
      "location": "Japan",
      "image": "https://picsum.photos/300/200?random=3&keyword=tokyo",
      "rating": 4.7,
      "reviews": 3241,
      "price": 2199,
      "duration": "6 days",
      "category": "culture",
      "featured": false,
      "discount": 10,
      "highlights": ["Traditional Hotels", "Temple Tours", "Local Cuisine"],
    },
    {
      "id": 4,
      "name": "Bali Tropical Escape",
      "location": "Indonesia",
      "image": "https://picsum.photos/300/200?random=4&keyword=bali",
      "rating": 4.8,
      "reviews": 2156,
      "price": 1599,
      "duration": "7 days",
      "category": "beach",
      "featured": true,
      "discount": 30,
      "highlights": ["Beach Resort", "Spa Treatments", "Island Tours"],
    },
    {
      "id": 5,
      "name": "Patagonia Expedition",
      "location": "Argentina",
      "image": "https://picsum.photos/300/200?random=5&keyword=patagonia",
      "rating": 4.6,
      "reviews": 892,
      "price": 4199,
      "duration": "10 days",
      "category": "adventure",
      "featured": false,
      "discount": 0,
      "highlights": ["Glacier Trekking", "Wildlife Safari", "Camping"],
    },
    {
      "id": 6,
      "name": "Paris City Break",
      "location": "France",
      "image": "https://picsum.photos/300/200?random=6&keyword=paris",
      "rating": 4.7,
      "reviews": 4521,
      "price": 1899,
      "duration": "5 days",
      "category": "city",
      "featured": true,
      "discount": 20,
      "highlights": ["Historic Tours", "Art Museums", "Fine Dining"],
    },
  ];

  List<Map<String, dynamic>> get filteredDestinations {
    var filtered = destinations.where((dest) {
      bool matchesCategory = selectedCategory == "all" || dest["category"] == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty || 
          dest["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          dest["location"].toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    // Sort destinations
    switch (selectedSort) {
      case "price_low":
        filtered.sort((a, b) => (a["price"] as int).compareTo(b["price"] as int));
        break;
      case "price_high":
        filtered.sort((a, b) => (b["price"] as int).compareTo(a["price"] as int));
        break;
      case "rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "popular":
      default:
        filtered.sort((a, b) => (b["reviews"] as int).compareTo(a["reviews"] as int));
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore Destinations"),
        actions: [
          IconButton(
            onPressed: () {
              showFilters = !showFilters;
              setState(() {});
            },
            icon: Icon(
              showFilters ? Icons.filter_list_off : Icons.filter_list,
              color: primaryColor,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: disabledBoldColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search destinations...",
                              hintStyle: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              searchQuery = value;
                              setState(() {});
                            },
                          ),
                        ),
                        if (searchQuery.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              searchQuery = "";
                              setState(() {});
                            },
                            child: Icon(
                              Icons.clear,
                              color: disabledBoldColor,
                              size: 18,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    Icons.map,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),

          // Categories
          Container(
            height: 50,
            child: QHorizontalScroll(
              children: categories.map((category) {
                bool isSelected = selectedCategory == category["value"];
                return GestureDetector(
                  onTap: () {
                    selectedCategory = category["value"];
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spXs),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.transparent,
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Center(
                      child: Text(
                        "${category["label"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : primaryColor,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Filters (Collapsible)
          if (showFilters)
            Container(
              padding: EdgeInsets.all(spMd),
              color: Colors.grey.withAlpha(20),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Text(
                        "Sort by:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "",
                          items: [
                            {"label": "Most Popular", "value": "popular"},
                            {"label": "Highest Rated", "value": "rating"},
                            {"label": "Price: Low to High", "value": "price_low"},
                            {"label": "Price: High to Low", "value": "price_high"},
                          ],
                          value: selectedSort,
                          onChanged: (value, label) {
                            selectedSort = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          // Results Count
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            child: Row(
              children: [
                Text(
                  "${filteredDestinations.length} destinations found",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                if (searchQuery.isNotEmpty) ...[
                  SizedBox(width: spXs),
                  Text(
                    "for \"$searchQuery\"",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Destinations List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: filteredDestinations.length,
              itemBuilder: (context, index) {
                final destination = filteredDestinations[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image Section
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                            child: Image.network(
                              "${destination["image"]}",
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Badges
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Column(
                              spacing: spXs,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (destination["featured"] == true)
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      borderRadius: BorderRadius.circular(radiusSm),
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
                                if ((destination["discount"] as int) > 0)
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: dangerColor,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${destination["discount"]}% OFF",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          // Favorite Button
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(200),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.favorite_border,
                                size: 18,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Content Section
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title and Location
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
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            size: 14,
                                            color: disabledBoldColor,
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            "${destination["location"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "\$${((destination["price"] as int).toDouble()).currency}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "per person",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // Rating and Reviews
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${destination["rating"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
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
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${destination["duration"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: infoColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Highlights
                            QHorizontalScroll(
                              children: (destination["highlights"] as List).map<Widget>((highlight) {
                                return Container(
                                  margin: EdgeInsets.only(right: spXs),
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "$highlight",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            // Action Buttons
                            Row(
                              spacing: spSm,
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "View Details",
                                    size: bs.sm,
                                    onPressed: () {
                                      // View destination details
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: QButton(
                                    label: "Book Now",
                                    size: bs.sm,
                                    onPressed: () {
                                      // Book destination
                                    },
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
