import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFeed10View extends StatefulWidget {
  @override
  State<GrlFeed10View> createState() => _GrlFeed10ViewState();
}

class _GrlFeed10ViewState extends State<GrlFeed10View> {
  int currentIndex = 0;
  
  List<Map<String, dynamic>> featuredStories = [
    {
      "id": 1,
      "title": "Morning Inspiration",
      "author": "Daily Motivation",
      "image": "https://picsum.photos/400/600?random=130&keyword=motivation",
      "gradient": ["#FF6B6B", "#4ECDC4"],
      "text": "Success is not final, failure is not fatal: it is the courage to continue that counts."
    },
    {
      "id": 2,
      "title": "Travel Diary",
      "author": "Adventure Seeker",
      "image": "https://picsum.photos/400/600?random=131&keyword=travel",
      "gradient": ["#667eea", "#764ba2"],
      "text": "Currently exploring the beautiful streets of Paris! The architecture here is absolutely stunning."
    },
    {
      "id": 3,
      "title": "Cooking Tips",
      "author": "Chef's Corner",
      "image": "https://picsum.photos/400/600?random=132&keyword=cooking",
      "gradient": ["#f093fb", "#f5576c"],
      "text": "Pro tip: Always let your steak rest for 5 minutes before serving. It makes all the difference!"
    }
  ];

  List<Map<String, dynamic>> quickUpdates = [
    {
      "id": 1,
      "author": "Weather Updates",
      "avatar": "https://picsum.photos/100/100?random=140&keyword=weather",
      "time": "5 min ago",
      "update": "Sunny skies ahead! Perfect day for outdoor activities ☀️",
      "temperature": "24°C",
      "location": "New York",
      "type": "weather"
    },
    {
      "id": 2,
      "author": "Stock Market",
      "avatar": "https://picsum.photos/100/100?random=141&keyword=stocks",
      "time": "15 min ago",
      "update": "Tech stocks are trending upward today 📈",
      "change": "+2.5%",
      "value": "\$142.50",
      "type": "stocks"
    },
    {
      "id": 3,
      "author": "News Flash",
      "avatar": "https://picsum.photos/100/100?random=142&keyword=news",
      "time": "30 min ago",
      "update": "Breaking: New sustainable energy project announced",
      "category": "Environment",
      "type": "news"
    }
  ];

  List<Map<String, dynamic>> socialPosts = [
    {
      "id": 1,
      "author": "Fitness Influencer",
      "username": "@fitnessguru",
      "avatar": "https://picsum.photos/100/100?random=150&keyword=fitness",
      "time": "1 hour ago",
      "content": "Just finished an amazing morning workout! Remember, consistency is key to achieving your fitness goals. What's your workout plan today? 💪",
      "image": "https://picsum.photos/400/300?random=150&keyword=gym",
      "likes": 2450,
      "comments": 89,
      "shares": 23,
      "isLiked": true,
      "metrics": {
        "engagement": "High",
        "reach": "12.5K"
      }
    },
    {
      "id": 2,
      "author": "Food Blogger",
      "username": "@foodieadventures",
      "avatar": "https://picsum.photos/100/100?random=151&keyword=food",
      "time": "2 hours ago",
      "content": "Tried this amazing new restaurant in downtown! The flavors were incredible and the presentation was stunning. Highly recommend their signature pasta dish! 🍝✨",
      "images": [
        "https://picsum.photos/400/300?random=151&keyword=pasta",
        "https://picsum.photos/400/300?random=152&keyword=restaurant"
      ],
      "likes": 1890,
      "comments": 156,
      "shares": 67,
      "isLiked": false,
      "metrics": {
        "engagement": "Medium",
        "reach": "8.9K"
      }
    },
    {
      "id": 3,
      "author": "Tech Innovator",
      "username": "@techinnovator",
      "avatar": "https://picsum.photos/100/100?random=153&keyword=tech",
      "time": "4 hours ago",
      "content": "Excited to share our latest AI breakthrough! This technology will revolutionize how we interact with smart devices. Beta testing starts next week! 🚀",
      "likes": 5670,
      "comments": 234,
      "shares": 145,
      "isLiked": true,
      "verified": true,
      "metrics": {
        "engagement": "Very High",
        "reach": "25.3K"
      }
    }
  ];

