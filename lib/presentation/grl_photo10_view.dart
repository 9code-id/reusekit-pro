import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPhoto10View extends StatefulWidget {
  @override
  State<GrlPhoto10View> createState() => _GrlPhoto10ViewState();
}

class _GrlPhoto10ViewState extends State<GrlPhoto10View> {
  String comment = "";
  List<Map<String, dynamic>> comments = [
    {
      "id": "1",
      "user": "Emma Davis",
      "avatar": "https://picsum.photos/50/50?random=1&keyword=person",
      "comment": "Absolutely stunning! The composition and lighting are perfect. 📸✨",
      "date": "2 hours ago",
      "likes": 12,
      "isLiked": false,
      "replies": [
        {
          "id": "1-1",
          "user": "John Photographer",
          "avatar": "https://picsum.photos/50/50?random=2&keyword=person",
          "comment": "Thank you so much! I spent hours waiting for the perfect light.",
          "date": "1 hour ago",
          "likes": 5,
          "isLiked": true,
        }
      ],
    },
    {
      "id": "2",
      "user": "Alex Johnson",
      "avatar": "https://picsum.photos/50/50?random=3&keyword=person",
      "comment": "This is the kind of photo that makes me want to pick up my camera and go explore! Amazing work! 🌄",
      "date": "5 hours ago",
      "likes": 8,
      "isLiked": true,
      "replies": [],
    },
    {
      "id": "3",
      "user": "Sarah Chen",
      "avatar": "https://picsum.photos/50/50?random=4&keyword=person",
      "comment": "The way you captured the reflection in the water is just breathtaking. What camera settings did you use?",
      "date": "8 hours ago",
      "likes": 6,
      "isLiked": false,
      "replies": [
        {
          "id": "3-1",
          "user": "John Photographer",
          "avatar": "https://picsum.photos/50/50?random=2&keyword=person",
          "comment": "Thanks! I used f/8, 1/250s, ISO 100. The key was the polarizing filter! 📷",
          "date": "7 hours ago",
          "likes": 3,
          "isLiked": false,
        },
        {
          "id": "3-2",
          "user": "Mike Wilson",
          "avatar": "https://picsum.photos/50/50?random=5&keyword=person",
          "comment": "Great tip about the polarizing filter! Thanks for sharing! 👍",
          "date": "6 hours ago",
          "likes": 2,
          "isLiked": false,
        }
      ],
    },
    {
      "id": "4",
      "user": "David Park",
      "avatar": "https://picsum.photos/50/50?random=6&keyword=person",
      "comment": "This should be featured in National Geographic! Absolutely professional quality.",
      "date": "12 hours ago",
      "likes": 15,
      "isLiked": true,
      "replies": [],
    },
    {
      "id": "5",
      "user": "Lisa Rodriguez",
      "avatar": "https://picsum.photos/50/50?random=7&keyword=person",
      "comment": "I've been following your work for months and this is definitely one of your best shots! Keep it up! 🔥",
      "date": "1 day ago",
      "likes": 9,
      "isLiked": false,
      "replies": [],
    },
  ];

  Map<String, dynamic> photoInfo = {
    "title": "Alpine Lake Reflection",
    "photographer": "John Photographer",
    "photographerAvatar": "https://picsum.photos/50/50?random=2&keyword=person",
    "url": "https://picsum.photos/400/600?random=1&keyword=lake",
    "description": "A pristine alpine lake perfectly reflecting the snow-capped mountains above, captured during the golden hour. This shot required a 3-hour hike to reach this remote location in the Swiss Alps.",
    "location": "Swiss Alps, Switzerland",
    "date": "December 20, 2024",
    "camera": "Canon EOS R5",
    "settings": "f/8.0, 1/250s, ISO 100",
    "likes": 342,
    "views": 2100,
    "downloads": 89,
    "commentsCount": 24,
  };

  void _toggleCommentLike(String commentId, [String? replyId]) {
    setState(() {
      if (replyId != null) {
        // Toggle reply like
        final comment = comments.firstWhere((c) => c["id"] == commentId);
        final reply = (comment["replies"] as List).firstWhere((r) => r["id"] == replyId);
        reply["isLiked"] = !reply["isLiked"];
        if (reply["isLiked"]) {
          reply["likes"] = (reply["likes"] as int) + 1;
        } else {
          reply["likes"] = (reply["likes"] as int) - 1;
        }
      } else {
        // Toggle comment like
        final comment = comments.firstWhere((c) => c["id"] == commentId);
        comment["isLiked"] = !comment["isLiked"];
        if (comment["isLiked"]) {
          comment["likes"] = (comment["likes"] as int) + 1;
        } else {
          comment["likes"] = (comment["likes"] as int) - 1;
        }
      }
    });
  }

