import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFollow1View extends StatefulWidget {
  @override
  State<GrlFollow1View> createState() => _GrlFollow1ViewState();
}

class _GrlFollow1ViewState extends State<GrlFollow1View> {
  String searchQuery = "";
  String selectedCategory = "all";
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "all"},
    {"label": "Following", "value": "following"},
    {"label": "Followers", "value": "followers"},
    {"label": "Suggested", "value": "suggested"},
  ];

  List<Map<String, dynamic>> users = [
    {
      "id": 1,
      "name": "Sarah Johnson",
      "username": "@sarah_j",
      "avatar": "https://picsum.photos/60/60?random=1&keyword=woman",
      "bio": "Digital artist & designer",
      "followers": 1234,
      "following": 567,
      "posts": 89,
      "isFollowing": true,
      "isVerified": true,
      "category": "following"
    },
    {
      "id": 2,
      "name": "Mike Chen",
      "username": "@mike_dev",
      "avatar": "https://picsum.photos/60/60?random=2&keyword=man",
      "bio": "Full-stack developer",
      "followers": 2345,
      "following": 890,
      "posts": 156,
      "isFollowing": false,
      "isVerified": false,
      "category": "suggested"
    },
    {
      "id": 3,
      "name": "Lisa Wang",
      "username": "@lisa_photo",
      "avatar": "https://picsum.photos/60/60?random=3&keyword=woman",
      "bio": "Professional photographer",
      "followers": 5678,
      "following": 234,
      "posts": 234,
      "isFollowing": true,
      "isVerified": true,
      "category": "following"
    },
    {
      "id": 4,
      "name": "Alex Rodriguez",
      "username": "@alex_fit",
      "avatar": "https://picsum.photos/60/60?random=4&keyword=fitness",
      "bio": "Fitness coach & nutritionist",
      "followers": 3456,
      "following": 456,
      "posts": 567,
      "isFollowing": false,
      "isVerified": false,
      "category": "suggested"
    },
    {
      "id": 5,
      "name": "Emma Thompson",
      "username": "@emma_writes",
      "avatar": "https://picsum.photos/60/60?random=5&keyword=writer",
      "bio": "Content writer & blogger",
      "followers": 987,
      "following": 345,
      "posts": 123,
      "isFollowing": true,
      "isVerified": false,
      "category": "followers"
    },
  ];

  List<Map<String, dynamic>> get filteredUsers {
    var filtered = users.where((user) {
      bool matchesSearch = searchQuery.isEmpty ||
          (user["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (user["username"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (user["bio"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "all" || user["category"] == selectedCategory;
      
      return matchesSearch && matchesCategory;
    }).toList();
    
    return filtered;
  }

  void _toggleFollow(int userId) {
    int index = users.indexWhere((user) => user["id"] == userId);
    if (index != -1) {
      users[index]["isFollowing"] = !users[index]["isFollowing"];
      
      if (users[index]["isFollowing"]) {
        users[index]["followers"] = (users[index]["followers"] as int) + 1;
        ss("Following ${users[index]["name"]}");
      } else {
        users[index]["followers"] = (users[index]["followers"] as int) - 1;
        si("Unfollowed ${users[index]["name"]}");
      }
      setState(() {});
    }
  }

  Widget _buildUserCard(Map<String, dynamic> user) {
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage("${user["avatar"]}"),
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
                    Expanded(
                      child: Text(
                        "${user["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    if (user["isVerified"] as bool)
                      Icon(
                        Icons.verified,
                        color: primaryColor,
                        size: 16,
                      ),
                  ],
                ),
                SizedBox(height: spXs),
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
                    color: disabledColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    _buildStatItem("Posts", user["posts"] as int),
                    SizedBox(width: spMd),
                    _buildStatItem("Followers", user["followers"] as int),
                    SizedBox(width: spMd),
                    _buildStatItem("Following", user["following"] as int),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: spMd),
          QButton(
            label: (user["isFollowing"] as bool) ? "Following" : "Follow",
            size: bs.sm,
            color: (user["isFollowing"] as bool) ? disabledBoldColor : primaryColor,
            onPressed: () => _toggleFollow(user["id"] as int),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, int value) {
    return Column(
      children: [
        Text(
          "${value}",
          style: TextStyle(
            fontSize: 14,
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

  Widget _buildStatsHeader() {
    int totalFollowing = users.where((user) => user["category"] == "following").length;
    int totalFollowers = users.where((user) => user["category"] == "followers").length;
    int totalSuggested = users.where((user) => user["category"] == "suggested").length;

    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard("Following", totalFollowing, primaryColor),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: _buildStatCard("Followers", totalFollowers, successColor),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: _buildStatCard("Suggested", totalSuggested, infoColor),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, int value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Text(
            "$value",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Follow People"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsHeader(),
            
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search users",
                    value: searchQuery,
                    hint: "Search by name, username, or bio",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            QCategoryPicker(
              items: categories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            Text(
              "People (${filteredUsers.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            if (filteredUsers.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXl),
                child: Column(
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No users found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search or category filter",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredUsers.map((user) => _buildUserCard(user)).toList(),
          ],
        ),
      ),
    );
  }
}
