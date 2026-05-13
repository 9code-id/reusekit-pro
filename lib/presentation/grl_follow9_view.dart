import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFollow9View extends StatefulWidget {
  @override
  State<GrlFollow9View> createState() => _GrlFollow9ViewState();
}

class _GrlFollow9ViewState extends State<GrlFollow9View> {
  List<Map<String, dynamic>> followTabs = [
    {"label": "Followers", "value": "followers"},
    {"label": "Following", "value": "following"},
    {"label": "Suggested", "value": "suggested"},
  ];

  String selectedTab = "followers";
  String searchQuery = "";

  List<Map<String, dynamic>> followersData = [
    {
      "id": 1,
      "name": "Sarah Johnson",
      "username": "@sarahjohnson",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=woman",
      "bio": "Digital artist & UI/UX designer. Creating beautiful interfaces ✨",
      "followers": 15200,
      "following": 890,
      "posts": 345,
      "isVerified": true,
      "isFollowing": true,
      "mutualFollowers": 12,
      "lastActive": "2 hours ago",
      "coverImage": "https://picsum.photos/400/200?random=101&keyword=design",
    },
    {
      "id": 2,
      "name": "Marcus Chen",
      "username": "@marcusweb",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=man",
      "bio": "Full-stack developer | Tech enthusiast | Coffee lover ☕",
      "followers": 8900,
      "following": 1200,
      "posts": 189,
      "isVerified": false,
      "isFollowing": true,
      "mutualFollowers": 8,
      "lastActive": "5 minutes ago",
      "coverImage": "https://picsum.photos/400/200?random=102&keyword=technology",
    },
    {
      "id": 3,
      "name": "Emily Rodriguez",
      "username": "@emilyphoto",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=photographer",
      "bio": "Travel photographer 📸 | Capturing moments around the world 🌍",
      "followers": 23400,
      "following": 567,
      "posts": 892,
      "isVerified": true,
      "isFollowing": true,
      "mutualFollowers": 15,
      "lastActive": "1 hour ago",
      "coverImage": "https://picsum.photos/400/200?random=103&keyword=travel",
    },
  ];

  List<Map<String, dynamic>> followingData = [
    {
      "id": 4,
      "name": "Tech Insider",
      "username": "@techinsider",
      "avatar": "https://picsum.photos/100/100?random=4&keyword=tech",
      "bio": "Latest tech news and reviews | Your daily dose of innovation 🚀",
      "followers": 156000,
      "following": 2300,
      "posts": 1250,
      "isVerified": true,
      "isFollowing": true,
      "mutualFollowers": 45,
      "lastActive": "30 minutes ago",
      "coverImage": "https://picsum.photos/400/200?random=104&keyword=innovation",
    },
    {
      "id": 5,
      "name": "Fitness Motivation",
      "username": "@fitmotivation",
      "avatar": "https://picsum.photos/100/100?random=5&keyword=fitness",
      "bio": "Your daily fitness inspiration 💪 | Workout plans & nutrition tips",
      "followers": 89200,
      "following": 890,
      "posts": 567,
      "isVerified": false,
      "isFollowing": true,
      "mutualFollowers": 23,
      "lastActive": "1 day ago",
      "coverImage": "https://picsum.photos/400/200?random=105&keyword=workout",
    },
    {
      "id": 6,
      "name": "Creative Studio",
      "username": "@creativestudio",
      "avatar": "https://picsum.photos/100/100?random=6&keyword=creative",
      "bio": "Design inspiration & creative content | Bringing ideas to life 🎨",
      "followers": 67800,
      "following": 1500,
      "posts": 423,
      "isVerified": true,
      "isFollowing": true,
      "mutualFollowers": 18,
      "lastActive": "3 hours ago",
      "coverImage": "https://picsum.photos/400/200?random=106&keyword=creative",
    },
  ];

  List<Map<String, dynamic>> suggestedData = [
    {
      "id": 7,
      "name": "Alex Thompson",
      "username": "@alexthompson",
      "avatar": "https://picsum.photos/100/100?random=7&keyword=business",
      "bio": "Entrepreneur | Business strategist | Helping startups grow 📈",
      "followers": 34500,
      "following": 1200,
      "posts": 298,
      "isVerified": false,
      "isFollowing": false,
      "mutualFollowers": 7,
      "lastActive": "4 hours ago",
      "coverImage": "https://picsum.photos/400/200?random=107&keyword=business",
      "reason": "Followed by sarahjohnson and 6 others",
    },
    {
      "id": 8,
      "name": "Food Explorer",
      "username": "@foodexplorer",
      "avatar": "https://picsum.photos/100/100?random=8&keyword=food",
      "bio": "Food blogger | Recipe creator | Exploring cuisines worldwide 🍕",
      "followers": 45600,
      "following": 890,
      "posts": 678,
      "isVerified": true,
      "isFollowing": false,
      "mutualFollowers": 12,
      "lastActive": "2 hours ago",
      "coverImage": "https://picsum.photos/400/200?random=108&keyword=cuisine",
      "reason": "Popular in your network",
    },
    {
      "id": 9,
      "name": "Music Vibes",
      "username": "@musicvibes",
      "avatar": "https://picsum.photos/100/100?random=9&keyword=music",
      "bio": "Music producer | DJ | Sharing the best beats and rhythms 🎵",
      "followers": 78900,
      "following": 2100,
      "posts": 456,
      "isVerified": false,
      "isFollowing": false,
      "mutualFollowers": 5,
      "lastActive": "6 hours ago",
      "coverImage": "https://picsum.photos/400/200?random=109&keyword=music",
      "reason": "Similar interests",
    },
  ];

