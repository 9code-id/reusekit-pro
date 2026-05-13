import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaLikesView extends StatefulWidget {
  const SmaLikesView({super.key});

  @override
  State<SmaLikesView> createState() => _SmaLikesViewState();
}

class _SmaLikesViewState extends State<SmaLikesView> {
  String selectedReactionType = "all";
  bool isLoading = false;

  List<Map<String, dynamic>> reactionTypes = [
    {"type": "all", "emoji": "👍", "label": "All", "count": 142},
    {"type": "like", "emoji": "👍", "label": "Like", "count": 89},
    {"type": "love", "emoji": "❤️", "label": "Love", "count": 32},
    {"type": "wow", "emoji": "😮", "label": "Wow", "count": 15},
    {"type": "laugh", "emoji": "😂", "label": "Haha", "count": 6},
    {"type": "support", "emoji": "💪", "label": "Support", "count": 12},
  ];

  List<Map<String, dynamic>> likes = [
    {
      "id": "like_001",
      "userId": "user_003",
      "userName": "Mike Wilson",
      "userUsername": "@mike_workout",
      "userAvatar": "https://picsum.photos/100/100?random=3&keyword=man",
      "reactionType": "like",
      "reactedAt": "2024-03-15T09:15:00Z",
      "isFollowing": true,
      "isMutualFriend": true,
      "mutualFriends": 12,
    },
    {
      "id": "like_002",
      "userId": "user_004",
      "userName": "Alice Thompson",
      "userUsername": "@alice_j",
      "userAvatar": "https://picsum.photos/100/100?random=4&keyword=woman",
      "reactionType": "love",
      "reactedAt": "2024-03-15T10:22:00Z",
      "isFollowing": true,
      "isMutualFriend": true,
      "mutualFriends": 28,
    },
    {
      "id": "like_003",
      "userId": "user_005",
      "userName": "Emma Davis",
      "userUsername": "@emma_fitness",
      "userAvatar": "https://picsum.photos/100/100?random=5&keyword=woman",
      "reactionType": "support",
      "reactedAt": "2024-03-15T11:45:00Z",
      "isFollowing": false,
      "isMutualFriend": true,
      "mutualFriends": 8,
    },
    {
      "id": "like_004",
      "userId": "user_006",
      "userName": "David Brown",
      "userUsername": "@david_fitness",
      "userAvatar": "https://picsum.photos/100/100?random=6&keyword=man",
      "reactionType": "like",
      "reactedAt": "2024-03-15T12:30:00Z",
      "isFollowing": false,
      "isMutualFriend": false,
      "mutualFriends": 0,
    },
    {
      "id": "like_005",
      "userId": "user_007",
      "userName": "Lisa Chang",
      "userUsername": "@lisa_health",
      "userAvatar": "https://picsum.photos/100/100?random=7&keyword=woman",
      "reactionType": "wow",
      "reactedAt": "2024-03-15T14:10:00Z",
      "isFollowing": true,
      "isMutualFriend": true,
      "mutualFriends": 15,
    },
    {
      "id": "like_006",
      "userId": "user_008",
      "userName": "Tom Anderson",
      "userUsername": "@tom_fit",
      "userAvatar": "https://picsum.photos/100/100?random=8&keyword=man",
      "reactionType": "love",
      "reactedAt": "2024-03-15T15:30:00Z",
      "isFollowing": false,
      "isMutualFriend": true,
      "mutualFriends": 6,
    },
    {
      "id": "like_007",
      "userId": "user_009",
      "userName": "Rachel Green",
      "userUsername": "@rachel_yoga",
      "userAvatar": "https://picsum.photos/100/100?random=9&keyword=woman",
      "reactionType": "like",
      "reactedAt": "2024-03-15T16:45:00Z",
      "isFollowing": true,
      "isMutualFriend": false,
      "mutualFriends": 0,
    },
    {
      "id": "like_008",
      "userId": "user_010",
      "userName": "James Wilson",
      "userUsername": "@james_cardio",
      "userAvatar": "https://picsum.photos/100/100?random=10&keyword=man",
      "reactionType": "laugh",
      "reactedAt": "2024-03-15T17:20:00Z",
      "isFollowing": false,
      "isMutualFriend": true,
      "mutualFriends": 18,
    },
  ];

