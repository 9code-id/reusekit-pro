import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaReactionsView extends StatefulWidget {
  const SmaReactionsView({super.key});

  @override
  State<SmaReactionsView> createState() => _SmaReactionsViewState();
}

class _SmaReactionsViewState extends State<SmaReactionsView> {
  String selectedReactionType = "all";
  String selectedTimeFilter = "all_time";
  bool showOnlyFriends = false;
  String searchQuery = "";

  List<Map<String, dynamic>> reactionTypes = [
    {"type": "all", "emoji": "👍", "label": "All Reactions", "count": 186},
    {"type": "like", "emoji": "👍", "label": "Like", "count": 89},
    {"type": "love", "emoji": "❤️", "label": "Love", "count": 32},
    {"type": "wow", "emoji": "😮", "label": "Wow", "count": 15},
    {"type": "laugh", "emoji": "😂", "label": "Haha", "count": 18},
    {"type": "support", "emoji": "💪", "label": "Support", "count": 22},
    {"type": "sad", "emoji": "😢", "label": "Sad", "count": 4},
    {"type": "angry", "emoji": "😠", "label": "Angry", "count": 6},
  ];

  List<Map<String, dynamic>> timeFilters = [
    {"value": "all_time", "label": "All Time"},
    {"value": "today", "label": "Today"},
    {"value": "this_week", "label": "This Week"},
    {"value": "this_month", "label": "This Month"},
  ];

  List<Map<String, dynamic>> reactions = [
    {
      "id": "reaction_001",
      "userId": "user_003",
      "userName": "Mike Wilson",
      "userUsername": "@mike_workout",
      "userAvatar": "https://picsum.photos/100/100?random=3&keyword=man",
      "reactionType": "support",
      "reactedAt": "2024-03-15T09:15:00Z",
      "isFollowing": true,
      "isFriend": true,
      "mutualFriends": 12,
      "postPreview": "Just finished my morning workout...",
      "postType": "text",
    },
    {
      "id": "reaction_002",
      "userId": "user_004",
      "userName": "Alice Thompson",
      "userUsername": "@alice_j",
      "userAvatar": "https://picsum.photos/100/100?random=4&keyword=woman",
      "reactionType": "love",
      "reactedAt": "2024-03-15T10:22:00Z",
      "isFollowing": true,
      "isFriend": true,
      "mutualFriends": 28,
      "postPreview": "Just finished my morning workout...",
      "postType": "image",
    },
    {
      "id": "reaction_003",
      "userId": "user_005",
      "userName": "Emma Davis",
      "userUsername": "@emma_fitness",
      "userAvatar": "https://picsum.photos/100/100?random=5&keyword=woman",
      "reactionType": "like",
      "reactedAt": "2024-03-15T11:45:00Z",
      "isFollowing": false,
      "isFriend": true,
      "mutualFriends": 8,
      "postPreview": "Just finished my morning workout...",
      "postType": "text",
    },
    {
      "id": "reaction_004",
      "userId": "user_006",
      "userName": "David Brown",
      "userUsername": "@david_fitness",
      "userAvatar": "https://picsum.photos/100/100?random=6&keyword=man",
      "reactionType": "wow",
      "reactedAt": "2024-03-15T12:30:00Z",
      "isFollowing": false,
      "isFriend": false,
      "mutualFriends": 0,
      "postPreview": "Just finished my morning workout...",
      "postType": "video",
    },
    {
      "id": "reaction_005",
      "userId": "user_007",
      "userName": "Lisa Chang",
      "userUsername": "@lisa_health",
      "userAvatar": "https://picsum.photos/100/100?random=7&keyword=woman",
      "reactionType": "laugh",
      "reactedAt": "2024-03-15T14:10:00Z",
      "isFollowing": true,
      "isFriend": true,
      "mutualFriends": 15,
      "postPreview": "Just finished my morning workout...",
      "postType": "text",
    },
    {
      "id": "reaction_006",
      "userId": "user_008",
      "userName": "Tom Anderson",
      "userUsername": "@tom_fit",
      "userAvatar": "https://picsum.photos/100/100?random=8&keyword=man",
      "reactionType": "like",
      "reactedAt": "2024-03-14T15:30:00Z",
      "isFollowing": false,
      "isFriend": true,
      "mutualFriends": 6,
      "postPreview": "Just finished my morning workout...",
      "postType": "image",
    },
    {
      "id": "reaction_007",
      "userId": "user_009",
      "userName": "Rachel Green",
      "userUsername": "@rachel_yoga",
      "userAvatar": "https://picsum.photos/100/100?random=9&keyword=woman",
      "reactionType": "love",
      "reactedAt": "2024-03-14T16:45:00Z",
      "isFollowing": true,
      "isFriend": false,
      "mutualFriends": 0,
      "postPreview": "Just finished my morning workout...",
      "postType": "text",
    },
    {
      "id": "reaction_008",
      "userId": "user_010",
      "userName": "James Wilson",
      "userUsername": "@james_cardio",
      "userAvatar": "https://picsum.photos/100/100?random=10&keyword=man",
      "reactionType": "support",
      "reactedAt": "2024-03-13T17:20:00Z",
      "isFollowing": false,
      "isFriend": true,
      "mutualFriends": 18,
      "postPreview": "Just finished my morning workout...",
      "postType": "video",
    },
  ];

