import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFavorite4View extends StatefulWidget {
  @override
  State<GrlFavorite4View> createState() => _GrlFavorite4ViewState();
}

class _GrlFavorite4ViewState extends State<GrlFavorite4View> {
  String sortBy = "title";
  String filterBy = "all";

  List<Map<String, dynamic>> favoriteBooks = [
    {
      "id": "1",
      "title": "The Art of Clean Code",
      "author": "Robert C. Martin",
      "genre": "Technology",
      "pages": 464,
      "rating": 4.7,
      "reviews": 3542,
      "cover": "https://picsum.photos/300/400?random=1&keyword=book",
      "readingProgress": 85,
      "status": "Reading",
      "price": 29.99,
      "publishedYear": 2008,
      "description": "A comprehensive guide to writing clean, maintainable code"
    },
    {
      "id": "2",
      "title": "Sapiens: A Brief History",
      "author": "Yuval Noah Harari",
      "genre": "History",
      "pages": 443,
      "rating": 4.8,
      "reviews": 15642,
      "cover": "https://picsum.photos/300/400?random=2&keyword=history",
      "readingProgress": 100,
      "status": "Completed",
      "price": 24.95,
      "publishedYear": 2014,
      "description": "An exploration of how humans came to dominate the world"
    },
    {
      "id": "3",
      "title": "The Psychology of Money",
      "author": "Morgan Housel",
      "genre": "Finance",
      "pages": 256,
      "rating": 4.6,
      "reviews": 8934,
      "cover": "https://picsum.photos/300/400?random=3&keyword=money",
      "readingProgress": 0,
      "status": "Want to Read",
      "price": 19.99,
      "publishedYear": 2020,
      "description": "Timeless lessons on wealth, greed, and happiness"
    },
    {
      "id": "4",
      "title": "Atomic Habits",
      "author": "James Clear",
      "genre": "Self-Help",
      "pages": 320,
      "rating": 4.9,
      "reviews": 22156,
      "cover": "https://picsum.photos/300/400?random=4&keyword=habits",
      "readingProgress": 45,
      "status": "Reading",
      "price": 22.50,
      "publishedYear": 2018,
      "description": "An easy & proven way to build good habits & break bad ones"
    },
    {
      "id": "5",
      "title": "The Midnight Library",
      "author": "Matt Haig",
      "genre": "Fiction",
      "pages": 288,
      "rating": 4.5,
      "reviews": 12894,
      "cover": "https://picsum.photos/300/400?random=5&keyword=library",
      "readingProgress": 100,
      "status": "Completed",
      "price": 18.99,
      "publishedYear": 2020,
      "description": "A novel about all the choices that go into a life well lived"
    }
  ];

  List<Map<String, dynamic>> get filteredBooks {
    List<Map<String, dynamic>> filtered = List.from(favoriteBooks);

    // Apply filter
    if (filterBy != "all") {
      filtered = filtered.where((book) =>
          (book["status"] as String).toLowerCase().replaceAll(" ", "_") ==
          filterBy)
          .toList();
    }

    // Apply sorting
    switch (sortBy) {
      case "rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "progress":
        filtered.sort((a, b) => (b["readingProgress"] as int).compareTo(a["readingProgress"] as int));
        break;
      case "pages":
        filtered.sort((a, b) => (b["pages"] as int).compareTo(a["pages"] as int));
        break;
      case "year":
        filtered.sort((a, b) => (b["publishedYear"] as int).compareTo(a["publishedYear"] as int));
        break;
      default:
        filtered.sort((a, b) => (a["title"] as String).compareTo(b["title"] as String));
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Books"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${favoriteBooks.length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Books",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${favoriteBooks.where((b) => b["status"] == "Completed").length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Completed",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${favoriteBooks.where((b) => b["status"] == "Reading").length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Reading",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Filter Section
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Sort By",
                    items: [
                      {"label": "Title", "value": "title"},
                      {"label": "Rating", "value": "rating"},
                      {"label": "Reading Progress", "value": "progress"},
                      {"label": "Pages", "value": "pages"},
                      {"label": "Year Published", "value": "year"},
                    ],
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Filter Status",
                    items: [
                      {"label": "All Books", "value": "all"},
                      {"label": "Completed", "value": "completed"},
                      {"label": "Reading", "value": "reading"},
                      {"label": "Want to Read", "value": "want_to_read"},
                    ],
                    value: filterBy,
                    onChanged: (value, label) {
                      filterBy = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Books List
            filteredBooks.isEmpty
                ? Center(
              child: Column(
                children: [
                  SizedBox(height: spXl),
                  Icon(
                    Icons.menu_book,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "No books found",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  QButton(
                    label: "Browse Books",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            )
                : ResponsiveGridView(
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
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(radiusLg),
                            ),
                            child: Image.network(
                              "${book["cover"]}",
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: GestureDetector(
                              onTap: () async {
                                bool isConfirmed = await confirm("Remove this book from favorites?");
                                if (isConfirmed) {
                                  favoriteBooks.removeWhere((b) => b["id"] == book["id"]);
                                  setState(() {});
                                  ss("Book removed from favorites");
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [shadowSm],
                                ),
                                child: Icon(
                                  Icons.favorite,
                                  color: dangerColor,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: _getStatusColor(book["status"] as String),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${book["status"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Book Details
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${book["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "by ${book["author"]}",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${book["genre"]}",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${book["publishedYear"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(Icons.star, color: warningColor, size: 16),
                                SizedBox(width: spXs),
                                Text(
                                  "${book["rating"]}",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "(${book["reviews"]})",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(Icons.library_books, size: 16, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${book["pages"]} pages",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Spacer(),
                                Text(
                                  "\$${(book["price"] as double).toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),

                            // Reading Progress
                            if ((book["readingProgress"] as int) > 0) ...[
                              SizedBox(height: spSm),
                              Text(
                                "Reading Progress: ${book["readingProgress"]}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Container(
                                height: 4,
                                decoration: BoxDecoration(
                                  color: disabledColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: (book["readingProgress"] as int) / 100,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(book["status"] as String),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                ),
                              ),
                            ],

                            SizedBox(height: spMd),
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: book["status"] == "Want to Read" ? "Start Reading" : "Continue",
                                    size: bs.sm,
                                    onPressed: () {
                                      ss("Opening ${book["title"]}");
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.share,
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Sharing book recommendation");
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
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "Reading":
        return warningColor;
      case "Want to Read":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }
}
