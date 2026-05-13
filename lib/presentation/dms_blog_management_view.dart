import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsBlogManagementView extends StatefulWidget {
  const DmsBlogManagementView({super.key});

  @override
  State<DmsBlogManagementView> createState() => _DmsBlogManagementViewState();
}

class _DmsBlogManagementViewState extends State<DmsBlogManagementView> {
  int currentTab = 0;
  String searchQuery = "";
  String statusFilter = "all";
  String categoryFilter = "all";
  String authorFilter = "all";
  String sortBy = "date_desc";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Published", "value": "published"},
    {"label": "Draft", "value": "draft"},
    {"label": "Scheduled", "value": "scheduled"},
    {"label": "Archived", "value": "archived"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Technology", "value": "technology"},
    {"label": "Business", "value": "business"},
    {"label": "Finance", "value": "finance"},
    {"label": "Healthcare", "value": "healthcare"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Newest First", "value": "date_desc"},
    {"label": "Oldest First", "value": "date_asc"},
    {"label": "Most Views", "value": "views_desc"},
    {"label": "Most Liked", "value": "likes_desc"},
    {"label": "Alphabetical", "value": "title_asc"},
  ];

  List<Map<String, dynamic>> blogPosts = [
    {
      "id": 1,
      "title": "10 Digital Marketing Trends for 2024",
      "slug": "digital-marketing-trends-2024",
      "category": "Marketing",
      "author": "Sarah Johnson",
      "status": "published",
      "publishDate": "2024-01-15",
      "lastModified": "2024-01-15 09:30",
      "views": 12847,
      "likes": 234,
      "comments": 89,
      "featured": true,
      "excerpt": "Discover the latest trends shaping the digital marketing landscape in 2024...",
      "wordCount": 2450,
      "readTime": "12 min",
      "seoScore": 95,
      "tags": ["marketing", "trends", "2024", "digital"],
    },
    {
      "id": 2,
      "title": "Complete Guide to Social Media Analytics",
      "slug": "social-media-analytics-guide",
      "category": "Technology",
      "author": "Mike Chen",
      "status": "draft",
      "publishDate": null,
      "lastModified": "2024-01-14 16:45",
      "views": 0,
      "likes": 0,
      "comments": 0,
      "featured": false,
      "excerpt": "Learn how to measure and analyze your social media performance effectively...",
      "wordCount": 1890,
      "readTime": "9 min",
      "seoScore": 78,
      "tags": ["social media", "analytics", "metrics"],
    },
    {
      "id": 3,
      "title": "Customer Success Case Study - TechCorp",
      "slug": "techcorp-case-study",
      "category": "Business",
      "author": "Emma Davis",
      "status": "published",
      "publishDate": "2024-01-13",
      "lastModified": "2024-01-13 11:20",
      "views": 5672,
      "likes": 98,
      "comments": 23,
      "featured": false,
      "excerpt": "How TechCorp increased their customer retention by 45% using our platform...",
      "wordCount": 3200,
      "readTime": "15 min",
      "seoScore": 88,
      "tags": ["case study", "success", "customer retention"],
    },
    {
      "id": 4,
      "title": "Email Marketing Best Practices 2024",
      "slug": "email-marketing-best-practices",
      "category": "Marketing",
      "author": "David Wilson",
      "status": "scheduled",
      "publishDate": "2024-01-20",
      "lastModified": "2024-01-12 14:30",
      "views": 0,
      "likes": 0,
      "comments": 0,
      "featured": true,
      "excerpt": "Master email marketing with these proven strategies and techniques...",
      "wordCount": 2100,
      "readTime": "10 min",
      "seoScore": 92,
      "tags": ["email", "marketing", "best practices"],
    },
  ];

  List<Map<String, dynamic>> recentActivity = [
    {
      "action": "published",
      "title": "10 Digital Marketing Trends for 2024",
      "author": "Sarah Johnson",
      "timestamp": "2 hours ago",
      "icon": Icons.publish,
      "color": successColor,
    },
    {
      "action": "updated",
      "title": "Complete Guide to Social Media Analytics",
      "author": "Mike Chen",
      "timestamp": "4 hours ago",
      "icon": Icons.edit,
      "color": infoColor,
    },
    {
      "action": "scheduled",
      "title": "Email Marketing Best Practices 2024",
      "author": "David Wilson",
      "timestamp": "6 hours ago",
      "icon": Icons.schedule,
      "color": warningColor,
    },
    {
      "action": "commented",
      "title": "Customer Success Case Study - TechCorp",
      "author": "Guest User",
      "timestamp": "8 hours ago",
      "icon": Icons.comment,
      "color": primaryColor,
    },
  ];

  List<Map<String, dynamic>> blogStats = [
    {
      "label": "Total Posts",
      "value": "247",
      "change": "+12",
      "icon": Icons.article,
      "color": primaryColor,
    },
    {
      "label": "Published",
      "value": "189",
      "change": "+8",
      "icon": Icons.publish,
      "color": successColor,
    },
    {
      "label": "Drafts",
      "value": "34",
      "change": "+3",
      "icon": Icons.edit,
      "color": warningColor,
    },
    {
      "label": "Total Views",
      "value": "847K",
      "change": "+23%",
      "icon": Icons.visibility,
      "color": infoColor,
    },
  ];

  void _deleteBlogPost(int id) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this blog post?");
    if (isConfirmed) {
      blogPosts.removeWhere((post) => post["id"] == id);
      setState(() {});
      ss("Blog post deleted successfully");
    }
  }

