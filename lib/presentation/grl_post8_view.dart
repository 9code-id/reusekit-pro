import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPost8View extends StatefulWidget {
  @override
  State<GrlPost8View> createState() => _GrlPost8ViewState();
}

class _GrlPost8ViewState extends State<GrlPost8View> {
  int selectedTab = 0;

  List<Map<String, dynamic>> myPosts = [
    {
      "id": "1",
      "title": "Getting Started with Flutter Development",
      "excerpt": "A comprehensive guide for beginners entering the world of mobile app development",
      "category": "Technology",
      "status": "published",
      "publishedAt": "2024-03-10T14:30:00Z",
      "image": "https://picsum.photos/400/250?random=1&keyword=coding",
      "likes": 234,
      "comments": 45,
      "views": 1567,
      "readTime": "8 min read"
    },
    {
      "id": "2",
      "title": "The Future of Remote Work Culture",
      "excerpt": "Exploring how distributed teams are reshaping modern workplace dynamics",
      "category": "Business",
      "status": "draft",
      "lastModified": "2024-03-15T10:20:00Z",
      "image": "https://picsum.photos/400/250?random=2&keyword=office",
      "wordCount": 1234,
      "readTime": "6 min read"
    },
    {
      "id": "3",
      "title": "Sustainable Living in Urban Environments",
      "excerpt": "Practical tips for reducing your environmental footprint in city life",
      "category": "Lifestyle",
      "status": "published",
      "publishedAt": "2024-03-08T09:15:00Z",
      "image": "https://picsum.photos/400/250?random=3&keyword=nature",
      "likes": 456,
      "comments": 78,
      "views": 2345,
      "readTime": "10 min read"
    },
    {
      "id": "4",
      "title": "Machine Learning for Beginners",
      "excerpt": "Understanding the basics of AI and how to get started with your first project",
      "category": "Technology",
      "status": "scheduled",
      "scheduledFor": "2024-03-20T12:00:00Z",
      "image": "https://picsum.photos/400/250?random=4&keyword=ai",
      "wordCount": 2100,
      "readTime": "12 min read"
    },
  ];

  List<Map<String, dynamic>> analytics = [
    {
      "metric": "Total Views",
      "value": 12456,
      "change": "+12.5%",
      "isPositive": true,
      "icon": Icons.visibility
    },
    {
      "metric": "Total Likes", 
      "value": 1890,
      "change": "+8.2%",
      "isPositive": true,
      "icon": Icons.favorite
    },
    {
      "metric": "Comments",
      "value": 567,
      "change": "+15.3%",
      "isPositive": true,
      "icon": Icons.comment
    },
    {
      "metric": "Followers",
      "value": 2340,
      "change": "+6.7%",
      "isPositive": true,
      "icon": Icons.people
    },
  ];

  List<Map<String, dynamic>> recentActivity = [
    {
      "type": "like",
      "user": "Sarah Johnson",
      "avatar": "https://picsum.photos/40/40?random=10&keyword=portrait",
      "action": "liked your post",
      "post": "Getting Started with Flutter Development",
      "time": "2 hours ago"
    },
    {
      "type": "comment",
      "user": "Michael Chen",
      "avatar": "https://picsum.photos/40/40?random=11&keyword=portrait",
      "action": "commented on",
      "post": "Sustainable Living in Urban Environments",
      "time": "4 hours ago"
    },
    {
      "type": "follow",
      "user": "Emma Wilson",
      "avatar": "https://picsum.photos/40/40?random=12&keyword=portrait",
      "action": "started following you",
      "post": "",
      "time": "6 hours ago"
    },
    {
      "type": "like",
      "user": "David Park",
      "avatar": "https://picsum.photos/40/40?random=13&keyword=portrait",
      "action": "liked your post",
      "post": "The Future of Remote Work Culture",
      "time": "8 hours ago"
    },
  ];

  String _formatViews(int views) {
    if (views >= 1000) {
      return "${(views / 1000).toStringAsFixed(1)}k";
    }
    return views.toString();
  }

  String _getStatusColor(String status) {
    switch (status) {
      case "published":
        return "success";
      case "draft":
        return "warning";
      case "scheduled":
        return "info";
      default:
        return "disabled";
    }
  }

