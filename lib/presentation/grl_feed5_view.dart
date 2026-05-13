import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFeed5View extends StatefulWidget {
  @override
  State<GrlFeed5View> createState() => _GrlFeed5ViewState();
}

class _GrlFeed5ViewState extends State<GrlFeed5View> {
  List<Map<String, dynamic>> feedFilter = [
    {"label": "All", "value": "all"},
    {"label": "Following", "value": "following"},
    {"label": "Trending", "value": "trending"},
    {"label": "Explore", "value": "explore"},
  ];

  String selectedFilter = "all";
  String newPostContent = "";

  List<Map<String, dynamic>> feedData = [
    {
      "id": 1,
      "author": {
        "name": "Alex Rodriguez",
        "username": "@alexrod",
        "avatar": "https://picsum.photos/100/100?random=1&keyword=person",
        "isVerified": true,
        "followers": 125400,
      },
      "content": "Just launched my new photography project! Capturing the beauty of urban landscapes at golden hour. What do you think about this shot from downtown? 📸✨",
      "images": [
        "https://picsum.photos/400/300?random=10&keyword=city",
        "https://picsum.photos/400/300?random=11&keyword=architecture",
      ],
      "timestamp": "2 hours ago",
      "likes": 2847,
      "comments": 156,
      "shares": 89,
      "isLiked": false,
      "isBookmarked": true,
      "category": "photography",
      "location": "New York City",
    },
    {
      "id": 2,
      "author": {
        "name": "Emma Chen",
        "username": "@emmacooks",
        "avatar": "https://picsum.photos/100/100?random=2&keyword=woman",
        "isVerified": false,
        "followers": 67800,
      },
      "content": "Sunday brunch vibes! Made these delicious avocado toast variations with homemade sourdough. Recipe in comments 🥑🍞",
      "images": [
        "https://picsum.photos/400/300?random=12&keyword=food",
      ],
      "timestamp": "4 hours ago",
      "likes": 1956,
      "comments": 234,
      "shares": 145,
      "isLiked": true,
      "isBookmarked": false,
      "category": "food",
      "location": "San Francisco",
    },
    {
      "id": 3,
      "author": {
        "name": "TechGuru Mike",
        "username": "@techguru",
        "avatar": "https://picsum.photos/100/100?random=3&keyword=man",
        "isVerified": true,
        "followers": 234500,
      },
      "content": "Breaking: New AI breakthrough in machine learning could revolutionize how we interact with technology. The future is here! 🤖💻 #AI #Technology #Innovation",
      "images": [],
      "timestamp": "6 hours ago",
      "likes": 4521,
      "comments": 687,
      "shares": 892,
      "isLiked": true,
      "isBookmarked": true,
      "category": "technology",
      "location": "Silicon Valley",
    },
    {
      "id": 4,
      "author": {
        "name": "Fitness Jane",
        "username": "@fitnessjane",
        "avatar": "https://picsum.photos/100/100?random=4&keyword=fitness",
        "isVerified": false,
        "followers": 89200,
      },
      "content": "Monday motivation! 💪 Just finished an intense HIIT workout. Remember, consistency is key! Here's my favorite 20-minute routine that you can do anywhere.",
      "images": [
        "https://picsum.photos/400/300?random=13&keyword=fitness",
        "https://picsum.photos/400/300?random=14&keyword=gym",
        "https://picsum.photos/400/300?random=15&keyword=workout",
      ],
      "timestamp": "8 hours ago",
      "likes": 3284,
      "comments": 412,
      "shares": 267,
      "isLiked": false,
      "isBookmarked": false,
      "category": "fitness",
      "location": "Los Angeles",
    },
    {
      "id": 5,
      "author": {
        "name": "Travel Buddy",
        "username": "@wanderlust",
        "avatar": "https://picsum.photos/100/100?random=5&keyword=traveler",
        "isVerified": true,
        "followers": 178900,
      },
      "content": "Paradise found! 🏝️ Three days in Bali and I'm already planning my next trip. The sunsets here are absolutely magical. Swipe to see more views!",
      "images": [
        "https://picsum.photos/400/300?random=16&keyword=beach",
        "https://picsum.photos/400/300?random=17&keyword=sunset",
      ],
      "timestamp": "12 hours ago",
      "likes": 5647,
      "comments": 289,
      "shares": 543,
      "isLiked": true,
      "isBookmarked": true,
      "category": "travel",
      "location": "Bali, Indonesia",
    },
    {
      "id": 6,
      "author": {
        "name": "Design Studio",
        "username": "@designpro",
        "avatar": "https://picsum.photos/100/100?random=6&keyword=design",
        "isVerified": true,
        "followers": 456700,
      },
      "content": "Color theory in action! 🎨 Here's how we used complementary colors to create this stunning brand identity for our latest client. What's your favorite color combination?",
      "images": [
        "https://picsum.photos/400/300?random=18&keyword=design",
      ],
      "timestamp": "1 day ago",
      "likes": 7892,
      "comments": 524,
      "shares": 734,
      "isLiked": false,
      "isBookmarked": false,
      "category": "design",
      "location": "London, UK",
    },
  ];

