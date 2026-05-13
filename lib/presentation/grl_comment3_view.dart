import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlComment3View extends StatefulWidget {
  @override
  State<GrlComment3View> createState() => _GrlComment3ViewState();
}

class _GrlComment3ViewState extends State<GrlComment3View> {
  String newComment = "";
  bool isVoiceRecording = false;
  String voiceRecordingDuration = "0:00";
  int sortOption = 0; // 0: Latest, 1: Popular, 2: Oldest
  
  List<String> sortOptions = ["Latest", "Popular", "Oldest"];

  List<Map<String, dynamic>> comments = [
    {
      "id": 1,
      "username": "tech_reviewer",
      "avatar": "https://picsum.photos/50/50?random=300&keyword=tech",
      "comment": "Fantastic review! Your insights on the battery life were spot on. I've been using this device for 2 weeks and can confirm everything you mentioned 🔋📱",
      "time": "3m",
      "likes": 156,
      "dislikes": 2,
      "isLiked": true,
      "isDisliked": false,
      "hasVoiceNote": false,
      "voiceDuration": "",
      "hasImage": false,
      "imageUrl": "",
      "isCreator": false,
      "isTopComment": true,
      "replies": 12,
      "translations": {
        "es": "¡Excelente reseña! Tus ideas sobre la duración de la batería fueron acertadas...",
        "fr": "Excellente critique! Vos idées sur la durée de vie de la batterie étaient exactes..."
      }
    },
    {
      "id": 2,
      "username": "content_creator_official",
      "avatar": "https://picsum.photos/50/50?random=301&keyword=creator",
      "comment": "Thanks for all the amazing feedback everyone! Your support means the world to me 💙 Working on more detailed reviews coming soon!",
      "time": "15m",
      "likes": 289,
      "dislikes": 0,
      "isLiked": false,
      "isDisliked": false,
      "hasVoiceNote": true,
      "voiceDuration": "0:23",
      "hasImage": false,
      "imageUrl": "",
      "isCreator": true,
      "isTopComment": false,
      "replies": 45,
      "translations": {}
    },
    {
      "id": 3,
      "username": "mobile_enthusiast",
      "avatar": "https://picsum.photos/50/50?random=302&keyword=mobile",
      "comment": "Could you do a comparison with the previous generation? I'm trying to decide if it's worth upgrading 🤔",
      "time": "1h",
      "likes": 67,
      "dislikes": 1,
      "isLiked": false,
      "isDisliked": false,
      "hasVoiceNote": false,
      "voiceDuration": "",
      "hasImage": true,
      "imageUrl": "https://picsum.photos/300/200?random=400&keyword=phone",
      "isCreator": false,
      "isTopComment": false,
      "replies": 8,
      "translations": {}
    },
    {
      "id": 4,
      "username": "budget_buyer",
      "avatar": "https://picsum.photos/50/50?random=303&keyword=buyer",
      "comment": "Great video but I wish you covered more budget alternatives. Not everyone can afford flagship devices 💰",
      "time": "2h",
      "likes": 134,
      "dislikes": 8,
      "isLiked": false,
      "isDisliked": false,
      "hasVoiceNote": false,
      "voiceDuration": "",
      "hasImage": false,
      "imageUrl": "",
      "isCreator": false,
      "isTopComment": false,
      "replies": 23,
      "translations": {}
    },
    {
      "id": 5,
      "username": "photo_pro",
      "avatar": "https://picsum.photos/50/50?random=304&keyword=photographer",
      "comment": "The camera samples you showed were incredible! As a professional photographer, I'm impressed by the low-light performance 📸✨",
      "time": "4h",
      "likes": 98,
      "dislikes": 0,
      "isLiked": true,
      "isDisliked": false,
      "hasVoiceNote": false,
      "voiceDuration": "",
      "hasImage": false,
      "imageUrl": "",
      "isCreator": false,
      "isTopComment": false,
      "replies": 15,
      "translations": {}
    }
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> sortedComments = _getSortedComments();

    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
        actions: [
          GestureDetector(
            onTap: () {
              _showSortOptions();
            },
            child: Icon(Icons.sort),
          ),
          SizedBox(width: spSm),
          GestureDetector(
            onTap: () {
              sw("Search comments");
            },
            child: Icon(Icons.search),
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: Column(
        children: [
          // Comments Header with Stats
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
                  "${sortedComments.length} comments",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Spacer(),
                Text(
                  "Sorted by ${sortOptions[sortOption]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                SizedBox(width: spXs),
                Icon(
                  Icons.arrow_drop_down,
                  color: disabledBoldColor,
                  size: 16,
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
                bool isCreator = comment["isCreator"] as bool;
                bool isTopComment = comment["isTopComment"] as bool;
                bool hasVoiceNote = comment["hasVoiceNote"] as bool;
                bool hasImage = comment["hasImage"] as bool;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Comment Badge
                      if (isTopComment) ...[
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange.withAlpha(100),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.trending_up,
                                color: Colors.orange,
                                size: 14,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "Top Comment",
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: spSm),
                      ],
                      
                      // Comment Content
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage("${comment["avatar"]}"),
                              ),
                              if (isCreator)
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 8,
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
                                // Username and Time
                                Row(
                                  children: [
                                    Text(
                                      "${comment["username"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    if (isCreator) ...[
                                      SizedBox(width: spXs),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 4,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.circular(radiusXxs),
                                        ),
                                        child: Text(
                                          "CREATOR",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
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
                                
                                // Voice Note
                                if (hasVoiceNote) ...[
                                  SizedBox(height: spSm),
                                  Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(50),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.play_arrow,
                                          color: primaryColor,
                                          size: 20,
                                        ),
                                        SizedBox(width: spSm),
                                        Container(
                                          width: 100,
                                          height: 3,
                                          decoration: BoxDecoration(
                                            color: primaryColor.withAlpha(100),
                                            borderRadius: BorderRadius.circular(radiusXxs),
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Text(
                                          "${comment["voiceDuration"]}",
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                                
                                // Image Attachment
                                if (hasImage) ...[
                                  SizedBox(height: spSm),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(radiusXs),
                                    child: Image.network(
                                      "${comment["imageUrl"]}",
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                                
                                SizedBox(height: spSm),
                                
                                // Action Buttons
                                Row(
                                  children: [
                                    // Like Button
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (comment["isDisliked"] as bool) {
                                            comment["isDisliked"] = false;
                                            comment["dislikes"] = (comment["dislikes"] as int) - 1;
                                          }
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
                                            Icons.thumb_up,
                                            color: (comment["isLiked"] as bool) 
                                                ? primaryColor 
                                                : disabledBoldColor,
                                            size: 18,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            "${comment["likes"]}",
                                            style: TextStyle(
                                              color: (comment["isLiked"] as bool) 
                                                  ? primaryColor 
                                                  : disabledBoldColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: spMd),
                                    
                                    // Dislike Button
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (comment["isLiked"] as bool) {
                                            comment["isLiked"] = false;
                                            comment["likes"] = (comment["likes"] as int) - 1;
                                          }
                                          comment["isDisliked"] = !(comment["isDisliked"] as bool);
                                          if (comment["isDisliked"] as bool) {
                                            comment["dislikes"] = (comment["dislikes"] as int) + 1;
                                          } else {
                                            comment["dislikes"] = (comment["dislikes"] as int) - 1;
                                          }
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.thumb_down,
                                            color: (comment["isDisliked"] as bool) 
                                                ? Colors.red 
                                                : disabledBoldColor,
                                            size: 18,
                                          ),
                                          if ((comment["dislikes"] as int) > 0) ...[
                                            SizedBox(width: 4),
                                            Text(
                                              "${comment["dislikes"]}",
                                              style: TextStyle(
                                                color: (comment["isDisliked"] as bool) 
                                                    ? Colors.red 
                                                    : disabledBoldColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: spMd),
                                    
                                    // Reply Button
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
                                    
                                    Spacer(),
                                    
                                    // Replies Count
                                    if ((comment["replies"] as int) > 0)
                                      GestureDetector(
                                        onTap: () {
                                          sw("View ${comment["replies"]} replies");
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              "${comment["replies"]} replies",
                                              style: TextStyle(
                                                color: primaryColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(width: 4),
                                            Icon(
                                              Icons.arrow_drop_down,
                                              color: primaryColor,
                                              size: 16,
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                                
                                // Translation Option
                                if ((comment["translations"] as Map).isNotEmpty) ...[
                                  SizedBox(height: spSm),
                                  GestureDetector(
                                    onTap: () {
                                      _showTranslations(comment["translations"] as Map);
                                    },
                                    child: Text(
                                      "See translation",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _showCommentOptions(comment);
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
                        hintText: "Add a public comment...",
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
                
                // Voice Recording Button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isVoiceRecording = !isVoiceRecording;
                    });
                    if (isVoiceRecording) {
                      ss("Recording voice note...");
                    } else {
                      ss("Voice note added!");
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isVoiceRecording ? Colors.red : disabledColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isVoiceRecording ? Icons.stop : Icons.mic,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                
                // Send Button
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
                        "dislikes": 0,
                        "isLiked": false,
                        "isDisliked": false,
                        "hasVoiceNote": false,
                        "voiceDuration": "",
                        "hasImage": false,
                        "imageUrl": "",
                        "isCreator": false,
                        "isTopComment": false,
                        "replies": 0,
                        "translations": {}
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

  List<Map<String, dynamic>> _getSortedComments() {
    List<Map<String, dynamic>> sorted = List.from(comments);
    
    switch (sortOption) {
      case 0: // Latest
        sorted.sort((a, b) => _parseTime(a["time"]).compareTo(_parseTime(b["time"])));
        break;
      case 1: // Popular
        sorted.sort((a, b) => (b["likes"] as int).compareTo(a["likes"] as int));
        break;
      case 2: // Oldest
        sorted.sort((a, b) => _parseTime(b["time"]).compareTo(_parseTime(a["time"])));
        break;
    }
    
    return sorted;
  }

  int _parseTime(String time) {
    if (time == "now") return 0;
    if (time.endsWith("m")) return int.parse(time.replaceAll("m", ""));
    if (time.endsWith("h")) return int.parse(time.replaceAll("h", "")) * 60;
    return 9999;
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Sort comments by",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: spMd),
              ...sortOptions.asMap().entries.map((entry) {
                int index = entry.key;
                String option = entry.value;
                
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      sortOption = index;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: spSm),
                    child: Row(
                      children: [
                        Icon(
                          sortOption == index ? Icons.radio_button_checked : Icons.radio_button_off,
                          color: sortOption == index ? primaryColor : disabledBoldColor,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          option,
                          style: TextStyle(
                            color: sortOption == index ? primaryColor : Colors.black,
                            fontWeight: sortOption == index ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
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

  void _showTranslations(Map translations) {
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
                "Translations",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: spMd),
              ...translations.entries.map((entry) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.key.toUpperCase(),
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        entry.value,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
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
                "Comment options",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: spMd),
              ListTile(
                leading: Icon(Icons.flag),
                title: Text("Report"),
                onTap: () {
                  Navigator.pop(context);
                  sw("Comment reported");
                },
              ),
              ListTile(
                leading: Icon(Icons.person_remove),
                title: Text("Block user"),
                onTap: () {
                  Navigator.pop(context);
                  sw("User blocked");
                },
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text("Share comment"),
                onTap: () {
                  Navigator.pop(context);
                  sw("Comment shared");
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
