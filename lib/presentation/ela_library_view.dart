import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaLibraryView extends StatefulWidget {
  const ElaLibraryView({super.key});

  @override
  State<ElaLibraryView> createState() => _ElaLibraryViewState();
}

class _ElaLibraryViewState extends State<ElaLibraryView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedGrade = "All Grades";
  bool loading = false;

  final List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Fiction", "value": "Fiction"},
    {"label": "Non-Fiction", "value": "Non-Fiction"},
    {"label": "Poetry", "value": "Poetry"},
    {"label": "Drama", "value": "Drama"},
    {"label": "Biography", "value": "Biography"},
    {"label": "Science", "value": "Science"},
    {"label": "History", "value": "History"},
  ];

  final List<Map<String, dynamic>> grades = [
    {"label": "All Grades", "value": "All Grades"},
    {"label": "Grade K-2", "value": "K-2"},
    {"label": "Grade 3-5", "value": "3-5"},
    {"label": "Grade 6-8", "value": "6-8"},
    {"label": "Grade 9-12", "value": "9-12"},
  ];

  final List<Map<String, dynamic>> books = [
    {
      "id": 1,
      "title": "To Kill a Mockingbird",
      "author": "Harper Lee",
      "category": "Fiction",
      "grade": "9-12",
      "pages": 376,
      "rating": 4.8,
      "image": "https://picsum.photos/150/200?random=1&keyword=book",
      "description": "A gripping tale of racial injustice and lost innocence in the American South.",
      "availability": "Available",
      "isbn": "978-0-06-112008-4",
      "publisher": "Harper Perennial Modern Classics",
      "year": 1960,
    },
    {
      "id": 2,
      "title": "The Great Gatsby",
      "author": "F. Scott Fitzgerald",
      "category": "Fiction",
      "grade": "9-12",
      "pages": 180,
      "rating": 4.5,
      "image": "https://picsum.photos/150/200?random=2&keyword=book",
      "description": "A classic American novel about the Jazz Age and the American Dream.",
      "availability": "Checked Out",
      "isbn": "978-0-7432-7356-5",
      "publisher": "Scribner",
      "year": 1925,
    },
    {
      "id": 3,
      "title": "National Geographic Kids",
      "author": "Various Authors",
      "category": "Science",
      "grade": "3-5",
      "pages": 50,
      "rating": 4.7,
      "image": "https://picsum.photos/150/200?random=3&keyword=science",
      "description": "Educational magazine featuring amazing facts about animals, science, and nature.",
      "availability": "Available",
      "isbn": "978-1-4263-3456-7",
      "publisher": "National Geographic",
      "year": 2023,
    },
    {
      "id": 4,
      "title": "Charlotte's Web",
      "author": "E.B. White",
      "category": "Fiction",
      "grade": "3-5",
      "pages": 184,
      "rating": 4.9,
      "image": "https://picsum.photos/150/200?random=4&keyword=children",
      "description": "The story of a pig named Wilbur and his friendship with a barn spider named Charlotte.",
      "availability": "Available",
      "isbn": "978-0-06-440055-8",
      "publisher": "Harper & Row",
      "year": 1952,
    },
    {
      "id": 5,
      "title": "Where the Red Fern Grows",
      "author": "Wilson Rawls",
      "category": "Fiction",
      "grade": "6-8",
      "pages": 212,
      "rating": 4.6,
      "image": "https://picsum.photos/150/200?random=5&keyword=adventure",
      "description": "A boy's devotion to his two hunting dogs and their adventures in the Ozark Mountains.",
      "availability": "Available",
      "isbn": "978-0-440-41267-1",
      "publisher": "Yearling",
      "year": 1961,
    },
    {
      "id": 6,
      "title": "A Wrinkle in Time",
      "author": "Madeleine L'Engle",
      "category": "Fiction",
      "grade": "6-8",
      "pages": 256,
      "rating": 4.4,
      "image": "https://picsum.photos/150/200?random=6&keyword=fantasy",
      "description": "A young girl travels through time and space to rescue her father.",
      "availability": "Available",
      "isbn": "978-0-312-36754-1",
      "publisher": "Square Fish",
      "year": 1962,
    },
  ];

  List<Map<String, dynamic>> get filteredBooks {
    return books.where((book) {
      bool matchesSearch = searchQuery.isEmpty ||
          (book["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (book["author"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || book["category"] == selectedCategory;
      bool matchesGrade = selectedGrade == "All Grades" || book["grade"] == selectedGrade;
      
      return matchesSearch && matchesCategory && matchesGrade;
    }).toList();
  }

  void _searchBooks() {
    loading = true;
    setState(() {});
    
    // Simulate API call
    Future.delayed(Duration(seconds: 1), () {
      loading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ELA Library"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {},
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Section
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: QTextField(
                                label: "Search books, authors, or topics",
                                value: searchQuery,
                                hint: "Enter keywords to search",
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
                              onPressed: _searchBooks,
                            ),
                          ],
                        ),
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
                                label: "Grade Level",
                                items: grades,
                                value: selectedGrade,
                                onChanged: (value, label) {
                                  selectedGrade = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Stats Section
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: primaryColor.withAlpha(50)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.library_books, color: primaryColor),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Library Collection",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${filteredBooks.length} books available • ${books.where((b) => b["availability"] == "Available").length} in stock",
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

                  // Books Grid
                  Text(
                    "Browse Books",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: filteredBooks.map((book) {
                      Color statusColor = book["availability"] == "Available" 
                          ? successColor 
                          : warningColor;
                      
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Book Cover
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(radiusMd),
                              ),
                              child: Stack(
                                children: [
                                  Image.network(
                                    "${book["image"]}",
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    top: spXs,
                                    right: spXs,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: statusColor,
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "${book["availability"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (book["availability"] == "Available")
                                    Positioned(
                                      bottom: spXs,
                                      right: spXs,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          icon: Icon(Icons.bookmark_border),
                                          color: primaryColor,
                                          iconSize: 20,
                                          onPressed: () {},
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),

                            // Book Info
                            Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${book["title"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "by ${book["author"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: secondaryColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${book["category"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: secondaryColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: infoColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "Grade ${book["grade"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: infoColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Row(
                                        children: List.generate(5, (i) {
                                          return Icon(
                                            i < (book["rating"] as double).floor()
                                                ? Icons.star
                                                : Icons.star_border,
                                            size: 14,
                                            color: warningColor,
                                          );
                                        }),
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${book["rating"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                          fontWeight: FontWeight.w600,
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
                                  SizedBox(height: spSm),
                                  Text(
                                    "${book["description"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: spSm),
                                  
                                  // Action Button
                                  Container(
                                    width: double.infinity,
                                    child: QButton(
                                      label: book["availability"] == "Available" 
                                          ? "Check Out" 
                                          : "Reserve",
                                      size: bs.sm,
                                      onPressed: () {
                                        // Navigate to book detail
                                      },
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
