import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBlog9View extends StatefulWidget {
  const GrlBlog9View({super.key});

  @override
  State<GrlBlog9View> createState() => _GrlBlog9ViewState();
}

class _GrlBlog9ViewState extends State<GrlBlog9View> {
  int currentTab = 0;
  String searchQuery = "";

  final List<Map<String, dynamic>> featuredCategories = [
    {
      "name": "Technology",
      "icon": Icons.computer,
      "color": primaryColor,
      "posts": 1240,
      "description": "Latest tech trends and innovations",
      "image": "https://picsum.photos/300/200?random=1&keyword=technology",
    },
    {
      "name": "Business",
      "icon": Icons.business,
      "color": successColor,
      "posts": 890,
      "description": "Business strategies and insights",
      "image": "https://picsum.photos/300/200?random=2&keyword=business",
    },
    {
      "name": "Design",
      "icon": Icons.brush,
      "color": warningColor,
      "posts": 567,
      "description": "Creative design and UX trends",
      "image": "https://picsum.photos/300/200?random=3&keyword=design",
    },
    {
      "name": "Science",
      "icon": Icons.science,
      "color": infoColor,
      "posts": 423,
      "description": "Scientific discoveries and research",
      "image": "https://picsum.photos/300/200?random=4&keyword=science",
    },
  ];

  final List<Map<String, dynamic>> trendingPosts = [
    {
      "id": 1,
      "title": "Building the Next Generation of AI Applications",
      "excerpt": "A comprehensive guide to developing AI-powered applications that solve real-world problems.",
      "author": "Sarah Chen",
      "authorImage": "https://picsum.photos/40/40?random=1&keyword=woman",
      "category": "Technology",
      "readTime": 15,
      "image": "https://picsum.photos/600/300?random=1&keyword=ai",
      "views": 45600,
      "likes": 1890,
      "comments": 234,
      "publishedAt": "2024-01-22",
      "trending": true,
      "premium": false,
    },
    {
      "id": 2,
      "title": "The Psychology of User Experience Design",
      "excerpt": "Understanding how psychological principles can improve user interface design and engagement.",
      "author": "David Kim",
      "authorImage": "https://picsum.photos/40/40?random=2&keyword=man",
      "category": "Design",
      "readTime": 12,
      "image": "https://picsum.photos/600/300?random=2&keyword=psychology",
      "views": 28900,
      "likes": 1245,
      "comments": 167,
      "publishedAt": "2024-01-21",
      "trending": true,
      "premium": true,
    },
    {
      "id": 3,
      "title": "Sustainable Business Models for the Future",
      "excerpt": "How companies are adapting their business models to be more environmentally sustainable.",
      "author": "Maria Rodriguez",
      "authorImage": "https://picsum.photos/40/40?random=3&keyword=woman",
      "category": "Business",
      "readTime": 10,
      "image": "https://picsum.photos/600/300?random=3&keyword=sustainability",
      "views": 34200,
      "likes": 987,
      "comments": 89,
      "publishedAt": "2024-01-20",
      "trending": true,
      "premium": false,
    },
  ];

  final List<Map<String, dynamic>> editorsPicks = [
    {
      "title": "The Future of Remote Work",
      "author": "Jennifer Park",
      "image": "https://picsum.photos/200/120?random=5&keyword=remote",
      "readTime": 8,
      "category": "Business",
    },
    {
      "title": "Climate Tech Innovations",
      "author": "Dr. Michael Brown",
      "image": "https://picsum.photos/200/120?random=6&keyword=climate",
      "readTime": 6,
      "category": "Science",
    },
    {
      "title": "Design Systems at Scale",
      "author": "Alex Thompson",
      "image": "https://picsum.photos/200/120?random=7&keyword=system",
      "readTime": 9,
      "category": "Design",
    },
    {
      "title": "Blockchain Beyond Crypto",
      "author": "Lisa Wang",
      "image": "https://picsum.photos/200/120?random=8&keyword=blockchain",
      "readTime": 11,
      "category": "Technology",
    },
  ];

