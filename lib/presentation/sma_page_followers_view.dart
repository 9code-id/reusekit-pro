import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaPageFollowersView extends StatefulWidget {
  const SmaPageFollowersView({super.key});

  @override
  State<SmaPageFollowersView> createState() => _SmaPageFollowersViewState();
}

class _SmaPageFollowersViewState extends State<SmaPageFollowersView> {
  String searchQuery = "";
  String selectedFilter = "All";
  List<String> filterOptions = ["All", "Recent", "Mutual Friends", "Verified"];
  
  List<Map<String, dynamic>> followers = [
    {
      "id": 1,
      "name": "Sarah Johnson",
      "username": "sarah_j",
      "image": "https://picsum.photos/60/60?random=1&keyword=woman",
      "isFollowing": true,
      "isVerified": true,
      "mutualFriends": 15,
      "followedDate": "2024-06-15",
      "isOnline": true,
      "lastSeen": "Active now"
    },
    {
      "id": 2,
      "name": "Mike Chen",
      "username": "mikechen_dev",
      "image": "https://picsum.photos/60/60?random=2&keyword=man",
      "isFollowing": false,
      "isVerified": false,
      "mutualFriends": 8,
      "followedDate": "2024-06-14",
      "isOnline": false,
      "lastSeen": "2 hours ago"
    },
    {
      "id": 3,
      "name": "Emma Davis",
      "username": "emma_designer",
      "image": "https://picsum.photos/60/60?random=3&keyword=girl",
      "isFollowing": true,
      "isVerified": true,
      "mutualFriends": 23,
      "followedDate": "2024-06-13",
      "isOnline": true,
      "lastSeen": "Active now"
    },
    {
      "id": 4,
      "name": "David Wilson",
      "username": "david_w",
      "image": "https://picsum.photos/60/60?random=4&keyword=person",
      "isFollowing": false,
      "isVerified": false,
      "mutualFriends": 3,
      "followedDate": "2024-06-12",
      "isOnline": false,
      "lastSeen": "1 day ago"
    },
    {
      "id": 5,
      "name": "Lisa Park",
      "username": "lisa_park_photo",
      "image": "https://picsum.photos/60/60?random=5&keyword=woman",
      "isFollowing": true,
      "isVerified": true,
      "mutualFriends": 12,
      "followedDate": "2024-06-11",
      "isOnline": false,
      "lastSeen": "3 hours ago"
    },
    {
      "id": 6,
      "name": "Alex Rodriguez",
      "username": "alex_sports",
      "image": "https://picsum.photos/60/60?random=6&keyword=athlete",
      "isFollowing": false,
      "isVerified": false,
      "mutualFriends": 7,
      "followedDate": "2024-06-10",
      "isOnline": true,
      "lastSeen": "Active now"
    },
    {
      "id": 7,
      "name": "Rachel Green",
      "username": "rachel_fitness",
      "image": "https://picsum.photos/60/60?random=7&keyword=fitness",
      "isFollowing": true,
      "isVerified": false,
      "mutualFriends": 19,
      "followedDate": "2024-06-09",
      "isOnline": false,
      "lastSeen": "5 hours ago"
    },
    {
      "id": 8,
      "name": "Tom Anderson",
      "username": "tom_music",
      "image": "https://picsum.photos/60/60?random=8&keyword=musician",
      "isFollowing": false,
      "isVerified": true,
      "mutualFriends": 31,
      "followedDate": "2024-06-08",
      "isOnline": false,
      "lastSeen": "1 day ago"
    }
  ];

  List<Map<String, dynamic>> get filteredFollowers {
    var filtered = followers.where((follower) {
      final matchesSearch = (follower["name"] as String)
          .toLowerCase()
          .contains(searchQuery.toLowerCase()) ||
          (follower["username"] as String)
              .toLowerCase()
              .contains(searchQuery.toLowerCase());
      
      bool matchesFilter = true;
      switch (selectedFilter) {
        case "Recent":
          matchesFilter = DateTime.parse(follower["followedDate"] as String)
              .isAfter(DateTime.now().subtract(Duration(days: 7)));
          break;
        case "Mutual Friends":
          matchesFilter = (follower["mutualFriends"] as int) > 10;
          break;
        case "Verified":
          matchesFilter = follower["isVerified"] as bool;
          break;
      }
      
      return matchesSearch && matchesFilter;
    }).toList();
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page Followers"),
        actions: [
          IconButton(
            onPressed: () {
              si("Export followers list");
            },
            icon: Icon(Icons.download),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Stats Card
            Card(
              child: Container(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${followers.length}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Total Followers",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: disabledColor,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${followers.where((f) => f["isOnline"] as bool).length}",
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
                    Container(
                      width: 1,
                      height: 40,
                      color: disabledColor,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${followers.where((f) => f["isVerified"] as bool).length}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
                            ),
                          ),
                          Text(
                            "Verified",
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
              ),
            ),

            // Search and Filter Section
            Card(
              child: Container(
                padding: EdgeInsets.all(spSm),
                child: Column(
                  spacing: spSm,
                  children: [
                    QTextField(
                      label: "Search Followers",
                      value: searchQuery,
                      hint: "Search by name or username...",
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Filter",
                      value: selectedFilter,
                      items: filterOptions.map((filter) => {
                        "label": filter,
                        "value": filter,
                      }).toList(),
                      onChanged: (value, label) {
                        selectedFilter = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Results Count
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: spXs),
              child: Text(
                "${filteredFollowers.length} followers found",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Followers List
            ...filteredFollowers.map((follower) {
              return Card(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  child: Row(
                    children: [
                      // Profile Image with Online Status
                      Stack(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusSm),
                              image: DecorationImage(
                                image: NetworkImage("${follower["image"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          if (follower["isOnline"] as bool) ...[
                            Positioned(
                              bottom: 2,
                              right: 2,
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: successColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(width: spSm),
                      
                      // User Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${follower["name"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (follower["isVerified"] as bool) ...[
                                  SizedBox(width: spXs),
                                  Icon(
                                    Icons.verified,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                ],
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "@${follower["username"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.group,
                                  size: 12,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${follower["mutualFriends"]} mutual friends",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(" • ", style: TextStyle(fontSize: 10, color: disabledBoldColor)),
                                Text(
                                  "${follower["lastSeen"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: (follower["isOnline"] as bool) ? successColor : disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      // Action Buttons
                      Column(
                        spacing: spXs,
                        children: [
                          QButton(
                            label: (follower["isFollowing"] as bool) ? "Following" : "Follow",
                            size: bs.sm,
                            onPressed: () {
                              follower["isFollowing"] = !(follower["isFollowing"] as bool);
                              if (follower["isFollowing"] as bool) {
                                ss("Following ${follower["name"]}");
                              } else {
                                si("Unfollowed ${follower["name"]}");
                              }
                              setState(() {});
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              //navigateTo(SmaChatView(userId: follower["id"]))
                            },
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              child: Icon(
                                Icons.message,
                                color: primaryColor,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),

            // Load More Button
            if (filteredFollowers.length >= 8) ...[
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Load More Followers",
                  size: bs.md,
                  onPressed: () {
                    si("Loading more followers...");
                  },
                ),
              ),
            ],

            // Empty State
            if (filteredFollowers.isEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXl),
                child: Column(
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No followers found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search or filter criteria",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
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
