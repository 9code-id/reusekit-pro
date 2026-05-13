import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDiscover9View extends StatefulWidget {
  @override
  State<GrlDiscover9View> createState() => _GrlDiscover9ViewState();
}

class _GrlDiscover9ViewState extends State<GrlDiscover9View> {
  String searchQuery = "";
  String selectedTimeframe = "Today";
  bool showBookmarked = false;
  
  List<Map<String, dynamic>> discoverFeeds = [
    {
      "id": 1,
      "type": "Article",
      "title": "The Rise of Sustainable Technology",
      "summary": "How green technology is reshaping our future and creating new opportunities for innovation",
      "author": "Dr. Emily Chen",
      "authorAvatar": "EC",
      "publishTime": "2 hours ago",
      "readTime": "5 min read",
      "image": "https://picsum.photos/400/250?random=1&keyword=technology",
      "category": "Technology",
      "likes": 245,
      "comments": 32,
      "shares": 18,
      "isBookmarked": false,
      "tags": ["Sustainability", "Innovation", "Future Tech"],
      "trending": true
    },
    {
      "id": 2,
      "type": "Video",
      "title": "Mastering Remote Work Productivity",
      "summary": "Expert tips and strategies for maintaining peak performance while working from home",
      "author": "Mark Rodriguez",
      "authorAvatar": "MR",
      "publishTime": "4 hours ago",
      "duration": "12:30",
      "image": "https://picsum.photos/400/250?random=2&keyword=workspace",
      "category": "Business",
      "likes": 189,
      "comments": 56,
      "shares": 23,
      "isBookmarked": true,
      "tags": ["Remote Work", "Productivity", "Business"],
      "trending": false
    },
    {
      "id": 3,
      "type": "Podcast",
      "title": "The Future of Space Exploration",
      "summary": "A deep dive into upcoming space missions and the role of private companies in space exploration",
      "author": "Space Talk Podcast",
      "authorAvatar": "ST",
      "publishTime": "6 hours ago",
      "duration": "45:20",
      "image": "https://picsum.photos/400/250?random=3&keyword=space",
      "category": "Science",
      "likes": 167,
      "comments": 28,
      "shares": 15,
      "isBookmarked": false,
      "tags": ["Space", "Science", "Innovation"],
      "trending": true
    },
    {
      "id": 4,
      "type": "Article",
      "title": "Mindful Living in the Digital Age",
      "summary": "Practical strategies for maintaining mental wellness while staying connected in our digital world",
      "author": "Dr. Sarah Williams",
      "authorAvatar": "SW",
      "publishTime": "8 hours ago",
      "readTime": "7 min read",
      "image": "https://picsum.photos/400/250?random=4&keyword=meditation",
      "category": "Wellness",
      "likes": 298,
      "comments": 45,
      "shares": 34,
      "isBookmarked": true,
      "tags": ["Mindfulness", "Wellness", "Digital Health"],
      "trending": false
    },
    {
      "id": 5,
      "type": "Course",
      "title": "Advanced Photography Techniques",
      "summary": "Learn professional photography skills from award-winning photographers in this comprehensive course",
      "author": "Photo Academy",
      "authorAvatar": "PA",
      "publishTime": "12 hours ago",
      "duration": "6 weeks",
      "image": "https://picsum.photos/400/250?random=5&keyword=photography",
      "category": "Education",
      "likes": 134,
      "comments": 21,
      "shares": 12,
      "isBookmarked": false,
      "tags": ["Photography", "Education", "Skills"],
      "trending": false
    },
    {
      "id": 6,
      "type": "Event",
      "title": "Global Climate Summit 2024",
      "summary": "Join world leaders and experts discussing climate action and sustainable solutions for our planet",
      "author": "Climate Action Network",
      "authorAvatar": "CN",
      "publishTime": "1 day ago",
      "duration": "3 days",
      "image": "https://picsum.photos/400/250?random=6&keyword=environment",
      "category": "Environment",
      "likes": 456,
      "comments": 78,
      "shares": 89,
      "isBookmarked": true,
      "tags": ["Climate", "Environment", "Summit"],
      "trending": true
    }
  ];

