import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBookmark10View extends StatefulWidget {
  @override
  State<GrlBookmark10View> createState() => _GrlBookmark10ViewState();
}

class _GrlBookmark10ViewState extends State<GrlBookmark10View> {
  String searchQuery = "";
  String selectedFilter = "All";
  String sortBy = "Recent";
  bool showCompactView = false;
  
  List<String> filterOptions = ["All", "Unread", "Starred", "Archived"];
  List<String> sortOptions = ["Recent", "Alphabetical", "Most Accessed"];
  
  List<Map<String, dynamic>> bookmarks = [
    {
      "id": 1,
      "title": "Modern Web Development Stack 2024",
      "url": "https://webdev-2024.com",
      "description": "Complete guide to the latest web development technologies, frameworks, and best practices for 2024",
      "thumbnail": "https://picsum.photos/400/300?random=151&keyword=webdev",
      "domain": "webdev-2024.com",
      "author": "Tech Insights",
      "dateAdded": "2024-01-20T14:30:00",
      "dateRead": null,
      "readingTime": "18 min",
      "accessCount": 5,
      "isStarred": true,
      "isRead": false,
      "isArchived": false,
      "category": "Technology",
      "tags": ["web-development", "javascript", "react", "2024"],
      "notes": "Important for team training session",
      "rating": 5,
      "shareCount": 12,
      "highlights": [],
      "readingProgress": 0
    },
    {
      "id": 2,
      "title": "Sustainable Living Guide",
      "url": "https://sustainable-life.org",
      "description": "Practical tips and strategies for adopting a more sustainable lifestyle in everyday life",
      "thumbnail": "https://picsum.photos/400/300?random=152&keyword=sustainability",
      "domain": "sustainable-life.org",
      "author": "Green Living",
      "dateAdded": "2024-01-19T09:45:00",
      "dateRead": "2024-01-19T15:30:00",
      "readingTime": "12 min",
      "accessCount": 3,
      "isStarred": false,
      "isRead": true,
      "isArchived": false,
      "category": "Lifestyle",
      "tags": ["sustainability", "environment", "lifestyle"],
      "notes": "Share with environmental group",
      "rating": 4,
      "shareCount": 8,
      "highlights": ["Reduce plastic usage", "Energy conservation tips"],
      "readingProgress": 100
    },
    {
      "id": 3,
      "title": "Investment Strategies for Beginners",
      "url": "https://invest-smart.com",
      "description": "Comprehensive introduction to investment strategies suitable for beginner investors",
      "thumbnail": "https://picsum.photos/400/300?random=153&keyword=investment",
      "domain": "invest-smart.com",
      "author": "Financial Advisor",
      "dateAdded": "2024-01-18T11:20:00",
      "dateRead": null,
      "readingTime": "25 min",
      "accessCount": 8,
      "isStarred": true,
      "isRead": false,
      "isArchived": false,
      "category": "Finance",
      "tags": ["investment", "finance", "beginner", "money"],
      "notes": "Review before financial planning meeting",
      "rating": 5,
      "shareCount": 15,
      "highlights": [],
      "readingProgress": 35
    },
    {
      "id": 4,
      "title": "Minimalist Home Design Ideas",
      "url": "https://minimal-design.studio",
      "description": "Beautiful minimalist home design ideas and inspiration for creating clean, functional spaces",
      "thumbnail": "https://picsum.photos/400/300?random=154&keyword=minimalist",
      "domain": "minimal-design.studio",
      "author": "Design Studio",
      "dateAdded": "2024-01-17T16:15:00",
      "dateRead": "2024-01-18T10:00:00",
      "readingTime": "8 min",
      "accessCount": 2,
      "isStarred": false,
      "isRead": true,
      "isArchived": true,
      "category": "Design",
      "tags": ["minimalism", "design", "home", "interior"],
      "notes": "Ideas for bedroom renovation",
      "rating": 3,
      "shareCount": 5,
      "highlights": ["Color palette suggestions", "Storage solutions"],
      "readingProgress": 100
    },
    {
      "id": 5,
      "title": "Machine Learning Fundamentals",
      "url": "https://ml-fundamentals.edu",
      "description": "Introduction to machine learning concepts, algorithms, and practical applications",
      "thumbnail": "https://picsum.photos/400/300?random=155&keyword=machine-learning",
      "domain": "ml-fundamentals.edu",
      "author": "University Research",
      "dateAdded": "2024-01-16T13:45:00",
      "dateRead": null,
      "readingTime": "35 min",
      "accessCount": 12,
      "isStarred": true,
      "isRead": false,
      "isArchived": false,
      "category": "Education",
      "tags": ["machine-learning", "ai", "education", "algorithms"],
      "notes": "Preparation for ML course",
      "rating": 5,
      "shareCount": 20,
      "highlights": [],
      "readingProgress": 60
    },
    {
      "id": 6,
      "title": "Travel Photography Tips",
      "url": "https://travel-photo.guide",
      "description": "Professional tips and techniques for capturing stunning travel photographs",
      "thumbnail": "https://picsum.photos/400/300?random=156&keyword=photography",
      "domain": "travel-photo.guide",
      "author": "Photo Pro",
      "dateAdded": "2024-01-15T08:30:00",
      "dateRead": "2024-01-16T14:20:00",
      "readingTime": "15 min",
      "accessCount": 4,
      "isStarred": false,
      "isRead": true,
      "isArchived": false,
      "category": "Photography",
      "tags": ["photography", "travel", "tips", "technique"],
      "notes": "Practice techniques on next trip",
      "rating": 4,
      "shareCount": 9,
      "highlights": ["Golden hour shooting", "Composition rules"],
      "readingProgress": 100
    },
  ];

