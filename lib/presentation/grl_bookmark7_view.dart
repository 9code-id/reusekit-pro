import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBookmark7View extends StatefulWidget {
  @override
  State<GrlBookmark7View> createState() => _GrlBookmark7ViewState();
}

class _GrlBookmark7ViewState extends State<GrlBookmark7View> {
  int selectedTabIndex = 0;
  String searchQuery = "";
  
  List<Map<String, dynamic>> bookmarkStats = [
    {"label": "Total Bookmarks", "value": 248, "color": primaryColor, "icon": Icons.bookmark},
    {"label": "This Week", "value": 12, "color": successColor, "icon": Icons.trending_up},
    {"label": "Read This Month", "value": 45, "color": infoColor, "icon": Icons.visibility},
    {"label": "Favorites", "value": 32, "color": warningColor, "icon": Icons.favorite},
  ];
  
  List<Map<String, dynamic>> recentActivity = [
    {
      "type": "bookmark_added",
      "title": "Advanced Node.js Patterns",
      "description": "Added to Development folder",
      "time": "2 minutes ago",
      "icon": Icons.add_circle,
      "color": successColor
    },
    {
      "type": "bookmark_read",
      "title": "React Performance Optimization",
      "description": "Marked as read",
      "time": "1 hour ago",
      "icon": Icons.check_circle,
      "color": primaryColor
    },
    {
      "type": "bookmark_shared",
      "title": "Design System Guidelines",
      "description": "Shared with team",
      "time": "3 hours ago",
      "icon": Icons.share,
      "color": infoColor
    },
    {
      "type": "folder_created",
      "title": "Mobile Development",
      "description": "New folder created",
      "time": "1 day ago",
      "icon": Icons.folder_open,
      "color": warningColor
    },
  ];
  
  List<Map<String, dynamic>> topBookmarks = [
    {
      "id": 1,
      "title": "Flutter Widget of the Week",
      "url": "https://flutter.dev/widgets",
      "description": "Weekly showcase of Flutter widgets with examples",
      "image": "https://picsum.photos/200/120?random=81&keyword=flutter",
      "views": 156,
      "saves": 89,
      "category": "Development",
      "trending": true
    },
    {
      "id": 2,
      "title": "CSS Grid Complete Guide",
      "url": "https://css-tricks.com/grid",
      "description": "Everything you need to know about CSS Grid",
      "image": "https://picsum.photos/200/120?random=82&keyword=css",
      "views": 134,
      "saves": 76,
      "category": "Web Design",
      "trending": false
    },
    {
      "id": 3,
      "title": "JavaScript ES2024 Features",
      "url": "https://example.com/js2024",
      "description": "Latest JavaScript features and improvements",
      "image": "https://picsum.photos/200/120?random=83&keyword=javascript",
      "views": 128,
      "saves": 72,
      "category": "Programming",
      "trending": true
    },
    {
      "id": 4,
      "title": "UX Design Principles",
      "url": "https://uxdesign.cc/principles",
      "description": "Fundamental principles for great user experience",
      "image": "https://picsum.photos/200/120?random=84&keyword=ux",
      "views": 98,
      "saves": 58,
      "category": "Design",
      "trending": false
    },
  ];
  
  List<Map<String, dynamic>> trendingTags = [
    {"name": "flutter", "count": 45, "growth": "+12%"},
    {"name": "javascript", "count": 38, "growth": "+8%"},
    {"name": "design-system", "count": 24, "growth": "+15%"},
    {"name": "react", "count": 22, "growth": "+5%"},
    {"name": "typescript", "count": 18, "growth": "+20%"},
    {"name": "ui-ux", "count": 16, "growth": "+7%"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Bookmark Analytics",
      selectedIndex: selectedTabIndex,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Activity", icon: Icon(Icons.timeline)),
        Tab(text: "Trending", icon: Icon(Icons.trending_up)),
        Tab(text: "Tags", icon: Icon(Icons.tag)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildActivityTab(),
        _buildTrendingTab(),
        _buildTagsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Cards
          Text(
            "Statistics",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 200,
            children: bookmarkStats.map((stat) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (stat["color"] as Color).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            stat["icon"] as IconData,
                            color: stat["color"] as Color,
                            size: 24,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.trending_up, color: successColor, size: 16),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "${stat["value"]}",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${stat["label"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spLg),
          
          // Recent Activity Preview
          Row(
            children: [
              Text(
                "Recent Activity",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "View All",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: recentActivity.take(3).map((activity) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[100]!,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (activity["color"] as Color).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          activity["icon"] as IconData,
                          color: activity["color"] as Color,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${activity["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${activity["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${activity["time"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search activity...",
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
          
          // Activity List
          ...recentActivity.map((activity) {
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
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: (activity["color"] as Color).withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      activity["icon"] as IconData,
                      color: activity["color"] as Color,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${activity["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${activity["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${activity["time"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, color: disabledBoldColor, size: 16),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTrendingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Trending Bookmarks",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          ...topBookmarks.map((bookmark) {
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                        child: Image.network(
                          "${bookmark["image"]}",
                          width: double.infinity,
                          height: 160,
                          fit: BoxFit.cover,
                        ),
                      ),
                      if (bookmark["trending"] as bool)
                        Positioned(
                          top: spSm,
                          left: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: dangerColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.trending_up, color: Colors.white, size: 12),
                                SizedBox(width: spXs),
                                Text(
                                  "Trending",
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
                      Positioned(
                        top: spSm,
                        right: spSm,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(150),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${bookmark["category"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
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
                          "${bookmark["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${bookmark["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: spMd),
                        Row(
                          children: [
                            Icon(Icons.visibility, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${bookmark["views"]} views",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Icon(Icons.bookmark, size: 16, color: warningColor),
                            SizedBox(width: spXs),
                            Text(
                              "${bookmark["saves"]} saves",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            QButton(
                              label: "View",
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
          }),
        ],
      ),
    );
  }

  Widget _buildTagsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Trending Tags",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          ResponsiveGridView(
            minItemWidth: 200,
            children: trendingTags.map((tag) {
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
                            color: primaryColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(Icons.tag, color: primaryColor, size: 20),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${tag["growth"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "#${tag["name"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${tag["count"]} bookmarks",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Explore",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
