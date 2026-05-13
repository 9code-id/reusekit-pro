import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaCommunityView extends StatefulWidget {
  const FwaCommunityView({super.key});

  @override
  State<FwaCommunityView> createState() => _FwaCommunityViewState();
}

class _FwaCommunityViewState extends State<FwaCommunityView> {
  int selectedTab = 0;
  String selectedCommunity = "All";
  
  List<String> communityTypes = ["All", "Beginners", "Weight Loss", "Strength", "Yoga", "Running", "HIIT"];
  
  List<Map<String, dynamic>> communityPosts = [
    {
      "id": 1,
      "userName": "Sarah M.",
      "userAvatar": "https://picsum.photos/50/50?random=1&keyword=woman",
      "timeAgo": "2 hours ago",
      "community": "Weight Loss",
      "content": "Just completed my 30-day weight loss challenge! Lost 8 pounds and feeling amazing. Thanks for all the support from this community! 💪",
      "image": "https://picsum.photos/300/200?random=1&keyword=fitness",
      "likes": 24,
      "comments": 8,
      "isLiked": false,
      "achievements": ["30-Day Challenge", "Weight Loss"],
      "workoutType": "Cardio + Strength"
    },
    {
      "id": 2,
      "userName": "Mike Chen",
      "userAvatar": "https://picsum.photos/50/50?random=2&keyword=man",
      "timeAgo": "4 hours ago",
      "community": "Strength",
      "content": "New personal record! Finally hit 225 lbs on bench press. The progressive overload training really works. Who else is working on their PRs?",
      "image": null,
      "likes": 31,
      "comments": 12,
      "isLiked": true,
      "achievements": ["Personal Record", "Strength"],
      "workoutType": "Strength Training"
    },
    {
      "id": 3,
      "userName": "Emma Davis",
      "userAvatar": "https://picsum.photos/50/50?random=3&keyword=woman",
      "timeAgo": "6 hours ago",
      "community": "Yoga",
      "content": "Morning yoga session in the park was absolutely peaceful. Sometimes nature is the best gym! Here's my favorite sunrise pose sequence.",
      "image": "https://picsum.photos/300/200?random=3&keyword=yoga",
      "likes": 19,
      "comments": 5,
      "isLiked": false,
      "achievements": ["Morning Warrior", "Mindfulness"],
      "workoutType": "Yoga Flow"
    },
    {
      "id": 4,
      "userName": "Alex Rodriguez",
      "userAvatar": "https://picsum.photos/50/50?random=4&keyword=man",
      "timeAgo": "8 hours ago",
      "community": "Running",
      "content": "Completed my first 10K race today! Time: 52:30. Not the fastest but I finished strong. Training for half marathon next! 🏃‍♂️",
      "image": "https://picsum.photos/300/200?random=4&keyword=running",
      "likes": 42,
      "comments": 15,
      "isLiked": true,
      "achievements": ["First 10K", "Endurance"],
      "workoutType": "Distance Running"
    },
    {
      "id": 5,
      "userName": "Lisa Wang",
      "userAvatar": "https://picsum.photos/50/50?random=5&keyword=woman",
      "timeAgo": "1 day ago",
      "community": "HIIT",
      "content": "HIIT workout destroyed me today but in the best way! 20 minutes of pure intensity. Who's joining tomorrow's group session?",
      "image": null,
      "likes": 28,
      "comments": 9,
      "isLiked": false,
      "achievements": ["HIIT Warrior", "Group Training"],
      "workoutType": "High Intensity"
    }
  ];

  List<Map<String, dynamic>> challenges = [
    {
      "id": 1,
      "title": "30-Day Push-Up Challenge",
      "description": "Build upper body strength with daily push-up progression",
      "participants": 245,
      "daysLeft": 12,
      "difficulty": "Intermediate",
      "image": "https://picsum.photos/150/100?random=1&keyword=pushup",
      "isJoined": true
    },
    {
      "id": 2,
      "title": "10K Steps Daily",
      "description": "Walk 10,000 steps every day for better health",
      "participants": 189,
      "daysLeft": 8,
      "difficulty": "Beginner",
      "image": "https://picsum.photos/150/100?random=2&keyword=walking",
      "isJoined": false
    },
    {
      "id": 3,
      "title": "Plank Power Month",
      "description": "Build core strength with daily plank challenges",
      "participants": 156,
      "daysLeft": 20,
      "difficulty": "Advanced",
      "image": "https://picsum.photos/150/100?random=3&keyword=plank",
      "isJoined": true
    }
  ];

  List<Map<String, dynamic>> groups = [
    {
      "id": 1,
      "name": "Morning Warriors",
      "description": "Early birds who love morning workouts",
      "members": 342,
      "image": "https://picsum.photos/80/80?random=1&keyword=morning",
      "category": "Time-based",
      "isJoined": true
    },
    {
      "id": 2,
      "name": "Weight Loss Journey",
      "description": "Supporting each other in weight loss goals",
      "members": 567,
      "image": "https://picsum.photos/80/80?random=2&keyword=scale",
      "category": "Goal-based",
      "isJoined": false
    },
    {
      "id": 3,
      "name": "Home Gym Heroes",
      "description": "Making the most of home workouts",
      "members": 289,
      "image": "https://picsum.photos/80/80?random=3&keyword=home",
      "category": "Location-based",
      "isJoined": true
    }
  ];

