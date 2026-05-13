import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPost10View extends StatefulWidget {
  @override
  State<GrlPost10View> createState() => _GrlPost10ViewState();
}

class _GrlPost10ViewState extends State<GrlPost10View> {
  int selectedTab = 0;
  String searchQuery = "";

  List<Map<String, dynamic>> followers = [
    {
      "id": "1",
      "name": "Sarah Johnson",
      "username": "@sarah_writes",
      "avatar": "https://picsum.photos/50/50?random=1&keyword=portrait",
      "bio": "Tech writer and UX designer sharing insights on digital products",
      "followers": 2340,
      "following": 567,
      "posts": 89,
      "isFollowing": true,
      "isVerified": true,
      "joinedDate": "2023-01-15",
      "categories": ["Technology", "Design"]
    },
    {
      "id": "2",
      "name": "Michael Chen",
      "username": "@mike_dev",
      "avatar": "https://picsum.photos/50/50?random=2&keyword=portrait",
      "bio": "Software engineer passionate about mobile development and AI",
      "followers": 1890,
      "following": 423,
      "posts": 67,
      "isFollowing": true,
      "isVerified": false,
      "joinedDate": "2022-11-08",
      "categories": ["Technology", "AI"]
    },
    {
      "id": "3",
      "name": "Emma Rodriguez",
      "username": "@emma_lifestyle",
      "avatar": "https://picsum.photos/50/50?random=3&keyword=portrait",
      "bio": "Lifestyle blogger, wellness advocate, and mindfulness coach",
      "followers": 3456,
      "following": 789,
      "posts": 123,
      "isFollowing": false,
      "isVerified": true,
      "joinedDate": "2022-06-20",
      "categories": ["Lifestyle", "Health"]
    },
    {
      "id": "4",
      "name": "David Park",
      "username": "@david_business",
      "avatar": "https://picsum.photos/50/50?random=4&keyword=portrait",
      "bio": "Entrepreneur and startup advisor helping scale tech companies",
      "followers": 4567,
      "following": 234,
      "posts": 156,
      "isFollowing": true,
      "isVerified": true,
      "joinedDate": "2021-09-12",
      "categories": ["Business", "Entrepreneurship"]
    },
  ];

  List<Map<String, dynamic>> following = [
    {
      "id": "5",
      "name": "Lisa Thompson",
      "username": "@lisa_design",
      "avatar": "https://picsum.photos/50/50?random=5&keyword=portrait",
      "bio": "Creative director specializing in brand identity and visual storytelling",
      "followers": 5678,
      "following": 345,
      "posts": 234,
      "isFollowing": true,
      "isVerified": true,
      "joinedDate": "2021-03-25",
      "categories": ["Design", "Branding"],
      "lastPost": "2024-03-15T10:30:00Z"
    },
    {
      "id": "6",
      "name": "Alex Kumar",
      "username": "@alex_data",
      "avatar": "https://picsum.photos/50/50?random=6&keyword=portrait",
      "bio": "Data scientist and machine learning researcher at leading tech company",
      "followers": 3210,
      "following": 456,
      "posts": 98,
      "isFollowing": true,
      "isVerified": false,
      "joinedDate": "2022-01-10",
      "categories": ["Data Science", "Technology"],
      "lastPost": "2024-03-14T14:20:00Z"
    },
    {
      "id": "7",
      "name": "Maria Santos",
      "username": "@maria_health",
      "avatar": "https://picsum.photos/50/50?random=7&keyword=portrait",
      "bio": "Nutritionist and fitness coach helping people live healthier lives",
      "followers": 2890,
      "following": 567,
      "posts": 178,
      "isFollowing": true,
      "isVerified": true,
      "joinedDate": "2021-08-17",
      "categories": ["Health", "Fitness"],
      "lastPost": "2024-03-13T09:45:00Z"
    },
    {
      "id": "8",
      "name": "James Wilson",
      "username": "@james_photo",
      "avatar": "https://picsum.photos/50/50?random=8&keyword=portrait",
      "bio": "Professional photographer capturing life's beautiful moments",
      "followers": 6789,
      "following": 234,
      "posts": 345,
      "isFollowing": true,
      "isVerified": true,
      "joinedDate": "2020-12-05",
      "categories": ["Photography", "Art"],
      "lastPost": "2024-03-12T16:15:00Z"
    },
  ];

