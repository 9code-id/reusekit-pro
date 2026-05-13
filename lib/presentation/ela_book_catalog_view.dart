import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaBookCatalogView extends StatefulWidget {
  const ElaBookCatalogView({super.key});

  @override
  State<ElaBookCatalogView> createState() => _ElaBookCatalogViewState();
}

class _ElaBookCatalogViewState extends State<ElaBookCatalogView> {
  String selectedCategory = "All";
  String selectedGrade = "All Grades";
  String selectedSubject = "All Subjects";
  String searchQuery = "";
  bool isGridView = true;

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All", "count": 850},
    {"label": "Textbooks", "value": "Textbooks", "count": 320},
    {"label": "Reference", "value": "Reference", "count": 180},
    {"label": "Fiction", "value": "Fiction", "count": 150},
    {"label": "Workbooks", "value": "Workbooks", "count": 120},
    {"label": "Digital", "value": "Digital", "count": 80},
  ];

  List<Map<String, dynamic>> grades = [
    {"label": "All Grades", "value": "All Grades"},
    {"label": "Grade 1-3", "value": "Grade 1-3"},
    {"label": "Grade 4-6", "value": "Grade 4-6"},
    {"label": "Grade 7-9", "value": "Grade 7-9"},
    {"label": "Grade 10-12", "value": "Grade 10-12"},
    {"label": "University", "value": "University"},
  ];

  List<Map<String, dynamic>> subjects = [
    {"label": "All Subjects", "value": "All Subjects"},
    {"label": "Mathematics", "value": "Mathematics"},
    {"label": "Science", "value": "Science"},
    {"label": "English", "value": "English"},
    {"label": "History", "value": "History"},
    {"label": "Geography", "value": "Geography"},
    {"label": "Art", "value": "Art"},
  ];

  List<Map<String, dynamic>> books = [
    {
      "id": "1",
      "title": "Advanced Mathematics for Grade 10",
      "author": "Dr. Sarah Johnson",
      "subject": "Mathematics",
      "grade": "Grade 10-12",
      "category": "Textbooks",
      "image": "https://picsum.photos/200/280?random=1&keyword=math-book",
      "rating": 4.8,
      "reviews": 245,
      "pages": 456,
      "publisher": "Education Press",
      "year": 2024,
      "price": 45.99,
      "available": true,
      "format": "Physical",
      "isbn": "978-0-12-345678-9",
      "description": "Comprehensive mathematics textbook covering algebra, geometry, and trigonometry.",
    },
    {
      "id": "2",
      "title": "Interactive Science Experiments",
      "author": "Prof. Michael Chen",
      "subject": "Science",
      "grade": "Grade 7-9",
      "category": "Reference",
      "image": "https://picsum.photos/200/280?random=2&keyword=science-book",
      "rating": 4.9,
      "reviews": 189,
      "pages": 320,
      "publisher": "Science World",
      "year": 2024,
      "price": 38.50,
      "available": true,
      "format": "Digital",
      "isbn": "978-0-98-765432-1",
      "description": "Hands-on science experiments for middle school students.",
    },
    {
      "id": "3",
      "title": "English Literature Anthology",
      "author": "Emma Thompson",
      "subject": "English",
      "grade": "Grade 10-12",
      "category": "Fiction",
      "image": "https://picsum.photos/200/280?random=3&keyword=literature-book",
      "rating": 4.7,
      "reviews": 312,
      "pages": 580,
      "publisher": "Literary House",
      "year": 2023,
      "price": 42.00,
      "available": true,
      "format": "Physical",
      "isbn": "978-0-45-678912-3",
      "description": "Collection of classic and contemporary English literature.",
    },
    {
      "id": "4",
      "title": "Geography Workbook Grade 8",
      "author": "David Wilson",
      "subject": "Geography",
      "grade": "Grade 7-9",
      "category": "Workbooks",
      "image": "https://picsum.photos/200/280?random=4&keyword=geography-book",
      "rating": 4.6,
      "reviews": 156,
      "pages": 240,
      "publisher": "Atlas Publications",
      "year": 2024,
      "price": 28.75,
      "available": true,
      "format": "Physical",
      "isbn": "978-0-32-123456-7",
      "description": "Interactive geography workbook with maps and exercises.",
    },
    {
      "id": "5",
      "title": "World History Timeline",
      "author": "Dr. Maria Rodriguez",
      "subject": "History",
      "grade": "Grade 10-12",
      "category": "Reference",
      "image": "https://picsum.photos/200/280?random=5&keyword=history-book",
      "rating": 4.8,
      "reviews": 278,
      "pages": 412,
      "publisher": "Historical Society",
      "year": 2024,
      "price": 49.99,
      "available": true,
      "format": "Digital",
      "isbn": "978-0-87-654321-0",
      "description": "Comprehensive world history from ancient civilizations to modern times.",
    },
    {
      "id": "6",
      "title": "Art Fundamentals for Beginners",
      "author": "Lisa Park",
      "subject": "Art",
      "grade": "Grade 4-6",
      "category": "Textbooks",
      "image": "https://picsum.photos/200/280?random=6&keyword=art-book",
      "rating": 4.5,
      "reviews": 134,
      "pages": 280,
      "publisher": "Creative Arts",
      "year": 2023,
      "price": 35.25,
      "available": true,
      "format": "Physical",
      "isbn": "978-0-56-789123-4",
      "description": "Introduction to basic art techniques and principles.",
    },
  ];

  List<Map<String, dynamic>> get filteredBooks {
    return books.where((book) {
      bool matchesSearch = searchQuery.isEmpty ||
          book["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          book["author"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || book["category"] == selectedCategory;
      bool matchesGrade = selectedGrade == "All Grades" || book["grade"] == selectedGrade;
      bool matchesSubject = selectedSubject == "All Subjects" || book["subject"] == selectedSubject;
      
      return matchesSearch && matchesCategory && matchesGrade && matchesSubject;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Catalog"),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              isGridView = !isGridView;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Search Bar
            QTextField(
              label: "Search books, authors, topics...",
              value: searchQuery,
              hint: "Type to search catalog",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),

            // Categories Filter
            Container(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Expanded(
                    child: QHorizontalScroll(
                      children: categories.map((category) {
                        bool isSelected = selectedCategory == category["value"];
                        return Container(
                          margin: EdgeInsets.only(right: spSm),
                          child: GestureDetector(
                            onTap: () {
                              selectedCategory = category["value"];
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                              decoration: BoxDecoration(
                                color: isSelected ? primaryColor : Colors.white,
                                borderRadius: BorderRadius.circular(radiusMd),
                                border: Border.all(
                                  color: isSelected ? primaryColor : disabledOutlineBorderColor,
                                ),
                                boxShadow: [shadowSm],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "${category["label"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected ? Colors.white : primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${category["count"]} books",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isSelected ? Colors.white.withAlpha(200) : disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Filter Options
            Row(
              children: [
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
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Subject",
                    items: subjects,
                    value: selectedSubject,
                    onChanged: (value, label) {
                      selectedSubject = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Results Header
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
                Row(
                  children: [
                    Text(
                      "View:",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () {
                        isGridView = true;
                        setState(() {});
                      },
                      child: Icon(
                        Icons.grid_view,
                        color: isGridView ? primaryColor : disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () {
                        isGridView = false;
                        setState(() {});
                      },
                      child: Icon(
                        Icons.list,
                        color: !isGridView ? primaryColor : disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Books Display
            if (isGridView)
              ResponsiveGridView(
                minItemWidth: 200,
                children: filteredBooks.map((book) => _buildBookGridCard(book)).toList(),
              )
            else
              Column(
                children: filteredBooks.map((book) => _buildBookListCard(book)).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookGridCard(Map<String, dynamic> book) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
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
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
            child: Container(
              height: 160,
              width: double.infinity,
              child: Image.network(
                "${book["image"]}",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: disabledColor,
                  child: Icon(Icons.book, size: 50, color: disabledBoldColor),
                ),
              ),
            ),
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
                    fontSize: 14,
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
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.star, size: 14, color: warningColor),
                    SizedBox(width: spXs),
                    Text(
                      "${book["rating"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      " (${book["reviews"]})",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${(book["price"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: book["format"] == "Digital" ? infoColor : primaryColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${book["format"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "View Details",
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
  }

  Widget _buildBookListCard(Map<String, dynamic> book) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          // Book Cover
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Container(
              width: 80,
              height: 110,
              child: Image.network(
                "${book["image"]}",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: disabledColor,
                  child: Icon(Icons.book, size: 30, color: disabledBoldColor),
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),

          // Book Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                SizedBox(height: spXs),
                Text(
                  "by ${book["author"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${book["subject"]} • ${book["grade"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.star, size: 16, color: warningColor),
                    SizedBox(width: spXs),
                    Text(
                      "${book["rating"]} (${book["reviews"]} reviews)",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${(book["price"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    QButton(
                      label: "View Details",
                      size: bs.sm,
                      onPressed: () {
                        // Navigate to book detail
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

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Books"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QDropdownField(
              label: "Category",
              items: categories.map((cat) => {"label": cat["label"], "value": cat["value"]}).toList(),
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Grade Level",
              items: grades,
              value: selectedGrade,
              onChanged: (value, label) {
                selectedGrade = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Subject",
              items: subjects,
              value: selectedSubject,
              onChanged: (value, label) {
                selectedSubject = value;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              selectedCategory = "All";
              selectedGrade = "All Grades";
              selectedSubject = "All Subjects";
              setState(() {});
              Navigator.pop(context);
            },
            child: Text("Clear All"),
          ),
          QButton(
            label: "Apply Filters",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
