import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFeed7View extends StatefulWidget {
  @override
  State<GrlFeed7View> createState() => _GrlFeed7ViewState();
}

class _GrlFeed7ViewState extends State<GrlFeed7View> {
  String searchQuery = "";
  String selectedCategory = "All";
  
  List<String> categories = ["All", "Photos", "Videos", "Articles", "People", "Groups"];
  
  List<Map<String, dynamic>> searchResults = [
    {
      "type": "user",
      "name": "Alexandra Smith",
      "username": "@alexandra_smith",
      "avatar": "https://picsum.photos/100/100?random=50&keyword=woman",
      "followers": 12500,
      "isFollowing": false,
      "verified": true,
      "bio": "Digital artist & UI/UX designer",
    },
    {
      "type": "post",
      "author": "Travel Blogger",
      "avatar": "https://picsum.photos/100/100?random=51&keyword=travel",
      "content": "Amazing sunset at Santorini! This place never fails to take my breath away. The colors of the sky were absolutely magical tonight. 🌅",
      "image": "https://picsum.photos/300/200?random=51&keyword=sunset",
      "likes": 856,
      "comments": 34,
      "time": "2 hours ago",
      "hashtags": ["#santorini", "#sunset", "#travel"]
    },
    {
      "type": "video",
      "author": "Fitness Coach",
      "avatar": "https://picsum.photos/100/100?random=52&keyword=fitness",
      "title": "10-Minute Morning Yoga Routine",
      "thumbnail": "https://picsum.photos/300/200?random=52&keyword=yoga",
      "duration": "10:32",
      "views": 45600,
      "likes": 2340,
      "time": "1 day ago",
    },
    {
      "type": "user",
      "name": "Tech Innovator",
      "username": "@tech_innovator",
      "avatar": "https://picsum.photos/100/100?random=53&keyword=tech",
      "followers": 89200,
      "isFollowing": true,
      "verified": true,
      "bio": "CEO at TechStartup | AI enthusiast",
    },
    {
      "type": "article",
      "title": "The Future of Artificial Intelligence in Healthcare",
      "author": "Dr. Sarah Johnson",
      "avatar": "https://picsum.photos/100/100?random=54&keyword=doctor",
      "image": "https://picsum.photos/300/200?random=54&keyword=medical",
      "readTime": "8 min read",
      "likes": 1240,
      "time": "3 days ago",
      "category": "Technology"
    },
    {
      "type": "group",
      "name": "Digital Marketing Professionals",
      "image": "https://picsum.photos/300/200?random=55&keyword=marketing",
      "members": 15600,
      "posts": 342,
      "description": "Community for digital marketing experts and enthusiasts",
      "isJoined": false,
    }
  ];

  List<Map<String, dynamic>> trendingTopics = [
    {"name": "#SustainableLiving", "posts": "12.5K"},
    {"name": "#TechInnovation", "posts": "8.9K"},
    {"name": "#MindfulMonday", "posts": "6.2K"},
    {"name": "#CreativeProcess", "posts": "4.8K"},
    {"name": "#HealthyLifestyle", "posts": "15.3K"},
  ];

  List<Map<String, dynamic>> suggestedUsers = [
    {
      "name": "Creative Designer",
      "username": "@creative_designer",
      "avatar": "https://picsum.photos/100/100?random=60&keyword=designer",
      "isFollowing": false,
    },
    {
      "name": "Food Blogger",
      "username": "@food_blogger",
      "avatar": "https://picsum.photos/100/100?random=61&keyword=food",
      "isFollowing": false,
    },
    {
      "name": "Photography Pro",
      "username": "@photography_pro",
      "avatar": "https://picsum.photos/100/100?random=62&keyword=camera",
      "isFollowing": false,
    },
  ];