  void _toggleFeatured(int id) {
    int index = blogPosts.indexWhere((post) => post["id"] == id);
    if (index != -1) {
      blogPosts[index]["featured"] = !(blogPosts[index]["featured"] as bool);
      setState(() {});
      String status = blogPosts[index]["featured"] ? "featured" : "unfeatured";
      ss("Blog post $status successfully");
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Blog Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Posts", icon: Icon(Icons.article)),
        Tab(text: "Categories", icon: Icon(Icons.category)),
        Tab(text: "Activity", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildPostsTab(),
        _buildCategoriesTab(),
        _buildActivityTab(),
      ],
    );
  }

  Widget _buildPostsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Blog Statistics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: blogStats.map((stat) => _buildStatCard(stat)).toList(),
          ),

          // Search and Filters
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search Posts",
                        value: searchQuery,
                        hint: "Search by title, content, or author...",
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.add,
                      label: "New Post",
                      size: bs.md,
                      onPressed: () {},
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Status",
                        items: statusOptions,
                        value: statusFilter,
                        onChanged: (value, label) {
                          statusFilter = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categoryOptions,
                        value: categoryFilter,
                        onChanged: (value, label) {
                          categoryFilter = value;
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

          // Blog Posts List
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.article, color: primaryColor),
                    SizedBox(width: spSm),
                    Text(
                      "Blog Posts (${blogPosts.length})",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ...blogPosts.map((post) => _buildBlogPostItem(post)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab() {
    List<Map<String, dynamic>> categories = [
      {
        "name": "Marketing",
        "slug": "marketing",
        "postCount": 45,
        "description": "Digital marketing strategies and trends",
        "color": primaryColor,
      },
      {
        "name": "Technology",
        "slug": "technology",
        "postCount": 32,
        "description": "Latest tech insights and innovations",
        "color": infoColor,
      },
      {
        "name": "Business",
        "slug": "business",
        "postCount": 28,
        "description": "Business growth and strategy guides",
        "color": successColor,
      },
      {
        "name": "Finance",
        "slug": "finance",
        "postCount": 19,
        "description": "Financial planning and investment tips",
        "color": warningColor,
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Category Management Header
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: successColor.withAlpha(30)),
            ),
            child: Row(
              children: [
                Icon(Icons.category, color: successColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Category Management",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Organize your blog content with categories",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "Add Category",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Categories Grid
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: categories.map((category) => _buildCategoryCard(category)).toList(),
          ),

          // Category Settings
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Category Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Show post count in navigation",
                      "value": true,
                      "checked": true,
                    }
                  ],
                  value: [
                    {
                      "label": "Show post count in navigation",
                      "value": true,
                      "checked": true
                    }
                  ],
                  onChanged: (values, ids) {},
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Enable category descriptions",
                      "value": true,
                      "checked": true,
                    }
                  ],
                  value: [
                    {
                      "label": "Enable category descriptions",
                      "value": true,
                      "checked": true
                    }
                  ],
                  onChanged: (values, ids) {},
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Allow empty categories",
                      "value": false,
                      "checked": false,
                    }
                  ],
                  value: [],
                  onChanged: (values, ids) {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Activity Overview
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(30)),
            ),
            child: Row(
              children: [
                Icon(Icons.history, color: infoColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Recent Activity",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Track all blog-related activities and changes",
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

          // Activity Timeline
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Activity Timeline",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...recentActivity.map((activity) => _buildActivityItem(activity)),
              ],
            ),
          ),

          // Activity Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildActivityStat("Today's Posts", "5", Icons.today, primaryColor),
              _buildActivityStat("This Week", "23", Icons.date_range, successColor),
              _buildActivityStat("Comments", "45", Icons.comment, infoColor),
              _buildActivityStat("Shares", "128", Icons.share, warningColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (stat["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  stat["icon"] as IconData,
                  color: stat["color"] as Color,
                  size: 20,
                ),
              ),
              Spacer(),
              Text(
                "${stat["change"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${stat["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: stat["color"] as Color,
            ),
          ),
          Text(
            "${stat["label"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlogPostItem(Map<String, dynamic> post) {
    Color statusColor = _getStatusColor(post["status"] as String);

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${post["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (post["featured"] == true) ...[
                Icon(Icons.star, color: warningColor, size: 16),
                SizedBox(width: spXs),
              ],
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${post["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "${post["excerpt"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            maxLines: 2,
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Text(
                "${post["category"]} • ${post["author"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              if (post["publishDate"] != null) ...[
                Text(
                  " • ${post["publishDate"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
              Spacer(),
              Text(
                "${post["wordCount"]} words • ${post["readTime"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (post["status"] == "published") ...[
            SizedBox(height: spSm),
            Row(
              children: [
                _buildMetricChip(Icons.visibility, "${(post["views"] as int).toString()}"),
                SizedBox(width: spXs),
                _buildMetricChip(Icons.favorite, "${(post["likes"] as int).toString()}"),
                SizedBox(width: spXs),
                _buildMetricChip(Icons.comment, "${(post["comments"] as int).toString()}"),
                Spacer(),
                Row(
                  children: [
                    QButton(
                      icon: Icons.edit,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: post["featured"] == true ? Icons.star : Icons.star_border,
                      size: bs.sm,
                      onPressed: () => _toggleFeatured(post["id"] as int),
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.delete,
                      size: bs.sm,
                      onPressed: () => _deleteBlogPost(post["id"] as int),
                    ),
                  ],
                ),
              ],
            ),
          ] else ...[
            SizedBox(height: spSm),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "SEO Score: ${post["seoScore"]}%",
                    style: TextStyle(
                      fontSize: 10,
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    QButton(
                      icon: Icons.edit,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.delete,
                      size: bs.sm,
                      onPressed: () => _deleteBlogPost(post["id"] as int),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (category["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.category,
                  color: category["color"] as Color,
                  size: 20,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${category["name"]}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: category["color"] as Color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${category["description"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Text(
                "${category["postCount"]} posts",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: category["color"] as Color,
                ),
              ),
              Spacer(),
              Text(
                "/${category["slug"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                  fontFamily: "monospace",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: (activity["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              activity["icon"] as IconData,
              color: activity["color"] as Color,
              size: 16,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${activity["author"]} ${activity["action"]} \"${activity["title"]}\"",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "${activity["timestamp"]}",
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
    );
  }

  Widget _buildActivityStat(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
              Icon(Icons.trending_up, color: successColor, size: 16),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricChip(IconData icon, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: primaryColor),
          SizedBox(width: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 11,
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "published":
        return successColor;
      case "draft":
        return warningColor;
      case "scheduled":
        return infoColor;
      case "archived":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }
}
