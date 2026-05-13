import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlComment4View extends StatefulWidget {
  @override
  State<GrlComment4View> createState() => _GrlComment4ViewState();
}

class _GrlComment4ViewState extends State<GrlComment4View> {
  String comment = "";
  List<Map<String, dynamic>> comments = [
    {
      "id": "1",
      "user": {
        "name": "Emily Johnson",
        "avatar": "https://picsum.photos/40/40?random=1",
        "verified": true,
      },
      "content": "This is amazing! Really love the concept and execution. Can't wait to see more from this project.",
      "likes": 24,
      "replies": 3,
      "isLiked": false,
      "timestamp": "2h ago",
      "replies_list": [
        {
          "id": "1-1",
          "user": {
            "name": "John Doe",
            "avatar": "https://picsum.photos/40/40?random=2",
            "verified": false,
          },
          "content": "Totally agree! The attention to detail is incredible.",
          "likes": 8,
          "isLiked": true,
          "timestamp": "1h ago",
        },
        {
          "id": "1-2",
          "user": {
            "name": "Sarah Wilson",
            "avatar": "https://picsum.photos/40/40?random=3",
            "verified": false,
          },
          "content": "Same here! Looking forward to the next update.",
          "likes": 5,
          "isLiked": false,
          "timestamp": "45m ago",
        }
      ]
    },
    {
      "id": "2",
      "user": {
        "name": "Michael Chen",
        "avatar": "https://picsum.photos/40/40?random=4",
        "verified": false,
      },
      "content": "Great work! The design is clean and the functionality is smooth. One suggestion: maybe add a dark mode option?",
      "likes": 15,
      "replies": 1,
      "isLiked": true,
      "timestamp": "3h ago",
      "replies_list": [
        {
          "id": "2-1",
          "user": {
            "name": "Alex Rodriguez",
            "avatar": "https://picsum.photos/40/40?random=5",
            "verified": true,
          },
          "content": "Dark mode would be perfect! Great suggestion.",
          "likes": 12,
          "isLiked": false,
          "timestamp": "2h ago",
        }
      ]
    },
    {
      "id": "3",
      "user": {
        "name": "Lisa Thompson",
        "avatar": "https://picsum.photos/40/40?random=6",
        "verified": false,
      },
      "content": "Incredible attention to detail! The user experience is seamless and intuitive. Well done!",
      "likes": 31,
      "replies": 0,
      "isLiked": false,
      "timestamp": "5h ago",
      "replies_list": []
    },
    {
      "id": "4",
      "user": {
        "name": "David Kim",
        "avatar": "https://picsum.photos/40/40?random=7",
        "verified": true,
      },
      "content": "This reminds me of my first project. Keep up the excellent work! 🚀",
      "likes": 18,
      "replies": 2,
      "isLiked": true,
      "timestamp": "6h ago",
      "replies_list": []
    }
  ];
  
