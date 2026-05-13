import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlArticle7View extends StatefulWidget {
  @override
  State<GrlArticle7View> createState() => _GrlArticle7ViewState();
}

class _GrlArticle7ViewState extends State<GrlArticle7View> {
  List<Map<String, dynamic>> bookmarkedArticles = [
    {
      "id": 1,
      "title": "Advanced Machine Learning Techniques for Healthcare",
      "author": "Dr. Sarah Johnson",
      "category": "Technology",
      "readTime": "12 min read",
      "publishDate": "2024-12-10",
      "image": "https://picsum.photos/400/250?random=1&keyword=ml-healthcare",
      "summary": "Exploring cutting-edge ML applications in medical diagnosis and treatment optimization.",
      "bookmarkedAt": "2024-12-15",
      "progress": 65,
      "tags": ["AI", "Healthcare", "Machine Learning"],
      "readStatus": "in_progress"
    },
    {
      "id": 2,
      "title": "Climate Change Solutions for Urban Cities",
      "author": "Prof. Michael Chen",
      "category": "Environment",
      "readTime": "8 min read",
      "publishDate": "2024-12-08",
      "image": "https://picsum.photos/400/250?random=2&keyword=urban-climate",
      "summary": "Innovative approaches to reducing carbon footprint in metropolitan areas.",
      "bookmarkedAt": "2024-12-14",
      "progress": 100,
      "tags": ["Climate", "Urban Planning", "Sustainability"],
      "readStatus": "completed"
    },
    {
      "id": 3,
      "title": "The Future of Remote Work Culture",
      "author": "Lisa Rodriguez",
      "category": "Business",
      "readTime": "15 min read",
      "publishDate": "2024-12-05",
      "image": "https://picsum.photos/400/250?random=3&keyword=remote-work",
      "summary": "How companies are adapting to permanent remote and hybrid work models.",
      "bookmarkedAt": "2024-12-13",
      "progress": 0,
      "tags": ["Remote Work", "Business Culture", "Technology"],
      "readStatus": "unread"
    },
    {
      "id": 4,
      "title": "Mental Health in Digital Age",
      "author": "Dr. Amanda Kim",
      "category": "Health",
      "readTime": "10 min read",
      "publishDate": "2024-12-03",
      "image": "https://picsum.photos/400/250?random=4&keyword=mental-health",
      "summary": "Understanding the psychological impact of constant digital connectivity.",
      "bookmarkedAt": "2024-12-12",
      "progress": 30,
      "tags": ["Mental Health", "Digital Wellness", "Psychology"],
      "readStatus": "in_progress"
    },
    {
      "id": 5,
      "title": "Blockchain Revolution in Finance",
      "author": "James Wilson",
      "category": "Finance",
      "readTime": "18 min read",
      "publishDate": "2024-12-01",
      "image": "https://picsum.photos/400/250?random=5&keyword=blockchain",
      "summary": "How blockchain technology is transforming traditional banking systems.",
      "bookmarkedAt": "2024-12-11",
      "progress": 85,
      "tags": ["Blockchain", "Finance", "Cryptocurrency"],
      "readStatus": "in_progress"
    },
  ];

  List<String> categories = ["All", "Technology", "Environment", "Business", "Health", "Finance"];
  List<String> readStatuses = ["All", "Unread", "In Progress", "Completed"];
  
  String selectedCategory = "All";
  String selectedReadStatus = "All";
  String sortBy = "Recent"; // Recent, Oldest, Title
  
  List<Map<String, dynamic>> get filteredArticles {
    List<Map<String, dynamic>> filtered = bookmarkedArticles.where((article) {
      bool categoryMatch = selectedCategory == "All" || article["category"] == selectedCategory;
      bool statusMatch = selectedReadStatus == "All" || 
        (selectedReadStatus == "Unread" && article["readStatus"] == "unread") ||
        (selectedReadStatus == "In Progress" && article["readStatus"] == "in_progress") ||
        (selectedReadStatus == "Completed" && article["readStatus"] == "completed");
      return categoryMatch && statusMatch;
    }).toList();

    // Sort articles
    if (sortBy == "Recent") {
      filtered.sort((a, b) => b["bookmarkedAt"].compareTo(a["bookmarkedAt"]));
    } else if (sortBy == "Oldest") {
      filtered.sort((a, b) => a["bookmarkedAt"].compareTo(b["bookmarkedAt"]));
    } else if (sortBy == "Title") {
      filtered.sort((a, b) => a["title"].compareTo(b["title"]));
    }

    return filtered;
  }

