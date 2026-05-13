import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFeed4View extends StatefulWidget {
  @override
  State<GrlFeed4View> createState() => _GrlFeed4ViewState();
}

class _GrlFeed4ViewState extends State<GrlFeed4View> {
  bool loading = false;
  String searchQuery = "";
  String selectedCategory = "All";
  List<String> likedPosts = [];
  List<String> followedUsers = [];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Food", "value": "Food"},
    {"label": "Travel", "value": "Travel"},
    {"label": "Fashion", "value": "Fashion"},
    {"label": "Sports", "value": "Sports"},
    {"label": "Music", "value": "Music"},
  ];

  List<Map<String, dynamic>> feedPosts = [
    {
      "id": "1",
      "user": {
        "name": "Alex Johnson",
        "username": "@alexj",
        "avatar": "https://picsum.photos/50/50?random=1&keyword=person",
        "verified": true,
        "followers": 15200,
      },
      "content": "Just launched my new tech startup! Excited to share this journey with everyone. The possibilities are endless when you combine passion with innovation. 🚀",
      "images": [
        "https://picsum.photos/400/300?random=10&keyword=technology",
        "https://picsum.photos/400/300?random=11&keyword=startup",
      ],
      "timestamp": DateTime.now().subtract(Duration(hours: 2)),
      "likes": 234,
      "comments": 45,
      "shares": 12,
      "category": "Technology",
      "location": "San Francisco, CA",
    },
    {
      "id": "2",
      "user": {
        "name": "Maria Santos",
        "username": "@mariafood",
        "avatar": "https://picsum.photos/50/50?random=2&keyword=chef",
        "verified": false,
        "followers": 8900,
      },
      "content": "Homemade pasta night! Fresh ingredients make all the difference. Recipe in my stories 👨‍🍳",
      "images": [
        "https://picsum.photos/400/300?random=12&keyword=pasta",
      ],
      "timestamp": DateTime.now().subtract(Duration(hours: 4)),
      "likes": 189,
      "comments": 28,
      "shares": 7,
      "category": "Food",
      "location": "Rome, Italy",
    },
    {
      "id": "3",
      "user": {
        "name": "David Chen",
        "username": "@travelwithd",
        "avatar": "https://picsum.photos/50/50?random=3&keyword=traveler",
        "verified": true,
        "followers": 22100,
      },
      "content": "Sunset from Mount Fuji never gets old. Nature's masterpiece painted across the sky 🌅",
      "images": [
        "https://picsum.photos/400/300?random=13&keyword=mountain",
        "https://picsum.photos/400/300?random=14&keyword=sunset",
        "https://picsum.photos/400/300?random=15&keyword=japan",
      ],
      "timestamp": DateTime.now().subtract(Duration(hours: 6)),
      "likes": 567,
      "comments": 89,
      "shares": 34,
      "category": "Travel",
      "location": "Mount Fuji, Japan",
    },
    {
      "id": "4",
      "user": {
        "name": "Sophie Williams",
        "username": "@sophiestyle",
        "avatar": "https://picsum.photos/50/50?random=4&keyword=fashion",
        "verified": false,
        "followers": 12400,
      },
      "content": "Vintage finds from today's thrift shopping adventure. Sustainable fashion is the future! ♻️",
      "images": [
        "https://picsum.photos/400/300?random=16&keyword=fashion",
      ],
      "timestamp": DateTime.now().subtract(Duration(hours: 8)),
      "likes": 298,
      "comments": 52,
      "shares": 18,
      "category": "Fashion",
      "location": "Brooklyn, NY",
    },
    {
      "id": "5",
      "user": {
        "name": "Ryan Cooper",
        "username": "@ryanfit",
        "avatar": "https://picsum.photos/50/50?random=5&keyword=athlete",
        "verified": true,
        "followers": 45600,
      },
      "content": "Early morning workout complete! The best way to start the day is with endorphins and determination 💪",
      "images": [
        "https://picsum.photos/400/300?random=17&keyword=gym",
        "https://picsum.photos/400/300?random=18&keyword=fitness",
      ],
      "timestamp": DateTime.now().subtract(Duration(hours: 10)),
      "likes": 445,
      "comments": 67,
      "shares": 23,
      "category": "Sports",
      "location": "Los Angeles, CA",
    },
  ];

  List<Map<String, dynamic>> get filteredPosts {
    List<Map<String, dynamic>> filtered = feedPosts;
    
    if (selectedCategory != "All") {
      filtered = filtered.where((post) => post["category"] == selectedCategory).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((post) {
        final content = post["content"].toString().toLowerCase();
        final username = post["user"]["username"].toString().toLowerCase();
        final name = post["user"]["name"].toString().toLowerCase();
        final query = searchQuery.toLowerCase();
        return content.contains(query) || username.contains(query) || name.contains(query);
      }).toList();
    }
    
    return filtered;
  }

  void toggleLike(String postId) {
    if (likedPosts.contains(postId)) {
      likedPosts.remove(postId);
    } else {
      likedPosts.add(postId);
    }
    setState(() {});
  }

  void toggleFollow(String username) {
    if (followedUsers.contains(username)) {
      followedUsers.remove(username);
    } else {
      followedUsers.add(username);
    }
    setState(() {});
  }

  Widget _buildPost(Map<String, dynamic> post) {
    final user = post["user"] as Map<String, dynamic>;
    final images = post["images"] as List<dynamic>;
    final isLiked = likedPosts.contains(post["id"]);
    final isFollowed = followedUsers.contains(user["username"]);

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Header
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
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
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          if (user["verified"] == true) ...[
                            SizedBox(width: spXs),
                            Icon(
                              Icons.verified,
                              size: 16,
                              color: primaryColor,
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            "${user["username"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            " • ${((user["followers"] as int) / 1000).toStringAsFixed(1)}K followers",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: isFollowed ? "Following" : "Follow",
                  size: bs.sm,
                  color: isFollowed ? disabledBoldColor : primaryColor,
                  onPressed: () => toggleFollow(user["username"]),
                ),
              ],
            ),
          ),

          // Post Content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Text(
              "${post["content"]}",
              style: TextStyle(
                fontSize: 15,
                color: primaryColor,
                height: 1.4,
              ),
            ),
          ),

          SizedBox(height: spSm),

          // Images
          if (images.isNotEmpty) ...[
            Container(
              height: 250,
              child: QHorizontalScroll(
                children: images.map((image) {
                  return Container(
                    width: 300,
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusLg),
                      image: DecorationImage(
                        image: NetworkImage("$image"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: spSm),
          ],

          // Post Metadata
          Padding(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${post["category"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Icon(
                  Icons.location_on,
                  size: 14,
                  color: disabledColor,
                ),
                Text(
                  "${post["location"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${(post["timestamp"] as DateTime).dMMMy}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spSm),

          // Action Buttons
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => toggleLike(post["id"]),
                        child: Row(
                          children: [
                            Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              color: isLiked ? dangerColor : disabledBoldColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${post["likes"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spMd),
                      Row(
                        children: [
                          Icon(
                            Icons.comment_outlined,
                            color: disabledBoldColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${post["comments"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: spMd),
                      Row(
                        children: [
                          Icon(
                            Icons.share_outlined,
                            color: disabledBoldColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${post["shares"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.bookmark_border,
                  color: disabledBoldColor,
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Social Feed"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: () {
              // Navigate to notifications
            },
          ),
          IconButton(
            icon: Icon(Icons.chat_outlined),
            onPressed: () {
              // Navigate to messages
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: disabledBoldColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Search posts, users...",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: disabledColor,
                                    fontSize: 14,
                                  ),
                                ),
                                onChanged: (value) {
                                  searchQuery = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.tune,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {
                          // Show filter options
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                QCategoryPicker(
                  items: categories,
                  value: selectedCategory,
                  onChanged: (index, label, value, item) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Feed Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  if (filteredPosts.isEmpty) ...[
                    Container(
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spMd),
                          Text(
                            "No posts found",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Try adjusting your search or filters",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    ...filteredPosts.map((post) => _buildPost(post)).toList(),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create post
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
