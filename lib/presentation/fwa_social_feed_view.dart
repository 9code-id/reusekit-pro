import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaSocialFeedView extends StatefulWidget {
  const FwaSocialFeedView({super.key});

  @override
  State<FwaSocialFeedView> createState() => _FwaSocialFeedViewState();
}

class _FwaSocialFeedViewState extends State<FwaSocialFeedView> {
  String selectedFeedType = "Following";
  int currentStoryIndex = 0;

  List<Map<String, dynamic>> feedTypes = [
    {"label": "Following", "value": "Following"},
    {"label": "Discover", "value": "Discover"},
    {"label": "Local", "value": "Local"},
    {"label": "Trending", "value": "Trending"},
  ];

  List<Map<String, dynamic>> stories = [
    {
      "userId": 1,
      "username": "sarah_fit",
      "avatar": "https://picsum.photos/60/60?random=1&keyword=person",
      "hasStory": true,
      "isViewed": false,
    },
    {
      "userId": 2,
      "username": "mike_strong",
      "avatar": "https://picsum.photos/60/60?random=2&keyword=person",
      "hasStory": true,
      "isViewed": false,
    },
    {
      "userId": 3,
      "username": "yoga_anna",
      "avatar": "https://picsum.photos/60/60?random=3&keyword=person",
      "hasStory": true,
      "isViewed": true,
    },
    {
      "userId": 4,
      "username": "runner_john",
      "avatar": "https://picsum.photos/60/60?random=4&keyword=person",
      "hasStory": true,
      "isViewed": false,
    },
  ];

