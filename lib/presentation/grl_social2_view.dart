import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSocial2View extends StatefulWidget {
  @override
  State<GrlSocial2View> createState() => _GrlSocial2ViewState();
}

class _GrlSocial2ViewState extends State<GrlSocial2View> {
  String searchQuery = "";
  String selectedCategory = "all";
  
  List<Map<String, dynamic>> users = [
    {
      "id": "1",
      "name": "Alex Thompson",
      "username": "@alexthompson",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=person",
      "bio": "Travel photographer | Coffee enthusiast | Always exploring new places ✈️📸",
      "followers": 15420,
      "following": 892,
      "posts": 234,
      "verified": true,
      "isFollowing": false,
      "mutualFollowers": 12,
      "category": "photography",
      "isOnline": true,
      "location": "New York, USA"
    },
    {
      "id": "2",
      "name": "Maya Patel",
      "username": "@mayacooks",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=woman",
      "bio": "Chef & Food blogger | Sharing delicious recipes daily 👩‍🍳🍽️",
      "followers": 28750,
      "following": 543,
      "posts": 456,
      "verified": true,
      "isFollowing": true,
      "mutualFollowers": 8,
      "category": "food",
      "isOnline": false,
      "location": "Mumbai, India"
    },
    {
      "id": "3",
      "name": "James Wilson",
      "username": "@jameswilson",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=man",
      "bio": "Tech entrepreneur | Building the future one app at a time 💻🚀",
      "followers": 45230,
      "following": 1200,
      "posts": 89,
      "verified": true,
      "isFollowing": false,
      "mutualFollowers": 23,
      "category": "tech",
      "isOnline": true,
      "location": "San Francisco, USA"
    },
    {
      "id": "4",
      "name": "Sophie Martinez",
      "username": "@sophieart",
      "avatar": "https://picsum.photos/100/100?random=4&keyword=woman",
      "bio": "Digital artist & illustrator | Commission work available 🎨✨",
      "followers": 8920,
      "following": 2100,
      "posts": 567,
      "verified": false,
      "isFollowing": false,
      "mutualFollowers": 5,
      "category": "art",
      "isOnline": true,
      "location": "Barcelona, Spain"
    },
    {
      "id": "5",
      "name": "Ryan Foster",
      "username": "@ryanfitness",
      "avatar": "https://picsum.photos/100/100?random=5&keyword=man",
      "bio": "Personal trainer | Helping you achieve your fitness goals 💪🏋️‍♂️",
      "followers": 12580,
      "following": 654,
      "posts": 345,
      "verified": false,
      "isFollowing": true,
      "mutualFollowers": 15,
      "category": "fitness",
      "isOnline": false,
      "location": "Los Angeles, USA"
    },
    {
      "id": "6",
      "name": "Luna Chen",
      "username": "@lunawrites",
      "avatar": "https://picsum.photos/100/100?random=6&keyword=woman",
      "bio": "Author & blogger | Sharing stories that inspire ✍️📚",
      "followers": 6750,
      "following": 1890,
      "posts": 278,
      "verified": false,
      "isFollowing": false,
      "mutualFollowers": 3,
      "category": "writing",
      "isOnline": true,
      "location": "Tokyo, Japan"
    }
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "all", "icon": Icons.group},
    {"label": "Photography", "value": "photography", "icon": Icons.camera_alt},
    {"label": "Food", "value": "food", "icon": Icons.restaurant},
    {"label": "Technology", "value": "tech", "icon": Icons.computer},
    {"label": "Art", "value": "art", "icon": Icons.palette},
    {"label": "Fitness", "value": "fitness", "icon": Icons.fitness_center},
    {"label": "Writing", "value": "writing", "icon": Icons.edit},
  ];

  List<Map<String, dynamic>> suggestedUsers = [
    {
      "id": "s1",
      "name": "Emma Davis",
      "username": "@emmadavis",
      "avatar": "https://picsum.photos/100/100?random=7&keyword=woman",
      "mutualFollowers": 18,
      "isFollowing": false,
      "category": "lifestyle"
    },
    {
      "id": "s2", 
      "name": "Mike Johnson",
      "username": "@mikejohnson",
      "avatar": "https://picsum.photos/100/100?random=8&keyword=man",
      "mutualFollowers": 7,
      "isFollowing": false,
      "category": "music"
    },
    {
      "id": "s3",
      "name": "Sara Kim",
      "username": "@sarakim",
      "avatar": "https://picsum.photos/100/100?random=9&keyword=woman",
      "mutualFollowers": 11,
      "isFollowing": false,
      "category": "fashion"
    }
  ];

  void _toggleFollow(String userId) {
    int index = users.indexWhere((user) => user["id"] == userId);
    if (index != -1) {
      bool isFollowing = users[index]["isFollowing"] as bool;
      users[index]["isFollowing"] = !isFollowing;
      users[index]["followers"] = (users[index]["followers"] as int) + (isFollowing ? -1 : 1);
      setState(() {});
      
      if (!isFollowing) {
        ss("You are now following ${users[index]["name"]}");
      }
    }
  }

  void _followSuggested(String userId) {
    int index = suggestedUsers.indexWhere((user) => user["id"] == userId);
    if (index != -1) {
      suggestedUsers[index]["isFollowing"] = true;
      setState(() {});
      ss("You are now following ${suggestedUsers[index]["name"]}");
    }
  }

  List<Map<String, dynamic>> _getFilteredUsers() {
    List<Map<String, dynamic>> filtered = List.from(users);
    
    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((user) {
        return user["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               user["username"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               user["bio"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    // Filter by category
    if (selectedCategory != "all") {
      filtered = filtered.where((user) => user["category"] == selectedCategory).toList();
    }
    
    return filtered;
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return "${(count / 1000000).toStringAsFixed(1)}M";
    } else if (count >= 1000) {
      return "${(count / 1000).toStringAsFixed(1)}K";
    } else {
      return count.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredUsers = _getFilteredUsers();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Discover People"),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Find People",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search users...",
                          value: searchQuery,
                          hint: "Search by name, username, or bio",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.clear,
                        size: bs.sm,
                        onPressed: () {
                          searchQuery = "";
                          selectedCategory = "all";
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Category Filter
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Browse by Category",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QHorizontalScroll(
                    children: categories.map((category) {
                      bool isSelected = selectedCategory == category["value"];
                      return GestureDetector(
                        onTap: () {
                          selectedCategory = "${category["value"]}";
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: spSm),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledBoldColor,
                            ),
                          ),
                          child: Column(
                            spacing: spXs,
                            children: [
                              Icon(
                                category["icon"] as IconData,
                                color: isSelected ? Colors.white : disabledBoldColor,
                                size: 20,
                              ),
                              Text(
                                "${category["label"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isSelected ? Colors.white : disabledBoldColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Suggested for You
            if (searchQuery.isEmpty && selectedCategory == "all")
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Suggested for You",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ...suggestedUsers.map((user) {
                      bool isFollowing = user["isFollowing"] as bool;
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage("${user["avatar"]}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "${user["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${user["username"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "Followed by ${user["mutualFollowers"]} friends",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            QButton(
                              label: isFollowing ? "Following" : "Follow",
                              size: bs.sm,
                              onPressed: isFollowing ? null : () => _followSuggested("${user["id"]}"),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),

            // People Results
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          filteredUsers.isEmpty ? "No people found" : "People",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "${filteredUsers.length} users",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  if (filteredUsers.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        spacing: spSm,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 48,
                            color: disabledBoldColor,
                          ),
                          Text(
                            "No users match your search",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...filteredUsers.map((user) {
                      bool isFollowing = user["isFollowing"] as bool;
                      bool isVerified = user["verified"] as bool;
                      bool isOnline = user["isOnline"] as bool;
                      
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: primaryColor.withAlpha(20)),
                        ),
                        child: Column(
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: 55,
                                      height: 55,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: NetworkImage("${user["avatar"]}"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    if (isOnline)
                                      Positioned(
                                        bottom: 2,
                                        right: 2,
                                        child: Container(
                                          width: 14,
                                          height: 14,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: successColor,
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
                                    spacing: spXs,
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
                                          if (isVerified) ...[
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
                                        "${user["username"]}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      if (user["location"].toString().isNotEmpty)
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 12,
                                              color: disabledBoldColor,
                                            ),
                                            SizedBox(width: 2),
                                            Text(
                                              "${user["location"]}",
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
                                QButton(
                                  label: isFollowing ? "Following" : "Follow",
                                  size: bs.sm,
                                  onPressed: () => _toggleFollow("${user["id"]}"),
                                ),
                              ],
                            ),
                            
                            // Bio
                            if (user["bio"].toString().isNotEmpty)
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${user["bio"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: primaryColor,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                            
                            // Stats
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    spacing: spXs,
                                    children: [
                                      Text(
                                        _formatCount(user["posts"] as int),
                                        style: TextStyle(
                                          fontSize: 16,
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
                                Container(
                                  width: 1,
                                  height: 30,
                                  color: disabledColor,
                                ),
                                Expanded(
                                  child: Column(
                                    spacing: spXs,
                                    children: [
                                      Text(
                                        _formatCount(user["followers"] as int),
                                        style: TextStyle(
                                          fontSize: 16,
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
                                Container(
                                  width: 1,
                                  height: 30,
                                  color: disabledColor,
                                ),
                                Expanded(
                                  child: Column(
                                    spacing: spXs,
                                    children: [
                                      Text(
                                        _formatCount(user["following"] as int),
                                        style: TextStyle(
                                          fontSize: 16,
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
                              ],
                            ),
                            
                            // Mutual followers
                            if ((user["mutualFollowers"] as int) > 0)
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "Followed by ${user["mutualFollowers"]} people you follow",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: infoColor,
                                  ),
                                ),
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
                                  icon: Icons.message,
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.more_vert,
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
