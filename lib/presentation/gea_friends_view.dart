import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaFriendsView extends StatefulWidget {
  const GeaFriendsView({super.key});

  @override
  State<GeaFriendsView> createState() => _GeaFriendsViewState();
}

class _GeaFriendsViewState extends State<GeaFriendsView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedFilter = "All";
  bool showOnlineOnly = false;

  final List<Map<String, dynamic>> friends = [
    {
      "id": "F001",
      "name": "DragonSlayer",
      "level": 52,
      "rank": "Master",
      "status": "Online",
      "activity": "In Lobby",
      "avatar": "https://picsum.photos/60/60?random=20",
      "isOnline": true,
      "lastSeen": "Now",
      "favoriteGame": "Battle Arena",
      "winRate": 89.2,
      "mutualFriends": 12,
      "isFavorite": true,
      "friendSince": "2024-01-10",
    },
    {
      "id": "F002",
      "name": "MysticWarrior",
      "level": 48,
      "rank": "Diamond",
      "status": "In Game",
      "activity": "Ranked Match",
      "avatar": "https://picsum.photos/60/60?random=21",
      "isOnline": true,
      "lastSeen": "Now",
      "favoriteGame": "Combat Zone",
      "winRate": 76.8,
      "mutualFriends": 8,
      "isFavorite": false,
      "friendSince": "2024-02-15",
    },
    {
      "id": "F003",
      "name": "ShadowHunter",
      "level": 44,
      "rank": "Platinum",
      "status": "Away",
      "activity": "Idle",
      "avatar": "https://picsum.photos/60/60?random=22",
      "isOnline": true,
      "lastSeen": "5 mins ago",
      "favoriteGame": "Stealth Ops",
      "winRate": 82.1,
      "mutualFriends": 15,
      "isFavorite": true,
      "friendSince": "2024-01-25",
    },
    {
      "id": "F004",
      "name": "ThunderBolt",
      "level": 39,
      "rank": "Gold",
      "status": "Offline",
      "activity": "Last seen 2 hours ago",
      "avatar": "https://picsum.photos/60/60?random=23",
      "isOnline": false,
      "lastSeen": "2 hours ago",
      "favoriteGame": "Racing Storm",
      "winRate": 71.5,
      "mutualFriends": 6,
      "isFavorite": false,
      "friendSince": "2024-03-01",
    },
    {
      "id": "F005",
      "name": "CyberNinja",
      "level": 56,
      "rank": "Master",
      "status": "Online",
      "activity": "In Lobby",
      "avatar": "https://picsum.photos/60/60?random=24",
      "isOnline": true,
      "lastSeen": "Now",
      "favoriteGame": "Cyber Arena",
      "winRate": 91.7,
      "mutualFriends": 18,
      "isFavorite": true,
      "friendSince": "2024-01-05",
    },
  ];

  final List<Map<String, dynamic>> friendRequests = [
    {
      "id": "R001",
      "name": "StarGazer",
      "level": 41,
      "rank": "Platinum",
      "avatar": "https://picsum.photos/60/60?random=30",
      "mutualFriends": 5,
      "requestDate": "2024-03-15",
      "requestTime": "2 hours ago",
    },
    {
      "id": "R002",
      "name": "FlameWarden",
      "level": 35,
      "rank": "Gold",
      "avatar": "https://picsum.photos/60/60?random=31",
      "mutualFriends": 3,
      "requestDate": "2024-03-14",
      "requestTime": "1 day ago",
    },
  ];

  final List<Map<String, dynamic>> suggestions = [
    {
      "id": "S001",
      "name": "IcePhoenix",
      "level": 47,
      "rank": "Diamond",
      "avatar": "https://picsum.photos/60/60?random=40",
      "mutualFriends": 8,
      "reason": "Mutual friends",
      "commonGame": "Battle Arena",
    },
    {
      "id": "S002",
      "name": "WindWalker",
      "level": 43,
      "rank": "Platinum",
      "avatar": "https://picsum.photos/60/60?random=41",
      "mutualFriends": 12,
      "reason": "Similar rank",
      "commonGame": "Combat Zone",
    },
    {
      "id": "S003",
      "name": "StormBreaker",
      "level": 50,
      "rank": "Diamond",
      "avatar": "https://picsum.photos/60/60?random=42",
      "mutualFriends": 6,
      "reason": "Recently played together",
      "commonGame": "Ranked Match",
    },
  ];

  final List<Map<String, dynamic>> recentActivity = [
    {
      "friend": "DragonSlayer",
      "activity": "achieved Master rank",
      "time": "2 hours ago",
      "type": "achievement",
    },
    {
      "friend": "CyberNinja",
      "activity": "won a tournament match",
      "time": "4 hours ago",
      "type": "match",
    },
    {
      "friend": "ShadowHunter",
      "activity": "unlocked new character",
      "time": "6 hours ago",
      "type": "unlock",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Friends",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Friends", icon: Icon(Icons.people)),
        Tab(text: "Requests", icon: Icon(Icons.person_add)),
        Tab(text: "Discover", icon: Icon(Icons.explore)),
        Tab(text: "Activity", icon: Icon(Icons.notifications)),
      ],
      tabChildren: [
        _buildFriendsTab(),
        _buildRequestsTab(),
        _buildDiscoverTab(),
        _buildActivityTab(),
      ],
    );
  }

  Widget _buildFriendsTab() {
    List<Map<String, dynamic>> filteredFriends = friends.where((friend) {
      bool matchesSearch = friend["name"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesFilter = selectedFilter == "All" || 
                          (selectedFilter == "Online" && friend["isOnline"]) ||
                          (selectedFilter == "Favorites" && friend["isFavorite"]);
      bool matchesOnlineFilter = !showOnlineOnly || friend["isOnline"];
      return matchesSearch && matchesFilter && matchesOnlineFilter;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filters
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: disabledBoldColor),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                searchQuery.isEmpty ? "Search friends..." : searchQuery,
                                style: TextStyle(
                                  color: searchQuery.isEmpty ? disabledBoldColor : Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    QButton(
                      icon: Icons.person_add,
                      size: bs.sm,
                      onPressed: () {
                        selectedTab = 2;
                        setState(() {});
                      },
                    ),
                  ],
                ),
                
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Filter",
                        items: [
                          {"label": "All Friends", "value": "All"},
                          {"label": "Online", "value": "Online"},
                          {"label": "Favorites", "value": "Favorites"},
                        ],
                        value: selectedFilter,
                        onChanged: (value, label) {
                          selectedFilter = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Friends Stats
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem("Total", "${friends.length}", Icons.people),
                _buildStatItem("Online", "${friends.where((f) => f["isOnline"]).length}", Icons.circle),
                _buildStatItem("Favorites", "${friends.where((f) => f["isFavorite"]).length}", Icons.star),
                _buildStatItem("Requests", "${friendRequests.length}", Icons.person_add),
              ],
            ),
          ),

          // Friends List
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Friends (${filteredFriends.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                if (filteredFriends.isEmpty)
                  Center(
                    child: Column(
                      children: [
                        Icon(Icons.people_outline, size: 64, color: disabledBoldColor),
                        SizedBox(height: spSm),
                        Text(
                          "No friends found",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  ...filteredFriends.map((friend) => _buildFriendCard(friend)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Pending Requests
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Friend Requests (${friendRequests.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                if (friendRequests.isEmpty)
                  Center(
                    child: Column(
                      children: [
                        Icon(Icons.person_add_disabled, size: 64, color: disabledBoldColor),
                        SizedBox(height: spSm),
                        Text(
                          "No pending requests",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  ...friendRequests.map((request) => _buildRequestCard(request)),
              ],
            ),
          ),

          // Quick Actions
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Find Friends",
                        icon: Icons.search,
                        onPressed: () {
                          selectedTab = 2;
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Invite by ID",
                        icon: Icons.qr_code,
                        onPressed: () {
                          //navigateTo(GeaInviteByIdView())
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

  Widget _buildDiscoverTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search Players
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Find Players",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: disabledBoldColor),
                            SizedBox(width: spSm),
                            Text(
                              "Search by username or ID...",
                              style: TextStyle(color: disabledBoldColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    QButton(
                      icon: Icons.qr_code_scanner,
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo(GeaQrScannerView())
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Friend Suggestions
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "People You May Know",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...suggestions.map((suggestion) => _buildSuggestionCard(suggestion)),
              ],
            ),
          ),

          // Nearby Players
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nearby Players",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Enable Location",
                        icon: Icons.location_on,
                        onPressed: () {},
                      ),
                    ),
                    QButton(
                      icon: Icons.refresh,
                      size: bs.sm,
                      onPressed: () {},
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

  Widget _buildActivityTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Activity Summary
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "Friends Activity",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildActivityStat("Active", "${friends.where((f) => f["isOnline"]).length}", Icons.circle),
                    _buildActivityStat("Playing", "${friends.where((f) => f["status"] == "In Game").length}", Icons.sports_esports),
                    _buildActivityStat("Recent", "${recentActivity.length}", Icons.update),
                  ],
                ),
              ],
            ),
          ),

          // Recent Activity
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recent Activity",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                if (recentActivity.isEmpty)
                  Center(
                    child: Column(
                      children: [
                        Icon(Icons.timeline, size: 64, color: disabledBoldColor),
                        SizedBox(height: spSm),
                        Text(
                          "No recent activity",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  ...recentActivity.map((activity) => _buildActivityCard(activity)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(10),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: primaryColor,
            size: 24,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildFriendCard(Map<String, dynamic> friend) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: friend["isFavorite"] ? Border.all(color: warningColor, width: 1) : null,
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage("${friend["avatar"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (friend["isOnline"])
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: _getStatusColor(friend["status"]),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              if (friend["isFavorite"])
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: warningColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.star,
                      size: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${friend["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Level ${friend["level"]} • ${friend["rank"]} • ${friend["winRate"]}% WR",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${friend["activity"]} • ${friend["mutualFriends"]} mutual friends",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                spacing: spXs,
                children: [
                  QButton(
                    icon: Icons.message,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo(GeaChatView(friendId: friend["id"]))
                    },
                  ),
                  QButton(
                    icon: Icons.gamepad,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo(GeaInviteToGameView(friendId: friend["id"]))
                    },
                  ),
                ],
              ),
              SizedBox(height: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showFriendOptions(friend);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRequestCard(Map<String, dynamic> request) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage("${request["avatar"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${request["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Level ${request["level"]} • ${request["rank"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${request["mutualFriends"]} mutual friends • ${request["requestTime"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                spacing: spXs,
                children: [
                  QButton(
                    icon: Icons.check,
                    size: bs.sm,
                    onPressed: () {
                      _acceptRequest(request);
                    },
                  ),
                  QButton(
                    icon: Icons.close,
                    size: bs.sm,
                    onPressed: () {
                      _declineRequest(request);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionCard(Map<String, dynamic> suggestion) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage("${suggestion["avatar"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${suggestion["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Level ${suggestion["level"]} • ${suggestion["rank"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${suggestion["reason"]} • ${suggestion["mutualFriends"]} mutual",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              QButton(
                icon: Icons.person_add,
                size: bs.sm,
                onPressed: () {
                  _sendFriendRequest(suggestion);
                },
              ),
              SizedBox(height: spXs),
              QButton(
                icon: Icons.close,
                size: bs.sm,
                onPressed: () {
                  _dismissSuggestion(suggestion);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> activity) {
    IconData activityIcon;
    Color activityColor;
    
    switch (activity["type"]) {
      case "achievement":
        activityIcon = Icons.emoji_events;
        activityColor = warningColor;
        break;
      case "match":
        activityIcon = Icons.sports_esports;
        activityColor = successColor;
        break;
      case "unlock":
        activityIcon = Icons.lock_open;
        activityColor = infoColor;
        break;
      default:
        activityIcon = Icons.update;
        activityColor = primaryColor;
    }

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: activityColor.withAlpha(10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              activityIcon,
              color: activityColor,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    children: [
                      TextSpan(
                        text: "${activity["friend"]} ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: "${activity["activity"]}"),
                    ],
                  ),
                ),
                Text(
                  "${activity["time"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(10),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: primaryColor,
            size: 20,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Online":
        return successColor;
      case "In Game":
        return warningColor;
      case "Away":
        return infoColor;
      case "Offline":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showFriendOptions(Map<String, dynamic> friend) {
    // Show friend options dialog
  }

  void _acceptRequest(Map<String, dynamic> request) {
    // Handle accepting friend request
    setState(() {
      friendRequests.remove(request);
    });
    ss("Friend request accepted!");
  }

  void _declineRequest(Map<String, dynamic> request) {
    // Handle declining friend request
    setState(() {
      friendRequests.remove(request);
    });
    si("Friend request declined");
  }

  void _sendFriendRequest(Map<String, dynamic> suggestion) {
    // Handle sending friend request
    ss("Friend request sent!");
  }

  void _dismissSuggestion(Map<String, dynamic> suggestion) {
    // Handle dismissing suggestion
    setState(() {
      suggestions.remove(suggestion);
    });
  }
}
