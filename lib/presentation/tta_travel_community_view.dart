import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaTravelCommunityView extends StatefulWidget {
  const TtaTravelCommunityView({super.key});

  @override
  State<TtaTravelCommunityView> createState() => _TtaTravelCommunityViewState();
}

class _TtaTravelCommunityViewState extends State<TtaTravelCommunityView> {
  int currentTab = 0;

  List<Map<String, dynamic>> communities = [
    {
      "id": 1,
      "name": "Solo Travelers",
      "description": "Connect with fellow solo adventurers and share tips",
      "image": "https://picsum.photos/300/200?random=1&keyword=solo",
      "members": 15420,
      "posts": 2890,
      "isJoined": true,
      "category": "General"
    },
    {
      "id": 2,
      "name": "Backpackers Paradise",
      "description": "Budget travel tips and backpacking adventures",
      "image": "https://picsum.photos/300/200?random=2&keyword=backpack",
      "members": 23680,
      "posts": 4520,
      "isJoined": false,
      "category": "Budget"
    },
    {
      "id": 3,
      "name": "Digital Nomads",
      "description": "Work remotely while exploring the world",
      "image": "https://picsum.photos/300/200?random=3&keyword=digital",
      "members": 18950,
      "posts": 3670,
      "isJoined": true,
      "category": "Lifestyle"
    },
    {
      "id": 4,
      "name": "Food & Culture",
      "description": "Discover authentic local cuisine and cultural experiences",
      "image": "https://picsum.photos/300/200?random=4&keyword=food",
      "members": 31250,
      "posts": 7890,
      "isJoined": false,
      "category": "Culture"
    },
    {
      "id": 5,
      "name": "Adventure Seekers",
      "description": "Extreme sports and adrenaline-filled activities",
      "image": "https://picsum.photos/300/200?random=5&keyword=adventure",
      "members": 12780,
      "posts": 2340,
      "isJoined": true,
      "category": "Adventure"
    },
  ];

  List<Map<String, dynamic>> forumPosts = [
    {
      "id": 1,
      "title": "Best solo travel destinations in Southeast Asia?",
      "author": "Emma_Wanderer",
      "avatar": "https://picsum.photos/40/40?random=11",
      "community": "Solo Travelers",
      "replies": 24,
      "likes": 87,
      "timeAgo": "2 hours ago",
      "isLiked": false,
      "tags": ["Southeast Asia", "Solo Travel", "Recommendations"]
    },
    {
      "id": 2,
      "title": "How to work effectively while traveling?",
      "author": "DigitalNomadLife",
      "avatar": "https://picsum.photos/40/40?random=12",
      "community": "Digital Nomads",
      "replies": 18,
      "likes": 52,
      "timeAgo": "4 hours ago",
      "isLiked": true,
      "tags": ["Remote Work", "Productivity", "Tips"]
    },
    {
      "id": 3,
      "title": "Must-try street food in Bangkok",
      "author": "FoodieExplorer",
      "avatar": "https://picsum.photos/40/40?random=13",
      "community": "Food & Culture",
      "replies": 31,
      "likes": 156,
      "timeAgo": "6 hours ago",
      "isLiked": false,
      "tags": ["Bangkok", "Street Food", "Thailand"]
    },
    {
      "id": 4,
      "title": "Budget backpacking through Europe - 30 days itinerary",
      "author": "BackpackBuddy",
      "avatar": "https://picsum.photos/40/40?random=14",
      "community": "Backpackers Paradise",
      "replies": 42,
      "likes": 203,
      "timeAgo": "8 hours ago",
      "isLiked": true,
      "tags": ["Europe", "Budget Travel", "Itinerary"]
    },
  ];

  List<Map<String, dynamic>> trendingTopics = [
    {"topic": "Solo Travel Tips", "posts": 1250},
    {"topic": "Digital Nomad Visa", "posts": 890},
    {"topic": "Budget Travel Hacks", "posts": 2340},
    {"topic": "Photography Tips", "posts": 567},
    {"topic": "Local Food Guide", "posts": 1890},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Travel Community",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Communities", icon: Icon(Icons.groups)),
        Tab(text: "Forum", icon: Icon(Icons.forum)),
        Tab(text: "Trending", icon: Icon(Icons.trending_up)),
      ],
      tabChildren: [
        _buildCommunitiesTab(),
        _buildForumTab(),
        _buildTrendingTab(),
      ],
    );
  }

  Widget _buildCommunitiesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search communities...",
                prefixIcon: Icon(Icons.search, color: disabledBoldColor),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(spSm),
              ),
            ),
          ),

          SizedBox(height: spLg),

          // Popular Communities Section
          Text(
            "Popular Communities",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: spSm),

          // Communities Grid
          Column(
            children: communities.map((community) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Community Image
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(radiusMd),
                      ),
                      child: Image.network(
                        "${community["image"]}",
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),

                    // Community Info
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${community["name"]}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${community["category"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: spXs),

                          Text(
                            "${community["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),

                          SizedBox(height: spSm),

                          // Stats
                          Row(
                            children: [
                              Icon(
                                Icons.people,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${(community["members"] as int).currency} members",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                Icons.article,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${(community["posts"] as int).currency} posts",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              QButton(
                                label: (community["isJoined"] as bool) 
                                    ? "Joined" 
                                    : "Join",
                                size: bs.sm,
                                color: (community["isJoined"] as bool) 
                                    ? successColor 
                                    : primaryColor,
                                onPressed: () {
                                  community["isJoined"] = !(community["isJoined"] as bool);
                                  setState(() {});
                                },
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

  Widget _buildForumTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Create Post Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Create New Post",
              icon: Icons.add,
              onPressed: () {},
            ),
          ),

          SizedBox(height: spLg),

          // Forum Posts
          Column(
            children: forumPosts.map((post) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Post Header
                    Row(
                      children: [
                        ClipOval(
                          child: Image.network(
                            "${post["avatar"]}",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
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
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "in ${post["community"]} • ${post["timeAgo"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.more_horiz),
                          onPressed: () {},
                        ),
                      ],
                    ),

                    SizedBox(height: spSm),

                    // Post Title
                    Text(
                      "${post["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: spSm),

                    // Tags
                    Wrap(
                      spacing: spXs,
                      children: (post["tags"] as List).map((tag) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "#$tag",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    SizedBox(height: spSm),

                    // Post Stats
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            post["isLiked"] = !(post["isLiked"] as bool);
                            setState(() {});
                          },
                          child: Row(
                            children: [
                              Icon(
                                (post["isLiked"] as bool) 
                                    ? Icons.thumb_up 
                                    : Icons.thumb_up_outlined,
                                size: 16,
                                color: (post["isLiked"] as bool) 
                                    ? primaryColor 
                                    : disabledBoldColor,
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
                        ),
                        SizedBox(width: spSm),
                        Row(
                          children: [
                            Icon(
                              Icons.comment_outlined,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${post["replies"]} replies",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Icon(
                          Icons.share_outlined,
                          size: 16,
                          color: disabledBoldColor,
                        ),
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

  Widget _buildTrendingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Trending Topics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: spLg),

          Column(
            children: trendingTopics.asMap().entries.map((entry) {
              final index = entry.key;
              final topic = entry.value;

              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: _getTrendingColor(index),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${topic["topic"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${(topic["posts"] as int).currency} posts",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.trending_up,
                      color: successColor,
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

  Color _getTrendingColor(int index) {
    switch (index) {
      case 0:
        return Colors.amber;
      case 1:
        return Colors.grey[400]!;
      case 2:
        return Colors.orange[400]!;
      default:
        return primaryColor;
    }
  }
}
