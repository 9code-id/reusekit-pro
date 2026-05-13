import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaHomeFeedView extends StatefulWidget {
  const SmaHomeFeedView({super.key});

  @override
  State<SmaHomeFeedView> createState() => _SmaHomeFeedViewState();
}

class _SmaHomeFeedViewState extends State<SmaHomeFeedView> {
  int currentIndex = 0;
  String newPostText = "";
  
  List<Map<String, dynamic>> feedPosts = [
    {
      "id": "1",
      "author": {
        "name": "Sarah Johnson",
        "avatar": "https://picsum.photos/60/60?random=1&keyword=person",
        "verified": true,
      },
      "timestamp": "2 hours ago",
      "content": "Just finished an amazing hiking trip in the mountains! The view was absolutely breathtaking. Nature never fails to inspire me. 🏔️ #hiking #nature #adventure",
      "images": [
        "https://picsum.photos/400/300?random=1&keyword=mountain",
        "https://picsum.photos/400/300?random=2&keyword=landscape",
      ],
      "likes": 127,
      "comments": 23,
      "shares": 8,
      "isLiked": false,
    },
    {
      "id": "2",
      "author": {
        "name": "Mike Chen",
        "avatar": "https://picsum.photos/60/60?random=2&keyword=person",
        "verified": false,
      },
      "timestamp": "4 hours ago",
      "content": "Excited to share my latest photography project! Spent the whole weekend capturing street art in the city. Each piece tells a unique story. 📸",
      "images": [
        "https://picsum.photos/400/300?random=3&keyword=art",
      ],
      "likes": 89,
      "comments": 15,
      "shares": 12,
      "isLiked": true,
    },
    {
      "id": "3",
      "author": {
        "name": "Emily Rodriguez",
        "avatar": "https://picsum.photos/60/60?random=3&keyword=person",
        "verified": true,
      },
      "timestamp": "6 hours ago",
      "content": "Cooking Sunday! Made homemade pasta from scratch today. There's something therapeutic about making food with your own hands. Recipe in comments! 🍝",
      "images": [
        "https://picsum.photos/400/300?random=4&keyword=food",
        "https://picsum.photos/400/300?random=5&keyword=pasta",
      ],
      "likes": 234,
      "comments": 45,
      "shares": 18,
      "isLiked": false,
    },
    {
      "id": "4",
      "author": {
        "name": "David Thompson",
        "avatar": "https://picsum.photos/60/60?random=4&keyword=person",
        "verified": false,
      },
      "timestamp": "8 hours ago",
      "content": "Finally completed my first marathon! 26.2 miles of pure determination. Thank you to everyone who supported me along the way! 🏃‍♂️💪",
      "images": [],
      "likes": 312,
      "comments": 67,
      "shares": 25,
      "isLiked": true,
    },
  ];
  
