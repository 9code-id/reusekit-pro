import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaHealthGroupsView extends StatefulWidget {
  const MhaHealthGroupsView({super.key});

  @override
  State<MhaHealthGroupsView> createState() => _MhaHealthGroupsViewState();
}

class _MhaHealthGroupsViewState extends State<MhaHealthGroupsView> {
  String selectedTab = "my_groups";
  String searchQuery = "";
  String selectedCategory = "all";

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "all"},
    {"label": "Chronic Conditions", "value": "chronic"},
    {"label": "Mental Health", "value": "mental"},
    {"label": "Fitness & Nutrition", "value": "fitness"},
    {"label": "Support Groups", "value": "support"},
    {"label": "Wellness", "value": "wellness"},
  ];

  List<Map<String, dynamic>> healthGroups = [
    {
      "id": 1,
      "name": "Diabetes Warriors",
      "description": "Supporting each other in managing diabetes with practical tips, recipes, and encouragement",
      "category": "chronic",
      "members": 2340,
      "posts": 1254,
      "image": "https://picsum.photos/300/200?random=10",
      "privacy": "public",
      "activity": "Very Active",
      "isJoined": true,
      "isModerator": false,
      "tags": ["diabetes", "type2", "diet", "insulin", "support"],
      "lastActivity": "2024-06-14T10:30:00.000Z",
      "recentPosts": [
        {
          "title": "Low carb breakfast ideas that actually taste good",
          "author": "Sarah M.",
          "time": "2 hours ago",
          "likes": 24
        },
        {
          "title": "My A1C dropped from 8.5 to 6.2 in 6 months",
          "author": "Mike T.",
          "time": "4 hours ago",
          "likes": 67
        }
      ],
      "rules": [
        "Be respectful and supportive",
        "No medical advice - only personal experiences",
        "Share resources and recipes freely",
        "Keep discussions relevant to diabetes management"
      ]
    },
    {
      "id": 2,
      "name": "Anxiety & Depression Support Circle",
      "description": "A safe space to share experiences, coping strategies, and find encouragement in mental health journey",
      "category": "mental",
      "members": 4567,
      "posts": 2876,
      "image": "https://picsum.photos/300/200?random=11",
      "privacy": "private",
      "activity": "Very Active",
      "isJoined": true,
      "isModerator": true,
      "tags": ["anxiety", "depression", "mental health", "coping", "therapy"],
      "lastActivity": "2024-06-14T11:15:00.000Z",
      "recentPosts": [
        {
          "title": "Grounding techniques that work for panic attacks",
          "author": "Anonymous",
          "time": "1 hour ago",
          "likes": 45
        },
        {
          "title": "Finding the right therapist - my journey",
          "author": "Lisa R.",
          "time": "3 hours ago",
          "likes": 32
        }
      ],
      "rules": [
        "Maintain anonymity and confidentiality",
        "No triggering content without warnings",
        "Professional crisis resources pinned",
        "Peer support only - not professional advice"
      ]
    },
    {
      "id": 3,
      "name": "Heart Health Heroes",
      "description": "Cardiovascular health support, exercise tips, and heart-healthy living discussions",
      "category": "chronic",
      "members": 1876,
      "posts": 987,
      "image": "https://picsum.photos/300/200?random=12",
      "privacy": "public",
      "activity": "Active",
      "isJoined": false,
      "isModerator": false,
      "tags": ["heart health", "cardio", "exercise", "diet", "prevention"],
      "lastActivity": "2024-06-14T09:45:00.000Z",
      "recentPosts": [
        {
          "title": "Best exercises for heart health after cardiac event",
          "author": "Dr. Johnson",
          "time": "5 hours ago",
          "likes": 56
        }
      ],
      "rules": [
        "Share evidence-based information",
        "Respect different recovery journeys",
        "Encourage healthy lifestyle choices",
        "Consult professionals for medical decisions"
      ]
    },
    {
      "id": 4,
      "name": "Mindful Eating Community",
      "description": "Healthy relationship with food, mindful eating practices, and nutrition support",
      "category": "fitness",
      "members": 3245,
      "posts": 1543,
      "image": "https://picsum.photos/300/200?random=13",
      "privacy": "public",
      "activity": "Very Active",
      "isJoined": false,
      "isModerator": false,
      "tags": ["mindful eating", "nutrition", "recipes", "wellness", "diet"],
      "lastActivity": "2024-06-14T08:20:00.000Z",
      "recentPosts": [
        {
          "title": "Meal prep Sunday - healthy batch cooking ideas",
          "author": "Maria C.",
          "time": "6 hours ago",
          "likes": 89
        }
      ],
      "rules": [
        "No diet shaming or body shaming",
        "Focus on health, not weight loss",
        "Share recipes and meal ideas",
        "Support mindful eating practices"
      ]
    },
    {
      "id": 5,
      "name": "Cancer Survivors Network",
      "description": "Support, hope, and shared experiences for cancer survivors and their families",
      "category": "support",
      "members": 1254,
      "posts": 2341,
      "image": "https://picsum.photos/300/200?random=14",
      "privacy": "private",
      "activity": "Active",
      "isJoined": false,
      "isModerator": false,
      "tags": ["cancer", "survivors", "support", "family", "hope"],
      "lastActivity": "2024-06-14T07:10:00.000Z",
      "recentPosts": [],
      "rules": [
        "Respect privacy and confidentiality",
        "Share hope and encouragement",
        "Support all types of cancer experiences",
        "Professional resources available"
      ]
    },
    {
      "id": 6,
      "name": "New Moms Wellness Hub",
      "description": "Postpartum health, baby care, and maternal wellness support for new mothers",
      "category": "wellness",
      "members": 2987,
      "posts": 1876,
      "image": "https://picsum.photos/300/200?random=15",
      "privacy": "public",
      "activity": "Very Active",
      "isJoined": false,
      "isModerator": false,
      "tags": ["postpartum", "newborn", "maternal health", "wellness", "support"],
      "lastActivity": "2024-06-14T11:30:00.000Z",
      "recentPosts": [
        {
          "title": "Postpartum exercise - when to start and what's safe",
          "author": "Dr. Smith",
          "time": "30 minutes ago",
          "likes": 78
        }
      ],
      "rules": [
        "Evidence-based information only",
        "Support all parenting choices",
        "No judgment or mom shaming",
        "Professional resources available"
      ]
    },
  ];

  List<Map<String, dynamic>> get filteredGroups {
    return healthGroups.where((group) {
      bool matchesTab = selectedTab == "all" || 
                       (selectedTab == "my_groups" && group["isJoined"] == true) ||
                       (selectedTab == "public" && group["privacy"] == "public") ||
                       (selectedTab == "private" && group["privacy"] == "private");
      
      bool matchesCategory = selectedCategory == "all" || group["category"] == selectedCategory;
      
      bool matchesSearch = searchQuery.isEmpty || 
                          (group["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
                          (group["description"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
                          (group["tags"] as List<String>).any((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()));
      
      return matchesTab && matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health Groups"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _showSearchDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Show group notifications
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Navigation
          Container(
            padding: EdgeInsets.all(spMd),
            child: QCategoryPicker(
              items: [
                {"label": "My Groups", "value": "my_groups"},
                {"label": "Public", "value": "public"},
                {"label": "Private", "value": "private"},
                {"label": "All", "value": "all"},
              ],
              value: selectedTab,
              onChanged: (index, label, value, item) {
                selectedTab = value;
                setState(() {});
              },
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  // Quick Stats
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 150,
                    children: [
                      _buildStatCard(
                        "My Groups",
                        "${healthGroups.where((g) => g["isJoined"] == true).length}",
                        Icons.group,
                        primaryColor,
                      ),
                      _buildStatCard(
                        "Moderating",
                        "${healthGroups.where((g) => g["isModerator"] == true).length}",
                        Icons.admin_panel_settings,
                        successColor,
                      ),
                      _buildStatCard(
                        "Total Members",
                        "${healthGroups.where((g) => g["isJoined"] == true).fold(0, (sum, g) => sum + (g["members"] as int))}",
                        Icons.people,
                        infoColor,
                      ),
                      _buildStatCard(
                        "Active Today",
                        "${healthGroups.where((g) => g["activity"] == "Very Active").length}",
                        Icons.trending_up,
                        warningColor,
                      ),
                    ],
                  ),

                  // Search and Filter
                  Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: QTextField(
                              label: "Search groups",
                              value: searchQuery,
                              hint: "Search by name, description, or tags...",
                              onChanged: (value) {
                                searchQuery = value;
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.search,
                            size: bs.sm,
                            onPressed: () {
                              // Perform search
                            },
                          ),
                        ],
                      ),

                      QCategoryPicker(
                        label: "Category",
                        items: categories,
                        value: selectedCategory,
                        onChanged: (index, label, value, item) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),

                  // Groups Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${selectedTab.replaceAll('_', ' ').toUpperCase()} (${filteredGroups.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _createGroup();
                        },
                        child: Text(
                          "Create Group",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Groups List
                  ...filteredGroups.map((group) => _buildGroupCard(group)),

                  // Join More Groups CTA
                  if (selectedTab == "my_groups" && filteredGroups.length < 3)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: primaryColor.withAlpha(50)),
                      ),
                      child: Column(
                        spacing: spSm,
                        children: [
                          Icon(
                            Icons.group_add,
                            color: primaryColor,
                            size: 48,
                          ),
                          Text(
                            "Join More Health Groups",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Connect with others who share similar health interests and goals",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: spSm),
                          QButton(
                            label: "Explore Groups",
                            icon: Icons.explore,
                            size: bs.md,
                            onPressed: () {
                              selectedTab = "public";
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createGroup();
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupCard(Map<String, dynamic> group) {
    Color activityColor = group["activity"] == "Very Active" ? successColor : 
                         group["activity"] == "Active" ? warningColor : disabledBoldColor;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Group Header
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusMd),
                child: Image.network(
                  "${group["image"]}",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
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
                        if (group["privacy"] == "private")
                          Icon(
                            Icons.lock,
                            color: disabledBoldColor,
                            size: 16,
                          ),
                        if (group["isModerator"] == true) ...[
                          SizedBox(width: spXs),
                          Icon(
                            Icons.admin_panel_settings,
                            color: successColor,
                            size: 16,
                          ),
                        ],
                      ],
                    ),
                    Text(
                      "${group["description"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.group,
                          color: disabledBoldColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${group["members"]} members",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: activityColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${group["activity"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: activityColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Tags
          if ((group["tags"] as List<String>).isNotEmpty)
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: (group["tags"] as List<String>).take(4).map((tag) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(color: primaryColor.withAlpha(30)),
                  ),
                  child: Text(
                    "#$tag",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
            ),

          // Recent Posts (for joined groups)
          if (group["isJoined"] == true && (group["recentPosts"] as List).isNotEmpty) ...[
            Text(
              "Recent Posts",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ...(group["recentPosts"] as List<Map<String, dynamic>>).take(2).map((post) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(5),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${post["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Text(
                          "by ${post["author"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          " • ${post["time"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.favorite,
                          color: disabledBoldColor,
                          size: 12,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${post["likes"]}",
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
            }),
          ],

          // Group Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 100,
            children: [
              _buildGroupStat("Members", "${group["members"]}", Icons.group),
              _buildGroupStat("Posts", "${group["posts"]}", Icons.post_add),
              _buildGroupStat("Activity", "${group["activity"]}", Icons.trending_up),
            ],
          ),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: group["isJoined"] == true ? "View Group" : "Join Group",
                  icon: group["isJoined"] == true ? Icons.open_in_new : Icons.group_add,
                  size: bs.md,
                  onPressed: () {
                    if (group["isJoined"] == true) {
                      _viewGroup(group);
                    } else {
                      _joinGroup(group);
                    }
                  },
                ),
              ),
              SizedBox(width: spMd),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showGroupOptions(group);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGroupStat(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 16,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog() {
    // Show search dialog
  }

  void _createGroup() {
    // Navigate to create group screen
  }

  void _joinGroup(Map<String, dynamic> group) {
    if (group["privacy"] == "private") {
      ss("Request sent to join ${group["name"]}");
    } else {
      group["isJoined"] = true;
      group["members"] = (group["members"] as int) + 1;
      setState(() {});
      ss("Joined ${group["name"]}!");
    }
  }

  void _viewGroup(Map<String, dynamic> group) {
    // Navigate to group detail/feed
  }

  void _showGroupOptions(Map<String, dynamic> group) {
    // Show group options menu
  }
}