  Map<String, int> get readingStats {
    int unread = bookmarkedArticles.where((a) => a["readStatus"] == "unread").length;
    int inProgress = bookmarkedArticles.where((a) => a["readStatus"] == "in_progress").length;
    int completed = bookmarkedArticles.where((a) => a["readStatus"] == "completed").length;
    return {
      "total": bookmarkedArticles.length,
      "unread": unread,
      "inProgress": inProgress,
      "completed": completed,
    };
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> stats = readingStats;
    
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "My Reading List",
                              style: TextStyle(
                                fontSize: fsH2,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Your bookmarked articles and reading progress",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(60),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(Icons.bookmarks, color: Colors.white, size: 28),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Reading Statistics
            ResponsiveGridView(
              minItemWidth: 200,
              children: [
                _buildStatCard("Total Saved", "${stats["total"]}", Icons.bookmark, primaryColor),
                _buildStatCard("Unread", "${stats["unread"]}", Icons.visibility_off, warningColor),
                _buildStatCard("Reading", "${stats["inProgress"]}", Icons.hourglass_bottom, infoColor),
                _buildStatCard("Completed", "${stats["completed"]}", Icons.check_circle, successColor),
              ],
            ),

            SizedBox(height: spXl),

            // Filters Section
            Row(
              children: [
                Text(
                  "Filters",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    _showSortOptions();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.sort, color: primaryColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Sort: $sortBy",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Category Filter
            QHorizontalScroll(
              children: categories.map((category) {
                bool isSelected = selectedCategory == category;
                return GestureDetector(
                  onTap: () {
                    selectedCategory = category;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? Colors.white : disabledBoldColor,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spMd),

            // Read Status Filter
            QHorizontalScroll(
              children: readStatuses.map((status) {
                bool isSelected = selectedReadStatus == status;
                return GestureDetector(
                  onTap: () {
                    selectedReadStatus = status;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? infoColor : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        color: isSelected ? Colors.white : disabledBoldColor,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spXl),

            // Articles List
            Row(
              children: [
                Text(
                  "Saved Articles",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredArticles.length} articles",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            if (filteredArticles.isEmpty) ...[
              Container(
                padding: EdgeInsets.all(spXl),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  children: [
                    Icon(Icons.bookmark_border, color: disabledColor, size: 64),
                    SizedBox(height: spMd),
                    Text(
                      "No articles found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters or bookmark some articles",
                      style: TextStyle(
                        color: disabledColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ] else ...[
              Column(
                children: filteredArticles.map((article) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                              child: Image.network(
                                "${article["image"]}",
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${article["category"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(article["readStatus"]).withAlpha(200),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  _getStatusIcon(article["readStatus"]),
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(spMd),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${article["title"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${article["summary"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                  height: 1.4,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: spSm),
                              Row(
                                children: [
                                  Icon(Icons.person, color: disabledColor, size: 16),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${article["author"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(width: spMd),
                                  Icon(Icons.access_time, color: disabledColor, size: 16),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${article["readTime"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              
                              if (article["progress"] > 0) ...[
                                SizedBox(height: spSm),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Reading Progress",
                                          style: TextStyle(
                                            color: disabledBoldColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          "${article["progress"]}%",
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spXs),
                                    LinearProgressIndicator(
                                      value: (article["progress"] as int) / 100,
                                      backgroundColor: disabledOutlineBorderColor,
                                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                                    ),
                                  ],
                                ),
                              ],

                              SizedBox(height: spSm),
                              
                              // Tags
                              Wrap(
                                spacing: spXs,
                                children: (article["tags"] as List).take(3).map<Widget>((tag) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "#$tag",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),

                              SizedBox(height: spMd),
                              
                              Row(
                                children: [
                                  Text(
                                    "Saved on ${article["bookmarkedAt"]}",
                                    style: TextStyle(
                                      color: disabledColor,
                                      fontSize: 11,
                                    ),
                                  ),
                                  Spacer(),
                                  QButton(
                                    label: article["readStatus"] == "completed" ? "Read Again" : "Continue Reading",
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
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(40),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "unread":
        return warningColor;
      case "in_progress":
        return infoColor;
      case "completed":
        return successColor;
      default:
        return disabledColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "unread":
        return Icons.visibility_off;
      case "in_progress":
        return Icons.hourglass_bottom;
      case "completed":
        return Icons.check_circle;
      default:
        return Icons.bookmark;
    }
  }

  void _showSortOptions() {
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
                "Sort Articles",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              ...["Recent", "Oldest", "Title"].map((option) {
                return GestureDetector(
                  onTap: () {
                    sortBy = option;
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: spMd),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
                    ),
                    child: Row(
                      children: [
                        Text(
                          option,
                          style: TextStyle(
                            color: sortBy == option ? primaryColor : primaryColor,
                            fontWeight: sortBy == option ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                        Spacer(),
                        if (sortBy == option)
                          Icon(Icons.check, color: primaryColor, size: 20),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}
