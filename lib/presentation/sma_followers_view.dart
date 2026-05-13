import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaFollowersView extends StatefulWidget {
  const SmaFollowersView({super.key});

  @override
  State<SmaFollowersView> createState() => _SmaFollowersViewState();
}

class _SmaFollowersViewState extends State<SmaFollowersView> {
  String searchQuery = "";
  String selectedFilter = "All";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Recent", "value": "Recent"},
    {"label": "Mutual Friends", "value": "Mutual Friends"},
    {"label": "Verified", "value": "Verified"},
    {"label": "Active", "value": "Active"},
  ];

  List<Map<String, dynamic>> followers = [
    {
      "id": 1,
      "username": "@photography_lover",
      "name": "Jessica Chen",
      "avatar": "https://picsum.photos/80/80?random=801",
      "followedDate": "2024-06-15",
      "isVerified": true,
      "isFollowingBack": false,
      "mutualFriends": 23,
      "bio": "Professional photographer 📸 Nature enthusiast",
      "followers": 67890,
      "posts": 1245,
      "isActive": true,
      "lastActive": "2 hours ago",
    },
    {
      "id": 2,
      "username": "@tech_enthusiast",
      "name": "Michael Rodriguez",
      "avatar": "https://picsum.photos/80/80?random=802",
      "followedDate": "2024-06-14",
      "isVerified": false,
      "isFollowingBack": true,
      "mutualFriends": 8,
      "bio": "Software developer & tech reviewer 💻",
      "followers": 12345,
      "posts": 567,
      "isActive": true,
      "lastActive": "Active now",
    },
    {
      "id": 3,
      "username": "@fitness_inspiration",
      "name": "Amanda Wilson",
      "avatar": "https://picsum.photos/80/80?random=803",
      "followedDate": "2024-06-13",
      "isVerified": true,
      "isFollowingBack": false,
      "mutualFriends": 45,
      "bio": "Personal trainer & nutrition coach 💪",
      "followers": 89012,
      "posts": 2134,
      "isActive": false,
      "lastActive": "1 day ago",
    },
    {
      "id": 4,
      "username": "@travel_stories",
      "name": "Carlos Martinez",
      "avatar": "https://picsum.photos/80/80?random=804",
      "followedDate": "2024-06-12",
      "isVerified": false,
      "isFollowingBack": true,
      "mutualFriends": 12,
      "bio": "World traveler ✈️ Sharing hidden gems",
      "followers": 34567,
      "posts": 890,
      "isActive": true,
      "lastActive": "30 minutes ago",
    },
    {
      "id": 5,
      "username": "@creative_arts",
      "name": "Sophie Kim",
      "avatar": "https://picsum.photos/80/80?random=805",
      "followedDate": "2024-06-11",
      "isVerified": true,
      "isFollowingBack": false,
      "mutualFriends": 67,
      "bio": "Digital artist & illustrator 🎨",
      "followers": 156789,
      "posts": 3456,
      "isActive": true,
      "lastActive": "1 hour ago",
    },
    {
      "id": 6,
      "username": "@food_explorer",
      "name": "David Thompson",
      "avatar": "https://picsum.photos/80/80?random=806",
      "followedDate": "2024-06-10",
      "isVerified": false,
      "isFollowingBack": true,
      "mutualFriends": 5,
      "bio": "Chef & food blogger 🍜 Culinary adventures",
      "followers": 23456,
      "posts": 1678,
      "isActive": false,
      "lastActive": "3 days ago",
    },
    {
      "id": 7,
      "username": "@music_beats",
      "name": "Alex Johnson",
      "avatar": "https://picsum.photos/80/80?random=807",
      "followedDate": "2024-06-09",
      "isVerified": true,
      "isFollowingBack": false,
      "mutualFriends": 34,
      "bio": "Music producer & DJ 🎵 Electronic vibes",
      "followers": 78901,
      "posts": 456,
      "isActive": true,
      "lastActive": "5 minutes ago",
    },
    {
      "id": 8,
      "username": "@lifestyle_blogger",
      "name": "Emily Davis",
      "avatar": "https://picsum.photos/80/80?random=808",
      "followedDate": "2024-06-08",
      "isVerified": false,
      "isFollowingBack": false,
      "mutualFriends": 19,
      "bio": "Lifestyle content creator ✨ Daily inspiration",
      "followers": 45678,
      "posts": 2890,
      "isActive": true,
      "lastActive": "15 minutes ago",
    },
  ];

  List<Map<String, dynamic>> get filteredFollowers {
    List<Map<String, dynamic>> filtered = followers;
    
    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((follower) =>
        follower["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        follower["username"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        follower["bio"].toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    // Apply category filter
    switch (selectedFilter) {
      case "Recent":
        filtered.sort((a, b) => 
          DateTime.parse(b["followedDate"]).compareTo(DateTime.parse(a["followedDate"])));
        break;
      case "Mutual Friends":
        filtered = filtered.where((follower) => 
          (follower["mutualFriends"] as int) > 0).toList();
        filtered.sort((a, b) => 
          (b["mutualFriends"] as int).compareTo(a["mutualFriends"] as int));
        break;
      case "Verified":
        filtered = filtered.where((follower) => 
          follower["isVerified"] == true).toList();
        break;
      case "Active":
        filtered = filtered.where((follower) => 
          follower["isActive"] == true).toList();
        break;
    }
    
    return filtered;
  }

  void toggleFollowBack(int followerId) {
    final index = followers.indexWhere((follower) => follower["id"] == followerId);
    if (index != -1) {
      followers[index]["isFollowingBack"] = !followers[index]["isFollowingBack"];
      setState(() {});
    }
  }

  void removeFollower(int followerId) async {
    bool isConfirmed = await confirm("Remove this follower? They won't be notified.");
    if (isConfirmed) {
      followers.removeWhere((follower) => follower["id"] == followerId);
      setState(() {});
      ss("Follower removed successfully");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Followers"),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              //navigateTo('InviteFriendsView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: primaryColor.withAlpha(100),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${followers.length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Followers",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${followers.where((f) => f["isFollowingBack"] == true).length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Following Back",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${followers.where((f) => f["isVerified"] == true).length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Verified",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Search Bar
            QTextField(
              label: "Search followers...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Filter Options
            QCategoryPicker(
              label: "Filter Followers",
              items: filterOptions,
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Results Header
            Row(
              children: [
                Text(
                  "Your Followers",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredFollowers.length} followers",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Followers List
            if (filteredFollowers.isEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: 48,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No followers found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search or filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              Column(
                children: filteredFollowers.map((follower) {
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            // Avatar
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage("${follower["avatar"]}"),
                                ),
                                if (follower["isActive"]) 
                                  Positioned(
                                    right: 2,
                                    bottom: 2,
                                    child: Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        color: successColor,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            
                            SizedBox(width: spSm),
                            
                            // Follower Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${follower["name"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      if (follower["isVerified"]) ...[
                                        SizedBox(width: spXs),
                                        Icon(
                                          Icons.verified,
                                          size: 16,
                                          color: primaryColor,
                                        ),
                                      ],
                                      if (follower["isFollowingBack"]) ...[
                                        SizedBox(width: spXs),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: successColor.withAlpha(50),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "Following",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: successColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  
                                  Text(
                                    "${follower["username"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  
                                  SizedBox(height: spXs),
                                  
                                  Text(
                                    "${follower["bio"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black87,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            
                            // Actions Menu
                            PopupMenuButton<String>(
                              icon: Icon(
                                Icons.more_vert,
                                color: disabledBoldColor,
                              ),
                              onSelected: (value) {
                                switch (value) {
                                  case "follow_back":
                                    toggleFollowBack(follower["id"]);
                                    break;
                                  case "remove":
                                    removeFollower(follower["id"]);
                                    break;
                                  case "block":
                                    // Block user
                                    break;
                                }
                              },
                              itemBuilder: (context) => [
                                if (!follower["isFollowingBack"])
                                  PopupMenuItem(
                                    value: "follow_back",
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.person_add,
                                          size: 16,
                                          color: primaryColor,
                                        ),
                                        SizedBox(width: spSm),
                                        Text(
                                          "Follow back",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                PopupMenuItem(
                                  value: "remove",
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.person_remove,
                                        size: 16,
                                        color: dangerColor,
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        "Remove follower",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: dangerColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: "block",
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.block,
                                        size: 16,
                                        color: dangerColor,
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        "Block user",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: dangerColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Stats and Info Row
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "${((follower["followers"] as int) / 1000).toStringAsFixed(1)}K",
                                    style: TextStyle(
                                      fontSize: 14,
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
                                    "${((follower["posts"] as int) / 1000).toStringAsFixed(1)}K",
                                    style: TextStyle(
                                      fontSize: 14,
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
                                    "${follower["mutualFriends"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Mutual",
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
                        
                        SizedBox(height: spSm),
                        
                        // Additional Info
                        Row(
                          children: [
                            Text(
                              "Followed ${DateTime.parse(follower["followedDate"]).dMMMy}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "•",
                              style: TextStyle(
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${follower["lastActive"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: follower["isActive"] 
                                  ? successColor 
                                  : disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Action Buttons
                        Row(
                          children: [
                            if (!follower["isFollowingBack"]) ...[
                              Expanded(
                                child: QButton(
                                  label: "Follow Back",
                                  size: bs.sm,
                                  onPressed: () => toggleFollowBack(follower["id"]),
                                ),
                              ),
                              SizedBox(width: spSm),
                            ],
                            
                            Expanded(
                              child: QButton(
                                label: "View Profile",
                                size: bs.sm,
                                onPressed: () {
                                  //navigateTo('ProfileView')
                                },
                              ),
                            ),
                            
                            SizedBox(width: spSm),
                            
                            QButton(
                              icon: Icons.message,
                              size: bs.sm,
                              onPressed: () {
                                //navigateTo('ChatView')
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