  List<Map<String, dynamic>> get filteredFeed {
    if (selectedFilter == "all") return feedData;
    if (selectedFilter == "trending") {
      return feedData.where((post) => (post["likes"] as int) > 3000).toList();
    }
    return feedData;
  }

  void _toggleLike(int postId) {
    final postIndex = feedData.indexWhere((post) => post["id"] == postId);
    if (postIndex != -1) {
      setState(() {
        feedData[postIndex]["isLiked"] = !feedData[postIndex]["isLiked"];
        if (feedData[postIndex]["isLiked"]) {
          feedData[postIndex]["likes"] = (feedData[postIndex]["likes"] as int) + 1;
        } else {
          feedData[postIndex]["likes"] = (feedData[postIndex]["likes"] as int) - 1;
        }
      });
    }
  }

  void _toggleBookmark(int postId) {
    final postIndex = feedData.indexWhere((post) => post["id"] == postId);
    if (postIndex != -1) {
      setState(() {
        feedData[postIndex]["isBookmarked"] = !feedData[postIndex]["isBookmarked"];
      });
    }
  }

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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Create Post Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage("https://picsum.photos/100/100?random=99&keyword=user"),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "What's on your mind?",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  QMemoField(
                    label: "Share your thoughts...",
                    value: newPostContent,
                    onChanged: (value) {
                      newPostContent = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      QButton(
                        icon: Icons.photo_camera,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.location_on,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                      Spacer(),
                      QButton(
                        label: "Post",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Feed Filter
            QCategoryPicker(
              label: "Filter Feed",
              items: feedFilter,
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),

            // Feed Posts
            ...filteredFeed.map((post) {
              final author = post["author"] as Map<String, dynamic>;
              final images = post["images"] as List;
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    // Post Header
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundImage: NetworkImage("${author["avatar"]}"),
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
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  if (author["isVerified"] == true) ...[
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
                                "${author["username"]} • ${post["timestamp"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              if (post["location"] != null)
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 12,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "${post["location"]}",
                                      style: TextStyle(
                                        fontSize: 11,
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

                    // Post Content
                    Text(
                      "${post["content"]}",
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.4,
                        color: primaryColor,
                      ),
                    ),

                    // Post Images
                    if (images.isNotEmpty)
                      if (images.length == 1)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${images[0]}",
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        )
                      else
                        Container(
                          height: 200,
                          child: QHorizontalScroll(
                            children: images.map((image) {
                              return Container(
                                width: 180,
                                margin: EdgeInsets.only(right: spXs),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  child: Image.network(
                                    "$image",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                    // Post Stats
                    Row(
                      children: [
                        Text(
                          "${(post["likes"] as int).toStringAsFixed(0)} likes",
                          style: TextStyle(
                            fontSize: 13,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${post["comments"]} comments",
                          style: TextStyle(
                            fontSize: 13,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${post["shares"]} shares",
                          style: TextStyle(
                            fontSize: 13,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),

                    // Post Actions
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(
                                  post["isLiked"] == true ? Icons.favorite : Icons.favorite_border,
                                  color: post["isLiked"] == true ? dangerColor : disabledBoldColor,
                                ),
                                onPressed: () => _toggleLike(post["id"]),
                              ),
                              Text(
                                "Like",
                                style: TextStyle(
                                  color: post["isLiked"] == true ? dangerColor : disabledBoldColor,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.chat_bubble_outline,
                                  color: disabledBoldColor,
                                ),
                                onPressed: () {},
                              ),
                              Text(
                                "Comment",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.share,
                                  color: disabledBoldColor,
                                ),
                                onPressed: () {},
                              ),
                              Text(
                                "Share",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            post["isBookmarked"] == true ? Icons.bookmark : Icons.bookmark_border,
                            color: post["isBookmarked"] == true ? warningColor : disabledBoldColor,
                          ),
                          onPressed: () => _toggleBookmark(post["id"]),
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
