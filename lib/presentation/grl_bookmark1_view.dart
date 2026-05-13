import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBookmark1View extends StatefulWidget {
  @override
  State<GrlBookmark1View> createState() => _GrlBookmark1ViewState();
}

class _GrlBookmark1ViewState extends State<GrlBookmark1View> {
  String searchQuery = "";
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Articles", "value": "Articles"},
    {"label": "Videos", "value": "Videos"},
    {"label": "Tutorials", "value": "Tutorials"},
    {"label": "News", "value": "News"},
    {"label": "Documentation", "value": "Documentation"},
  ];

  List<Map<String, dynamic>> bookmarks = [
    {
      "id": 1,
      "title": "Flutter Best Practices Guide",
      "url": "https://flutter.dev/docs/development",
      "description": "Complete guide to Flutter development best practices and conventions",
      "category": "Documentation",
      "favicon": "https://placehold.co/24x24?text=F",
      "dateAdded": "2024-12-20",
      "tags": ["flutter", "development", "guide"],
      "isStarred": true,
    },
    {
      "id": 2,
      "title": "Advanced State Management in Flutter",
      "url": "https://medium.com/flutter-community",
      "description": "Deep dive into state management patterns and when to use them",
      "category": "Articles",
      "favicon": "https://placehold.co/24x24?text=M",
      "dateAdded": "2024-12-19",
      "tags": ["flutter", "state-management", "riverpod"],
      "isStarred": false,
    },
    {
      "id": 3,
      "title": "Building Responsive UIs Tutorial",
      "url": "https://youtube.com/watch",
      "description": "Learn how to create responsive layouts that work on all screen sizes",
      "category": "Videos",
      "favicon": "https://placehold.co/24x24?text=Y",
      "dateAdded": "2024-12-18",
      "tags": ["ui", "responsive", "design"],
      "isStarred": true,
    },
    {
      "id": 4,
      "title": "Dart Language Tour",
      "url": "https://dart.dev/guides/language",
      "description": "Official Dart language documentation and examples",
      "category": "Documentation",
      "favicon": "https://placehold.co/24x24?text=D",
      "dateAdded": "2024-12-17",
      "tags": ["dart", "language", "basics"],
      "isStarred": false,
    },
    {
      "id": 5,
      "title": "Flutter 3.24 Release Notes",
      "url": "https://flutter.dev/blog/whats-new",
      "description": "Latest features and improvements in Flutter 3.24 release",
      "category": "News",
      "favicon": "https://placehold.co/24x24?text=F",
      "dateAdded": "2024-12-16",
      "tags": ["flutter", "release", "news"],
      "isStarred": true,
    },
  ];

  List<Map<String, dynamic>> get filteredBookmarks {
    return bookmarks.where((bookmark) {
      bool matchesSearch = searchQuery.isEmpty ||
          (bookmark["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (bookmark["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || bookmark["category"] == selectedCategory;
      
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Bookmarks"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              ss("Add bookmark feature coming soon");
            },
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
                    label: "Search bookmarks...",
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
                    // Search functionality
                  },
                ),
              ],
            ),

            // Category Filter
            QCategoryPicker(
              label: "Filter by Category",
              items: categories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            // Bookmarks List
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Bookmarks",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${filteredBookmarks.length} items",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
                ...filteredBookmarks.map((bookmark) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusXs),
                                image: DecorationImage(
                                  image: NetworkImage("${bookmark["favicon"]}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${bookmark["title"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${bookmark["url"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                bookmark["isStarred"] = !(bookmark["isStarred"] as bool);
                                setState(() {});
                                ss(bookmark["isStarred"] ? "Added to favorites" : "Removed from favorites");
                              },
                              child: Icon(
                                bookmark["isStarred"] ? Icons.star : Icons.star_border,
                                color: bookmark["isStarred"] ? warningColor : disabledBoldColor,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${bookmark["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${bookmark["category"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${bookmark["dateAdded"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    ss("Opening bookmark");
                                  },
                                  child: Icon(
                                    Icons.open_in_new,
                                    color: primaryColor,
                                    size: 18,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                GestureDetector(
                                  onTap: () {
                                    ss("Share bookmark");
                                  },
                                  child: Icon(
                                    Icons.share,
                                    color: disabledBoldColor,
                                    size: 18,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                GestureDetector(
                                  onTap: () {
                                    ss("More options");
                                  },
                                  child: Icon(
                                    Icons.more_vert,
                                    color: disabledBoldColor,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
