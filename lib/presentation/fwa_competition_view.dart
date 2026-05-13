import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaCompetitionView extends StatefulWidget {
  const FwaCompetitionView({super.key});

  @override
  State<FwaCompetitionView> createState() => _FwaCompetitionViewState();
}

class _FwaCompetitionViewState extends State<FwaCompetitionView> {
  String selectedTab = "Active";
  String selectedCategory = "All";

  List<Map<String, dynamic>> tabOptions = [
    {"label": "Active", "value": "Active"},
    {"label": "Upcoming", "value": "Upcoming"},
    {"label": "My Competitions", "value": "My Competitions"},
    {"label": "Completed", "value": "Completed"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Steps", "value": "Steps"},
    {"label": "Distance", "value": "Distance"},
    {"label": "Calories", "value": "Calories"},
    {"label": "Workouts", "value": "Workouts"},
    {"label": "Weight Loss", "value": "Weight Loss"},
    {"label": "Strength", "value": "Strength"},
  ];

  List<Map<String, dynamic>> competitions = [
    {
      "id": 1,
      "title": "10K Steps Daily Challenge",
      "description": "Walk 10,000 steps every day for 30 days. Stay consistent and build healthy habits!",
      "image": "https://picsum.photos/300/200?random=1&keyword=walking",
      "category": "Steps",
      "type": "Daily",
      "duration": "30 days",
      "startDate": "2024-06-01",
      "endDate": "2024-06-30",
      "status": "Active",
      "participants": 1247,
      "maxParticipants": 2000,
      "prize": "Fitness Tracker",
      "entryFee": 0,
      "isJoined": true,
      "myRank": 23,
      "myProgress": 75,
      "target": "10,000 steps/day",
      "rules": ["Walk at least 10,000 steps daily", "Use fitness tracker", "No cheating"],
      "difficulty": "Easy",
      "organizer": "FitLife Community",
      "rewards": ["Winner: Fitness Tracker", "Top 10: Gym Voucher", "All Finishers: Badge"]
    },
    {
      "id": 2,
      "title": "Summer Body Transformation",
      "description": "8-week transformation challenge. Lose weight, build muscle, and get your summer body ready!",
      "image": "https://picsum.photos/300/200?random=2&keyword=transformation",
      "category": "Weight Loss",
      "type": "Challenge",
      "duration": "8 weeks",
      "startDate": "2024-06-15",
      "endDate": "2024-08-10",
      "status": "Upcoming",
      "participants": 456,
      "maxParticipants": 1000,
      "prize": "\$500 Cash Prize",
      "entryFee": 25,
      "isJoined": false,
      "myRank": 0,
      "myProgress": 0,
      "target": "Best transformation",
      "rules": ["Before/after photos required", "Weekly check-ins", "Healthy methods only"],
      "difficulty": "Hard",
      "organizer": "FitLife Pro",
      "rewards": ["1st Place: \$500", "2nd Place: \$300", "3rd Place: \$200"]
    },
    {
      "id": 3,
      "title": "Virtual Marathon Challenge",
      "description": "Complete a full marathon distance (42.2km) within 30 days. Run at your own pace!",
      "image": "https://picsum.photos/300/200?random=3&keyword=marathon",
      "category": "Distance",
      "type": "Endurance",
      "duration": "30 days",
      "startDate": "2024-06-01",
      "endDate": "2024-06-30",
      "status": "Active",
      "participants": 892,
      "maxParticipants": 1500,
      "prize": "Marathon Medal",
      "entryFee": 15,
      "isJoined": true,
      "myRank": 67,
      "myProgress": 45,
      "target": "42.2km total",
      "rules": ["Complete 42.2km in 30 days", "GPS tracking required", "Running only"],
      "difficulty": "Medium",
      "organizer": "Run Club Elite",
      "rewards": ["Finisher Medal", "Digital Certificate", "Training Plan"]
    },
    {
      "id": 4,
      "title": "Push-up Challenge",
      "description": "See how many push-ups you can do in a month. Build upper body strength progressively!",
      "image": "https://picsum.photos/300/200?random=4&keyword=pushup",
      "category": "Strength",
      "type": "Strength",
      "duration": "30 days",
      "startDate": "2024-05-15",
      "endDate": "2024-06-14",
      "status": "Completed",
      "participants": 678,
      "maxParticipants": 1000,
      "prize": "Workout Equipment",
      "entryFee": 0,
      "isJoined": true,
      "myRank": 12,
      "myProgress": 100,
      "target": "Most push-ups",
      "rules": ["Daily push-up count", "Video proof required", "Proper form only"],
      "difficulty": "Medium",
      "organizer": "Strength Club",
      "rewards": ["Top 20: Equipment Set", "All Participants: Badge"]
    },
    {
      "id": 5,
      "title": "Calorie Burn Championship",
      "description": "Burn the most calories in a week through any workout activities. Track everything!",
      "image": "https://picsum.photos/300/200?random=5&keyword=calories",
      "category": "Calories",
      "type": "Weekly",
      "duration": "7 days",
      "startDate": "2024-06-10",
      "endDate": "2024-06-16",
      "status": "Active",
      "participants": 324,
      "maxParticipants": 500,
      "prize": "Nutrition Plan",
      "entryFee": 10,
      "isJoined": false,
      "myRank": 0,
      "myProgress": 0,
      "target": "Most calories burned",
      "rules": ["All activities count", "Heart rate monitor required", "Daily submission"],
      "difficulty": "Hard",
      "organizer": "Burn Club",
      "rewards": ["Winner: Custom Nutrition Plan", "Top 10: Supplement Pack"]
    },
  ];

  List<Map<String, dynamic>> get filteredCompetitions {
    return competitions.where((competition) {
      bool matchesTab = selectedTab == "All" ||
                       competition["status"] == selectedTab ||
                       (selectedTab == "My Competitions" && competition["isJoined"] as bool);
      
      bool matchesCategory = selectedCategory == "All" || competition["category"] == selectedCategory;
      
      return matchesTab && matchesCategory;
    }).toList();
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Easy":
        return successColor;
      case "Medium":
        return warningColor;
      case "Hard":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Upcoming":
        return infoColor;
      case "Completed":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Competitions"),
        actions: [
          IconButton(
            icon: Icon(Icons.emoji_events),
            onPressed: () {
              // View my achievements
            },
          ),
          IconButton(
            icon: Icon(Icons.leaderboard),
            onPressed: () {
              // View leaderboards
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Tab Selector
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              child: QHorizontalScroll(
                children: tabOptions.map((tab) {
                  bool isSelected = tab["value"] == selectedTab;
                  return GestureDetector(
                    onTap: () {
                      selectedTab = tab["value"];
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
                        "${tab["label"]}",
                        style: TextStyle(
                          color: isSelected ? Colors.white : disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Category Filter
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: QDropdownField(
                label: "Category",
                items: categoryOptions,
                value: selectedCategory,
                onChanged: (value, label) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),
            ),

            SizedBox(height: spMd),

            // Competitions List
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedTab == "My Competitions" ? "My Competitions" : "Competitions",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${filteredCompetitions.length} available",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  ...filteredCompetitions.map((competition) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Competition Image
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                            child: Stack(
                              children: [
                                Image.network(
                                  "${competition["image"]}",
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  top: spSm,
                                  left: spSm,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(competition["status"]),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${competition["status"]}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: spSm,
                                  right: spSm,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: _getDifficultyColor(competition["difficulty"]),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${competition["difficulty"]}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                if (competition["isJoined"] as bool)
                                  Positioned(
                                    bottom: spSm,
                                    right: spSm,
                                    child: Container(
                                      padding: EdgeInsets.all(spXs),
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          
                          Padding(
                            padding: EdgeInsets.all(spSm),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title and Category
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${competition["title"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: primaryColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${competition["category"]}",
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                
                                SizedBox(height: spSm),
                                
                                // Description
                                Text(
                                  "${competition["description"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                ),
                                
                                SizedBox(height: spSm),
                                
                                // Competition Details
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.schedule,
                                                color: disabledBoldColor,
                                                size: 16,
                                              ),
                                              SizedBox(width: spXs),
                                              Text(
                                                "${competition["duration"]}",
                                                style: TextStyle(
                                                  color: disabledBoldColor,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: spXs),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.people,
                                                color: disabledBoldColor,
                                                size: 16,
                                              ),
                                              SizedBox(width: spXs),
                                              Text(
                                                "${competition["participants"]}/${competition["maxParticipants"]} joined",
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
                                    
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.emoji_events,
                                              color: warningColor,
                                              size: 16,
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "${competition["prize"]}",
                                              style: TextStyle(
                                                color: warningColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: spXs),
                                        if ((competition["entryFee"] as int) > 0)
                                          Text(
                                            "Entry: \$${competition["entryFee"]}",
                                            style: TextStyle(
                                              color: dangerColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        else
                                          Text(
                                            "Free Entry",
                                            style: TextStyle(
                                              color: successColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                                
                                SizedBox(height: spSm),
                                
                                // Progress Bar (if joined)
                                if (competition["isJoined"] as bool && competition["status"] == "Active") ...[
                                  Row(
                                    children: [
                                      Text(
                                        "My Progress:",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        "Rank #${competition["myRank"]}",
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Container(
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: disabledColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: (competition["myProgress"] as int) / 100,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${competition["myProgress"]}% Complete",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                ],
                                
                                // Target and Organizer
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Target:",
                                            style: TextStyle(
                                              color: disabledBoldColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            "${competition["target"]}",
                                            style: TextStyle(
                                              color: primaryColor,
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
                                          "By:",
                                          style: TextStyle(
                                            color: disabledBoldColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "${competition["organizer"]}",
                                          style: TextStyle(
                                            color: disabledBoldColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                
                                SizedBox(height: spSm),
                                
                                // Action Buttons
                                Row(
                                  children: [
                                    Expanded(
                                      child: QButton(
                                        label: "View Details",
                                        size: bs.sm,
                                        onPressed: () {
                                          // View competition details
                                        },
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: QButton(
                                        label: competition["isJoined"] as bool 
                                            ? (competition["status"] == "Active" ? "View Progress" : "View Results")
                                            : (competition["status"] == "Upcoming" ? "Join Now" : "View Results"),
                                        size: bs.sm,
                                        onPressed: () {
                                          if (competition["isJoined"] as bool) {
                                            // View progress or results
                                          } else {
                                            // Join competition
                                            _joinCompetition(competition);
                                          }
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
                  }).toList(),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Load More Button
            if (filteredCompetitions.isNotEmpty)
              Container(
                padding: EdgeInsets.symmetric(horizontal: spMd),
                width: double.infinity,
                child: QButton(
                  label: "Load More Competitions",
                  size: bs.md,
                  onPressed: () {
                    // Load more competitions
                  },
                ),
              ),

            // Empty State
            if (filteredCompetitions.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.emoji_events,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No competitions found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try selecting a different category or check back later for new competitions",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

            SizedBox(height: spMd),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Create new competition
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _joinCompetition(Map<String, dynamic> competition) {
    if ((competition["entryFee"] as int) > 0) {
      // Show payment dialog
      ss("Redirecting to payment...");
    } else {
      // Join directly
      setState(() {
        competition["isJoined"] = true;
        competition["participants"] = (competition["participants"] as int) + 1;
      });
      ss("Successfully joined ${competition["title"]}!");
    }
  }
}
