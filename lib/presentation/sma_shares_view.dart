import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaSharesView extends StatefulWidget {
  const SmaSharesView({super.key});

  @override
  State<SmaSharesView> createState() => _SmaSharesViewState();
}

class _SmaSharesViewState extends State<SmaSharesView> {
  String searchQuery = "";
  String selectedShareType = "all";
  bool isLoading = false;

  List<Map<String, dynamic>> shareTypes = [
    {"type": "all", "label": "All Shares", "count": 24},
    {"type": "reshare", "label": "Reshares", "count": 15},
    {"type": "story", "label": "Stories", "count": 6},
    {"type": "message", "label": "Messages", "count": 3},
  ];

  List<Map<String, dynamic>> shares = [
    {
      "id": "share_001",
      "userId": "user_003",
      "userName": "Mike Wilson",
      "userUsername": "@mike_workout",
      "userAvatar": "https://picsum.photos/100/100?random=3&keyword=man",
      "shareType": "reshare",
      "sharedAt": "2024-03-15T09:30:00Z",
      "shareComment": "This is exactly what I needed! Thanks for sharing this amazing workout routine. Going to try it tomorrow morning! 💪",
      "isFollowing": true,
      "isMutualFriend": true,
      "mutualFriends": 12,
      "visibility": "public",
    },
    {
      "id": "share_002",
      "userId": "user_004",
      "userName": "Alice Thompson",
      "userUsername": "@alice_j",
      "userAvatar": "https://picsum.photos/100/100?random=4&keyword=woman",
      "shareType": "story",
      "sharedAt": "2024-03-15T10:45:00Z",
      "shareComment": "",
      "isFollowing": true,
      "isMutualFriend": true,
      "mutualFriends": 28,
      "visibility": "friends",
    },
    {
      "id": "share_003",
      "userId": "user_005",
      "userName": "Emma Davis",
      "userUsername": "@emma_fitness",
      "userAvatar": "https://picsum.photos/100/100?random=5&keyword=woman",
      "shareType": "reshare",
      "sharedAt": "2024-03-15T12:15:00Z",
      "shareComment": "Love this gym! Highly recommend checking it out if you're in the downtown area.",
      "isFollowing": false,
      "isMutualFriend": true,
      "mutualFriends": 8,
      "visibility": "public",
    },
    {
      "id": "share_004",
      "userId": "user_006",
      "userName": "David Brown",
      "userUsername": "@david_fitness",
      "userAvatar": "https://picsum.photos/100/100?random=6&keyword=man",
      "shareType": "message",
      "sharedAt": "2024-03-15T13:20:00Z",
      "shareComment": "Check this out!",
      "isFollowing": false,
      "isMutualFriend": false,
      "mutualFriends": 0,
      "visibility": "private",
    },
    {
      "id": "share_005",
      "userId": "user_007",
      "userName": "Lisa Chang",
      "userUsername": "@lisa_health",
      "userAvatar": "https://picsum.photos/100/100?random=7&keyword=woman",
      "shareType": "story",
      "sharedAt": "2024-03-15T14:30:00Z",
      "shareComment": "",
      "isFollowing": true,
      "isMutualFriend": true,
      "mutualFriends": 15,
      "visibility": "close_friends",
    },
    {
      "id": "share_006",
      "userId": "user_008",
      "userName": "Tom Anderson",
      "userUsername": "@tom_fit",
      "userAvatar": "https://picsum.photos/100/100?random=8&keyword=man",
      "shareType": "reshare",
      "sharedAt": "2024-03-15T15:45:00Z",
      "shareComment": "Great gym recommendation! The facilities look amazing and the trainers seem really knowledgeable.",
      "isFollowing": false,
      "isMutualFriend": true,
      "mutualFriends": 6,
      "visibility": "public",
    },
    {
      "id": "share_007",
      "userId": "user_009",
      "userName": "Rachel Green",
      "userUsername": "@rachel_yoga",
      "userAvatar": "https://picsum.photos/100/100?random=9&keyword=woman",
      "shareType": "reshare",
      "sharedAt": "2024-03-15T16:10:00Z",
      "shareComment": "Sharing with my yoga community! This gym has excellent yoga classes too.",
      "isFollowing": true,
      "isMutualFriend": false,
      "mutualFriends": 0,
      "visibility": "public",
    },
    {
      "id": "share_008",
      "userId": "user_010",
      "userName": "James Wilson",
      "userUsername": "@james_cardio",
      "userAvatar": "https://picsum.photos/100/100?random=10&keyword=man",
      "shareType": "message",
      "sharedAt": "2024-03-15T17:30:00Z",
      "shareComment": "Thought you might be interested in this gym!",
      "isFollowing": false,
      "isMutualFriend": true,
      "mutualFriends": 18,
      "visibility": "private",
    },
  ];