  void _toggleFollow(String username) {
    setState(() {
      final userIndex = searchResults.indexWhere((item) => 
        item["type"] == "user" && item["username"] == username);
      if (userIndex != -1) {
        searchResults[userIndex]["isFollowing"] = !searchResults[userIndex]["isFollowing"];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Search posts, people, topics...",
                        prefixIcon: Icon(Icons.search, color: disabledBoldColor),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    Icons.tune,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Category Filter
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : disabledBoldColor,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          Expanded(
            child: searchQuery.isEmpty
                ? _buildDiscoverContent()
                : _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscoverContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Trending Topics
          Text(
            "Trending Topics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: trendingTopics.map((topic) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: spSm),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${topic["name"]}",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
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
                );
              }).toList(),
            ),
          ),
          
          SizedBox(height: spLg),
          
          // Suggested Users
          Text(
            "Suggested for You",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Container(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: suggestedUsers.length,
              itemBuilder: (context, index) {
                final user = suggestedUsers[index];
                return Container(
                  width: 120,
                  margin: EdgeInsets.only(right: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusLg),
                          image: DecorationImage(
                            image: NetworkImage("${user["avatar"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${user["name"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: spXs),
                      QButton(
                        label: "Follow",
                        size: bs.sm,
                        onPressed: () {
                          //followUser
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final result = searchResults[index];
        final type = result["type"];
        
        if (type == "user") {
          return _buildUserResult(result);
        } else if (type == "post") {
          return _buildPostResult(result);
        } else if (type == "video") {
          return _buildVideoResult(result);
        } else if (type == "article") {
          return _buildArticleResult(result);
        } else if (type == "group") {
          return _buildGroupResult(result);
        }
        
        return Container();
      },
    );
  }

  Widget _buildUserResult(Map<String, dynamic> user) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusLg),
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
                    if (user["verified"] == true)
                      Container(
                        margin: EdgeInsets.only(left: spXs),
                        child: Icon(
                          Icons.verified,
                          color: primaryColor,
                          size: 16,
                        ),
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
                if (user["bio"] != null)
                  Text(
                    "${user["bio"]}",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                Text(
                  "${((user["followers"] as int) / 1000).toStringAsFixed(1)}K followers",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: user["isFollowing"] ? "Following" : "Follow",
            size: bs.sm,
            onPressed: () => _toggleFollow(user["username"]),
          ),
        ],
      ),
    );
  }

  Widget _buildPostResult(Map<String, dynamic> post) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusLg),
                  image: DecorationImage(
                    image: NetworkImage("${post["avatar"]}"),
                    fit: BoxFit.cover,
                  ),
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
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
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
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${post["content"]}",
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              height: 1.4,
            ),
          ),
          if (post["image"] != null)
            Container(
              margin: EdgeInsets.symmetric(vertical: spSm),
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusSm),
                image: DecorationImage(
                  image: NetworkImage("${post["image"]}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          Row(
            children: [
              Icon(Icons.favorite_border, size: 18, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text("${post["likes"]}", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
              SizedBox(width: spMd),
              Icon(Icons.chat_bubble_outline, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text("${post["comments"]}", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVideoResult(Map<String, dynamic> video) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 100,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${video["thumbnail"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(100),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 4,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${video["duration"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
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
                Text(
                  "${video["title"]}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spXs),
                Text(
                  "${video["author"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${((video["views"] as int) / 1000).toStringAsFixed(1)}K views",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "•",
                      style: TextStyle(color: disabledBoldColor),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${video["time"]}",
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
        ],
      ),
    );
  }

  Widget _buildArticleResult(Map<String, dynamic> article) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
              image: DecorationImage(
                image: NetworkImage("${article["image"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${article["title"]}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spXs),
                Text(
                  "${article["author"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${article["readTime"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "•",
                      style: TextStyle(color: disabledBoldColor),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${article["category"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupResult(Map<String, dynamic> group) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
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
              borderRadius: BorderRadius.circular(radiusSm),
              image: DecorationImage(
                image: NetworkImage("${group["image"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${group["name"]}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${group["description"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spXs),
                Text(
                  "${((group["members"] as int) / 1000).toStringAsFixed(1)}K members • ${group["posts"]} posts",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            label: group["isJoined"] ? "Joined" : "Join",
            size: bs.sm,
            onPressed: () {
              //joinGroup
            },
          ),
        ],
      ),
    );
  }
}
