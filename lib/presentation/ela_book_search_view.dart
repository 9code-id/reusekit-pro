import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaBookSearchView extends StatefulWidget {
  const ElaBookSearchView({super.key});

  @override
  State<ElaBookSearchView> createState() => _ElaBookSearchViewState();
}

class _ElaBookSearchViewState extends State<ElaBookSearchView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedGrade = "All Grades";
  String selectedAvailability = "All";
  String sortBy = "Relevance";
  bool loading = false;
  bool showFilters = false;

  final List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Fiction", "value": "Fiction"},
    {"label": "Non-Fiction", "value": "Non-Fiction"},
    {"label": "Science", "value": "Science"},
    {"label": "History", "value": "History"},
    {"label": "Biography", "value": "Biography"},
    {"label": "Poetry", "value": "Poetry"},
    {"label": "Drama", "value": "Drama"},
    {"label": "Reference", "value": "Reference"},
  ];

  final List<Map<String, dynamic>> grades = [
    {"label": "All Grades", "value": "All Grades"},
    {"label": "K-2", "value": "K-2"},
    {"label": "3-5", "value": "3-5"},
    {"label": "6-8", "value": "6-8"},
    {"label": "9-12", "value": "9-12"},
  ];

  final List<Map<String, dynamic>> availability = [
    {"label": "All", "value": "All"},
    {"label": "Available", "value": "Available"},
    {"label": "Checked Out", "value": "Checked Out"},
    {"label": "Reserved", "value": "Reserved"},
  ];

  final List<Map<String, dynamic>> sortOptions = [
    {"label": "Relevance", "value": "Relevance"},
    {"label": "Title A-Z", "value": "Title A-Z"},
    {"label": "Title Z-A", "value": "Title Z-A"},
    {"label": "Author A-Z", "value": "Author A-Z"},
    {"label": "Newest First", "value": "Newest First"},
    {"label": "Highest Rated", "value": "Highest Rated"},
  ];

  final List<String> recentSearches = [
    "To Kill a Mockingbird",
    "Harper Lee",
    "American Literature",
    "Classic Fiction",
    "Coming of Age",
  ];

  final List<String> popularSearches = [
    "Shakespeare",
    "Poetry Collection",
    "Science Fiction",
    "Historical Fiction",
    "Biographies",
    "Study Guides",
    "Young Adult",
    "Reference Books",
  ];

  final List<Map<String, dynamic>> searchResults = [
    {
      "id": 1,
      "title": "To Kill a Mockingbird",
      "author": "Harper Lee",
      "category": "Fiction",
      "grade": "9-12",
      "pages": 376,
      "rating": 4.8,
      "reviews": 342,
      "image": "https://picsum.photos/150/200?random=1&keyword=book",
      "availability": "Available",
      "copies": 3,
      "description": "A gripping tale of racial injustice and lost innocence in the American South.",
      "isbn": "978-0-06-112008-4",
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
      "reviews": 289,
      "image": "https://picsum.photos/150/200?random=2&keyword=book",
      "availability": "Checked Out",
      "copies": 0,
      "description": "A classic American novel about the Jazz Age and the American Dream.",
      "isbn": "978-0-7432-7356-5",
      "year": 1925,
    },
    {
      "id": 3,
      "title": "Mockingbird: A Portrait of Harper Lee",
      "author": "Charles J. Shields",
      "category": "Biography",
      "grade": "9-12",
      "pages": 352,
      "rating": 4.2,
      "reviews": 156,
      "image": "https://picsum.photos/150/200?random=3&keyword=biography",
      "availability": "Available",
      "copies": 2,
      "description": "An in-depth biography of Harper Lee and the creation of her masterpiece.",
      "isbn": "978-0-8050-8782-4",
      "year": 2006,
    },
    {
      "id": 4,
      "title": "Go Set a Watchman",
      "author": "Harper Lee",
      "category": "Fiction",
      "grade": "9-12",
      "pages": 278,
      "rating": 3.8,
      "reviews": 201,
      "image": "https://picsum.photos/150/200?random=4&keyword=book",
      "availability": "Available",
      "copies": 4,
      "description": "Harper Lee's second novel, published decades after To Kill a Mockingbird.",
      "isbn": "978-0-06-240985-0",
      "year": 2015,
    },
  ];

  List<Map<String, dynamic>> get filteredResults {
    List<Map<String, dynamic>> results = List.from(searchResults);
    
    if (searchQuery.isNotEmpty) {
      results = results.where((book) {
        return (book["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (book["author"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (book["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    if (selectedCategory != "All") {
      results = results.where((book) => book["category"] == selectedCategory).toList();
    }
    
    if (selectedGrade != "All Grades") {
      results = results.where((book) => book["grade"] == selectedGrade).toList();
    }
    
    if (selectedAvailability != "All") {
      results = results.where((book) => book["availability"] == selectedAvailability).toList();
    }
    
    // Sort results
    switch (sortBy) {
      case "Title A-Z":
        results.sort((a, b) => (a["title"] as String).compareTo(b["title"] as String));
        break;
      case "Title Z-A":
        results.sort((a, b) => (b["title"] as String).compareTo(a["title"] as String));
        break;
      case "Author A-Z":
        results.sort((a, b) => (a["author"] as String).compareTo(b["author"] as String));
        break;
      case "Newest First":
        results.sort((a, b) => (b["year"] as int).compareTo(a["year"] as int));
        break;
      case "Highest Rated":
        results.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
    }
    
    return results;
  }

  void _performSearch() {
    if (searchQuery.trim().isEmpty) return;
    
    loading = true;
    setState(() {});
    
    // Simulate API call
    Future.delayed(Duration(seconds: 1), () {
      loading = false;
      setState(() {});
    });
  }

  void _clearFilters() {
    selectedCategory = "All";
    selectedGrade = "All Grades";
    selectedAvailability = "All";
    sortBy = "Relevance";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Books"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              showFilters = !showFilters;
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
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
                      onPressed: _performSearch,
                    ),
                  ],
                ),
                
                // Quick Filters
                if (!showFilters)
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
                          label: "Sort By",
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

          // Advanced Filters
          if (showFilters)
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                border: Border(
                  bottom: BorderSide(color: primaryColor.withAlpha(50)),
                ),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Advanced Filters",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Clear All",
                        size: bs.sm,
                        onPressed: _clearFilters,
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
                  
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Availability",
                          items: availability,
                          value: selectedAvailability,
                          onChanged: (value, label) {
                            selectedAvailability = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Sort By",
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

          // Content
          Expanded(
            child: loading
                ? Center(child: CircularProgressIndicator())
                : searchQuery.isEmpty
                    ? _buildEmptyState()
                    : _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recent Searches
          if (recentSearches.isNotEmpty) ...[
            Text(
              "Recent Searches",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spXs,
                children: recentSearches.map((search) {
                  return GestureDetector(
                    onTap: () {
                      searchQuery = search;
                      _performSearch();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.history,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              search,
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.north_west,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],

          // Popular Searches
          Text(
            "Popular Searches",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: popularSearches.map((search) {
                return GestureDetector(
                  onTap: () {
                    searchQuery = search;
                    _performSearch();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: secondaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: secondaryColor.withAlpha(50)),
                    ),
                    child: Text(
                      search,
                      style: TextStyle(
                        fontSize: 12,
                        color: secondaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Search Tips
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb, color: infoColor, size: 20),
                    SizedBox(width: spSm),
                    Text(
                      "Search Tips",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "• Search by title, author, or keywords\n"
                  "• Use quotes for exact phrases: \"To Kill a Mockingbird\"\n"
                  "• Filter by grade level and category\n"
                  "• Check availability status before requesting",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Results Summary
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: primaryColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: primaryColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Found ${filteredResults.length} results for \"$searchQuery\"",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
                if (searchQuery.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      searchQuery = "";
                      setState(() {});
                    },
                    child: Icon(
                      Icons.close,
                      color: primaryColor,
                      size: 20,
                    ),
                  ),
              ],
            ),
          ),

          // Search Results
          if (filteredResults.isEmpty)
            Center(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: disabledBoldColor,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "No results found",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Try adjusting your search terms or filters",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          else
            ...filteredResults.map((book) {
              Color statusColor = book["availability"] == "Available" 
                  ? successColor 
                  : book["availability"] == "Checked Out"
                      ? warningColor
                      : infoColor;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
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
                      child: Stack(
                        children: [
                          Image.network(
                            "${book["image"]}",
                            width: 80,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: spXs,
                            right: spXs,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${book["availability"]}",
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
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
                              Row(
                                children: List.generate(5, (i) {
                                  return Icon(
                                    i < (book["rating"] as double).floor()
                                        ? Icons.star
                                        : Icons.star_border,
                                    size: 12,
                                    color: warningColor,
                                  );
                                }),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${book["rating"]} (${book["reviews"]})",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
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
                                    fontSize: 9,
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
                                    fontSize: 9,
                                    color: infoColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
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
                          
                          // Actions
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: book["availability"] == "Available" 
                                      ? "Check Out" 
                                      : "Reserve",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.visibility,
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
            }).toList(),
        ],
      ),
    );
  }
}
