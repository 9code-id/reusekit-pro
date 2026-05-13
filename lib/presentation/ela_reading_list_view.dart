import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaReadingListView extends StatefulWidget {
  const ElaReadingListView({super.key});

  @override
  State<ElaReadingListView> createState() => _ElaReadingListViewState();
}

class _ElaReadingListViewState extends State<ElaReadingListView> {
  int selectedTab = 0;
  String selectedFilter = "All";
  bool loading = false;

  final List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Currently Reading", "value": "Reading"},
    {"label": "Want to Read", "value": "Want to Read"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Favorites", "value": "Favorites"},
  ];

  final List<Map<String, dynamic>> readingList = [
    {
      "id": 1,
      "title": "To Kill a Mockingbird",
      "author": "Harper Lee",
      "category": "Fiction",
      "grade": "9-12",
      "pages": 376,
      "currentPage": 125,
      "rating": 4.8,
      "image": "https://picsum.photos/150/200?random=1&keyword=book",
      "status": "Reading",
      "dateAdded": "2024-03-15",
      "dueDate": "2024-03-29",
      "notes": "Excellent character development. Scout's perspective is fascinating.",
      "progress": 33,
      "isFavorite": true,
      "readingTime": "2h 15m",
    },
    {
      "id": 2,
      "title": "The Great Gatsby",
      "author": "F. Scott Fitzgerald",
      "category": "Fiction",
      "grade": "9-12",
      "pages": 180,
      "currentPage": 180,
      "rating": 4.5,
      "image": "https://picsum.photos/150/200?random=2&keyword=book",
      "status": "Completed",
      "dateAdded": "2024-02-20",
      "dateCompleted": "2024-03-10",
      "notes": "Beautiful prose but complex themes. The symbolism is incredible.",
      "progress": 100,
      "isFavorite": false,
      "readingTime": "4h 32m",
    },
    {
      "id": 3,
      "title": "1984",
      "author": "George Orwell",
      "category": "Fiction",
      "grade": "9-12",
      "pages": 328,
      "currentPage": 0,
      "rating": 0,
      "image": "https://picsum.photos/150/200?random=3&keyword=dystopia",
      "status": "Want to Read",
      "dateAdded": "2024-03-12",
      "notes": "Recommended by Ms. Johnson for dystopian literature unit.",
      "progress": 0,
      "isFavorite": false,
      "readingTime": "0m",
    },
    {
      "id": 4,
      "title": "Pride and Prejudice",
      "author": "Jane Austen",
      "category": "Fiction",
      "grade": "9-12",
      "pages": 432,
      "currentPage": 87,
      "rating": 4.2,
      "image": "https://picsum.photos/150/200?random=4&keyword=classic",
      "status": "Reading",
      "dateAdded": "2024-03-08",
      "dueDate": "2024-03-25",
      "notes": "Love the wit and social commentary. Elizabeth is a great protagonist.",
      "progress": 20,
      "isFavorite": true,
      "readingTime": "3h 45m",
    },
    {
      "id": 5,
      "title": "The Catcher in the Rye",
      "author": "J.D. Salinger",
      "category": "Fiction",
      "grade": "9-12",
      "pages": 277,
      "currentPage": 277,
      "rating": 3.9,
      "image": "https://picsum.photos/150/200?random=5&keyword=coming-of-age",
      "status": "Completed",
      "dateAdded": "2024-01-15",
      "dateCompleted": "2024-02-18",
      "notes": "Holden's voice is unique but sometimes frustrating. Good character study.",
      "progress": 100,
      "isFavorite": false,
      "readingTime": "5h 12m",
    },
    {
      "id": 6,
      "title": "Of Mice and Men",
      "author": "John Steinbeck",
      "category": "Fiction",
      "grade": "9-12",
      "pages": 112,
      "currentPage": 0,
      "rating": 0,
      "image": "https://picsum.photos/150/200?random=6&keyword=depression",
      "status": "Want to Read",
      "dateAdded": "2024-03-18",
      "notes": "Short but powerful. Part of American Literature curriculum.",
      "progress": 0,
      "isFavorite": false,
      "readingTime": "0m",
    },
  ];