  List<String> timeframes = ["Today", "This Week", "This Month", "All Time"];

  List<Map<String, dynamic>> get filteredFeeds {
    return discoverFeeds.where((feed) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${feed["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${feed["summary"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${feed["author"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          (feed["tags"] as List).any((tag) => 
            "$tag".toLowerCase().contains(searchQuery.toLowerCase()));

      bool matchesBookmark = !showBookmarked || feed["isBookmarked"];

      return matchesSearch && matchesBookmark;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discover Feed"),
        actions: [
          IconButton(
            icon: Icon(showBookmarked ? Icons.bookmark : Icons.bookmark_border),
            onPressed: () {
              showBookmarked = !showBookmarked;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () => _showFilterOptions(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              margin: EdgeInsets.all(spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor.withAlpha(10), secondaryColor.withAlpha(10)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.explore,
                        color: primaryColor,
                        size: 32,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Discover Content",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Curated content from trusted sources",
                              style: TextStyle(
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  // Quick Stats
                  Row(
                    children: [
                      _buildQuickStat("${discoverFeeds.length}", "Items", primaryColor),
                      SizedBox(width: spMd),
                      _buildQuickStat("${discoverFeeds.where((f) => f["trending"]).length}", "Trending", warningColor),
                      SizedBox(width: spMd),
                      _buildQuickStat("${discoverFeeds.where((f) => f["isBookmarked"]).length}", "Saved", successColor),
                    ],
                  ),
                ],
              ),
            ),

            // Search and Filters
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search content...",
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
                          // Perform search
                        },
                      ),
                    ],
                  ),

                  // Timeframe Filter
                  QHorizontalScroll(
                    children: timeframes.map((timeframe) {
                      bool isSelected = selectedTimeframe == timeframe;
                      return GestureDetector(
                        onTap: () {
                          selectedTimeframe = timeframe;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                            ),
                          ),
                          child: Text(
                            timeframe,
                            style: TextStyle(
                              color: isSelected ? Colors.white : disabledBoldColor,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Active Filters
            if (showBookmarked || searchQuery.isNotEmpty)
              Container(
                margin: EdgeInsets.all(spMd),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: infoColor.withAlpha(30)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.filter_list,
                      size: 16,
                      color: infoColor,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "Active filters: ${_getActiveFilters()}",
                        style: TextStyle(
                          color: infoColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showBookmarked = false;
                        searchQuery = "";
                        setState(() {});
                      },
                      child: Icon(
                        Icons.clear,
                        size: 16,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ),

            // Results Count
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Text(
                "${filteredFeeds.length} items found",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),

            SizedBox(height: spMd),

            // Content Feed
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredFeeds.length,
              itemBuilder: (context, index) {
                final feed = filteredFeeds[index];
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
                      // Header with Author Info
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: primaryColor.withAlpha(20),
                              child: Text(
                                "${feed["authorAvatar"]}",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${feed["author"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      if (feed["trending"]) ...[
                                        SizedBox(width: spXs),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                                          decoration: BoxDecoration(
                                            color: warningColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "TRENDING",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 8,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  Text(
                                    "${feed["publishTime"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: _getTypeColor("${feed["type"]}").withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${feed["type"]}",
                                style: TextStyle(
                                  color: _getTypeColor("${feed["type"]}"),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Content Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: spMd),
                          child: Stack(
                            children: [
                              Image.network(
                                "${feed["image"]}",
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                bottom: spSm,
                                left: spSm,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(150),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        _getTypeIcon("${feed["type"]}"),
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        feed["type"] == "Article" 
                                          ? "${feed["readTime"]}"
                                          : "${feed["duration"]}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Content Details
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Text(
                              "${feed["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            
                            Text(
                              "${feed["summary"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                            // Tags
                            QHorizontalScroll(
                              children: (feed["tags"] as List).map((tag) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "#$tag",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),

                            // Engagement Stats
                            Row(
                              children: [
                                _buildEngagementButton(
                                  Icons.favorite_border,
                                  "${feed["likes"]}",
                                  dangerColor,
                                  () => _handleLike(feed["id"]),
                                ),
                                SizedBox(width: spMd),
                                _buildEngagementButton(
                                  Icons.comment_outlined,
                                  "${feed["comments"]}",
                                  primaryColor,
                                  () => _showComments(feed),
                                ),
                                SizedBox(width: spMd),
                                _buildEngagementButton(
                                  Icons.share_outlined,
                                  "${feed["shares"]}",
                                  secondaryColor,
                                  () => _shareContent(feed),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () => _toggleBookmark(feed["id"]),
                                  child: Icon(
                                    feed["isBookmarked"] ? Icons.bookmark : Icons.bookmark_border,
                                    color: feed["isBookmarked"] ? primaryColor : disabledBoldColor,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),

                            // Action Button
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: _getActionLabel("${feed["type"]}"),
                                onPressed: () {
                                  _openContent(feed);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Load More Button
            if (filteredFeeds.isNotEmpty)
              Container(
                margin: EdgeInsets.all(spMd),
                width: double.infinity,
                child: QButton(
                  label: "Load More Content",
                  color: secondaryColor,
                  onPressed: () {
                    si("Loading more content...");
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStat(String value, String label, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEngagementButton(IconData icon, String count, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: color,
          ),
          SizedBox(width: spXs),
          Text(
            count,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Article":
        return primaryColor;
      case "Video":
        return dangerColor;
      case "Podcast":
        return successColor;
      case "Course":
        return warningColor;
      case "Event":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "Article":
        return Icons.article;
      case "Video":
        return Icons.play_circle;
      case "Podcast":
        return Icons.mic;
      case "Course":
        return Icons.school;
      case "Event":
        return Icons.event;
      default:
        return Icons.content_copy;
    }
  }

  String _getActionLabel(String type) {
    switch (type) {
      case "Article":
        return "Read Article";
      case "Video":
        return "Watch Video";
      case "Podcast":
        return "Listen Now";
      case "Course":
        return "Enroll Course";
      case "Event":
        return "Join Event";
      default:
        return "View Content";
    }
  }

  String _getActiveFilters() {
    List<String> filters = [];
    if (showBookmarked) filters.add("Bookmarked");
    if (searchQuery.isNotEmpty) filters.add("Search");
    return filters.join(", ");
  }

  void _toggleBookmark(int feedId) {
    final feedIndex = discoverFeeds.indexWhere((feed) => feed["id"] == feedId);
    if (feedIndex != -1) {
      discoverFeeds[feedIndex]["isBookmarked"] = !discoverFeeds[feedIndex]["isBookmarked"];
      setState(() {});
      
      if (discoverFeeds[feedIndex]["isBookmarked"]) {
        ss("Content bookmarked!");
      } else {
        si("Bookmark removed");
      }
    }
  }

  void _handleLike(int feedId) {
    final feedIndex = discoverFeeds.indexWhere((feed) => feed["id"] == feedId);
    if (feedIndex != -1) {
      discoverFeeds[feedIndex]["likes"] = (discoverFeeds[feedIndex]["likes"] as int) + 1;
      setState(() {});
      ss("Liked!");
    }
  }

  void _openContent(Map<String, dynamic> feed) {
    si("Opening ${feed["title"]}");
  }

  void _shareContent(Map<String, dynamic> feed) {
    si("Sharing: ${feed["title"]}");
  }

  void _showComments(Map<String, dynamic> feed) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "${feed["comments"]} Comments",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.comment,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Comments Section",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Comment system would be implemented here",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Text(
              "Filter Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            QSwitch(
              items: [
                {
                  "label": "Show only bookmarked content",
                  "value": "bookmarked",
                  "checked": showBookmarked,
                }
              ],
              value: showBookmarked 
                ? [{"label": "Show only bookmarked content", "value": "bookmarked", "checked": true}]
                : [],
              onChanged: (values, ids) {
                showBookmarked = values.isNotEmpty;
                setState(() {});
                Navigator.pop(context);
              },
            ),
            
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.tune,
                    color: disabledBoldColor,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "More filter options available in advanced settings",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
