import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlComment2View extends StatefulWidget {
  @override
  State<GrlComment2View> createState() => _GrlComment2ViewState();
}

class _GrlComment2ViewState extends State<GrlComment2View> {
  String newComment = "";
  String selectedFilter = "All";
  bool showEmojiPicker = false;
  int selectedCommentIndex = -1;

  List<String> filterOptions = ["All", "Recent", "Top", "Friends"];

  List<Map<String, dynamic>> comments = [
    {
      "id": 1,
      "username": "foodie_explorer",
      "avatar": "https://picsum.photos/50/50?random=200&keyword=chef",
      "comment": "This recipe looks incredible! Can't wait to try it this weekend 🍳👨‍🍳",
      "time": "5m",
      "likes": 42,
      "isLiked": true,
      "isPinned": true,
      "hasMedia": false,
      "isVerified": true,
      "reactions": [
        {"emoji": "😍", "count": 15},
        {"emoji": "🤤", "count": 8},
        {"emoji": "👏", "count": 12}
      ]
    },
    {
      "id": 2,
      "username": "kitchen_master",
      "avatar": "https://picsum.photos/50/50?random=201&keyword=cook",
      "comment": "Pro tip: Add a pinch of smoked paprika for extra flavor! I've been making this for years ✨",
      "time": "12m",
      "likes": 67,
      "isLiked": false,
      "isPinned": false,
      "hasMedia": false,
      "isVerified": false,
      "reactions": [
        {"emoji": "💡", "count": 23},
        {"emoji": "🙌", "count": 11}
      ]
    },
    {
      "id": 3,
      "username": "healthy_living",
      "avatar": "https://picsum.photos/50/50?random=202&keyword=nutrition",
      "comment": "Love how you included the nutritional info! This fits perfectly into my meal prep routine 💪🥗",
      "time": "25m",
      "likes": 28,
      "isLiked": false,
      "isPinned": false,
      "hasMedia": true,
      "mediaUrl": "https://picsum.photos/200/150?random=300&keyword=mealprep",
      "isVerified": false,
      "reactions": [
        {"emoji": "💪", "count": 18},
        {"emoji": "🔥", "count": 7}
      ]
    },
    {
      "id": 4,
      "username": "cooking_newbie",
      "avatar": "https://picsum.photos/50/50?random=203&keyword=beginner",
      "comment": "This might be a silly question, but can I substitute the heavy cream with something lighter? Still learning! 🤔",
      "time": "1h",
      "likes": 15,
      "isLiked": false,
      "isPinned": false,
      "hasMedia": false,
      "isVerified": false,
      "reactions": [
        {"emoji": "🤔", "count": 5},
        {"emoji": "💭", "count": 3}
      ]
    },
    {
      "id": 5,
      "username": "spice_guru",
      "avatar": "https://picsum.photos/50/50?random=204&keyword=spices",
      "comment": "The spice combinations here are absolutely divine! Reminds me of my grandmother's cooking 👵❤️",
      "time": "2h",
      "likes": 89,
      "isLiked": true,
      "isPinned": false,
      "hasMedia": false,
      "isVerified": true,
      "reactions": [
        {"emoji": "❤️", "count": 34},
        {"emoji": "👵", "count": 12},
        {"emoji": "🌶️", "count": 8}
      ]
    }
  ];

