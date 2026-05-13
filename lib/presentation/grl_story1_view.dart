import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStory1View extends StatefulWidget {
  @override
  State<GrlStory1View> createState() => _GrlStory1ViewState();
}

class _GrlStory1ViewState extends State<GrlStory1View> {
  List<Map<String, dynamic>> stories = [
    {
      "id": "1",
      "author": "Sarah Chen",
      "avatar": "https://picsum.photos/50/50?random=1&keyword=portrait",
      "timestamp": "2024-03-15T14:30:00Z",
      "content": [
        {
          "type": "image",
          "url": "https://picsum.photos/400/600?random=1&keyword=travel",
          "caption": "Beautiful sunset in Santorini ✨"
        },
        {
          "type": "image", 
          "url": "https://picsum.photos/400/600?random=2&keyword=food",
          "caption": "Amazing Greek cuisine!"
        },
        {
          "type": "image",
          "url": "https://picsum.photos/400/600?random=3&keyword=architecture",
          "caption": "Traditional Greek architecture"
        }
      ],
      "isViewed": false,
      "views": 234,
      "likes": 45
    },
    {
      "id": "2",
      "author": "Mike Johnson",
      "avatar": "https://picsum.photos/50/50?random=2&keyword=portrait",
      "timestamp": "2024-03-15T12:15:00Z",
      "content": [
        {
          "type": "image",
          "url": "https://picsum.photos/400/600?random=4&keyword=workout",
          "caption": "Morning workout session 💪"
        },
        {
          "type": "image",
          "url": "https://picsum.photos/400/600?random=5&keyword=healthy",
          "caption": "Healthy breakfast to fuel the day"
        }
      ],
      "isViewed": true,
      "views": 156,
      "likes": 28
    },
    {
      "id": "3",
      "author": "Emma Wilson",
      "avatar": "https://picsum.photos/50/50?random=3&keyword=portrait",
      "timestamp": "2024-03-15T10:45:00Z",
      "content": [
        {
          "type": "image",
          "url": "https://picsum.photos/400/600?random=6&keyword=workspace",
          "caption": "My creative workspace setup"
        },
        {
          "type": "image",
          "url": "https://picsum.photos/400/600?random=7&keyword=design",
          "caption": "Working on a new design project"
        },
        {
          "type": "image",
          "url": "https://picsum.photos/400/600?random=8&keyword=coffee",
          "caption": "Coffee break ☕"
        },
        {
          "type": "image",
          "url": "https://picsum.photos/400/600?random=9&keyword=sketch",
          "caption": "Sketching new ideas"
        }
      ],
      "isViewed": false,
      "views": 89,
      "likes": 67
    },
    {
      "id": "4",
      "author": "David Park",
      "avatar": "https://picsum.photos/50/50?random=4&keyword=portrait",
      "timestamp": "2024-03-15T08:20:00Z",
      "content": [
        {
          "type": "image",
          "url": "https://picsum.photos/400/600?random=10&keyword=nature",
          "caption": "Early morning hike 🏔️"
        },
        {
          "type": "image",
          "url": "https://picsum.photos/400/600?random=11&keyword=mountain",
          "caption": "Reached the summit!"
        }
      ],
      "isViewed": true,
      "views": 178,
      "likes": 92
    },
    {
      "id": "5",
      "author": "Lisa Rodriguez",
      "avatar": "https://picsum.photos/50/50?random=5&keyword=portrait",
      "timestamp": "2024-03-14T20:10:00Z",
      "content": [
        {
          "type": "image",
          "url": "https://picsum.photos/400/600?random=12&keyword=cooking",
          "caption": "Cooking dinner for friends"
        },
        {
          "type": "image",
          "url": "https://picsum.photos/400/600?random=13&keyword=dinner",
          "caption": "Perfect dinner party setup"
        },
        {
          "type": "image",
          "url": "https://picsum.photos/400/600?random=14&keyword=friends",
          "caption": "Great time with amazing people"
        }
      ],
      "isViewed": false,
      "views": 267,
      "likes": 156
    },
    {
      "id": "6",
      "author": "Alex Thompson",
      "avatar": "https://picsum.photos/50/50?random=6&keyword=portrait",
      "timestamp": "2024-03-14T18:30:00Z",
      "content": [
        {
          "type": "image",
          "url": "https://picsum.photos/400/600?random=15&keyword=music",
          "caption": "Recording session at the studio 🎵"
        },
        {
          "type": "image",
          "url": "https://picsum.photos/400/600?random=16&keyword=guitar",
          "caption": "New song coming soon!"
        }
      ],
      "isViewed": true,
      "views": 123,
      "likes": 78
    }
  ];

