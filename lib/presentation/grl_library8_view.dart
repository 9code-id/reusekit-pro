import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLibrary8View extends StatefulWidget {
  @override
  State<GrlLibrary8View> createState() => _GrlLibrary8ViewState();
}

class _GrlLibrary8ViewState extends State<GrlLibrary8View> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedType = "All";

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Database", "value": "Database"},
    {"label": "E-Journal", "value": "E-Journal"},
    {"label": "E-Book", "value": "E-Book"},
    {"label": "Research Tool", "value": "Research Tool"},
    {"label": "News", "value": "News"},
  ];

  List<Map<String, dynamic>> types = [
    {"label": "All", "value": "All"},
    {"label": "Academic", "value": "Academic"},
    {"label": "Professional", "value": "Professional"},
    {"label": "General", "value": "General"},
    {"label": "Specialized", "value": "Specialized"},
  ];

  List<Map<String, dynamic>> digitalResources = [
    {
      "id": 1,
      "name": "IEEE Xplore Digital Library",
      "description": "Comprehensive database of electrical engineering, computer science, and electronics literature",
      "category": "Database",
      "type": "Academic",
      "provider": "IEEE",
      "accessType": "Subscription",
      "url": "https://ieeexplore.ieee.org",
      "image": "https://picsum.photos/400/300?random=1&keyword=engineering",
      "subjects": ["Engineering", "Computer Science", "Electronics"],
      "coverage": "1884-Present",
      "lastUpdated": "2024-12-20",
      "popularity": 95,
      "isBookmarked": true,
      "accessCount": 2847,
      "userRating": 4.8,
    },
    {
      "id": 2,
      "name": "Nature Digital Archive",
      "description": "Complete digital archive of Nature journal from 1869 to present",
      "category": "E-Journal",
      "type": "Academic",
      "provider": "Nature Publishing Group",
      "accessType": "Open Access",
      "url": "https://nature.com",
      "image": "https://picsum.photos/400/300?random=2&keyword=science",
      "subjects": ["Science", "Research", "Biology"],
      "coverage": "1869-Present",
      "lastUpdated": "2024-12-21",
      "popularity": 89,
      "isBookmarked": false,
      "accessCount": 1924,
      "userRating": 4.9,
    },
    {
      "id": 3,
      "name": "Oxford Academic Books",
      "description": "Extensive collection of academic e-books from Oxford University Press",
      "category": "E-Book",
      "type": "Academic",
      "provider": "Oxford University Press",
      "accessType": "Subscription",
      "url": "https://academic.oup.com",
      "image": "https://picsum.photos/400/300?random=3&keyword=books",
      "subjects": ["Literature", "History", "Philosophy", "Science"],
      "coverage": "2000-Present",
      "lastUpdated": "2024-12-19",
      "popularity": 78,
      "isBookmarked": true,
      "accessCount": 1456,
      "userRating": 4.7,
    },
    {
      "id": 4,
      "name": "JSTOR Digital Archive",
      "description": "Digital library of academic journals, books, and primary sources",
      "category": "Database",
      "type": "Academic",
      "provider": "JSTOR",
      "accessType": "Subscription",
      "url": "https://jstor.org",
      "image": "https://picsum.photos/400/300?random=4&keyword=academic",
      "subjects": ["Humanities", "Social Sciences", "Arts"],
      "coverage": "1665-Present",
      "lastUpdated": "2024-12-20",
      "popularity": 92,
      "isBookmarked": false,
      "accessCount": 3245,
      "userRating": 4.6,
    },
    {
      "id": 5,
      "name": "Zotero Research Tool",
      "description": "Free reference management software for collecting and organizing research",
      "category": "Research Tool",
      "type": "Professional",
      "provider": "Corporation for Digital Scholarship",
      "accessType": "Free",
      "url": "https://zotero.org",
      "image": "https://picsum.photos/400/300?random=5&keyword=research",
      "subjects": ["Research Management", "Citations", "Bibliography"],
      "coverage": "All Disciplines",
      "lastUpdated": "2024-12-18",
      "popularity": 85,
      "isBookmarked": true,
      "accessCount": 987,
      "userRating": 4.5,
    },
    {
      "id": 6,
      "name": "Financial Times Archive",
      "description": "Complete digital archive of Financial Times newspaper",
      "category": "News",
      "type": "Professional",
      "provider": "Financial Times",
      "accessType": "Subscription",
      "url": "https://ft.com",
      "image": "https://picsum.photos/400/300?random=6&keyword=finance",
      "subjects": ["Business", "Finance", "Economics", "Politics"],
      "coverage": "1888-Present",
      "lastUpdated": "2024-12-21",
      "popularity": 71,
      "isBookmarked": false,
      "accessCount": 654,
      "userRating": 4.4,
    },
    {
      "id": 7,
      "name": "Springer Nature eBooks",
      "description": "Comprehensive collection of scientific and technical e-books",
      "category": "E-Book",
      "type": "Specialized",
      "provider": "Springer Nature",
      "accessType": "Subscription",
      "url": "https://link.springer.com",
      "image": "https://picsum.photos/400/300?random=7&keyword=scientific",
      "subjects": ["Medicine", "Technology", "Mathematics"],
      "coverage": "1996-Present",
      "lastUpdated": "2024-12-20",
      "popularity": 88,
      "isBookmarked": true,
      "accessCount": 2156,
      "userRating": 4.7,
    },
    {
      "id": 8,
      "name": "PubMed Central",
      "description": "Free digital archive of biomedical and life sciences journal literature",
      "category": "Database",
      "type": "Academic",
      "provider": "National Institutes of Health",
      "accessType": "Open Access",
      "url": "https://pmc.ncbi.nlm.nih.gov",
      "image": "https://picsum.photos/400/300?random=8&keyword=medical",
      "subjects": ["Medicine", "Biology", "Health Sciences"],
      "coverage": "1950-Present",
      "lastUpdated": "2024-12-21",
      "popularity": 94,
      "isBookmarked": false,
      "accessCount": 4567,
      "userRating": 4.9,
    },
  ];

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Database":
        return primaryColor;
      case "E-Journal":
        return successColor;
      case "E-Book":
        return warningColor;
      case "Research Tool":
        return infoColor;
      case "News":
        return secondaryColor;
      default:
        return disabledColor;
    }
  }

  Color _getAccessTypeColor(String accessType) {
    switch (accessType) {
      case "Open Access":
        return successColor;
      case "Free":
        return successColor;
      case "Subscription":
        return warningColor;
      default:
        return disabledColor;
    }
  }

  List<Map<String, dynamic>> get filteredResources {
    List<Map<String, dynamic>> filtered = digitalResources;

    if (selectedCategory != "All") {
      filtered = filtered.where((resource) => resource["category"] == selectedCategory).toList();
    }

    if (selectedType != "All") {
      filtered = filtered.where((resource) => resource["type"] == selectedType).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((resource) =>
          (resource["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (resource["description"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (resource["subjects"] as List).any((subject) => 
              (subject as String).toLowerCase().contains(searchQuery.toLowerCase()))).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Digital Resources"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Search Bar
            QTextField(
              label: "Search digital resources",
              value: searchQuery,
              hint: "Search by name, description, or subject",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Filters
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
                    label: "Type",
                    items: types,
                    value: selectedType,
                    onChanged: (value, label) {
                      selectedType = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Stats Dashboard
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${digitalResources.length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Resources",
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
                              "${digitalResources.where((r) => r["accessType"] == "Open Access" || r["accessType"] == "Free").length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Free Access",
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
                              "${digitalResources.where((r) => r["isBookmarked"] == true).length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Bookmarked",
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
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "My Bookmarks",
                      size: bs.sm,
                      icon: Icons.bookmark,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),

            // Popular Categories
            Text(
              "Browse by Category",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QHorizontalScroll(
              children: categories.skip(1).map((category) {
                final categoryName = category["value"] as String;
                final resourceCount = digitalResources.where((r) => r["category"] == categoryName).length;
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: _getCategoryColor(categoryName).withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(color: _getCategoryColor(categoryName)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getCategoryIcon(categoryName),
                        size: 32,
                        color: _getCategoryColor(categoryName),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        categoryName,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _getCategoryColor(categoryName),
                        ),
                      ),
                      Text(
                        "$resourceCount resources",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Results
            Text(
              "${filteredResources.length} Resources Found",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),

            // Resources List
            Column(
              spacing: spSm,
              children: filteredResources.map((resource) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Resource Image
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                        child: Stack(
                          children: [
                            Image.network(
                              "${resource["image"]}",
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getCategoryColor(resource["category"] as String),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${resource["category"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getAccessTypeColor(resource["accessType"] as String),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${resource["accessType"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            if (resource["isBookmarked"] == true)
                              Positioned(
                                bottom: spSm,
                                right: spSm,
                                child: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: warningColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    Icons.bookmark,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      // Resource Details
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${resource["name"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
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
                                      "${resource["userRating"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: warningColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            Text(
                              "${resource["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),

                            // Provider and Type
                            Row(
                              children: [
                                Icon(
                                  Icons.business,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${resource["provider"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${resource["type"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: infoColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Coverage and Updates
                            Row(
                              children: [
                                Icon(
                                  Icons.date_range,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Coverage: ${resource["coverage"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Icon(
                                  Icons.update,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Updated: ${DateTime.parse(resource["lastUpdated"] as String).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),

                            // Statistics
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "${resource["popularity"]}%",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "Popularity",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    width: 1,
                                    color: disabledColor,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "${((resource["accessCount"] as int) / 1000).toStringAsFixed(1)}K",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: successColor,
                                          ),
                                        ),
                                        Text(
                                          "Access Count",
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

                            // Subjects
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Subjects:",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Wrap(
                                  spacing: spXs,
                                  runSpacing: spXs,
                                  children: (resource["subjects"] as List).map((subject) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: secondaryColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                        border: Border.all(color: secondaryColor.withAlpha(50)),
                                      ),
                                      child: Text(
                                        "$subject",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: secondaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),

                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "Access Resource",
                                    size: bs.md,
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: resource["isBookmarked"] == true ? Icons.bookmark : Icons.bookmark_border,
                                  size: bs.md,
                                  onPressed: () {
                                    resource["isBookmarked"] = !(resource["isBookmarked"] as bool);
                                    setState(() {});
                                  },
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.share,
                                  size: bs.md,
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

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Database":
        return Icons.storage;
      case "E-Journal":
        return Icons.article;
      case "E-Book":
        return Icons.book;
      case "Research Tool":
        return Icons.search;
      case "News":
        return Icons.newspaper;
      default:
        return Icons.category;
    }
  }
}
