import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaFollowingView extends StatefulWidget {
  const SmaFollowingView({super.key});

  @override
  State<SmaFollowingView> createState() => _SmaFollowingViewState();
}

class _SmaFollowingViewState extends State<SmaFollowingView> {
  String searchQuery = "";
  String selectedFilter = "All";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Recent", "value": "Recent"},
    {"label": "Friends", "value": "Friends"},
    {"label": "Verified", "value": "Verified"},
    {"label": "Inactive", "value": "Inactive"},
  ];

  List<Map<String, dynamic>> following = [
    {
      "id": 1,
      "username": "@natgeo",
      "name": "National Geographic",
      "avatar": "https://picsum.photos/80/80?random=901",
      "followedDate": "2024-06-15",
      "isVerified": true,
      "isFollowingBack": false,
      "category": "Media",
      "bio": "Exploring the world through stunning photography 🌍",
      "followers": 45600000,
      "posts": 12456,
      "isActive": true,
      "lastPost": "2 hours ago",
      "isFriend": false,
    },
    {
      "id": 2,
      "username": "@tech_reviewer",
      "name": "Tech Reviewer Pro",
      "avatar": "https://picsum.photos/80/80?random=902",
      "followedDate": "2024-06-14",
      "isVerified": true,
      "isFollowingBack": true,
      "category": "Technology",
      "bio": "Latest tech reviews and gadget unboxings 📱",
      "followers": 2340000,
      "posts": 3456,
      "isActive": true,
      "lastPost": "1 hour ago",
      "isFriend": true,
    },
    {
      "id": 3,
      "username": "@fitness_guru",
      "name": "Fitness Motivation",
      "avatar": "https://picsum.photos/80/80?random=903",
      "followedDate": "2024-06-13",
      "isVerified": false,
      "isFollowingBack": true,
      "category": "Health",
      "bio": "Transform your body and mind 💪 Daily workouts",
      "followers": 890000,
      "posts": 5678,
      "isActive": true,
      "lastPost": "4 hours ago",
      "isFriend": true,
    },
    {
      "id": 4,
      "username": "@travel_diaries",
      "name": "Travel Adventures",
      "avatar": "https://picsum.photos/80/80?random=904",
      "followedDate": "2024-06-12",
      "isVerified": true,
      "isFollowingBack": false,
      "category": "Travel",
      "bio": "Discover hidden gems around the world ✈️",
      "followers": 1560000,
      "posts": 7890,
      "isActive": false,
      "lastPost": "2 days ago",
      "isFriend": false,
    },
    {
      "id": 5,
      "username": "@food_network",
      "name": "Food Network",
      "avatar": "https://picsum.photos/80/80?random=905",
      "followedDate": "2024-06-11",
      "isVerified": true,
      "isFollowingBack": false,
      "category": "Food",
      "bio": "Delicious recipes and culinary inspiration 🍜",
      "followers": 8900000,
      "posts": 9876,
      "isActive": true,
      "lastPost": "6 hours ago",
      "isFriend": false,
    },
    {
      "id": 6,
      "username": "@art_gallery",
      "name": "Modern Art Gallery",
      "avatar": "https://picsum.photos/80/80?random=906",
      "followedDate": "2024-06-10",
      "isVerified": false,
      "isFollowingBack": true,
      "category": "Art",
      "bio": "Contemporary art and creative expressions 🎨",
      "followers": 456000,
      "posts": 2345,
      "isActive": true,
      "lastPost": "8 hours ago",
      "isFriend": true,
    },
    {
      "id": 7,
      "username": "@science_facts",
      "name": "Science Daily",
      "avatar": "https://picsum.photos/80/80?random=907",
      "followedDate": "2024-06-09",
      "isVerified": true,
      "isFollowingBack": false,
      "category": "Education",
      "bio": "Fascinating science facts and discoveries 🔬",
      "followers": 3450000,
      "posts": 4567,
      "isActive": true,
      "lastPost": "3 hours ago",
      "isFriend": false,
    },
    {
      "id": 8,
      "username": "@music_beats",
      "name": "Music Producer",
      "avatar": "https://picsum.photos/80/80?random=908",
      "followedDate": "2024-06-08",
      "isVerified": false,
      "isFollowingBack": true,
      "category": "Music",
      "bio": "Electronic music producer 🎵 New beats daily",
      "followers": 234000,
      "posts": 1890,
      "isActive": false,
      "lastPost": "1 week ago",
      "isFriend": true,
    },
  ];

  List<Map<String, dynamic>> get filteredFollowing {
    List<Map<String, dynamic>> filtered = following;
    
    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((person) =>
        person["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        person["username"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        person["bio"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        person["category"].toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    // Apply category filter
    switch (selectedFilter) {
      case "Recent":
        filtered.sort((a, b) => 
          DateTime.parse(b["followedDate"]).compareTo(DateTime.parse(a["followedDate"])));
        break;
      case "Friends":
        filtered = filtered.where((person) => 
          person["isFriend"] == true).toList();
        break;
      case "Verified":
        filtered = filtered.where((person) => 
          person["isVerified"] == true).toList();
        break;
      case "Inactive":
        filtered = filtered.where((person) => 
          person["isActive"] == false).toList();
        break;
    }
    
    return filtered;
  }

  void unfollowUser(int userId) async {
    final user = following.firstWhere((u) => u["id"] == userId);
    bool isConfirmed = await confirm("Unfollow ${user["name"]}?");
    if (isConfirmed) {
      following.removeWhere((person) => person["id"] == userId);
      setState(() {});
      ss("Unfollowed ${user["name"]}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Following"),
        actions: [
          IconButton(
            icon: Icon(Icons.person_search),
            onPressed: () {
              //navigateTo('PeopleSearchView')
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
                          "${following.length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Following",
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
                          "${following.where((f) => f["isFollowingBack"] == true).length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Friends",
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
                          "${following.where((f) => f["isVerified"] == true).length}",
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
              label: "Search following...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Filter Options
            QCategoryPicker(
              label: "Filter Following",
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
                  "People You Follow",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredFollowing.length} accounts",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Following List
            if (filteredFollowing.isEmpty) ...[
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
                      "No accounts found",
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
                children: filteredFollowing.map((person) {
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
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage("${person["avatar"]}"),
                            ),
                            
                            SizedBox(width: spSm),
                            
                            // Person Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "${person["name"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (person["isVerified"]) ...[
                                        SizedBox(width: spXs),
                                        Icon(
                                          Icons.verified,
                                          size: 16,
                                          color: primaryColor,
                                        ),
                                      ],
                                    ],
                                  ),
                                  
                                  Text(
                                    "${person["username"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  
                                  SizedBox(height: spXs),
                                  
                                  Text(
                                    "${person["bio"]}",
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
                            
                            // Unfollow Button
                            QButton(
                              label: "Following",
                              size: bs.sm,
                              onPressed: () => unfollowUser(person["id"]),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Status Indicators
                        Row(
                          children: [
                            if (person["isFriend"]) ...[
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(50),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "Following you back",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                            ],
                            
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${person["category"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            
                            Spacer(),
                            
                            Text(
                              "Last post: ${person["lastPost"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: person["isActive"] 
                                  ? successColor 
                                  : disabledBoldColor,
                              ),
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
                                    "${((person["followers"] as int) / 1000000).toStringAsFixed(1)}M",
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
                                    "${((person["posts"] as int) / 1000).toStringAsFixed(1)}K",
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
                                    "Since",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${DateTime.parse(person["followedDate"]).dMMMy}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
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
                                label: "View Profile",
                                size: bs.sm,
                                onPressed: () {
                                  //navigateTo('ProfileView')
                                },
                              ),
                            ),
                            
                            SizedBox(width: spSm),
                            
                            if (person["isFriend"]) ...[
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
                            ],
                            
                            QButton(
                              icon: Icons.notifications,
                              size: bs.sm,
                              onPressed: () {
                                // Toggle notifications
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