  final List<Map<String, dynamic>> topWriters = [
    {
      "name": "Dr. Sarah Chen",
      "image": "https://picsum.photos/60/60?random=1&keyword=woman",
      "expertise": "AI & Machine Learning",
      "followers": 45600,
      "articles": 127,
      "verified": true,
    },
    {
      "name": "David Kim",
      "image": "https://picsum.photos/60/60?random=2&keyword=man",
      "expertise": "UX Design",
      "followers": 32800,
      "articles": 89,
      "verified": true,
    },
    {
      "name": "Maria Rodriguez",
      "image": "https://picsum.photos/60/60?random=3&keyword=woman",
      "expertise": "Business Strategy",
      "followers": 28900,
      "articles": 156,
      "verified": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Blog Discovery",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Explore", icon: Icon(Icons.explore)),
        Tab(text: "Categories", icon: Icon(Icons.category)),
        Tab(text: "Writers", icon: Icon(Icons.people)),
        Tab(text: "Trending", icon: Icon(Icons.trending_up)),
      ],
      tabChildren: [
        _buildExploreTab(),
        _buildCategoriesTab(),
        _buildWritersTab(),
        _buildTrendingTab(),
      ],
    );
  }

  Widget _buildExploreTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Discover articles, topics, authors...",
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
                onPressed: () {},
              ),
            ],
          ),

          SizedBox(height: spMd),

          // Hero Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, secondaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Discover Amazing Stories",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Explore thousands of articles from expert writers across various topics",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "2.4K+",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Articles",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "450+",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Writers",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "15+",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Categories",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withAlpha(200),
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

          SizedBox(height: spMd),

          // Featured Categories
          Text(
            "Popular Categories",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),

          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: featuredCategories.map((category) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                      child: Image.network(
                        "${category["image"]}",
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                category["icon"] as IconData,
                                color: category["color"] as Color,
                                size: 20,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${category["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
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
                          Text(
                            "${category["posts"]} articles",
                            style: TextStyle(
                              fontSize: 11,
                              color: category["color"] as Color,
                              fontWeight: FontWeight.w600,
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

          SizedBox(height: spMd),

          // Editor's Picks
          Text(
            "Editor's Picks",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),

          QHorizontalScroll(
            children: editorsPicks.map((post) {
              return Container(
                width: 220,
                margin: EdgeInsets.only(right: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                          child: Image.network(
                            "${post["image"]}",
                            height: 120,
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
                              color: warningColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.star, size: 12, color: Colors.white),
                                SizedBox(width: spXs),
                                Text(
                                  "PICK",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${post["category"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${post["title"]}",
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
                            "${post["author"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${post["readTime"]} min read",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
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
    );
  }

  Widget _buildCategoriesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Browse by Category",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: featuredCategories.map((category) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  border: Border.all(color: (category["color"] as Color).withAlpha(30)),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: (category["color"] as Color).withAlpha(20),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        category["icon"] as IconData,
                        size: 32,
                        color: category["color"] as Color,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "${category["name"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${category["description"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: (category["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${category["posts"]} articles",
                        style: TextStyle(
                          fontSize: 12,
                          color: category["color"] as Color,
                          fontWeight: FontWeight.bold,
                        ),
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

  Widget _buildWritersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Top Writers",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: topWriters.map((writer) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage("${writer["image"]}"),
                        ),
                        if (writer["verified"] == true)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.verified,
                                size: 16,
                                color: infoColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${writer["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${writer["expertise"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "${((writer["followers"] as int) / 1000).toStringAsFixed(1)}K followers",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Text(
                                "${writer["articles"]} articles",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      label: "Follow",
                      size: bs.sm,
                      onPressed: () {},
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

  Widget _buildTrendingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.whatshot, color: dangerColor, size: 24),
              SizedBox(width: spXs),
              Text(
                "Trending Now",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Column(
            children: trendingPosts.map((post) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
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
                            "${post["image"]}",
                            height: 200,
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
                              color: dangerColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.whatshot, size: 12, color: Colors.white),
                                SizedBox(width: spXs),
                                Text(
                                  "TRENDING",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (post["premium"] == true)
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: warningColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(Icons.star, size: 12, color: Colors.white),
                            ),
                          ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${post["category"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${post["title"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${post["excerpt"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              height: 1.4,
                            ),
                          ),
                          SizedBox(height: spMd),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundImage: NetworkImage("${post["authorImage"]}"),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${post["author"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${post["publishedAt"]} • ${post["readTime"]} min read",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.visibility, size: 16, color: infoColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${((post["views"] as int) / 1000).toStringAsFixed(1)}K",
                                    style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                  ),
                                  SizedBox(width: spMd),
                                  Icon(Icons.favorite, size: 16, color: dangerColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${post["likes"]}",
                                    style: TextStyle(fontSize: 12, color: disabledBoldColor),
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
        ],
      ),
    );
  }
}
