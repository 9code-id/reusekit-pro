import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaForumsView extends StatefulWidget {
  const NmaForumsView({super.key});

  @override
  State<NmaForumsView> createState() => _NmaForumsViewState();
}

class _NmaForumsViewState extends State<NmaForumsView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedSortBy = "Latest Posts";

  List<String> categories = [
    "All",
    "General Discussion",
    "Local Politics",
    "Community Events",
    "Business & Economy",
    "Environment",
    "Transportation",
    "Education",
    "Healthcare",
    "Housing",
  ];

  List<String> sortOptions = [
    "Latest Posts",
    "Most Active",
    "Most Popular",
    "Newest Forums",
  ];

  List<Map<String, dynamic>> forums = [
    {
      "id": 1,
      "title": "General Discussion",
      "description": "General topics and conversations about our community",
      "category": "General Discussion",
      "icon": Icons.forum,
      "color": primaryColor,
      "topics": 234,
      "posts": 1847,
      "lastPost": {
        "title": "Community Garden Update",
        "author": "GreenThumb2024",
        "time": "5 minutes ago",
        "avatar": "https://picsum.photos/30/30?random=1&keyword=profile",
      },
      "moderators": [
        {
          "name": "Sarah Mitchell",
          "avatar": "https://picsum.photos/30/30?random=10&keyword=profile",
        },
        {
          "name": "David Chen",
          "avatar": "https://picsum.photos/30/30?random=11&keyword=profile",
        }
      ],
      "subscribers": 1247,
      "isSubscribed": true,
    },
    {
      "id": 2,
      "title": "Local Politics & Government",
      "description": "Discussions about local government, policies, and political matters",
      "category": "Local Politics",
      "icon": Icons.how_to_vote,
      "color": infoColor,
      "topics": 156,
      "posts": 892,
      "lastPost": {
        "title": "City Council Meeting Summary",
        "author": "CivicWatcher",
        "time": "2 hours ago",
        "avatar": "https://picsum.photos/30/30?random=2&keyword=profile",
      },
      "moderators": [
        {
          "name": "Amanda Rodriguez",
          "avatar": "https://picsum.photos/30/30?random=12&keyword=profile",
        }
      ],
      "subscribers": 934,
      "isSubscribed": false,
    },
    {
      "id": 3,
      "title": "Community Events",
      "description": "Organize and discuss local events, festivals, and gatherings",
      "category": "Community Events",
      "icon": Icons.event,
      "color": warningColor,
      "topics": 89,
      "posts": 567,
      "lastPost": {
        "title": "Summer Festival Planning",
        "author": "EventOrganizer",
        "time": "4 hours ago",
        "avatar": "https://picsum.photos/30/30?random=3&keyword=profile",
      },
      "moderators": [
        {
          "name": "Michael Thompson",
          "avatar": "https://picsum.photos/30/30?random=13&keyword=profile",
        }
      ],
      "subscribers": 678,
      "isSubscribed": true,
    },
    {
      "id": 4,
      "title": "Business & Economy",
      "description": "Local business news, economic development, and entrepreneurship",
      "category": "Business & Economy",
      "icon": Icons.business,
      "color": successColor,
      "topics": 134,
      "posts": 723,
      "lastPost": {
        "title": "Small Business Support Program",
        "author": "BusinessOwner",
        "time": "6 hours ago",
        "avatar": "https://picsum.photos/30/30?random=4&keyword=profile",
      },
      "moderators": [
        {
          "name": "Lisa Wang",
          "avatar": "https://picsum.photos/30/30?random=14&keyword=profile",
        }
      ],
      "subscribers": 823,
      "isSubscribed": false,
    },
    {
      "id": 5,
      "title": "Environment & Sustainability",
      "description": "Environmental issues, green initiatives, and sustainability discussions",
      "category": "Environment",
      "icon": Icons.eco,
      "color": successColor,
      "topics": 67,
      "posts": 345,
      "lastPost": {
        "title": "Recycling Program Expansion",
        "author": "EcoWarrior",
        "time": "1 day ago",
        "avatar": "https://picsum.photos/30/30?random=5&keyword=profile",
      },
      "moderators": [
        {
          "name": "Green Advocate",
          "avatar": "https://picsum.photos/30/30?random=15&keyword=profile",
        }
      ],
      "subscribers": 456,
      "isSubscribed": true,
    },
    {
      "id": 6,
      "title": "Transportation & Infrastructure",
      "description": "Roads, public transport, traffic, and infrastructure development",
      "category": "Transportation",
      "icon": Icons.directions_bus,
      "color": infoColor,
      "topics": 98,
      "posts": 432,
      "lastPost": {
        "title": "New Bus Route Proposal",
        "author": "CommuterDaily",
        "time": "1 day ago",
        "avatar": "https://picsum.photos/30/30?random=6&keyword=profile",
      },
      "moderators": [
        {
          "name": "Transit Planner",
          "avatar": "https://picsum.photos/30/30?random=16&keyword=profile",
        }
      ],
      "subscribers": 567,
      "isSubscribed": false,
    },
  ];

  List<Map<String, dynamic>> featuredTopics = [
    {
      "id": 1,
      "title": "City Budget 2024 - Public Input Session",
      "forum": "Local Politics & Government",
      "author": "CityModerator",
      "replies": 89,
      "views": 1234,
      "time": "1 hour ago",
      "isPinned": true,
      "isHot": true,
    },
    {
      "id": 2,
      "title": "Neighborhood Watch Program Signup",
      "forum": "General Discussion",
      "author": "SafetyFirst",
      "replies": 45,
      "views": 567,
      "time": "3 hours ago",
      "isPinned": true,
      "isHot": false,
    },
    {
      "id": 3,
      "title": "Local Business Directory Update",
      "forum": "Business & Economy",
      "author": "DirectoryMod",
      "replies": 23,
      "views": 345,
      "time": "5 hours ago",
      "isPinned": false,
      "isHot": true,
    },
  ];

  List<Map<String, dynamic>> get filteredForums {
    var filtered = forums.where((forum) {
      bool matchesSearch = searchQuery.isEmpty ||
          (forum["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (forum["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || forum["category"] == selectedCategory;
      
      return matchesSearch && matchesCategory;
    }).toList();

    // Sort forums
    switch (selectedSortBy) {
      case "Most Active":
        filtered.sort((a, b) => (b["posts"] as int).compareTo(a["posts"] as int));
        break;
      case "Most Popular":
        filtered.sort((a, b) => (b["subscribers"] as int).compareTo(a["subscribers"] as int));
        break;
      case "Newest Forums":
        filtered.sort((a, b) => (a["id"] as int).compareTo(b["id"] as int));
        break;
      default: // Latest Posts
        // Keep original order for latest posts
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Community Forums"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and filters
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Search bar
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search forums...",
                        value: searchQuery,
                        hint: "Search by forum name or description",
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
                SizedBox(height: spSm),
                
                // Filters
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categories.map((category) => {
                          "label": category,
                          "value": category,
                        }).toList(),
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
                        label: "Sort by",
                        items: sortOptions.map((option) => {
                          "label": option,
                          "value": option,
                        }).toList(),
                        value: selectedSortBy,
                        onChanged: (value, label) {
                          selectedSortBy = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Stats header
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(30),
              border: Border(
                bottom: BorderSide(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Text(
                  "${filteredForums.length} forums",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${filteredForums.fold(0, (sum, forum) => sum + (forum["subscribers"] as int))} total members",
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

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Featured topics
                  if (featuredTopics.isNotEmpty) ...[
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Featured Discussions",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Column(
                            children: featuredTopics.map((topic) {
                              return Container(
                                margin: EdgeInsets.only(bottom: spSm),
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  boxShadow: [shadowSm],
                                  border: topic["isPinned"] as bool
                                      ? Border.all(color: warningColor, width: 1)
                                      : null,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(spXs),
                                      decoration: BoxDecoration(
                                        color: primaryColor.withAlpha(100),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Icon(
                                        Icons.forum,
                                        size: 16,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              if (topic["isPinned"] as bool)
                                                Container(
                                                  margin: EdgeInsets.only(right: spXs),
                                                  child: Icon(
                                                    Icons.push_pin,
                                                    size: 12,
                                                    color: warningColor,
                                                  ),
                                                ),
                                              if (topic["isHot"] as bool)
                                                Container(
                                                  margin: EdgeInsets.only(right: spXs),
                                                  child: Icon(
                                                    Icons.local_fire_department,
                                                    size: 12,
                                                    color: dangerColor,
                                                  ),
                                                ),
                                              Expanded(
                                                child: Text(
                                                  "${topic["title"]}",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: primaryColor,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: spXs),
                                          Text(
                                            "in ${topic["forum"]} • by ${topic["author"]} • ${topic["time"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Column(
                                      children: [
                                        Text(
                                          "${topic["replies"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "replies",
                                          style: TextStyle(
                                            fontSize: 10,
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
                      ),
                    ),
                    Divider(color: disabledOutlineBorderColor),
                  ],

                  // Forums list
                  Container(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "All Forums",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Column(
                          children: filteredForums.map((forum) {
                            return Container(
                              margin: EdgeInsets.only(bottom: spMd),
                              child: _buildForumCard(forum),
                            );
                          }).toList(),
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
          // Navigate to create forum/topic
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildForumCard(Map<String, dynamic> forum) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Forum header
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (forum["color"] as Color).withAlpha(100),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  forum["icon"] as IconData,
                  size: 24,
                  color: forum["color"] as Color,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${forum["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${forum["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              QButton(
                label: forum["isSubscribed"] as bool ? "Subscribed" : "Subscribe",
                size: bs.sm,
                onPressed: () {
                  forum["isSubscribed"] = !(forum["isSubscribed"] as bool);
                  if (forum["isSubscribed"]) {
                    forum["subscribers"] = (forum["subscribers"] as int) + 1;
                  } else {
                    forum["subscribers"] = (forum["subscribers"] as int) - 1;
                  }
                  setState(() {});
                },
              ),
            ],
          ),
          SizedBox(height: spSm),

          // Forum stats
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.topic,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${forum["topics"]} topics",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Icon(
                      Icons.chat_bubble_outline,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${forum["posts"]} posts",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Icon(
                      Icons.people,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${forum["subscribers"]} members",
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
          SizedBox(height: spSm),

          // Last post and moderators
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Last post:",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundImage: NetworkImage("${forum["lastPost"]["avatar"]}"),
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${forum["lastPost"]["title"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "by ${forum["lastPost"]["author"]} • ${forum["lastPost"]["time"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: spMd),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Moderators:",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int i = 0; i < (forum["moderators"] as List).length; i++)
                        Container(
                          margin: EdgeInsets.only(left: i > 0 ? spXs : 0),
                          child: CircleAvatar(
                            radius: 12,
                            backgroundImage: NetworkImage("${(forum["moderators"] as List)[i]["avatar"]}"),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
