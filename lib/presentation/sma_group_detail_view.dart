import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaGroupDetailView extends StatefulWidget {
  const SmaGroupDetailView({super.key});

  @override
  State<SmaGroupDetailView> createState() => _SmaGroupDetailViewState();
}

class _SmaGroupDetailViewState extends State<SmaGroupDetailView> {
  int selectedTab = 0;
  String newPost = "";
  bool isJoined = true;

  final Map<String, dynamic> groupData = {
    "id": 1,
    "name": "Flutter Developers",
    "description": "A vibrant community for Flutter developers to share knowledge, tips, and collaborate on projects. Join us to stay updated with the latest Flutter developments and connect with fellow developers worldwide.",
    "members": 12540,
    "image": "https://picsum.photos/400/200?random=1&keyword=tech",
    "coverImage": "https://picsum.photos/400/200?random=2&keyword=flutter",
    "category": "Technology",
    "isPrivate": false,
    "createdDate": "2023-01-15",
    "isAdmin": true,
    "moderators": [
      {
        "name": "John Doe",
        "image": "https://picsum.photos/40/40?random=10&keyword=person",
        "role": "Admin"
      },
      {
        "name": "Jane Smith",
        "image": "https://picsum.photos/40/40?random=11&keyword=person",
        "role": "Moderator"
      },
    ],
  };

  final List<Map<String, dynamic>> posts = [
    {
      "id": 1,
      "author": "Alice Johnson",
      "authorImage": "https://picsum.photos/40/40?random=20&keyword=profile",
      "content": "Just released a new Flutter package for advanced animations! Check it out and let me know what you think. It includes smooth transitions and custom curve animations.",
      "timestamp": "2 hours ago",
      "likes": 45,
      "comments": 12,
      "shares": 8,
      "isLiked": false,
      "attachments": [
        "https://picsum.photos/300/200?random=30&keyword=code"
      ],
    },
    {
      "id": 2,
      "author": "Bob Wilson",
      "authorImage": "https://picsum.photos/40/40?random=21&keyword=profile",
      "content": "Question: What's the best state management solution for large Flutter apps? I'm currently using Provider but considering Riverpod or Bloc. Any experiences to share?",
      "timestamp": "5 hours ago",
      "likes": 23,
      "comments": 18,
      "shares": 3,
      "isLiked": true,
      "attachments": [],
    },
    {
      "id": 3,
      "author": "Carol Davis",
      "authorImage": "https://picsum.photos/40/40?random=22&keyword=profile",
      "content": "Flutter 3.16 is amazing! The new features for performance optimization are game-changers. Here's a quick tutorial on how to implement the new widget inspector.",
      "timestamp": "1 day ago",
      "likes": 78,
      "comments": 25,
      "shares": 15,
      "isLiked": false,
      "attachments": [
        "https://picsum.photos/300/200?random=31&keyword=tutorial",
        "https://picsum.photos/300/200?random=32&keyword=flutter"
      ],
    },
  ];

  final List<Map<String, dynamic>> members = [
    {
      "name": "John Doe",
      "image": "https://picsum.photos/50/50?random=40&keyword=member",
      "role": "Admin",
      "joinDate": "2023-01-15",
      "posts": 156,
    },
    {
      "name": "Jane Smith",
      "image": "https://picsum.photos/50/50?random=41&keyword=member",
      "role": "Moderator",
      "joinDate": "2023-02-10",
      "posts": 89,
    },
    {
      "name": "Mike Johnson",
      "image": "https://picsum.photos/50/50?random=42&keyword=member",
      "role": "Member",
      "joinDate": "2023-03-05",
      "posts": 45,
    },
  ];

