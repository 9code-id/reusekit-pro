import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaFriendsTaggingView extends StatefulWidget {
  const SmaFriendsTaggingView({super.key});

  @override
  State<SmaFriendsTaggingView> createState() => _SmaFriendsTaggingViewState();
}

class _SmaFriendsTaggingViewState extends State<SmaFriendsTaggingView> {
  String searchQuery = "";
  List<String> selectedFriendIds = [];
  bool isSearching = false;

  List<Map<String, dynamic>> friends = [
    {
      "id": "friend_001",
      "name": "Alice Johnson",
      "username": "@alice_j",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=woman",
      "isOnline": true,
      "mutualFriends": 15,
      "isClose": true,
    },
    {
      "id": "friend_002",
      "name": "Bob Smith",
      "username": "@bobsmith",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=man",
      "isOnline": false,
      "mutualFriends": 8,
      "isClose": false,
    },
    {
      "id": "friend_003",
      "name": "Carol Williams",
      "username": "@carol_w",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=woman",
      "isOnline": true,
      "mutualFriends": 22,
      "isClose": true,
    },
    {
      "id": "friend_004",
      "name": "David Brown",
      "username": "@david_b",
      "avatar": "https://picsum.photos/100/100?random=4&keyword=man",
      "isOnline": false,
      "mutualFriends": 5,
      "isClose": false,
    },
    {
      "id": "friend_005",
      "name": "Emily Davis",
      "username": "@emily_d",
      "avatar": "https://picsum.photos/100/100?random=5&keyword=woman",
      "isOnline": true,
      "mutualFriends": 18,
      "isClose": true,
    },
    {
      "id": "friend_006",
      "name": "Frank Wilson",
      "username": "@frank_w",
      "avatar": "https://picsum.photos/100/100?random=6&keyword=man",
      "isOnline": false,
      "mutualFriends": 12,
      "isClose": false,
    },
    {
      "id": "friend_007",
      "name": "Grace Miller",
      "username": "@grace_m",
      "avatar": "https://picsum.photos/100/100?random=7&keyword=woman",
      "isOnline": true,
      "mutualFriends": 9,
      "isClose": true,
    },
    {
      "id": "friend_008",
      "name": "Henry Taylor",
      "username": "@henry_t",
      "avatar": "https://picsum.photos/100/100?random=8&keyword=man",
      "isOnline": false,
      "mutualFriends": 6,
      "isClose": false,
    },
  ];

  List<Map<String, dynamic>> get filteredFriends {
    if (searchQuery.isEmpty) {
      // Show close friends first, then others
      List<Map<String, dynamic>> closeFriends = friends.where((f) => f["isClose"] as bool).toList();
      List<Map<String, dynamic>> otherFriends = friends.where((f) => !(f["isClose"] as bool)).toList();
      return [...closeFriends, ...otherFriends];
    }

    return friends.where((friend) {
      return "${friend["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
             "${friend["username"]}".toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  void _toggleFriendSelection(String friendId) {
    if (selectedFriendIds.contains(friendId)) {
      selectedFriendIds.remove(friendId);
    } else {
      selectedFriendIds.add(friendId);
    }
    setState(() {});
  }

  void _confirmTagging() {
    if (selectedFriendIds.isEmpty) {
      se("Please select at least one friend to tag");
      return;
    }

    List<String> taggedNames = friends
        .where((f) => selectedFriendIds.contains(f["id"]))
        .map((f) => "${f["name"]}")
        .toList();

    ss("Tagged ${taggedNames.length} friend${taggedNames.length > 1 ? 's' : ''}: ${taggedNames.join(', ')}");
    back();
  }

  void _searchFriends() async {
    if (searchQuery.trim().isEmpty) return;

    isSearching = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 1));

    isSearching = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tag Friends"),
        actions: [
          QButton(
            label: "Done (${selectedFriendIds.length})",
            size: bs.sm,
            onPressed: _confirmTagging,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.grey.withValues(alpha: 0.05),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search friends...",
                        value: searchQuery,
                        hint: "Type friend's name or username",
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                          if (value.length > 2) {
                            _searchFriends();
                          }
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: isSearching ? Icons.hourglass_empty : Icons.search,
                      size: bs.sm,
                      onPressed: isSearching ? null : _searchFriends,
                    ),
                  ],
                ),
                
                if (isSearching)
                  Container(
                    margin: EdgeInsets.only(top: spSm),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(strokeWidth: 2),
                        SizedBox(width: spSm),
                        Text(
                          "Searching friends...",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // Selected Friends Preview
          if (selectedFriendIds.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.05),
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
                    "Selected Friends (${selectedFriendIds.length})",
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
                      children: selectedFriendIds.map((friendId) {
                        Map<String, dynamic> friend = friends.firstWhere((f) => f["id"] == friendId);
                        return Container(
                          margin: EdgeInsets.only(right: spSm),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage("${friend["avatar"]}"),
                                  ),
                                  Positioned(
                                    top: -5,
                                    right: -5,
                                    child: GestureDetector(
                                      onTap: () => _toggleFriendSelection(friendId),
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: dangerColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Text(
                                "${friend["name"]}".split(' ').first,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

          // Friends List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: filteredFriends.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> friend = filteredFriends[index];
                bool isSelected = selectedFriendIds.contains(friend["id"]);
                bool isClose = friend["isClose"] as bool;
                bool isOnline = friend["isOnline"] as bool;
                
                return GestureDetector(
                  onTap: () => _toggleFriendSelection("${friend["id"]}"),
                  child: Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor.withValues(alpha: 0.1) : Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border.all(
                        color: isSelected ? primaryColor : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 22,
                              backgroundImage: NetworkImage("${friend["avatar"]}"),
                            ),
                            if (isOnline)
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: successColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
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
                                    "${friend["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  if (isClose) ...[
                                    SizedBox(width: 4),
                                    Icon(
                                      Icons.favorite,
                                      color: dangerColor,
                                      size: 12,
                                    ),
                                  ],
                                ],
                              ),
                              Text(
                                "${friend["username"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: secondaryColor,
                                ),
                              ),
                              SizedBox(height: 2),
                              
                              Row(
                                children: [
                                  Icon(
                                    Icons.people,
                                    size: 12,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    "${friend["mutualFriends"]} mutual friends",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  if (isOnline) ...[
                                    SizedBox(width: spSm),
                                    Icon(
                                      Icons.circle,
                                      size: 8,
                                      color: successColor,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "Online",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(width: spSm),
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: primaryColor,
                            size: 24,
                          )
                        else
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.withValues(alpha: 0.4),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Bottom Actions
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
                Expanded(
                  child: QButton(
                    label: "Select All Close Friends",
                    icon: Icons.favorite,
                    size: bs.sm,
                    onPressed: () {
                      selectedFriendIds.clear();
                      selectedFriendIds.addAll(
                        friends.where((f) => f["isClose"] as bool)
                               .map((f) => "${f["id"]}")
                               .toList()
                      );
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Clear Selection",
                    icon: Icons.clear,
                    size: bs.sm,
                    onPressed: () {
                      selectedFriendIds.clear();
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
