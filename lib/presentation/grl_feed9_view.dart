import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFeed9View extends StatefulWidget {
  @override
  State<GrlFeed9View> createState() => _GrlFeed9ViewState();
}

class _GrlFeed9ViewState extends State<GrlFeed9View> {
  String selectedCategory = "All";
  
  List<String> categories = ["All", "Sports", "Entertainment", "News", "Lifestyle", "Technology"];
  
  List<Map<String, dynamic>> liveStreams = [
    {
      "id": 1,
      "title": "Live Cooking Show: Italian Cuisine",
      "streamer": "Chef Marco",
      "avatar": "https://picsum.photos/100/100?random=100&keyword=chef",
      "thumbnail": "https://picsum.photos/400/300?random=100&keyword=cooking",
      "viewers": 12500,
      "category": "Entertainment",
      "isLive": true,
      "duration": "2:15:30"
    },
    {
      "id": 2,
      "title": "Breaking News: Tech Conference Live",
      "streamer": "TechNews Today",
      "avatar": "https://picsum.photos/100/100?random=101&keyword=news",
      "thumbnail": "https://picsum.photos/400/300?random=101&keyword=technology",
      "viewers": 8900,
      "category": "News",
      "isLive": true,
      "duration": "1:45:20"
    },
    {
      "id": 3,
      "title": "Morning Workout Session",
      "streamer": "Fitness Guru",
      "avatar": "https://picsum.photos/100/100?random=102&keyword=fitness",
      "thumbnail": "https://picsum.photos/400/300?random=102&keyword=workout",
      "viewers": 5600,
      "category": "Sports",
      "isLive": true,
      "duration": "0:45:15"
    }
  ];
  
  List<Map<String, dynamic>> posts = [
    {
      "id": 1,
      "author": "Travel Vlogger",
      "username": "@travel_vlogger",
      "avatar": "https://picsum.photos/100/100?random=110&keyword=travel",
      "time": "30 min ago",
      "content": "Just arrived in Tokyo! The city is absolutely incredible. First stop: authentic ramen in Shibuya! 🍜✨",
      "images": [
        "https://picsum.photos/400/300?random=110&keyword=tokyo",
        "https://picsum.photos/400/300?random=111&keyword=ramen",
        "https://picsum.photos/400/300?random=112&keyword=shibuya"
      ],
      "likes": 3450,
      "comments": 267,
      "shares": 89,
      "isLiked": true,
      "category": "Lifestyle",
      "tags": ["#Tokyo", "#Travel", "#Ramen", "#Japan"]
    },
    {
      "id": 2,
      "author": "Sports Analyst",
      "username": "@sports_analyst",
      "avatar": "https://picsum.photos/100/100?random=115&keyword=sports",
      "time": "1 hour ago",
      "content": "What an incredible match! The final goal was absolutely spectacular. This is why we love football! ⚽🔥",
      "video": {
        "thumbnail": "https://picsum.photos/400/300?random=115&keyword=football",
        "duration": "2:45",
        "views": "125K"
      },
      "likes": 8900,
      "comments": 456,
      "shares": 234,
      "isLiked": false,
      "category": "Sports",
      "verified": true
    },
    {
      "id": 3,
      "author": "Tech Reviewer",
      "username": "@tech_reviewer",
      "avatar": "https://picsum.photos/100/100?random=120&keyword=tech",
      "time": "2 hours ago",
      "content": "First impressions of the new smartphone: cameras are incredible, battery life is amazing, and the design is sleek! Full review coming soon. 📱",
      "images": [
        "https://picsum.photos/400/300?random=120&keyword=smartphone"
      ],
      "likes": 5670,
      "comments": 189,
      "shares": 167,
      "isLiked": true,
      "category": "Technology",
      "verified": true
    },
    {
      "id": 4,
      "author": "Music Producer",
      "username": "@music_producer",
      "avatar": "https://picsum.photos/100/100?random=125&keyword=music",
      "time": "3 hours ago",
      "content": "Working on a new track in the studio tonight! The creative process is flowing beautifully. Can't wait to share this with you all! 🎵🎧",
      "audio": {
        "title": "Studio Session Preview",
        "duration": "1:30",
        "waveform": "https://picsum.photos/400/100?random=125&keyword=waveform"
      },
      "likes": 2340,
      "comments": 78,
      "shares": 45,
      "isLiked": false,
      "category": "Entertainment"
    }
  ];