  final List<Map<String, dynamic>> events = [
    {
      "id": 1,
      "title": "Flutter Meetup 2024",
      "description": "Join us for an exciting Flutter meetup with guest speakers and networking opportunities.",
      "date": "2024-02-15",
      "time": "18:00",
      "location": "Tech Hub, San Francisco",
      "attendees": 67,
      "isAttending": false,
    },
    {
      "id": 2,
      "title": "Online Workshop: Advanced Flutter",
      "description": "Learn advanced Flutter concepts including custom animations and performance optimization.",
      "date": "2024-02-20",
      "time": "14:00",
      "location": "Online",
      "attendees": 234,
      "isAttending": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      "${groupData["coverImage"]}",
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
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
                      bottom: spMd,
                      left: spMd,
                      right: spMd,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage("${groupData["image"]}"),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${groupData["name"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${((groupData["members"] as int) / 1000).toStringAsFixed(1)}K members",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(200),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (!isJoined)
                            QButton(
                              label: "Join",
                              size: bs.sm,
                              onPressed: _joinGroup,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Icon(Icons.more_vert),
                SizedBox(width: spSm),
              ],
            ),
          ];
        },
        body: QTabBar(
          withoutAppBar: true,
          selectedIndex: selectedTab,
          tabs: [
            Tab(text: "Posts", icon: Icon(Icons.article)),
            Tab(text: "About", icon: Icon(Icons.info)),
            Tab(text: "Members", icon: Icon(Icons.group)),
            Tab(text: "Events", icon: Icon(Icons.event)),
          ],
          tabChildren: [
            _buildPostsTab(),
            _buildAboutTab(),
            _buildMembersTab(),
            _buildEventsTab(),
          ],
          onInit: (tabController) {},
        ),
      ),
    );
  }

  Widget _buildPostsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Create Post Card
          if (isJoined)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          "https://picsum.photos/40/40?random=100&keyword=user",
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTextField(
                          label: "Share with the group",
                          value: newPost,
                          hint: "What's on your mind?",
                          onChanged: (value) {
                            newPost = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Spacer(),
                      QButton(
                        label: "Post",
                        size: bs.sm,
                        onPressed: _createPost,
                      ),
                    ],
                  ),
                ],
              ),
            ),

          // Posts List
          ...posts.map((post) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Post Header
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage("${post["authorImage"]}"),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${post["author"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
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
                      Icon(
                        Icons.more_vert,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                    ],
                  ),

                  SizedBox(height: spSm),

                  // Post Content
                  Text(
                    "${post["content"]}",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                    ),
                  ),

                  // Post Attachments
                  if ((post["attachments"] as List).isNotEmpty)
                    Column(
                      children: [
                        SizedBox(height: spSm),
                        Container(
                          height: 200,
                          child: QHorizontalScroll(
                            children: (post["attachments"] as List).map((attachment) {
                              return Container(
                                width: 300,
                                margin: EdgeInsets.only(right: spSm),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  child: Image.network(
                                    "$attachment",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),

                  SizedBox(height: spSm),

                  // Post Actions
                  Row(
                    children: [
                      _buildPostAction(
                        icon: post["isLiked"] as bool ? Icons.favorite : Icons.favorite_border,
                        label: "${post["likes"]}",
                        color: post["isLiked"] as bool ? dangerColor : disabledBoldColor,
                        onTap: () => _toggleLike(post["id"]),
                      ),
                      SizedBox(width: spMd),
                      _buildPostAction(
                        icon: Icons.comment,
                        label: "${post["comments"]}",
                        color: disabledBoldColor,
                        onTap: () => _openComments(post["id"]),
                      ),
                      SizedBox(width: spMd),
                      _buildPostAction(
                        icon: Icons.share,
                        label: "${post["shares"]}",
                        color: disabledBoldColor,
                        onTap: () => _sharePost(post["id"]),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildAboutTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Description
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "About",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "${groupData["description"]}",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Group Info
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Group Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                _buildInfoRow(Icons.category, "Category", "${groupData["category"]}"),
                _buildInfoRow(Icons.people, "Members", "${((groupData["members"] as int) / 1000).toStringAsFixed(1)}K"),
                _buildInfoRow(Icons.calendar_today, "Created", "${DateTime.parse(groupData["createdDate"]).dMMMy}"),
                _buildInfoRow(Icons.lock, "Privacy", groupData["isPrivate"] as bool ? "Private" : "Public"),
              ],
            ),
          ),

          // Moderators
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Moderators",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...(groupData["moderators"] as List).map((moderator) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: spSm),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage("${moderator["image"]}"),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${moderator["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${moderator["role"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
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
          ),
        ],
      ),
    );
  }

  Widget _buildMembersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search Members
          QTextField(
            label: "Search members",
            value: "",
            hint: "Find members...",
            onChanged: (value) {},
          ),

          // Members List
          ...members.map((member) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage("${member["image"]}"),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${member["name"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: member["role"] == "Admin"
                                    ? warningColor.withAlpha(20)
                                    : member["role"] == "Moderator"
                                        ? infoColor.withAlpha(20)
                                        : primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${member["role"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: member["role"] == "Admin"
                                      ? warningColor
                                      : member["role"] == "Moderator"
                                          ? infoColor
                                          : primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Joined ${DateTime.parse(member["joinDate"]).dMMMy} • ${member["posts"]} posts",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    icon: Icons.message,
                    size: bs.sm,
                    onPressed: () {
                      // Message member
                    },
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildEventsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Create Event Button
          if (groupData["isAdmin"] as bool)
            Container(
              width: double.infinity,
              child: QButton(
                label: "Create Event",
                size: bs.md,
                onPressed: () {
                  // Navigate to create event
                },
              ),
            ),

          // Events List
          ...events.map((event) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${DateTime.parse(event["date"]).day}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${DateTime.parse(event["date"]).month}/${DateTime.parse(event["date"]).year}",
                              style: TextStyle(
                                fontSize: 10,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${event["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${event["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${event["time"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${event["location"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Text(
                        "${event["attendees"]} attending",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: event["isAttending"] as bool ? "Going" : "Attend",
                        size: bs.sm,
                        onPressed: () {
                          _toggleEventAttendance(event["id"]);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: disabledBoldColor,
          ),
          SizedBox(width: spSm),
          Text(
            "$label:",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostAction({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: color,
          ),
          SizedBox(width: spXs),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _joinGroup() {
    isJoined = true;
    setState(() {});
    ss("Successfully joined the group!");
  }

  void _createPost() {
    if (newPost.trim().isNotEmpty) {
      ss("Post created successfully!");
      newPost = "";
      setState(() {});
    }
  }

  void _toggleLike(int postId) {
    int index = posts.indexWhere((post) => post["id"] == postId);
    if (index != -1) {
      posts[index]["isLiked"] = !(posts[index]["isLiked"] as bool);
      if (posts[index]["isLiked"] as bool) {
        posts[index]["likes"] = (posts[index]["likes"] as int) + 1;
      } else {
        posts[index]["likes"] = (posts[index]["likes"] as int) - 1;
      }
      setState(() {});
    }
  }

  void _openComments(int postId) {
    // Navigate to comments
  }

  void _sharePost(int postId) {
    ss("Post shared!");
  }

  void _toggleEventAttendance(int eventId) {
    int index = events.indexWhere((event) => event["id"] == eventId);
    if (index != -1) {
      events[index]["isAttending"] = !(events[index]["isAttending"] as bool);
      if (events[index]["isAttending"] as bool) {
        events[index]["attendees"] = (events[index]["attendees"] as int) + 1;
        ss("You're now attending this event!");
      } else {
        events[index]["attendees"] = (events[index]["attendees"] as int) - 1;
        ss("You're no longer attending this event");
      }
      setState(() {});
    }
  }
}
