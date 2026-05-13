import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlArticle10View extends StatefulWidget {
  @override
  State<GrlArticle10View> createState() => _GrlArticle10ViewState();
}

class _GrlArticle10ViewState extends State<GrlArticle10View> {
  List<Map<String, dynamic>> comments = [
    {
      "id": 1,
      "author": "Michael Chen",
      "authorImage": "https://picsum.photos/50/50?random=1&keyword=man",
      "content": "Excellent article! The insights on AI applications in healthcare are particularly valuable. I'd love to see more discussion on the ethical implications.",
      "timestamp": "2 hours ago",
      "likes": 24,
      "isLiked": false,
      "replies": [
        {
          "id": 11,
          "author": "Dr. Sarah Johnson",
          "authorImage": "https://picsum.photos/50/50?random=2&keyword=woman",
          "content": "Thank you for the feedback! I'm actually working on a follow-up article about AI ethics in healthcare. Stay tuned!",
          "timestamp": "1 hour ago",
          "likes": 12,
          "isLiked": false,
          "isAuthor": true,
        }
      ]
    },
    {
      "id": 2,
      "author": "Lisa Rodriguez",
      "authorImage": "https://picsum.photos/50/50?random=3&keyword=professional",
      "content": "The section on machine learning algorithms was incredibly detailed. As someone working in the pharma industry, this gives me great ideas for our research pipeline.",
      "timestamp": "4 hours ago",
      "likes": 18,
      "isLiked": true,
      "replies": []
    },
    {
      "id": 3,
      "author": "James Wilson",
      "authorImage": "https://picsum.photos/50/50?random=4&keyword=doctor",
      "content": "I appreciate the balanced perspective on AI limitations. Too often we see overly optimistic predictions without acknowledging the current challenges.",
      "timestamp": "6 hours ago",
      "likes": 31,
      "isLiked": false,
      "replies": [
        {
          "id": 31,
          "author": "Amanda Kim",
          "authorImage": "https://picsum.photos/50/50?random=5&keyword=nurse",
          "content": "Absolutely agree! The regulatory hurdles alone are significant challenges that need more attention.",
          "timestamp": "5 hours ago",
          "likes": 8,
          "isLiked": false,
        }
      ]
    },
    {
      "id": 4,
      "author": "David Park",
      "authorImage": "https://picsum.photos/50/50?random=6&keyword=scientist",
      "content": "Could you elaborate more on the data privacy concerns? This seems like a critical issue that deserves deeper discussion.",
      "timestamp": "8 hours ago",
      "likes": 15,
      "isLiked": false,
      "replies": []
    },
    {
      "id": 5,
      "author": "Rachel Thompson",
      "authorImage": "https://picsum.photos/50/50?random=7&keyword=researcher",
      "content": "Great read! The real-world examples really help illustrate the concepts. Looking forward to seeing how this technology evolves.",
      "timestamp": "1 day ago",
      "likes": 22,
      "isLiked": false,
      "replies": []
    }
  ];

  String newComment = "";
  String replyToComment = "";
  int? replyingToId;
  String sortBy = "newest"; // newest, oldest, most_liked

