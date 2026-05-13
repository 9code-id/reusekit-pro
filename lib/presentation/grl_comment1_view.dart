import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlComment1View extends StatefulWidget {
  @override
  State<GrlComment1View> createState() => _GrlComment1ViewState();
}

class _GrlComment1ViewState extends State<GrlComment1View> {
  String newComment = "";
  String replyText = "";
  int? replyingToIndex;
  bool isLoading = false;

  List<Map<String, dynamic>> comments = [
    {
      "id": 1,
      "username": "photography_lover",
      "avatar": "https://picsum.photos/50/50?random=100&keyword=photographer",
      "comment": "This shot is absolutely stunning! The lighting is perfect 📸✨",
      "time": "2h",
      "likes": 247,
      "isLiked": false,
      "replies": [
        {
          "id": 101,
          "username": "camera_expert",
          "avatar": "https://picsum.photos/50/50?random=101&keyword=expert",
          "comment": "Agreed! Looks like golden hour magic 🌅",
          "time": "1h",
          "likes": 23,
          "isLiked": true,
        },
        {
          "id": 102,
          "username": "nature_enthusiast",
          "avatar": "https://picsum.photos/50/50?random=102&keyword=nature",
          "comment": "The composition is chef's kiss! 👌",
          "time": "45m",
          "likes": 15,
          "isLiked": false,
        }
      ]
    },
    {
      "id": 2,
      "username": "travel_blogger",
      "avatar": "https://picsum.photos/50/50?random=103&keyword=traveler",
      "comment": "Where was this taken? Adding it to my travel bucket list! 🌍",
      "time": "3h",
      "likes": 189,
      "isLiked": true,
      "replies": []
    },
    {
      "id": 3,
      "username": "art_critic",
      "avatar": "https://picsum.photos/50/50?random=104&keyword=critic",
      "comment": "The way you captured the shadows and highlights is masterful. This deserves to be in a gallery! 🎨",
      "time": "4h",
      "likes": 312,
      "isLiked": false,
      "replies": [
        {
          "id": 301,
          "username": "gallery_owner",
          "avatar": "https://picsum.photos/50/50?random=105&keyword=gallery",
          "comment": "I completely agree! Would love to feature this in our next exhibition. DM me! 🏛️",
          "time": "3h",
          "likes": 67,
          "isLiked": false,
        }
      ]
    },
    {
      "id": 4,
      "username": "wanderlust_soul",
      "avatar": "https://picsum.photos/50/50?random=106&keyword=wanderer",
      "comment": "This makes me want to pack my bags and explore right now! 🎒✈️",
      "time": "5h",
      "likes": 156,
      "isLiked": false,
      "replies": []
    },
    {
      "id": 5,
      "username": "color_enthusiast",
      "avatar": "https://picsum.photos/50/50?random=107&keyword=artist",
      "comment": "The color palette in this photo is absolutely divine! Those warm tones against the cool sky - pure poetry! 🎨🌈",
      "time": "6h",
      "likes": 203,
      "isLiked": true,
      "replies": []
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
        actions: [
          Icon(Icons.more_vert),
          SizedBox(width: spSm),
        ],
      ),
      body: Column(
        children: [
          // Comments List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Main Comment
                      _buildCommentItem(comment, index, false),
                      
                      // Replies
                      if ((comment["replies"] as List).isNotEmpty) ...[
                        SizedBox(height: spSm),
                        Padding(
                          padding: EdgeInsets.only(left: spLg),
                          child: Column(
                            children: (comment["replies"] as List).map((reply) {
                              return Container(
                                margin: EdgeInsets.only(bottom: spSm),
                                child: _buildCommentItem(reply, index, true),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                      
                      // Reply Input (if replying to this comment)
                      if (replyingToIndex == index) ...[
                        SizedBox(height: spSm),
                        Padding(
                          padding: EdgeInsets.only(left: spLg),
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                              border: Border.all(
                                color: primaryColor.withAlpha(100),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Replying to @${comment["username"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: "Write a reply...",
                                          hintStyle: TextStyle(
                                            color: disabledBoldColor,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        maxLines: 3,
                                        minLines: 1,
                                        onChanged: (value) {
                                          replyText = value;
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          replyingToIndex = null;
                                          replyText = "";
                                        });
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    GestureDetector(
                                      onTap: replyText.isNotEmpty ? () {
                                        setState(() {
                                          (comments[index]["replies"] as List).add({
                                            "id": DateTime.now().millisecondsSinceEpoch,
                                            "username": "you",
                                            "avatar": "https://picsum.photos/50/50?random=999&keyword=user",
                                            "comment": replyText,
                                            "time": "now",
                                            "likes": 0,
                                            "isLiked": false,
                                          });
                                          replyingToIndex = null;
                                          replyText = "";
                                        });
                                        ss("Reply posted!");
                                      } : null,
                                      child: Text(
                                        "Reply",
                                        style: TextStyle(
                                          color: replyText.isNotEmpty 
                                              ? primaryColor 
                                              : disabledBoldColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          
          // Add Comment Input
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
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(
                    "https://picsum.photos/50/50?random=998&keyword=user"
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Add a comment...",
                        hintStyle: TextStyle(
                          color: disabledBoldColor,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: spSm),
                      ),
                      maxLines: 4,
                      minLines: 1,
                      onChanged: (value) {
                        newComment = value;
                        setState(() {});
                      },
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                GestureDetector(
                  onTap: newComment.isNotEmpty ? () {
                    setState(() {
                      isLoading = true;
                    });
                    
                    // Simulate posting delay
                    Future.delayed(Duration(milliseconds: 500), () {
                      setState(() {
                        comments.insert(0, {
                          "id": DateTime.now().millisecondsSinceEpoch,
                          "username": "you",
                          "avatar": "https://picsum.photos/50/50?random=998&keyword=user",
                          "comment": newComment,
                          "time": "now",
                          "likes": 0,
                          "isLiked": false,
                          "replies": []
                        });
                        newComment = "";
                        isLoading = false;
                      });
                      ss("Comment posted!");
                    });
                  } : null,
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: newComment.isNotEmpty 
                          ? primaryColor 
                          : disabledColor,
                      shape: BoxShape.circle,
                    ),
                    child: isLoading
                        ? SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 20,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentItem(Map<String, dynamic> comment, int parentIndex, bool isReply) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: isReply ? 14 : 18,
          backgroundImage: NetworkImage("${comment["avatar"]}"),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Username and Time
              Row(
                children: [
                  Text(
                    "${comment["username"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isReply ? 13 : 14,
                    ),
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${comment["time"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: isReply ? 11 : 12,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              
              // Comment Text
              Text(
                "${comment["comment"]}",
                style: TextStyle(
                  fontSize: isReply ? 13 : 14,
                  height: 1.4,
                ),
              ),
              SizedBox(height: spXs),
              
              // Action Buttons
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        comment["isLiked"] = !(comment["isLiked"] as bool);
                        if (comment["isLiked"] as bool) {
                          comment["likes"] = (comment["likes"] as int) + 1;
                        } else {
                          comment["likes"] = (comment["likes"] as int) - 1;
                        }
                      });
                    },
                    child: Row(
                      children: [
                        Icon(
                          (comment["isLiked"] as bool) 
                              ? Icons.favorite 
                              : Icons.favorite_border,
                          color: (comment["isLiked"] as bool) 
                              ? Colors.red 
                              : disabledBoldColor,
                          size: isReply ? 16 : 18,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${comment["likes"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: isReply ? 11 : 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: spMd),
                  if (!isReply)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          replyingToIndex = replyingToIndex == parentIndex ? null : parentIndex;
                          replyText = "";
                        });
                      },
                      child: Text(
                        "Reply",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            sw("More options");
          },
          child: Icon(
            Icons.more_vert,
            color: disabledBoldColor,
            size: 16,
          ),
        ),
      ],
    );
  }
}
