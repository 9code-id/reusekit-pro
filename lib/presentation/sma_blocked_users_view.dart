import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaBlockedUsersView extends StatefulWidget {
  const SmaBlockedUsersView({super.key});

  @override
  State<SmaBlockedUsersView> createState() => _SmaBlockedUsersViewState();
}

class _SmaBlockedUsersViewState extends State<SmaBlockedUsersView> {
  String searchQuery = "";
  String selectedFilter = "All";
  
  List<Map<String, dynamic>> blockedUsers = [
    {
      "id": 1,
      "username": "troublemaker_01",
      "fullName": "Mike Johnson",
      "profileImage": "https://picsum.photos/300/300?random=1&keyword=man",
      "blockedDate": "2024-06-10",
      "reason": "Harassment",
      "mutualFriends": 3,
      "lastSeen": "2 days ago",
      "isVerified": false,
      "reportCount": 5,
    },
    {
      "id": 2,
      "username": "spam_account_x",
      "fullName": "Sarah Wilson",
      "profileImage": "https://picsum.photos/300/300?random=2&keyword=woman",
      "blockedDate": "2024-06-08",
      "reason": "Spam",
      "mutualFriends": 0,
      "lastSeen": "1 week ago",
      "isVerified": false,
      "reportCount": 12,
    },
    {
      "id": 3,
      "username": "fake_profile_99",
      "fullName": "Alex Thompson",
      "profileImage": "https://picsum.photos/300/300?random=3&keyword=person",
      "blockedDate": "2024-06-05",
      "reason": "Fake Account",
      "mutualFriends": 1,
      "lastSeen": "3 days ago",
      "isVerified": false,
      "reportCount": 8,
    },
    {
      "id": 4,
      "username": "inappropriate_user",
      "fullName": "David Brown",
      "profileImage": "https://picsum.photos/300/300?random=4&keyword=man",
      "blockedDate": "2024-06-01",
      "reason": "Inappropriate Content",
      "mutualFriends": 2,
      "lastSeen": "5 days ago",
      "isVerified": false,
      "reportCount": 15,
    },
    {
      "id": 5,
      "username": "bot_account_123",
      "fullName": "Emma Davis",
      "profileImage": "https://picsum.photos/300/300?random=5&keyword=woman",
      "blockedDate": "2024-05-28",
      "reason": "Bot Activity",
      "mutualFriends": 0,
      "lastSeen": "1 month ago",
      "isVerified": false,
      "reportCount": 25,
    },
  ];