  void _toggleLike(int postId) {
    setState(() {
      final postIndex = posts.indexWhere((post) => post["id"] == postId);
      if (postIndex != -1) {
        posts[postIndex]["isLiked"] = !posts[postIndex]["isLiked"];
        if (posts[postIndex]["isLiked"]) {
          posts[postIndex]["likes"]++;
        } else {
          posts[postIndex]["likes"]--;
        }
      }
    });
  }

  List<Map<String, dynamic>> get filteredPosts {
    if (selectedCategory == "All") return posts;
    return posts.where((post) => post["category"] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Feed"),
        actions: [
          GestureDetector(
            onTap: () {
              //navigateTo('GoLiveView')
            },
            child: Container(
              margin: EdgeInsets.only(right: spSm),
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: dangerColor,
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.videocam, color: Colors.white, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "Go Live",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              //navigateTo('SearchView')
            },
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              child: Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Live Streams Section
          Container(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(spMd),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: dangerColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Live Now",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          //navigateTo('AllLiveStreamsView')
                        },
                        child: Text(
                          "See All",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    itemCount: liveStreams.length,
                    itemBuilder: (context, index) {
                      final stream = liveStreams[index];
                      return GestureDetector(
                        onTap: () {
                          //navigateTo('LiveStreamView')
                        },
                        child: Container(
                          width: 200,
                          margin: EdgeInsets.only(right: spSm),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusLg),
                            boxShadow: [shadowSm],
                          ),
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  image: DecorationImage(
                                    image: NetworkImage("${stream["thumbnail"]}"),
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
                              
                              // Live Badge
                              Positioned(
                                top: spSm,
                                left: spSm,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: dangerColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(radiusLg),
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "LIVE",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              
                              // Viewers Count
                              Positioned(
                                top: spSm,
                                right: spSm,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(150),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.visibility, color: Colors.white, size: 12),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${((stream["viewers"] as int) / 1000).toStringAsFixed(1)}K",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              
                              // Stream Info
                              Positioned(
                                bottom: spSm,
                                left: spSm,
                                right: spSm,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${stream["title"]}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: spXs),
                                    Row(
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(radiusLg),
                                            image: DecorationImage(
                                              image: NetworkImage("${stream["avatar"]}"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: spXs),
                                        Expanded(
                                          child: Text(
                                            "${stream["streamer"]}",
                                            style: TextStyle(
                                              color: Colors.white.withAlpha(200),
                                              fontSize: 12,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          
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
          
          // Posts Feed
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              itemCount: filteredPosts.length,
              itemBuilder: (context, index) {
                final post = filteredPosts[index];
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
                                  Row(
                                    children: [
                                      Text(
                                        "${post["username"]}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(" • ", style: TextStyle(color: disabledBoldColor)),
                                      Text(
                                        "${post["time"]}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${post["category"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
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
                      
                      // Tags
                      if (post["tags"] != null)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          child: Wrap(
                            spacing: spXs,
                            children: (post["tags"] as List).map((tag) {
                              return Text(
                                "$tag",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      
                      SizedBox(height: spSm),
                      
                      // Media Content
                      if (post["images"] != null)
                        _buildImageContent(post["images"] as List),
                      
                      if (post["video"] != null)
                        _buildVideoContent(post["video"]),
                      
                      if (post["audio"] != null)
                        _buildAudioContent(post["audio"]),
                      
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
                            
                            // Save
                            GestureDetector(
                              onTap: () {
                                //toggleSave
                              },
                              child: Icon(
                                Icons.bookmark_border,
                                color: disabledBoldColor,
                                size: 22,
                              ),
                            ),
                          ],
                        ),
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

  Widget _buildImageContent(List images) {
    if (images.length == 1) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: spSm),
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radiusSm),
          image: DecorationImage(
            image: NetworkImage("${images[0]}"),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: spSm),
        height: 200,
        child: QHorizontalScroll(
          children: images.map((image) {
            return Container(
              width: 250,
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
      );
    }
  }

  Widget _buildVideoContent(Map<String, dynamic> video) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spSm),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radiusSm),
        image: DecorationImage(
          image: NetworkImage("${video["thumbnail"]}"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(100),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
          ),
          Center(
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(200),
                borderRadius: BorderRadius.circular(radiusXl),
              ),
              child: Icon(
                Icons.play_arrow,
                color: primaryColor,
                size: 30,
              ),
            ),
          ),
          Positioned(
            bottom: spSm,
            right: spSm,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(150),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${video["duration"]}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: spSm,
            left: spSm,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(150),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${video["views"]} views",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAudioContent(Map<String, dynamic> audio) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 30,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${audio["title"]}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${audio["duration"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusXs),
                    image: DecorationImage(
                      image: NetworkImage("${audio["waveform"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
