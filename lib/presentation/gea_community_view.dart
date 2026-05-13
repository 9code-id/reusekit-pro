import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaCommunityView extends StatefulWidget {
  const GeaCommunityView({super.key});

  @override
  State<GeaCommunityView> createState() => _GeaCommunityViewState();
}

class _GeaCommunityViewState extends State<GeaCommunityView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedCategory = "All";
  
  // Mock data for community posts
  List<Map<String, dynamic>> communityPosts = [
    {
      "id": 1,
      "author": "GamerPro2024",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=gamer",
      "title": "Epic Boss Fight Strategy Guide",
      "content": "Just discovered an amazing strategy for defeating the final boss in Dragon's Quest. Here's my complete walkthrough...",
      "category": "Strategy",
      "likes": 234,
      "comments": 56,
      "shares": 12,
      "time": "2 hours ago",
      "image": "https://picsum.photos/400/200?random=101&keyword=game",
      "isLiked": false,
      "isFollowing": false,
      "tags": ["DragonQuest", "BossGuide", "Gaming"],
    },
    {
      "id": 2,
      "author": "StreamQueen",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=streamer",
      "title": "Best Gaming Setup for 2025",
      "content": "After months of testing, here's my ultimate gaming setup recommendation for both casual and competitive players.",
      "category": "Hardware",
      "likes": 189,
      "comments": 34,
      "shares": 28,
      "time": "4 hours ago",
      "image": "https://picsum.photos/400/200?random=102&keyword=setup",
      "isLiked": true,
      "isFollowing": true,
      "tags": ["Setup", "Hardware", "2025"],
    },
    {
      "id": 3,
      "author": "IndieGameDev",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=developer",
      "title": "My Journey Creating an Indie Game",
      "content": "From concept to Steam release - sharing my 2-year journey of creating my first indie game as a solo developer.",
      "category": "Development",
      "likes": 445,
      "comments": 89,
      "shares": 67,
      "time": "6 hours ago",
      "image": "https://picsum.photos/400/200?random=103&keyword=indie",
      "isLiked": false,
      "isFollowing": false,
      "tags": ["IndieGame", "Development", "Solo"],
    },
    {
      "id": 4,
      "author": "EsportsAnalyst",
      "avatar": "https://picsum.photos/100/100?random=4&keyword=analyst",
      "title": "Championship Analysis & Predictions",
      "content": "Breaking down the upcoming championship matches with detailed analysis of team strategies and player performance.",
      "category": "Esports",
      "likes": 156,
      "comments": 23,
      "shares": 19,
      "time": "8 hours ago",
      "image": "https://picsum.photos/400/200?random=104&keyword=esports",
      "isLiked": true,
      "isFollowing": false,
      "tags": ["Esports", "Analysis", "Championship"],
    },
  ];

  // Mock data for trending topics
  List<Map<String, dynamic>> trendingTopics = [
    {
      "topic": "#NewGameRelease",
      "posts": 1234,
      "trend": "up",
    },
    {
      "topic": "#GamingSetup",
      "posts": 892,
      "trend": "up",
    },
    {
      "topic": "#IndieGameDev",
      "posts": 567,
      "trend": "stable",
    },
    {
      "topic": "#EsportsNews",
      "posts": 445,
      "trend": "down",
    },
  ];

  // Mock data for featured communities
  List<Map<String, dynamic>> featuredCommunities = [
    {
      "name": "RPG Masters",
      "members": 15420,
      "description": "For RPG enthusiasts and masters",
      "image": "https://picsum.photos/100/100?random=201&keyword=rpg",
      "isJoined": true,
    },
    {
      "name": "Indie Developers",
      "members": 8934,
      "description": "Independent game developers unite",
      "image": "https://picsum.photos/100/100?random=202&keyword=indie",
      "isJoined": false,
    },
    {
      "name": "Speedrun Community",
      "members": 12567,
      "description": "Breaking records, one run at a time",
      "image": "https://picsum.photos/100/100?random=203&keyword=speed",
      "isJoined": false,
    },
  ];

  List<String> categories = ["All", "Strategy", "Hardware", "Development", "Esports", "Reviews"];

  void _toggleLike(int postId) {
    setState(() {
      final postIndex = communityPosts.indexWhere((post) => post["id"] == postId);
      if (postIndex != -1) {
        communityPosts[postIndex]["isLiked"] = !communityPosts[postIndex]["isLiked"];
        if (communityPosts[postIndex]["isLiked"]) {
          communityPosts[postIndex]["likes"] += 1;
        } else {
          communityPosts[postIndex]["likes"] -= 1;
        }
      }
    });
  }

  void _toggleFollow(int postId) {
    setState(() {
      final postIndex = communityPosts.indexWhere((post) => post["id"] == postId);
      if (postIndex != -1) {
        communityPosts[postIndex]["isFollowing"] = !communityPosts[postIndex]["isFollowing"];
      }
    });
  }

  void _createPost() {
    ss("Post creation started");
  }

  void _joinCommunity(String communityName) {
    setState(() {
      final communityIndex = featuredCommunities.indexWhere((community) => community["name"] == communityName);
      if (communityIndex != -1) {
        featuredCommunities[communityIndex]["isJoined"] = !featuredCommunities[communityIndex]["isJoined"];
        if (featuredCommunities[communityIndex]["isJoined"]) {
          featuredCommunities[communityIndex]["members"] += 1;
          ss("Joined ${communityName}");
        } else {
          featuredCommunities[communityIndex]["members"] -= 1;
          ss("Left ${communityName}");
        }
      }
    });
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post header
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage("${post["avatar"]}"),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${post["author"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: secondaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${post["category"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: secondaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2),
                      Text(
                        "${post["time"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: (post["isFollowing"] as bool) ? "Following" : "Follow",
                  size: bs.sm,
                  onPressed: () => _toggleFollow(post["id"] as int),
                ),
              ],
            ),
          ),
          
          // Post content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${post["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${post["content"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: spSm),
                
                // Tags
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (post["tags"] as List).map((tag) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "#$tag",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          
          // Post image
          if (post["image"] != null) ...[
            SizedBox(height: spSm),
            ClipRRect(
              borderRadius: BorderRadius.circular(radiusSm),
              child: Image.network(
                "${post["image"]}",
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ],
          
          SizedBox(height: spSm),
          
          // Post actions
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => _toggleLike(post["id"] as int),
                  child: Row(
                    children: [
                      Icon(
                        (post["isLiked"] as bool) ? Icons.favorite : Icons.favorite_border,
                        color: (post["isLiked"] as bool) ? dangerColor : disabledBoldColor,
                        size: 20,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "${post["likes"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spMd),
                Row(
                  children: [
                    Icon(
                      Icons.comment,
                      color: disabledBoldColor,
                      size: 20,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${post["comments"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: spMd),
                Row(
                  children: [
                    Icon(
                      Icons.share,
                      color: disabledBoldColor,
                      size: 20,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${post["shares"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Icon(
                  Icons.bookmark_border,
                  color: disabledBoldColor,
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingTopics() {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
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
            "Trending Topics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...trendingTopics.map((topic) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${topic["topic"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
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
                  Icon(
                    topic["trend"] == "up" ? Icons.trending_up : 
                    topic["trend"] == "down" ? Icons.trending_down : Icons.trending_flat,
                    color: topic["trend"] == "up" ? successColor : 
                           topic["trend"] == "down" ? dangerColor : disabledBoldColor,
                    size: 20,
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildFeaturedCommunities() {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
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
            "Featured Communities",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...featuredCommunities.map((community) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage("${community["image"]}"),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${community["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${community["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${(community["members"] as int).toString()} members",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    label: (community["isJoined"] as bool) ? "Joined" : "Join",
                    size: bs.sm,
                    onPressed: () => _joinCommunity(community["name"] as String),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Gaming Community",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Feed", icon: Icon(Icons.home)),
        Tab(text: "Discover", icon: Icon(Icons.explore)),
        Tab(text: "My Posts", icon: Icon(Icons.person)),
      ],
      tabChildren: [
        // Feed Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Create post button
              Container(
                width: double.infinity,
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
                      backgroundImage: NetworkImage("https://picsum.photos/100/100?random=999&keyword=user"),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: GestureDetector(
                        onTap: _createPost,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "Share your gaming experience...",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.add,
                      size: bs.sm,
                      onPressed: _createPost,
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Category filter
              QCategoryPicker(
                items: categories.map((category) => {
                  "label": category,
                  "value": category,
                }).toList(),
                value: selectedCategory,
                onChanged: (index, label, value, item) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spMd),
              
              // Posts list
              ...communityPosts.map((post) => _buildPostCard(post)).toList(),
            ],
          ),
        ),
        
        // Discover Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Search communities, topics, users...",
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
                      ss("Search: $searchQuery");
                    },
                  ),
                ],
              ),
              
              SizedBox(height: spMd),
              
              _buildTrendingTopics(),
              _buildFeaturedCommunities(),
              
              // Popular posts
              Container(
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
                      "Popular This Week",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...communityPosts.take(2).map((post) => Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusXs),
                            child: Image.network(
                              "${post["image"]}",
                              width: 60,
                              height: 60,
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
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "${post["author"]} • ${post["likes"]} likes",
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
                    )).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        // My Posts Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User stats
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage("https://picsum.photos/100/100?random=999&keyword=user"),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "GameMaster_Pro",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Gaming enthusiast since 2010",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "12 Posts",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(" • ", style: TextStyle(color: disabledBoldColor)),
                              Text(
                                "1.2K Followers",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                              Text(" • ", style: TextStyle(color: disabledBoldColor)),
                              Text(
                                "345 Following",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      label: "Edit Profile",
                      size: bs.sm,
                      onPressed: () {
                        ss("Edit profile clicked");
                      },
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // My posts section
              Text(
                "My Recent Posts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              ...communityPosts.take(3).map((post) => _buildPostCard(post)).toList(),
              
              // Load more button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Load More Posts",
                  size: bs.md,
                  onPressed: () {
                    ss("Loading more posts...");
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
