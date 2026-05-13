import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBookmark8View extends StatefulWidget {
  @override
  State<GrlBookmark8View> createState() => _GrlBookmark8ViewState();
}

class _GrlBookmark8ViewState extends State<GrlBookmark8View> {
  int selectedIndex = 0;
  String searchQuery = "";
  String sortBy = "Date Added";
  
  List<Map<String, dynamic>> socialBookmarks = [
    {
      "id": 1,
      "title": "The Future of AI in Design",
      "url": "https://designfuture.ai",
      "description": "Exploring how artificial intelligence is transforming the design industry",
      "image": "https://picsum.photos/400/250?random=91&keyword=ai",
      "author": {
        "name": "Sarah Johnson",
        "avatar": "https://picsum.photos/50/50?random=101&keyword=person",
        "verified": true,
        "following": false
      },
      "stats": {
        "likes": 324,
        "shares": 89,
        "comments": 45,
        "saves": 156
      },
      "tags": ["ai", "design", "future", "technology"],
      "dateShared": "2024-01-20T14:30:00",
      "isLiked": false,
      "isSaved": true,
      "category": "Design",
      "readingTime": "8 min"
    },
    {
      "id": 2,
      "title": "Advanced React Hooks Patterns",
      "url": "https://react-patterns.dev",
      "description": "Deep dive into advanced React hooks patterns for better state management",
      "image": "https://picsum.photos/400/250?random=92&keyword=react",
      "author": {
        "name": "Mike Chen",
        "avatar": "https://picsum.photos/50/50?random=102&keyword=developer",
        "verified": false,
        "following": true
      },
      "stats": {
        "likes": 198,
        "shares": 67,
        "comments": 23,
        "saves": 142
      },
      "tags": ["react", "hooks", "javascript", "frontend"],
      "dateShared": "2024-01-19T09:15:00",
      "isLiked": true,
      "isSaved": false,
      "category": "Development",
      "readingTime": "12 min"
    },
    {
      "id": 3,
      "title": "Sustainable Architecture Trends",
      "url": "https://sustainablearch.com",
      "description": "Latest trends in sustainable architecture and green building practices",
      "image": "https://picsum.photos/400/250?random=93&keyword=architecture",
      "author": {
        "name": "Emma Wilson",
        "avatar": "https://picsum.photos/50/50?random=103&keyword=architect",
        "verified": true,
        "following": false
      },
      "stats": {
        "likes": 276,
        "shares": 134,
        "comments": 78,
        "saves": 203
      },
      "tags": ["architecture", "sustainability", "green", "environment"],
      "dateShared": "2024-01-18T16:45:00",
      "isLiked": false,
      "isSaved": true,
      "category": "Architecture",
      "readingTime": "15 min"
    },
    {
      "id": 4,
      "title": "Modern CSS Layout Techniques",
      "url": "https://css-modern.dev",
      "description": "Comprehensive guide to modern CSS layout techniques including Grid and Flexbox",
      "image": "https://picsum.photos/400/250?random=94&keyword=css",
      "author": {
        "name": "David Rodriguez",
        "avatar": "https://picsum.photos/50/50?random=104&keyword=designer",
        "verified": false,
        "following": true
      },
      "stats": {
        "likes": 445,
        "shares": 178,
        "comments": 92,
        "saves": 289
      },
      "tags": ["css", "layout", "grid", "flexbox", "webdev"],
      "dateShared": "2024-01-17T11:20:00",
      "isLiked": true,
      "isSaved": true,
      "category": "Web Development",
      "readingTime": "10 min"
    },
  ];