  List<String> quickEmojis = ["❤️", "😍", "🤤", "🔥", "👏", "💯", "🙌", "💪"];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredComments = _getFilteredComments();

    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
        actions: [
          GestureDetector(
            onTap: () {
              sw("Comment settings");
            },
            child: Icon(Icons.settings),
          ),
          SizedBox(width: spSm),
          GestureDetector(
            onTap: () {
              sw("Share comments");
            },
            child: Icon(Icons.share),
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: Column(
        children: [
          // Filter Tabs
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: spMd),
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
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: filterOptions.length,
                    itemBuilder: (context, index) {
                      final filter = filterOptions[index];
                      bool isSelected = selectedFilter == filter;
                      
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFilter = filter;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: spMd),
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Center(
                            child: Text(
                              filter,
                              style: TextStyle(
                                color: isSelected ? Colors.white : disabledBoldColor,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${filteredComments.length}",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Comments List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: filteredComments.length,
              itemBuilder: (context, index) {
                final comment = filteredComments[index];
                bool isPinned = comment["isPinned"] as bool;
                bool isVerified = comment["isVerified"] as bool;
                bool hasMedia = comment["hasMedia"] as bool;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isPinned ? primaryColor.withAlpha(20) : Colors.white,
                    borderRadius: BorderRadius.circular(radiusXs),
                    border: Border.all(
                      color: isPinned ? primaryColor.withAlpha(100) : disabledOutlineBorderColor,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with Pin indicator
                      if (isPinned) ...[
                        Row(
                          children: [
                            Icon(
                              Icons.push_pin,
                              color: primaryColor,
                              size: 14,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Pinned Comment",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                      ],
                      
                      // Comment Content
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage("${comment["avatar"]}"),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Username and verification
                                Row(
                                  children: [
                                    Text(
                                      "${comment["username"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    if (isVerified) ...[
                                      SizedBox(width: spXs),
                                      Icon(
                                        Icons.verified,
                                        color: primaryColor,
                                        size: 16,
                                      ),
                                    ],
                                    SizedBox(width: spXs),
                                    Text(
                                      "${comment["time"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                
                                // Comment Text
                                Text(
                                  "${comment["comment"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    height: 1.4,
                                  ),
                                ),
                                
                                // Media Attachment
                                if (hasMedia) ...[
                                  SizedBox(height: spSm),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(radiusXs),
                                    child: Image.network(
                                      "${comment["mediaUrl"]}",
                                      height: 120,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                                
                                SizedBox(height: spSm),
                                
                                // Reactions Row
                                if ((comment["reactions"] as List).isNotEmpty) ...[
                                  Row(
                                    children: [
                                      ...(comment["reactions"] as List).map((reaction) {
                                        return Container(
                                          margin: EdgeInsets.only(right: spSm),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                reaction["count"] = (reaction["count"] as int) + 1;
                                              });
                                              ss("Reacted with ${reaction["emoji"]}");
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: spXs,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: disabledColor.withAlpha(50),
                                                borderRadius: BorderRadius.circular(radiusLg),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "${reaction["emoji"]}",
                                                    style: TextStyle(fontSize: 12),
                                                  ),
                                                  SizedBox(width: 2),
                                                  Text(
                                                    "${reaction["count"]}",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: disabledBoldColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                  SizedBox(height: spSm),
                                ],
                                
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
                                            size: 18,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            "${comment["likes"]}",
                                            style: TextStyle(
                                              color: disabledBoldColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: spMd),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedCommentIndex = selectedCommentIndex == index ? -1 : index;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.add_reaction_outlined,
                                            color: disabledBoldColor,
                                            size: 18,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            "React",
                                            style: TextStyle(
                                              color: disabledBoldColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: spMd),
                                    GestureDetector(
                                      onTap: () {
                                        sw("Reply to comment");
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
                                
                                // Quick Emoji Reactions
                                if (selectedCommentIndex == index) ...[
                                  SizedBox(height: spSm),
                                  Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      color: disabledColor.withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Row(
                                      children: quickEmojis.map((emoji) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              // Add or update reaction
                                              List reactions = comment["reactions"] as List;
                                              int existingIndex = reactions.indexWhere(
                                                (r) => r["emoji"] == emoji
                                              );
                                              
                                              if (existingIndex != -1) {
                                                reactions[existingIndex]["count"] = 
                                                    (reactions[existingIndex]["count"] as int) + 1;
                                              } else {
                                                reactions.add({
                                                  "emoji": emoji,
                                                  "count": 1
                                                });
                                              }
                                              selectedCommentIndex = -1;
                                            });
                                            ss("Reacted with $emoji");
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(right: spSm),
                                            padding: EdgeInsets.all(spXs),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(radiusXs),
                                              boxShadow: [shadowSm],
                                            ),
                                            child: Text(
                                              emoji,
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
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
                              size: 18,
                            ),
                          ),
                        ],
                      ),
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
                    "https://picsum.photos/50/50?random=999&keyword=user"
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
                        hintText: "Share your thoughts...",
                        hintStyle: TextStyle(
                          color: disabledBoldColor,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: spSm),
                      ),
                      maxLines: 3,
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
                  onTap: () {
                    setState(() {
                      showEmojiPicker = !showEmojiPicker;
                    });
                  },
                  child: Icon(
                    Icons.emoji_emotions_outlined,
                    color: disabledBoldColor,
                    size: 24,
                  ),
                ),
                SizedBox(width: spSm),
                GestureDetector(
                  onTap: newComment.isNotEmpty ? () {
                    setState(() {
                      comments.insert(0, {
                        "id": DateTime.now().millisecondsSinceEpoch,
                        "username": "you",
                        "avatar": "https://picsum.photos/50/50?random=999&keyword=user",
                        "comment": newComment,
                        "time": "now",
                        "likes": 0,
                        "isLiked": false,
                        "isPinned": false,
                        "hasMedia": false,
                        "isVerified": false,
                        "reactions": []
                      });
                      newComment = "";
                    });
                    ss("Comment posted!");
                  } : null,
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: newComment.isNotEmpty 
                          ? primaryColor 
                          : disabledColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
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

  List<Map<String, dynamic>> _getFilteredComments() {
    switch (selectedFilter) {
      case "Recent":
        return List.from(comments)..sort((a, b) => 
          _parseTime(a["time"]).compareTo(_parseTime(b["time"])));
      case "Top":
        return List.from(comments)..sort((a, b) => 
          (b["likes"] as int).compareTo(a["likes"] as int));
      case "Friends":
        return comments.where((c) => c["isVerified"] as bool).toList();
      default:
        return comments;
    }
  }

  int _parseTime(String time) {
    if (time == "now") return 0;
    if (time.endsWith("m")) return int.parse(time.replaceAll("m", ""));
    if (time.endsWith("h")) return int.parse(time.replaceAll("h", "")) * 60;
    return 9999;
  }
}
