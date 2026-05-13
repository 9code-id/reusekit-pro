import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBlog6View extends StatefulWidget {
  const GrlBlog6View({super.key});

  @override
  State<GrlBlog6View> createState() => _GrlBlog6ViewState();
}

class _GrlBlog6ViewState extends State<GrlBlog6View> {
  int currentTab = 0;
  String searchQuery = "";

  final List<Map<String, dynamic>> categories = [
    {
      "name": "Latest",
      "icon": Icons.schedule,
      "count": 24,
      "color": primaryColor,
    },
    {
      "name": "Popular",
      "icon": Icons.trending_up,
      "count": 18,
      "color": successColor,
    },
    {
      "name": "Saved",
      "icon": Icons.bookmark,
      "count": 12,
      "color": warningColor,
    },
    {
      "name": "Following",
      "icon": Icons.people,
      "count": 31,
      "color": infoColor,
    },
  ];

  final List<Map<String, dynamic>> writers = [
    {
      "id": 1,
      "name": "Sarah Chen",
      "title": "Tech Journalist",
      "image": "https://picsum.photos/60/60?random=1&keyword=woman",
      "followers": 15200,
      "articles": 89,
      "isFollowing": true,
      "verified": true,
      "expertise": ["AI", "Machine Learning", "Tech Trends"],
    },
    {
      "id": 2,
      "name": "David Kim",
      "title": "Business Strategist",
      "image": "https://picsum.photos/60/60?random=2&keyword=man",
      "followers": 22800,
      "articles": 156,
      "isFollowing": false,
      "verified": true,
      "expertise": ["Strategy", "Leadership", "Startups"],
    },
    {
      "id": 3,
      "name": "Maria Garcia",
      "title": "UX Designer",
      "image": "https://picsum.photos/60/60?random=3&keyword=woman",
      "followers": 9600,
      "articles": 67,
      "isFollowing": true,
      "verified": false,
      "expertise": ["Design", "User Experience", "Product"],
    },
  ];

  final List<Map<String, dynamic>> blogPosts = [
    {
      "id": 1,
      "title": "The Rise of Generative AI in Creative Industries",
      "excerpt": "How artificial intelligence is transforming creative workflows and opening new possibilities for artists and designers worldwide.",
      "content": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      "author": "Sarah Chen",
      "authorImage": "https://picsum.photos/40/40?random=1&keyword=woman",
      "category": "Technology",
      "readTime": 8,
      "publishedAt": "2024-01-20T10:30:00Z",
      "image": "https://picsum.photos/400/220?random=1&keyword=ai",
      "views": 12400,
      "likes": 890,
      "comments": 156,
      "bookmarks": 234,
      "shares": 89,
      "tags": ["AI", "Creative", "Technology"],
      "premium": false,
      "trending": true,
    },
    {
      "id": 2,
      "title": "Building Sustainable Tech Companies",
      "excerpt": "A comprehensive guide to creating environmentally responsible technology businesses that prioritize both profit and planet.",
      "content": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      "author": "David Kim",
      "authorImage": "https://picsum.photos/40/40?random=2&keyword=man",
      "category": "Business",
      "readTime": 12,
      "publishedAt": "2024-01-18T14:15:00Z",
      "image": "https://picsum.photos/400/220?random=2&keyword=sustainability",
      "views": 8900,
      "likes": 567,
      "comments": 89,
      "bookmarks": 178,
      "shares": 45,
      "tags": ["Sustainability", "Business", "Environment"],
      "premium": true,
      "trending": false,
    },
    {
      "id": 3,
      "title": "User-Centered Design in the Age of AI",
      "excerpt": "Exploring how human-centered design principles remain crucial as we integrate artificial intelligence into everyday products.",
      "content": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      "author": "Maria Garcia",
      "authorImage": "https://picsum.photos/40/40?random=3&keyword=woman",
      "category": "Design",
      "readTime": 6,
      "publishedAt": "2024-01-16T09:45:00Z",
      "image": "https://picsum.photos/400/220?random=3&keyword=design",
      "views": 15600,
      "likes": 1203,
      "comments": 245,
      "bookmarks": 456,
      "shares": 123,
      "tags": ["Design", "UX", "AI"],
      "premium": false,
      "trending": true,
    },
    {
      "id": 4,
      "title": "The Future of Remote Work Culture",
      "excerpt": "Analyzing the long-term impacts of distributed teams on company culture, productivity, and employee satisfaction.",
      "content": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      "author": "Sarah Chen",
      "authorImage": "https://picsum.photos/40/40?random=1&keyword=woman",
      "category": "Business",
      "readTime": 10,
      "publishedAt": "2024-01-14T16:20:00Z",
      "image": "https://picsum.photos/400/220?random=4&keyword=remote",
      "views": 9800,
      "likes": 678,
      "comments": 134,
      "bookmarks": 289,
      "shares": 67,
      "tags": ["Remote Work", "Culture", "Future"],
      "premium": true,
      "trending": false,
    },
  ];