  List<Map<String, dynamic>> get filteredUsers {
    return blockedUsers.where((user) {
      final matchesSearch = searchQuery.isEmpty ||
          (user["username"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (user["fullName"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesFilter = selectedFilter == "All" ||
          (selectedFilter == "Recent" && _isRecentlyBlocked(user["blockedDate"])) ||
          (selectedFilter == "High Risk" && (user["reportCount"] as int) > 10);
      
      return matchesSearch && matchesFilter;
    }).toList();
  }

  bool _isRecentlyBlocked(String dateStr) {
    final blockedDate = DateTime.parse(dateStr);
    final now = DateTime.now();
    final difference = now.difference(blockedDate).inDays;
    return difference <= 7;
  }

  Color _getReasonColor(String reason) {
    switch (reason.toLowerCase()) {
      case 'harassment':
        return dangerColor;
      case 'spam':
        return warningColor;
      case 'fake account':
        return infoColor;
      case 'inappropriate content':
        return dangerColor;
      case 'bot activity':
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  IconData _getReasonIcon(String reason) {
    switch (reason.toLowerCase()) {
      case 'harassment':
        return Icons.warning;
      case 'spam':
        return Icons.report;
      case 'fake account':
        return Icons.person_off;
      case 'inappropriate content':
        return Icons.block;
      case 'bot activity':
        return Icons.smart_toy;
      default:
        return Icons.block;
    }
  }

  void _unblockUser(Map<String, dynamic> user) async {
    bool isConfirmed = await confirm("Are you sure you want to unblock ${user["fullName"]}?");
    if (isConfirmed) {
      setState(() {
        blockedUsers.removeWhere((u) => u["id"] == user["id"]);
      });
      ss("${user["fullName"]} has been unblocked");
    }
  }

  void _reportUser(Map<String, dynamic> user) async {
    bool isConfirmed = await confirm("Do you want to report ${user["fullName"]} to platform administrators?");
    if (isConfirmed) {
      ss("Report submitted for ${user["fullName"]}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blocked Users"),
        actions: [
          QButton(
            label: "${blockedUsers.length}",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Statistics Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${blockedUsers.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Blocked Users",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${blockedUsers.where((u) => _isRecentlyBlocked(u["blockedDate"])).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Recent Blocks",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${blockedUsers.where((u) => (u["reportCount"] as int) > 10).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "High Risk",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Search and Filter
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: QTextField(
                    label: "Search blocked users...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Filter",
                    items: [
                      {"label": "All", "value": "All"},
                      {"label": "Recent", "value": "Recent"},
                      {"label": "High Risk", "value": "High Risk"},
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

            // Empty State
            if (filteredUsers.isEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.block,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      searchQuery.isEmpty ? "No Blocked Users" : "No Results Found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      searchQuery.isEmpty 
                          ? "You haven't blocked any users yet"
                          : "Try adjusting your search or filter",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Blocked Users List
            ...filteredUsers.map((user) {
              final Color reasonColor = _getReasonColor(user["reason"]);
              final IconData reasonIcon = _getReasonIcon(user["reason"]);
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border.all(
                    color: reasonColor.withAlpha(30),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      // User Header
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage("${user["profileImage"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${user["fullName"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    if (user["isVerified"] as bool) ...[
                                      SizedBox(width: spXs),
                                      Icon(
                                        Icons.verified,
                                        color: primaryColor,
                                        size: 16,
                                      ),
                                    ],
                                  ],
                                ),
                                Text(
                                  "@${user["username"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: reasonColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  reasonIcon,
                                  color: reasonColor,
                                  size: 12,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${user["reason"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: reasonColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // User Details
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Blocked on ${user["blockedDate"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.schedule,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Last seen: ${user["lastSeen"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.people,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${user["mutualFriends"]} mutual friends",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.report,
                                  size: 14,
                                  color: dangerColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${user["reportCount"]} reports",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: dangerColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Unblock",
                              size: bs.sm,
                              onPressed: () => _unblockUser(user),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Report",
                              size: bs.sm,
                              onPressed: () => _reportUser(user),
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.more_vert,
                            size: bs.sm,
                            onPressed: () {
                              // Show more actions
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),

            // Bulk Actions
            if (filteredUsers.isNotEmpty) ...[
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
                  spacing: spSm,
                  children: [
                    Text(
                      "Bulk Actions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Unblock All Recent",
                        size: bs.sm,
                        onPressed: () async {
                          bool isConfirmed = await confirm("Are you sure you want to unblock all recently blocked users?");
                          if (isConfirmed) {
                            setState(() {
                              blockedUsers.removeWhere((u) => _isRecentlyBlocked(u["blockedDate"]));
                            });
                            ss("All recent blocks have been removed");
                          }
                        },
                      ),
                    ),
                    
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Export Block List",
                        size: bs.sm,
                        onPressed: () {
                          ss("Block list export started");
                        },
                      ),
                    ),
                    
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Clear All Blocks",
                        size: bs.sm,
                        onPressed: () async {
                          bool isConfirmed = await confirm("Are you sure you want to unblock ALL users? This action cannot be undone.");
                          if (isConfirmed) {
                            setState(() {
                              blockedUsers.clear();
                            });
                            ss("All users have been unblocked");
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
