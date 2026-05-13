import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlComment6View extends StatefulWidget {
  @override
  State<GrlComment6View> createState() => _GrlComment6ViewState();
}

class _GrlComment6ViewState extends State<GrlComment6View> {
  String comment = "";
  String selectedSortBy = "Newest";
  List<String> sortOptions = ["Newest", "Oldest", "Most Liked", "Most Replies"];
  
  List<Map<String, dynamic>> threadComments = [
    {
      "id": "1",
      "user": {
        "name": "Dr. Sarah Mitchell",
        "avatar": "https://picsum.photos/40/40?random=21",
        "title": "Senior Developer",
        "company": "Tech Solutions Inc.",
        "verified": true,
        "online": true,
      },
      "content": "I've been implementing this pattern for the past few months and the results are incredible. The performance improvements alone justify the learning curve. Here's a detailed breakdown of what I've discovered:\n\n1. Memory usage reduced by 40%\n2. Load times improved by 60%\n3. User engagement increased significantly\n\nWould love to hear about others' experiences!",
      "likes": 156,
      "dislikes": 3,
      "replies": 23,
      "views": 1204,
      "isLiked": true,
      "isDisliked": false,
      "timestamp": "3h ago",
      "edited": true,
      "editTime": "2h ago",
      "tags": ["Performance", "Best Practices", "Architecture"],
      "codeSnippet": true,
      "images": ["https://picsum.photos/300/200?random=1"],
      "thread": [
        {
          "id": "1-1",
          "user": {
            "name": "Alex Rodriguez",
            "avatar": "https://picsum.photos/40/40?random=22",
            "title": "Full Stack Developer",
            "verified": false,
            "online": true,
          },
          "content": "This is exactly what our team needed! The memory optimization tips are gold. Quick question - did you encounter any issues with state persistence?",
          "likes": 45,
          "dislikes": 0,
          "isLiked": false,
          "isDisliked": false,
          "timestamp": "2h ago",
          "thread": [
            {
              "id": "1-1-1",
              "user": {
                "name": "Dr. Sarah Mitchell",
                "avatar": "https://picsum.photos/40/40?random=21",
                "title": "Senior Developer",
                "verified": true,
                "online": true,
              },
              "content": "Great question! We did face some challenges initially. The key is implementing proper cleanup in your dispose methods. I can share our solution if you're interested.",
              "likes": 32,
              "dislikes": 0,
              "isLiked": true,
              "isDisliked": false,
              "timestamp": "1h ago",
            }
          ]
        },
        {
          "id": "1-2",
          "user": {
            "name": "Emma Chen",
            "avatar": "https://picsum.photos/40/40?random=23",
            "title": "UI/UX Designer",
            "verified": false,
            "online": false,
          },
          "content": "From a design perspective, this approach allows for much smoother animations and transitions. Users definitely notice the difference!",
          "likes": 28,
          "dislikes": 1,
          "isLiked": true,
          "isDisliked": false,
          "timestamp": "1h ago",
          "thread": []
        }
      ]
    },
    {
      "id": "2",
      "user": {
        "name": "Michael Foster",
        "avatar": "https://picsum.photos/40/40?random=24",
        "title": "Lead Architect",
        "company": "Innovation Labs",
        "verified": true,
        "online": false,
      },
      "content": "Interesting approach! I've been working on something similar. One concern I have is maintainability in large teams. How do you handle code reviews and ensure consistency across different developers?",
      "likes": 89,
      "dislikes": 5,
      "replies": 15,
      "views": 892,
      "isLiked": false,
      "isDisliked": false,
      "timestamp": "5h ago",
      "edited": false,
      "editTime": "",
      "tags": ["Team Management", "Code Review", "Scalability"],
      "codeSnippet": false,
      "images": [],
      "thread": [
        {
          "id": "2-1",
          "user": {
            "name": "Jennifer Park",
            "avatar": "https://picsum.photos/40/40?random=25",
            "title": "DevOps Engineer",
            "verified": false,
            "online": true,
          },
          "content": "We've implemented automated linting rules and pre-commit hooks that catch most consistency issues. Works great for our 12-person team!",
          "likes": 22,
          "dislikes": 0,
          "isLiked": false,
          "isDisliked": false,
          "timestamp": "4h ago",
          "thread": []
        }
      ]
    },
    {
      "id": "3",
      "user": {
        "name": "Carlos Mendez",
        "avatar": "https://picsum.photos/40/40?random=26",
        "title": "Mobile Developer",
        "company": "StartupXYZ",
        "verified": false,
        "online": true,
      },
      "content": "Has anyone tried this approach with React Native? I'm curious about cross-platform compatibility and performance differences.",
      "likes": 34,
      "dislikes": 2,
      "replies": 8,
      "views": 456,
      "isLiked": true,
      "isDisliked": false,
      "timestamp": "1d ago",
      "edited": false,
      "editTime": "",
      "tags": ["React Native", "Cross Platform", "Mobile"],
      "codeSnippet": false,
      "images": [],
      "thread": []
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discussion Thread"),
        actions: [
          QButton(
            icon: Icons.bookmark_border,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.share,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Column(
        children: [
          // Thread Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              border: Border(
                bottom: BorderSide(color: disabledColor, width: 1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.forum,
                      color: primaryColor,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Advanced Flutter Architecture Discussion",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${threadComments.length} participants • ${_getTotalReplies()} replies",
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
                SizedBox(height: spMd),
                Row(
                  children: [
                    Text(
                      "Sort by:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QCategoryPicker(
                        items: sortOptions.map((option) => {
                          "label": option,
                          "value": option,
                        }).toList(),
                        value: selectedSortBy,
                        onChanged: (index, label, value, item) {
                          selectedSortBy = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: threadComments.map((comment) => _buildThreadComment(comment, 0)).toList(),
              ),
            ),
          ),

          // Enhanced Comment Input
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowLg],
              border: Border(
                top: BorderSide(color: disabledColor, width: 1),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: "Add to the discussion...",
                        value: comment,
                        hint: "Share your expertise and insights",
                        onChanged: (value) {
                          comment = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    QButton(
                      icon: Icons.code,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.image,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.link,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.tag,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    Spacer(),
                    QButton(
                      label: "Post",
                      size: bs.sm,
                      onPressed: comment.isNotEmpty ? () {
                        _postComment();
                      } : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThreadComment(Map<String, dynamic> comment, int depth) {
    final user = comment["user"];
    final thread = comment["thread"] as List? ?? [];
    
    return Container(
      margin: EdgeInsets.only(
        bottom: spMd,
        left: depth * 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: depth == 0 ? Colors.white : primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: depth == 0 ? [shadowMd] : [shadowXs],
              border: depth > 0 ? Border(
                left: BorderSide(
                  color: primaryColor.withAlpha(50),
                  width: 2,
                ),
              ) : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Header
                Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: depth == 0 ? 48 : 36,
                          height: depth == 0 ? 48 : 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage("${user["avatar"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        if (user["online"] == true)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: successColor,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                            ),
                          ),
                      ],
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
                                  fontSize: depth == 0 ? 15 : 13,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              if (user["verified"] == true) ...[
                                SizedBox(width: spXs),
                                Icon(
                                  Icons.verified,
                                  size: depth == 0 ? 16 : 14,
                                  color: successColor,
                                ),
                              ],
                            ],
                          ),
                          if (user["title"] != null) ...[
                            Text(
                              "${user["title"]}${user["company"] != null ? ' • ${user["company"]}' : ''}",
                              style: TextStyle(
                                fontSize: depth == 0 ? 12 : 11,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                          Row(
                            children: [
                              Text(
                                "${comment["timestamp"]}",
                                style: TextStyle(
                                  fontSize: depth == 0 ? 12 : 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              if (comment["edited"] == true) ...[
                                Text(
                                  " • edited ${comment["editTime"]}",
                                  style: TextStyle(
                                    fontSize: depth == 0 ? 12 : 11,
                                    color: disabledBoldColor,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (depth == 0) ...[
                      Column(
                        children: [
                          Icon(
                            Icons.visibility,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          Text(
                            "${comment["views"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: spSm),
                    ],
                    QButton(
                      icon: Icons.more_vert,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),

                SizedBox(height: spMd),

                // Tags
                if (comment["tags"] != null && (comment["tags"] as List).isNotEmpty) ...[
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (comment["tags"] as List).map((tag) => Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "$tag",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    )).toList(),
                  ),
                  SizedBox(height: spSm),
                ],

                // Comment Content
                Text(
                  "${comment["content"]}",
                  style: TextStyle(
                    fontSize: depth == 0 ? 14 : 13,
                    color: primaryColor,
                    height: 1.5,
                  ),
                ),

                // Images
                if (comment["images"] != null && (comment["images"] as List).isNotEmpty) ...[
                  SizedBox(height: spMd),
                  QHorizontalScroll(
                    children: (comment["images"] as List).map((imageUrl) => Container(
                      width: 200,
                      height: 120,
                      margin: EdgeInsets.only(right: spSm),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        image: DecorationImage(
                          image: NetworkImage("$imageUrl"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )).toList(),
                  ),
                ],

                if (comment["codeSnippet"] == true) ...[
                  SizedBox(height: spMd),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: disabledColor),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.code,
                          size: 16,
                          color: primaryColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "View code snippet",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                SizedBox(height: spMd),

                // Actions
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        comment["isLiked"] = !comment["isLiked"];
                        if (comment["isLiked"]) {
                          comment["likes"] = (comment["likes"] as int) + 1;
                          comment["isDisliked"] = false;
                        } else {
                          comment["likes"] = (comment["likes"] as int) - 1;
                        }
                        setState(() {});
                      },
                      child: Row(
                        children: [
                          Icon(
                            comment["isLiked"] ? Icons.thumb_up : Icons.thumb_up_outlined,
                            size: 18,
                            color: comment["isLiked"] ? primaryColor : disabledBoldColor,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "${comment["likes"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: comment["isLiked"] ? primaryColor : disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () {
                        comment["isDisliked"] = !comment["isDisliked"];
                        if (comment["isDisliked"]) {
                          comment["dislikes"] = (comment["dislikes"] as int) + 1;
                          comment["isLiked"] = false;
                        } else {
                          comment["dislikes"] = (comment["dislikes"] as int) - 1;
                        }
                        setState(() {});
                      },
                      child: Row(
                        children: [
                          Icon(
                            comment["isDisliked"] ? Icons.thumb_down : Icons.thumb_down_outlined,
                            size: 18,
                            color: comment["isDisliked"] ? dangerColor : disabledBoldColor,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "${comment["dislikes"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: comment["isDisliked"] ? dangerColor : disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spLg),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.reply,
                            size: 18,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Reply",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (depth == 0 && comment["replies"] != null && (comment["replies"] as int) > 0) ...[
                      SizedBox(width: spLg),
                      Text(
                        "${comment["replies"]} replies",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          // Thread Replies
          if (thread.isNotEmpty) ...[
            SizedBox(height: spSm),
            ...thread.map((reply) => _buildThreadComment(reply, depth + 1)),
          ],
        ],
      ),
    );
  }

  int _getTotalReplies() {
    int total = 0;
    for (var comment in threadComments) {
      total += (comment["replies"] as int? ?? 0);
      if (comment["thread"] != null) {
        total += (comment["thread"] as List).length;
        for (var reply in comment["thread"] as List) {
          if (reply["thread"] != null) {
            total += (reply["thread"] as List).length;
          }
        }
      }
    }
    return total;
  }

  void _postComment() {
    if (comment.trim().isEmpty) return;
    
    final newComment = {
      "id": "${threadComments.length + 1}",
      "user": {
        "name": "You",
        "avatar": "https://picsum.photos/40/40?random=100",
        "title": "Developer",
        "company": "Your Company",
        "verified": false,
        "online": true,
      },
      "content": comment,
      "likes": 0,
      "dislikes": 0,
      "replies": 0,
      "views": 1,
      "isLiked": false,
      "isDisliked": false,
      "timestamp": "now",
      "edited": false,
      "editTime": "",
      "tags": [],
      "codeSnippet": false,
      "images": [],
      "thread": [],
    };
    
    threadComments.insert(0, newComment);
    comment = "";
    setState(() {});
    
    ss("Comment posted successfully!");
  }
}
