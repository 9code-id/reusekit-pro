import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaForumsView extends StatefulWidget {
  const GeaForumsView({super.key});

  @override
  State<GeaForumsView> createState() => _GeaForumsViewState();
}

class _GeaForumsViewState extends State<GeaForumsView> {
  String selectedCategory = "All";
  String searchQuery = "";
  int selectedSort = 0;

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "General Discussion", "value": "General Discussion"},
    {"label": "Game Strategies", "value": "Game Strategies"},
    {"label": "Team Recruitment", "value": "Team Recruitment"},
    {"label": "Technical Support", "value": "Technical Support"},
    {"label": "Tournament Talk", "value": "Tournament Talk"},
  ];

  List<String> sortOptions = [
    "Latest Activity",
    "Most Replies",
    "Most Views",
    "Newest Topics",
  ];

  List<Map<String, dynamic>> forumTopics = [
    {
      "id": 1,
      "title": "Best Valorant Lineups for Ascent Map",
      "category": "Game Strategies",
      "author": "StrategyMaster",
      "authorAvatar": "https://picsum.photos/40/40?random=1",
      "replies": 42,
      "views": 1250,
      "lastActivity": "5 minutes ago",
      "lastUser": "ProPlayer123",
      "isPinned": true,
      "isLocked": false,
      "hasNewReplies": true,
    },
    {
      "id": 2,
      "title": "Looking for CS2 Team - Global Elite Level",
      "category": "Team Recruitment",
      "author": "TeamCaptain",
      "authorAvatar": "https://picsum.photos/40/40?random=2",
      "replies": 18,
      "views": 680,
      "lastActivity": "12 minutes ago",
      "lastUser": "SkillfulGamer",
      "isPinned": false,
      "isLocked": false,
      "hasNewReplies": true,
    },
    {
      "id": 3,
      "title": "VCT Champions 2024 Predictions and Analysis",
      "category": "Tournament Talk",
      "author": "EsportsAnalyst",
      "authorAvatar": "https://picsum.photos/40/40?random=3",
      "replies": 89,
      "views": 3200,
      "lastActivity": "25 minutes ago",
      "lastUser": "FanBoy2024",
      "isPinned": true,
      "isLocked": false,
      "hasNewReplies": false,
    },
    {
      "id": 4,
      "title": "Frame Rate Issues After Latest Update",
      "category": "Technical Support",
      "author": "GamerInNeed",
      "authorAvatar": "https://picsum.photos/40/40?random=4",
      "replies": 15,
      "views": 450,
      "lastActivity": "1 hour ago",
      "lastUser": "TechSupport",
      "isPinned": false,
      "isLocked": false,
      "hasNewReplies": true,
    },
    {
      "id": 5,
      "title": "Welcome to GEA Forums - Read This First!",
      "category": "General Discussion",
      "author": "Administrator",
      "authorAvatar": "https://picsum.photos/40/40?random=5",
      "replies": 156,
      "views": 8900,
      "lastActivity": "2 hours ago",
      "lastUser": "NewMember",
      "isPinned": true,
      "isLocked": true,
      "hasNewReplies": false,
    },
    {
      "id": 6,
      "title": "Effective Crosshair Placement Techniques",
      "category": "Game Strategies",
      "author": "AimCoach",
      "authorAvatar": "https://picsum.photos/40/40?random=6",
      "replies": 73,
      "views": 2100,
      "lastActivity": "3 hours ago",
      "lastUser": "QuickAim",
      "isPinned": false,
      "isLocked": false,
      "hasNewReplies": false,
    },
  ];

  List<Map<String, dynamic>> moderators = [
    {
      "name": "GameMaster",
      "avatar": "https://picsum.photos/30/30?random=10",
      "isOnline": true,
    },
    {
      "name": "ForumAdmin",
      "avatar": "https://picsum.photos/30/30?random=11", 
      "isOnline": false,
    },
    {
      "name": "TechModerator",
      "avatar": "https://picsum.photos/30/30?random=12",
      "isOnline": true,
    },
  ];

  List<Map<String, dynamic>> get filteredTopics {
    return forumTopics.where((topic) {
      bool matchesCategory = selectedCategory == "All" || topic["category"] == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty || 
          (topic["title"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GEA Forums"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _createNewTopic(),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildForumStats(),
            _buildSearchAndFilters(),
            _buildModeratorsPanel(),
            _buildForumTopics(),
          ],
        ),
      ),
    );
  }

  Widget _buildForumStats() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem("Topics", "1,247", Icons.topic),
          ),
          Container(
            width: 1,
            height: 40,
            color: disabledOutlineBorderColor,
          ),
          Expanded(
            child: _buildStatItem("Posts", "18,562", Icons.message),
          ),
          Container(
            width: 1,
            height: 40,
            color: disabledOutlineBorderColor,
          ),
          Expanded(
            child: _buildStatItem("Members", "4,891", Icons.people),
          ),
          Container(
            width: 1,
            height: 40,
            color: disabledOutlineBorderColor,
          ),
          Expanded(
            child: _buildStatItem("Online", "234", Icons.online_prediction),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      spacing: spXs,
      children: [
        Icon(icon, color: primaryColor, size: 20),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: primaryColor,
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

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search topics...",
                value: searchQuery,
                hint: "Search by title or content",
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
              onPressed: () {},
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Category",
                items: categories,
                value: selectedCategory,
                onChanged: (value, label) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Sort By",
                items: sortOptions.asMap().entries.map((entry) => {
                  "label": entry.value,
                  "value": entry.key.toString(),
                }).toList(),
                value: selectedSort.toString(),
                onChanged: (value, label) {
                  selectedSort = int.parse(value);
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildModeratorsPanel() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Forum Moderators",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: moderators.map((moderator) => Container(
              margin: EdgeInsets.only(right: spSm),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage("${moderator["avatar"]}"),
                      ),
                      if (moderator["isOnline"] as bool)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: Border.all(color: Colors.white, width: 1),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${moderator["name"]}",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildForumTopics() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Forum Topics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            Text(
              "${filteredTopics.length} topics",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
        ...filteredTopics.map((topic) => _buildTopicCard(topic)).toList(),
      ],
    );
  }

  Widget _buildTopicCard(Map<String, dynamic> topic) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: (topic["hasNewReplies"] as bool) 
            ? Border.all(color: primaryColor.withAlpha(50), width: 1)
            : null,
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (topic["isPinned"] as bool)
                Container(
                  margin: EdgeInsets.only(right: spXs),
                  child: Icon(
                    Icons.push_pin,
                    color: warningColor,
                    size: 16,
                  ),
                ),
              if (topic["isLocked"] as bool)
                Container(
                  margin: EdgeInsets.only(right: spXs),
                  child: Icon(
                    Icons.lock,
                    color: dangerColor,
                    size: 16,
                  ),
                ),
              Expanded(
                child: Text(
                  "${topic["title"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (topic["hasNewReplies"] as bool)
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                ),
            ],
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundImage: NetworkImage("${topic["authorAvatar"]}"),
              ),
              SizedBox(width: spXs),
              Text(
                "${topic["author"]}",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: secondaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${topic["category"]}",
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.reply, color: disabledBoldColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "${topic["replies"]} replies",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              SizedBox(width: spSm),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.visibility, color: disabledBoldColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "${(topic["views"] as int) >= 1000 ? '${((topic["views"] as int) / 1000).toStringAsFixed(1)}K' : topic["views"]} views",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${topic["lastActivity"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    "by ${topic["lastUser"]}",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _createNewTopic() {
    ss("Opening topic creation form");
  }
}
