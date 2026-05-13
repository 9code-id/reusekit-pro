import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaCommunityForumView extends StatefulWidget {
  const HcaCommunityForumView({super.key});

  @override
  State<HcaCommunityForumView> createState() => _HcaCommunityForumViewState();
}

class _HcaCommunityForumViewState extends State<HcaCommunityForumView> {
  String selectedCategory = "All";
  String searchQuery = "";
  String sortBy = "recent";
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "General Health", "value": "general"},
    {"label": "Chronic Conditions", "value": "chronic"},
    {"label": "Mental Health", "value": "mental"},
    {"label": "Nutrition", "value": "nutrition"},
    {"label": "Exercise", "value": "exercise"},
    {"label": "Medications", "value": "medications"},
    {"label": "Support", "value": "support"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Most Recent", "value": "recent"},
    {"label": "Most Popular", "value": "popular"},
    {"label": "Most Replies", "value": "replies"},
    {"label": "Oldest", "value": "oldest"},
  ];

  List<Map<String, dynamic>> forumPosts = [
    {
      "id": 1,
      "title": "Tips for Managing Diabetes at Work",
      "content": "I've been struggling to maintain my blood sugar levels during long work days. Does anyone have practical tips for managing diabetes in an office environment?",
      "author": "Sarah M.",
      "authorAvatar": "https://picsum.photos/50/50?random=1",
      "category": "chronic",
      "tags": ["diabetes", "work", "management"],
      "createdAt": "2024-01-15T10:30:00Z",
      "replies": 12,
      "likes": 23,
      "views": 156,
      "isLiked": false,
      "isBookmarked": true,
      "isPinned": false,
      "lastReply": "2024-01-15T14:20:00Z",
      "lastReplyAuthor": "Dr. Johnson",
      "hasExpertReply": true,
      "solved": false,
    },
    {
      "id": 2,
      "title": "Anxiety Support Group - Weekly Check-in",
      "content": "Welcome to our weekly anxiety support check-in! Share how you're feeling this week and any coping strategies that have helped you.",
      "author": "Community Moderator",
      "authorAvatar": "https://picsum.photos/50/50?random=2",
      "category": "mental",
      "tags": ["anxiety", "support", "weekly"],
      "createdAt": "2024-01-14T09:00:00Z",
      "replies": 28,
      "likes": 45,
      "views": 234,
      "isLiked": true,
      "isBookmarked": false,
      "isPinned": true,
      "lastReply": "2024-01-15T16:45:00Z",
      "lastReplyAuthor": "Mike K.",
      "hasExpertReply": false,
      "solved": false,
    },
    {
      "id": 3,
      "title": "Healthy Meal Prep Ideas for Busy Parents",
      "content": "As a working parent, I'm looking for quick and healthy meal prep ideas that my kids will actually eat. Please share your favorite recipes!",
      "author": "Jennifer L.",
      "authorAvatar": "https://picsum.photos/50/50?random=3",
      "category": "nutrition",
      "tags": ["meal prep", "nutrition", "family"],
      "createdAt": "2024-01-13T15:45:00Z",
      "replies": 19,
      "likes": 38,
      "views": 187,
      "isLiked": false,
      "isBookmarked": false,
      "isPinned": false,
      "lastReply": "2024-01-15T12:30:00Z",
      "lastReplyAuthor": "Chef Maria",
      "hasExpertReply": true,
      "solved": true,
    },
    {
      "id": 4,
      "title": "Starting Exercise After Heart Surgery",
      "content": "I had heart surgery 3 months ago and my doctor cleared me for light exercise. I'm nervous about starting. Any advice from others who've been through this?",
      "author": "Robert H.",
      "authorAvatar": "https://picsum.photos/50/50?random=4",
      "category": "exercise",
      "tags": ["heart", "surgery", "exercise", "recovery"],
      "createdAt": "2024-01-12T11:20:00Z",
      "replies": 15,
      "likes": 32,
      "views": 143,
      "isLiked": true,
      "isBookmarked": true,
      "isPinned": false,
      "lastReply": "2024-01-15T09:15:00Z",
      "lastReplyAuthor": "Dr. Smith",
      "hasExpertReply": true,
      "solved": false,
    },
    {
      "id": 5,
      "title": "Side Effects of New Medication",
      "content": "I started taking a new blood pressure medication last week and I'm experiencing some side effects. Has anyone else had experience with this medication?",
      "author": "Linda T.",
      "authorAvatar": "https://picsum.photos/50/50?random=5",
      "category": "medications",
      "tags": ["medication", "side effects", "blood pressure"],
      "createdAt": "2024-01-11T14:30:00Z",
      "replies": 8,
      "likes": 12,
      "views": 89,
      "isLiked": false,
      "isBookmarked": false,
      "isPinned": false,
      "lastReply": "2024-01-14T16:20:00Z",
      "lastReplyAuthor": "Pharmacist Jane",
      "hasExpertReply": true,
      "solved": true,
    },
    {
      "id": 6,
      "title": "Celebrating Small Wins in Recovery",
      "content": "Today marks 6 months since I started my mental health journey. I wanted to share some small wins and encourage others who might be struggling.",
      "author": "Alex P.",
      "authorAvatar": "https://picsum.photos/50/50?random=6",
      "category": "support",
      "tags": ["recovery", "mental health", "motivation"],
      "createdAt": "2024-01-10T13:15:00Z",
      "replies": 25,
      "likes": 67,
      "views": 298,
      "isLiked": true,
      "isBookmarked": true,
      "isPinned": false,
      "lastReply": "2024-01-15T11:40:00Z",
      "lastReplyAuthor": "Community Support",
      "hasExpertReply": false,
      "solved": false,
    },
  ];

  List<Map<String, dynamic>> get filteredPosts {
    var posts = forumPosts;
    
    if (selectedCategory != "All") {
      posts = posts.where((post) => post["category"] == selectedCategory).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      posts = posts.where((post) => 
        "${post["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${post["content"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        (post["tags"] as List).any((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()))
      ).toList();
    }
    
    // Sort posts
    switch (sortBy) {
      case "popular":
        posts.sort((a, b) => (b["likes"] as int).compareTo(a["likes"] as int));
        break;
      case "replies":
        posts.sort((a, b) => (b["replies"] as int).compareTo(a["replies"] as int));
        break;
      case "oldest":
        posts.sort((a, b) => a["createdAt"].compareTo(b["createdAt"]));
        break;
      default: // recent
        posts.sort((a, b) => b["createdAt"].compareTo(a["createdAt"]));
    }
    
    // Pinned posts first
    posts.sort((a, b) => (b["isPinned"] ? 1 : 0).compareTo(a["isPinned"] ? 1 : 0));
    
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Community Forum"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              // Show bookmarked posts
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Show notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Community Stats
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatCard("Members", "2,543", Icons.people),
                      _buildStatCard("Posts", "8,291", Icons.forum),
                      _buildStatCard("Experts", "127", Icons.verified),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Create New Post",
                      color: Colors.white,
                      size: bs.sm,
                      onPressed: () {
                        _showCreatePostDialog();
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Search and Filter
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search posts...",
                    value: searchQuery,
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
            
            SizedBox(height: spMd),
            
            // Filter Options
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
                SizedBox(width: spMd),
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
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Posts Count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${filteredPosts.length} Posts",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                if (selectedCategory != "All" || searchQuery.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      selectedCategory = "All";
                      searchQuery = "";
                      setState(() {});
                    },
                    child: Text(
                      "Clear Filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: dangerColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Forum Posts
            ...List.generate(filteredPosts.length, (index) {
              final post = filteredPosts[index];
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  border: post["isPinned"] 
                    ? Border.all(color: warningColor.withAlpha(100), width: 2)
                    : null,
                ),
                child: Padding(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Post Header
                      Row(
                        children: [
                          // Author Avatar
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage("${post["authorAvatar"]}"),
                          ),
                          
                          SizedBox(width: spSm),
                          
                          // Author Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${post["author"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    if (post["hasExpertReply"])
                                      Container(
                                        margin: EdgeInsets.only(left: spXs),
                                        child: Icon(
                                          Icons.verified,
                                          size: 16,
                                          color: successColor,
                                        ),
                                      ),
                                  ],
                                ),
                                Text(
                                  _formatTimeAgo(post["createdAt"]),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Post Status Badges
                          if (post["isPinned"])
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: warningColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "Pinned",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          if (post["solved"])
                            Container(
                              margin: EdgeInsets.only(left: spXs),
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "Solved",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Post Title
                      Text(
                        "${post["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Post Content
                      Text(
                        "${post["content"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          height: 1.4,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Tags
                      Wrap(
                        spacing: spXs,
                        children: (post["tags"] as List).map<Widget>((tag) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: _getCategoryColor(post["category"]).withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "#$tag",
                              style: TextStyle(
                                fontSize: 12,
                                color: _getCategoryColor(post["category"]),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Post Stats
                      Row(
                        children: [
                          _buildStatItem(Icons.visibility, "${post["views"]}", "views"),
                          SizedBox(width: spMd),
                          _buildStatItem(Icons.chat_bubble_outline, "${post["replies"]}", "replies"),
                          SizedBox(width: spMd),
                          _buildStatItem(Icons.favorite_border, "${post["likes"]}", "likes"),
                          
                          Spacer(),
                          
                          // Last Reply Info
                          if (post["replies"] > 0)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Last reply by",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${post["lastReplyAuthor"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Discussion",
                              size: bs.sm,
                              onPressed: () {
                                _viewPost(post);
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          GestureDetector(
                            onTap: () {
                              post["isLiked"] = !(post["isLiked"] as bool);
                              if (post["isLiked"]) {
                                post["likes"] = (post["likes"] as int) + 1;
                              } else {
                                post["likes"] = (post["likes"] as int) - 1;
                              }
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: post["isLiked"] ? dangerColor.withAlpha(25) : disabledColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                post["isLiked"] ? Icons.favorite : Icons.favorite_border,
                                size: 20,
                                color: post["isLiked"] ? dangerColor : disabledBoldColor,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          GestureDetector(
                            onTap: () {
                              post["isBookmarked"] = !(post["isBookmarked"] as bool);
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: post["isBookmarked"] ? primaryColor.withAlpha(25) : disabledColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                post["isBookmarked"] ? Icons.bookmark : Icons.bookmark_border,
                                size: 20,
                                color: post["isBookmarked"] ? primaryColor : disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
            
            if (filteredPosts.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXl),
                child: Column(
                  children: [
                    Icon(
                      Icons.forum_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No Posts Found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your search or category filter",
                      textAlign: TextAlign.center,
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

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          size: 24,
          color: Colors.white,
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withAlpha(200),
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: disabledBoldColor,
        ),
        SizedBox(width: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "general":
        return primaryColor;
      case "chronic":
        return dangerColor;
      case "mental":
        return warningColor;
      case "nutrition":
        return successColor;
      case "exercise":
        return infoColor;
      case "medications":
        return secondaryColor;
      case "support":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  String _formatTimeAgo(String dateString) {
    final date = DateTime.parse(dateString);
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 0) {
      return "${difference.inDays}d ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours}h ago";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes}m ago";
    } else {
      return "Just now";
    }
  }

  void _showCreatePostDialog() {
    // Show create post dialog
  }

  void _viewPost(Map<String, dynamic> post) {
    // Navigate to post detail view
  }
}