  List<Map<String, dynamic>> trendingCollections = [
    {
      "id": 1,
      "name": "Web Development Essentials",
      "description": "Must-read articles for web developers",
      "bookmarkCount": 45,
      "followers": 1250,
      "image": "https://picsum.photos/300/200?random=111&keyword=webdev",
      "creator": {
        "name": "Tech Community",
        "avatar": "https://picsum.photos/40/40?random=121&keyword=tech"
      },
      "isFollowing": false,
      "tags": ["webdev", "javascript", "css", "html"]
    },
    {
      "id": 2,
      "name": "Design Inspiration Hub",
      "description": "Beautiful designs and creative ideas",
      "bookmarkCount": 67,
      "followers": 2340,
      "image": "https://picsum.photos/300/200?random=112&keyword=design",
      "creator": {
        "name": "Design Guild",
        "avatar": "https://picsum.photos/40/40?random=122&keyword=design"
      },
      "isFollowing": true,
      "tags": ["design", "ui", "ux", "inspiration"]
    },
    {
      "id": 3,
      "name": "AI & Machine Learning",
      "description": "Latest in artificial intelligence",
      "bookmarkCount": 32,
      "followers": 890,
      "image": "https://picsum.photos/300/200?random=113&keyword=ai",
      "creator": {
        "name": "AI Research",
        "avatar": "https://picsum.photos/40/40?random=123&keyword=ai"
      },
      "isFollowing": false,
      "tags": ["ai", "ml", "tech", "future"]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QBottomBar(
      title: "Social Bookmarks",
      selectedIndex: selectedIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Feed",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: "Discover",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: "Following",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
      children: [
        _buildFeedTab(),
        _buildDiscoverTab(),
        _buildFollowingTab(),
        _buildProfileTab(),
      ],
      onTap: (index) {
        selectedIndex = index;
        setState(() {});
      },
    );
  }

  Widget _buildFeedTab() {
    return Column(
      children: [
        // Header with search
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search bookmarks...",
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
                  ),
                  SizedBox(width: spMd),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(Icons.tune, color: Colors.white, size: 20),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  _buildSortChip("Latest", "Date Added"),
                  SizedBox(width: spSm),
                  _buildSortChip("Popular", "Popularity"),
                  SizedBox(width: spSm),
                  _buildSortChip("Trending", "Trending"),
                ],
              ),
            ],
          ),
        ),
        
        // Feed Content
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(spMd),
            itemCount: socialBookmarks.length,
            itemBuilder: (context, index) {
              final bookmark = socialBookmarks[index];
              return _buildSocialBookmarkCard(bookmark);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDiscoverTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Trending Collections",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          ...trendingCollections.map((collection) {
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                    child: Image.network(
                      "${collection["image"]}",
                      width: double.infinity,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(radiusLg),
                              child: Image.network(
                                "${(collection["creator"] as Map)["avatar"]}",
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${collection["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "by ${(collection["creator"] as Map)["name"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            QButton(
                              label: (collection["isFollowing"] as bool) ? "Following" : "Follow",
                              size: bs.sm,
                              onPressed: () {
                                collection["isFollowing"] = !(collection["isFollowing"] as bool);
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "${collection["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: spMd),
                        Row(
                          children: [
                            Icon(Icons.bookmark, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${collection["bookmarkCount"]} bookmarks",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Icon(Icons.people, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${collection["followers"]} followers",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spMd),
                        Wrap(
                          spacing: spXs,
                          children: (collection["tags"] as List).take(4).map((tag) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "#$tag",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
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

  Widget _buildFollowingTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, size: 64, color: disabledColor),
          SizedBox(height: spMd),
          Text(
            "Follow creators to see their bookmarks",
            style: TextStyle(
              fontSize: 16,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Discover interesting content from people you follow",
            style: TextStyle(
              fontSize: 14,
              color: disabledColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: spLg),
          QButton(
            label: "Explore Creators",
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Profile Header
          Container(
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    "https://picsum.photos/100/100?random=200&keyword=profile",
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: spMd),
                Text(
                  "John Developer",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "@johndeveloper",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spMd),
                Text(
                  "Passionate developer sharing the best resources in tech",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: spLg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatItem("248", "Bookmarks"),
                    _buildStatItem("1.2K", "Followers"),
                    _buildStatItem("456", "Following"),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spLg),
          
          // Quick Actions
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildActionCard("My Collections", Icons.folder, "12 collections"),
              _buildActionCard("Liked Bookmarks", Icons.favorite, "89 likes"),
              _buildActionCard("Shared Content", Icons.share, "45 shares"),
              _buildActionCard("Settings", Icons.settings, "Account settings"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialBookmarkCard(Map<String, dynamic> bookmark) {
    return Container(
      margin: EdgeInsets.only(bottom: spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author Header
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusLg),
                  child: Image.network(
                    "${(bookmark["author"] as Map)["avatar"]}",
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${(bookmark["author"] as Map)["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          if ((bookmark["author"] as Map)["verified"] as bool) ...[
                            SizedBox(width: spXs),
                            Icon(Icons.verified, color: infoColor, size: 16),
                          ],
                        ],
                      ),
                      Text(
                        "${bookmark["readingTime"]} • ${bookmark["category"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: (bookmark["author"] as Map)["following"] as bool ? "Following" : "Follow",
                  size: bs.sm,
                  onPressed: () {
                    (bookmark["author"] as Map)["following"] = !((bookmark["author"] as Map)["following"] as bool);
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          
          // Content Image
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusLg),
            child: Image.network(
              "${bookmark["image"]}",
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          
          // Content Details
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${bookmark["title"]}",
                  style: TextStyle(
                    fontSize: 18,
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
                
                // Tags
                Wrap(
                  spacing: spXs,
                  children: (bookmark["tags"] as List).take(3).map((tag) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "#$tag",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: spMd),
                
                // Action Bar
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        bookmark["isLiked"] = !(bookmark["isLiked"] as bool);
                        setState(() {});
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            (bookmark["isLiked"] as bool) ? Icons.favorite : Icons.favorite_border,
                            color: (bookmark["isLiked"] as bool) ? dangerColor : disabledBoldColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${(bookmark["stats"] as Map)["likes"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spMd),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.chat_bubble_outline, color: disabledBoldColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "${(bookmark["stats"] as Map)["comments"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: spMd),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.share, color: disabledBoldColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "${(bookmark["stats"] as Map)["shares"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        bookmark["isSaved"] = !(bookmark["isSaved"] as bool);
                        setState(() {});
                      },
                      child: Icon(
                        (bookmark["isSaved"] as bool) ? Icons.bookmark : Icons.bookmark_border,
                        color: (bookmark["isSaved"] as bool) ? warningColor : disabledBoldColor,
                        size: 20,
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
  }

  Widget _buildSortChip(String label, String value) {
    bool isSelected = sortBy == value;
    return GestureDetector(
      onTap: () {
        sortBy = value;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.grey[100],
          borderRadius: BorderRadius.circular(radiusLg),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : disabledBoldColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard(String title, IconData icon, String subtitle) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(icon, color: primaryColor, size: 32),
          SizedBox(height: spMd),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
