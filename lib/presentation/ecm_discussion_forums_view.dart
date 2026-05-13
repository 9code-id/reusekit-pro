import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmDiscussionForumsView extends StatefulWidget {
  const EcmDiscussionForumsView({super.key});

  @override
  State<EcmDiscussionForumsView> createState() => _EcmDiscussionForumsViewState();
}

class _EcmDiscussionForumsViewState extends State<EcmDiscussionForumsView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String sortBy = "Latest";
  bool showPinnedOnly = false;

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "All"},
    {"label": "General Discussion", "value": "General"},
    {"label": "Technical Topics", "value": "Technical"},
    {"label": "Networking", "value": "Networking"},
    {"label": "Career Advice", "value": "Career"},
    {"label": "Industry News", "value": "News"},
    {"label": "Q&A", "value": "QA"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Latest Activity", "value": "Latest"},
    {"label": "Most Popular", "value": "Popular"},
    {"label": "Most Replies", "value": "Replies"},
    {"label": "Newest", "value": "Newest"},
  ];

  List<Map<String, dynamic>> forumTopics = [
    {
      "id": "1",
      "title": "Best Practices for Remote Team Management",
      "content": "What are your top strategies for managing remote teams effectively? I'd love to hear about tools, communication methods, and challenges you've overcome.",
      "category": "General",
      "author": "Sarah Johnson",
      "author_avatar": "https://picsum.photos/100/100?random=1&keyword=person",
      "author_title": "Team Lead",
      "created_date": "2024-01-15T09:00:00Z",
      "last_activity": "2024-01-15T11:30:00Z",
      "replies_count": 24,
      "views_count": 156,
      "likes_count": 18,
      "is_pinned": true,
      "is_solved": false,
      "is_liked": true,
      "is_following": true,
      "tags": ["remote-work", "management", "productivity"]
    },
    {
      "id": "2",
      "title": "AI in Software Development - Future Trends",
      "content": "Discussing the impact of AI tools on software development. How is your team adapting to AI-assisted coding?",
      "category": "Technical",
      "author": "Michael Chen",
      "author_avatar": "https://picsum.photos/100/100?random=2&keyword=person",
      "author_title": "Senior Developer",
      "created_date": "2024-01-15T08:30:00Z",
      "last_activity": "2024-01-15T11:15:00Z",
      "replies_count": 31,
      "views_count": 203,
      "likes_count": 27,
      "is_pinned": false,
      "is_solved": false,
      "is_liked": false,
      "is_following": false,
      "tags": ["ai", "development", "future", "automation"]
    },
    {
      "id": "3",
      "title": "Building Your Professional Network",
      "content": "Tips and strategies for effective networking at conferences and events. What's worked best for you?",
      "category": "Networking",
      "author": "Emily Rodriguez",
      "author_avatar": "https://picsum.photos/100/100?random=3&keyword=person",
      "author_title": "Marketing Manager",
      "created_date": "2024-01-15T07:45:00Z",
      "last_activity": "2024-01-15T10:45:00Z",
      "replies_count": 19,
      "views_count": 89,
      "likes_count": 12,
      "is_pinned": true,
      "is_solved": true,
      "is_liked": true,
      "is_following": true,
      "tags": ["networking", "career", "professional-development"]
    },
    {
      "id": "4",
      "title": "Career Transition from Traditional to Tech",
      "content": "Share your stories about transitioning from non-tech careers to technology roles. What challenges did you face?",
      "category": "Career",
      "author": "David Wilson",
      "author_avatar": "https://picsum.photos/100/100?random=4&keyword=person",
      "author_title": "Product Manager",
      "created_date": "2024-01-14T16:20:00Z",
      "last_activity": "2024-01-15T09:30:00Z",
      "replies_count": 42,
      "views_count": 178,
      "likes_count": 35,
      "is_pinned": false,
      "is_solved": false,
      "is_liked": false,
      "is_following": true,
      "tags": ["career-change", "transition", "tech-industry"]
    },
    {
      "id": "5",
      "title": "Latest Industry Acquisition - Impact Analysis",
      "content": "Thoughts on the recent tech acquisition announced this week? How might this affect the industry landscape?",
      "category": "News",
      "author": "Lisa Park",
      "author_avatar": "https://picsum.photos/100/100?random=5&keyword=person",
      "author_title": "Industry Analyst",
      "created_date": "2024-01-14T14:15:00Z",
      "last_activity": "2024-01-15T08:45:00Z",
      "replies_count": 16,
      "views_count": 124,
      "likes_count": 9,
      "is_pinned": false,
      "is_solved": false,
      "is_liked": true,
      "is_following": false,
      "tags": ["industry-news", "acquisitions", "market-analysis"]
    },
  ];

  List<Map<String, dynamic>> get filteredTopics {
    List<Map<String, dynamic>> filtered = forumTopics;
    
    if (selectedCategory != "All") {
      filtered = filtered.where((topic) => topic["category"] == selectedCategory).toList();
    }
    
    if (showPinnedOnly) {
      filtered = filtered.where((topic) => topic["is_pinned"] == true).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((topic) {
        return topic["title"].toLowerCase().contains(searchQuery.toLowerCase()) ||
               topic["content"].toLowerCase().contains(searchQuery.toLowerCase()) ||
               (topic["tags"] as List).any((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()));
      }).toList();
    }
    
    // Sort topics
    filtered.sort((a, b) {
      switch (sortBy) {
        case "Latest":
          return DateTime.parse(b["last_activity"]).compareTo(DateTime.parse(a["last_activity"]));
        case "Popular":
          return (b["likes_count"] as int).compareTo(a["likes_count"] as int);
        case "Replies":
          return (b["replies_count"] as int).compareTo(a["replies_count"] as int);
        case "Newest":
          return DateTime.parse(b["created_date"]).compareTo(DateTime.parse(a["created_date"]));
        default:
          return DateTime.parse(b["last_activity"]).compareTo(DateTime.parse(a["last_activity"]));
      }
    });
    
    // Pinned topics should always be at the top
    List<Map<String, dynamic>> pinned = filtered.where((topic) => topic["is_pinned"] == true).toList();
    List<Map<String, dynamic>> regular = filtered.where((topic) => topic["is_pinned"] == false).toList();
    
    return [...pinned, ...regular];
  }

  String _formatTime(String timestamp) {
    DateTime time = DateTime.parse(timestamp);
    DateTime now = DateTime.now();
    Duration difference = now.difference(time);
    
    if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else {
      return time.dMMMy;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discussion Forums"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.forum,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Discussion Forums",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Engage in meaningful conversations with the community",
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
            ),

            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search discussions",
                    value: searchQuery,
                    hint: "Search topics, content, or tags",
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
                    items: categoryOptions,
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

            QSwitch(
              items: [
                {
                  "label": "Show Pinned Only",
                  "value": true,
                  "checked": showPinnedOnly,
                }
              ],
              value: [
                if (showPinnedOnly)
                  {
                    "label": "Show Pinned Only",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                showPinnedOnly = values.isNotEmpty;
                setState(() {});
              },
            ),

            Container(
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
                      Icon(
                        Icons.topic,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Forum Topics",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${filteredTopics.length} topics",
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
                  if (filteredTopics.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        children: [
                          Icon(
                            Icons.topic,
                            size: 48,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No discussions found",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Try adjusting your search or filters",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...List.generate(filteredTopics.length, (index) {
                      final topic = filteredTopics[index];
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: topic["is_pinned"] 
                                ? warningColor.withAlpha(5)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: topic["is_pinned"] 
                                  ? warningColor.withAlpha(30)
                                  : disabledOutlineBorderColor,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(radiusSm),
                                      image: DecorationImage(
                                        image: NetworkImage("${topic["author_avatar"]}"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            if (topic["is_pinned"])
                                              Container(
                                                margin: EdgeInsets.only(right: spXs),
                                                padding: EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  color: warningColor,
                                                  borderRadius: BorderRadius.circular(radiusXs),
                                                ),
                                                child: Icon(
                                                  Icons.push_pin,
                                                  size: 10,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            Expanded(
                                              child: Text(
                                                "${topic["title"]}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ),
                                            if (topic["is_solved"])
                                              Container(
                                                padding: EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  color: successColor,
                                                  borderRadius: BorderRadius.circular(radiusXs),
                                                ),
                                                child: Icon(
                                                  Icons.check,
                                                  size: 10,
                                                  color: Colors.white,
                                                ),
                                              ),
                                          ],
                                        ),
                                        Text(
                                          "${topic["author"]} • ${topic["author_title"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        _formatTime(topic["last_activity"]),
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 4,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: primaryColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${topic["category"]}",
                                          style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "${topic["content"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if ((topic["tags"] as List).isNotEmpty) ...[
                                SizedBox(height: spSm),
                                Wrap(
                                  spacing: spXs,
                                  runSpacing: spXs,
                                  children: (topic["tags"] as List).map((tag) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: infoColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "#$tag",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: infoColor,
                                        ),
                                      ),
                                    );
                                  }).toList().cast<Widget>(),
                                ),
                              ],
                              SizedBox(height: spSm),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          topic["is_liked"] ? Icons.favorite : Icons.favorite_border,
                                          size: 16,
                                          color: topic["is_liked"] ? dangerColor : disabledBoldColor,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "${topic["likes_count"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: spMd),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.comment,
                                        size: 16,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${topic["replies_count"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: spMd),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.visibility,
                                        size: 16,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${topic["views_count"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Icon(
                                      topic["is_following"] ? Icons.notifications : Icons.notifications_none,
                                      size: 18,
                                      color: topic["is_following"] ? primaryColor : disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.share,
                                      size: 18,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