  List<Map<String, dynamic>> socialFeed = [
    {
      "id": 1,
      "userId": 1,
      "username": "sarah_fit",
      "userAvatar": "https://picsum.photos/40/40?random=1&keyword=person",
      "isVerified": true,
      "isFollowing": true,
      "postTime": "2 hours ago",
      "content": "Just crushed my morning workout! 💪 Nothing beats that post-exercise endorphin rush. Who else is starting their day with some movement?",
      "images": [
        "https://picsum.photos/400/300?random=11&keyword=fitness",
        "https://picsum.photos/400/300?random=12&keyword=gym"
      ],
      "category": "Workout Achievement",
      "location": "FitLife Gym",
      "likes": 124,
      "comments": 18,
      "shares": 5,
      "isLiked": true,
      "isBookmarked": false,
      "tags": ["#morningworkout", "#fitness", "#motivation"]
    },
    {
      "id": 2,
      "userId": 2,
      "username": "mike_strong",
      "userAvatar": "https://picsum.photos/40/40?random=2&keyword=person",
      "isVerified": false,
      "isFollowing": true,
      "postTime": "4 hours ago",
      "content": "6 months transformation! From 220lbs to 185lbs. The journey continues... 🔥\n\nKey tips that worked for me:\n✅ Consistent meal prep\n✅ Progressive overload\n✅ 8+ hours sleep\n✅ Never giving up",
      "images": [
        "https://picsum.photos/400/600?random=21&keyword=transformation"
      ],
      "category": "Before & After",
      "location": null,
      "likes": 456,
      "comments": 67,
      "shares": 23,
      "isLiked": false,
      "isBookmarked": true,
      "tags": ["#transformation", "#weightloss", "#beforeandafter", "#motivation"]
    },
    {
      "id": 3,
      "userId": 3,
      "username": "yoga_anna",
      "userAvatar": "https://picsum.photos/40/40?random=3&keyword=person",
      "isVerified": true,
      "isFollowing": false,
      "postTime": "6 hours ago",
      "content": "Morning yoga session by the beach 🧘‍♀️ Starting the day with gratitude and mindfulness. The sound of waves makes everything more peaceful.",
      "images": [
        "https://picsum.photos/400/400?random=31&keyword=yoga"
      ],
      "category": "Mindfulness",
      "location": "Santa Monica Beach",
      "likes": 289,
      "comments": 42,
      "shares": 12,
      "isLiked": true,
      "isBookmarked": false,
      "tags": ["#yoga", "#mindfulness", "#beachyoga", "#morning"]
    },
    {
      "id": 4,
      "userId": 4,
      "username": "runner_john",
      "userAvatar": "https://picsum.photos/40/40?random=4&keyword=person",
      "isVerified": false,
      "isFollowing": true,
      "postTime": "8 hours ago",
      "content": "New personal record! 🏃‍♂️ Completed my first half marathon in under 2 hours. All those early morning runs finally paid off. Next goal: full marathon!",
      "images": [],
      "category": "Personal Record",
      "location": "Central Park",
      "likes": 178,
      "comments": 34,
      "shares": 8,
      "isLiked": false,
      "isBookmarked": false,
      "tags": ["#running", "#halfmarathon", "#personalrecord", "#achievement"]
    },
    {
      "id": 5,
      "userId": 5,
      "username": "nutrition_emily",
      "userAvatar": "https://picsum.photos/40/40?random=5&keyword=person",
      "isVerified": true,
      "isFollowing": false,
      "postTime": "12 hours ago",
      "content": "Sunday meal prep session! 🥗 Prepping colorful, nutritious meals for the week ahead. Consistency is key to reaching your health goals.",
      "images": [
        "https://picsum.photos/400/300?random=51&keyword=mealprep",
        "https://picsum.photos/400/300?random=52&keyword=healthy",
        "https://picsum.photos/400/300?random=53&keyword=nutrition"
      ],
      "category": "Nutrition Success",
      "location": null,
      "likes": 92,
      "comments": 15,
      "shares": 7,
      "isLiked": true,
      "isBookmarked": true,
      "tags": ["#mealprep", "#nutrition", "#healthyeating", "#Sunday"]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Social Feed"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Search functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () {
              // Messages
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Feed Type Selector
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              child: QHorizontalScroll(
                children: feedTypes.map((type) {
                  bool isSelected = type["value"] == selectedFeedType;
                  return GestureDetector(
                    onTap: () {
                      selectedFeedType = type["value"];
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                      margin: EdgeInsets.only(right: spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Text(
                        "${type["label"]}",
                        style: TextStyle(
                          color: isSelected ? Colors.white : disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Stories Section
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Stories",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Add story
                        },
                        child: Text(
                          "Add Story",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Container(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: stories.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          // Add Story Button
                          return GestureDetector(
                            onTap: () {
                              // Add story
                            },
                            child: Container(
                              width: 70,
                              margin: EdgeInsets.only(right: spSm),
                              child: Column(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: disabledColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: primaryColor,
                                        width: 2,
                                      ),
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
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        final story = stories[index - 1];
                        return GestureDetector(
                          onTap: () {
                            // View story
                          },
                          child: Container(
                            width: 70,
                            margin: EdgeInsets.only(right: spSm),
                            child: Column(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: story["isViewed"] as bool ? disabledBoldColor : primaryColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 28,
                                    backgroundImage: NetworkImage("${story["avatar"]}"),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${story["username"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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

            SizedBox(height: spMd),

            // Social Posts
            ...socialFeed.map((post) {
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
                          // User Avatar
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage("${post["userAvatar"]}"),
                          ),
                          SizedBox(width: spSm),
                          
                          // User Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${post["username"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    if (post["isVerified"] as bool) ...[
                                      SizedBox(width: spXs),
                                      Icon(
                                        Icons.verified,
                                        color: primaryColor,
                                        size: 16,
                                      ),
                                    ],
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${post["postTime"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                    if (post["location"] != null) ...[
                                      Text(" • ", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                                      Icon(
                                        Icons.location_on,
                                        color: disabledBoldColor,
                                        size: 12,
                                      ),
                                      Text(
                                        "${post["location"]}",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                          
                          // Follow Button
                          if (!(post["isFollowing"] as bool))
                            QButton(
                              label: "Follow",
                              size: bs.sm,
                              onPressed: () {
                                // Follow user
                              },
                            ),
                          
                          // More Options
                          IconButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: disabledBoldColor,
                            ),
                            onPressed: () {
                              // Show more options
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
                          color: primaryColor,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ),

                    // Tags
                    if ((post["tags"] as List).isNotEmpty) ...[
                      SizedBox(height: spSm),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: spSm),
                        child: Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (post["tags"] as List).map((tag) {
                            return GestureDetector(
                              onTap: () {
                                // Search for tag
                              },
                              child: Text(
                                tag,
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],

                    // Post Images
                    if ((post["images"] as List).isNotEmpty) ...[
                      SizedBox(height: spSm),
                      Container(
                        height: (post["images"] as List).length == 1 ? 300 : 200,
                        child: (post["images"] as List).length == 1
                            ? Image.network(
                                "${(post["images"] as List)[0]}",
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: (post["images"] as List).length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 250,
                                    margin: EdgeInsets.only(
                                      left: index == 0 ? spSm : 0,
                                      right: spSm,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(radiusSm),
                                      child: Image.network(
                                        "${(post["images"] as List)[index]}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],

                    SizedBox(height: spSm),

                    // Category Badge
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: spSm),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${post["category"]}",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: spSm),

                    // Engagement Stats
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: spSm),
                      child: Row(
                        children: [
                          Text(
                            "${post["likes"]} likes",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Text(
                            "${post["comments"]} comments",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Text(
                            "${post["shares"]} shares",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: spSm),

                    // Action Buttons
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spSm),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Like Button
                          GestureDetector(
                            onTap: () {
                              // Toggle like
                            },
                            child: Row(
                              children: [
                                Icon(
                                  post["isLiked"] as bool ? Icons.favorite : Icons.favorite_border,
                                  color: post["isLiked"] as bool ? dangerColor : disabledBoldColor,
                                  size: 20,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Like",
                                  style: TextStyle(
                                    color: post["isLiked"] as bool ? dangerColor : disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Comment Button
                          GestureDetector(
                            onTap: () {
                              // Show comments
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.comment_outlined,
                                  color: disabledBoldColor,
                                  size: 20,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Comment",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Share Button
                          GestureDetector(
                            onTap: () {
                              // Share post
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.share_outlined,
                                  color: disabledBoldColor,
                                  size: 20,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Share",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Bookmark Button
                          GestureDetector(
                            onTap: () {
                              // Toggle bookmark
                            },
                            child: Icon(
                              post["isBookmarked"] as bool ? Icons.bookmark : Icons.bookmark_border,
                              color: post["isBookmarked"] as bool ? primaryColor : disabledBoldColor,
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

            SizedBox(height: spMd),

            // Load More
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              width: double.infinity,
              child: QButton(
                label: "Load More Posts",
                size: bs.md,
                onPressed: () {
                  // Load more posts
                },
              ),
            ),

            SizedBox(height: spMd),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Create new post
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
