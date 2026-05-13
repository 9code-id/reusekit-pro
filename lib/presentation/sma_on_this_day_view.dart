import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaOnThisDayView extends StatefulWidget {
  const SmaOnThisDayView({super.key});

  @override
  State<SmaOnThisDayView> createState() => _SmaOnThisDayViewState();
}

class _SmaOnThisDayViewState extends State<SmaOnThisDayView> {
  DateTime selectedDate = DateTime.now();
  String selectedFilter = "all";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Memories", "value": "all"},
    {"label": "Photos", "value": "photos"},
    {"label": "Videos", "value": "videos"},
    {"label": "Posts", "value": "posts"},
    {"label": "Events", "value": "events"},
  ];
  
  List<Map<String, dynamic>> memories = [
    {
      "id": "mem_001",
      "type": "post",
      "title": "First day at my new job!",
      "content": "Starting my journey as a software developer at TechCorp. So excited for this new chapter!",
      "date": "2023-06-16",
      "year_ago": 1,
      "media": [
        "https://picsum.photos/300/200?random=1&keyword=office"
      ],
      "likes": 45,
      "comments": 12,
      "user": {
        "name": "John Doe",
        "avatar": "https://picsum.photos/40/40?random=1&keyword=profile"
      }
    },
    {
      "id": "mem_002", 
      "type": "photo",
      "title": "Beach vacation with family",
      "content": "Amazing sunset at Malibu Beach. Perfect end to our summer vacation!",
      "date": "2022-06-16",
      "year_ago": 2,
      "media": [
        "https://picsum.photos/300/400?random=2&keyword=beach",
        "https://picsum.photos/300/400?random=3&keyword=sunset",
        "https://picsum.photos/300/400?random=4&keyword=family"
      ],
      "likes": 89,
      "comments": 23,
      "user": {
        "name": "John Doe",
        "avatar": "https://picsum.photos/40/40?random=1&keyword=profile"
      }
    },
    {
      "id": "mem_003",
      "type": "video",
      "title": "Graduation ceremony",
      "content": "Finally graduated! Thank you to everyone who supported me throughout this journey.",
      "date": "2021-06-16",
      "year_ago": 3,
      "media": [
        "https://picsum.photos/300/200?random=5&keyword=graduation"
      ],
      "duration": "2:34",
      "likes": 156,
      "comments": 34,
      "user": {
        "name": "John Doe",
        "avatar": "https://picsum.photos/40/40?random=1&keyword=profile"
      }
    },
    {
      "id": "mem_004",
      "type": "event",
      "title": "Birthday celebration",
      "content": "Turned 22 today! Had an amazing party with friends and family.",
      "date": "2020-06-16",
      "year_ago": 4,
      "media": [
        "https://picsum.photos/300/300?random=6&keyword=birthday",
        "https://picsum.photos/300/300?random=7&keyword=cake"
      ],
      "likes": 78,
      "comments": 45,
      "user": {
        "name": "John Doe",
        "avatar": "https://picsum.photos/40/40?random=1&keyword=profile"
      }
    },
    {
      "id": "mem_005",
      "type": "post",
      "title": "High school graduation",
      "content": "End of an era, beginning of a new adventure. Ready for college!",
      "date": "2019-06-16",
      "year_ago": 5,
      "media": [
        "https://picsum.photos/300/200?random=8&keyword=school"
      ],
      "likes": 123,
      "comments": 67,
      "user": {
        "name": "John Doe",
        "avatar": "https://picsum.photos/40/40?random=1&keyword=profile"
      }
    },
  ];
  
  List<Map<String, dynamic>> get filteredMemories {
    if (selectedFilter == "all") {
      return memories;
    }
    return memories.where((memory) => memory["type"] == selectedFilter).toList();
  }
  
  void _shareMemory(Map<String, dynamic> memory) {
    ss("Memory shared successfully");
  }
  
  void _createMemoryPost(Map<String, dynamic> memory) {
    si("Creating memory post");
    // Navigate to create post with memory
  }
  
  IconData getMemoryIcon(String type) {
    switch (type) {
      case "photo":
        return Icons.photo;
      case "video":
        return Icons.videocam;
      case "post":
        return Icons.article;
      case "event":
        return Icons.event;
      default:
        return Icons.memory;
    }
  }
  
  Color getMemoryColor(String type) {
    switch (type) {
      case "photo":
        return successColor;
      case "video":
        return infoColor;
      case "post":
        return primaryColor;
      case "event":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("On This Day"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              // Show date picker
              si("Date picker would open");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.history,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "On This Day",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${selectedDate.dMMMy}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (filteredMemories.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "You have ${filteredMemories.length} ${filteredMemories.length == 1 ? 'memory' : 'memories'} from previous years",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
            // Filter Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.filter_list,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Filter Memories",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QCategoryPicker(
                    items: filterOptions,
                    value: selectedFilter,
                    onChanged: (index, label, value, item) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            // Memories List
            if (filteredMemories.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.photo_library_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No memories found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Create some memories to see them here!",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredMemories.map((memory) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      // Memory Header
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                              "${(memory["user"] as Map)["avatar"]}",
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
                                      "${(memory["user"] as Map)["name"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: getMemoryColor(memory["type"] as String).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            getMemoryIcon(memory["type"] as String),
                                            size: 12,
                                            color: getMemoryColor(memory["type"] as String),
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            "${memory["type"]}".toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: getMemoryColor(memory["type"] as String),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${memory["year_ago"]} ${(memory["year_ago"] as int) == 1 ? 'year' : 'years'} ago • ${memory["date"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuButton<String>(
                            icon: Icon(Icons.more_vert, size: 20),
                            onSelected: (value) {
                              if (value == 'share') {
                                _shareMemory(memory);
                              } else if (value == 'repost') {
                                _createMemoryPost(memory);
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'share',
                                child: Row(
                                  children: [
                                    Icon(Icons.share, size: 16),
                                    SizedBox(width: spXs),
                                    Text('Share Memory'),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'repost',
                                child: Row(
                                  children: [
                                    Icon(Icons.repeat, size: 16),
                                    SizedBox(width: spXs),
                                    Text('Create Post'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      // Memory Content
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "${memory["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${memory["content"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                      
                      // Memory Media
                      if ((memory["media"] as List).isNotEmpty)
                        Container(
                          height: (memory["media"] as List).length == 1 ? 200 : 150,
                          child: (memory["media"] as List).length == 1
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(radiusSm),
                                child: Stack(
                                  children: [
                                    Image.network(
                                      "${(memory["media"] as List)[0]}",
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                    if (memory["type"] == "video")
                                      Positioned.fill(
                                        child: Container(
                                          color: Colors.black.withAlpha(100),
                                          child: Center(
                                            child: Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                Icons.play_arrow,
                                                color: primaryColor,
                                                size: 30,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (memory["type"] == "video" && memory["duration"] != null)
                                      Positioned(
                                        bottom: 8,
                                        right: 8,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Colors.black.withAlpha(150),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${memory["duration"]}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              )
                            : QHorizontalScroll(
                                children: (memory["media"] as List).map<Widget>((mediaUrl) {
                                  return Container(
                                    width: 120,
                                    margin: EdgeInsets.only(right: spXs),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(radiusXs),
                                      child: Image.network(
                                        "$mediaUrl",
                                        width: 120,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                        ),
                      
                      // Memory Stats
                      Row(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.favorite,
                                color: dangerColor,
                                size: 16,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${memory["likes"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: spSm),
                          Row(
                            children: [
                              Icon(
                                Icons.comment,
                                color: primaryColor,
                                size: 16,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${memory["comments"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Row(
                            children: [
                              QButton(
                                label: "Share",
                                size: bs.sm,
                                icon: Icons.share,
                                onPressed: () => _shareMemory(memory),
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                label: "Repost",
                                size: bs.sm,
                                icon: Icons.repeat,
                                onPressed: () => _createMemoryPost(memory),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
          ],
        ),
      ),
    );
  }
}
