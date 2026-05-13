import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaFriendRequestsView extends StatefulWidget {
  const SmaFriendRequestsView({super.key});

  @override
  State<SmaFriendRequestsView> createState() => _SmaFriendRequestsViewState();
}

class _SmaFriendRequestsViewState extends State<SmaFriendRequestsView> {
  String selectedTab = "Received";
  
  List<Map<String, dynamic>> tabOptions = [
    {"label": "Received", "value": "Received"},
    {"label": "Sent", "value": "Sent"},
    {"label": "Suggestions", "value": "Suggestions"},
  ];

  List<Map<String, dynamic>> receivedRequests = [
    {
      "id": 1,
      "username": "@sarah_photography",
      "name": "Sarah Miller",
      "avatar": "https://picsum.photos/80/80?random=1001",
      "mutualFriends": 12,
      "bio": "Professional photographer 📸 Capturing life's moments",
      "followers": 45600,
      "requestDate": "2024-06-15",
      "isVerified": true,
    },
    {
      "id": 2,
      "username": "@tech_explorer",
      "name": "Alex Chen",
      "avatar": "https://picsum.photos/80/80?random=1002",
      "mutualFriends": 8,
      "bio": "Software developer & tech enthusiast 💻",
      "followers": 23400,
      "requestDate": "2024-06-14",
      "isVerified": false,
    },
    {
      "id": 3,
      "username": "@fitness_coach_emma",
      "name": "Emma Wilson",
      "avatar": "https://picsum.photos/80/80?random=1003",
      "mutualFriends": 25,
      "bio": "Personal trainer helping you reach your goals 💪",
      "followers": 67890,
      "requestDate": "2024-06-13",
      "isVerified": true,
    },
    {
      "id": 4,
      "username": "@travel_memories",
      "name": "David Rodriguez",
      "avatar": "https://picsum.photos/80/80?random=1004",
      "mutualFriends": 5,
      "bio": "World traveler sharing amazing destinations ✈️",
      "followers": 34500,
      "requestDate": "2024-06-12",
      "isVerified": false,
    },
  ];

  List<Map<String, dynamic>> sentRequests = [
    {
      "id": 5,
      "username": "@art_studio_NYC",
      "name": "NYC Art Studio",
      "avatar": "https://picsum.photos/80/80?random=1005",
      "mutualFriends": 15,
      "bio": "Contemporary art gallery in New York 🎨",
      "followers": 89012,
      "requestDate": "2024-06-11",
      "isVerified": true,
    },
    {
      "id": 6,
      "username": "@music_producer",
      "name": "Mike Johnson",
      "avatar": "https://picsum.photos/80/80?random=1006",
      "mutualFriends": 3,
      "bio": "Electronic music producer & DJ 🎵",
      "followers": 12300,
      "requestDate": "2024-06-10",
      "isVerified": false,
    },
  ];

  List<Map<String, dynamic>> suggestions = [
    {
      "id": 7,
      "username": "@cooking_secrets",
      "name": "Chef Maria",
      "avatar": "https://picsum.photos/80/80?random=1007",
      "mutualFriends": 18,
      "bio": "Professional chef sharing secret recipes 👩‍🍳",
      "followers": 156000,
      "reason": "18 mutual friends",
      "isVerified": true,
    },
    {
      "id": 8,
      "username": "@outdoor_adventures",
      "name": "Adventure Guide",
      "avatar": "https://picsum.photos/80/80?random=1008",
      "mutualFriends": 22,
      "bio": "Outdoor adventure guide & nature lover 🏔️",
      "followers": 78900,
      "reason": "Similar interests",
      "isVerified": false,
    },
    {
      "id": 9,
      "username": "@book_reviews",
      "name": "Literary Corner",
      "avatar": "https://picsum.photos/80/80?random=1009",
      "mutualFriends": 9,
      "bio": "Book reviews and literary discussions 📚",
      "followers": 45600,
      "reason": "Followed by friends",
      "isVerified": true,
    },
  ];

  void acceptRequest(int requestId) {
    receivedRequests.removeWhere((request) => request["id"] == requestId);
    setState(() {});
    ss("Friend request accepted");
  }

  void declineRequest(int requestId) {
    receivedRequests.removeWhere((request) => request["id"] == requestId);
    setState(() {});
    si("Friend request declined");
  }

  void cancelSentRequest(int requestId) async {
    bool isConfirmed = await confirm("Cancel this friend request?");
    if (isConfirmed) {
      sentRequests.removeWhere((request) => request["id"] == requestId);
      setState(() {});
      si("Friend request cancelled");
    }
  }

