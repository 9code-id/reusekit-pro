import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaFriendsListView extends StatefulWidget {
  const SmaFriendsListView({super.key});

  @override
  State<SmaFriendsListView> createState() => _SmaFriendsListViewState();
}

class _SmaFriendsListViewState extends State<SmaFriendsListView> {
  String searchQuery = "";
  String selectedFilter = "All";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Online", "value": "Online"},
    {"label": "Recently Active", "value": "Recently Active"},
    {"label": "Close Friends", "value": "Close Friends"},
    {"label": "Favorites", "value": "Favorites"},
  ];

  List<Map<String, dynamic>> friends = [
    {
      "id": 1,
      "username": "@sarah_johnson",
      "name": "Sarah Johnson",
      "avatar": "https://picsum.photos/80/80?random=701",
      "isOnline": true,
      "lastSeen": "Active now",
      "mutualFriends": 45,
      "friendSince": "2 years ago",
      "isCloseFriend": true,
      "isFavorite": true,
      "bio": "Travel enthusiast & photographer 📸",
      "posts": 1234,
      "followers": 45600,
      "following": 1234,
    },
    {
      "id": 2,
      "username": "@mike_wilson",
      "name": "Mike Wilson",
      "avatar": "https://picsum.photos/80/80?random=702",
      "isOnline": false,
      "lastSeen": "5 minutes ago",
      "mutualFriends": 23,
      "friendSince": "1 year ago",
      "isCloseFriend": false,
      "isFavorite": false,
      "bio": "Tech geek & coffee lover ☕",
      "posts": 567,
      "followers": 23400,
      "following": 890,
    },
    {
      "id": 3,
      "username": "@emma_davis",
      "name": "Emma Davis",
      "avatar": "https://picsum.photos/80/80?random=703",
      "isOnline": true,
      "lastSeen": "Active now",
      "mutualFriends": 67,
      "friendSince": "3 years ago",
      "isCloseFriend": true,
      "isFavorite": true,
      "bio": "Artist & creative soul 🎨",
      "posts": 2456,
      "followers": 78900,
      "following": 2345,
    },
    {
      "id": 4,
      "username": "@alex_brown",
      "name": "Alex Brown",
      "avatar": "https://picsum.photos/80/80?random=704",
      "isOnline": false,
      "lastSeen": "2 hours ago",
      "mutualFriends": 12,
      "friendSince": "6 months ago",
      "isCloseFriend": false,
      "isFavorite": false,
      "bio": "Fitness enthusiast 💪",
      "posts": 890,
      "followers": 12300,
      "following": 456,
    },
    {
      "id": 5,
      "username": "@lisa_martinez",
      "name": "Lisa Martinez",
      "avatar": "https://picsum.photos/80/80?random=705",
      "isOnline": false,
      "lastSeen": "1 day ago",
      "mutualFriends": 34,
      "friendSince": "1.5 years ago",
      "isCloseFriend": true,
      "isFavorite": false,
      "bio": "Chef & food blogger 🍜",
      "posts": 1567,
      "followers": 34500,
      "following": 1678,
    },
    {
      "id": 6,
      "username": "@david_lee",
      "name": "David Lee",
      "avatar": "https://picsum.photos/80/80?random=706",
      "isOnline": true,
      "lastSeen": "Active now",
      "mutualFriends": 56,
      "friendSince": "2.5 years ago",
      "isCloseFriend": false,
      "isFavorite": true,
      "bio": "Music producer & DJ 🎵",
      "posts": 678,
      "followers": 56700,
      "following": 1234,
    },
  ];

  List<Map<String, dynamic>> get filteredFriends {
    List<Map<String, dynamic>> filtered = friends;
    
    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((friend) =>
        friend["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        friend["username"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        friend["bio"].toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    // Apply category filter
    switch (selectedFilter) {
      case "Online":
        filtered = filtered.where((friend) => friend["isOnline"] == true).toList();
        break;
      case "Recently Active":
        filtered = filtered.where((friend) => 
          friend["lastSeen"].contains("minutes") || 
          friend["lastSeen"].contains("Active now")
        ).toList();
        break;
      case "Close Friends":
        filtered = filtered.where((friend) => friend["isCloseFriend"] == true).toList();
        break;
      case "Favorites":
        filtered = filtered.where((friend) => friend["isFavorite"] == true).toList();
        break;
    }
    
    return filtered;
  }

  void toggleCloseFriend(int friendId) {
    final index = friends.indexWhere((friend) => friend["id"] == friendId);
    if (index != -1) {
      friends[index]["isCloseFriend"] = !friends[index]["isCloseFriend"];
      setState(() {});
    }
  }

  void toggleFavorite(int friendId) {
    final index = friends.indexWhere((friend) => friend["id"] == friendId);
    if (index != -1) {
      friends[index]["isFavorite"] = !friends[index]["isFavorite"];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Friends"),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              //navigateTo('AddFriendsView')
            },
          ),
          IconButton(
            icon: Icon(Icons.group),
            onPressed: () {
              // Group management
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            QTextField(
              label: "Search friends...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Filter Options
            QCategoryPicker(
              label: "Filter Friends",
              items: filterOptions,
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Friends Count
            Row(
              children: [
                Text(
                  "My Friends",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredFriends.length} friends",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Online Friends Quick Access
            if (selectedFilter == "All") ...[
              Text(
                "Online Now",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spSm),
              
              QHorizontalScroll(
                children: friends.where((friend) => friend["isOnline"] == true).map((friend) {
                  return Container(
                    width: 80,
                    margin: EdgeInsets.only(right: spSm),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage("${friend["avatar"]}"),
                            ),
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
                        SizedBox(height: spXs),
                        Text(
                          "${friend["name"].split(' ')[0]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              
              SizedBox(height: spMd),
              
              Text(
                "All Friends",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spSm),
            ],
            
            // Friends List
            if (filteredFriends.isEmpty) ...[
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
                      "No friends found",
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
                children: filteredFriends.map((friend) {
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
                            // Avatar with online status
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage("${friend["avatar"]}"),
                                ),
                                if (friend["isOnline"]) 
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
                            
                            // Friend Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${friend["name"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      if (friend["isCloseFriend"]) ...[
                                        SizedBox(width: spXs),
                                        Icon(
                                          Icons.favorite,
                                          size: 14,
                                          color: dangerColor,
                                        ),
                                      ],
                                      if (friend["isFavorite"]) ...[
                                        SizedBox(width: spXs),
                                        Icon(
                                          Icons.star,
                                          size: 14,
                                          color: Colors.amber,
                                        ),
                                      ],
                                    ],
                                  ),
                                  
                                  Text(
                                    "${friend["username"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  
                                  SizedBox(height: spXs),
                                  
                                  Text(
                                    "${friend["bio"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black87,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  
                                  SizedBox(height: spXs),
                                  
                                  Row(
                                    children: [
                                      Text(
                                        "${friend["lastSeen"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: friend["isOnline"] 
                                            ? successColor 
                                            : disabledBoldColor,
                                          fontWeight: friend["isOnline"] 
                                            ? FontWeight.w600 
                                            : FontWeight.normal,
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
                                        "Friends for ${friend["friendSince"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            
                            // Action Menu
                            PopupMenuButton<String>(
                              icon: Icon(
                                Icons.more_vert,
                                color: disabledBoldColor,
                              ),
                              onSelected: (value) {
                                switch (value) {
                                  case "close_friend":
                                    toggleCloseFriend(friend["id"]);
                                    break;
                                  case "favorite":
                                    toggleFavorite(friend["id"]);
                                    break;
                                  case "unfriend":
                                    // Show confirmation dialog
                                    break;
                                }
                              },
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: "close_friend",
                                  child: Row(
                                    children: [
                                      Icon(
                                        friend["isCloseFriend"] 
                                          ? Icons.favorite 
                                          : Icons.favorite_border,
                                        size: 16,
                                        color: dangerColor,
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        friend["isCloseFriend"] 
                                          ? "Remove from close friends" 
                                          : "Add to close friends",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: "favorite",
                                  child: Row(
                                    children: [
                                      Icon(
                                        friend["isFavorite"] 
                                          ? Icons.star 
                                          : Icons.star_border,
                                        size: 16,
                                        color: Colors.amber,
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        friend["isFavorite"] 
                                          ? "Remove from favorites" 
                                          : "Add to favorites",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: "unfriend",
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.person_remove,
                                        size: 16,
                                        color: dangerColor,
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        "Unfriend",
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
                        
                        // Stats Row
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "${((friend["posts"] as int) / 1000).toStringAsFixed(1)}K",
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
                                    "${((friend["followers"] as int) / 1000).toStringAsFixed(1)}K",
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
                                    "${friend["mutualFriends"]}",
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
                        
                        // Action Buttons
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Message",
                                size: bs.sm,
                                onPressed: () {
                                  //navigateTo('ChatView')
                                },
                              ),
                            ),
                            
                            SizedBox(width: spSm),
                            
                            Expanded(
                              child: QButton(
                                label: "View Profile",
                                size: bs.sm,
                                onPressed: () {
                                  //navigateTo('ProfileView')
                                },
                              ),
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
