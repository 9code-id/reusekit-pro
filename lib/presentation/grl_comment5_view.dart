import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlComment5View extends StatefulWidget {
  @override
  State<GrlComment5View> createState() => _GrlComment5ViewState();
}

class _GrlComment5ViewState extends State<GrlComment5View> {
  String comment = "";
  String selectedFilter = "All";
  List<String> filterOptions = ["All", "Recent", "Top", "Oldest"];
  
  List<Map<String, dynamic>> allComments = [
    {
      "id": "1",
      "user": {
        "name": "Alexandra Chen",
        "avatar": "https://picsum.photos/40/40?random=11",
        "badge": "Pro",
        "level": "Expert",
      },
      "content": "This feature implementation is absolutely brilliant! The way you've handled the state management here is textbook perfect. I've been working on similar projects and this gives me great inspiration for my next iteration.",
      "likes": 142,
      "replies": 8,
      "isLiked": true,
      "timestamp": "2h ago",
      "category": "Feature",
      "isPinned": true,
      "reactions": {
        "thumbsUp": 25,
        "heart": 18,
        "fire": 12,
        "clap": 8,
      }
    },
    {
      "id": "2",
      "user": {
        "name": "Marcus Johnson",
        "avatar": "https://picsum.photos/40/40?random=12",
        "badge": "Verified",
        "level": "Intermediate",
      },
      "content": "Love the clean architecture approach! Quick question though - have you considered implementing error boundaries for better error handling? Would love to hear your thoughts on this.",
      "likes": 89,
      "replies": 12,
      "isLiked": false,
      "timestamp": "4h ago",
      "category": "Question",
      "isPinned": false,
      "reactions": {
        "thumbsUp": 15,
        "heart": 8,
        "thinking": 22,
        "clap": 5,
      }
    },
    {
      "id": "3",
      "user": {
        "name": "Sophie Martinez",
        "avatar": "https://picsum.photos/40/40?random=13",
        "badge": "Contributor",
        "level": "Advanced",
      },
      "content": "Amazing work! The performance optimizations you've implemented here are next level. I'm particularly impressed with the lazy loading strategy. This is definitely going into my bookmarks! 🚀",
      "likes": 203,
      "replies": 15,
      "isLiked": true,
      "timestamp": "6h ago",
      "category": "Praise",
      "isPinned": false,
      "reactions": {
        "thumbsUp": 35,
        "heart": 28,
        "fire": 45,
        "clap": 12,
      }
    },
    {
      "id": "4",
      "user": {
        "name": "James Wilson",
        "avatar": "https://picsum.photos/40/40?random=14",
        "badge": "Moderator",
        "level": "Expert",
      },
      "content": "Excellent documentation and code quality! For newcomers reading this, I'd recommend checking out the companion tutorial series. This implementation showcases best practices beautifully.",
      "likes": 67,
      "replies": 6,
      "isLiked": false,
      "timestamp": "1d ago",
      "category": "Educational",
      "isPinned": true,
      "reactions": {
        "thumbsUp": 20,
        "heart": 10,
        "books": 18,
        "clap": 8,
      }
    },
    {
      "id": "5",
      "user": {
        "name": "Emma Thompson",
        "avatar": "https://picsum.photos/40/40?random=15",
        "badge": "New",
        "level": "Beginner",
      },
      "content": "This is exactly what I was looking for! As someone new to development, this example really helps me understand the concepts. Thank you for sharing such quality content!",
      "likes": 45,
      "replies": 3,
      "isLiked": true,
      "timestamp": "2d ago",
      "category": "Learning",
      "isPinned": false,
      "reactions": {
        "thumbsUp": 12,
        "heart": 15,
        "grateful": 8,
        "clap": 3,
      }
    }
  ];

  List<Map<String, dynamic>> get filteredComments {
    switch (selectedFilter) {
      case "Recent":
        return allComments..sort((a, b) => _parseTime(a["timestamp"]).compareTo(_parseTime(b["timestamp"])));
      case "Top":
        return allComments..sort((a, b) => (b["likes"] as int).compareTo(a["likes"] as int));
      case "Oldest":
        return allComments..sort((a, b) => _parseTime(b["timestamp"]).compareTo(_parseTime(a["timestamp"])));
      default:
        return allComments;
    }
  }

