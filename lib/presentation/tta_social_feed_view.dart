import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaSocialFeedView extends StatefulWidget {
  const TtaSocialFeedView({super.key});

  @override
  State<TtaSocialFeedView> createState() => _TtaSocialFeedViewState();
}

class _TtaSocialFeedViewState extends State<TtaSocialFeedView> {
  List<Map<String, dynamic>> socialPosts = [
    {
      "id": 1,
      "user": {
        "name": "Emma Wilson",
        "avatar": "https://picsum.photos/40/40?random=1",
        "verified": true,
        "followers": 12500
      },
      "location": "Santorini, Greece",
      "image": "https://picsum.photos/400/300?random=1&keyword=santorini",
      "caption": "Watching the most incredible sunset from Oia! The colors in the sky are absolutely magical ✨ #Santorini #Greece #Sunset",
      "likes": 2847,
      "comments": 156,
      "shares": 89,
      "timeAgo": "2 hours ago",
      "isLiked": false,
      "tags": ["#Santorini", "#Greece", "#Sunset"]
    },
    {
      "id": 2,
      "user": {
        "name": "Alex Chen",
        "avatar": "https://picsum.photos/40/40?random=2",
        "verified": false,
        "followers": 3200
      },
      "location": "Tokyo, Japan",
      "image": "https://picsum.photos/400/300?random=2&keyword=tokyo",
      "caption": "Street food adventures in Shibuya! This takoyaki is life 🐙🔥 Where should I try next?",
      "likes": 1523,
      "comments": 89,
      "shares": 45,
      "timeAgo": "5 hours ago",
      "isLiked": true,
      "tags": ["#Tokyo", "#StreetFood", "#Japan"]
    },
    {
      "id": 3,
      "user": {
        "name": "Maria Rodriguez",
        "avatar": "https://picsum.photos/40/40?random=3",
        "verified": true,
        "followers": 8900
      },
      "location": "Machu Picchu, Peru",
      "image": "https://picsum.photos/400/300?random=3&keyword=machupicchu",
      "caption": "Finally made it to Machu Picchu after a 4-day trek! The journey was challenging but so worth it 🏔️",
      "likes": 3456,
      "comments": 234,
      "shares": 120,
      "timeAgo": "1 day ago",
      "isLiked": false,
      "tags": ["#MachuPicchu", "#Peru", "#Hiking"]
    },
    {
      "id": 4,
      "user": {
        "name": "David Thompson",
        "avatar": "https://picsum.photos/40/40?random=4",
        "verified": false,
        "followers": 1800
      },
      "location": "Banff National Park, Canada",
      "image": "https://picsum.photos/400/300?random=4&keyword=banff",
      "caption": "Morning hike around Lake Louise. The water is so crystal clear you can see the bottom! 🏔️💙",
      "likes": 987,
      "comments": 67,
      "shares": 32,
      "timeAgo": "6 hours ago",
      "isLiked": true,
      "tags": ["#Banff", "#Canada", "#NaturalBeauty"]
    },
    {
      "id": 5,
      "user": {
        "name": "Sophie Martin",
        "avatar": "https://picsum.photos/40/40?random=5",
        "verified": true,
        "followers": 15600
      },
      "location": "Maldives",
      "image": "https://picsum.photos/400/300?random=5&keyword=maldives",
      "caption": "Paradise found! 🏝️ Overwater villa life in the Maldives. Pinch me, I think I'm dreaming!",
      "likes": 4567,
      "comments": 289,
      "shares": 156,
      "timeAgo": "3 hours ago",
      "isLiked": false,
      "tags": ["#Maldives", "#Paradise", "#Vacation"]
    },
  ];

  List<Map<String, dynamic>> stories = [
    {
      "user": "Your Story",
      "avatar": "https://picsum.photos/60/60?random=10",
      "hasStory": false,
      "isOwn": true
    },
    {
      "user": "Emma Wilson",
      "avatar": "https://picsum.photos/60/60?random=11",
      "hasStory": true,
      "isOwn": false
    },
    {
      "user": "Alex Chen",
      "avatar": "https://picsum.photos/60/60?random=12",
      "hasStory": true,
      "isOwn": false
    },
    {
      "user": "Maria Rodriguez",
      "avatar": "https://picsum.photos/60/60?random=13",
      "hasStory": true,
      "isOwn": false
    },
    {
      "user": "David Thompson",
      "avatar": "https://picsum.photos/60/60?random=14",
      "hasStory": true,
      "isOwn": false
    },
  ];

  String selectedFilter = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Social Feed"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.chat_bubble_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Stories Section
          Container(
            height: 100,
            padding: EdgeInsets.symmetric(vertical: spSm),
            child: QHorizontalScroll(
              children: stories.map((story) {
                return Container(
                  margin: EdgeInsets.only(left: spSm),
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: (story["hasStory"] as bool) 
                                ? primaryColor 
                                : disabledColor,
                            width: 2,
                          ),
                        ),
                        child: ClipOval(
                          child: (story["isOwn"] as bool)
                              ? Stack(
                                  children: [
                                    Image.network(
                                      "${story["avatar"]}",
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          size: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Image.network(
                                  "${story["avatar"]}",
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${story["user"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          // Filter Tabs
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: QCategoryPicker(
              items: [
                {"label": "All", "value": "All"},
                {"label": "Following", "value": "Following"},
                {"label": "Popular", "value": "Popular"},
                {"label": "Recent", "value": "Recent"},
              ],
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),
          ),

          SizedBox(height: spSm),

          // Posts Feed
          Expanded(
            child: ListView.builder(
              itemCount: socialPosts.length,
              itemBuilder: (context, index) {
                final post = socialPosts[index];
                final user = post["user"] as Map<String, dynamic>;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                            ClipOval(
                              child: Image.network(
                                "${user["avatar"]}",
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
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
                                        ),
                                      ),
                                      if (user["verified"] as bool) ...[
                                        SizedBox(width: spXs),
                                        Icon(
                                          Icons.verified,
                                          size: 16,
                                          color: primaryColor,
                                        ),
                                      ],
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 14,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${post["location"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        " • ${post["timeAgo"]}",
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
                            IconButton(
                              icon: Icon(Icons.more_horiz),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),

                      // Post Image
                      Image.network(
                        "${post["image"]}",
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                      ),

                      // Post Actions
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                post["isLiked"] = !(post["isLiked"] as bool);
                                setState(() {});
                              },
                              child: Icon(
                                (post["isLiked"] as bool) 
                                    ? Icons.favorite 
                                    : Icons.favorite_border,
                                color: (post["isLiked"] as bool) 
                                    ? Colors.red 
                                    : disabledBoldColor,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Icon(
                              Icons.chat_bubble_outline,
                              color: disabledBoldColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Icon(
                              Icons.send,
                              color: disabledBoldColor,
                              size: 24,
                            ),
                            Spacer(),
                            Icon(
                              Icons.bookmark_border,
                              color: disabledBoldColor,
                              size: 24,
                            ),
                          ],
                        ),
                      ),

                      // Post Stats
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${(post["likes"] as int).currency} likes",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${post["caption"]}",
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "View all ${post["comments"]} comments",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: spSm),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