  @override
  Widget build(BuildContext context) {
    return QBottomBar(
      title: "Social Feed",
      selectedIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: "Discover",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle),
          label: "Create",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: "Notifications",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
      children: [
        _buildHomeFeed(),
        _buildDiscoverTab(),
        _buildCreateTab(),
        _buildNotificationsTab(),
        _buildProfileTab(),
      ],
      onTap: (index) {
        currentIndex = index;
        setState(() {});
      },
    );
  }
  
  Widget _buildHomeFeed() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildCreatePostCard(),
          _buildStoriesRow(),
          ...List.generate(feedPosts.length, (index) {
            final post = feedPosts[index];
            return _buildPostCard(post);
          }),
        ],
      ),
    );
  }
  
  Widget _buildCreatePostCard() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        spacing: spSm,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage("https://picsum.photos/60/60?random=10&keyword=person"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Navigate to create post
              },
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  "What's on your mind?",
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.photo_camera,
                  color: primaryColor,
                  size: 24,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.video_call,
                  color: primaryColor,
                  size: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildStoriesRow() {
    return Container(
      height: 120,
      child: QHorizontalScroll(
        children: [
          _buildAddStoryCard(),
          ...List.generate(6, (index) {
            return _buildStoryCard(
              "Story ${index + 1}",
              "https://picsum.photos/80/80?random=${index + 11}&keyword=person",
              "https://picsum.photos/80/120?random=${index + 20}&keyword=story",
            );
          }),
        ],
      ),
    );
  }
  
  Widget _buildAddStoryCard() {
    return Container(
      width: 80,
      margin: EdgeInsets.only(right: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(30),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.add,
              color: primaryColor,
              size: 24,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Your Story",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStoryCard(String name, String avatar, String storyImage) {
    return Container(
      width: 80,
      margin: EdgeInsets.only(right: spSm),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radiusMd),
        image: DecorationImage(
          image: NetworkImage(storyImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radiusMd),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withAlpha(150),
            ],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(spXs),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    image: DecorationImage(
                      image: NetworkImage(avatar),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.all(spXs),
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildPostCard(Map<String, dynamic> post) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPostHeader(post),
          _buildPostContent(post),
          if ((post["images"] as List).isNotEmpty) _buildPostImages(post),
          _buildPostActions(post),
        ],
      ),
    );
  }
  
  Widget _buildPostHeader(Map<String, dynamic> post) {
    final author = post["author"] as Map<String, dynamic>;
    
    return Padding(
      padding: EdgeInsets.all(spSm),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage("${author["avatar"]}"),
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
                      "${author["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    if (author["verified"] == true) ...[
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
                  "${post["timestamp"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {},
            color: disabledBoldColor,
          ),
        ],
      ),
    );
  }
  
  Widget _buildPostContent(Map<String, dynamic> post) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: spSm),
      child: Text(
        "${post["content"]}",
        style: TextStyle(
          fontSize: 16,
          color: primaryColor,
          height: 1.4,
        ),
      ),
    );
  }
  
  Widget _buildPostImages(Map<String, dynamic> post) {
    final images = post["images"] as List;
    
    return Container(
      margin: EdgeInsets.only(top: spSm),
      height: 250,
      child: images.length == 1
          ? Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("${images[0]}"),
                  fit: BoxFit.cover,
                ),
              ),
            )
          : QHorizontalScroll(
              children: images.map((image) {
                return Container(
                  width: 200,
                  margin: EdgeInsets.only(left: spSm),
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
    );
  }
  
  Widget _buildPostActions(Map<String, dynamic> post) {
    return Padding(
      padding: EdgeInsets.all(spSm),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${post["likes"]} likes",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Row(
                children: [
                  Text(
                    "${post["comments"]} comments",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "${post["shares"]} shares",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    post["isLiked"] = !(post["isLiked"] as bool);
                    setState(() {});
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        post["isLiked"] ? Icons.favorite : Icons.favorite_border,
                        color: post["isLiked"] ? dangerColor : disabledBoldColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Like",
                        style: TextStyle(
                          fontSize: 14,
                          color: post["isLiked"] ? dangerColor : disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.comment,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Comment",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.share,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Share",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildDiscoverTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.explore,
            size: 80,
            color: primaryColor,
          ),
          SizedBox(height: spSm),
          Text(
            "Discover",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Explore trending content and new people",
            style: TextStyle(
              fontSize: 16,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCreateTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_circle,
            size: 80,
            color: primaryColor,
          ),
          SizedBox(height: spSm),
          Text(
            "Create",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Share your moments with the world",
            style: TextStyle(
              fontSize: 16,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildNotificationsTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications,
            size: 80,
            color: primaryColor,
          ),
          SizedBox(height: spSm),
          Text(
            "Notifications",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Stay updated with latest activities",
            style: TextStyle(
              fontSize: 16,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildProfileTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person,
            size: 80,
            color: primaryColor,
          ),
          SizedBox(height: spSm),
          Text(
            "Profile",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Manage your profile and settings",
            style: TextStyle(
              fontSize: 16,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