  Color _getStatusBadgeColor(String status) {
    switch (status) {
      case "published":
        return successColor;
      case "draft":
        return warningColor;
      case "scheduled":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return "${difference.inDays}d ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours}h ago";
    } else {
      return "${difference.inMinutes}m ago";
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "My Posts",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Posts", icon: Icon(Icons.article)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Activity", icon: Icon(Icons.notifications)),
      ],
      tabChildren: [
        _buildPostsTab(),
        _buildAnalyticsTab(),
        _buildActivityTab(),
      ],
    );
  }

  Widget _buildPostsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Create Button
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My Articles",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${myPosts.length} articles",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spLg),

          // Quick Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildQuickStat("Published", myPosts.where((post) => post["status"] == "published").length.toString(), successColor),
              _buildQuickStat("Drafts", myPosts.where((post) => post["status"] == "draft").length.toString(), warningColor),
              _buildQuickStat("Scheduled", myPosts.where((post) => post["status"] == "scheduled").length.toString(), infoColor),
            ],
          ),
          SizedBox(height: spLg),

          // Posts List
          ...myPosts.map((post) {
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  // Post Image
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(radiusMd),
                    ),
                    child: Image.network(
                      "${post["image"]}",
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Status Badge and Category
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: _getStatusBadgeColor(post["status"]).withAlpha(26),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${post["status"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: _getStatusBadgeColor(post["status"]),
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(26),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${post["category"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${post["readTime"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spMd),

                        // Title
                        Text(
                          "${post["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),

                        // Excerpt
                        Text(
                          "${post["excerpt"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: spMd),

                        // Post Stats
                        if (post["status"] == "published") ...[
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.visibility,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    _formatViews(post["views"] as int),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: spMd),
                              Row(
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${post["likes"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: spMd),
                              Row(
                                children: [
                                  Icon(
                                    Icons.comment,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${post["comments"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Text(
                                "Published ${_formatDate(post["publishedAt"])}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ] else if (post["status"] == "draft") ...[
                          Row(
                            children: [
                              Text(
                                "${post["wordCount"]} words",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "Modified ${_formatDate(post["lastModified"])}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ] else if (post["status"] == "scheduled") ...[
                          Row(
                            children: [
                              Text(
                                "${post["wordCount"]} words",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    size: 14,
                                    color: infoColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Mar 20, 12:00 PM",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: infoColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                        SizedBox(height: spMd),

                        // Action Buttons
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: post["status"] == "published" ? "View" : "Edit",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.more_vert,
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
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Performance Overview",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Track your content performance and engagement",
            style: TextStyle(
              fontSize: 16,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spLg),

          // Analytics Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 160,
            children: analytics.map((metric) {
              return Container(
                padding: EdgeInsets.all(spMd),
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
                        Icon(
                          metric["icon"],
                          color: primaryColor,
                          size: 24,
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${metric["change"]}",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "${metric["value"]}",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${metric["metric"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spLg),

          // Top Performing Posts
          Text(
            "Top Performing Posts",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          ...myPosts.where((post) => post["status"] == "published").map((post) {
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${post["image"]}",
                      width: 80,
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
                          "${post["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(
                              Icons.visibility,
                              size: 14,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              _formatViews(post["views"] as int),
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Icon(
                              Icons.favorite,
                              size: 14,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${post["likes"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
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
        ],
      ),
    );
  }

  Widget _buildActivityTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Activity",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "See what's happening with your content",
            style: TextStyle(
              fontSize: 16,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spLg),

          ...recentActivity.map((activity) {
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage("${activity["avatar"]}"),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                            children: [
                              TextSpan(
                                text: "${activity["user"]} ",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: "${activity["action"]}",
                              ),
                              if (activity["post"].isNotEmpty) ...[
                                TextSpan(text: " "),
                                TextSpan(
                                  text: "${activity["post"]}",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ],
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${activity["time"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _getActivityIcon(activity["type"]),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildQuickStat(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getActivityIcon(String type) {
    IconData icon;
    Color color;

    switch (type) {
      case "like":
        icon = Icons.favorite;
        color = dangerColor;
        break;
      case "comment":
        icon = Icons.comment;
        color = infoColor;
        break;
      case "follow":
        icon = Icons.person_add;
        color = successColor;
        break;
      default:
        icon = Icons.notifications;
        color = primaryColor;
    }

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(26),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Icon(
        icon,
        size: 20,
        color: color,
      ),
    );
  }
}
