import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaCloseFriendsView extends StatefulWidget {
  const SmaCloseFriendsView({super.key});

  @override
  State<SmaCloseFriendsView> createState() => _SmaCloseFriendsViewState();
}

class _SmaCloseFriendsViewState extends State<SmaCloseFriendsView> {
  String searchQuery = "";
  bool isEditMode = false;
  
  List<Map<String, dynamic>> closeFriends = [
    {
      "id": 1,
      "username": "emma_jones",
      "fullName": "Emma Jones",
      "profileImage": "https://picsum.photos/300/300?random=1&keyword=woman",
      "addedDate": "2024-05-15",
      "mutualFriends": 12,
      "isOnline": true,
      "lastSeen": "Active now",
      "isVerified": true,
      "relationship": "Best Friend",
      "interactionScore": 95,
      "storiesViewed": 45,
      "postsLiked": 89,
    },
    {
      "id": 2,
      "username": "mike_chen",
      "fullName": "Mike Chen",
      "profileImage": "https://picsum.photos/300/300?random=2&keyword=man",
      "addedDate": "2024-04-22",
      "mutualFriends": 8,
      "isOnline": false,
      "lastSeen": "2 hours ago",
      "isVerified": false,
      "relationship": "College Friend",
      "interactionScore": 87,
      "storiesViewed": 32,
      "postsLiked": 76,
    },
    {
      "id": 3,
      "username": "sarah_wilson",
      "fullName": "Sarah Wilson",
      "profileImage": "https://picsum.photos/300/300?random=3&keyword=woman",
      "addedDate": "2024-06-01",
      "mutualFriends": 15,
      "isOnline": true,
      "lastSeen": "Active now",
      "isVerified": true,
      "relationship": "Work Colleague",
      "interactionScore": 92,
      "storiesViewed": 38,
      "postsLiked": 82,
    },
    {
      "id": 4,
      "username": "alex_rodriguez",
      "fullName": "Alex Rodriguez",
      "profileImage": "https://picsum.photos/300/300?random=4&keyword=man",
      "addedDate": "2024-03-10",
      "mutualFriends": 6,
      "isOnline": false,
      "lastSeen": "1 day ago",
      "isVerified": false,
      "relationship": "Family Friend",
      "interactionScore": 78,
      "storiesViewed": 25,
      "postsLiked": 58,
    },
    {
      "id": 5,
      "username": "jenny_kim",
      "fullName": "Jenny Kim",
      "profileImage": "https://picsum.photos/300/300?random=5&keyword=woman",
      "addedDate": "2024-05-28",
      "mutualFriends": 9,
      "isOnline": true,
      "lastSeen": "Active now",
      "isVerified": true,
      "relationship": "Childhood Friend",
      "interactionScore": 98,
      "storiesViewed": 52,
      "postsLiked": 95,
    },
  ];

  List<Map<String, dynamic>> suggestedFriends = [
    {
      "id": 101,
      "username": "tom_parker",
      "fullName": "Tom Parker",
      "profileImage": "https://picsum.photos/300/300?random=6&keyword=man",
      "mutualFriends": 18,
      "isVerified": false,
      "relationship": "Mutual Friend",
      "interactionScore": 65,
      "reason": "Frequently likes your posts",
    },
    {
      "id": 102,
      "username": "lisa_brown",
      "fullName": "Lisa Brown",
      "profileImage": "https://picsum.photos/300/300?random=7&keyword=woman",
      "mutualFriends": 7,
      "isVerified": true,
      "relationship": "Suggested",
      "interactionScore": 72,
      "reason": "Views your stories often",
    },
    {
      "id": 103,
      "username": "david_lee",
      "fullName": "David Lee",
      "profileImage": "https://picsum.photos/300/300?random=8&keyword=man",
      "mutualFriends": 4,
      "isVerified": false,
      "relationship": "Suggested",
      "interactionScore": 58,
      "reason": "Comments on your posts regularly",
    },
  ];

  List<int> selectedFriends = [];