  List<Map<String, dynamic>> get filteredBooks {
    if (selectedFilter == "All") return readingList;
    if (selectedFilter == "Favorites") {
      return readingList.where((book) => book["isFavorite"] == true).toList();
    }
    return readingList.where((book) => book["status"] == selectedFilter).toList();
  }

  Map<String, int> get readingStats {
    int reading = readingList.where((book) => book["status"] == "Reading").length;
    int completed = readingList.where((book) => book["status"] == "Completed").length;
    int wantToRead = readingList.where((book) => book["status"] == "Want to Read").length;
    int totalPages = readingList
        .where((book) => book["status"] == "Completed")
        .fold(0, (sum, book) => sum + (book["pages"] as int));
    
    return {
      "reading": reading,
      "completed": completed,
      "wantToRead": wantToRead,
      "totalPages": totalPages,
    };
  }

  void _updateBookStatus(int bookId, String newStatus) {
    final bookIndex = readingList.indexWhere((book) => book["id"] == bookId);
    if (bookIndex != -1) {
      readingList[bookIndex]["status"] = newStatus;
      if (newStatus == "Completed") {
        readingList[bookIndex]["dateCompleted"] = DateTime.now().toIso8601String().split('T')[0];
        readingList[bookIndex]["progress"] = 100;
        readingList[bookIndex]["currentPage"] = readingList[bookIndex]["pages"];
      }
      setState(() {});
      ss("Book status updated to $newStatus");
    }
  }

  void _toggleFavorite(int bookId) {
    final bookIndex = readingList.indexWhere((book) => book["id"] == bookId);
    if (bookIndex != -1) {
      readingList[bookIndex]["isFavorite"] = !readingList[bookIndex]["isFavorite"];
      setState(() {});
      if (readingList[bookIndex]["isFavorite"]) {
        ss("Added to favorites");
      } else {
        si("Removed from favorites");
      }
    }
  }

  void _removeFromList(int bookId) async {
    bool isConfirmed = await confirm("Remove this book from your reading list?");
    if (isConfirmed) {
      readingList.removeWhere((book) => book["id"] == bookId);
      setState(() {});
      ss("Book removed from reading list");
    }
  }

