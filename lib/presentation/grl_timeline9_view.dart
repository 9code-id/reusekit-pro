import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTimeline9View extends StatefulWidget {
  @override
  State<GrlTimeline9View> createState() => _GrlTimeline9ViewState();
}

class _GrlTimeline9ViewState extends State<GrlTimeline9View> {
  List<Map<String, dynamic>> socialPosts = [
    {
      "id": "1",
      "user": {
        "name": "Alice Johnson",
        "username": "@alice_codes",
        "avatar": "https://picsum.photos/50/50?random=1&keyword=person",
        "verified": true
      },
      "content": "Just launched my new portfolio website! 🚀 Built with React and lots of coffee ☕️",
      "timestamp": "2024-01-20T16:30:00Z",
      "type": "post",
      "media": {
        "type": "image",
        "url": "https://picsum.photos/300/200?random=1&keyword=website"
      },
      "interactions": {
        "likes": 234,
        "comments": 18,
        "shares": 12
      },
      "location": "San Francisco, CA"
    },
    {
      "id": "2",
      "user": {
        "name": "Tech Conference",
        "username": "@techconf2024",
        "avatar": "https://picsum.photos/50/50?random=2&keyword=conference",
        "verified": true
      },
      "content": "🎉 Speaker announcement! Join us for an amazing session on AI and Machine Learning trends.",
      "timestamp": "2024-01-20T14:15:00Z",
      "type": "announcement",
      "media": {
        "type": "video",
        "url": "https://picsum.photos/300/200?random=2&keyword=conference",
        "duration": "2:34"
      },
      "interactions": {
        "likes": 456,
        "comments": 67,
        "shares": 89
      },
      "location": "Virtual Event"
    },
    {
      "id": "3",
      "user": {
        "name": "David Chen",
        "username": "@david_designs",
        "avatar": "https://picsum.photos/50/50?random=3&keyword=designer",
        "verified": false
      },
      "content": "New UI design for a fitness tracking app. What do you think about the color scheme? 🎨",
      "timestamp": "2024-01-20T12:45:00Z",
      "type": "post",
      "media": {
        "type": "image",
        "url": "https://picsum.photos/300/400?random=3&keyword=mobile"
      },
      "interactions": {
        "likes": 189,
        "comments": 23,
        "shares": 8
      },
      "location": "New York, NY"
    },
    {
      "id": "4",
      "user": {
        "name": "Sarah Thompson",
        "username": "@sarah_dev",
        "avatar": "https://picsum.photos/50/50?random=4&keyword=developer",
        "verified": false
      },
      "content": "Debugging session complete! 🐛➡️✨ Sometimes the simplest solutions are the best ones.",
      "timestamp": "2024-01-20T10:22:00Z",
      "type": "update",
      "media": null,
      "interactions": {
        "likes": 156,
        "comments": 31,
        "shares": 5
      },
      "location": "Remote"
    },
    {
      "id": "5",
      "user": {
        "name": "StartupNews",
        "username": "@startup_daily",
        "avatar": "https://picsum.photos/50/50?random=5&keyword=news",
        "verified": true
      },
      "content": "📈 Tech startup funding reaches new highs this quarter. Innovation continues to drive investment.",
      "timestamp": "2024-01-20T08:00:00Z",
      "type": "news",
      "media": {
        "type": "image",
        "url": "https://picsum.photos/300/200?random=5&keyword=chart"
      },
      "interactions": {
        "likes": 892,
        "comments": 124,
        "shares": 267
      },
      "location": "Silicon Valley"
    },
    {
      "id": "6",
      "user": {
        "name": "Emma Wilson",
        "username": "@emma_ux",
        "avatar": "https://picsum.photos/50/50?random=6&keyword=ux",
        "verified": false
      },
      "content": "User research insights from today's session. Understanding user behavior is key to great design! 📊",
      "timestamp": "2024-01-19T17:30:00Z",
      "type": "insight",
      "media": {
        "type": "image",
        "url": "https://picsum.photos/300/250?random=6&keyword=research"
      },
      "interactions": {
        "likes": 278,
        "comments": 42,
        "shares": 19
      },
      "location": "London, UK"
    }
  ];

  String selectedFilter = "all";
  List<String> filterOptions = ["all", "post", "announcement", "update", "news", "insight"];

  List<Map<String, dynamic>> get filteredPosts {
    if (selectedFilter == "all") {
      return socialPosts;
    }
    return socialPosts.where((post) => post["type"] == selectedFilter).toList();
  }