  List<Map<String, dynamic>> myStory = [
    {
      "type": "image",
      "url": "https://picsum.photos/400/600?random=20&keyword=selfie",
      "caption": "Good morning! ☀️",
      "timestamp": "2024-03-15T09:00:00Z"
    },
    {
      "type": "image", 
      "url": "https://picsum.photos/400/600?random=21&keyword=coffee",
      "caption": "Starting the day with great coffee",
      "timestamp": "2024-03-15T09:15:00Z"
    }
  ];

  String _formatTime(String timestamp) {
    final now = DateTime.now();
    final time = DateTime.parse(timestamp);
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return "${difference.inDays}d";
    } else if (difference.inHours > 0) {
      return "${difference.inHours}h";
    } else {
      return "${difference.inMinutes}m";
    }
  }

  void _viewStory(int index) {
    setState(() {
      stories[index]["isViewed"] = true;
    });
    
    // Navigate to story viewer
    // ss('Next page'));
  }

  void _createStory() {
    // Navigate to story creation
    ss("Story creation coming soon!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stories"),
        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _createStory,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stories Header
            Container(
              padding: EdgeInsets.all(spMd),
              child: Text(
                "Stories",
                style: TextStyle(
                  fontSize: fsH3,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),

            // Horizontal Stories List
            Container(
              height: 120,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: spMd),
                child: Row(
                  children: [
                    // Add Story Button
                    GestureDetector(
                      onTap: _createStory,
                      child: Container(
                        width: 80,
                        margin: EdgeInsets.only(right: spMd),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(radiusLg),
                                    border: Border.all(
                                      color: primaryColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 32,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "Your Story",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Stories List
                    ...stories.asMap().entries.map((entry) {
                      final index = entry.key;
                      final story = entry.value;
                      return GestureDetector(
                        onTap: () => _viewStory(index),
                        child: Container(
                          width: 80,
                          margin: EdgeInsets.only(right: spMd),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(radiusLg),
                                      border: Border.all(
                                        color: (story["isViewed"] as bool) 
                                          ? disabledBoldColor 
                                          : primaryColor,
                                        width: 3,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(radiusLg),
                                      child: Image.network(
                                        "${story["avatar"]}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  if (!(story["isViewed"] as bool))
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.circular(radiusLg),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "${story["author"]}".split(" ")[0],
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: (story["isViewed"] as bool) 
                                    ? disabledBoldColor 
                                    : primaryColor,
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),

            SizedBox(height: spLg),

            // My Story Section (if exists)
            if (myStory.isNotEmpty) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: spMd),
                child: Row(
                  children: [
                    Text(
                      "Your Story",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Expires in 20h",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spMd),
              
              Container(
                height: 180,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: spMd),
                  child: Row(
                    children: myStory.asMap().entries.map((entry) {
                      final index = entry.key;
                      final storyItem = entry.value;
                      return Container(
                        width: 120,
                        margin: EdgeInsets.only(right: spMd),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: Stack(
                            children: [
                              Image.network(
                                "${storyItem["url"]}",
                                width: 120,
                                height: 180,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                width: 120,
                                height: 180,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withAlpha(128),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: spSm,
                                left: spSm,
                                right: spSm,
                                child: Text(
                                  _formatTime(storyItem["timestamp"]),
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: spLg),
            ],

            // Recent Stories Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Text(
                "Recent Stories",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
            SizedBox(height: spMd),

            // Stories Grid
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 160,
                children: stories.map((story) {
                  return GestureDetector(
                    onTap: () => _viewStory(stories.indexOf(story)),
                    child: Container(
                      height: 240,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(radiusLg),
                        child: Stack(
                          children: [
                            // Background Image (first story content)
                            Image.network(
                              "${(story["content"] as List)[0]["url"]}",
                              width: double.infinity,
                              height: 240,
                              fit: BoxFit.cover,
                            ),
                            
                            // Dark Overlay
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withAlpha(179),
                                  ],
                                ),
                              ),
                            ),

                            // Story Info
                            Positioned(
                              top: spMd,
                              left: spMd,
                              right: spMd,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 16,
                                    backgroundImage: NetworkImage("${story["avatar"]}"),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${story["author"]}",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          _formatTime(story["timestamp"]),
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.white.withAlpha(204),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (!(story["isViewed"] as bool))
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(radiusLg),
                                      ),
                                    ),
                                ],
                              ),
                            ),

                            // Bottom Info
                            Positioned(
                              bottom: spMd,
                              left: spMd,
                              right: spMd,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${(story["content"] as List)[0]["caption"]}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: spSm),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.visibility,
                                        size: 14,
                                        color: Colors.white.withAlpha(204),
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${story["views"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white.withAlpha(204),
                                        ),
                                      ),
                                      SizedBox(width: spMd),
                                      Icon(
                                        Icons.favorite,
                                        size: 14,
                                        color: Colors.white.withAlpha(204),
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${story["likes"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white.withAlpha(204),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withAlpha(51),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "${(story["content"] as List).length}",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
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
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: spLg),
          ],
        ),
      ),
    );
  }
}
