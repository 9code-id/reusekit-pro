import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaForumsView extends StatefulWidget {
  const FwaForumsView({super.key});

  @override
  State<FwaForumsView> createState() => _FwaForumsViewState();
}

class _FwaForumsViewState extends State<FwaForumsView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String sortBy = "Recent";

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "General", "value": "General"},
    {"label": "Workout", "value": "Workout"},
    {"label": "Nutrition", "value": "Nutrition"},
    {"label": "Progress", "value": "Progress"},
    {"label": "Equipment", "value": "Equipment"},
    {"label": "Motivation", "value": "Motivation"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Recent", "value": "Recent"},
    {"label": "Popular", "value": "Popular"},
    {"label": "Most Replies", "value": "Most Replies"},
    {"label": "Unanswered", "value": "Unanswered"},
  ];

  List<Map<String, dynamic>> forumTopics = [
    {
      "id": 1,
      "title": "Best workout routine for beginners?",
      "author": "FitnessNewbie22",
      "authorAvatar": "https://picsum.photos/40/40?random=1&keyword=person",
      "category": "Workout",
      "createdAt": "2 hours ago",
      "replies": 15,
      "views": 124,
      "lastReply": "30 min ago",
      "isSticky": false,
      "isLocked": false,
      "tags": ["beginner", "routine", "workout"]
    },
    {
      "id": 2,
      "title": "Weekly Meal Prep Ideas - Share yours!",
      "author": "HealthyEater",
      "authorAvatar": "https://picsum.photos/40/40?random=2&keyword=person",
      "category": "Nutrition",
      "createdAt": "4 hours ago",
      "replies": 28,
      "views": 256,
      "lastReply": "15 min ago",
      "isSticky": true,
      "isLocked": false,
      "tags": ["meal prep", "nutrition", "recipes"]
    },
    {
      "id": 3,
      "title": "Lost 20kg in 6 months - My journey",
      "author": "TransformationSuccess",
      "authorAvatar": "https://picsum.photos/40/40?random=3&keyword=person",
      "category": "Progress",
      "createdAt": "1 day ago",
      "replies": 42,
      "views": 512,
      "lastReply": "2 hours ago",
      "isSticky": false,
      "isLocked": false,
      "tags": ["weight loss", "transformation", "success"]
    },
    {
      "id": 4,
      "title": "Home gym equipment recommendations under \$500",
      "author": "HomeGymGuru",
      "authorAvatar": "https://picsum.photos/40/40?random=4&keyword=person",
      "category": "Equipment",
      "createdAt": "1 day ago",
      "replies": 18,
      "views": 189,
      "lastReply": "3 hours ago",
      "isSticky": false,
      "isLocked": false,
      "tags": ["home gym", "equipment", "budget"]
    },
    {
      "id": 5,
      "title": "Motivation Monday - Share your goals!",
      "author": "MotivationMaster",
      "authorAvatar": "https://picsum.photos/40/40?random=5&keyword=person",
      "category": "Motivation",
      "createdAt": "2 days ago",
      "replies": 67,
      "views": 432,
      "lastReply": "1 hour ago",
      "isSticky": true,
      "isLocked": false,
      "tags": ["motivation", "goals", "weekly"]
    },
    {
      "id": 6,
      "title": "Form check - Am I doing squats correctly?",
      "author": "FormChecker",
      "authorAvatar": "https://picsum.photos/40/40?random=6&keyword=person",
      "category": "General",
      "createdAt": "3 days ago",
      "replies": 12,
      "views": 98,
      "lastReply": "6 hours ago",
      "isSticky": false,
      "isLocked": false,
      "tags": ["form check", "squats", "technique"]
    },
  ];

  List<Map<String, dynamic>> get filteredTopics {
    return forumTopics.where((topic) {
      bool matchesSearch = topic["title"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || topic["category"] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forums"),
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
              // Create new topic
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
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search topics...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: () {
                    // Show filter options
                  },
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Category Filter
            Text(
              "Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            QHorizontalScroll(
              children: categories.map((category) {
                bool isSelected = category["value"] == selectedCategory;
                return GestureDetector(
                  onTap: () {
                    selectedCategory = category["value"];
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
                      "${category["label"]}",
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

            // Sort Options
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Forum Topics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Sort by:",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      width: 120,
                      child: QDropdownField(
                        label: "",
                        items: sortOptions,
                        value: sortBy,
                        onChanged: (value, label) {
                          sortBy = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Forum Topics List
            ...filteredTopics.map((topic) {
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
                        // Sticky/Pinned Icon
                        if (topic["isSticky"] as bool)
                          Icon(
                            Icons.push_pin,
                            color: warningColor,
                            size: 16,
                          ),
                        if (topic["isSticky"] as bool) SizedBox(width: spXs),
                        
                        // Locked Icon
                        if (topic["isLocked"] as bool)
                          Icon(
                            Icons.lock,
                            color: disabledBoldColor,
                            size: 16,
                          ),
                        if (topic["isLocked"] as bool) SizedBox(width: spXs),
                        
                        // Category Badge
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${topic["category"]}",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        
                        Spacer(),
                        
                        // More Options
                        Icon(
                          Icons.more_vert,
                          color: disabledBoldColor,
                          size: 20,
                        ),
                      ],
                    ),

                    SizedBox(height: spSm),

                    // Topic Title
                    Text(
                      "${topic["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),

                    SizedBox(height: spSm),

                    // Tags
                    if ((topic["tags"] as List).isNotEmpty)
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (topic["tags"] as List).map((tag) {
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

                    // Author and Meta Info
                    Row(
                      children: [
                        // Author Avatar
                        CircleAvatar(
                          radius: 12,
                          backgroundImage: NetworkImage("${topic["authorAvatar"]}"),
                        ),
                        SizedBox(width: spSm),
                        
                        // Author Name
                        Text(
                          "${topic["author"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                            fontSize: 14,
                          ),
                        ),
                        
                        SizedBox(width: spSm),
                        
                        Text(
                          "•",
                          style: TextStyle(color: disabledBoldColor),
                        ),
                        
                        SizedBox(width: spSm),
                        
                        Text(
                          "${topic["createdAt"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spSm),

                    // Stats and Last Reply
                    Row(
                      children: [
                        // Views
                        Icon(
                          Icons.visibility,
                          color: disabledBoldColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${topic["views"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                        
                        SizedBox(width: spMd),
                        
                        // Replies
                        Icon(
                          Icons.comment,
                          color: disabledBoldColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${topic["replies"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                        
                        Spacer(),
                        
                        // Last Reply
                        Text(
                          "Last reply: ${topic["lastReply"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
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
            if (filteredTopics.isNotEmpty)
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Load More Topics",
                  size: bs.md,
                  onPressed: () {
                    // Load more topics
                  },
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Create new topic
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