  void sendFriendRequest(int userId) {
    // Add to sent requests
    final suggestion = suggestions.firstWhere((s) => s["id"] == userId);
    sentRequests.add({
      ...suggestion,
      "requestDate": DateTime.now().toString().substring(0, 10),
    });
    
    // Remove from suggestions
    suggestions.removeWhere((s) => s["id"] == userId);
    setState(() {});
    ss("Friend request sent to ${suggestion["name"]}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Friend Requests"),
        actions: [
          IconButton(
            icon: Icon(Icons.person_search),
            onPressed: () {
              //navigateTo('PeopleSearchView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tab Navigation
            QCategoryPicker(
              label: "Request Types",
              items: tabOptions,
              value: selectedTab,
              onChanged: (index, label, value, item) {
                selectedTab = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Content based on selected tab
            if (selectedTab == "Received") ...[
              // Received Requests
              Row(
                children: [
                  Text(
                    "Friend Requests",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${receivedRequests.length} requests",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: spSm),
              
              if (receivedRequests.isEmpty) ...[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spLg),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.person_add_disabled,
                        size: 48,
                        color: disabledBoldColor,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "No friend requests",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "When people send you friend requests, they'll appear here",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ] else ...[
                Column(
                  children: receivedRequests.map((request) {
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // Avatar
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage("${request["avatar"]}"),
                              ),
                              
                              SizedBox(width: spSm),
                              
                              // Request Info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${request["name"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        if (request["isVerified"]) ...[
                                          SizedBox(width: spXs),
                                          Icon(
                                            Icons.verified,
                                            size: 16,
                                            color: primaryColor,
                                          ),
                                        ],
                                      ],
                                    ),
                                    
                                    Text(
                                      "${request["username"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    
                                    SizedBox(height: spXs),
                                    
                                    Text(
                                      "${request["bio"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black87,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    
                                    SizedBox(height: spXs),
                                    
                                    Text(
                                      "${request["mutualFriends"]} mutual friends",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Request Info
                          Row(
                            children: [
                              Text(
                                "Request sent ${DateTime.parse(request["requestDate"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${((request["followers"] as int) / 1000).toStringAsFixed(1)}K followers",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Accept",
                                  size: bs.sm,
                                  onPressed: () => acceptRequest(request["id"]),
                                ),
                              ),
                              
                              SizedBox(width: spSm),
                              
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  child: GestureDetector(
                                    onTap: () => declineRequest(request["id"]),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 12),
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(radiusSm),
                                        border: Border.all(
                                          color: disabledBoldColor,
                                          width: 1,
                                        ),
                                      ),
                                      child: Text(
                                        "Decline",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ]
            
            else if (selectedTab == "Sent") ...[
              // Sent Requests
              Row(
                children: [
                  Text(
                    "Sent Requests",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${sentRequests.length} sent",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: spSm),
              
              if (sentRequests.isEmpty) ...[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spLg),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.send,
                        size: 48,
                        color: disabledBoldColor,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "No sent requests",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Friend requests you send will appear here",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                Column(
                  children: sentRequests.map((request) {
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Row(
                        children: [
                          // Avatar
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage("${request["avatar"]}"),
                          ),
                          
                          SizedBox(width: spSm),
                          
                          // Request Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${request["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    if (request["isVerified"]) ...[
                                      SizedBox(width: spXs),
                                      Icon(
                                        Icons.verified,
                                        size: 16,
                                        color: primaryColor,
                                      ),
                                    ],
                                  ],
                                ),
                                
                                Text(
                                  "${request["username"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                
                                SizedBox(height: spXs),
                                
                                Text(
                                  "Sent ${DateTime.parse(request["requestDate"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Cancel Button
                          GestureDetector(
                            onTap: () => cancelSentRequest(request["id"]),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: disabledBoldColor,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ]
            
            else if (selectedTab == "Suggestions") ...[
              // People You May Know
              Row(
                children: [
                  Text(
                    "People You May Know",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${suggestions.length} suggestions",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: spSm),
              
              Column(
                children: suggestions.map((suggestion) {
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            // Avatar
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage("${suggestion["avatar"]}"),
                            ),
                            
                            SizedBox(width: spSm),
                            
                            // Suggestion Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${suggestion["name"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      if (suggestion["isVerified"]) ...[
                                        SizedBox(width: spXs),
                                        Icon(
                                          Icons.verified,
                                          size: 16,
                                          color: primaryColor,
                                        ),
                                      ],
                                    ],
                                  ),
                                  
                                  Text(
                                    "${suggestion["username"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  
                                  SizedBox(height: spXs),
                                  
                                  Text(
                                    "${suggestion["bio"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black87,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            
                            // Add Friend Button
                            QButton(
                              label: "Add Friend",
                              size: bs.sm,
                              onPressed: () => sendFriendRequest(suggestion["id"]),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Suggestion Reason
                        Row(
                          children: [
                            Icon(
                              Icons.people,
                              size: 16,
                              color: primaryColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${suggestion["reason"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${((suggestion["followers"] as int) / 1000).toStringAsFixed(1)}K followers",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
