import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaPostDetailView extends StatefulWidget {
  const SmaPostDetailView({super.key});

  @override
  State<SmaPostDetailView> createState() => _SmaPostDetailViewState();
}

class _SmaPostDetailViewState extends State<SmaPostDetailView> {
  String newComment = "";
  bool isLiked = false;
  bool isBookmarked = false;
  bool showAllComments = false;
  String selectedReaction = "";

  Map<String, dynamic> post = {
    "id": "post_001",
    "authorId": "user_002",
    "authorName": "Sarah Johnson",
    "authorUsername": "@sarah_j",
    "authorAvatar": "https://picsum.photos/100/100?random=1&keyword=woman",
    "isVerified": true,
    "content": "Just finished my morning workout at the new gym downtown! The facilities are amazing and the trainers are so helpful. Can't wait to get back there tomorrow. Who wants to join me? 💪 #fitness #morning #workout",
    "images": [
      "https://picsum.photos/400/300?random=10&keyword=gym",
      "https://picsum.photos/400/300?random=11&keyword=fitness",
    ],
    "location": "Downtown Fitness Center",
    "createdAt": "2024-03-15T08:30:00Z",
    "privacy": "friends",
    "likes": 142,
    "comments": 28,
    "shares": 12,
    "views": 856,
    "tags": ["@alice_j", "@mike_workout"],
    "hashtags": ["#fitness", "#morning", "#workout"],
  };

  List<Map<String, dynamic>> reactions = [
    {"type": "like", "emoji": "👍", "count": 89},
    {"type": "love", "emoji": "❤️", "count": 32},
    {"type": "wow", "emoji": "😮", "count": 15},
    {"type": "laugh", "emoji": "😂", "count": 6},
    {"type": "support", "emoji": "💪", "count": 12},
  ];

  List<Map<String, dynamic>> comments = [
    {
      "id": "comment_001",
      "authorId": "user_003",
      "authorName": "Mike Wilson",
      "authorUsername": "@mike_workout",
      "authorAvatar": "https://picsum.photos/100/100?random=3&keyword=man",
      "content": "Great workout session! That gym really is amazing. Thanks for the recommendation!",
      "createdAt": "2024-03-15T09:15:00Z",
      "likes": 8,
      "replies": 2,
      "isLiked": false,
    },
    {
      "id": "comment_002",
      "authorId": "user_004",
      "authorName": "Alice Thompson",
      "authorUsername": "@alice_j",
      "authorAvatar": "https://picsum.photos/100/100?random=4&keyword=woman",
      "content": "I'm definitely joining you tomorrow! What time are we meeting?",
      "createdAt": "2024-03-15T10:22:00Z",
      "likes": 12,
      "replies": 1,
      "isLiked": true,
    },
    {
      "id": "comment_003",
      "authorId": "user_005",
      "authorName": "Emma Davis",
      "authorUsername": "@emma_fitness",
      "authorAvatar": "https://picsum.photos/100/100?random=5&keyword=woman",
      "content": "Love the energy! Those trainers really know their stuff. Been going there for months now.",
      "createdAt": "2024-03-15T11:45:00Z",
      "likes": 5,
      "replies": 0,
      "isLiked": false,
    },
    {
      "id": "comment_004",
      "authorId": "user_006",
      "authorName": "David Brown",
      "authorUsername": "@david_fitness",
      "authorAvatar": "https://picsum.photos/100/100?random=6&keyword=man",
      "content": "Which trainer did you work with? I'm looking for someone to help with my form on deadlifts.",
      "createdAt": "2024-03-15T12:30:00Z",
      "likes": 3,
      "replies": 1,
      "isLiked": false,
    },
  ];

  void _toggleLike() {
    isLiked = !isLiked;
    if (isLiked) {
      post["likes"] = (post["likes"] as int) + 1;
    } else {
      post["likes"] = (post["likes"] as int) - 1;
    }
    setState(() {});
  }

  void _toggleBookmark() {
    isBookmarked = !isBookmarked;
    setState(() {});
    ss(isBookmarked ? "Post saved to bookmarks" : "Post removed from bookmarks");
  }

  void _selectReaction(String reactionType) {
    selectedReaction = selectedReaction == reactionType ? "" : reactionType;
    setState(() {});
  }

  void _sharePost() {
    ss("Post shared successfully!");
  }

  void _addComment() {
    if (newComment.trim().isEmpty) {
      se("Please write a comment");
      return;
    }

    Map<String, dynamic> comment = {
      "id": "comment_${comments.length + 1}",
      "authorId": "current_user",
      "authorName": "You",
      "authorUsername": "@you",
      "authorAvatar": "https://picsum.photos/100/100?random=99&keyword=person",
      "content": newComment,
      "createdAt": DateTime.now().toIso8601String(),
      "likes": 0,
      "replies": 0,
      "isLiked": false,
    };

    comments.insert(0, comment);
    post["comments"] = (post["comments"] as int) + 1;
    newComment = "";
    setState(() {});
    ss("Comment added successfully!");
  }

  void _toggleCommentLike(int index) {
    comments[index]["isLiked"] = !(comments[index]["isLiked"] as bool);
    if (comments[index]["isLiked"] as bool) {
      comments[index]["likes"] = (comments[index]["likes"] as int) + 1;
    } else {
      comments[index]["likes"] = (comments[index]["likes"] as int) - 1;
    }
    setState(() {});
  }