  List<Map<String, dynamic>> get filteredBookmarks {
    List<Map<String, dynamic>> filtered = bookmarks;
    
    // Apply filters
    switch (selectedFilter) {
      case "Unread":
        filtered = filtered.where((b) => !(b["isRead"] as bool)).toList();
        break;
      case "Starred":
        filtered = filtered.where((b) => b["isStarred"] as bool).toList();
        break;
      case "Archived":
        filtered = filtered.where((b) => b["isArchived"] as bool).toList();
        break;
    }
    
    // Apply search
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((bookmark) {
        return "${bookmark["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
               "${bookmark["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
               "${bookmark["author"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
               (bookmark["tags"] as List).any((tag) => "$tag".toLowerCase().contains(searchQuery.toLowerCase()));
      }).toList();
    }
    
    // Apply sorting
    switch (sortBy) {
      case "Alphabetical":
        filtered.sort((a, b) => "${a["title"]}".compareTo("${b["title"]}"));
        break;
      case "Most Accessed":
        filtered.sort((a, b) => (b["accessCount"] as int).compareTo(a["accessCount"] as int));
        break;
      case "Recent":
      default:
        filtered.sort((a, b) => DateTime.parse("${b["dateAdded"]}").compareTo(DateTime.parse("${a["dateAdded"]}")));
        break;
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reading List"),
        actions: [
          IconButton(
            icon: Icon(showCompactView ? Icons.view_list : Icons.view_comfortable),
            onPressed: () {
              showCompactView = !showCompactView;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Advanced Filter Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Search Bar
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search articles, authors, or tags...",
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: disabledBoldColor, size: 20),
                      contentPadding: EdgeInsets.symmetric(vertical: spMd),
                    ),
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(height: spMd),
                
                // Filter and Sort Row
                Row(
                  children: [
                    // Filter Dropdown
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spSm),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.filter_list, color: disabledBoldColor, size: 16),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                selectedFilter,
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Icon(Icons.arrow_drop_down, color: disabledBoldColor, size: 16),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spMd),
                    
                    // Sort Dropdown
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spSm),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.sort, color: disabledBoldColor, size: 16),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                sortBy,
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Icon(Icons.arrow_drop_down, color: disabledBoldColor, size: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Results Summary
          if (filteredBookmarks.isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              child: Text(
                "${filteredBookmarks.length} article${filteredBookmarks.length == 1 ? '' : 's'} • ${filteredBookmarks.where((b) => !(b["isRead"] as bool)).length} unread",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ),
          
          // Bookmark List
          Expanded(
            child: filteredBookmarks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.library_books, size: 64, color: disabledColor),
                        SizedBox(height: spMd),
                        Text(
                          "No articles found",
                          style: TextStyle(
                            fontSize: 16,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Try adjusting your filters or search terms",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(spMd),
                    itemCount: filteredBookmarks.length,
                    itemBuilder: (context, index) {
                      final bookmark = filteredBookmarks[index];
                      return showCompactView 
                          ? _buildCompactBookmarkItem(bookmark)
                          : _buildDetailedBookmarkItem(bookmark);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryColor,
        icon: Icon(Icons.add_link, color: Colors.white),
        label: Text("Add Article", style: TextStyle(color: Colors.white)),
        onPressed: () {},
      ),
    );
  }

  Widget _buildDetailedBookmarkItem(Map<String, dynamic> bookmark) {
    double progressValue = (bookmark["readingProgress"] as int) / 100;
    
    return Container(
      margin: EdgeInsets.only(bottom: spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
        border: Border.all(
          color: (bookmark["isRead"] as bool) ? Colors.grey[100]! : primaryColor.withAlpha(60),
          width: (bookmark["isRead"] as bool) ? 1 : 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with thumbnail
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                child: Image.network(
                  "${bookmark["thumbnail"]}",
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spMd,
                right: spMd,
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          bookmark["isStarred"] = !(bookmark["isStarred"] as bool);
                          setState(() {});
                        },
                        child: Icon(
                          (bookmark["isStarred"] as bool) ? Icons.star : Icons.star_border,
                          color: (bookmark["isStarred"] as bool) ? warningColor : Colors.white,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(Icons.share, color: Colors.white, size: 20),
                      SizedBox(width: spSm),
                      Icon(Icons.more_vert, color: Colors.white, size: 20),
                    ],
                  ),
                ),
              ),
              if ((bookmark["readingProgress"] as int) > 0)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 6,
                    child: LinearProgressIndicator(
                      value: progressValue,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                  ),
                ),
            ],
          ),
          
          // Content
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category and status
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${bookmark["category"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    if (bookmark["isRead"] as bool)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Read",
                          style: TextStyle(
                            fontSize: 11,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    if (bookmark["isArchived"] as bool)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Archived",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    Spacer(),
                    // Rating stars
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(5, (starIndex) {
                        return Icon(
                          starIndex < (bookmark["rating"] as int) ? Icons.star : Icons.star_border,
                          color: warningColor,
                          size: 14,
                        );
                      }),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                
                // Title
                Text(
                  "${bookmark["title"]}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spSm),
                
                // Description
                Text(
                  "${bookmark["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spMd),
                
                // Author and metadata
                Row(
                  children: [
                    Text(
                      "by ${bookmark["author"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Icon(Icons.access_time, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${bookmark["readingTime"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Icon(Icons.visibility, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${bookmark["accessCount"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                // Highlights
                if ((bookmark["highlights"] as List).isNotEmpty) ...[
                  SizedBox(height: spMd),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.highlight, color: warningColor, size: 14),
                            SizedBox(width: spXs),
                            Text(
                              "Highlights",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        ...(bookmark["highlights"] as List).map((highlight) {
                          return Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Text(
                              "• $highlight",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
                
                // Notes
                if (bookmark["notes"] != null && "${bookmark["notes"]}".isNotEmpty) ...[
                  SizedBox(height: spMd),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.note, color: disabledBoldColor, size: 14),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${bookmark["notes"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                SizedBox(height: spMd),
                
                // Tags
                Wrap(
                  spacing: spXs,
                  children: (bookmark["tags"] as List).map((tag) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "#$tag",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: spMd),
                
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: (bookmark["isRead"] as bool) 
                            ? "Read Again" 
                            : ((bookmark["readingProgress"] as int) > 0 ? "Continue" : "Read"),
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(Icons.bookmark_border, color: disabledBoldColor, size: 18),
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

  Widget _buildCompactBookmarkItem(Map<String, dynamic> bookmark) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${bookmark["thumbnail"]}",
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${bookmark["title"]}",
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
                  "by ${bookmark["author"]} • ${bookmark["readingTime"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    if (bookmark["isRead"] as bool)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Read",
                          style: TextStyle(
                            fontSize: 9,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    if ((bookmark["readingProgress"] as int) > 0 && !(bookmark["isRead"] as bool)) ...[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${bookmark["readingProgress"]}%",
                          style: TextStyle(
                            fontSize: 9,
                            color: infoColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  bookmark["isStarred"] = !(bookmark["isStarred"] as bool);
                  setState(() {});
                },
                child: Icon(
                  (bookmark["isStarred"] as bool) ? Icons.star : Icons.star_border,
                  color: (bookmark["isStarred"] as bool) ? warningColor : disabledBoldColor,
                  size: 18,
                ),
              ),
              SizedBox(height: spSm),
              Icon(Icons.more_vert, color: disabledBoldColor, size: 16),
            ],
          ),
        ],
      ),
    );
  }
}
