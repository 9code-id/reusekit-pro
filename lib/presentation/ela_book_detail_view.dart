import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaBookDetailView extends StatefulWidget {
  const ElaBookDetailView({super.key});

  @override
  State<ElaBookDetailView> createState() => _ElaBookDetailViewState();
}

class _ElaBookDetailViewState extends State<ElaBookDetailView> {
  bool isBookmarked = false;
  bool loading = false;
  int selectedTab = 0;

  final Map<String, dynamic> book = {
    "id": 1,
    "title": "To Kill a Mockingbird",
    "author": "Harper Lee",
    "category": "Fiction",
    "grade": "9-12",
    "pages": 376,
    "rating": 4.8,
    "reviews": 342,
    "image": "https://picsum.photos/300/400?random=1&keyword=book",
    "description": "Set in the fictional town of Maycomb, Alabama, during the 1930s, the story is told through the eyes of Scout Finch. Her father, Atticus Finch, is a lawyer who decides to defend a black man charged with rape, despite social pressure.",
    "availability": "Available",
    "isbn": "978-0-06-112008-4",
    "publisher": "Harper Perennial Modern Classics",
    "year": 1960,
    "language": "English",
    "genre": ["Fiction", "Classic Literature", "Historical Fiction"],
    "awards": ["Pulitzer Prize for Fiction (1961)", "Brotherhood Award (1961)"],
    "readingLevel": "9th Grade",
    "lexileLevel": "870L",
    "checkoutPeriod": "14 days",
    "totalCopies": 5,
    "availableCopies": 3,
    "holds": 2,
  };

  final List<Map<String, dynamic>> reviews = [
    {
      "id": 1,
      "reviewer": "Sarah Johnson",
      "grade": "11th Grade",
      "rating": 5,
      "date": "2024-03-15",
      "review": "This book is absolutely incredible! The way Harper Lee addresses social issues through the innocent eyes of Scout is masterful. Highly recommend for anyone studying American literature.",
    },
    {
      "id": 2,
      "reviewer": "Mike Chen",
      "grade": "10th Grade", 
      "rating": 4,
      "date": "2024-03-10",
      "review": "Great classic novel that really makes you think about justice and morality. Some parts were slow but overall a powerful story.",
    },
    {
      "id": 3,
      "reviewer": "Emma Davis",
      "grade": "12th Grade",
      "rating": 5,
      "date": "2024-03-08",
      "review": "One of the best books I've read for English class. Atticus Finch is such an inspiring character. The themes are still relevant today.",
    },
  ];

  final List<Map<String, dynamic>> relatedBooks = [
    {
      "title": "The Great Gatsby",
      "author": "F. Scott Fitzgerald",
      "image": "https://picsum.photos/120/160?random=2&keyword=book",
      "rating": 4.5,
    },
    {
      "title": "Of Mice and Men",
      "author": "John Steinbeck",
      "image": "https://picsum.photos/120/160?random=3&keyword=book",
      "rating": 4.3,
    },
    {
      "title": "The Catcher in the Rye",
      "author": "J.D. Salinger",
      "image": "https://picsum.photos/120/160?random=4&keyword=book",
      "rating": 4.1,
    },
  ];

  void _checkoutBook() async {
    loading = true;
    setState(() {});
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("Book checked out successfully! Due date: ${DateTime.now().add(Duration(days: 14)).dMMMy}");
  }

  void _reserveBook() async {
    loading = true;
    setState(() {});
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("Book reserved successfully! You'll be notified when it's available.");
  }