  List<Map<String, dynamic>> get sortedComments {
    List<Map<String, dynamic>> sorted = List.from(comments);
    
    if (sortBy == "newest") {
      // Already in newest order
    } else if (sortBy == "oldest") {
      sorted = sorted.reversed.toList();
    } else if (sortBy == "most_liked") {
      sorted.sort((a, b) => (b["likes"] as int).compareTo(a["likes"] as int));
    }
    
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
        actions: [
          GestureDetector(
            onTap: () => _showSortOptions(),
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.sort, color: primaryColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    _getSortLabel(),
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Comments Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowXs],
            ),
            child: Row(
              children: [
                Text(
                  "${comments.length + comments.fold(0, (sum, comment) => sum + (comment["replies"] as List).length)} Comments",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(40),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.sentiment_satisfied, color: successColor, size: 14),
                      SizedBox(width: spXs),
                      Text(
                        "Engaging Discussion",
                        style: TextStyle(
                          color: successColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Comments List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: sortedComments.length,
              itemBuilder: (context, index) {
                final comment = sortedComments[index];
                return _buildCommentItem(comment, false);
              },
            ),
          ),

          // Comment Input
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowMd],
            ),
            child: Column(
              children: [
                if (replyingToId != null) ...[
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.reply, color: primaryColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Replying to ${_getCommentAuthor(replyingToId!)}",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            replyingToId = null;
                            replyToComment = "";
                            setState(() {});
                          },
                          child: Icon(Icons.close, color: primaryColor, size: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spSm),
                ],
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage("https://picsum.photos/50/50?random=user&keyword=profile"),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: TextField(
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: replyingToId != null ? "Write a reply..." : "Write a comment...",
                            hintStyle: TextStyle(color: disabledColor),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                          onChanged: (value) {
                            if (replyingToId != null) {
                              replyToComment = value;
                            } else {
                              newComment = value;
                            }
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.send,
                      size: bs.sm,
                      onPressed: (replyingToId != null ? replyToComment.isNotEmpty : newComment.isNotEmpty) ? () {
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

  Widget _buildCommentItem(Map<String, dynamic> comment, bool isReply) {
    return Container(
      margin: EdgeInsets.only(
        bottom: spMd,
        left: isReply ? spXl : 0,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: isReply ? 16 : 20,
                backgroundImage: NetworkImage("${comment["authorImage"]}"),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${comment["author"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                            fontSize: isReply ? 14 : 16,
                          ),
                        ),
                        if (comment["isAuthor"] == true) ...[
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "Author",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                        Spacer(),
                        Text(
                          "${comment["timestamp"]}",
                          style: TextStyle(
                            color: disabledColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${comment["content"]}",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: isReply ? 14 : 16,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _toggleLike(comment);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: (comment["isLiked"] == true) 
                                  ? dangerColor.withAlpha(40) 
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  (comment["isLiked"] == true) ? Icons.favorite : Icons.favorite_border,
                                  color: (comment["isLiked"] == true) ? dangerColor : disabledBoldColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${comment["likes"]}",
                                  style: TextStyle(
                                    color: (comment["isLiked"] == true) ? dangerColor : disabledBoldColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (!isReply) ...[
                          SizedBox(width: spMd),
                          GestureDetector(
                            onTap: () {
                              replyingToId = comment["id"];
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.reply, color: disabledBoldColor, size: 16),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Reply",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                        Spacer(),
                        GestureDetector(
                          onTap: () => _showCommentOptions(comment),
                          child: Icon(Icons.more_vert, color: disabledColor, size: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Replies
          if (!isReply && (comment["replies"] as List).isNotEmpty) ...[
            SizedBox(height: spMd),
            Column(
              children: (comment["replies"] as List).map<Widget>((reply) {
                return _buildCommentItem(reply, true);
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  String _getSortLabel() {
    switch (sortBy) {
      case "newest":
        return "Newest";
      case "oldest":
        return "Oldest";
      case "most_liked":
        return "Most Liked";
      default:
        return "Newest";
    }
  }

  String _getCommentAuthor(int commentId) {
    final comment = comments.firstWhere((c) => c["id"] == commentId);
    return comment["author"];
  }

  void _toggleLike(Map<String, dynamic> comment) {
    comment["isLiked"] = !(comment["isLiked"] ?? false);
    if (comment["isLiked"]) {
      comment["likes"] = (comment["likes"] as int) + 1;
    } else {
      comment["likes"] = (comment["likes"] as int) - 1;
    }
    setState(() {});
  }

  void _postComment() {
    if (replyingToId != null && replyToComment.isNotEmpty) {
      // Add reply
      final parentComment = comments.firstWhere((c) => c["id"] == replyingToId);
      (parentComment["replies"] as List).add({
        "id": DateTime.now().millisecondsSinceEpoch,
        "author": "You",
        "authorImage": "https://picsum.photos/50/50?random=user&keyword=profile",
        "content": replyToComment,
        "timestamp": "Just now",
        "likes": 0,
        "isLiked": false,
      });
      replyToComment = "";
      replyingToId = null;
      si("Reply posted successfully");
    } else if (newComment.isNotEmpty) {
      // Add new comment
      comments.insert(0, {
        "id": DateTime.now().millisecondsSinceEpoch,
        "author": "You",
        "authorImage": "https://picsum.photos/50/50?random=user&keyword=profile",
        "content": newComment,
        "timestamp": "Just now",
        "likes": 0,
        "isLiked": false,
        "replies": [],
      });
      newComment = "";
      ss("Comment posted successfully");
    }
    setState(() {});
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sort Comments",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              ...[
                {"value": "newest", "label": "Newest First"},
                {"value": "oldest", "label": "Oldest First"},
                {"value": "most_liked", "label": "Most Liked"},
              ].map((option) {
                return GestureDetector(
                  onTap: () {
                    sortBy = option["value"]!;
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: spMd),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
                    ),
                    child: Row(
                      children: [
                        Text(
                          option["label"]!,
                          style: TextStyle(
                            color: sortBy == option["value"] ? primaryColor : primaryColor,
                            fontWeight: sortBy == option["value"] ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                        Spacer(),
                        if (sortBy == option["value"])
                          Icon(Icons.check, color: primaryColor, size: 20),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  void _showCommentOptions(Map<String, dynamic> comment) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Comment Options",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              _buildBottomSheetOption(Icons.flag, "Report Comment", () {
                Navigator.pop(context);
                sw("Comment reported for review");
              }),
              _buildBottomSheetOption(Icons.block, "Block User", () {
                Navigator.pop(context);
                si("User blocked successfully");
              }),
              _buildBottomSheetOption(Icons.copy, "Copy Comment", () {
                Navigator.pop(context);
                ss("Comment copied to clipboard");
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomSheetOption(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: spMd),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
        ),
        child: Row(
          children: [
            Icon(icon, color: primaryColor, size: 20),
            SizedBox(width: spMd),
            Text(
              label,
              style: TextStyle(
                color: primaryColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