  String expandedCommentId = "";
  String replyingToId = "";
  String replyText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
        actions: [
          QButton(
            icon: Icons.sort,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Discussion",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${comments.length} comments",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  // Comments List
                  ...comments.map((comment) => _buildCommentCard(comment)),
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
                  color: disabledColor,
                  width: 1,
                ),
              ),
              boxShadow: [shadowMd],
            ),
            child: Column(
              children: [
                if (replyingToId.isNotEmpty) ...[
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.reply,
                          size: 16,
                          color: primaryColor,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "Replying to ${_getUserNameById(replyingToId)}",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            replyingToId = "";
                            replyText = "";
                            setState(() {});
                          },
                          child: Icon(
                            Icons.close,
                            size: 16,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spSm),
                ],
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: replyingToId.isEmpty ? "Add a comment..." : "Write a reply...",
                        value: replyingToId.isEmpty ? comment : replyText,
                        hint: "Share your thoughts",
                        onChanged: (value) {
                          if (replyingToId.isEmpty) {
                            comment = value;
                          } else {
                            replyText = value;
                          }
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.send,
                      size: bs.sm,
                      onPressed: () {
                        if (replyingToId.isEmpty && comment.isNotEmpty) {
                          _addComment();
                        } else if (replyingToId.isNotEmpty && replyText.isNotEmpty) {
                          _addReply();
                        }
                      },
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

  Widget _buildCommentCard(Map<String, dynamic> comment) {
    final user = comment["user"];
    final isExpanded = expandedCommentId == comment["id"];
    final replies = comment["replies_list"] as List;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage("${user["avatar"]}"),
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
                                "${user["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              if (user["verified"] == true) ...[
                                SizedBox(width: spXs),
                                Icon(
                                  Icons.verified,
                                  size: 16,
                                  color: successColor,
                                ),
                              ],
                            ],
                          ),
                          Text(
                            "${comment["timestamp"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.more_vert,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "${comment["content"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        comment["isLiked"] = !comment["isLiked"];
                        if (comment["isLiked"]) {
                          comment["likes"] = (comment["likes"] as int) + 1;
                        } else {
                          comment["likes"] = (comment["likes"] as int) - 1;
                        }
                        setState(() {});
                      },
                      child: Row(
                        children: [
                          Icon(
                            comment["isLiked"] ? Icons.favorite : Icons.favorite_border,
                            size: 20,
                            color: comment["isLiked"] ? dangerColor : disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${comment["likes"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spMd),
                    GestureDetector(
                      onTap: () {
                        replyingToId = comment["id"];
                        setState(() {});
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.reply,
                            size: 20,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Reply",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if ((comment["replies"] as int) > 0) ...[
                      SizedBox(width: spMd),
                      GestureDetector(
                        onTap: () {
                          expandedCommentId = isExpanded ? "" : comment["id"];
                          setState(() {});
                        },
                        child: Row(
                          children: [
                            Icon(
                              isExpanded ? Icons.expand_less : Icons.expand_more,
                              size: 20,
                              color: primaryColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${comment["replies"]} ${(comment["replies"] as int) == 1 ? 'reply' : 'replies'}",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          
          // Replies
          if (isExpanded && replies.isNotEmpty) ...[
            SizedBox(height: spSm),
            Padding(
              padding: EdgeInsets.only(left: spLg),
              child: Column(
                children: replies.map((reply) => _buildReplyCard(reply)).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildReplyCard(Map<String, dynamic> reply) {
    final user = reply["user"];
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            color: primaryColor,
            width: 3,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage("${user["avatar"]}"),
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
                          "${user["name"]}",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        if (user["verified"] == true) ...[
                          SizedBox(width: spXs),
                          Icon(
                            Icons.verified,
                            size: 14,
                            color: successColor,
                          ),
                        ],
                      ],
                    ),
                    Text(
                      "${reply["timestamp"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${reply["content"]}",
            style: TextStyle(
              fontSize: 13,
              color: primaryColor,
              height: 1.4,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  reply["isLiked"] = !reply["isLiked"];
                  if (reply["isLiked"]) {
                    reply["likes"] = (reply["likes"] as int) + 1;
                  } else {
                    reply["likes"] = (reply["likes"] as int) - 1;
                  }
                  setState(() {});
                },
                child: Row(
                  children: [
                    Icon(
                      reply["isLiked"] ? Icons.favorite : Icons.favorite_border,
                      size: 16,
                      color: reply["isLiked"] ? dangerColor : disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${reply["likes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getUserNameById(String commentId) {
    final comment = comments.firstWhere((c) => c["id"] == commentId);
    return comment["user"]["name"];
  }

  void _addComment() {
    if (comment.trim().isEmpty) return;
    
    final newComment = {
      "id": "${comments.length + 1}",
      "user": {
        "name": "You",
        "avatar": "https://picsum.photos/40/40?random=100",
        "verified": false,
      },
      "content": comment,
      "likes": 0,
      "replies": 0,
      "isLiked": false,
      "timestamp": "now",
      "replies_list": [],
    };
    
    comments.insert(0, newComment);
    comment = "";
    setState(() {});
    
    ss("Comment posted successfully");
  }

  void _addReply() {
    if (replyText.trim().isEmpty) return;
    
    final newReply = {
      "id": "${replyingToId}-${DateTime.now().millisecondsSinceEpoch}",
      "user": {
        "name": "You",
        "avatar": "https://picsum.photos/40/40?random=100",
        "verified": false,
      },
      "content": replyText,
      "likes": 0,
      "isLiked": false,
      "timestamp": "now",
    };
    
    final commentIndex = comments.indexWhere((c) => c["id"] == replyingToId);
    if (commentIndex != -1) {
      (comments[commentIndex]["replies_list"] as List).add(newReply);
      comments[commentIndex]["replies"] = (comments[commentIndex]["replies"] as int) + 1;
    }
    
    replyText = "";
    replyingToId = "";
    setState(() {});
    
    ss("Reply posted successfully");
  }
}