  List<Map<String, dynamic>> get filteredPosts {
    if (searchQuery.isEmpty) return blogPosts;
    return blogPosts.where((post) {
      return "${post["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${post["excerpt"]}".toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Blog Hub",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Discover", icon: Icon(Icons.explore)),
        Tab(text: "Following", icon: Icon(Icons.people)),
        Tab(text: "Bookmarks", icon: Icon(Icons.bookmark)),
        Tab(text: "Writers", icon: Icon(Icons.edit)),
      ],
      tabChildren: [
        _buildDiscoverTab(),
        _buildFollowingTab(),
        _buildBookmarksTab(),
        _buildWritersTab(),
      ],
    );
  }

  Widget _buildDiscoverTab() {
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
                  label: "Search articles, topics, authors...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.tune,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),

          SizedBox(height: spMd),

          // Quick Categories
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
            children: categories.map((category) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  border: Border.all(color: (category["color"] as Color).withAlpha(30)),
                ),
                child: Column(
                  children: [
                    Icon(
                      category["icon"] as IconData,
                      size: 32,
                      color: category["color"] as Color,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${category["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${category["count"]} articles",
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

          SizedBox(height: spMd),

          // Trending Posts
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Trending Now",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.whatshot, size: 12, color: dangerColor),
                    SizedBox(width: spXs),
                    Text(
                      "HOT",
                      style: TextStyle(
                        fontSize: 10,
                        color: dangerColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),

          QHorizontalScroll(
            children: filteredPosts.where((post) => post["trending"] == true).map((post) {
              return Container(
                width: 300,
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
                            "${post["image"]}",
                            height: 160,
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
                          Text(
                            "${post["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${post["excerpt"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              height: 1.4,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundImage: NetworkImage("${post["authorImage"]}"),
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${post["author"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${post["readTime"]} min",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.favorite, size: 14, color: dangerColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${post["likes"]}",
                                    style: TextStyle(fontSize: 11, color: disabledBoldColor),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(Icons.comment, size: 14, color: infoColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${post["comments"]}",
                                    style: TextStyle(fontSize: 11, color: disabledBoldColor),
                                  ),
                                ],
                              ),
                              Icon(Icons.bookmark_border, size: 16, color: disabledBoldColor),
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

          SizedBox(height: spMd),

          // All Posts
          Text(
            "Recent Articles",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),

          Column(
            children: filteredPosts.map((post) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${post["image"]}",
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (post["premium"] == true) ...[
                                Icon(Icons.star, size: 12, color: warningColor),
                                SizedBox(width: spXs),
                              ],
                              if (post["trending"] == true) ...[
                                Icon(Icons.whatshot, size: 12, color: dangerColor),
                                SizedBox(width: spXs),
                              ],
                              Text(
                                "${post["category"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
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
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 8,
                                backgroundImage: NetworkImage("${post["authorImage"]}"),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${post["author"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${post["readTime"]} min",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(Icons.favorite, size: 12, color: dangerColor),
                              SizedBox(width: spXs),
                              Text(
                                "${post["likes"]}",
                                style: TextStyle(fontSize: 10, color: disabledBoldColor),
                              ),
                              SizedBox(width: spSm),
                              Icon(Icons.visibility, size: 12, color: infoColor),
                              SizedBox(width: spXs),
                              Text(
                                "${((post["views"] as int) / 1000).toStringAsFixed(1)}K",
                                style: TextStyle(fontSize: 10, color: disabledBoldColor),
                              ),
                              Spacer(),
                              Icon(Icons.bookmark_border, size: 14, color: disabledBoldColor),
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

  Widget _buildFollowingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Latest from People You Follow",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: blogPosts.take(3).map((post) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
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
                                "Published 2 hours ago",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.more_vert, color: disabledBoldColor),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${post["title"]}",
                      style: TextStyle(
                        fontSize: 16,
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
                    SizedBox(height: spSm),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${post["image"]}",
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(Icons.favorite_border, size: 20, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text("${post["likes"]}", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                        SizedBox(width: spMd),
                        Icon(Icons.comment_outlined, size: 20, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text("${post["comments"]}", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                        Spacer(),
                        Icon(Icons.bookmark_border, size: 20, color: disabledBoldColor),
                        SizedBox(width: spSm),
                        Icon(Icons.share, size: 20, color: disabledBoldColor),
                      ],
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

  Widget _buildBookmarksTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Saved Articles",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "12 saved",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Column(
            children: blogPosts.map((post) {
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${post["image"]}",
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                            "${post["author"]} • ${post["readTime"]} min read",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Saved 3 days ago",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.bookmark, size: 20, color: warningColor),
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
            "Featured Writers",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: writers.map((writer) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Row(
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
                        SizedBox(width: spSm),
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
                                "${writer["title"]}",
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
                                  SizedBox(width: spSm),
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
                          label: writer["isFollowing"] == true ? "Following" : "Follow",
                          size: bs.sm,
                          onPressed: () {
                            writer["isFollowing"] = !(writer["isFollowing"] as bool);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: (writer["expertise"] as List).map<Widget>((skill) {
                        return Container(
                          margin: EdgeInsets.only(right: spXs),
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "$skill",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
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
