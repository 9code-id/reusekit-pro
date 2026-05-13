import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlExplore10View extends StatefulWidget {
  @override
  State<GrlExplore10View> createState() => _GrlExplore10ViewState();
}

class _GrlExplore10ViewState extends State<GrlExplore10View> {
  String searchQuery = "";
  String selectedCategory = "All";
  int selectedFilterIndex = 0;

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Food", "value": "Food"},
    {"label": "Travel", "value": "Travel"},
    {"label": "Fashion", "value": "Fashion"},
    {"label": "Tech", "value": "Tech"},
    {"label": "Art", "value": "Art"},
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "Recent", "value": "recent"},
    {"label": "Popular", "value": "popular"},
    {"label": "Trending", "value": "trending"},
  ];

  List<Map<String, dynamic>> exploreItems = [
    {
      "id": 1,
      "title": "Delicious Pasta Recipe",
      "category": "Food",
      "image": "https://picsum.photos/300/200?random=1&keyword=pasta",
      "creator": "Chef Maria",
      "avatar": "https://picsum.photos/50/50?random=101",
      "likes": 2340,
      "views": 45000,
      "type": "recipe",
      "tags": ["pasta", "italian", "cooking"],
      "duration": "15 min",
    },
    {
      "id": 2,
      "title": "Tokyo Street Photography",
      "category": "Travel",
      "image": "https://picsum.photos/300/200?random=2&keyword=tokyo",
      "creator": "Alex Photography",
      "avatar": "https://picsum.photos/50/50?random=102",
      "likes": 5670,
      "views": 89000,
      "type": "photo",
      "tags": ["tokyo", "street", "photography"],
      "duration": "",
    },
    {
      "id": 3,
      "title": "Summer Fashion Trends",
      "category": "Fashion",
      "image": "https://picsum.photos/300/200?random=3&keyword=fashion",
      "creator": "Style Guru",
      "avatar": "https://picsum.photos/50/50?random=103",
      "likes": 3210,
      "views": 67000,
      "type": "article",
      "tags": ["fashion", "summer", "trends"],
      "duration": "5 min read",
    },
    {
      "id": 4,
      "title": "iPhone 16 Pro Review",
      "category": "Tech",
      "image": "https://picsum.photos/300/200?random=4&keyword=iphone",
      "creator": "Tech Reviewer",
      "avatar": "https://picsum.photos/50/50?random=104",
      "likes": 8900,
      "views": 156000,
      "type": "video",
      "tags": ["iphone", "review", "tech"],
      "duration": "12:34",
    },
    {
      "id": 5,
      "title": "Modern Art Exhibition",
      "category": "Art",
      "image": "https://picsum.photos/300/200?random=5&keyword=art",
      "creator": "Art Critic",
      "avatar": "https://picsum.photos/50/50?random=105",
      "likes": 1890,
      "views": 34000,
      "type": "gallery",
      "tags": ["art", "modern", "exhibition"],
      "duration": "",
    },
    {
      "id": 6,
      "title": "Homemade Pizza Guide",
      "category": "Food",
      "image": "https://picsum.photos/300/200?random=6&keyword=pizza",
      "creator": "Pizza Master",
      "avatar": "https://picsum.photos/50/50?random=106",
      "likes": 4560,
      "views": 78000,
      "type": "tutorial",
      "tags": ["pizza", "cooking", "diy"],
      "duration": "25 min",
    },
    {
      "id": 7,
      "title": "Bali Hidden Beaches",
      "category": "Travel",
      "image": "https://picsum.photos/300/200?random=7&keyword=bali",
      "creator": "Travel Explorer",
      "avatar": "https://picsum.photos/50/50?random=107",
      "likes": 7230,
      "views": 123000,
      "type": "guide",
      "tags": ["bali", "beach", "travel"],
      "duration": "8 min read",
    },
    {
      "id": 8,
      "title": "Minimalist Wardrobe",
      "category": "Fashion",
      "image": "https://picsum.photos/300/200?random=8&keyword=wardrobe",
      "creator": "Minimal Style",
      "avatar": "https://picsum.photos/50/50?random=108",
      "likes": 2890,
      "views": 54000,
      "type": "lifestyle",
      "tags": ["minimalist", "wardrobe", "style"],
      "duration": "6 min read",
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    if (selectedCategory == "All") {
      return exploreItems;
    }
    return exploreItems.where((item) => item["category"] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search content...",
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

            SizedBox(height: spMd),

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

            SizedBox(height: spMd),

            // Filter Options
            Row(
              children: [
                Text(
                  "Sort by:",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                ...List.generate(filterOptions.length, (index) {
                  final option = filterOptions[index];
                  final isSelected = selectedFilterIndex == index;
                  return Container(
                    margin: EdgeInsets.only(right: spXs),
                    child: GestureDetector(
                      onTap: () {
                        selectedFilterIndex = index;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledBoldColor,
                          ),
                        ),
                        child: Text(
                          "${option["label"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : disabledBoldColor,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),

            SizedBox(height: spMd),

            // Results Count
            Text(
              "${filteredItems.length} results found",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(height: spSm),

            // Content Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredItems.map((item) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusLg),
                              topRight: Radius.circular(radiusLg),
                            ),
                            child: Image.network(
                              "${item["image"]}",
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: spXs,
                            right: spXs,
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.bookmark_border,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                          if (item["duration"].toString().isNotEmpty)
                            Positioned(
                              bottom: spXs,
                              right: spXs,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(180),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${item["duration"]}",
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

                      // Content
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Category Badge
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${item["category"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            SizedBox(height: spXs),

                            // Title
                            Text(
                              "${item["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                            SizedBox(height: spXs),

                            // Creator Info
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  child: Image.network(
                                    "${item["avatar"]}",
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${item["creator"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: spXs),

                            // Stats
                            Row(
                              children: [
                                Icon(
                                  Icons.favorite,
                                  size: 14,
                                  color: dangerColor,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${((item["likes"] as int) / 1000).toStringAsFixed(1)}k",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Icon(
                                  Icons.visibility,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${((item["views"] as int) / 1000).toStringAsFixed(0)}k",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: spSm),

                            // Tags
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (item["tags"] as List).map((tag) {
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
                                    "#$tag",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),

                            SizedBox(height: spSm),

                            // Action Button
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () {},
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
    );
  }
}