  List<Map<String, dynamic>> get filteredCloseFriends {
    return closeFriends.where((friend) {
      final matchesSearch = searchQuery.isEmpty ||
          (friend["username"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (friend["fullName"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return matchesSearch;
    }).toList();
  }

  void _toggleFriendSelection(int friendId) {
    setState(() {
      if (selectedFriends.contains(friendId)) {
        selectedFriends.remove(friendId);
      } else {
        selectedFriends.add(friendId);
      }
    });
  }

  void _removeFromCloseFriends(Map<String, dynamic> friend) async {
    bool isConfirmed = await confirm("Remove ${friend["fullName"]} from close friends?");
    if (isConfirmed) {
      setState(() {
        closeFriends.removeWhere((f) => f["id"] == friend["id"]);
      });
      ss("${friend["fullName"]} removed from close friends");
    }
  }

  void _addToCloseFriends(Map<String, dynamic> friend) {
    setState(() {
      closeFriends.add({
        ...friend,
        "addedDate": DateTime.now().toString().split(' ')[0],
        "isOnline": false,
        "lastSeen": "Just added",
        "storiesViewed": 0,
        "postsLiked": 0,
      });
      suggestedFriends.removeWhere((f) => f["id"] == friend["id"]);
    });
    ss("${friend["fullName"]} added to close friends");
  }

  void _removeSelectedFriends() async {
    if (selectedFriends.isEmpty) return;
    
    bool isConfirmed = await confirm("Remove ${selectedFriends.length} friends from close friends?");
    if (isConfirmed) {
      setState(() {
        closeFriends.removeWhere((f) => selectedFriends.contains(f["id"]));
        selectedFriends.clear();
        isEditMode = false;
      });
      ss("Selected friends removed from close friends");
    }
  }

  Color _getInteractionColor(int score) {
    if (score >= 90) return successColor;
    if (score >= 70) return primaryColor;
    if (score >= 50) return warningColor;
    return disabledBoldColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Close Friends"),
        actions: [
          if (isEditMode) ...[
            QButton(
              label: "Cancel",
              size: bs.sm,
              onPressed: () {
                setState(() {
                  isEditMode = false;
                  selectedFriends.clear();
                });
              },
            ),
          ] else ...[
            QButton(
              label: "Edit",
              size: bs.sm,
              onPressed: () {
                setState(() {
                  isEditMode = true;
                });
              },
            ),
          ],
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Stats Overview
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Close Friends",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(150),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${closeFriends.length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Total Friends",
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
                            color: Colors.white.withAlpha(150),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${closeFriends.where((f) => f["isOnline"] as bool).length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Online Now",
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
                            color: Colors.white.withAlpha(150),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${((closeFriends.map((f) => f["interactionScore"] as int).fold(0, (a, b) => a + b)) / closeFriends.length).round()}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "Avg Interaction",
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
                ],
              ),
            ),

            // Search Bar
            if (!isEditMode) ...[
              QTextField(
                label: "Search close friends...",
                value: searchQuery,
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
            ],

            // Bulk Actions (Edit Mode)
            if (isEditMode && selectedFriends.isNotEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: warningColor.withAlpha(50)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${selectedFriends.length} friends selected",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                    ),
                    QButton(
                      label: "Remove Selected",
                      size: bs.sm,
                      onPressed: _removeSelectedFriends,
                    ),
                  ],
                ),
              ),
            ],

            // Close Friends List
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
                    "Your Close Friends",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  if (filteredCloseFriends.isEmpty) ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        children: [
                          Icon(
                            Icons.people,
                            size: 48,
                            color: disabledBoldColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            searchQuery.isEmpty ? "No Close Friends Yet" : "No Results Found",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            searchQuery.isEmpty 
                                ? "Add some friends to your close friends list"
                                : "Try adjusting your search",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    ...filteredCloseFriends.map((friend) {
                      final bool isSelected = selectedFriends.contains(friend["id"]);
                      final Color interactionColor = _getInteractionColor(friend["interactionScore"]);
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor.withAlpha(10) : Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: isSelected ? Border.all(color: primaryColor.withAlpha(50)) : null,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(radiusSm),
                            onTap: isEditMode 
                                ? () => _toggleFriendSelection(friend["id"])
                                : null,
                            child: Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Row(
                                children: [
                                  if (isEditMode) ...[
                                    Checkbox(
                                      value: isSelected,
                                      onChanged: (value) => _toggleFriendSelection(friend["id"]),
                                      activeColor: primaryColor,
                                    ),
                                    SizedBox(width: spSm),
                                  ],
                                  
                                  Stack(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: NetworkImage("${friend["profileImage"]}"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      if (friend["isOnline"] as bool)
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            width: 16,
                                            height: 16,
                                            decoration: BoxDecoration(
                                              color: successColor,
                                              shape: BoxShape.circle,
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
                                              "${friend["fullName"]}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                            if (friend["isVerified"] as bool) ...[
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
                                          "@${friend["username"]} • ${friend["relationship"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              size: 8,
                                              color: interactionColor,
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "Interaction: ${friend["interactionScore"]}%",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: interactionColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(width: spSm),
                                            Text(
                                              "${friend["lastSeen"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                  if (!isEditMode) ...[
                                    Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: primaryColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${friend["mutualFriends"]} mutual",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: primaryColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: spXs),
                                        QButton(
                                          icon: Icons.more_vert,
                                          size: bs.sm,
                                          onPressed: () => _removeFromCloseFriends(friend),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ],
              ),
            ),

            // Suggested Friends
            if (!isEditMode && suggestedFriends.isNotEmpty) ...[
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
                    Row(
                      children: [
                        Icon(
                          Icons.recommend,
                          color: infoColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Suggested for Close Friends",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    ...suggestedFriends.map((friend) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: infoColor.withAlpha(30)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage("${friend["profileImage"]}"),
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
                                        "${friend["fullName"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      if (friend["isVerified"] as bool) ...[
                                        SizedBox(width: spXs),
                                        Icon(
                                          Icons.verified,
                                          color: primaryColor,
                                          size: 14,
                                        ),
                                      ],
                                    ],
                                  ),
                                  Text(
                                    "${friend["mutualFriends"]} mutual friends",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${friend["reason"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: infoColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            QButton(
                              label: "Add",
                              size: bs.sm,
                              onPressed: () => _addToCloseFriends(friend),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],

            // Close Friends Benefits
            if (!isEditMode) ...[
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
                      "Close Friends Benefits",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    _buildBenefitItem(
                      Icons.visibility,
                      "Priority Stories",
                      "Their stories appear first in your feed",
                      successColor,
                    ),
                    
                    _buildBenefitItem(
                      Icons.notifications_active,
                      "Special Notifications",
                      "Get notified when they post new content",
                      infoColor,
                    ),
                    
                    _buildBenefitItem(
                      Icons.favorite,
                      "Exclusive Content",
                      "See content shared only with close friends",
                      dangerColor,
                    ),
                    
                    _buildBenefitItem(
                      Icons.message,
                      "Direct Access",
                      "Quick access to start conversations",
                      warningColor,
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

  Widget _buildBenefitItem(IconData icon, String title, String description, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 18,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  description,
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
}