  void _postComment() {
    if (comment.trim().isNotEmpty) {
      setState(() {
        comments.insert(0, {
          "id": "${comments.length + 1}",
          "user": "You",
          "avatar": "https://picsum.photos/50/50?random=100&keyword=person",
          "comment": comment.trim(),
          "date": "Just now",
          "likes": 0,
          "isLiked": false,
          "replies": [],
        });
        comment = "";
      });
      ss("Comment posted successfully");
    }
  }

  Widget _buildReply(Map<String, dynamic> reply, String parentCommentId) {
    return Container(
      margin: EdgeInsets.only(top: spXs, left: spLg),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: disabledColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusXs),
              image: DecorationImage(
                image: NetworkImage("${reply["avatar"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          SizedBox(width: spSm),
          
          // Reply Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${reply["user"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${reply["date"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  "${reply["comment"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => _toggleCommentLike(parentCommentId, reply["id"]),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            (reply["isLiked"] as bool) ? Icons.favorite : Icons.favorite_border,
                            size: 12,
                            color: (reply["isLiked"] as bool) ? dangerColor : disabledColor,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "${reply["likes"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Reply",
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
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
    );
  }

  Widget _buildComment(Map<String, dynamic> commentData) {
    final replies = commentData["replies"] as List;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${commentData["avatar"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              SizedBox(width: spSm),
              
              // Comment Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${commentData["user"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${commentData["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      "${commentData["comment"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => _toggleCommentLike(commentData["id"]),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                (commentData["isLiked"] as bool) ? Icons.favorite : Icons.favorite_border,
                                size: 16,
                                color: (commentData["isLiked"] as bool) ? dangerColor : disabledColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${commentData["likes"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spMd),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Reply",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spMd),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.more_horiz,
                            size: 16,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          // Replies
          if (replies.isNotEmpty)
            Column(
              children: replies.map((reply) => _buildReply(reply, commentData["id"])).toList(),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Photo Info Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Photo
                Container(
                  height: 200,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radiusLg),
                    child: Image.network(
                      "${photoInfo["url"]}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                SizedBox(height: spMd),
                
                // Photo Details
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        image: DecorationImage(
                          image: NetworkImage("${photoInfo["photographerAvatar"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${photoInfo["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "by ${photoInfo["photographer"]}",
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
                
                SizedBox(height: spSm),
                
                // Stats
                Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      size: 16,
                      color: dangerColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${photoInfo["likes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(
                      Icons.visibility,
                      size: 16,
                      color: infoColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${photoInfo["views"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(
                      Icons.comment,
                      size: 16,
                      color: primaryColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${photoInfo["commentsCount"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Comments Section
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Comments Header
                  Row(
                    children: [
                      Text(
                        "Comments (${comments.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Sort by Latest",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.sort,
                        size: 16,
                        color: primaryColor,
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Comments List
                  ...comments.map((commentData) => _buildComment(commentData)).toList(),
                  
                  // Load More
                  if (comments.length >= 5)
                    Center(
                      child: QButton(
                        label: "Load More Comments",
                        size: bs.sm,
                        color: disabledBoldColor,
                        onPressed: () {},
                      ),
                    ),
                ],
              ),
            ),
          ),
          
          // Comment Input
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                // User Avatar
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                    image: DecorationImage(
                      image: NetworkImage("https://picsum.photos/50/50?random=100&keyword=person"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                SizedBox(width: spSm),
                
                // Comment Input
                Expanded(
                  child: QTextField(
                    label: "Add a comment...",
                    value: comment,
                    hint: "Share your thoughts about this photo",
                    onChanged: (value) {
                      comment = value;
                      setState(() {});
                    },
                  ),
                ),
                
                SizedBox(width: spSm),
                
                // Post Button
                QButton(
                  label: "Post",
                  size: bs.sm,
                  onPressed: comment.trim().isNotEmpty ? _postComment : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