  List<Map<String, dynamic>> get filteredLikes {
    if (selectedReactionType == "all") {
      return likes;
    }
    return likes.where((like) => like["reactionType"] == selectedReactionType).toList();
  }

  void _toggleFollow(String userId) async {
    isLoading = true;
    setState(() {});

    int index = likes.indexWhere((like) => like["userId"] == userId);
    if (index != -1) {
      bool currentlyFollowing = likes[index]["isFollowing"] as bool;
      
      await Future.delayed(Duration(seconds: 1));
      
      likes[index]["isFollowing"] = !currentlyFollowing;
      
      isLoading = false;
      setState(() {});
      
      ss(currentlyFollowing ? "Unfollowed user" : "Following user");
    }
  }

  String _getReactionEmoji(String reactionType) {
    switch (reactionType) {
      case "like":
        return "👍";
      case "love":
        return "❤️";
      case "wow":
        return "😮";
      case "laugh":
        return "😂";
      case "support":
        return "💪";
      default:
        return "👍";
    }
  }

  String _formatTimeAgo(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(date);

    if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else if (difference.inDays < 7) {
      return "${difference.inDays}d ago";
    } else {
      return "${date.day}/${date.month}/${date.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> displayLikes = filteredLikes;

    return Scaffold(
      appBar: AppBar(
        title: Text("Reactions"),
        actions: [
          QButton(
            icon: Icons.search,
            size: bs.sm,
            onPressed: () {
              // Search users
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Reaction Type Tabs
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.05),
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Reaction Types",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  height: 50,
                  child: QHorizontalScroll(
                    children: reactionTypes.map((reaction) {
                      bool isSelected = selectedReactionType == reaction["type"];
                      return GestureDetector(
                        onTap: () {
                          selectedReactionType = "${reaction["type"]}";
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: spSm),
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? primaryColor.withValues(alpha: 0.1) 
                                : Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : Colors.grey.withValues(alpha: 0.3),
                              width: isSelected ? 2 : 1,
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
                                "${reaction["label"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isSelected ? primaryColor : disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 4),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                decoration: BoxDecoration(
                                  color: isSelected 
                                      ? primaryColor 
                                      : Colors.grey.withValues(alpha: 0.3),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${reaction["count"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: isSelected ? Colors.white : disabledBoldColor,
                                    fontWeight: FontWeight.bold,
                                  ),
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

          // Users List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: displayLikes.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> like = displayLikes[index];
                bool isFollowing = like["isFollowing"] as bool;
                bool isMutualFriend = like["isMutualFriend"] as bool;
                int mutualFriends = like["mutualFriends"] as int;

                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundImage: NetworkImage("${like["userAvatar"]}"),
                          ),
                          Positioned(
                            bottom: -2,
                            right: -2,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusXs),
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: Center(
                                child: Text(
                                  _getReactionEmoji("${like["reactionType"]}"),
                                  style: TextStyle(fontSize: 10),
                                ),
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
                            Text(
                              "${like["userName"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${like["userUsername"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: 2),
                            Row(
                              children: [
                                if (isMutualFriend && mutualFriends > 0) ...[
                                  Icon(
                                    Icons.people,
                                    size: 12,
                                    color: secondaryColor,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    "$mutualFriends mutual friends",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: secondaryColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                ],
                                Icon(
                                  Icons.schedule,
                                  size: 12,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  _formatTimeAgo("${like["reactedAt"]}"),
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(width: spSm),
                      if (!isMutualFriend) // Only show follow button for non-friends
                        QButton(
                          label: isFollowing ? "Following" : "Follow",
                          size: bs.sm,
                          onPressed: isLoading 
                              ? null 
                              : () => _toggleFollow("${like["userId"]}"),
                        )
                      else
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                          decoration: BoxDecoration(
                            color: successColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "Friends",
                            style: TextStyle(
                              fontSize: 11,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Bottom Summary
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.05),
              border: Border(
                top: BorderSide(
                  color: Colors.grey.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: infoColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    selectedReactionType == "all"
                        ? "Showing all ${displayLikes.length} reactions"
                        : "Showing ${displayLikes.length} ${reactionTypes.firstWhere((r) => r["type"] == selectedReactionType)["label"]} reactions",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ),
                QButton(
                  label: "See All",
                  size: bs.sm,
                  onPressed: () {
                    selectedReactionType = "all";
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