  List<Map<String, dynamic>> suggested = [
    {
      "id": "9",
      "name": "Sophie Miller",
      "username": "@sophie_writes",
      "avatar": "https://picsum.photos/50/50?random=9&keyword=portrait",
      "bio": "Content strategist and copywriter helping brands tell their stories",
      "followers": 1456,
      "following": 678,
      "posts": 87,
      "isFollowing": false,
      "isVerified": false,
      "joinedDate": "2023-02-18",
      "categories": ["Marketing", "Writing"],
      "mutualFollowers": 5,
      "reason": "Followed by Sarah Johnson and 4 others you follow"
    },
    {
      "id": "10",
      "name": "Ryan Adams",
      "username": "@ryan_crypto",
      "avatar": "https://picsum.photos/50/50?random=10&keyword=portrait",
      "bio": "Blockchain developer and cryptocurrency analyst sharing market insights",
      "followers": 3456,
      "following": 234,
      "posts": 123,
      "isFollowing": false,
      "isVerified": true,
      "joinedDate": "2021-11-30",
      "categories": ["Crypto", "Technology"],
      "mutualFollowers": 3,
      "reason": "Similar interests in Technology"
    },
    {
      "id": "11",
      "name": "Anna Kim",
      "username": "@anna_travels",
      "avatar": "https://picsum.photos/50/50?random=11&keyword=portrait",
      "bio": "Travel blogger sharing hidden gems and cultural experiences worldwide",
      "followers": 5234,
      "following": 1890,
      "posts": 456,
      "isFollowing": false,
      "isVerified": true,
      "joinedDate": "2020-07-14",
      "categories": ["Travel", "Culture"],
      "mutualFollowers": 8,
      "reason": "Followed by Emma Rodriguez and 7 others you follow"
    },
  ];

  void _toggleFollow(List<Map<String, dynamic>> list, int index) {
    setState(() {
      list[index]["isFollowing"] = !(list[index]["isFollowing"] as bool);
    });
    
    if (list[index]["isFollowing"] as bool) {
      ss("Started following ${list[index]["name"]}");
    } else {
      ss("Unfollowed ${list[index]["name"]}");
    }
  }

