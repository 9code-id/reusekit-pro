import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSocial5View extends StatefulWidget {
  @override
  State<GrlSocial5View> createState() => _GrlSocial5ViewState();
}

class _GrlSocial5ViewState extends State<GrlSocial5View> {
  List<Map<String, dynamic>> trendingTopics = [
    {"topic": "#MondayMotivation", "posts": "2.4K posts"},
    {"topic": "#TechTalk", "posts": "15.7K posts"},
    {"topic": "#Foodie", "posts": "8.9K posts"},
    {"topic": "#Photography", "posts": "45.2K posts"},
    {"topic": "#Travel", "posts": "32.1K posts"},
  ];

  List<Map<String, dynamic>> suggestedUsers = [
    {
      "id": 1,
      "name": "Alex Rodriguez",
      "username": "@alex_rod",
      "avatar": "https://picsum.photos/60/60?random=20",
      "followers": "12.5K",
      "isFollowing": false,
      "bio": "Digital Artist & UI Designer",
    },
    {
      "id": 2,
      "name": "Maya Chen",
      "username": "@maya_designs",
      "avatar": "https://picsum.photos/60/60?random=21",
      "followers": "8.7K",
      "isFollowing": false,
      "bio": "Travel Blogger & Photographer",
    },
    {
      "id": 3,
      "name": "James Wilson",
      "username": "@james_code",
      "avatar": "https://picsum.photos/60/60?random=22",
      "followers": "25.3K",
      "isFollowing": true,
      "bio": "Software Engineer & Tech Enthusiast",
    },
    {
      "id": 4,
      "name": "Sophie Martin",
      "username": "@sophie_art",
      "avatar": "https://picsum.photos/60/60?random=23",
      "followers": "18.9K",
      "isFollowing": false,
      "bio": "Abstract Artist & Creative Director",
    },
  ];

  List<Map<String, dynamic>> recentActivity = [
    {
      "id": 1,
      "type": "like",
      "user": {"name": "Emma Stone", "avatar": "https://picsum.photos/40/40?random=30"},
      "action": "liked your photo",
      "timestamp": "2m ago",
      "postImage": "https://picsum.photos/50/50?random=40",
    },
    {
      "id": 2,
      "type": "follow",
      "user": {"name": "Ryan Gosling", "avatar": "https://picsum.photos/40/40?random=31"},
      "action": "started following you",
      "timestamp": "5m ago",
      "postImage": null,
    },
    {
      "id": 3,
      "type": "comment",
      "user": {"name": "Jennifer Lawrence", "avatar": "https://picsum.photos/40/40?random=32"},
      "action": "commented on your post",
      "timestamp": "10m ago",
      "postImage": "https://picsum.photos/50/50?random=41",
    },
    {
      "id": 4,
      "type": "like",
      "user": {"name": "Chris Evans", "avatar": "https://picsum.photos/40/40?random=33"},
      "action": "liked your story",
      "timestamp": "15m ago",
      "postImage": null,
    },
    {
      "id": 5,
      "type": "mention",
      "user": {"name": "Scarlett Johansson", "avatar": "https://picsum.photos/40/40?random=34"},
      "action": "mentioned you in a comment",
      "timestamp": "20m ago",
      "postImage": "https://picsum.photos/50/50?random=42",
    },
  ];

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Discover",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Icon(Icons.search, size: 24),
          SizedBox(width: spMd),
        ],
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: [
                _buildTabButton("Trending", 0),
                SizedBox(width: spMd),
                _buildTabButton("People", 1),
                SizedBox(width: spMd),
                _buildTabButton("Activity", 2),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Tab Content
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    final isSelected = selectedTab == index;
    return GestureDetector(
      onTap: () {
        selectedTab = index;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: isSelected ? primaryColor : disabledBoldColor,
            width: 1,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : disabledBoldColor,
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case 0:
        return _buildTrendingTab();
      case 1:
        return _buildPeopleTab();
      case 2:
        return _buildActivityTab();
      default:
        return _buildTrendingTab();
    }
  }

  Widget _buildTrendingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Trending Now",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          
          ...List.generate(trendingTopics.length, (index) {
            final topic = trendingTopics[index];
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.trending_up,
                      color: primaryColor,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${topic["topic"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${topic["posts"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: disabledBoldColor,
                    size: 20,
                  ),
                ],
              ),
            );
          }),
          
          SizedBox(height: spMd),
          
          Text(
            "Featured Content",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusLg),
              image: DecorationImage(
                image: NetworkImage("https://picsum.photos/400/200?random=50"),
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
                    Colors.black.withAlpha(180),
                  ],
                ),
              ),
              padding: EdgeInsets.all(spMd),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Photography Tips & Tricks",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Learn from the best photographers",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeopleTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Suggested for You",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          
          ...List.generate(suggestedUsers.length, (index) {
            final user = suggestedUsers[index];
            final isFollowing = user["isFollowing"] as bool;
            
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
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
                        Text(
                          "${user["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
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
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${user["followers"]} followers",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    label: isFollowing ? "Following" : "Follow",
                    size: bs.sm,
                    color: isFollowing ? disabledBoldColor : primaryColor,
                    onPressed: () {
                      suggestedUsers[index]["isFollowing"] = !isFollowing;
                      setState(() {});
                    },
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildActivityTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          
          ...List.generate(recentActivity.length, (index) {
            final activity = recentActivity[index];
            final user = activity["user"] as Map<String, dynamic>;
            final type = activity["type"] as String;
            final postImage = activity["postImage"];
            
            IconData activityIcon;
            Color activityColor;
            
            switch (type) {
              case "like":
                activityIcon = Icons.favorite;
                activityColor = dangerColor;
                break;
              case "follow":
                activityIcon = Icons.person_add;
                activityColor = primaryColor;
                break;
              case "comment":
                activityIcon = Icons.chat_bubble;
                activityColor = infoColor;
                break;
              case "mention":
                activityIcon = Icons.alternate_email;
                activityColor = warningColor;
                break;
              default:
                activityIcon = Icons.notifications;
                activityColor = primaryColor;
            }
            
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
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
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage("${user["avatar"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -2,
                        right: -2,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: activityColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(
                            activityIcon,
                            size: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                            children: [
                              TextSpan(
                                text: "${user["name"]} ",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: "${activity["action"]}",
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${activity["timestamp"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (postImage != null)
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        image: DecorationImage(
                          image: NetworkImage("$postImage"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
