import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaRestrictedUsersView extends StatefulWidget {
  const SmaRestrictedUsersView({super.key});

  @override
  State<SmaRestrictedUsersView> createState() => _SmaRestrictedUsersViewState();
}

class _SmaRestrictedUsersViewState extends State<SmaRestrictedUsersView> {
  String searchQuery = "";
  String selectedFilter = "All";
  
  List<Map<String, dynamic>> restrictedUsers = [
    {
      "id": 1,
      "username": "limiteduser_01",
      "fullName": "Jennifer Smith",
      "profileImage": "https://picsum.photos/300/300?random=1&keyword=woman",
      "restrictedDate": "2024-06-12",
      "restrictionType": "Comments Only",
      "reason": "Spam Prevention",
      "mutualFriends": 5,
      "isVerified": false,
      "restrictions": ["Cannot see stories", "Cannot comment on posts", "Cannot send messages"],
      "expiryDate": "2024-07-12",
      "severity": "Medium",
    },
    {
      "id": 2,
      "username": "tempuser_xyz",
      "fullName": "Robert Johnson",
      "profileImage": "https://picsum.photos/300/300?random=2&keyword=man",
      "restrictedDate": "2024-06-10",
      "restrictionType": "Story Viewing",
      "reason": "Privacy Violation",
      "mutualFriends": 2,
      "isVerified": false,
      "restrictions": ["Cannot view stories", "Cannot react to posts"],
      "expiryDate": "2024-06-24",
      "severity": "Low",
    },
    {
      "id": 3,
      "username": "cautionuser_99",
      "fullName": "Lisa Anderson",
      "profileImage": "https://picsum.photos/300/300?random=3&keyword=woman",
      "restrictedDate": "2024-06-08",
      "restrictionType": "Full Restriction",
      "reason": "Multiple Violations",
      "mutualFriends": 1,
      "isVerified": false,
      "restrictions": ["Cannot see posts", "Cannot send messages", "Cannot view profile", "Cannot tag in posts"],
      "expiryDate": "2024-08-08",
      "severity": "High",
    },
    {
      "id": 4,
      "username": "watcheduser_23",
      "fullName": "Michael Davis",
      "profileImage": "https://picsum.photos/300/300?random=4&keyword=man",
      "restrictedDate": "2024-06-05",
      "restrictionType": "Message Limitation",
      "reason": "Inappropriate Content",
      "mutualFriends": 8,
      "isVerified": false,
      "restrictions": ["Cannot send direct messages", "Cannot share posts"],
      "expiryDate": "2024-06-19",
      "severity": "Medium",
    },
    {
      "id": 5,
      "username": "limitedaccess_456",
      "fullName": "Amanda Wilson",
      "profileImage": "https://picsum.photos/300/300?random=5&keyword=woman",
      "restrictedDate": "2024-06-03",
      "restrictionType": "Profile Viewing",
      "reason": "Stalking Behavior",
      "mutualFriends": 0,
      "isVerified": false,
      "restrictions": ["Cannot view profile", "Cannot see last seen", "Cannot access contact info"],
      "expiryDate": "2024-09-03",
      "severity": "High",
    },
  ];