  List<Map<String, dynamic>> get filteredReactions {
    List<Map<String, dynamic>> filtered = reactions;
    
    // Filter by reaction type
    if (selectedReactionType != "all") {
      filtered = filtered.where((reaction) => reaction["reactionType"] == selectedReactionType).toList();
    }
    
    // Filter by friends only
    if (showOnlyFriends) {
      filtered = filtered.where((reaction) => reaction["isFriend"] as bool).toList();
    }
    
    // Filter by time
    if (selectedTimeFilter != "all_time") {
      DateTime now = DateTime.now();
      DateTime filterDate;
      
      switch (selectedTimeFilter) {
        case "today":
          filterDate = DateTime(now.year, now.month, now.day);
          break;
        case "this_week":
          filterDate = now.subtract(Duration(days: 7));
          break;
        case "this_month":
          filterDate = DateTime(now.year, now.month, 1);
          break;
        default:
          filterDate = DateTime(2000);
      }
      
      filtered = filtered.where((reaction) {
        DateTime reactionDate = DateTime.parse("${reaction["reactedAt"]}");
        return reactionDate.isAfter(filterDate);
      }).toList();
    }
    
    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((reaction) {
        return "${reaction["userName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
               "${reaction["userUsername"]}".toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    // Sort by most recent
    filtered.sort((a, b) => DateTime.parse("${b["reactedAt"]}").compareTo(DateTime.parse("${a["reactedAt"]}")));
    
    return filtered;
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
      case "sad":
        return "😢";
      case "angry":
        return "😠";
      default:
        return "👍";
    }
  }

  Color _getReactionColor(String reactionType) {
    switch (reactionType) {
      case "like":
        return primaryColor;
      case "love":
        return Colors.red;
      case "wow":
        return Colors.orange;
      case "laugh":
        return Colors.amber;
      case "support":
        return Colors.green;
      case "sad":
        return Colors.blue;
      case "angry":
        return Colors.red;
      default:
        return primaryColor;
    }
  }

  IconData _getPostTypeIcon(String postType) {
    switch (postType) {
      case "text":
        return Icons.text_fields;
      case "image":
        return Icons.image;
      case "video":
        return Icons.video_library;
      default:
        return Icons.post_add;
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
    List<Map<String, dynamic>> displayReactions = filteredReactions;

    return Scaffold(
      appBar: AppBar(
        title: Text("Reactions"),
        actions: [
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: () {
              // Show reaction analytics
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filters Section
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
                // Search Bar
                QTextField(
                  label: "Search reactions...",
                  value: searchQuery,
                  hint: "Search by name or username",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spMd),

                // Reaction Type Filter
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
                  height: 60,
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
                                ? _getReactionColor("${reaction["type"]}").withValues(alpha: 0.1)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected 
                                  ? _getReactionColor("${reaction["type"]}")
                                  : Colors.grey.withValues(alpha: 0.3),
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${reaction["emoji"]}",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 2),
                              Text(
                                "${reaction["label"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isSelected 
                                      ? _getReactionColor("${reaction["type"]}")
                                      : disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 2),
                                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                decoration: BoxDecoration(
                                  color: isSelected 
                                      ? _getReactionColor("${reaction["type"]}")
                                      : Colors.grey.withValues(alpha: 0.3),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${reaction["count"]}",
                                  style: TextStyle(
                                    fontSize: 8,
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
                SizedBox(height: spMd),

                // Additional Filters
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Time Period",
                        items: timeFilters,
                        value: selectedTimeFilter,
                        onChanged: (value, label) {
                          selectedTimeFilter = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Friends only",
                            "value": true,
                            "checked": showOnlyFriends,
                          }
                        ],
                        value: [
                          if (showOnlyFriends)
                            {
                              "label": "Friends only",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          showOnlyFriends = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Reactions List
          Expanded(
            child: displayReactions.isEmpty
                ? Container(
                    padding: EdgeInsets.all(spLg),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.sentiment_satisfied,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "No reactions found",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Try adjusting your filters or search terms",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(spMd),
                    itemCount: displayReactions.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> reaction = displayReactions[index];
                      bool isFollowing = reaction["isFollowing"] as bool;
                      bool isFriend = reaction["isFriend"] as bool;
                      int mutualFriends = reaction["mutualFriends"] as int;
                      String reactionType = "${reaction["reactionType"]}";

                      return Container(
                        margin: EdgeInsets.only(bottom: spMd),
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
                                  backgroundImage: NetworkImage("${reaction["userAvatar"]}"),
                                ),
                                Positioned(
                                  bottom: -2,
                                  right: -2,
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                      border: Border.all(color: Colors.white, width: 2),
                                    ),
                                    child: Center(
                                      child: Text(
                                        _getReactionEmoji(reactionType),
                                        style: TextStyle(fontSize: 12),
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
                                  Row(
                                    children: [
                                      Text(
                                        "${reaction["userName"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "reacted with",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        _getReactionEmoji(reactionType),
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${reaction["userUsername"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Row(
                                    children: [
                                      Icon(
                                        _getPostTypeIcon("${reaction["postType"]}"),
                                        size: 12,
                                        color: secondaryColor,
                                      ),
                                      SizedBox(width: 2),
                                      Expanded(
                                        child: Text(
                                          "${reaction["postPreview"]}",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: secondaryColor,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        _formatTimeAgo("${reaction["reactedAt"]}"),
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (isFriend && mutualFriends > 0) ...[
                                    SizedBox(height: 2),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.people,
                                          size: 10,
                                          color: successColor,
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          "$mutualFriends mutual friends",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: successColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            
                            SizedBox(width: spSm),
                            Column(
                              children: [
                                if (!isFriend)
                                  QButton(
                                    label: isFollowing ? "Following" : "Follow",
                                    size: bs.sm,
                                    onPressed: () {
                                      // Toggle follow
                                    },
                                  )
                                else
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: successColor.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "Friends",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                SizedBox(height: spXs),
                                QButton(
                                  icon: Icons.more_vert,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Show more options
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          // Summary and Stats
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
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.analytics,
                      color: infoColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "Showing ${displayReactions.length} reaction${displayReactions.length != 1 ? 's' : ''}",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                        ),
                      ),
                    ),
                    QButton(
                      label: "Clear Filters",
                      size: bs.sm,
                      onPressed: () {
                        selectedReactionType = "all";
                        selectedTimeFilter = "all_time";
                        showOnlyFriends = false;
                        searchQuery = "";
                        setState(() {});
                      },
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Export Data",
                        icon: Icons.download,
                        size: bs.sm,
                        onPressed: () {
                          ss("Reaction data exported");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "View Analytics",
                        icon: Icons.insights,
                        size: bs.sm,
                        onPressed: () {
                          // Show detailed analytics
                        },
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
}
