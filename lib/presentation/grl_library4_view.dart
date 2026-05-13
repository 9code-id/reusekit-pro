import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLibrary4View extends StatefulWidget {
  @override
  State<GrlLibrary4View> createState() => _GrlLibrary4ViewState();
}

class _GrlLibrary4ViewState extends State<GrlLibrary4View> {
  String searchQuery = "";
  String selectedCategory = "All Books";
  String selectedSort = "Title";
  bool isGridView = true;

  List<Map<String, dynamic>> categories = [
    {"label": "All Books", "value": "All Books"},
    {"label": "Fiction", "value": "Fiction"},
    {"label": "Non-Fiction", "value": "Non-Fiction"},
    {"label": "Science", "value": "Science"},
    {"label": "History", "value": "History"},
    {"label": "Biography", "value": "Biography"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Title", "value": "Title"},
    {"label": "Author", "value": "Author"},
    {"label": "Date Added", "value": "Date Added"},
    {"label": "Rating", "value": "Rating"},
  ];

  List<Map<String, dynamic>> books = [
    {
      "id": 1,
      "title": "The Art of War",
      "author": "Sun Tzu",
      "category": "History",
      "cover": "https://picsum.photos/300/400?random=1&keyword=book",
      "rating": 4.8,
      "pages": 273,
      "year": 2023,
      "description": "Ancient Chinese military treatise on strategy and tactics",
      "status": "Available",
      "borrowed": false,
    },
    {
      "id": 2,
      "title": "Quantum Physics",
      "author": "Dr. Sarah Johnson",
      "category": "Science",
      "cover": "https://picsum.photos/300/400?random=2&keyword=physics",
      "rating": 4.6,
      "pages": 456,
      "year": 2024,
      "description": "Comprehensive guide to quantum mechanics and modern physics",
      "status": "Borrowed",
      "borrowed": true,
    },
    {
      "id": 3,
      "title": "Digital Innovation",
      "author": "Mark Thompson",
      "category": "Non-Fiction",
      "cover": "https://picsum.photos/300/400?random=3&keyword=technology",
      "rating": 4.7,
      "pages": 334,
      "year": 2023,
      "description": "Exploring the future of technology and digital transformation",
      "status": "Available",
      "borrowed": false,
    },
    {
      "id": 4,
      "title": "The Great Explorer",
      "author": "Emma Davis",
      "category": "Biography",
      "cover": "https://picsum.photos/300/400?random=4&keyword=explorer",
      "rating": 4.5,
      "pages": 287,
      "year": 2022,
      "description": "Life story of famous 20th century explorer and adventurer",
      "status": "Reserved",
      "borrowed": false,
    },
    {
      "id": 5,
      "title": "Mystery of Time",
      "author": "Robert Chen",
      "category": "Fiction",
      "cover": "https://picsum.photos/300/400?random=5&keyword=mystery",
      "rating": 4.4,
      "pages": 398,
      "year": 2024,
      "description": "A thrilling science fiction novel about time travel",
      "status": "Available",
      "borrowed": false,
    },
    {
      "id": 6,
      "title": "World History",
      "author": "Prof. Michael Brown",
      "category": "History",
      "cover": "https://picsum.photos/300/400?random=6&keyword=history",
      "rating": 4.9,
      "pages": 567,
      "year": 2023,
      "description": "Comprehensive overview of world civilizations and events",
      "status": "Available",
      "borrowed": false,
    },
  ];

  List<Map<String, dynamic>> get filteredBooks {
    List<Map<String, dynamic>> filtered = books;

    if (selectedCategory != "All Books") {
      filtered = filtered.where((book) => book["category"] == selectedCategory).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((book) =>
          (book["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (book["author"] as String).toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    // Sort books
    switch (selectedSort) {
      case "Author":
        filtered.sort((a, b) => (a["author"] as String).compareTo(b["author"] as String));
        break;
      case "Date Added":
        filtered.sort((a, b) => (b["year"] as int).compareTo(a["year"] as int));
        break;
      case "Rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      default:
        filtered.sort((a, b) => (a["title"] as String).compareTo(b["title"] as String));
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Available":
        return successColor;
      case "Borrowed":
        return warningColor;
      case "Reserved":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Library Collection"),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              isGridView = !isGridView;
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
            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search books or authors",
                    value: searchQuery,
                    hint: "Enter title or author name",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),

            // Filter Row
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
                    label: "Sort by",
                    items: sortOptions,
                    value: selectedSort,
                    onChanged: (value, label) {
                      selectedSort = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Library Stats
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${books.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Books",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 1,
                    color: disabledColor,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${books.where((b) => b["status"] == "Available").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Available",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 1,
                    color: disabledColor,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${books.where((b) => b["borrowed"] == true).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Borrowed",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Results Info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${filteredBooks.length} books found",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Sorted by ${selectedSort}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),

            // Books Display
            if (isGridView)
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredBooks.map((book) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Book Cover
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                          child: Stack(
                            children: [
                              Image.network(
                                "${book["cover"]}",
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: spXs,
                                right: spXs,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(book["status"] as String),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${book["status"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "${book["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "by ${book["author"]}",
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
                                  SizedBox(width: 4),
                                  Text(
                                    "${book["rating"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: warningColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${book["pages"]} pages",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${book["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Container(
                                width: double.infinity,
                                child: QButton(
                                  label: book["status"] == "Available" ? "Borrow Book" : "View Details",
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
              )
            else
              Column(
                spacing: spSm,
                children: filteredBooks.map((book) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${book["cover"]}",
                            width: 80,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${book["title"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(book["status"] as String),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${book["status"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "by ${book["author"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 14,
                                    color: warningColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${book["rating"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: warningColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${book["pages"]} pages",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${book["year"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${book["description"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  QButton(
                                    label: book["status"] == "Available" ? "Borrow" : "View",
                                    size: bs.sm,
                                    onPressed: () {},
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
          ],
        ),
      ),
    );
  }
}