  List<Map<String, dynamic>> get filteredUsers {
    return restrictedUsers.where((user) {
      final matchesSearch = searchQuery.isEmpty ||
          (user["username"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (user["fullName"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesFilter = selectedFilter == "All" ||
          (selectedFilter == "Expiring Soon" && _isExpiringSoon(user["expiryDate"])) ||
          (selectedFilter == "High Severity" && user["severity"] == "High") ||
          (selectedFilter == "Recent" && _isRecentlyRestricted(user["restrictedDate"]));
      
      return matchesSearch && matchesFilter;
    }).toList();
  }

  bool _isExpiringSoon(String dateStr) {
    final expiryDate = DateTime.parse(dateStr);
    final now = DateTime.now();
    final difference = expiryDate.difference(now).inDays;
    return difference <= 7 && difference > 0;
  }

  bool _isRecentlyRestricted(String dateStr) {
    final restrictedDate = DateTime.parse(dateStr);
    final now = DateTime.now();
    final difference = now.difference(restrictedDate).inDays;
    return difference <= 3;
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return infoColor;
      default:
        return primaryColor;
    }
  }

  Color _getRestrictionTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'full restriction':
        return dangerColor;
      case 'comments only':
        return warningColor;
      case 'story viewing':
        return infoColor;
      case 'message limitation':
        return warningColor;
      case 'profile viewing':
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  void _removeRestriction(Map<String, dynamic> user) async {
    bool isConfirmed = await confirm("Are you sure you want to remove restrictions from ${user["fullName"]}?");
    if (isConfirmed) {
      setState(() {
        restrictedUsers.removeWhere((u) => u["id"] == user["id"]);
      });
      ss("Restrictions removed from ${user["fullName"]}");
    }
  }

  void _modifyRestriction(Map<String, dynamic> user) {
    // In a real app, this would open a dialog to modify restrictions
    ss("Modify restrictions for ${user["fullName"]}");
  }

  void _extendRestriction(Map<String, dynamic> user) async {
    bool isConfirmed = await confirm("Do you want to extend restrictions for ${user["fullName"]} by 30 days?");
    if (isConfirmed) {
      final currentExpiry = DateTime.parse(user["expiryDate"]);
      final newExpiry = currentExpiry.add(Duration(days: 30));
      setState(() {
        user["expiryDate"] = newExpiry.toString().split(' ')[0];
      });
      ss("Restriction extended for ${user["fullName"]}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restricted Users"),
        actions: [
          QButton(
            label: "${restrictedUsers.length}",
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
                          "${restrictedUsers.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Total Restricted",
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
                          "${restrictedUsers.where((u) => u["severity"] == "High").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "High Severity",
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
                          "${restrictedUsers.where((u) => _isExpiringSoon(u["expiryDate"])).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Expiring Soon",
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
                    label: "Search restricted users...",
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
                      {"label": "Expiring Soon", "value": "Expiring Soon"},
                      {"label": "High Severity", "value": "High Severity"},
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
                      Icons.remove_circle_outline,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      searchQuery.isEmpty ? "No Restricted Users" : "No Results Found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      searchQuery.isEmpty 
                          ? "You haven't restricted any users yet"
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

            // Restricted Users List
            ...filteredUsers.map((user) {
              final Color severityColor = _getSeverityColor(user["severity"]);
              final Color typeColor = _getRestrictionTypeColor(user["restrictionType"]);
              final bool isExpiring = _isExpiringSoon(user["expiryDate"]);
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border.all(
                    color: severityColor.withAlpha(30),
                    width: user["severity"] == "High" ? 2 : 1,
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: severityColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${user["severity"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              if (isExpiring) ...[
                                SizedBox(height: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: warningColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "EXPIRING",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),

                      // Restriction Details
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: typeColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: typeColor.withAlpha(30),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.gavel,
                                  size: 16,
                                  color: typeColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${user["restrictionType"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: typeColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "Reason: ${user["reason"]}",
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
                                  Icons.schedule,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Since: ${user["restrictedDate"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.event,
                                  size: 14,
                                  color: isExpiring ? warningColor : disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Expires: ${user["expiryDate"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isExpiring ? warningColor : disabledBoldColor,
                                    fontWeight: isExpiring ? FontWeight.w600 : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Restrictions List
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Active Restrictions:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            ...(user["restrictions"] as List<String>).map((restriction) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.remove,
                                      size: 12,
                                      color: dangerColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      restriction,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      ),

                      // Mutual Friends
                      if ((user["mutualFriends"] as int) > 0) ...[
                        Row(
                          children: [
                            Icon(
                              Icons.people,
                              size: 16,
                              color: primaryColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${user["mutualFriends"]} mutual friends",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Remove",
                              size: bs.sm,
                              onPressed: () => _removeRestriction(user),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Modify",
                              size: bs.sm,
                              onPressed: () => _modifyRestriction(user),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Extend",
                              size: bs.sm,
                              onPressed: () => _extendRestriction(user),
                            ),
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
                        label: "Remove Expiring Restrictions",
                        size: bs.sm,
                        onPressed: () async {
                          final expiringUsers = restrictedUsers.where((u) => _isExpiringSoon(u["expiryDate"])).toList();
                          if (expiringUsers.isNotEmpty) {
                            bool isConfirmed = await confirm("Remove restrictions from ${expiringUsers.length} users expiring soon?");
                            if (isConfirmed) {
                              setState(() {
                                restrictedUsers.removeWhere((u) => _isExpiringSoon(u["expiryDate"]));
                              });
                              ss("Removed ${expiringUsers.length} expiring restrictions");
                            }
                          } else {
                            si("No restrictions are expiring soon");
                          }
                        },
                      ),
                    ),
                    
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Export Restrictions List",
                        size: bs.sm,
                        onPressed: () {
                          ss("Restrictions list export started");
                        },
                      ),
                    ),
                    
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Clear All Restrictions",
                        size: bs.sm,
                        onPressed: () async {
                          bool isConfirmed = await confirm("Are you sure you want to remove ALL restrictions? This action cannot be undone.");
                          if (isConfirmed) {
                            setState(() {
                              restrictedUsers.clear();
                            });
                            ss("All restrictions have been removed");
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