  List<Map<String, dynamic>> get currentData {
    switch (selectedTab) {
      case "followers":
        return followersData;
      case "following":
        return followingData;
      case "suggested":
        return suggestedData;
      default:
        return followersData;
    }
  }

  List<Map<String, dynamic>> get filteredData {
    if (searchQuery.isEmpty) return currentData;
    return currentData.where((user) {
      return "${user["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
             "${user["username"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
             "${user["bio"]}".toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  void _toggleFollow(int userId) {
    final userLists = [followersData, followingData, suggestedData];
    
    for (var userList in userLists) {
      final userIndex = userList.indexWhere((user) => user["id"] == userId);
      if (userIndex != -1) {
        setState(() {
          userList[userIndex]["isFollowing"] = !userList[userIndex]["isFollowing"];
          if (userList[userIndex]["isFollowing"]) {
            userList[userIndex]["followers"] = (userList[userIndex]["followers"] as int) + 1;
          } else {
            userList[userIndex]["followers"] = (userList[userIndex]["followers"] as int) - 1;
          }
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Follow Network"),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // User Profile Summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage("https://picsum.photos/100/100?random=99&keyword=user"),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "John Doe",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Icon(
                                  Icons.verified,
                                  color: primaryColor,
                                  size: 16,
                                ),
                              ],
                            ),
                            Text(
                              "@johndoe",
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
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "1,234",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Posts",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "15.2K",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Followers",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "892",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Following",
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
                ],
              ),
            ),

            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search users...",
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

            // Tab Filter
            QCategoryPicker(
              label: "View",
              items: followTabs,
              value: selectedTab,
              onChanged: (index, label, value, item) {
                selectedTab = value;
                setState(() {});
              },
            ),

            // Stats Summary for Current Tab
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    selectedTab == "followers" ? Icons.people : 
                    selectedTab == "following" ? Icons.person_add : 
                    Icons.explore,
                    color: primaryColor,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    selectedTab == "followers" ? "${followersData.length} Followers" :
                    selectedTab == "following" ? "${followingData.length} Following" :
                    "${suggestedData.length} Suggested for you",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            // User List
            ...filteredData.map((user) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    // User Header
                    Row(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundImage: NetworkImage("${user["avatar"]}"),
                            ),
                            if (user["lastActive"] == "5 minutes ago" || user["lastActive"] == "2 hours ago")
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: successColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 2),
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
                              Row(
                                children: [
                                  Text(
                                    "${user["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  if (user["isVerified"] == true) ...[
                                    SizedBox(width: spXs),
                                    Icon(
                                      Icons.verified,
                                      color: primaryColor,
                                      size: 16,
                                    ),
                                  ],
                                ],
                              ),
                              Text(
                                "${user["username"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              if (selectedTab == "suggested" && user["reason"] != null)
                                Text(
                                  "${user["reason"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        QButton(
                          label: user["isFollowing"] == true ? "Following" : "Follow",
                          size: bs.sm,
                          onPressed: () => _toggleFollow(user["id"]),
                        ),
                      ],
                    ),

                    // User Bio
                    if (user["bio"] != null)
                      Container(
                        width: double.infinity,
                        child: Text(
                          "${user["bio"]}",
                          style: TextStyle(
                            fontSize: 13,
                            color: primaryColor,
                            height: 1.3,
                          ),
                        ),
                      ),

                    // User Stats
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${((user["posts"] as int) / 1000 >= 1) ? '${((user["posts"] as int) / 1000).toStringAsFixed(1)}K' : '${user["posts"]}'}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Posts",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${((user["followers"] as int) / 1000 >= 1) ? '${((user["followers"] as int) / 1000).toStringAsFixed(1)}K' : '${user["followers"]}'}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Followers",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${((user["following"] as int) / 1000 >= 1) ? '${((user["following"] as int) / 1000).toStringAsFixed(1)}K' : '${user["following"]}'}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Following",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (user["mutualFollowers"] != null && (user["mutualFollowers"] as int) > 0)
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "${user["mutualFollowers"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Mutual",
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

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Profile",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.chat_bubble_outline,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.more_horiz,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            // Load More Button
            if (filteredData.length >= 3)
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Load More",
                  size: bs.md,
                  onPressed: () {},
                ),
              ),
          ],
        ),
      ),
    );
  }
}