  List<Map<String, dynamic>> _getFilteredList(List<Map<String, dynamic>> list) {
    if (searchQuery.isEmpty) return list;
    
    return list.where((user) =>
      (user["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
      (user["username"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
      (user["bio"] as String).toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();
  }

  String _formatFollowerCount(int count) {
    if (count >= 1000) {
      return "${(count / 1000).toStringAsFixed(1)}k";
    }
    return count.toString();
  }

  String _formatLastPost(String? lastPost) {
    if (lastPost == null) return "";
    
    final now = DateTime.now();
    final posted = DateTime.parse(lastPost);
    final difference = now.difference(posted);

    if (difference.inDays > 0) {
      return "Posted ${difference.inDays}d ago";
    } else if (difference.inHours > 0) {
      return "Posted ${difference.inHours}h ago";
    } else {
      return "Posted ${difference.inMinutes}m ago";
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Connections",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Followers", icon: Icon(Icons.people)),
        Tab(text: "Following", icon: Icon(Icons.person_add)),
        Tab(text: "Suggestions", icon: Icon(Icons.explore)),
      ],
      tabChildren: [
        _buildFollowersTab(),
        _buildFollowingTab(),
        _buildSuggestedTab(),
      ],
    );
  }

  Widget _buildFollowersTab() {
    final filteredFollowers = _getFilteredList(followers);
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          QTextField(
            label: "Search followers...",
            value: searchQuery,
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          SizedBox(height: spLg),

          // Stats
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(26),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${followers.length}",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Followers",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: primaryColor.withAlpha(51),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${followers.where((f) => f["isFollowing"] as bool).length}",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Following Back",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spLg),

          // Followers List
          ...filteredFollowers.map((follower) {
            final index = followers.indexOf(follower);
            return _buildUserCard(
              user: follower,
              onToggleFollow: () => _toggleFollow(followers, index),
              showLastPost: false,
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildFollowingTab() {
    final filteredFollowing = _getFilteredList(following);
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          QTextField(
            label: "Search following...",
            value: searchQuery,
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          SizedBox(height: spLg),

          // Stats
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withAlpha(26),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.people,
                  color: successColor,
                  size: 24,
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Following ${following.length} creators",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Stay updated with their latest content",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spLg),

          // Following List
          ...filteredFollowing.map((user) {
            final index = following.indexOf(user);
            return _buildUserCard(
              user: user,
              onToggleFollow: () => _toggleFollow(following, index),
              showLastPost: true,
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSuggestedTab() {
    final filteredSuggested = _getFilteredList(suggested);
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            "Discover New Creators",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Find interesting people to follow based on your interests",
            style: TextStyle(
              fontSize: 16,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spLg),

          // Search Bar
          QTextField(
            label: "Search suggestions...",
            value: searchQuery,
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          SizedBox(height: spLg),

          // Suggested Users
          ...filteredSuggested.map((user) {
            final index = suggested.indexOf(user);
            return _buildSuggestedUserCard(
              user: user,
              onToggleFollow: () => _toggleFollow(suggested, index),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildUserCard({
    required Map<String, dynamic> user,
    required VoidCallback onToggleFollow,
    required bool showLastPost,
  }) {
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
          Stack(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage("${user["avatar"]}"),
              ),
              if (user["isVerified"] as bool)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
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
                Row(
                  children: [
                    Text(
                      "${user["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    if (user["isVerified"] as bool)
                      Icon(
                        Icons.verified,
                        size: 16,
                        color: infoColor,
                      ),
                  ],
                ),
                Text(
                  "${user["username"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${user["bio"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Text(
                      "${_formatFollowerCount(user["followers"] as int)} followers",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text(
                      "${user["posts"]} posts",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    if (showLastPost && user["lastPost"] != null) ...[
                      SizedBox(width: spMd),
                      Text(
                        _formatLastPost(user["lastPost"]),
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          QButton(
            label: (user["isFollowing"] as bool) ? "Following" : "Follow",
            size: bs.sm,
            onPressed: onToggleFollow,
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestedUserCard({
    required Map<String, dynamic> user,
    required VoidCallback onToggleFollow,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border.all(
          color: primaryColor.withAlpha(26),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage("${user["avatar"]}"),
                  ),
                  if (user["isVerified"] as bool)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
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
                    Row(
                      children: [
                        Text(
                          "${user["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        if (user["isVerified"] as bool)
                          Icon(
                            Icons.verified,
                            size: 16,
                            color: infoColor,
                          ),
                      ],
                    ),
                    Text(
                      "${user["username"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                label: "Follow",
                size: bs.sm,
                onPressed: onToggleFollow,
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "${user["bio"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              height: 1.4,
            ),
          ),
          SizedBox(height: spMd),
          
          // Categories
          Wrap(
            spacing: spXs,
            children: (user["categories"] as List).map((category) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spMd),

          // Stats and Reason
          Row(
            children: [
              Text(
                "${_formatFollowerCount(user["followers"] as int)} followers",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Text(
                "${user["posts"]} posts",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: spSm,
              vertical: spXs,
            ),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(26),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${user["reason"]}",
              style: TextStyle(
                fontSize: 11,
                color: infoColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
