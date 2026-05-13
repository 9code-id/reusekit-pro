import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaCommentsView extends StatefulWidget {
  const NmaCommentsView({super.key});

  @override
  State<NmaCommentsView> createState() => _NmaCommentsViewState();
}

class _NmaCommentsViewState extends State<NmaCommentsView> {
  String newComment = "";
  String replyText = "";
  int? replyingTo;
  bool showReplies = false;

  List<Map<String, dynamic>> comments = [
    {
      "id": 1,
      "author": "Sarah Johnson",
      "avatar": "https://picsum.photos/40/40?random=1&keyword=profile",
      "time": "2 hours ago",
      "content": "This is exactly what we needed to hear from our local government. Transparency is key to building trust with citizens.",
      "likes": 24,
      "replies": 3,
      "isLiked": true,
      "verified": true,
    },
    {
      "id": 2,
      "author": "Michael Chen",
      "avatar": "https://picsum.photos/40/40?random=2&keyword=profile",
      "time": "3 hours ago",
      "content": "Great article! I hope this leads to more community engagement and better policies for our neighborhood.",
      "likes": 18,
      "replies": 1,
      "isLiked": false,
      "verified": false,
    },
    {
      "id": 3,
      "author": "Amanda Rodriguez",
      "avatar": "https://picsum.photos/40/40?random=3&keyword=profile",
      "time": "4 hours ago",
      "content": "Finally someone is addressing the issues we've been facing for months. Thank you for bringing this to light!",
      "likes": 32,
      "replies": 5,
      "isLiked": true,
      "verified": true,
    },
  ];

  List<Map<String, dynamic>> replies = [
    {
      "id": 1,
      "parentId": 1,
      "author": "David Kim",
      "avatar": "https://picsum.photos/40/40?random=4&keyword=profile",
      "time": "1 hour ago",
      "content": "Absolutely agree! We need more journalists covering local politics.",
      "likes": 8,
      "isLiked": false,
    },
    {
      "id": 2,
      "parentId": 1,
      "author": "Lisa Thompson",
      "avatar": "https://picsum.photos/40/40?random=5&keyword=profile",
      "time": "30 minutes ago",
      "content": "This article changed my perspective on the issue completely.",
      "likes": 5,
      "isLiked": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
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
          // Article summary
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusSm),
                  child: Image.network(
                    "https://picsum.photos/60/60?random=10&keyword=news",
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Local Government Announces New Infrastructure Plan",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "By News Team • 5 hours ago",
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
          ),

          // Comments header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Text(
                  "${comments.length} Comments",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Top Comments",
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

          // Comments list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  child: Column(
                    children: [
                      _buildCommentCard(comment),
                      if (showReplies && (comment["replies"] as int) > 0)
                        Container(
                          margin: EdgeInsets.only(left: spLg, top: spSm),
                          child: Column(
                            children: replies
                                .where((reply) => reply["parentId"] == comment["id"])
                                .map((reply) => Container(
                                      margin: EdgeInsets.only(bottom: spSm),
                                      child: _buildReplyCard(reply),
                                    ))
                                .toList(),
                          ),
                        ),
                      if (replyingTo == comment["id"])
                        Container(
                          margin: EdgeInsets.only(left: spLg, top: spSm),
                          child: _buildReplyInput(),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Comment input
          _buildCommentInput(),
        ],
      ),
    );
  }

  Widget _buildCommentCard(Map<String, dynamic> comment) {
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
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage("${comment["avatar"]}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${comment["author"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        if (comment["verified"] as bool)
                          Container(
                            margin: EdgeInsets.only(left: spXs),
                            child: Icon(
                              Icons.verified,
                              size: 14,
                              color: successColor,
                            ),
                          ),
                      ],
                    ),
                    Text(
                      "${comment["time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.more_vert,
                  size: 16,
                  color: disabledBoldColor,
                ),
                onPressed: () {},
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
          SizedBox(height: spSm),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  comment["isLiked"] = !(comment["isLiked"] as bool);
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
                      comment["isLiked"] as bool ? Icons.favorite : Icons.favorite_border,
                      size: 16,
                      color: comment["isLiked"] as bool ? dangerColor : disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${comment["likes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spMd),
              GestureDetector(
                onTap: () {
                  replyingTo = replyingTo == comment["id"] ? null : comment["id"];
                  setState(() {});
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.reply,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Reply",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              if ((comment["replies"] as int) > 0) ...[
                SizedBox(width: spMd),
                GestureDetector(
                  onTap: () {
                    showReplies = !showReplies;
                    setState(() {});
                  },
                  child: Row(
                    children: [
                      Icon(
                        showReplies ? Icons.expand_less : Icons.expand_more,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${comment["replies"]} replies",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              Spacer(),
              Text(
                "Share",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReplyCard(Map<String, dynamic> reply) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: disabledColor.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundImage: NetworkImage("${reply["avatar"]}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${reply["author"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${reply["time"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "${reply["content"]}",
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
              height: 1.3,
            ),
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  reply["isLiked"] = !(reply["isLiked"] as bool);
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
                      reply["isLiked"] as bool ? Icons.favorite : Icons.favorite_border,
                      size: 14,
                      color: reply["isLiked"] as bool ? dangerColor : disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${reply["likes"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "Reply",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCommentInput() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: disabledOutlineBorderColor,
            width: 1,
          ),
        ),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage("https://picsum.photos/40/40?random=99&keyword=profile"),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QTextField(
              label: "Add a comment...",
              value: newComment,
              hint: "Share your thoughts on this article",
              onChanged: (value) {
                newComment = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.send,
            size: bs.sm,
            onPressed: newComment.isNotEmpty ? () {
              // Add comment logic
              newComment = "";
              setState(() {});
            } : null,
          ),
        ],
      ),
    );
  }

  Widget _buildReplyInput() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: disabledColor.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundImage: NetworkImage("https://picsum.photos/40/40?random=99&keyword=profile"),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QTextField(
              label: "Write a reply...",
              value: replyText,
              onChanged: (value) {
                replyText = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.send,
            size: bs.sm,
            onPressed: replyText.isNotEmpty ? () {
              // Add reply logic
              replyText = "";
              replyingTo = null;
              setState(() {});
            } : null,
          ),
        ],
      ),
    );
  }
}
