import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaHealthForumsView extends StatefulWidget {
  const MhaHealthForumsView({super.key});

  @override
  State<MhaHealthForumsView> createState() => _MhaHealthForumsViewState();
}

class _MhaHealthForumsViewState extends State<MhaHealthForumsView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String sortBy = "Latest";
  bool showMyPosts = false;

  List<Map<String, dynamic>> forumCategories = [
    {"label": "All", "value": "All", "count": 2847},
    {"label": "General Health", "value": "general", "count": 524},
    {"label": "Mental Health", "value": "mental", "count": 386},
    {"label": "Nutrition", "value": "nutrition", "count": 298},
    {"label": "Fitness", "value": "fitness", "count": 417},
    {"label": "Chronic Conditions", "value": "chronic", "count": 203},
    {"label": "Women's Health", "value": "womens", "count": 156},
    {"label": "Men's Health", "value": "mens", "count": 127},
    {"label": "Pediatrics", "value": "pediatrics", "count": 189},
    {"label": "Senior Health", "value": "senior", "count": 142},
    {"label": "Alternative Medicine", "value": "alternative", "count": 89},
    {"label": "Medical Advice", "value": "advice", "count": 316},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Latest", "value": "latest"},
    {"label": "Most Popular", "value": "popular"},
    {"label": "Most Replies", "value": "replies"},
    {"label": "Oldest", "value": "oldest"},
  ];

  List<Map<String, dynamic>> forumPosts = [
    {
      "id": "1",
      "title": "Managing Diabetes: Daily Routine Tips",
      "content": "I've been managing Type 2 diabetes for 3 years now. Here are some daily routine tips that have helped me maintain stable blood sugar levels...",
      "author": "Sarah Johnson",
      "authorAvatar": "https://picsum.photos/100/100?random=1&keyword=woman",
      "category": "chronic",
      "categoryName": "Chronic Conditions",
      "replies": 23,
      "likes": 89,
      "views": 456,
      "createdAt": "2024-06-13T10:30:00Z",
      "lastReply": "2024-06-14T08:15:00Z",
      "isPinned": true,
      "tags": ["diabetes", "lifestyle", "tips"],
      "hasAnswer": true,
    },
    {
      "id": "2",
      "title": "Anxiety and Sleep Issues - Need Advice",
      "content": "I've been struggling with anxiety for the past few months and it's really affecting my sleep. Has anyone found effective strategies that don't involve medication?",
      "author": "Mike Chen",
      "authorAvatar": "https://picsum.photos/100/100?random=2&keyword=man",
      "category": "mental",
      "categoryName": "Mental Health",
      "replies": 41,
      "likes": 67,
      "views": 523,
      "createdAt": "2024-06-13T14:20:00Z",
      "lastReply": "2024-06-14T09:45:00Z",
      "isPinned": false,
      "tags": ["anxiety", "sleep", "natural remedies"],
      "hasAnswer": false,
    },
    {
      "id": "3",
      "title": "Best Protein Sources for Vegetarians",
      "content": "Recently switched to a vegetarian diet and looking for advice on complete protein sources. What are your go-to protein-rich meals?",
      "author": "Emma Wilson",
      "authorAvatar": "https://picsum.photos/100/100?random=3&keyword=woman",
      "category": "nutrition",
      "categoryName": "Nutrition",
      "replies": 18,
      "likes": 52,
      "views": 334,
      "createdAt": "2024-06-13T09:15:00Z",
      "lastReply": "2024-06-14T07:30:00Z",
      "isPinned": false,
      "tags": ["vegetarian", "protein", "nutrition"],
      "hasAnswer": true,
    },
    {
      "id": "4",
      "title": "Home Workout Routine During Recovery",
      "content": "Recovering from a knee injury and looking for low-impact exercises I can do at home. Physical therapist cleared me for light activity.",
      "author": "David Kumar",
      "authorAvatar": "https://picsum.photos/100/100?random=4&keyword=man",
      "category": "fitness",
      "categoryName": "Fitness",
      "replies": 15,
      "likes": 38,
      "views": 267,
      "createdAt": "2024-06-12T16:45:00Z",
      "lastReply": "2024-06-14T06:20:00Z",
      "isPinned": false,
      "tags": ["recovery", "home workout", "low impact"],
      "hasAnswer": false,
    },
    {
      "id": "5",
      "title": "Postpartum Depression Support",
      "content": "New mom here dealing with postpartum depression. Looking for others who have been through this journey and can share their experiences.",
      "author": "Lisa Rodriguez",
      "authorAvatar": "https://picsum.photos/100/100?random=5&keyword=woman",
      "category": "womens",
      "categoryName": "Women's Health",
      "replies": 28,
      "likes": 94,
      "views": 412,
      "createdAt": "2024-06-12T11:30:00Z",
      "lastReply": "2024-06-14T10:15:00Z",
      "isPinned": false,
      "tags": ["postpartum", "depression", "support"],
      "hasAnswer": true,
    },
    {
      "id": "6",
      "title": "High Blood Pressure Management",
      "content": "Recently diagnosed with hypertension. Doctor recommended lifestyle changes before medication. What changes have worked for you?",
      "author": "Robert Smith",
      "authorAvatar": "https://picsum.photos/100/100?random=6&keyword=man",
      "category": "chronic",
      "categoryName": "Chronic Conditions",
      "replies": 32,
      "likes": 76,
      "views": 398,
      "createdAt": "2024-06-11T15:20:00Z",
      "lastReply": "2024-06-14T09:10:00Z",
      "isPinned": false,
      "tags": ["hypertension", "lifestyle", "prevention"],
      "hasAnswer": true,
    },
  ];

  List<Map<String, dynamic>> trendingTopics = [
    {"name": "Mental Health Awareness", "posts": 145, "growth": "+23%"},
    {"name": "Vaccine Information", "posts": 89, "growth": "+15%"},
    {"name": "Healthy Recipes", "posts": 234, "growth": "+18%"},
    {"name": "Exercise Tips", "posts": 167, "growth": "+12%"},
    {"name": "Sleep Hygiene", "posts": 98, "growth": "+27%"},
  ];

  List<Map<String, dynamic>> featuredExperts = [
    {
      "name": "Dr. Jennifer Adams",
      "specialty": "Cardiologist",
      "avatar": "https://picsum.photos/80/80?random=20&keyword=doctor",
      "posts": 34,
      "followers": 1205,
    },
    {
      "name": "Dr. Michael Brown",
      "specialty": "Nutritionist",
      "avatar": "https://picsum.photos/80/80?random=21&keyword=doctor",
      "posts": 28,
      "followers": 892,
    },
    {
      "name": "Dr. Sarah Wilson",
      "specialty": "Mental Health",
      "avatar": "https://picsum.photos/80/80?random=22&keyword=doctor",
      "posts": 41,
      "followers": 1567,
    },
  ];

  List<Map<String, dynamic>> get filteredPosts {
    return forumPosts.where((post) {
      bool matchesSearch = searchQuery.isEmpty ||
          (post["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (post["content"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || post["category"] == selectedCategory;
      
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health Forums"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showCreatePostDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and Filters
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: QTextField(
                    label: "Search forums...",
                    value: searchQuery,
                    hint: "Search topics, posts, or users",
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
                    items: forumCategories,
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

            // Filter Options
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Sort by",
                    items: sortOptions,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "My Posts Only",
                        "value": true,
                        "checked": showMyPosts,
                      }
                    ],
                    value: [if (showMyPosts) {"label": "My Posts Only", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      showMyPosts = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Trending Topics
            Text(
              "Trending Topics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            QHorizontalScroll(
              children: trendingTopics.map((topic) {
                return Container(
                  width: 160,
                  margin: EdgeInsets.only(right: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${topic["name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${topic["posts"]} posts",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${topic["growth"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spLg),

            // Featured Experts
            Text(
              "Featured Experts",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            QHorizontalScroll(
              children: featuredExperts.map((expert) {
                return Container(
                  width: 140,
                  margin: EdgeInsets.only(right: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage("${expert["avatar"]}"),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${expert["name"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2),
                      Text(
                        "${expert["specialty"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: spXs),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "${expert["posts"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Posts",
                                style: TextStyle(
                                  fontSize: 8,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "${expert["followers"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Followers",
                                style: TextStyle(
                                  fontSize: 8,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spLg),

            // Forum Posts
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Discussions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${filteredPosts.length} posts",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),

            // Posts List
            ...filteredPosts.map((post) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: (post["isPinned"] as bool) ? Border.all(color: warningColor, width: 1) : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Post Header
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage("${post["authorAvatar"]}"),
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${post["author"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${post["categoryName"]} • ${DateTime.parse(post["createdAt"] as String).dMMMy}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (post["isPinned"] as bool)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.push_pin,
                                  size: 10,
                                  color: warningColor,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "Pinned",
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: warningColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (post["hasAnswer"] as bool)
                          Container(
                            margin: EdgeInsets.only(left: spXs),
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 10,
                                  color: successColor,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "Answered",
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Post Title
                    Text(
                      "${post["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),

                    // Post Content Preview
                    Text(
                      "${post["content"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: spSm),

                    // Tags
                    Wrap(
                      spacing: spXs,
                      children: (post["tags"] as List).map((tag) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "#$tag",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: spSm),

                    // Post Stats
                    Row(
                      children: [
                        Icon(
                          Icons.thumb_up_outlined,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${post["likes"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          Icons.comment_outlined,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${post["replies"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          Icons.visibility_outlined,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${post["views"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Last reply ${DateTime.parse(post["lastReply"] as String).dMMMy}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            SizedBox(height: spLg),

            // Load More Button
            Center(
              child: QButton(
                label: "Load More Posts",
                size: bs.md,
                onPressed: () {
                  ss("Loading more posts...");
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreatePostDialog();
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showCreatePostDialog() {
    String postTitle = "";
    String postContent = "";
    String postCategory = "general";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create New Post"),
        content: StatefulBuilder(
          builder: (context, setDialogState) => Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                QTextField(
                  label: "Post Title",
                  value: postTitle,
                  hint: "Enter an engaging title",
                  onChanged: (value) {
                    postTitle = value;
                    setDialogState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QDropdownField(
                  label: "Category",
                  items: forumCategories.where((cat) => cat["value"] != "All").toList(),
                  value: postCategory,
                  onChanged: (value, label) {
                    postCategory = value;
                    setDialogState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QMemoField(
                  label: "Post Content",
                  value: postContent,
                  hint: "Share your thoughts, questions, or experiences...",
                  onChanged: (value) {
                    postContent = value;
                    setDialogState(() {});
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Post",
            size: bs.sm,
            onPressed: () {
              if (postTitle.isNotEmpty && postContent.isNotEmpty) {
                Navigator.pop(context);
                ss("Post created successfully!");
              } else {
                se("Please fill in all required fields");
              }
            },
          ),
        ],
      ),
    );
  }
}
