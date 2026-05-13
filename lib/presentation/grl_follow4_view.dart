import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFollow4View extends StatefulWidget {
  @override
  State<GrlFollow4View> createState() => _GrlFollow4ViewState();
}

class _GrlFollow4ViewState extends State<GrlFollow4View> {
  String searchQuery = "";
  String selectedCategory = "All";
  List<String> selectedInterests = [];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Photography", "value": "Photography"},
    {"label": "Travel", "value": "Travel"},
    {"label": "Food", "value": "Food"},
    {"label": "Fitness", "value": "Fitness"},
    {"label": "Art", "value": "Art"},
    {"label": "Music", "value": "Music"},
    {"label": "Technology", "value": "Technology"},
  ];

  List<Map<String, dynamic>> interests = [
    {"label": "Nature", "value": "nature", "checked": false},
    {"label": "Street Art", "value": "street_art", "checked": false},
    {"label": "Fashion", "value": "fashion", "checked": false},
    {"label": "Sports", "value": "sports", "checked": false},
    {"label": "Gaming", "value": "gaming", "checked": false},
    {"label": "Cooking", "value": "cooking", "checked": false},
  ];

  List<Map<String, dynamic>> suggestedUsers = [
    {
      "id": 1,
      "name": "Alex Thompson",
      "username": "@alexphoto",
      "image": "https://picsum.photos/150/150?random=1&keyword=portrait",
      "category": "Photography",
      "followers": 45200,
      "posts": 1250,
      "bio": "Capturing moments that matter ✨",
      "isFollowing": false,
      "mutualFriends": 12,
      "isVerified": true,
    },
    {
      "id": 2,
      "name": "Emma Rodriguez",
      "username": "@wanderemma",
      "image": "https://picsum.photos/150/150?random=2&keyword=portrait",
      "category": "Travel",
      "followers": 28900,
      "posts": 890,
      "bio": "Exploring the world one city at a time 🌍",
      "isFollowing": false,
      "mutualFriends": 8,
      "isVerified": false,
    },
    {
      "id": 3,
      "name": "Marcus Chen",
      "username": "@chefmarcus",
      "image": "https://picsum.photos/150/150?random=3&keyword=portrait",
      "category": "Food",
      "followers": 67800,
      "posts": 2100,
      "bio": "Chef | Food enthusiast | Recipe creator 👨‍🍳",
      "isFollowing": true,
      "mutualFriends": 25,
      "isVerified": true,
    },
    {
      "id": 4,
      "name": "Sarah Johnson",
      "username": "@fitnesssarah",
      "image": "https://picsum.photos/150/150?random=4&keyword=portrait",
      "category": "Fitness",
      "followers": 34500,
      "posts": 750,
      "bio": "Personal trainer | Wellness coach 💪",
      "isFollowing": false,
      "mutualFriends": 5,
      "isVerified": false,
    },
    {
      "id": 5,
      "name": "David Kim",
      "username": "@davidart",
      "image": "https://picsum.photos/150/150?random=5&keyword=portrait",
      "category": "Art",
      "followers": 19200,
      "posts": 480,
      "bio": "Digital artist | Illustration lover 🎨",
      "isFollowing": false,
      "mutualFriends": 3,
      "isVerified": false,
    },
    {
      "id": 6,
      "name": "Luna Martinez",
      "username": "@lunamelody",
      "image": "https://picsum.photos/150/150?random=6&keyword=portrait",
      "category": "Music",
      "followers": 52100,
      "posts": 1650,
      "bio": "Singer-songwriter | Music producer 🎵",
      "isFollowing": false,
      "mutualFriends": 18,
      "isVerified": true,
    },
  ];

  List<Map<String, dynamic>> get filteredUsers {
    return suggestedUsers.where((user) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${user["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${user["username"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || 
          "${user["category"]}" == selectedCategory;
      
      return matchesSearch && matchesCategory;
    }).toList();
  }

  void _toggleFollow(int userId) {
    setState(() {
      final userIndex = suggestedUsers.indexWhere((user) => user["id"] == userId);
      if (userIndex != -1) {
        bool wasFollowing = suggestedUsers[userIndex]["isFollowing"] as bool;
        suggestedUsers[userIndex]["isFollowing"] = !wasFollowing;
        
        if (!wasFollowing) {
          ss("Started following ${suggestedUsers[userIndex]["name"]}");
        } else {
          si("Unfollowed ${suggestedUsers[userIndex]["name"]}");
        }
      }
    });
  }

  void _showUserProfile(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
        ),
        child: Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage("${user["image"]}"),
                        fit: BoxFit.cover,
                      ),
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
                              "${user["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            if (user["isVerified"] as bool) ...[
                              SizedBox(width: spXs),
                              Icon(
                                Icons.verified,
                                color: primaryColor,
                                size: 18,
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
                        SizedBox(height: spXs),
                        Text(
                          "${user["bio"]}",
                          style: TextStyle(
                            fontSize: 13,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${((user["posts"] as int) / 1000).toStringAsFixed(1)}K",
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
                          "${((user["followers"] as int) / 1000).toStringAsFixed(1)}K",
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
                          "${user["mutualFriends"]}",
                          style: TextStyle(
                            fontSize: fsH6,
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
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: (user["isFollowing"] as bool) ? "Following" : "Follow",
                      size: bs.sm,
                      onPressed: () {
                        _toggleFollow(user["id"] as int);
                        back();
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: Icons.message,
                    size: bs.sm,
                    onPressed: () {
                      back();
                      si("Message sent to ${user["name"]}");
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discover People"),
        actions: [
          QButton(
            icon: Icons.tune,
            size: bs.sm,
            onPressed: () {
              si("Opened advanced filters");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Search
            QTextField(
              label: "Search people",
              value: searchQuery,
              hint: "Search by name or username",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Category Filter
            QDropdownField(
              label: "Category",
              items: categories,
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            // Interest Tags
            Text(
              "Interests",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QSwitch(
              items: interests,
              value: interests.where((item) => item["checked"] as bool).toList(),
              onChanged: (values, ids) {
                selectedInterests = (values as List<Map<String, dynamic>>)
                    .map((item) => item["value"] as String)
                    .toList();
                
                for (var interest in interests) {
                  interest["checked"] = selectedInterests.contains(interest["value"]);
                }
                setState(() {});
              },
            ),

            // Results Header
            Row(
              children: [
                Text(
                  "Suggested for you",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredUsers.length} people",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),

            // User List
            ...filteredUsers.map((user) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => _showUserProfile(user),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage("${user["image"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _showUserProfile(user),
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
                                if (user["isVerified"] as bool) ...[
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
                            SizedBox(height: spXs),
                            Text(
                              "${user["bio"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "${((user["followers"] as int) / 1000).toStringAsFixed(1)}K followers",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                if ((user["mutualFriends"] as int) > 0) ...[
                                  Text(" • ", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                                  Text(
                                    "${user["mutualFriends"]} mutual",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      label: (user["isFollowing"] as bool) ? "Following" : "Follow",
                      size: bs.sm,
                      onPressed: () => _toggleFollow(user["id"] as int),
                    ),
                  ],
                ),
              );
            }).toList(),

            if (filteredUsers.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No people found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search or filters",
                      textAlign: TextAlign.center,
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
    );
  }
}
