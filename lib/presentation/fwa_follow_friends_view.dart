import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaFollowFriendsView extends StatefulWidget {
  const FwaFollowFriendsView({super.key});

  @override
  State<FwaFollowFriendsView> createState() => _FwaFollowFriendsViewState();
}

class _FwaFollowFriendsViewState extends State<FwaFollowFriendsView> {
  String searchQuery = "";
  String selectedFilter = "All";

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Following", "value": "Following"},
    {"label": "Followers", "value": "Followers"},
    {"label": "Mutual Friends", "value": "Mutual Friends"},
    {"label": "Suggested", "value": "Suggested"},
  ];

  List<Map<String, dynamic>> people = [
    {
      "id": 1,
      "username": "sarah_fitness",
      "fullName": "Sarah Johnson",
      "avatar": "https://picsum.photos/60/60?random=1&keyword=person",
      "isVerified": true,
      "isFollowing": false,
      "isFollowingMe": false,
      "mutualFriends": 5,
      "followers": 12500,
      "following": 450,
      "posts": 234,
      "bio": "Fitness coach & nutritionist 💪 Helping you reach your goals ✨",
      "location": "Los Angeles, CA",
      "categories": ["Fitness", "Nutrition"],
      "isOnline": true,
      "lastActive": "Active now",
      "workoutStreak": 45,
      "badges": ["Top Trainer", "Nutrition Expert"]
    },
    {
      "id": 2,
      "username": "mike_strong",
      "fullName": "Mike Chen",
      "avatar": "https://picsum.photos/60/60?random=2&keyword=person",
      "isVerified": false,
      "isFollowing": true,
      "isFollowingMe": true,
      "mutualFriends": 12,
      "followers": 8900,
      "following": 320,
      "posts": 189,
      "bio": "Powerlifter | Personal Trainer | Motivating others to be strong 🏋️‍♂️",
      "location": "New York, NY",
      "categories": ["Strength Training", "Powerlifting"],
      "isOnline": false,
      "lastActive": "2 hours ago",
      "workoutStreak": 23,
      "badges": ["Strength Champion"]
    },
    {
      "id": 3,
      "username": "yoga_anna",
      "fullName": "Anna Williams",
      "avatar": "https://picsum.photos/60/60?random=3&keyword=person",
      "isVerified": true,
      "isFollowing": false,
      "isFollowingMe": true,
      "mutualFriends": 8,
      "followers": 15600,
      "following": 280,
      "posts": 567,
      "bio": "Yoga instructor & mindfulness coach 🧘‍♀️ Find your inner peace",
      "location": "San Francisco, CA",
      "categories": ["Yoga", "Mindfulness"],
      "isOnline": true,
      "lastActive": "Active now",
      "workoutStreak": 67,
      "badges": ["Yoga Master", "Mindfulness Guide"]
    },
    {
      "id": 4,
      "username": "runner_john",
      "fullName": "John Martinez",
      "avatar": "https://picsum.photos/60/60?random=4&keyword=person",
      "isVerified": false,
      "isFollowing": true,
      "isFollowingMe": false,
      "mutualFriends": 3,
      "followers": 4200,
      "following": 890,
      "posts": 145,
      "bio": "Marathon runner 🏃‍♂️ Run coach | Spreading the love for running",
      "location": "Chicago, IL",
      "categories": ["Running", "Cardio"],
      "isOnline": false,
      "lastActive": "1 day ago",
      "workoutStreak": 34,
      "badges": ["Marathon Finisher"]
    },
    {
      "id": 5,
      "username": "nutrition_emily",
      "fullName": "Emily Davis",
      "avatar": "https://picsum.photos/60/60?random=5&keyword=person",
      "isVerified": true,
      "isFollowing": false,
      "isFollowingMe": false,
      "mutualFriends": 0,
      "followers": 23400,
      "following": 150,
      "posts": 423,
      "bio": "Registered Dietitian 🥗 Helping you fuel your body right 🌱",
      "location": "Miami, FL",
      "categories": ["Nutrition", "Meal Prep"],
      "isOnline": false,
      "lastActive": "5 hours ago",
      "workoutStreak": 12,
      "badges": ["Nutrition Expert", "Certified Dietitian"]
    },
    {
      "id": 6,
      "username": "crossfit_alex",
      "fullName": "Alex Rodriguez",
      "avatar": "https://picsum.photos/60/60?random=6&keyword=person",
      "isVerified": false,
      "isFollowing": false,
      "isFollowingMe": false,
      "mutualFriends": 7,
      "followers": 6700,
      "following": 540,
      "posts": 198,
      "bio": "CrossFit athlete & coach 🔥 HIIT workouts | Functional fitness",
      "location": "Austin, TX",
      "categories": ["CrossFit", "HIIT"],
      "isOnline": true,
      "lastActive": "Active now",
      "workoutStreak": 28,
      "badges": ["CrossFit Coach"]
    },
  ];

  List<Map<String, dynamic>> get filteredPeople {
    return people.where((person) {
      bool matchesSearch = person["username"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          person["fullName"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesFilter = selectedFilter == "All" ||
                          (selectedFilter == "Following" && person["isFollowing"] as bool) ||
                          (selectedFilter == "Followers" && person["isFollowingMe"] as bool) ||
                          (selectedFilter == "Mutual Friends" && (person["mutualFriends"] as int) > 0) ||
                          (selectedFilter == "Suggested" && !(person["isFollowing"] as bool) && !(person["isFollowingMe"] as bool));
      
      return matchesSearch && matchesFilter;
    }).toList();
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return "${(number / 1000000).toStringAsFixed(1)}M";
    } else if (number >= 1000) {
      return "${(number / 1000).toStringAsFixed(1)}K";
    }
    return number.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Follow Friends"),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              // Invite friends
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            QTextField(
              label: "Search people...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            SizedBox(height: spMd),

            // Filter Options
            QHorizontalScroll(
              children: filterOptions.map((filter) {
                bool isSelected = filter["value"] == selectedFilter;
                return GestureDetector(
                  onTap: () {
                    selectedFilter = filter["value"];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                      boxShadow: [shadowSm],
                    ),
                    child: Text(
                      "${filter["label"]}",
                      style: TextStyle(
                        color: isSelected ? Colors.white : disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spMd),

            // Results Count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedFilter == "All" ? "All People" : selectedFilter,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${filteredPeople.length} ${filteredPeople.length == 1 ? 'person' : 'people'}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            SizedBox(height: spSm),

            // People List
            ...filteredPeople.map((person) {
              String relationshipStatus = "";
              if (person["isFollowing"] as bool && person["isFollowingMe"] as bool) {
                relationshipStatus = "Mutual friends";
              } else if (person["isFollowing"] as bool) {
                relationshipStatus = "Following";
              } else if (person["isFollowingMe"] as bool) {
                relationshipStatus = "Follows you";
              } else if ((person["mutualFriends"] as int) > 0) {
                relationshipStatus = "${person["mutualFriends"]} mutual friends";
              }

              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Avatar with online status
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage("${person["avatar"]}"),
                            ),
                            if (person["isOnline"] as bool)
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
                        ),
                        
                        SizedBox(width: spSm),
                        
                        // User Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${person["fullName"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  if (person["isVerified"] as bool)
                                    Icon(
                                      Icons.verified,
                                      color: primaryColor,
                                      size: 16,
                                    ),
                                ],
                              ),
                              
                              Text(
                                "@${person["username"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
                              ),
                              
                              if (relationshipStatus.isNotEmpty) ...[
                                SizedBox(height: spXs),
                                Text(
                                  relationshipStatus,
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                              
                              SizedBox(height: spXs),
                              
                              Text(
                                "${person["bio"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 13,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(width: spSm),
                        
                        // Follow Button
                        QButton(
                          label: person["isFollowing"] as bool ? "Following" : "Follow",
                          size: bs.sm,
                          onPressed: () {
                            // Toggle follow status
                            setState(() {
                              if (person["isFollowing"] as bool) {
                                person["isFollowing"] = false;
                                person["followers"] = (person["followers"] as int) - 1;
                              } else {
                                person["isFollowing"] = true;
                                person["followers"] = (person["followers"] as int) + 1;
                              }
                            });
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: spSm),

                    // Stats Row
                    Row(
                      children: [
                        // Stats
                        Expanded(
                          child: Row(
                            children: [
                              _buildStatItem("Posts", person["posts"] as int),
                              SizedBox(width: spMd),
                              _buildStatItem("Followers", person["followers"] as int),
                              SizedBox(width: spMd),
                              _buildStatItem("Following", person["following"] as int),
                            ],
                          ),
                        ),
                        
                        // Workout Streak
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.local_fire_department,
                                color: warningColor,
                                size: 12,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${person["workoutStreak"]} day streak",
                                style: TextStyle(
                                  color: warningColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spSm),

                    // Categories and Badges
                    Row(
                      children: [
                        // Categories
                        Expanded(
                          child: Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (person["categories"] as List).map((category) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  category,
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        
                        // Location and Activity
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (person["location"] != null)
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: disabledBoldColor,
                                    size: 12,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${person["location"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            SizedBox(height: spXs),
                            Text(
                              "${person["lastActive"]}",
                              style: TextStyle(
                                color: person["isOnline"] as bool ? successColor : disabledBoldColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Badges
                    if ((person["badges"] as List).isNotEmpty) ...[
                      SizedBox(height: spSm),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (person["badges"] as List).map((badge) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                              border: Border.all(color: warningColor.withAlpha(50)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.emoji_events,
                                  color: warningColor,
                                  size: 10,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  badge,
                                  style: TextStyle(
                                    color: warningColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],

                    SizedBox(height: spSm),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Profile",
                            size: bs.sm,
                            onPressed: () {
                              // View full profile
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Message",
                            size: bs.sm,
                            onPressed: () {
                              // Send message
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            SizedBox(height: spMd),

            // Load More Button
            if (filteredPeople.isNotEmpty)
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Load More People",
                  size: bs.md,
                  onPressed: () {
                    // Load more people
                  },
                ),
              ),

            // Empty State
            if (filteredPeople.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No people found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your search or filter",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, int value) {
    return Column(
      children: [
        Text(
          _formatNumber(value),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryColor,
            fontSize: 14,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
