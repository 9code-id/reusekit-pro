import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaDiscussionForumView extends StatefulWidget {
  const ElaDiscussionForumView({super.key});

  @override
  State<ElaDiscussionForumView> createState() => _ElaDiscussionForumViewState();
}

class _ElaDiscussionForumViewState extends State<ElaDiscussionForumView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedCategory = "all";

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Categories", "value": "all"},
    {"label": "Mathematics", "value": "mathematics"},
    {"label": "Physics", "value": "physics"},
    {"label": "Chemistry", "value": "chemistry"},
    {"label": "Biology", "value": "biology"},
    {"label": "Computer Science", "value": "computer_science"},
    {"label": "General Discussion", "value": "general"},
  ];

  List<Map<String, dynamic>> discussions = [
    {
      "id": 1,
      "title": "Best strategies for solving complex integrals?",
      "category": "Mathematics",
      "author": "Sarah Johnson",
      "authorAvatar": "https://picsum.photos/40/40?random=1&keyword=student",
      "content": "I've been struggling with some advanced integration techniques. What are your go-to strategies when facing complex integrals?",
      "timestamp": "2024-01-15 10:30:00",
      "replies": 15,
      "views": 89,
      "likes": 23,
      "tags": ["Calculus", "Integration", "Mathematics"],
      "isLiked": false,
      "isPinned": true,
      "lastReply": "2024-01-15 14:20:00",
      "lastReplyBy": "Dr. Michael Chen",
    },
    {
      "id": 2,
      "title": "Understanding quantum mechanics fundamentals",
      "category": "Physics",
      "author": "Alex Rodriguez",
      "authorAvatar": "https://picsum.photos/40/40?random=2&keyword=student",
      "content": "Can someone explain the wave-particle duality in simple terms? I'm having trouble grasping this concept.",
      "timestamp": "2024-01-15 09:15:00",
      "replies": 8,
      "views": 56,
      "likes": 12,
      "tags": ["Quantum Mechanics", "Physics", "Fundamentals"],
      "isLiked": true,
      "isPinned": false,
      "lastReply": "2024-01-15 13:45:00",
      "lastReplyBy": "Prof. Emily Davis",
    },
    {
      "id": 3,
      "title": "Organic chemistry reaction mechanisms",
      "category": "Chemistry",
      "author": "Emma Thompson",
      "authorAvatar": "https://picsum.photos/40/40?random=3&keyword=student",
      "content": "Looking for help with SN1 vs SN2 mechanisms. When should I expect each type of reaction?",
      "timestamp": "2024-01-15 08:45:00",
      "replies": 12,
      "views": 73,
      "likes": 18,
      "tags": ["Organic Chemistry", "Mechanisms", "Reactions"],
      "isLiked": false,
      "isPinned": false,
      "lastReply": "2024-01-15 12:30:00",
      "lastReplyBy": "Dr. Lisa Wilson",
    },
    {
      "id": 4,
      "title": "Data structures vs algorithms - which to master first?",
      "category": "Computer Science",
      "author": "Mike Chen",
      "authorAvatar": "https://picsum.photos/40/40?random=4&keyword=student",
      "content": "I'm new to computer science. Should I focus on understanding data structures before diving into algorithms?",
      "timestamp": "2024-01-15 07:20:00",
      "replies": 20,
      "views": 134,
      "likes": 31,
      "tags": ["Algorithms", "Data Structures", "Learning Path"],
      "isLiked": true,
      "isPinned": false,
      "lastReply": "2024-01-15 15:10:00",
      "lastReplyBy": "Prof. James Rodriguez",
    },
    {
      "id": 5,
      "title": "Cell division process clarification needed",
      "category": "Biology",
      "author": "Lisa Davis",
      "authorAvatar": "https://picsum.photos/40/40?random=5&keyword=student",
      "content": "Can someone break down the differences between mitosis and meiosis? I keep getting confused.",
      "timestamp": "2024-01-14 16:30:00",
      "replies": 6,
      "views": 42,
      "likes": 9,
      "tags": ["Cell Biology", "Mitosis", "Meiosis"],
      "isLiked": false,
      "isPinned": false,
      "lastReply": "2024-01-15 11:20:00",
      "lastReplyBy": "Dr. Anna Martinez",
    },
    {
      "id": 6,
      "title": "Study group etiquette and best practices",
      "category": "General Discussion",
      "author": "David Wilson",
      "authorAvatar": "https://picsum.photos/40/40?random=6&keyword=student",
      "content": "What are some unwritten rules for participating in online study groups effectively?",
      "timestamp": "2024-01-14 14:15:00",
      "replies": 25,
      "views": 156,
      "likes": 42,
      "tags": ["Study Tips", "Group Learning", "Etiquette"],
      "isLiked": true,
      "isPinned": false,
      "lastReply": "2024-01-15 16:45:00",
      "lastReplyBy": "Dr. Sarah Johnson",
    },
  ];

  List<Map<String, dynamic>> get filteredDiscussions {
    return discussions.where((discussion) {
      bool matchesSearch = discussion["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          discussion["content"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "all" || 
          discussion["category"].toString().toLowerCase().replaceAll(" ", "_") == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  List<Map<String, dynamic>> get sortedDiscussions {
    List<Map<String, dynamic>> sorted = List.from(filteredDiscussions);
    
    switch (currentTab) {
      case 0: // Latest
        sorted.sort((a, b) => DateTime.parse(b["timestamp"]).compareTo(DateTime.parse(a["timestamp"])));
        break;
      case 1: // Popular
        sorted.sort((a, b) => (b["likes"] as int).compareTo(a["likes"] as int));
        break;
      case 2: // Most Replied
        sorted.sort((a, b) => (b["replies"] as int).compareTo(a["replies"] as int));
        break;
    }
    
    // Pin pinned discussions to top
    List<Map<String, dynamic>> pinned = sorted.where((d) => d["isPinned"] as bool).toList();
    List<Map<String, dynamic>> regular = sorted.where((d) => !(d["isPinned"] as bool)).toList();
    
    return [...pinned, ...regular];
  }

  void _toggleLike(Map<String, dynamic> discussion) {
    setState(() {
      bool isLiked = discussion["isLiked"] as bool;
      discussion["isLiked"] = !isLiked;
      discussion["likes"] = (discussion["likes"] as int) + (isLiked ? -1 : 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Discussion Forum",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Latest", icon: Icon(Icons.access_time)),
        Tab(text: "Popular", icon: Icon(Icons.trending_up)),
        Tab(text: "Most Replied", icon: Icon(Icons.forum)),
      ],
      tabChildren: [
        // Latest Tab
        _buildDiscussionList(),
        // Popular Tab
        _buildDiscussionList(),
        // Most Replied Tab
        _buildDiscussionList(),
      ],
      onInit: (tabController) {
        // Access to TabController if needed
      },
    );
  }

  Widget _buildDiscussionList() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filter
          Row(
            children: [
              Expanded(
                flex: 2,
                child: QTextField(
                  label: "Search discussions",
                  value: searchQuery,
                  hint: "Search by title or content",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryItems,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Create Discussion Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Start New Discussion",
              icon: Icons.add,
              size: bs.md,
              onPressed: () {
                // navigateTo('CreateDiscussionView')
              },
            ),
          ),

          // Discussions Header
          Row(
            children: [
              Text(
                "Discussions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                "${sortedDiscussions.length} topics",
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),

          // Discussions List
          ...sortedDiscussions.map((discussion) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: discussion["isPinned"] as bool 
                    ? Border.all(color: primaryColor, width: 1)
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  // Header
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage("${discussion["authorAvatar"]}"),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${discussion["author"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (discussion["isPinned"] as bool) ...[
                                  SizedBox(width: spXs),
                                  Icon(
                                    Icons.push_pin,
                                    size: 14,
                                    color: primaryColor,
                                  ),
                                ],
                              ],
                            ),
                            Text(
                              "${DateTime.parse(discussion["timestamp"]).dMMMy}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${discussion["category"]}",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Title
                  GestureDetector(
                    onTap: () {
                      // navigateTo('DiscussionDetailView')
                    },
                    child: Text(
                      "${discussion["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Content Preview
                  Text(
                    "${discussion["content"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Tags
                  Wrap(
                    spacing: spXs,
                    children: (discussion["tags"] as List).map((tag) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: secondaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "$tag",
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: 10,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  // Stats and Actions
                  Row(
                    children: [
                      // Stats
                      Row(
                        children: [
                          Icon(Icons.visibility, size: 16, color: disabledBoldColor),
                          SizedBox(width: 4),
                          Text(
                            "${discussion["views"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Icon(Icons.reply, size: 16, color: disabledBoldColor),
                          SizedBox(width: 4),
                          Text(
                            "${discussion["replies"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      
                      Spacer(),
                      
                      // Like Button
                      GestureDetector(
                        onTap: () => _toggleLike(discussion),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                          decoration: BoxDecoration(
                            color: discussion["isLiked"] as bool 
                                ? primaryColor.withAlpha(20)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                discussion["isLiked"] as bool 
                                    ? Icons.favorite 
                                    : Icons.favorite_border,
                                size: 16,
                                color: discussion["isLiked"] as bool 
                                    ? primaryColor 
                                    : disabledBoldColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${discussion["likes"]}",
                                style: TextStyle(
                                  color: discussion["isLiked"] as bool 
                                      ? primaryColor 
                                      : disabledBoldColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      SizedBox(width: spSm),
                      
                      // Reply Button
                      QButton(
                        label: "Reply",
                        size: bs.sm,
                        onPressed: () {
                          // navigateTo('DiscussionDetailView')
                        },
                      ),
                    ],
                  ),

                  // Last Reply Info
                  if (discussion["lastReply"] != null)
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Last reply by ",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 11,
                            ),
                          ),
                          Text(
                            "${discussion["lastReplyBy"]}",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${DateTime.parse(discussion["lastReply"]).dMMMy}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 11,
                            ),
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
    );
  }
}