  @override
  Widget build(BuildContext context) {
    final stats = readingStats;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("My Reading List"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add book
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // Navigate to reading analytics
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Reading Stats
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reading Progress",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          "Currently Reading",
                          "${stats["reading"]}",
                          Icons.menu_book,
                          primaryColor,
                        ),
                      ),
                      Expanded(
                        child: _buildStatCard(
                          "Completed",
                          "${stats["completed"]}",
                          Icons.check_circle,
                          successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          "Want to Read",
                          "${stats["wantToRead"]}",
                          Icons.bookmark,
                          infoColor,
                        ),
                      ),
                      Expanded(
                        child: _buildStatCard(
                          "Pages Read",
                          "${stats["totalPages"]}",
                          Icons.article,
                          warningColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Filter Options
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filter Books",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QCategoryPicker(
                    items: filterOptions,
                    value: selectedFilter,
                    onChanged: (index, label, value, item) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Books List
            Text(
              filteredBooks.isEmpty 
                  ? "No books found" 
                  : "${filteredBooks.length} books in $selectedFilter",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            if (filteredBooks.isEmpty)
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Icon(
                      Icons.library_books,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No books found",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Add some books to your reading list to get started",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: spMd),
                    QButton(
                      label: "Browse Library",
                      size: bs.md,
                      onPressed: () {
                        // Navigate to library
                      },
                    ),
                  ],
                ),
              )
            else
              ...filteredBooks.map((book) {
                Color statusColor;
                switch (book["status"]) {
                  case "Reading":
                    statusColor = primaryColor;
                    break;
                  case "Completed":
                    statusColor = successColor;
                    break;
                  case "Want to Read":
                    statusColor = infoColor;
                    break;
                  default:
                    statusColor = disabledBoldColor;
                }

                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: statusColor,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Book Cover
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Stack(
                              children: [
                                Image.network(
                                  "${book["image"]}",
                                  width: 80,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                                if (book["isFavorite"] == true)
                                  Positioned(
                                    top: spXs,
                                    right: spXs,
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: warningColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          
                          SizedBox(width: spSm),
                          
                          // Book Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${book["title"]}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => _toggleFavorite(book["id"]),
                                      child: Icon(
                                        book["isFavorite"] 
                                            ? Icons.favorite 
                                            : Icons.favorite_border,
                                        color: book["isFavorite"] 
                                            ? Colors.red 
                                            : disabledBoldColor,
                                        size: 20,
                                      ),
                                    ),
                                  ],
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
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: statusColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${book["status"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 4,
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
                                  ],
                                ),
                                SizedBox(height: spXs),
                                
                                // Progress for reading books
                                if (book["status"] == "Reading") ...[
                                  Row(
                                    children: [
                                      Text(
                                        "Page ${book["currentPage"]} of ${book["pages"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${book["progress"]}%",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  LinearProgressIndicator(
                                    value: (book["progress"] as int) / 100,
                                    backgroundColor: statusColor.withAlpha(50),
                                    valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                                  ),
                                  SizedBox(height: spXs),
                                  if (book["dueDate"] != null)
                                    Text(
                                      "Due: ${DateTime.parse(book["dueDate"]).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: DateTime.parse(book["dueDate"]).isBefore(DateTime.now().add(Duration(days: 3)))
                                            ? dangerColor
                                            : disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                ],
                                
                                // Completion info for completed books
                                if (book["status"] == "Completed") ...[
                                  if (book["rating"] > 0)
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
                                          ),
                                        ),
                                      ],
                                    ),
                                  if (book["dateCompleted"] != null)
                                    Text(
                                      "Completed: ${DateTime.parse(book["dateCompleted"]).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  Text(
                                    "Reading time: ${book["readingTime"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                                
                                if (book["notes"] != null && (book["notes"] as String).isNotEmpty) ...[
                                  SizedBox(height: spXs),
                                  Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: infoColor.withAlpha(10),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${book["notes"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Action Buttons
                      Row(
                        children: [
                          if (book["status"] == "Want to Read")
                            Expanded(
                              child: QButton(
                                label: "Start Reading",
                                size: bs.sm,
                                onPressed: () => _updateBookStatus(book["id"], "Reading"),
                              ),
                            )
                          else if (book["status"] == "Reading") ...[
                            Expanded(
                              child: QButton(
                                label: "Continue Reading",
                                size: bs.sm,
                                onPressed: () {
                                  // Navigate to reader
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              label: "Mark Complete",
                              size: bs.sm,
                              onPressed: () => _updateBookStatus(book["id"], "Completed"),
                            ),
                          ]
                          else if (book["status"] == "Completed") ...[
                            Expanded(
                              child: QButton(
                                label: "Read Again",
                                size: bs.sm,
                                onPressed: () => _updateBookStatus(book["id"], "Reading"),
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.rate_review,
                              size: bs.sm,
                              onPressed: () {
                                // Navigate to review
                              },
                            ),
                          ],
                          
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.more_vert,
                            size: bs.sm,
                            onPressed: () {
                              _showBookOptions(book);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(right: spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showBookOptions(Map<String, dynamic> book) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${book["title"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              ListTile(
                leading: Icon(Icons.edit),
                title: Text("Edit Notes"),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to edit notes
                },
              ),
              
              ListTile(
                leading: Icon(Icons.share),
                title: Text("Share Book"),
                onTap: () {
                  Navigator.pop(context);
                  ss("Sharing link copied to clipboard");
                },
              ),
              
              ListTile(
                leading: Icon(Icons.visibility),
                title: Text("View Details"),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to book detail
                },
              ),
              
              ListTile(
                leading: Icon(Icons.delete, color: dangerColor),
                title: Text(
                  "Remove from List",
                  style: TextStyle(color: dangerColor),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _removeFromList(book["id"]);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