  List<Map<String, dynamic>> get filteredPosts {
    if (selectedCommunity == "All") return communityPosts;
    return communityPosts.where((post) => (post["community"] as String) == selectedCommunity).toList();
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    List<dynamic> achievements = post["achievements"] as List;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User header
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusLg),
                child: Image.network(
                  "${post["userAvatar"]}",
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
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
                          "${post["userName"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${post["community"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${post["timeAgo"]} • ${post["workoutType"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              Icon(
                Icons.more_vert,
                color: disabledBoldColor,
                size: 20,
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Post content
          Text(
            "${post["content"]}",
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              height: 1.4,
            ),
          ),
          
          // Post image
          if (post["image"] != null) ...[
            SizedBox(height: spSm),
            ClipRRect(
              borderRadius: BorderRadius.circular(radiusSm),
              child: Image.network(
                "${post["image"]}",
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ],
          
          SizedBox(height: spSm),
          
          // Achievements
          if (achievements.isNotEmpty)
            Wrap(
              spacing: spXs,
              children: achievements.map((achievement) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.emoji_events, size: 12, color: warningColor),
                      SizedBox(width: 2),
                      Text(
                        "$achievement",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          
          SizedBox(height: spSm),
          
          // Action buttons
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  // Toggle like
                },
                child: Row(
                  children: [
                    Icon(
                      (post["isLiked"] as bool) ? Icons.favorite : Icons.favorite_border,
                      color: (post["isLiked"] as bool) ? dangerColor : disabledBoldColor,
                      size: 20,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${post["likes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(width: spMd),
              
              GestureDetector(
                onTap: () {
                  // View comments
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.comment_outlined,
                      color: disabledBoldColor,
                      size: 20,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${post["comments"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              Spacer(),
              
              GestureDetector(
                onTap: () {
                  // Share post
                },
                child: Icon(
                  Icons.share_outlined,
                  color: disabledBoldColor,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeCard(Map<String, dynamic> challenge) {
    Color difficultyColor = challenge["difficulty"] == "Beginner" 
        ? successColor 
        : challenge["difficulty"] == "Intermediate" 
        ? warningColor 
        : dangerColor;
    
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${challenge["image"]}",
              width: double.infinity,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          
          SizedBox(height: spSm),
          
          Text(
            "${challenge["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          
          SizedBox(height: spXs),
          
          Text(
            "${challenge["description"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: difficultyColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${challenge["difficulty"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: difficultyColor,
                  ),
                ),
              ),
              Spacer(),
              Text(
                "${challenge["daysLeft"]} days left",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spXs),
          
          Row(
            children: [
              Icon(Icons.people, size: 12, color: disabledBoldColor),
              SizedBox(width: 4),
              Text(
                "${challenge["participants"]} joined",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Container(
            width: double.infinity,
            child: QButton(
              label: (challenge["isJoined"] as bool) ? "Joined" : "Join Challenge",
              size: bs.sm,
              onPressed: (challenge["isJoined"] as bool) ? null : () {
                // Join challenge
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupCard(Map<String, dynamic> group) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${group["image"]}",
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          
          SizedBox(width: spSm),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${group["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                SizedBox(height: spXs),
                
                Text(
                  "${group["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                
                SizedBox(height: spXs),
                
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${group["category"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: infoColor,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.people, size: 12, color: disabledBoldColor),
                    SizedBox(width: 4),
                    Text(
                      "${group["members"]} members",
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
          
          QButton(
            label: (group["isJoined"] as bool) ? "Joined" : "Join",
            size: bs.sm,
            onPressed: (group["isJoined"] as bool) ? null : () {
              // Join group
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Community",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Feed", icon: Icon(Icons.home)),
        Tab(text: "Challenges", icon: Icon(Icons.emoji_events)),
        Tab(text: "Groups", icon: Icon(Icons.group)),
      ],
      tabChildren: [
        // Feed Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: [
              // Community filter
              QDropdownField(
                label: "Community",
                items: communityTypes.map((type) => {
                  "label": type,
                  "value": type,
                }).toList(),
                value: selectedCommunity,
                onChanged: (value, label) {
                  selectedCommunity = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spMd),
              
              // Posts
              ...filteredPosts.map((post) => _buildPostCard(post)).toList(),
            ],
          ),
        ),
        
        // Challenges Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Active Challenges",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spSm),
              
              QHorizontalScroll(
                children: challenges.map((challenge) => _buildChallengeCard(challenge)).toList(),
              ),
              
              SizedBox(height: spMd),
              
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Create New Challenge",
                  size: bs.md,
                  icon: Icons.add,
                  onPressed: () {
                    // Create challenge
                  },
                ),
              ),
            ],
          ),
        ),
        
        // Groups Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Fitness Groups",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spSm),
              
              ...groups.map((group) => _buildGroupCard(group)).toList(),
              
              SizedBox(height: spMd),
              
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Create New Group",
                  size: bs.md,
                  icon: Icons.add,
                  onPressed: () {
                    // Create group
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