  List<Map<String, dynamic>> get filteredShares {
    List<Map<String, dynamic>> filtered = shares;
    
    // Filter by share type
    if (selectedShareType != "all") {
      filtered = filtered.where((share) => share["shareType"] == selectedShareType).toList();
    }
    
    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((share) {
        return "${share["userName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
               "${share["userUsername"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
               "${share["shareComment"]}".toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    return filtered;
  }

  void _toggleFollow(String userId) async {
    isLoading = true;
    setState(() {});

    int index = shares.indexWhere((share) => share["userId"] == userId);
    if (index != -1) {
      bool currentlyFollowing = shares[index]["isFollowing"] as bool;
      
      await Future.delayed(Duration(seconds: 1));
      
      shares[index]["isFollowing"] = !currentlyFollowing;
      
      isLoading = false;
      setState(() {});
      
      ss(currentlyFollowing ? "Unfollowed user" : "Following user");
    }
  }

  IconData _getShareTypeIcon(String shareType) {
    switch (shareType) {
      case "reshare":
        return Icons.repeat;
      case "story":
        return Icons.auto_stories;
      case "message":
        return Icons.message;
      default:
        return Icons.share;
    }
  }

  Color _getShareTypeColor(String shareType) {
    switch (shareType) {
      case "reshare":
        return primaryColor;
      case "story":
        return Colors.purple;
      case "message":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getVisibilityIcon(String visibility) {
    switch (visibility) {
      case "public":
        return Icons.public;
      case "friends":
        return Icons.people;
      case "close_friends":
        return Icons.favorite;
      case "private":
        return Icons.lock;
      default:
        return Icons.public;
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
    List<Map<String, dynamic>> displayShares = filteredShares;

    return Scaffold(
      appBar: AppBar(
        title: Text("Shares"),
        actions: [
          QButton(
            icon: Icons.sort,
            size: bs.sm,
            onPressed: () {
              // Show sort options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
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
                  label: "Search shares...",
                  value: searchQuery,
                  hint: "Search by name or comment",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spMd),
                
                // Share Type Filter
                Text(
                  "Share Types",
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
                    children: shareTypes.map((type) {
                      bool isSelected = selectedShareType == type["type"];
                      return GestureDetector(
                        onTap: () {
                          selectedShareType = "${type["type"]}";
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
                              Icon(
                                _getShareTypeIcon("${type["type"]}"),
                                size: 16,
                                color: isSelected ? primaryColor : disabledBoldColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${type["label"]}",
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
                                  "${type["count"]}",
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

          // Shares List
          Expanded(
            child: displayShares.isEmpty
                ? Container(
                    padding: EdgeInsets.all(spLg),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.share,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "No shares found",
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
                    itemCount: displayShares.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> share = displayShares[index];
                      bool isFollowing = share["isFollowing"] as bool;
                      bool isMutualFriend = share["isMutualFriend"] as bool;
                      int mutualFriends = share["mutualFriends"] as int;
                      String shareType = "${share["shareType"]}";
                      String visibility = "${share["visibility"]}";

                      return Container(
                        margin: EdgeInsets.only(bottom: spMd),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // User Info Row
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage("${share["userAvatar"]}"),
                                ),
                                SizedBox(width: spSm),
                                
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${share["userName"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Icon(
                                            _getShareTypeIcon(shareType),
                                            size: 14,
                                            color: _getShareTypeColor(shareType),
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            shareType == "reshare" ? "reshared" :
                                            shareType == "story" ? "shared to story" :
                                            shareType == "message" ? "sent via message" : "shared",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: _getShareTypeColor(shareType),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${share["userUsername"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          if (isMutualFriend && mutualFriends > 0) ...[
                                            Icon(
                                              Icons.people,
                                              size: 10,
                                              color: secondaryColor,
                                            ),
                                            SizedBox(width: 2),
                                            Text(
                                              "$mutualFriends mutual",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: secondaryColor,
                                              ),
                                            ),
                                            SizedBox(width: spXs),
                                          ],
                                          Icon(
                                            _getVisibilityIcon(visibility),
                                            size: 10,
                                            color: disabledBoldColor,
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            _formatTimeAgo("${share["sharedAt"]}"),
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                
                                if (!isMutualFriend)
                                  QButton(
                                    label: isFollowing ? "Following" : "Follow",
                                    size: bs.sm,
                                    onPressed: isLoading 
                                        ? null 
                                        : () => _toggleFollow("${share["userId"]}"),
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
                              ],
                            ),

                            // Share Comment (if exists)
                            if ("${share["shareComment"]}".isNotEmpty) ...[
                              SizedBox(height: spSm),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withValues(alpha: 0.05),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(
                                    color: Colors.grey.withValues(alpha: 0.2),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  "${share["shareComment"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: primaryColor,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                            ],

                            // Share Actions
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                QButton(
                                  label: "View Share",
                                  icon: Icons.open_in_new,
                                  size: bs.sm,
                                  onPressed: () {
                                    // View shared post
                                  },
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  label: "Visit Profile",
                                  icon: Icons.person,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Visit user profile
                                  },
                                ),
                                Spacer(),
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
                    "Showing ${displayShares.length} ${selectedShareType == "all" ? "shares" : shareTypes.firstWhere((t) => t["type"] == selectedShareType)["label"].toLowerCase()}",
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
                    selectedShareType = "all";
                    searchQuery = "";
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
