import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaGroupsView extends StatefulWidget {
  const FwaGroupsView({super.key});

  @override
  State<FwaGroupsView> createState() => _FwaGroupsViewState();
}

class _FwaGroupsViewState extends State<FwaGroupsView> {
  String searchQuery = "";
  String selectedFilter = "All";
  String selectedCategory = "All";

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "My Groups", "value": "My Groups"},
    {"label": "Popular", "value": "Popular"},
    {"label": "Newest", "value": "Newest"},
    {"label": "Active", "value": "Active"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Weight Loss", "value": "Weight Loss"},
    {"label": "Muscle Building", "value": "Muscle Building"},
    {"label": "Running", "value": "Running"},
    {"label": "Yoga", "value": "Yoga"},
    {"label": "Nutrition", "value": "Nutrition"},
    {"label": "Home Workout", "value": "Home Workout"},
  ];

  List<Map<String, dynamic>> fitnessGroups = [
    {
      "id": 1,
      "name": "30-Day Weight Loss Challenge",
      "description": "Join us for a month-long journey to lose weight together with daily challenges and support.",
      "image": "https://picsum.photos/300/200?random=1&keyword=fitness",
      "category": "Weight Loss",
      "members": 1248,
      "posts": 523,
      "isJoined": true,
      "isPrivate": false,
      "activityLevel": "Very Active",
      "recentActivity": "2 min ago",
      "admins": [
        {
          "name": "Sarah Johnson",
          "avatar": "https://picsum.photos/30/30?random=11&keyword=person"
        }
      ],
      "tags": ["weight loss", "challenge", "support"]
    },
    {
      "id": 2,
      "name": "Morning Runners Club",
      "description": "Early birds who love to start their day with a run. Share routes, tips, and motivation!",
      "image": "https://picsum.photos/300/200?random=2&keyword=running",
      "category": "Running",
      "members": 856,
      "posts": 342,
      "isJoined": false,
      "isPrivate": false,
      "activityLevel": "Active",
      "recentActivity": "15 min ago",
      "admins": [
        {
          "name": "Mike Chen",
          "avatar": "https://picsum.photos/30/30?random=12&keyword=person"
        }
      ],
      "tags": ["running", "morning", "motivation"]
    },
    {
      "id": 3,
      "name": "Muscle Building Masters",
      "description": "Dedicated to serious muscle building. Share workouts, nutrition tips, and progress photos.",
      "image": "https://picsum.photos/300/200?random=3&keyword=gym",
      "category": "Muscle Building",
      "members": 2156,
      "posts": 1024,
      "isJoined": true,
      "isPrivate": false,
      "activityLevel": "Very Active",
      "recentActivity": "5 min ago",
      "admins": [
        {
          "name": "Alex Rodriguez",
          "avatar": "https://picsum.photos/30/30?random=13&keyword=person"
        },
        {
          "name": "Emma Davis",
          "avatar": "https://picsum.photos/30/30?random=14&keyword=person"
        }
      ],
      "tags": ["muscle building", "strength", "bodybuilding"]
    },
    {
      "id": 4,
      "name": "Yoga & Mindfulness",
      "description": "A peaceful community for yoga enthusiasts. Share poses, meditation tips, and find inner peace.",
      "image": "https://picsum.photos/300/200?random=4&keyword=yoga",
      "category": "Yoga",
      "members": 945,
      "posts": 289,
      "isJoined": false,
      "isPrivate": false,
      "activityLevel": "Moderate",
      "recentActivity": "1 hour ago",
      "admins": [
        {
          "name": "Lily Thompson",
          "avatar": "https://picsum.photos/30/30?random=15&keyword=person"
        }
      ],
      "tags": ["yoga", "mindfulness", "meditation"]
    },
    {
      "id": 5,
      "name": "Home Workout Heroes",
      "description": "No gym? No problem! Share home workout routines and equipment-free exercises.",
      "image": "https://picsum.photos/300/200?random=5&keyword=workout",
      "category": "Home Workout",
      "members": 1567,
      "posts": 678,
      "isJoined": true,
      "isPrivate": false,
      "activityLevel": "Active",
      "recentActivity": "30 min ago",
      "admins": [
        {
          "name": "David Kim",
          "avatar": "https://picsum.photos/30/30?random=16&keyword=person"
        }
      ],
      "tags": ["home workout", "no equipment", "convenience"]
    },
    {
      "id": 6,
      "name": "Nutrition Experts",
      "description": "Private group for certified nutritionists and dietitians to share professional insights.",
      "image": "https://picsum.photos/300/200?random=6&keyword=nutrition",
      "category": "Nutrition",
      "members": 234,
      "posts": 156,
      "isJoined": false,
      "isPrivate": true,
      "activityLevel": "Moderate",
      "recentActivity": "2 hours ago",
      "admins": [
        {
          "name": "Dr. Maria Lopez",
          "avatar": "https://picsum.photos/30/30?random=17&keyword=person"
        }
      ],
      "tags": ["nutrition", "professional", "expert"]
    },
  ];

  List<Map<String, dynamic>> get filteredGroups {
    return fitnessGroups.where((group) {
      bool matchesSearch = group["name"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || group["category"] == selectedCategory;
      bool matchesFilter = selectedFilter == "All" || 
                          (selectedFilter == "My Groups" && group["isJoined"] as bool) ||
                          (selectedFilter == "Popular" && (group["members"] as int) > 1000) ||
                          (selectedFilter == "Active" && group["activityLevel"] == "Very Active");
      
      return matchesSearch && matchesCategory && matchesFilter;
    }).toList();
  }

  Color _getActivityColor(String activityLevel) {
    switch (activityLevel) {
      case "Very Active":
        return successColor;
      case "Active":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Groups"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Search functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Create new group
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
              label: "Search groups...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            SizedBox(height: spMd),

            // Filter Options
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Filter",
                    items: filterOptions,
                    value: selectedFilter,
                    onChanged: (value, label) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
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
              ],
            ),

            SizedBox(height: spMd),

            // My Groups Section (if applicable)
            if (selectedFilter == "All" || selectedFilter == "My Groups")
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "My Groups",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          selectedFilter = "My Groups";
                          setState(() {});
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  QHorizontalScroll(
                    children: fitnessGroups.where((group) => group["isJoined"] as bool).map((group) {
                      return Container(
                        width: 280,
                        margin: EdgeInsets.only(right: spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Group Image
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                              child: Stack(
                                children: [
                                  Image.network(
                                    "${group["image"]}",
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  if (group["isPrivate"] as bool)
                                    Positioned(
                                      top: spSm,
                                      right: spSm,
                                      child: Container(
                                        padding: EdgeInsets.all(spXs),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withAlpha(150),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Icon(
                                          Icons.lock,
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
                                  // Group Name
                                  Text(
                                    "${group["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  
                                  SizedBox(height: spXs),
                                  
                                  // Stats
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.people,
                                        color: disabledBoldColor,
                                        size: 16,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${group["members"]}",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Icon(
                                        Icons.message,
                                        color: disabledBoldColor,
                                        size: 16,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${group["posts"]}",
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
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: spMd),
                ],
              ),

            // All Groups Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedFilter == "My Groups" ? "My Groups" : "All Groups",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${filteredGroups.length} groups",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            SizedBox(height: spSm),

            // Groups List
            ...filteredGroups.map((group) {
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
                        // Group Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Stack(
                            children: [
                              Image.network(
                                "${group["image"]}",
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                              if (group["isPrivate"] as bool)
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withAlpha(150),
                                      borderRadius: BorderRadius.circular(radiusXxs),
                                    ),
                                    child: Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        
                        SizedBox(width: spSm),
                        
                        // Group Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${group["name"]}",
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
                                      color: _getActivityColor(group["activityLevel"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${group["activityLevel"]}",
                                      style: TextStyle(
                                        color: _getActivityColor(group["activityLevel"]),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: spXs),
                              
                              Text(
                                "${group["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              
                              SizedBox(height: spSm),
                              
                              // Stats
                              Row(
                                children: [
                                  Icon(
                                    Icons.people,
                                    color: disabledBoldColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${(group["members"] as int) >= 1000 ? '${((group["members"] as int) / 1000).toStringAsFixed(1)}k' : group["members"]} members",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(
                                    Icons.message,
                                    color: disabledBoldColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${group["posts"]} posts",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "•",
                                    style: TextStyle(color: disabledBoldColor),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${group["recentActivity"]}",
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
                      ],
                    ),

                    SizedBox(height: spSm),

                    // Tags
                    if ((group["tags"] as List).isNotEmpty)
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (group["tags"] as List).map((tag) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "#$tag",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                    SizedBox(height: spSm),

                    // Admins and Join Button
                    Row(
                      children: [
                        // Admin Avatars
                        Row(
                          children: [
                            Text(
                              "Admins: ",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            ...(group["admins"] as List).take(3).map((admin) {
                              return Container(
                                margin: EdgeInsets.only(right: spXs),
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundImage: NetworkImage("${admin["avatar"]}"),
                                ),
                              );
                            }).toList(),
                            if ((group["admins"] as List).length > 3)
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: disabledColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    "+${(group["admins"] as List).length - 3}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        
                        Spacer(),
                        
                        // Join/View Button
                        QButton(
                          label: group["isJoined"] as bool ? "View" : "Join",
                          size: bs.sm,
                          onPressed: () {
                            if (group["isJoined"] as bool) {
                              // Navigate to group
                            } else {
                              // Join group
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            SizedBox(height: spMd),

            // Load More Button
            if (filteredGroups.isNotEmpty)
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Load More Groups",
                  size: bs.md,
                  onPressed: () {
                    // Load more groups
                  },
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Create new group
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
