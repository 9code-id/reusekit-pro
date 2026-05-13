import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaCourseCatalogView extends StatefulWidget {
  const ElaCourseCatalogView({super.key});

  @override
  State<ElaCourseCatalogView> createState() => _ElaCourseCatalogViewState();
}

class _ElaCourseCatalogViewState extends State<ElaCourseCatalogView> {
  String searchQuery = "";
  String selectedCategory = "all";
  String selectedLevel = "all";
  String selectedDuration = "all";
  String sortBy = "popular";
  bool showFilters = false;

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Technology", "value": "technology"},
    {"label": "Business", "value": "business"},
    {"label": "Design", "value": "design"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Health & Fitness", "value": "health"},
    {"label": "Languages", "value": "languages"},
    {"label": "Music", "value": "music"},
    {"label": "Photography", "value": "photography"}
  ];

  List<Map<String, dynamic>> levels = [
    {"label": "All Levels", "value": "all"},
    {"label": "Beginner", "value": "beginner"},
    {"label": "Intermediate", "value": "intermediate"},
    {"label": "Advanced", "value": "advanced"}
  ];

  List<Map<String, dynamic>> durations = [
    {"label": "Any Duration", "value": "all"},
    {"label": "0-2 hours", "value": "short"},
    {"label": "3-6 hours", "value": "medium"},
    {"label": "7-17 hours", "value": "long"},
    {"label": "17+ hours", "value": "extra_long"}
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Most Popular", "value": "popular"},
    {"label": "Highest Rated", "value": "rating"},
    {"label": "Newest", "value": "newest"},
    {"label": "Price: Low to High", "value": "price_low"},
    {"label": "Price: High to Low", "value": "price_high"}
  ];

  List<Map<String, dynamic>> courses = [
    {
      "id": "1",
      "title": "Complete Web Development Bootcamp",
      "instructor": "Sarah Wilson",
      "rating": 4.9,
      "students": 15420,
      "duration": "40 hours",
      "level": "Beginner",
      "price": 89.99,
      "originalPrice": 199.99,
      "image": "https://picsum.photos/300/200?random=1&keyword=coding",
      "category": "technology",
      "isBestseller": true,
      "isNew": false,
      "description": "Learn web development from scratch with HTML, CSS, JavaScript, React, Node.js and more."
    },
    {
      "id": "2",
      "title": "Digital Marketing Mastery",
      "instructor": "Mike Johnson",
      "rating": 4.7,
      "students": 8950,
      "duration": "25 hours",
      "level": "intermediate",
      "price": 69.99,
      "originalPrice": 149.99,
      "image": "https://picsum.photos/300/200?random=2&keyword=marketing",
      "category": "marketing",
      "isBestseller": false,
      "isNew": true,
      "description": "Master digital marketing strategies including SEO, social media, and paid advertising."
    },
    {
      "id": "3",
      "title": "UI/UX Design Fundamentals",
      "instructor": "Emma Davis",
      "rating": 4.8,
      "students": 12300,
      "duration": "30 hours",
      "level": "beginner",
      "price": 79.99,
      "originalPrice": 179.99,
      "image": "https://picsum.photos/300/200?random=3&keyword=design",
      "category": "design",
      "isBestseller": true,
      "isNew": false,
      "description": "Learn the principles of user interface and user experience design."
    },
    {
      "id": "4",
      "title": "Python for Data Science",
      "instructor": "Dr. James Chen",
      "rating": 4.6,
      "students": 9800,
      "duration": "35 hours",
      "level": "intermediate",
      "price": 94.99,
      "originalPrice": 199.99,
      "image": "https://picsum.photos/300/200?random=4&keyword=python",
      "category": "technology",
      "isBestseller": false,
      "isNew": false,
      "description": "Master Python programming for data analysis and machine learning."
    },
    {
      "id": "5",
      "title": "Business Strategy & Analytics",
      "instructor": "Lisa Rodriguez",
      "rating": 4.5,
      "students": 6750,
      "duration": "22 hours",
      "level": "advanced",
      "price": 119.99,
      "originalPrice": 249.99,
      "image": "https://picsum.photos/300/200?random=5&keyword=business",
      "category": "business",
      "isBestseller": false,
      "isNew": true,
      "description": "Learn strategic thinking and business analytics for decision making."
    },
    {
      "id": "6",
      "title": "Photography Masterclass",
      "instructor": "Alex Thompson",
      "rating": 4.7,
      "students": 5420,
      "duration": "18 hours",
      "level": "beginner",
      "price": 59.99,
      "originalPrice": 129.99,
      "image": "https://picsum.photos/300/200?random=6&keyword=photography",
      "category": "photography",
      "isBestseller": false,
      "isNew": false,
      "description": "Master the art of photography from basics to advanced techniques."
    },
    {
      "id": "7",
      "title": "Spanish Language Complete Course",
      "instructor": "Maria Gonzalez",
      "rating": 4.8,
      "students": 11200,
      "duration": "45 hours",
      "level": "beginner",
      "price": 74.99,
      "originalPrice": 159.99,
      "image": "https://picsum.photos/300/200?random=7&keyword=spanish",
      "category": "languages",
      "isBestseller": true,
      "isNew": false,
      "description": "Learn Spanish from beginner to conversational level."
    },
    {
      "id": "8",
      "title": "Music Production with Logic Pro",
      "instructor": "David Kim",
      "rating": 4.6,
      "students": 4300,
      "duration": "28 hours",
      "level": "intermediate",
      "price": 89.99,
      "originalPrice": 179.99,
      "image": "https://picsum.photos/300/200?random=8&keyword=music",
      "category": "music",
      "isBestseller": false,
      "isNew": true,
      "description": "Create professional music using Logic Pro and industry techniques."
    }
  ];