  int _parseTime(String timestamp) {
    if (timestamp.contains("h ago")) {
      return int.parse(timestamp.split("h")[0]);
    } else if (timestamp.contains("d ago")) {
      return int.parse(timestamp.split("d")[0]) * 24;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Community Discussion"),
        actions: [
          QButton(
            icon: Icons.search,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Column(
        children: [
          // Header Stats
          Container(
            padding: EdgeInsets.all(spMd),
            color: primaryColor.withAlpha(10),
            child: Row(
              children: [
                Expanded(
                  child: _buildStatCard("Total Comments", "${allComments.length}", Icons.comment, primaryColor),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard("Active Today", "24", Icons.trending_up, successColor),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard("Top Rated", "5", Icons.star, warningColor),
                ),
              ],
            ),
          ),
          
          // Filter Tabs
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            child: Row(
              children: [
                Expanded(
                  child: QCategoryPicker(
                    items: filterOptions.map((filter) => {
                      "label": filter,
                      "value": filter,
                    }).toList(),
                    value: selectedFilter,
                    onChanged: (index, label, value, item) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  // Pinned Comments
                  if (filteredComments.any((c) => c["isPinned"] == true)) ...[
                    Text(
                      "📌 Pinned Comments",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    ...filteredComments.where((c) => c["isPinned"] == true).map((comment) => _buildAdvancedCommentCard(comment)),
                    SizedBox(height: spLg),
                  ],
                  
                  // Regular Comments
                  Text(
                    "💬 All Comments",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ...filteredComments.where((c) => c["isPinned"] != true).map((comment) => _buildAdvancedCommentCard(comment)),
                ],
              ),
            ),
          ),
          
          // Advanced Comment Input
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowLg],
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
                        label: "Join the discussion...",
                        value: comment,
                        hint: "Share your thoughts and insights",
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
                      icon: Icons.gif,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.emoji_emotions,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.attach_file,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    Spacer(),
                    QButton(
                      label: "Post Comment",
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

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowXs],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedCommentCard(Map<String, dynamic> comment) {
    final user = comment["user"];
    final reactions = comment["reactions"] as Map<String, dynamic>;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
        border: comment["isPinned"] == true ? Border.all(
          color: warningColor,
          width: 2,
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
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage("${user["avatar"]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: _getBadgeColor(user["badge"]),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Icon(
                        _getBadgeIcon(user["badge"]),
                        size: 8,
                        color: Colors.white,
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
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getBadgeColor(user["badge"]),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${user["badge"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "${user["level"]} • ${comment["timestamp"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        if (comment["isPinned"] == true) ...[
                          SizedBox(width: spXs),
                          Icon(
                            Icons.push_pin,
                            size: 12,
                            color: warningColor,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Category Tag
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: _getCategoryColor(comment["category"]).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${comment["category"]}",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: _getCategoryColor(comment["category"]),
              ),
            ),
          ),
          
          SizedBox(height: spSm),
          
          // Comment Content
          Text(
            "${comment["content"]}",
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              height: 1.5,
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Reactions Bar
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                ...reactions.entries.take(4).map((entry) => 
                  _buildReactionButton(entry.key, entry.value)
                ),
                Spacer(),
                Text(
                  "${reactions.values.reduce((a, b) => (a as int) + (b as int))} reactions",
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
          
          // Action Buttons
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
                      comment["isLiked"] ? Icons.thumb_up : Icons.thumb_up_outlined,
                      size: 20,
                      color: comment["isLiked"] ? primaryColor : disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${comment["likes"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: comment["isLiked"] ? primaryColor : disabledBoldColor,
                        fontWeight: FontWeight.w600,
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
                      size: 20,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${comment["replies"]} replies",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
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
                      Icons.share,
                      size: 20,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Share",
                      style: TextStyle(
                        fontSize: 14,
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

  Widget _buildReactionButton(String reaction, dynamic count) {
    return Container(
      margin: EdgeInsets.only(right: spSm),
      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _getReactionEmoji(reaction),
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(width: 2),
          Text(
            "$count",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getBadgeColor(String badge) {
    switch (badge) {
      case "Pro": return successColor;
      case "Verified": return primaryColor;
      case "Contributor": return warningColor;
      case "Moderator": return dangerColor;
      case "New": return infoColor;
      default: return disabledBoldColor;
    }
  }

  IconData _getBadgeIcon(String badge) {
    switch (badge) {
      case "Pro": return Icons.star;
      case "Verified": return Icons.verified;
      case "Contributor": return Icons.code;
      case "Moderator": return Icons.shield;
      case "New": return Icons.fiber_new;
      default: return Icons.person;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Feature": return successColor;
      case "Question": return infoColor;
      case "Praise": return warningColor;
      case "Educational": return primaryColor;
      case "Learning": return dangerColor;
      default: return disabledBoldColor;
    }
  }

  String _getReactionEmoji(String reaction) {
    switch (reaction) {
      case "thumbsUp": return "👍";
      case "heart": return "❤️";
      case "fire": return "🔥";
      case "clap": return "👏";
      case "thinking": return "🤔";
      case "books": return "📚";
      case "grateful": return "🙏";
      default: return "👍";
    }
  }

  void _postComment() {
    if (comment.trim().isEmpty) return;
    
    final newComment = {
      "id": "${allComments.length + 1}",
      "user": {
        "name": "You",
        "avatar": "https://picsum.photos/40/40?random=100",
        "badge": "New",
        "level": "Beginner",
      },
      "content": comment,
      "likes": 0,
      "replies": 0,
      "isLiked": false,
      "timestamp": "now",
      "category": "General",
      "isPinned": false,
      "reactions": {
        "thumbsUp": 0,
        "heart": 0,
        "fire": 0,
        "clap": 0,
      },
    };
    
    allComments.insert(0, newComment);
    comment = "";
    setState(() {});
    
    ss("Comment posted successfully!");
  }
}
