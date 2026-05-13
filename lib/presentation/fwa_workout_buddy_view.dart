import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaWorkoutBuddyView extends StatefulWidget {
  const FwaWorkoutBuddyView({super.key});

  @override
  State<FwaWorkoutBuddyView> createState() => _FwaWorkoutBuddyViewState();
}

class _FwaWorkoutBuddyViewState extends State<FwaWorkoutBuddyView> {
  String selectedFilter = "All";
  String selectedWorkoutType = "All";
  String selectedDistance = "Any";
  String selectedTime = "Any";

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Available Now", "value": "Available Now"},
    {"label": "My Buddies", "value": "My Buddies"},
    {"label": "Nearby", "value": "Nearby"},
    {"label": "Recommended", "value": "Recommended"},
  ];

  List<Map<String, dynamic>> workoutTypes = [
    {"label": "All", "value": "All"},
    {"label": "Gym", "value": "Gym"},
    {"label": "Running", "value": "Running"},
    {"label": "Cycling", "value": "Cycling"},
    {"label": "Yoga", "value": "Yoga"},
    {"label": "Swimming", "value": "Swimming"},
    {"label": "HIIT", "value": "HIIT"},
    {"label": "CrossFit", "value": "CrossFit"},
  ];

  List<Map<String, dynamic>> distanceOptions = [
    {"label": "Any", "value": "Any"},
    {"label": "Within 1km", "value": "1km"},
    {"label": "Within 5km", "value": "5km"},
    {"label": "Within 10km", "value": "10km"},
    {"label": "Within 25km", "value": "25km"},
  ];

  List<Map<String, dynamic>> timeOptions = [
    {"label": "Any", "value": "Any"},
    {"label": "Morning (6-10 AM)", "value": "Morning"},
    {"label": "Afternoon (10 AM-4 PM)", "value": "Afternoon"},
    {"label": "Evening (4-8 PM)", "value": "Evening"},
    {"label": "Night (8-11 PM)", "value": "Night"},
  ];

  List<Map<String, dynamic>> workoutBuddies = [
    {
      "id": 1,
      "name": "Sarah Johnson",
      "username": "sarah_fit",
      "avatar": "https://picsum.photos/60/60?random=1&keyword=person",
      "isOnline": true,
      "lastActive": "Active now",
      "distance": 2.1,
      "workoutType": "Gym",
      "preferredTime": "Morning",
      "experience": "Intermediate",
      "isMyBuddy": false,
      "isAvailable": true,
      "rating": 4.8,
      "totalWorkouts": 127,
      "bio": "Love morning workouts! Looking for a consistent gym buddy to stay motivated.",
      "goals": ["Weight Loss", "Strength Building"],
      "availability": ["Monday", "Wednesday", "Friday"],
      "equipment": ["Dumbbells", "Resistance Bands"],
      "location": "FitLife Gym",
      "joinedDate": "3 months ago",
      "badges": ["Early Bird", "Consistent"],
      "workoutStreak": 15
    },
    {
      "id": 2,
      "name": "Mike Chen",
      "username": "mike_strong",
      "avatar": "https://picsum.photos/60/60?random=2&keyword=person",
      "isOnline": false,
      "lastActive": "2 hours ago",
      "distance": 4.5,
      "workoutType": "Running",
      "preferredTime": "Evening",
      "experience": "Advanced",
      "isMyBuddy": true,
      "isAvailable": false,
      "rating": 4.9,
      "totalWorkouts": 234,
      "bio": "Marathon runner training for next race. Let's log those miles together!",
      "goals": ["Endurance", "Speed Training"],
      "availability": ["Tuesday", "Thursday", "Saturday", "Sunday"],
      "equipment": ["Running Shoes", "GPS Watch"],
      "location": "Central Park",
      "joinedDate": "8 months ago",
      "badges": ["Marathon Finisher", "Speed Demon"],
      "workoutStreak": 42
    },
    {
      "id": 3,
      "name": "Anna Williams",
      "username": "yoga_anna",
      "avatar": "https://picsum.photos/60/60?random=3&keyword=person",
      "isOnline": true,
      "lastActive": "Active now",
      "distance": 1.8,
      "workoutType": "Yoga",
      "preferredTime": "Morning",
      "experience": "Expert",
      "isMyBuddy": false,
      "isAvailable": true,
      "rating": 5.0,
      "totalWorkouts": 89,
      "bio": "Certified yoga instructor. Join me for peaceful morning sessions.",
      "goals": ["Flexibility", "Mindfulness"],
      "availability": ["Daily"],
      "equipment": ["Yoga Mat", "Blocks"],
      "location": "Zen Studio",
      "joinedDate": "5 months ago",
      "badges": ["Yoga Master", "Zen State"],
      "workoutStreak": 30
    },
    {
      "id": 4,
      "name": "Alex Rodriguez",
      "username": "crossfit_alex",
      "avatar": "https://picsum.photos/60/60?random=4&keyword=person",
      "isOnline": true,
      "lastActive": "Active now",
      "distance": 3.2,
      "workoutType": "CrossFit",
      "preferredTime": "Evening",
      "experience": "Advanced",
      "isMyBuddy": false,
      "isAvailable": true,
      "rating": 4.7,
      "totalWorkouts": 156,
      "bio": "CrossFit enthusiast. Push your limits and achieve new PRs!",
      "goals": ["Functional Fitness", "Strength"],
      "availability": ["Monday", "Wednesday", "Friday"],
      "equipment": ["Kettlebells", "Pull-up Bar"],
      "location": "CrossFit Box",
      "joinedDate": "6 months ago",
      "badges": ["Beast Mode", "PR Crusher"],
      "workoutStreak": 22
    },
    {
      "id": 5,
      "name": "Emily Davis",
      "username": "swimmer_emily",
      "avatar": "https://picsum.photos/60/60?random=5&keyword=person",
      "isOnline": false,
      "lastActive": "1 hour ago",
      "distance": 6.1,
      "workoutType": "Swimming",
      "preferredTime": "Afternoon",
      "experience": "Intermediate",
      "isMyBuddy": true,
      "isAvailable": false,
      "rating": 4.6,
      "totalWorkouts": 92,
      "bio": "Swimming for fitness and fun. Join me for some pool sessions!",
      "goals": ["Cardio", "Technique"],
      "availability": ["Tuesday", "Thursday", "Sunday"],
      "equipment": ["Goggles", "Swim Cap"],
      "location": "Community Pool",
      "joinedDate": "4 months ago",
      "badges": ["Water Warrior", "Consistent"],
      "workoutStreak": 18
    },
  ];

  List<Map<String, dynamic>> get filteredBuddies {
    return workoutBuddies.where((buddy) {
      bool matchesFilter = selectedFilter == "All" ||
                          (selectedFilter == "Available Now" && buddy["isAvailable"] as bool) ||
                          (selectedFilter == "My Buddies" && buddy["isMyBuddy"] as bool) ||
                          (selectedFilter == "Nearby" && (buddy["distance"] as double) <= 5.0) ||
                          selectedFilter == "Recommended";
      
      bool matchesWorkoutType = selectedWorkoutType == "All" || buddy["workoutType"] == selectedWorkoutType;
      bool matchesDistance = selectedDistance == "Any" || _checkDistance(buddy["distance"] as double);
      bool matchesTime = selectedTime == "Any" || buddy["preferredTime"] == selectedTime;
      
      return matchesFilter && matchesWorkoutType && matchesDistance && matchesTime;
    }).toList();
  }

  bool _checkDistance(double distance) {
    switch (selectedDistance) {
      case "1km":
        return distance <= 1.0;
      case "5km":
        return distance <= 5.0;
      case "10km":
        return distance <= 10.0;
      case "25km":
        return distance <= 25.0;
      default:
        return true;
    }
  }

  Color _getExperienceColor(String experience) {
    switch (experience) {
      case "Beginner":
        return successColor;
      case "Intermediate":
        return warningColor;
      case "Advanced":
        return dangerColor;
      case "Expert":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workout Buddy"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterModal();
            },
          ),
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              // Show map view
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Filters
            Text(
              "Find Your Workout Buddy",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
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

            // Active Filters Summary
            if (selectedWorkoutType != "All" || selectedDistance != "Any" || selectedTime != "Any")
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: primaryColor.withAlpha(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Active Filters:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: [
                        if (selectedWorkoutType != "All")
                          _buildFilterChip("Type: $selectedWorkoutType"),
                        if (selectedDistance != "Any")
                          _buildFilterChip("Distance: $selectedDistance"),
                        if (selectedTime != "Any")
                          _buildFilterChip("Time: $selectedTime"),
                      ],
                    ),
                  ],
                ),
              ),

            SizedBox(height: spMd),

            // Results Count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Available Buddies",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${filteredBuddies.length} ${filteredBuddies.length == 1 ? 'buddy' : 'buddies'}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            SizedBox(height: spSm),

            // Workout Buddies List
            ...filteredBuddies.map((buddy) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Avatar with online status
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage("${buddy["avatar"]}"),
                            ),
                            if (buddy["isOnline"] as bool)
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
                                      "${buddy["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  // Availability Status
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: buddy["isAvailable"] as bool ? successColor.withAlpha(20) : disabledColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      buddy["isAvailable"] as bool ? "Available" : "Busy",
                                      style: TextStyle(
                                        color: buddy["isAvailable"] as bool ? successColor : disabledBoldColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              
                              Row(
                                children: [
                                  Text(
                                    "@${buddy["username"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(" • ", style: TextStyle(color: disabledBoldColor)),
                                  Icon(
                                    Icons.location_on,
                                    color: disabledBoldColor,
                                    size: 12,
                                  ),
                                  Text(
                                    "${(buddy["distance"] as double).toStringAsFixed(1)}km away",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: spXs),
                              
                              // Rating and Stats
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: warningColor,
                                    size: 14,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${(buddy["rating"] as double).toStringAsFixed(1)}",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    " (${buddy["totalWorkouts"]} workouts)",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        // Connect Button
                        QButton(
                          label: buddy["isMyBuddy"] as bool ? "Chat" : "Connect",
                          size: bs.sm,
                          onPressed: () {
                            if (buddy["isMyBuddy"] as bool) {
                              // Open chat
                            } else {
                              // Send buddy request
                              _sendBuddyRequest(buddy);
                            }
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: spSm),

                    // Bio
                    Text(
                      "${buddy["bio"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),

                    SizedBox(height: spSm),

                    // Workout Info
                    Row(
                      children: [
                        // Workout Type
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${buddy["workoutType"]}",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        
                        SizedBox(width: spSm),
                        
                        // Experience Level
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getExperienceColor(buddy["experience"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${buddy["experience"]}",
                            style: TextStyle(
                              color: _getExperienceColor(buddy["experience"]),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        
                        SizedBox(width: spSm),
                        
                        // Preferred Time
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${buddy["preferredTime"]}",
                            style: TextStyle(
                              color: infoColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        
                        Spacer(),
                        
                        // Workout Streak
                        Row(
                          children: [
                            Icon(
                              Icons.local_fire_department,
                              color: warningColor,
                              size: 12,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${buddy["workoutStreak"]} days",
                              style: TextStyle(
                                color: warningColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: spSm),

                    // Goals
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: [
                        Text(
                          "Goals:",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        ...(buddy["goals"] as List).map((goal) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 1),
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              goal,
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 11,
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),

                    SizedBox(height: spSm),

                    // Availability and Location
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Available:",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                (buddy["availability"] as List).join(", "),
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Location:",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${buddy["location"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Badges
                    if ((buddy["badges"] as List).isNotEmpty) ...[
                      SizedBox(height: spSm),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (buddy["badges"] as List).map((badge) {
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
                  ],
                ),
              );
            }).toList(),

            SizedBox(height: spMd),

            // Load More Button
            if (filteredBuddies.isNotEmpty)
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Load More Buddies",
                  size: bs.md,
                  onPressed: () {
                    // Load more buddies
                  },
                ),
              ),

            // Empty State
            if (filteredBuddies.isEmpty)
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
                      "No workout buddies found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your filters or check back later",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: spMd),
                    QButton(
                      label: "Clear Filters",
                      size: bs.sm,
                      onPressed: () {
                        selectedFilter = "All";
                        selectedWorkoutType = "All";
                        selectedDistance = "Any";
                        selectedTime = "Any";
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Create workout session
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: primaryColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _showFilterModal() {
    // Show filter modal
  }

  void _sendBuddyRequest(Map<String, dynamic> buddy) {
    ss("Buddy request sent to ${buddy["name"]}!");
  }
}