  void _toggleLike(int postId) {
    setState(() {
      final postIndex = socialPosts.indexWhere((post) => post["id"] == postId);
      if (postIndex != -1) {
        socialPosts[postIndex]["isLiked"] = !socialPosts[postIndex]["isLiked"];
        if (socialPosts[postIndex]["isLiked"]) {
          socialPosts[postIndex]["likes"]++;
        } else {
          socialPosts[postIndex]["likes"]--;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return QBottomBar(
      title: "Feed Hub",
      selectedIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: "Explore",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: "Updates",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
      children: [
        _buildHomeTab(),
        _buildExploreTab(),
        _buildUpdatesTab(),
        _buildProfileTab(),
      ],
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
    );
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Featured Stories
          Text(
            "Featured Stories",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Container(
            height: 200,
            child: QHorizontalScroll(
              children: featuredStories.map((story) {
                return GestureDetector(
                  onTap: () {
                    //navigateTo('StoryDetailView')
                  },
                  child: Container(
                    width: 150,
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusLg),
                            image: DecorationImage(
                              image: NetworkImage("${story["image"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusLg),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withAlpha(150),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: spSm,
                          left: spSm,
                          right: spSm,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${story["title"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${story["author"]}",
                                style: TextStyle(
                                  color: Colors.white.withAlpha(200),
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
          SizedBox(height: spLg),
          
          // Social Posts
          Text(
            "Recent Posts",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          ...socialPosts.map((post) {
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
                  // Post Header
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Row(
                      children: [
                        Container(
                          width: 45,
                          height: 45,
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
                              Row(
                                children: [
                                  Text(
                                    "${post["author"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  if (post["verified"] == true)
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
                                "${post["username"]} • ${post["time"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () {
                            //showPostOptions
                          },
                        ),
                      ],
                    ),
                  ),
                  
                  // Post Content
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: spSm),
                    child: Text(
                      "${post["content"]}",
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.4,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  // Post Images
                  if (post["image"] != null)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: spSm),
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        image: DecorationImage(
                          image: NetworkImage("${post["image"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  
                  if (post["images"] != null)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: spSm),
                      height: 180,
                      child: QHorizontalScroll(
                        children: (post["images"] as List).map((image) {
                          return Container(
                            width: 200,
                            margin: EdgeInsets.only(right: spSm),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusSm),
                              image: DecorationImage(
                                image: NetworkImage("$image"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  
                  // Metrics
                  if (post["metrics"] != null)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "Reach: ${post["metrics"]["reach"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${post["metrics"]["engagement"]} Engagement",
                              style: TextStyle(
                                fontSize: 10,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  // Action Bar
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Row(
                      children: [
                        // Like
                        GestureDetector(
                          onTap: () => _toggleLike(post["id"]),
                          child: Row(
                            children: [
                              Icon(
                                post["isLiked"] ? Icons.favorite : Icons.favorite_border,
                                color: post["isLiked"] ? dangerColor : disabledBoldColor,
                                size: 22,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${post["likes"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spMd),
                        
                        // Comment
                        GestureDetector(
                          onTap: () {
                            //navigateTo('CommentsView')
                          },
                          child: Row(
                            children: [
                              Icon(Icons.chat_bubble_outline, color: disabledBoldColor, size: 20),
                              SizedBox(width: spXs),
                              Text(
                                "${post["comments"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spMd),
                        
                        // Share
                        GestureDetector(
                          onTap: () {
                            //sharePost
                          },
                          child: Row(
                            children: [
                              Icon(Icons.share, color: disabledBoldColor, size: 20),
                              SizedBox(width: spXs),
                              Text(
                                "${post["shares"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        Spacer(),
                        
                        // Analytics
                        GestureDetector(
                          onTap: () {
                            //navigateTo('PostAnalyticsView')
                          },
                          child: Icon(
                            Icons.analytics,
                            color: disabledBoldColor,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildExploreTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Explore Content",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: List.generate(6, (index) {
              return Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  image: DecorationImage(
                    image: NetworkImage("https://picsum.photos/200/150?random=${160 + index}&keyword=explore"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusLg),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withAlpha(150),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Explore Topic ${index + 1}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${(index + 1) * 50}K posts",
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildUpdatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Updates",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          ...quickUpdates.map((update) {
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
                        image: NetworkImage("${update["avatar"]}"),
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
                          "${update["author"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${update["update"]}",
                          style: TextStyle(
                            fontSize: 13,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${update["time"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (update["type"] == "weather")
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "${update["temperature"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
                            ),
                          ),
                          Text(
                            "${update["location"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (update["type"] == "stocks")
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "${update["change"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "${update["value"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (update["type"] == "news")
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${update["category"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Profile Header
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusXl),
              image: DecorationImage(
                image: NetworkImage("https://picsum.photos/200/200?random=170&keyword=profile"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: spSm),
          
          Text(
            "John Doe",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "@johndoe",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Text(
            "Content creator, photographer, and digital nomad. Sharing my journey around the world! 📸✈️",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              height: 1.4,
            ),
          ),
          SizedBox(height: spMd),
          
          // Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "1,234",
                    style: TextStyle(
                      fontSize: 18,
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
              Column(
                children: [
                  Text(
                    "56.7K",
                    style: TextStyle(
                      fontSize: 18,
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
              Column(
                children: [
                  Text(
                    "892",
                    style: TextStyle(
                      fontSize: 18,
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
            ],
          ),
          SizedBox(height: spMd),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Edit Profile",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('EditProfileView')
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Share Profile",
                  size: bs.sm,
                  onPressed: () {
                    //shareProfile
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