  Color _getPostTypeColor(String type) {
    switch (type) {
      case "announcement":
        return warningColor;
      case "news":
        return infoColor;
      case "insight":
        return secondaryColor;
      case "update":
        return successColor;
      case "post":
      default:
        return primaryColor;
    }
  }

  IconData _getPostTypeIcon(String type) {
    switch (type) {
      case "announcement":
        return Icons.campaign;
      case "news":
        return Icons.newspaper;
      case "insight":
        return Icons.lightbulb;
      case "update":
        return Icons.update;
      case "post":
      default:
        return Icons.post_add;
    }
  }

  String _formatTimestamp(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);

    if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else {
      return "${difference.inDays}d ago";
    }
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      return "${(number / 1000).toStringAsFixed(1)}K";
    }
    return number.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Social Timeline"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.timeline,
                    color: Colors.white,
                    size: 32,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Social Feed",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Stay connected with your network",
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(60),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${filteredPosts.length} posts",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Filter Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filter Posts",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: filterOptions.map((filter) {
                        bool isSelected = selectedFilter == filter;
                        return Container(
                          margin: EdgeInsets.only(right: spSm),
                          child: GestureDetector(
                            onTap: () {
                              selectedFilter = filter;
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: isSelected ? primaryColor : Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (filter != "all")
                                    Icon(
                                      _getPostTypeIcon(filter),
                                      size: 14,
                                      color: isSelected ? Colors.white : disabledBoldColor,
                                    ),
                                  if (filter != "all") SizedBox(width: spXs),
                                  Text(
                                    filter == "all" ? "All Posts" : filter.toUpperCase(),
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : disabledBoldColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
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
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Social Posts Timeline
            ...filteredPosts.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> post = entry.value;
              bool isLast = index == filteredPosts.length - 1;

              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Timeline Indicator
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage("${(post["user"] as Map)["avatar"]}"),
                        ),
                        if (!isLast)
                          Container(
                            width: 2,
                            height: 60,
                            color: Colors.grey.shade300,
                            margin: EdgeInsets.symmetric(vertical: spSm),
                          ),
                      ],
                    ),

                    SizedBox(width: spMd),

                    // Post Content
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Post Header
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${(post["user"] as Map)["name"]}",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                          if ((post["user"] as Map)["verified"] == true) ...[
                                            SizedBox(width: spXs),
                                            Icon(
                                              Icons.verified,
                                              size: 16,
                                              color: infoColor,
                                            ),
                                          ],
                                        ],
                                      ),
                                      Text(
                                        "${(post["user"] as Map)["username"]}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      _formatTimestamp("${post["timestamp"]}"),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: _getPostTypeColor("${post["type"]}").withAlpha(30),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            _getPostTypeIcon("${post["type"]}"),
                                            size: 10,
                                            color: _getPostTypeColor("${post["type"]}"),
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            "${post["type"]}".toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 9,
                                              fontWeight: FontWeight.bold,
                                              color: _getPostTypeColor("${post["type"]}"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            SizedBox(height: spSm),

                            // Post Content
                            Text(
                              "${post["content"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                                height: 1.5,
                              ),
                            ),

                            // Location
                            if (post["location"] != null) ...[
                              SizedBox(height: spXs),
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
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],

                            // Media Content
                            if (post["media"] != null) ...[
                              SizedBox(height: spMd),
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  image: DecorationImage(
                                    image: NetworkImage("${(post["media"] as Map)["url"]}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: (post["media"] as Map)["type"] == "video"
                                    ? Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(radiusLg),
                                          color: Colors.black.withAlpha(100),
                                        ),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.play_circle_fill,
                                                color: Colors.white,
                                                size: 48,
                                              ),
                                              if ((post["media"] as Map)["duration"] != null)
                                                Text(
                                                  "${(post["media"] as Map)["duration"]}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : null,
                              ),
                            ],

                            SizedBox(height: spMd),

                            // Interactions
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.favorite_border,
                                          size: 18,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          _formatNumber((post["interactions"] as Map)["likes"] as int),
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.comment_outlined,
                                          size: 18,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          _formatNumber((post["interactions"] as Map)["comments"] as int),
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.share_outlined,
                                          size: 18,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          _formatNumber((post["interactions"] as Map)["shares"] as int),
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: spSm),

                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "Like",
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: QButton(
                                    label: "Comment",
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.share,
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),

            SizedBox(height: spLg),

            // Load More
            Container(
              width: double.infinity,
              child: QButton(
                label: "Load More Posts",
                size: bs.md,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
