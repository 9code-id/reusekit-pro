import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSearch2View extends StatefulWidget {
  @override
  State<GrlSearch2View> createState() => _GrlSearch2ViewState();
}

class _GrlSearch2ViewState extends State<GrlSearch2View> {
  String searchQuery = "";
  String selectedFilter = "all";
  String sortBy = "relevance";
  bool showFilters = false;

  List<Map<String, dynamic>> searchHistory = [
    {"query": "best restaurants", "timestamp": "2 hours ago"},
    {"query": "coffee shops nearby", "timestamp": "1 day ago"},
    {"query": "italian cuisine", "timestamp": "3 days ago"},
    {"query": "fast food delivery", "timestamp": "1 week ago"}
  ];

  List<Map<String, dynamic>> popularSearches = [
    {"query": "pizza delivery", "count": 1250},
    {"query": "sushi restaurants", "count": 890},
    {"query": "vegetarian food", "count": 650},
    {"query": "dessert places", "count": 420}
  ];

  List<Map<String, dynamic>> searchResults = [
    {
      "id": 1,
      "name": "Bella Vista Restaurant",
      "type": "Italian Restaurant",
      "rating": 4.8,
      "reviews": 324,
      "distance": "0.5 km",
      "priceRange": "\$\$\$",
      "image": "https://picsum.photos/300/200?random=1&keyword=restaurant",
      "tags": ["Italian", "Fine Dining", "Romantic"],
      "openUntil": "11:00 PM",
      "featured": true
    },
    {
      "id": 2,
      "name": "Tokyo Sushi Bar",
      "type": "Japanese Restaurant",
      "rating": 4.6,
      "reviews": 198,
      "distance": "1.2 km",
      "priceRange": "\$\$",
      "image": "https://picsum.photos/300/200?random=2&keyword=sushi",
      "tags": ["Japanese", "Sushi", "Fresh"],
      "openUntil": "10:30 PM",
      "featured": false
    },
    {
      "id": 3,
      "name": "Green Garden Cafe",
      "type": "Vegetarian Cafe",
      "rating": 4.7,
      "reviews": 156,
      "distance": "0.8 km",
      "priceRange": "\$",
      "image": "https://picsum.photos/300/200?random=3&keyword=cafe",
      "tags": ["Vegetarian", "Healthy", "Organic"],
      "openUntil": "9:00 PM",
      "featured": false
    }
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "all"},
    {"label": "Restaurants", "value": "restaurant"},
    {"label": "Cafes", "value": "cafe"},
    {"label": "Fast Food", "value": "fastfood"},
    {"label": "Delivery", "value": "delivery"}
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Relevance", "value": "relevance"},
    {"label": "Distance", "value": "distance"},
    {"label": "Rating", "value": "rating"},
    {"label": "Price: Low to High", "value": "price_asc"},
    {"label": "Price: High to Low", "value": "price_desc"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Places"),
        actions: [
          IconButton(
            icon: Icon(showFilters ? Icons.filter_list : Icons.filter_list_off),
            onPressed: () {
              showFilters = !showFilters;
              setState(() {});
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
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm),
                      child: QTextField(
                        label: "Search restaurants, cafes...",
                        value: searchQuery,
                        hint: "What are you craving?",
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(spXs),
                    child: QButton(
                      icon: Icons.search,
                      size: bs.sm,
                      onPressed: () {
                        // Perform search
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Filter Row
            if (showFilters) ...[
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    // Filter Categories
                    QCategoryPicker(
                      items: filterOptions,
                      value: selectedFilter,
                      onChanged: (index, label, value, item) {
                        selectedFilter = value;
                        setState(() {});
                      },
                    ),

                    // Sort Options
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
                            label: "Sort Order",
                            items: sortOptions,
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
              ),
            ],

            // Search Content
            if (searchQuery.isEmpty) ...[
              // Search History
              Text(
                "Recent Searches",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Column(
                spacing: spXs,
                children: searchHistory.map((history) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusXs),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.history,
                          size: 20,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${history["query"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${history["timestamp"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              // Popular Searches
              SizedBox(height: spMd),
              Text(
                "Popular Searches",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ResponsiveGridView(
                padding: EdgeInsets.all(spXs),
                minItemWidth: 200,
                children: popularSearches.map((popular) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowXs],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.trending_up,
                              size: 20,
                              color: successColor,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${popular["query"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${(popular["count"] as int)} searches",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],

            // Search Results
            if (searchQuery.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${searchResults.length} places found",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Near you",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Results List
              Column(
                spacing: spSm,
                children: searchResults.map((place) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                      border: (place["featured"] as bool)
                          ? Border.all(color: primaryColor, width: 2)
                          : null,
                    ),
                    child: Column(
                      children: [
                        // Featured Badge
                        if (place["featured"] as bool) ...[
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusSm),
                                topRight: Radius.circular(radiusSm),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Featured",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],

                        // Place Content
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Row(
                            children: [
                              // Place Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusXs),
                                child: Image.network(
                                  "${place["image"]}",
                                  width: 100,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: spSm),

                              // Place Info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Text(
                                      "${place["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "${place["type"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 16,
                                          color: warningColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${(place["rating"] as num).toStringAsFixed(1)}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "(${(place["reviews"] as int)})",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Text(
                                          "${place["priceRange"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: successColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 14,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${place["distance"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Icon(
                                          Icons.access_time,
                                          size: 14,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "Open until ${place["openUntil"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: successColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Tags
                        if (place["tags"] != null) ...[
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: spSm),
                            child: Wrap(
                              spacing: spXs,
                              children: (place["tags"] as List).map((tag) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: disabledColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "$tag",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(height: spSm),
                        ],
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
