import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHome5View extends StatefulWidget {
  @override
  State<GrlHome5View> createState() => _GrlHome5ViewState();
}

class _GrlHome5ViewState extends State<GrlHome5View> {
  int currentBottomIndex = 0;
  String searchQuery = "";
  
  final List<Map<String, dynamic>> featuredContent = [
    {
      "id": 1,
      "title": "Smart Home Automation",
      "subtitle": "Control your home from anywhere",
      "image": "https://picsum.photos/300/180?random=1&keyword=smart-home",
      "category": "Technology",
      "readTime": "5 min read",
      "likes": 245,
      "isBookmarked": false,
    },
    {
      "id": 2,
      "title": "Sustainable Living Tips",
      "subtitle": "Eco-friendly lifestyle changes",
      "image": "https://picsum.photos/300/180?random=2&keyword=sustainable",
      "category": "Lifestyle",
      "readTime": "8 min read",
      "likes": 189,
      "isBookmarked": true,
    },
    {
      "id": 3,
      "title": "Financial Planning Guide",
      "subtitle": "Build your wealth step by step",
      "image": "https://picsum.photos/300/180?random=3&keyword=finance",
      "category": "Finance",
      "readTime": "12 min read",
      "likes": 356,
      "isBookmarked": false,
    },
  ];

  final List<Map<String, dynamic>> categories = [
    {
      "name": "Technology",
      "icon": Icons.computer,
      "color": infoColor,
      "articleCount": 124,
    },
    {
      "name": "Business",
      "icon": Icons.business_center,
      "color": primaryColor,
      "articleCount": 89,
    },
    {
      "name": "Lifestyle",
      "icon": Icons.favorite,
      "color": dangerColor,
      "articleCount": 67,
    },
    {
      "name": "Health",
      "icon": Icons.health_and_safety,
      "color": successColor,
      "articleCount": 156,
    },
    {
      "name": "Travel",
      "icon": Icons.flight,
      "color": warningColor,
      "articleCount": 98,
    },
    {
      "name": "Food",
      "icon": Icons.restaurant,
      "color": infoColor,
      "articleCount": 203,
    },
  ];

  final List<Map<String, dynamic>> trendingTopics = [
    {
      "title": "AI Revolution",
      "posts": 1245,
      "trend": "+25%",
      "trendUp": true,
    },
    {
      "title": "Remote Work",
      "posts": 987,
      "trend": "+18%",
      "trendUp": true,
    },
    {
      "title": "Cryptocurrency",
      "posts": 756,
      "trend": "-8%",
      "trendUp": false,
    },
    {
      "title": "Climate Change",
      "posts": 645,
      "trend": "+12%",
      "trendUp": true,
    },
  ];

  final List<Map<String, dynamic>> recentActivity = [
    {
      "user": "Sarah Johnson",
      "action": "liked your article",
      "title": "Introduction to Machine Learning",
      "time": "2 hours ago",
      "avatar": "https://picsum.photos/40/40?random=1&keyword=person",
    },
    {
      "user": "Mike Chen",
      "action": "commented on",
      "title": "Future of Web Development",
      "time": "4 hours ago",
      "avatar": "https://picsum.photos/40/40?random=2&keyword=person",
    },
    {
      "user": "Emma Wilson",
      "action": "shared your post",
      "title": "Sustainable Design Principles",
      "time": "6 hours ago",
      "avatar": "https://picsum.photos/40/40?random=3&keyword=person",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QBottomBar(
      title: "Content Hub",
      selectedIndex: currentBottomIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: "Explore",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: "Saved",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
      children: [
        // Home Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withAlpha(180)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Discover Amazing Content",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Stay updated with the latest trends and insights",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(220),
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        QButton(
                          label: "Explore Now",
                          color: Colors.white,
                          size: bs.sm,
                          onPressed: () {
                            currentBottomIndex = 1;
                            setState(() {});
                          },
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "My Library",
                          color: Colors.white.withAlpha(100),
                          size: bs.sm,
                          onPressed: () {
                            currentBottomIndex = 2;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Search Bar
              QTextField(
                label: "Search articles, topics...",
                value: searchQuery,
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),

              // Featured Content
              Row(
                children: [
                  Text(
                    "Featured Content",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "See All",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              QHorizontalScroll(
                children: featuredContent.map((content) {
                  return Container(
                    width: 280,
                    margin: EdgeInsets.only(right: spSm),
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
                                "${content["image"]}",
                                width: double.infinity,
                                height: 140,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${content["category"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(230),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Icon(
                                  (content["isBookmarked"] as bool) ? Icons.bookmark : Icons.bookmark_border,
                                  size: 18,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            spacing: spXs,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${content["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${content["subtitle"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: [
                                  Row(
                                    spacing: 4,
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        size: 12,
                                        color: disabledColor,
                                      ),
                                      Text(
                                        "${content["readTime"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Row(
                                    spacing: 4,
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                        size: 12,
                                        color: dangerColor,
                                      ),
                                      Text(
                                        "${content["likes"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledColor,
                                        ),
                                      ),
                                    ],
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

              // Categories
              Text(
                "Browse Categories",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 110,
                children: categories.map((category) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: (category["color"] as Color).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            category["icon"] as IconData,
                            size: 24,
                            color: category["color"] as Color,
                          ),
                        ),
                        Text(
                          "${category["name"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${category["articleCount"]} articles",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
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

        // Explore Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Trending Topics",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Column(
                spacing: spSm,
                children: trendingTopics.map((topic) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            spacing: spXs,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${topic["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${topic["posts"]} posts",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: (topic["trendUp"] as bool) ? successColor.withAlpha(30) : dangerColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            spacing: 2,
                            children: [
                              Icon(
                                (topic["trendUp"] as bool) ? Icons.trending_up : Icons.trending_down,
                                size: 14,
                                color: (topic["trendUp"] as bool) ? successColor : dangerColor,
                              ),
                              Text(
                                "${topic["trend"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: (topic["trendUp"] as bool) ? successColor : dangerColor,
                                ),
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

        // Saved Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Saved Articles",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: infoColor.withAlpha(100)),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Icon(
                      Icons.bookmark_border,
                      size: 48,
                      color: infoColor,
                    ),
                    Text(
                      "No Saved Articles Yet",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Start bookmarking articles you want to read later",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QButton(
                      label: "Explore Articles",
                      size: bs.sm,
                      onPressed: () {
                        currentBottomIndex = 1;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Profile Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [primaryColor, primaryColor.withAlpha(180)],
                        ),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Alex Johnson",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Content Creator & Tech Enthusiast",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            spacing: spXs,
                            children: [
                              Text(
                                "156",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Articles",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            spacing: spXs,
                            children: [
                              Text(
                                "2.4K",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Followers",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            spacing: spXs,
                            children: [
                              Text(
                                "589",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Following",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Recent Activity
              Text(
                "Recent Activity",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Column(
                spacing: spSm,
                children: recentActivity.map((activity) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: Image.network(
                            "${activity["avatar"]}",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            spacing: spXs,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontFamily: 'Inter',
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "${activity["user"]} ",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(text: "${activity["action"]} "),
                                    TextSpan(
                                      text: "${activity["title"]}",
                                      style: TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "${activity["time"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Edit Profile",
                      size: bs.md,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Settings",
                      color: infoColor,
                      size: bs.md,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
      onTap: (index) {
        currentBottomIndex = index;
        setState(() {});
      },
    );
  }
}