  @override
  Widget build(BuildContext context) {
    bool isAvailable = book["availableCopies"] > 0;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Details"),
        actions: [
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: isBookmarked ? primaryColor : null,
            ),
            onPressed: () {
              isBookmarked = !isBookmarked;
              setState(() {});
              if (isBookmarked) {
                ss("Book added to your reading list");
              } else {
                si("Book removed from your reading list");
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Share link copied to clipboard");
            },
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
                  // Book Header
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Book Cover
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${book["image"]}",
                            width: 120,
                            height: 160,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spSm),
                        
                        // Book Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${book["title"]}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "by ${book["author"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
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
                                        size: 16,
                                        color: warningColor,
                                      );
                                    }),
                                  ),
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
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isAvailable ? successColor : warningColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      isAvailable 
                                          ? "${book["availableCopies"]} Available" 
                                          : "${book["holds"]} Holds",
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: isAvailable ? "Check Out" : "Reserve",
                          size: bs.md,
                          onPressed: isAvailable ? _checkoutBook : _reserveBook,
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.preview,
                        size: bs.md,
                        onPressed: () {
                          // Navigate to preview
                        },
                      ),
                    ],
                  ),

                  // Tab Bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(radiusMd),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    selectedTab = 0;
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: spSm),
                                    decoration: BoxDecoration(
                                      color: selectedTab == 0 ? primaryColor : Colors.transparent,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "Details",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: selectedTab == 0 ? Colors.white : primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    selectedTab = 1;
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: spSm),
                                    decoration: BoxDecoration(
                                      color: selectedTab == 1 ? primaryColor : Colors.transparent,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "Reviews",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: selectedTab == 1 ? Colors.white : primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    selectedTab = 2;
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: spSm),
                                    decoration: BoxDecoration(
                                      color: selectedTab == 2 ? primaryColor : Colors.transparent,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "Related",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: selectedTab == 2 ? Colors.white : primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Tab Content
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: selectedTab == 0 
                              ? _buildDetailsTab()
                              : selectedTab == 1
                                  ? _buildReviewsTab()
                                  : _buildRelatedTab(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildDetailsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Description",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          "${book["description"]}",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
            height: 1.5,
          ),
        ),
        
        SizedBox(height: spSm),
        
        Text(
          "Book Information",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        _buildInfoRow("ISBN", "${book["isbn"]}"),
        _buildInfoRow("Publisher", "${book["publisher"]}"),
        _buildInfoRow("Publication Year", "${book["year"]}"),
        _buildInfoRow("Pages", "${book["pages"]}"),
        _buildInfoRow("Language", "${book["language"]}"),
        _buildInfoRow("Reading Level", "${book["readingLevel"]}"),
        _buildInfoRow("Lexile Level", "${book["lexileLevel"]}"),
        _buildInfoRow("Checkout Period", "${book["checkoutPeriod"]}"),
        
        SizedBox(height: spSm),
        
        Text(
          "Genres",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Wrap(
          spacing: spXs,
          runSpacing: spXs,
          children: (book["genre"] as List).map((genre) {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: spSm,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: secondaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "$genre",
                style: TextStyle(
                  fontSize: 12,
                  color: secondaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
        ),
        
        if ((book["awards"] as List).isNotEmpty) ...[
          SizedBox(height: spSm),
          Text(
            "Awards",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...(book["awards"] as List).map((award) {
            return Container(
              margin: EdgeInsets.only(bottom: spXs),
              child: Row(
                children: [
                  Icon(Icons.emoji_events, size: 16, color: warningColor),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "$award",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "$label:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Text(
              "Student Reviews",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              label: "Write Review",
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        
        ...reviews.map((review) {
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: primaryColor.withAlpha(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: primaryColor.withAlpha(20),
                      child: Text(
                        "${(review["reviewer"] as String).substring(0, 1)}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${review["reviewer"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${review["grade"]} • ${DateTime.parse(review["date"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: List.generate(5, (i) {
                        return Icon(
                          i < (review["rating"] as int)
                              ? Icons.star
                              : Icons.star_border,
                          size: 14,
                          color: warningColor,
                        );
                      }),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "${review["review"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildRelatedTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "You Might Also Like",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        ...relatedBooks.map((relatedBook) {
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusXs),
                  child: Image.network(
                    "${relatedBook["image"]}",
                    width: 60,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${relatedBook["title"]}",
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
                        "by ${relatedBook["author"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Row(
                            children: List.generate(5, (i) {
                              return Icon(
                                i < (relatedBook["rating"] as double).floor()
                                    ? Icons.star
                                    : Icons.star_border,
                                size: 12,
                                color: warningColor,
                              );
                            }),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${relatedBook["rating"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "View",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
