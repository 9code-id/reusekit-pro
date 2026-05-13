import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaSearchResultsView extends StatefulWidget {
  const SpaSearchResultsView({Key? key}) : super(key: key);

  @override
  State<SpaSearchResultsView> createState() => _SpaSearchResultsViewState();
}

class _SpaSearchResultsViewState extends State<SpaSearchResultsView> {
  String searchQuery = "Facial treatments";
  String selectedCategory = "All";
  String sortBy = "popularity";
  bool showFilters = false;

  List<Map<String, dynamic>> searchResults = [
    {
      "id": 1,
      "name": "Hydrating Facial Treatment",
      "spa": "Luxury Spa & Wellness",
      "image": "https://picsum.photos/300/200?random=1&keyword=facial",
      "rating": 4.8,
      "reviews": 126,
      "price": 120.0,
      "duration": 60,
      "category": "Facial",
      "discount": 20,
      "isPopular": true,
      "description": "Deep cleansing and hydrating facial treatment with premium products",
    },
    {
      "id": 2,
      "name": "Anti-Aging Facial",
      "spa": "Elite Beauty Center",
      "image": "https://picsum.photos/300/200?random=2&keyword=spa",
      "rating": 4.9,
      "reviews": 89,
      "price": 180.0,
      "duration": 90,
      "category": "Facial",
      "discount": 0,
      "isPopular": false,
      "description": "Advanced anti-aging treatment with collagen boost",
    },
    {
      "id": 3,
      "name": "Organic Skin Renewal",
      "spa": "Natural Spa Retreat",
      "image": "https://picsum.photos/300/200?random=3&keyword=organic",
      "rating": 4.7,
      "reviews": 203,
      "price": 95.0,
      "duration": 75,
      "category": "Facial",
      "discount": 15,
      "isPopular": true,
      "description": "100% organic ingredients for natural skin renewal",
    },
    {
      "id": 4,
      "name": "Diamond Microdermabrasion",
      "spa": "Premium Skin Clinic",
      "image": "https://picsum.photos/300/200?random=4&keyword=diamond",
      "rating": 4.6,
      "reviews": 67,
      "price": 200.0,
      "duration": 45,
      "category": "Facial",
      "discount": 10,
      "isPopular": false,
      "description": "Professional diamond-tip microdermabrasion treatment",
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Facial", "value": "Facial"},
    {"label": "Body", "value": "Body"},
    {"label": "Massage", "value": "Massage"},
    {"label": "Skincare", "value": "Skincare"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Popularity", "value": "popularity"},
    {"label": "Price: Low to High", "value": "price_asc"},
    {"label": "Price: High to Low", "value": "price_desc"},
    {"label": "Rating", "value": "rating"},
    {"label": "Newest", "value": "newest"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Results"),
        actions: [
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {
              showFilters = !showFilters;
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Header
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.grey[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search treatments...",
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
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "${searchResults.length} results found for '${searchQuery}'",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          // Category Filter
          QCategoryPicker(
            items: categories,
            value: selectedCategory,
            onChanged: (index, label, value, item) {
              selectedCategory = value;
              setState(() {});
            },
          ),

          // Sort & Filter Row
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            child: Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Sort by",
                    items: sortOptions,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: showFilters ? "Hide Filters" : "Show Filters",
                  size: bs.sm,
                  onPressed: () {
                    showFilters = !showFilters;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Filter Section
          if (showFilters)
            Container(
              padding: EdgeInsets.all(spMd),
              color: Colors.grey[50],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filters",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Min Price (\$)",
                          value: "",
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTextField(
                          label: "Max Price (\$)",
                          value: "",
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      QButton(
                        label: "Apply Filters",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Clear All",
                        size: bs.sm,
                        color: dangerColor,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),

          // Results List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final result = searchResults[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      // Image and Popular Badge
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(radiusMd),
                            ),
                            child: Image.network(
                              "${result["image"]}",
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          if (result["isPopular"] as bool)
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "Popular",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          if ((result["discount"] as int) > 0)
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: dangerColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${result["discount"]}% OFF",
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

                      // Content
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title and Rating
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${result["name"]}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${result["spa"]}",
                                        style: TextStyle(
                                          fontSize: 14,
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
                                      "${result["rating"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      " (${result["reviews"]})",
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

                            // Description
                            Text(
                              "${result["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                            SizedBox(height: spSm),

                            // Price and Duration
                            Row(
                              children: [
                                if ((result["discount"] as int) > 0) ...[
                                  Text(
                                    "\$${((result["price"] as double) * (1 + (result["discount"] as int) / 100)).toStringAsFixed(0)}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                ],
                                Text(
                                  "\$${(result["price"] as double).toStringAsFixed(0)}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.schedule,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${result["duration"]} min",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: spSm),

                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: QButton(
                                    label: "Book Now",
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: QButton(
                                    label: "Details",
                                    size: bs.sm,
                                    color: secondaryColor,
                                    onPressed: () {},
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
