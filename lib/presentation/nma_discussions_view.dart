import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaDiscussionsView extends StatefulWidget {
  const NmaDiscussionsView({super.key});

  @override
  State<NmaDiscussionsView> createState() => _NmaDiscussionsViewState();
}

class _NmaDiscussionsViewState extends State<NmaDiscussionsView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedSortBy = "Latest";

  List<String> categories = [
    "All",
    "Politics",
    "Local Issues",
    "Community",
    "Business",
    "Environment",
    "Education",
    "Healthcare",
  ];

  List<String> sortOptions = [
    "Latest",
    "Most Popular",
    "Most Replies",
    "Trending",
  ];

  List<Map<String, dynamic>> discussions = [
    {
      "id": 1,
      "title": "New Traffic Light Installation at Main Street - What's Your Opinion?",
      "author": "CityCouncilMember",
      "authorAvatar": "https://picsum.photos/40/40?random=1&keyword=profile",
      "category": "Local Issues",
      "time": "2 hours ago",
      "replies": 47,
      "views": 324,
      "isHot": true,
      "isPinned": true,
      "lastActivity": "5 minutes ago",
      "preview": "The city council is considering installing a new traffic light at the intersection of Main Street and Oak Avenue. We want to hear from residents about...",
      "participants": [
        "https://picsum.photos/30/30?random=10&keyword=profile",
        "https://picsum.photos/30/30?random=11&keyword=profile",
        "https://picsum.photos/30/30?random=12&keyword=profile",
      ],
    },
    {
      "id": 2,
      "title": "Local Business Recovery After Recent Events - Support Ideas",
      "author": "BusinessOwner23",
      "authorAvatar": "https://picsum.photos/40/40?random=2&keyword=profile",
      "category": "Business",
      "time": "4 hours ago",
      "replies": 32,
      "views": 198,
      "isHot": false,
      "isPinned": false,
      "lastActivity": "1 hour ago",
      "preview": "Hi everyone, I'm a local business owner and I'd like to discuss ways we can support each other during these challenging times...",
      "participants": [
        "https://picsum.photos/30/30?random=13&keyword=profile",
        "https://picsum.photos/30/30?random=14&keyword=profile",
      ],
    },
    {
      "id": 3,
      "title": "Community Garden Project - Looking for Volunteers!",
      "author": "GreenThumb2024",
      "authorAvatar": "https://picsum.photos/40/40?random=3&keyword=profile",
      "category": "Community",
      "time": "6 hours ago",
      "replies": 28,
      "views": 156,
      "isHot": true,
      "isPinned": false,
      "lastActivity": "30 minutes ago",
      "preview": "We're starting a community garden project in the park and we need volunteers to help with planning, planting, and maintenance...",
      "participants": [
        "https://picsum.photos/30/30?random=15&keyword=profile",
        "https://picsum.photos/30/30?random=16&keyword=profile",
        "https://picsum.photos/30/30?random=17&keyword=profile",
        "https://picsum.photos/30/30?random=18&keyword=profile",
      ],
    },
    {
      "id": 4,
      "title": "School Board Election Candidates - Let's Discuss",
      "author": "ConcernedParent",
      "authorAvatar": "https://picsum.photos/40/40?random=4&keyword=profile",
      "category": "Education",
      "time": "8 hours ago",
      "replies": 54,
      "views": 432,
      "isHot": true,
      "isPinned": false,
      "lastActivity": "15 minutes ago",
      "preview": "With the upcoming school board elections, I think it's important we discuss the candidates and their positions on key issues affecting our children's education...",
      "participants": [
        "https://picsum.photos/30/30?random=19&keyword=profile",
        "https://picsum.photos/30/30?random=20&keyword=profile",
        "https://picsum.photos/30/30?random=21&keyword=profile",
      ],
    },
    {
      "id": 5,
      "title": "Environmental Impact of New Development Project",
      "author": "EcoAdvocate",
      "authorAvatar": "https://picsum.photos/40/40?random=5&keyword=profile",
      "category": "Environment",
      "time": "1 day ago",
      "replies": 41,
      "views": 287,
      "isHot": false,
      "isPinned": false,
      "lastActivity": "2 hours ago",
      "preview": "The proposed shopping center development on the east side of town could have significant environmental impacts. Let's discuss the pros and cons...",
      "participants": [
        "https://picsum.photos/30/30?random=22&keyword=profile",
        "https://picsum.photos/30/30?random=23&keyword=profile",
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredDiscussions {
    var filtered = discussions.where((discussion) {
      bool matchesSearch = searchQuery.isEmpty ||
          (discussion["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (discussion["preview"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || discussion["category"] == selectedCategory;
      
      return matchesSearch && matchesCategory;
    }).toList();

    // Sort discussions
    switch (selectedSortBy) {
      case "Most Popular":
        filtered.sort((a, b) => (b["views"] as int).compareTo(a["views"] as int));
        break;
      case "Most Replies":
        filtered.sort((a, b) => (b["replies"] as int).compareTo(a["replies"] as int));
        break;
      case "Trending":
        filtered.sort((a, b) {
          int aScore = (a["replies"] as int) + ((a["views"] as int) ~/ 10);
          int bScore = (b["replies"] as int) + ((b["views"] as int) ~/ 10);
          return bScore.compareTo(aScore);
        });
        break;
      default: // Latest
        filtered.sort((a, b) => a["id"].compareTo(b["id"]));
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discussions"),
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
                        label: "Search discussions...",
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
                SizedBox(height: spSm),
                
                // Category filter
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

          // Stats bar
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
                  "${filteredDiscussions.length} discussions",
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
                      "1.2K active members",
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

          // Discussions list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: filteredDiscussions.length,
              itemBuilder: (context, index) {
                final discussion = filteredDiscussions[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  child: _buildDiscussionCard(discussion),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create discussion
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildDiscussionCard(Map<String, dynamic> discussion) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: discussion["isPinned"] as bool
            ? Border.all(color: warningColor, width: 1)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with badges
          Row(
            children: [
              if (discussion["isPinned"] as bool)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(100),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.push_pin,
                        size: 12,
                        color: warningColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Pinned",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              if (discussion["isHot"] as bool) ...[
                if (discussion["isPinned"] as bool) SizedBox(width: spXs),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(100),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.local_fire_department,
                        size: 12,
                        color: dangerColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Hot",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(100),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${discussion["category"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),

          // Title
          Text(
            "${discussion["title"]}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
              height: 1.3,
            ),
          ),
          SizedBox(height: spXs),

          // Preview
          Text(
            "${discussion["preview"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: spSm),

          // Author and time
          Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundImage: NetworkImage("${discussion["authorAvatar"]}"),
              ),
              SizedBox(width: spXs),
              Text(
                "${discussion["author"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spXs),
              Text(
                "•",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spXs),
              Text(
                "${discussion["time"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              if ((discussion["participants"] as List).isNotEmpty)
                Container(
                  width: ((discussion["participants"] as List).length > 3 ? 3 : (discussion["participants"] as List).length) * 15.0 + 10,
                  height: 20,
                  child: Stack(
                    children: [
                      for (int i = 0; i < ((discussion["participants"] as List).length > 3 ? 3 : (discussion["participants"] as List).length); i++)
                        Positioned(
                          left: (i * 15).toDouble(),
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 8,
                              backgroundImage: NetworkImage("${(discussion["participants"] as List)[i]}"),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(height: spSm),

          // Stats
          Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 16,
                    color: disabledBoldColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${discussion["replies"]} replies",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              SizedBox(width: spMd),
              Row(
                children: [
                  Icon(
                    Icons.visibility,
                    size: 16,
                    color: disabledBoldColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${discussion["views"]} views",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Text(
                "Last: ${discussion["lastActivity"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
