import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSearch1View extends StatefulWidget {
  @override
  State<GrlSearch1View> createState() => _GrlSearch1ViewState();
}

class _GrlSearch1ViewState extends State<GrlSearch1View> {
  String searchQuery = "";
  String selectedCategory = "all";
  List<String> recentSearches = [
    "Flutter development",
    "Dart programming",
    "Mobile app design",
    "UI components",
    "State management"
  ];

  List<Map<String, dynamic>> searchResults = [
    {
      "id": 1,
      "title": "Advanced Flutter Development Course",
      "description": "Learn advanced concepts in Flutter development including state management, animations, and custom widgets.",
      "category": "course",
      "rating": 4.8,
      "students": 1250,
      "price": 89.99,
      "image": "https://picsum.photos/120/80?random=1&keyword=coding",
      "instructor": "John Smith",
      "duration": "12 hours"
    },
    {
      "id": 2,
      "title": "Dart Programming Fundamentals",
      "description": "Master the basics of Dart programming language from scratch with hands-on examples.",
      "category": "course",
      "rating": 4.6,
      "students": 890,
      "price": 59.99,
      "image": "https://picsum.photos/120/80?random=2&keyword=programming",
      "instructor": "Sarah Johnson",
      "duration": "8 hours"
    },
    {
      "id": 3,
      "title": "Mobile App UI/UX Design",
      "description": "Create stunning mobile app interfaces with modern design principles and best practices.",
      "category": "design",
      "rating": 4.9,
      "students": 2100,
      "price": 79.99,
      "image": "https://picsum.photos/120/80?random=3&keyword=design",
      "instructor": "Mike Wilson",
      "duration": "10 hours"
    },
    {
      "id": 4,
      "title": "Flutter State Management Guide",
      "description": "Complete guide to state management in Flutter using Provider, Bloc, and Riverpod.",
      "category": "tutorial",
      "rating": 4.7,
      "students": 650,
      "price": 49.99,
      "image": "https://picsum.photos/120/80?random=4&keyword=flutter",
      "instructor": "Emma Davis",
      "duration": "6 hours"
    }
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "all"},
    {"label": "Courses", "value": "course"},
    {"label": "Tutorials", "value": "tutorial"},
    {"label": "Design", "value": "design"},
    {"label": "Programming", "value": "programming"}
  ];

  List<Map<String, dynamic>> get filteredResults {
    if (selectedCategory == "all") return searchResults;
    return searchResults.where((item) => item["category"] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Show filter options
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
            // Search Input
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search courses, tutorials...",
                    value: searchQuery,
                    hint: "What do you want to learn?",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.md,
                  onPressed: () {
                    // Perform search
                  },
                ),
              ],
            ),

            // Category Filter
            QCategoryPicker(
              label: "Categories",
              items: categories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            // Recent Searches
            if (searchQuery.isEmpty) ...[
              Text(
                "Recent Searches",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                width: double.infinity,
                child: Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: recentSearches.map((search) {
                    return GestureDetector(
                      onTap: () {
                        searchQuery = search;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: disabledOutlineBorderColor,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.history,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              search,
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],

            // Search Results
            if (searchQuery.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Search Results (${filteredResults.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Sort by: Relevance",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),

              // Results List
              Column(
                spacing: spSm,
                children: filteredResults.map((result) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        // Course Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusXs),
                          child: Image.network(
                            "${result["image"]}",
                            width: 120,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spSm),

                        // Course Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "${result["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${result["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${result["instructor"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(
                                    Icons.access_time,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${result["duration"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 16,
                                        color: warningColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${(result["rating"] as num).toStringAsFixed(1)}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "(${(result["students"] as int)})",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "\$${((result["price"] as double)).currency}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
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
                }).toList(),
              ),
            ],

            // Empty State
            if (searchQuery.isNotEmpty && filteredResults.isEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No results found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search terms or categories",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