  String _formatTimeAgo(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(date);

    if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h";
    } else if (difference.inDays < 7) {
      return "${difference.inDays}d";
    } else {
      return "${date.day}/${date.month}/${date.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> displayComments = showAllComments ? comments : comments.take(3).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Post"),
        actions: [
          QButton(
            icon: Icons.more_vert,
            size: bs.sm,
            onPressed: () {
              // Show more options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Post Header
                  Container(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundImage: NetworkImage("${post["authorAvatar"]}"),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${post["authorName"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  if (post["isVerified"] as bool) ...[
                                    SizedBox(width: 4),
                                    Icon(
                                      Icons.verified,
                                      color: primaryColor,
                                      size: 14,
                                    ),
                                  ],
                                ],
                              ),
                              Text(
                                "${post["authorUsername"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    _formatTimeAgo("${post["createdAt"]}"),
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Icon(
                                    post["privacy"] == "public" ? Icons.public : Icons.people,
                                    size: 12,
                                    color: disabledBoldColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          icon: isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          size: bs.sm,
                          onPressed: _toggleBookmark,
                        ),
                      ],
                    ),
                  ),

                  // Post Content
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    child: Text(
                      "${post["content"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        height: 1.4,
                      ),
                    ),
                  ),

                  // Post Images
                  if ((post["images"] as List).isNotEmpty) ...[
                    SizedBox(height: spMd),
                    Container(
                      height: 300,
                      child: QHorizontalScroll(
                        children: (post["images"] as List).map((imageUrl) {
                          return Container(
                            width: 280,
                            margin: EdgeInsets.only(left: spMd, right: spSm),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(radiusMd),
                              child: Image.network(
                                "$imageUrl",
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],

                  // Location
                  if (post["location"] != null && "${post["location"]}".isNotEmpty) ...[
                    SizedBox(height: spMd),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spMd),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 14,
                            color: secondaryColor,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "${post["location"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: secondaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  SizedBox(height: spMd),

                  // Reactions Summary
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    child: Row(
                      children: [
                        Container(
                          height: 20,
                          child: QHorizontalScroll(
                            children: reactions.where((r) => (r["count"] as int) > 0).map((reaction) {
                              return Container(
                                margin: EdgeInsets.only(right: 4),
                                child: Text(
                                  "${reaction["emoji"]}",
                                  style: TextStyle(fontSize: 16),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${post["likes"]} reactions",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${post["comments"]} comments",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${post["shares"]} shares",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spSm),
                  Divider(height: 1),
                  SizedBox(height: spSm),

                  // Action Buttons
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    child: Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: isLiked ? "Liked" : "Like",
                            icon: isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                            size: bs.sm,
                            onPressed: _toggleLike,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Comment",
                            icon: Icons.comment_outlined,
                            size: bs.sm,
                            onPressed: () {
                              // Focus comment input
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Share",
                            icon: Icons.share_outlined,
                            size: bs.sm,
                            onPressed: _sharePost,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spMd),

                  // Reaction Options
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "React to this post:",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Container(
                          height: 40,
                          child: QHorizontalScroll(
                            children: reactions.map((reaction) {
                              bool isSelected = selectedReaction == reaction["type"];
                              return GestureDetector(
                                onTap: () => _selectReaction("${reaction["type"]}"),
                                child: Container(
                                  margin: EdgeInsets.only(right: spSm),
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: isSelected ? primaryColor.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    border: Border.all(
                                      color: isSelected ? primaryColor : Colors.transparent,
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "${reaction["emoji"]}",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${reaction["count"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: isSelected ? primaryColor : disabledBoldColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spMd),
                  Divider(height: 1),
                  SizedBox(height: spMd),

                  // Comments Section
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Comments",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            if (comments.length > 3 && !showAllComments)
                              QButton(
                                label: "View all ${comments.length} comments",
                                size: bs.sm,
                                onPressed: () {
                                  showAllComments = true;
                                  setState(() {});
                                },
                              ),
                          ],
                        ),
                        SizedBox(height: spMd),

                        Column(
                          children: displayComments.asMap().entries.map((entry) {
                            int index = entry.key;
                            Map<String, dynamic> comment = entry.value;
                            bool isCommentLiked = comment["isLiked"] as bool;

                            return Container(
                              margin: EdgeInsets.only(bottom: spMd),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 16,
                                    backgroundImage: NetworkImage("${comment["authorAvatar"]}"),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(spSm),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withValues(alpha: 0.1),
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${comment["authorName"]}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryColor,
                                                ),
                                              ),
                                              SizedBox(height: 2),
                                              Text(
                                                "${comment["content"]}",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: primaryColor,
                                                  height: 1.3,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Text(
                                              _formatTimeAgo("${comment["createdAt"]}"),
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            SizedBox(width: spSm),
                                            GestureDetector(
                                              onTap: () => _toggleCommentLike(index),
                                              child: Text(
                                                isCommentLiked ? "Liked" : "Like",
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: isCommentLiked ? primaryColor : disabledBoldColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: spSm),
                                            Text(
                                              "Reply",
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: disabledBoldColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            if ((comment["likes"] as int) > 0) ...[
                                              Spacer(),
                                              Icon(
                                                Icons.thumb_up,
                                                size: 10,
                                                color: primaryColor,
                                              ),
                                              SizedBox(width: 2),
                                              Text(
                                                "${comment["likes"]}",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
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
                  color: Colors.grey.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: primaryColor,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QTextField(
                    label: "Write a comment...",
                    value: newComment,
                    hint: "Share your thoughts",
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
                  onPressed: newComment.trim().isNotEmpty ? _addComment : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