  List<Map<String, dynamic>> get filteredCourses {
    var filtered = courses.where((course) {
      // Category filter
      bool matchesCategory = selectedCategory == "all" || course["category"] == selectedCategory;
      
      // Level filter
      bool matchesLevel = selectedLevel == "all" || course["level"] == selectedLevel;
      
      // Duration filter
      bool matchesDuration = true;
      if (selectedDuration != "all") {
        int hours = int.tryParse(course["duration"].toString().split(" ")[0]) ?? 0;
        switch (selectedDuration) {
          case "short":
            matchesDuration = hours <= 2;
            break;
          case "medium":
            matchesDuration = hours >= 3 && hours <= 6;
            break;
          case "long":
            matchesDuration = hours >= 7 && hours <= 17;
            break;
          case "extra_long":
            matchesDuration = hours > 17;
            break;
        }
      }
      
      // Search filter
      bool matchesSearch = searchQuery.isEmpty ||
          course["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          course["instructor"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          course["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesCategory && matchesLevel && matchesDuration && matchesSearch;
    }).toList();
    
    // Sort courses
    switch (sortBy) {
      case "popular":
        filtered.sort((a, b) => (b["students"] as int).compareTo(a["students"] as int));
        break;
      case "rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "newest":
        filtered.sort((a, b) => (b["isNew"] as bool ? 1 : 0).compareTo(a["isNew"] as bool ? 1 : 0));
        break;
      case "price_low":
        filtered.sort((a, b) => (a["price"] as double).compareTo(b["price"] as double));
        break;
      case "price_high":
        filtered.sort((a, b) => (b["price"] as double).compareTo(a["price"] as double));
        break;
    }
    
    return filtered;
  }

  void _enrollInCourse(Map<String, dynamic> course) {
    ss("Enrolled in: ${course["title"]}");
  }

  void _viewCourseDetail(Map<String, dynamic> course) {
    si("Opening course: ${course["title"]}");
  }

  void _clearFilters() {
    selectedCategory = "all";
    selectedLevel = "all";
    selectedDuration = "all";
    setState(() {});
  }

  Color _getLevelColor(String level) {
    switch (level) {
      case "beginner":
        return successColor;
      case "intermediate":
        return warningColor;
      case "advanced":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Course Catalog"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              showFilters = !showFilters;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              si("Opening advanced search");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Sort
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.grey.shade50,
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search courses...",
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
                        si("Searching for: $searchQuery");
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Sort by",
                        items: sortOptions,
                        value: sortBy,
                        onChanged: (value, label) {
                          sortBy = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      label: "Filters",
                      icon: showFilters ? Icons.expand_less : Icons.expand_more,
                      size: bs.sm,
                      onPressed: () {
                        showFilters = !showFilters;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Filters Panel
          if (showFilters)
            Container(
              padding: EdgeInsets.all(spMd),
              color: Colors.white,
              child: Column(
                spacing: spSm,
                children: [
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
                          label: "Level",
                          items: levels,
                          value: selectedLevel,
                          onChanged: (value, label) {
                            selectedLevel = value;
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
                          label: "Duration",
                          items: durations,
                          value: selectedDuration,
                          onChanged: (value, label) {
                            selectedDuration = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Clear Filters",
                        size: bs.sm,
                        onPressed: _clearFilters,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          
          // Results Header
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Text(
                  "${filteredCourses.length} courses found",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                if (filteredCourses.isNotEmpty)
                  Text(
                    "Showing ${filteredCourses.length} results",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
              ],
            ),
          ),
          
          // Course List
          Expanded(
            child: filteredCourses.isEmpty
                ? Container(
                    padding: EdgeInsets.all(spLg),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: spMd,
                      children: [
                        Icon(Icons.search_off, size: 64, color: disabledColor),
                        Text(
                          "No courses found",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Try adjusting your search criteria or filters",
                          style: TextStyle(
                            fontSize: 16,
                            color: disabledColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        QButton(
                          label: "Clear All Filters",
                          onPressed: () {
                            searchQuery = "";
                            _clearFilters();
                          },
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    padding: EdgeInsets.all(spMd),
                    child: ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: filteredCourses.map((course) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                                    child: Image.network(
                                      "${course["image"]}",
                                      width: double.infinity,
                                      height: 140,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  if (course["isBestseller"] == true)
                                    Positioned(
                                      top: spSm,
                                      left: spSm,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: warningColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "BESTSELLER",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (course["isNew"] == true)
                                    Positioned(
                                      top: spSm,
                                      right: spSm,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: successColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "NEW",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.all(spSm),
                                child: Column(
                                  spacing: spSm,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${course["title"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "by ${course["instructor"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${course["description"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.star, color: warningColor, size: 16),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${course["rating"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Text(
                                          "(${course["students"]})",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spSm,
                                            vertical: spXs,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _getLevelColor("${course["level"]}").withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${course["level"]}".toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: _getLevelColor("${course["level"]}"),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${course["duration"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "\$${(course["price"] as double).toStringAsFixed(2)}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Text(
                                          "\$${(course["originalPrice"] as double).toStringAsFixed(2)}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            decoration: TextDecoration.lineThrough,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: QButton(
                                            label: "View Details",
                                            size: bs.sm,
                                            onPressed: () => _viewCourseDetail(course),
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Expanded(
                                          child: QButton(
                                            label: "Enroll",
                                            size: bs.sm,
                                            onPressed: () => _enrollInCourse(course),
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
                  ),
          ),
        ],
      ),
    );
  }
}
