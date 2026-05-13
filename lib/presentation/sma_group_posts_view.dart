import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaGroupPostsView extends StatefulWidget {
  const SmaGroupPostsView({super.key});

  @override
  State<SmaGroupPostsView> createState() => _SmaGroupPostsViewState();
}

class _SmaGroupPostsViewState extends State<SmaGroupPostsView> {
  String searchQuery = "";
  String selectedFilter = "All";
  String selectedSort = "Newest";
  bool showCreatePost = false;
  String newPostContent = "";
  List<String> newPostImages = [];
  
  List<Map<String, dynamic>> posts = [
    {
      "id": 1,
      "author": "Alex Chen",
      "author_image": "https://picsum.photos/60/60?random=1&keyword=man",
      "author_role": "admin",
      "content": "Just launched our new AI-powered development tool! Check out the demo and let me know what you think. Would love to get feedback from this amazing community! 🚀",
      "timestamp": "2 hours ago",
      "likes": 24,
      "comments": 8,
      "shares": 3,
      "images": ["https://picsum.photos/400/250?random=10&keyword=ai"],
      "is_pinned": true,
      "is_liked": false,
      "is_saved": false,
      "post_type": "announcement",
      "hashtags": ["#AI", "#Demo", "#Innovation"],
    },
    {
      "id": 2,
      "author": "Sarah Johnson",
      "author_image": "https://picsum.photos/60/60?random=2&keyword=woman",
      "author_role": "member",
      "content": "Anyone attending the upcoming TechCrunch conference? Would be great to meet up with fellow group members there! Let me know if you're going 😊",
      "timestamp": "4 hours ago",
      "likes": 12,
      "comments": 15,
      "shares": 1,
      "images": [],
      "is_pinned": false,
      "is_liked": true,
      "is_saved": true,
      "post_type": "discussion",
      "hashtags": ["#TechCrunch", "#Networking", "#Events"],
    },
    {
      "id": 3,
      "author": "Mike Rodriguez",
      "author_image": "https://picsum.photos/60/60?random=3&keyword=man",
      "author_role": "moderator",
      "content": "Weekly reminder: Please keep discussions focused on technology topics. Off-topic posts will be moved to our general chat section. Thanks for keeping our community organized! 📋",
      "timestamp": "1 day ago",
      "likes": 18,
      "comments": 3,
      "shares": 0,
      "images": [],
      "is_pinned": false,
      "is_liked": false,
      "is_saved": false,
      "post_type": "moderation",
      "hashtags": ["#Rules", "#Community"],
    },
    {
      "id": 4,
      "author": "Emma Davis",
      "author_image": "https://picsum.photos/60/60?random=4&keyword=woman",
      "author_role": "member",
      "content": "Just finished reading 'The Lean Startup' - highly recommend it for anyone working on tech projects! Here are my key takeaways and how they apply to our current development practices.",
      "timestamp": "2 days ago",
      "likes": 31,
      "comments": 12,
      "shares": 8,
      "images": ["https://picsum.photos/400/250?random=11&keyword=book"],
      "is_pinned": false,
      "is_liked": true,
      "is_saved": false,
      "post_type": "educational",
      "hashtags": ["#Books", "#Startup", "#Learning"],
    },
    {
      "id": 5,
      "author": "James Wilson",
      "author_image": "https://picsum.photos/60/60?random=5&keyword=man",
      "author_role": "member",
      "content": "Sharing my latest machine learning project - sentiment analysis tool for customer feedback. Open sourced on GitHub! Feel free to contribute or ask questions. 🤖",
      "timestamp": "3 days ago",
      "likes": 45,
      "comments": 22,
      "shares": 15,
      "images": ["https://picsum.photos/400/250?random=12&keyword=code"],
      "is_pinned": false,
      "is_liked": false,
      "is_saved": true,
      "post_type": "project",
      "hashtags": ["#MachineLearning", "#OpenSource", "#GitHub"],
    },
  ];

  List<String> filterOptions = ["All", "Announcements", "Discussions", "Projects", "Educational", "Moderation"];
  List<String> sortOptions = ["Newest", "Oldest", "Most Liked", "Most Commented"];
  
  List<Map<String, dynamic>> get filteredPosts {
    var filtered = posts;
    
    // Search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((post) =>
        (post["content"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (post["author"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (post["hashtags"] as List).any((tag) => 
          (tag as String).toLowerCase().contains(searchQuery.toLowerCase())
        )
      ).toList();
    }
    
    // Type filter
    if (selectedFilter != "All") {
      String filterType = selectedFilter.toLowerCase().replaceAll("s", "");
      filtered = filtered.where((post) =>
        (post["post_type"] as String) == filterType
      ).toList();
    }
    
    // Sort
    switch (selectedSort) {
      case "Newest":
        // Already in newest order
        break;
      case "Oldest":
        filtered = filtered.reversed.toList();
        break;
      case "Most Liked":
        filtered.sort((a, b) => (b["likes"] as int).compareTo(a["likes"] as int));
        break;
      case "Most Commented":
        filtered.sort((a, b) => (b["comments"] as int).compareTo(a["comments"] as int));
        break;
    }
    
    return filtered;
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case "admin":
        return dangerColor;
      case "moderator":
        return warningColor;
      case "member":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPostTypeColor(String postType) {
    switch (postType) {
      case "announcement":
        return dangerColor;
      case "discussion":
        return primaryColor;
      case "project":
        return successColor;
      case "educational":
        return infoColor;
      case "moderation":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  void _likePost(int postId) {
    setState(() {
      final postIndex = posts.indexWhere((post) => post["id"] == postId);
      if (postIndex != -1) {
        posts[postIndex]["is_liked"] = !(posts[postIndex]["is_liked"] as bool);
        if (posts[postIndex]["is_liked"] as bool) {
          posts[postIndex]["likes"] = (posts[postIndex]["likes"] as int) + 1;
        } else {
          posts[postIndex]["likes"] = (posts[postIndex]["likes"] as int) - 1;
        }
      }
    });
  }

  void _savePost(int postId) {
    setState(() {
      final postIndex = posts.indexWhere((post) => post["id"] == postId);
      if (postIndex != -1) {
        posts[postIndex]["is_saved"] = !(posts[postIndex]["is_saved"] as bool);
      }
    });
    
    final post = posts.firstWhere((post) => post["id"] == postId);
    if (post["is_saved"] as bool) {
      ss("Post saved successfully");
    } else {
      si("Post removed from saved");
    }
  }

  void _createPost() {
    if (newPostContent.isNotEmpty) {
      final newPost = {
        "id": posts.length + 1,
        "author": "Current User",
        "author_image": "https://picsum.photos/60/60?random=99&keyword=user",
        "author_role": "member",
        "content": newPostContent,
        "timestamp": "Just now",
        "likes": 0,
        "comments": 0,
        "shares": 0,
        "images": newPostImages,
        "is_pinned": false,
        "is_liked": false,
        "is_saved": false,
        "post_type": "discussion",
        "hashtags": [],
      };
      
      setState(() {
        posts.insert(0, newPost);
        newPostContent = "";
        newPostImages = [];
        showCreatePost = false;
      });
      
      ss("Post created successfully!");
    }
  }

  void _deletePost(int postId) async {
    final confirmed = await confirm("Are you sure you want to delete this post?");
    if (confirmed) {
      setState(() {
        posts.removeWhere((post) => post["id"] == postId);
      });
      ss("Post deleted successfully");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Group Posts"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showCreatePost = true;
              setState(() {});
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'saved':
                  // Show saved posts
                  break;
                case 'my_posts':
                  // Show my posts
                  break;
                case 'reported':
                  // Show reported posts
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'saved',
                child: Row(
                  children: [
                    Icon(Icons.bookmark),
                    SizedBox(width: spXs),
                    Text("Saved Posts"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'my_posts',
                child: Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: spXs),
                    Text("My Posts"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'reported',
                child: Row(
                  children: [
                    Icon(Icons.report, color: dangerColor),
                    SizedBox(width: spXs),
                    Text("Reported Posts"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filters
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                QTextField(
                  label: "Search posts",
                  value: searchQuery,
                  hint: "Search by content, author, or hashtags",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
                
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Filter",
                        items: filterOptions.map((filter) => {
                          "label": filter,
                          "value": filter,
                        }).toList(),
                        value: selectedFilter,
                        onChanged: (value, label) {
                          selectedFilter = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Sort",
                        items: sortOptions.map((sort) => {
                          "label": sort,
                          "value": sort,
                        }).toList(),
                        value: selectedSort,
                        onChanged: (value, label) {
                          selectedSort = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Posts Count
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            child: Row(
              children: [
                Text(
                  "${filteredPosts.length} posts",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                if (posts.where((p) => p["is_pinned"] == true).isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
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
                          "Pinned posts shown first",
                          style: TextStyle(
                            fontSize: 11,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          
          // Posts List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredPosts.length,
              itemBuilder: (context, index) {
                final post = filteredPosts[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: (post["is_pinned"] as bool) 
                        ? Border.all(color: warningColor, width: 2)
                        : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      // Post Header
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundImage: NetworkImage("${post["author_image"]}"),
                          ),
                          SizedBox(width: spSm),
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
                                    SizedBox(width: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: _getRoleColor(post["author_role"] as String).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "${post["author_role"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: _getRoleColor(post["author_role"] as String),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${post["timestamp"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledColor,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: _getPostTypeColor(post["post_type"] as String).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "${post["post_type"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: _getPostTypeColor(post["post_type"] as String),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (post["is_pinned"] as bool)
                            Icon(
                              Icons.push_pin,
                              color: warningColor,
                              size: 20,
                            ),
                          PopupMenuButton<String>(
                            icon: Icon(Icons.more_vert, color: disabledBoldColor, size: 20),
                            onSelected: (value) {
                              final postId = post["id"] as int;
                              switch (value) {
                                case 'save':
                                  _savePost(postId);
                                  break;
                                case 'report':
                                  // Report post
                                  break;
                                case 'delete':
                                  _deletePost(postId);
                                  break;
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'save',
                                child: Row(
                                  children: [
                                    Icon(
                                      (post["is_saved"] as bool) ? Icons.bookmark : Icons.bookmark_border,
                                      color: primaryColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text((post["is_saved"] as bool) ? "Unsave" : "Save Post"),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'report',
                                child: Row(
                                  children: [
                                    Icon(Icons.report, color: dangerColor),
                                    SizedBox(width: spXs),
                                    Text("Report Post"),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    Icon(Icons.delete, color: dangerColor),
                                    SizedBox(width: spXs),
                                    Text("Delete Post"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      // Post Content
                      Text(
                        "${post["content"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          height: 1.4,
                        ),
                      ),
                      
                      // Hashtags
                      if ((post["hashtags"] as List).isNotEmpty)
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (post["hashtags"] as List).map((tag) {
                            return Text(
                              "$tag",
                              style: TextStyle(
                                fontSize: 13,
                                color: infoColor,
                                fontWeight: FontWeight.w600,
                              ),
                            );
                          }).toList(),
                        ),
                      
                      // Post Images
                      if ((post["images"] as List).isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${(post["images"] as List)[0]}",
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      
                      // Post Actions
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => _likePost(post["id"] as int),
                            child: Row(
                              children: [
                                Icon(
                                  (post["is_liked"] as bool) ? Icons.favorite : Icons.favorite_border,
                                  color: (post["is_liked"] as bool) ? dangerColor : disabledBoldColor,
                                  size: 20,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${post["likes"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: spMd),
                          GestureDetector(
                            onTap: () {
                              // Open comments
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.comment_outlined,
                                  color: disabledBoldColor,
                                  size: 20,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${post["comments"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: spMd),
                          GestureDetector(
                            onTap: () {
                              // Share post
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.share_outlined,
                                  color: disabledBoldColor,
                                  size: 20,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${post["shares"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () => _savePost(post["id"] as int),
                            child: Icon(
                              (post["is_saved"] as bool) ? Icons.bookmark : Icons.bookmark_border,
                              color: (post["is_saved"] as bool) ? primaryColor : disabledBoldColor,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      
      // Create Post FAB
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          showCreatePost = true;
          setState(() {});
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      
      // Create Post Modal
      bottomSheet: showCreatePost
          ? Container(
              height: MediaQuery.of(context).size.height * 0.7,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                boxShadow: [shadowLg],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Create New Post",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showCreatePost = false;
                          setState(() {});
                        },
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                  
                  Expanded(
                    child: QMemoField(
                      label: "What's on your mind?",
                      value: newPostContent,
                      hint: "Share your thoughts with the group...",
                      onChanged: (value) {
                        newPostContent = value;
                        setState(() {});
                      },
                    ),
                  ),
                  
                  QMultiImagePicker(
                    label: "Add Images",
                    value: newPostImages,
                    maxImages: 5,
                    hint: "Add photos to your post",
                    onChanged: (value) {
                      newPostImages = value;
                      setState(() {});
                    },
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Cancel",
                          color: secondaryColor,
                          size: bs.md,
                          onPressed: () {
                            showCreatePost = false;
                            newPostContent = "";
                            newPostImages = [];
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Post",
                          icon: Icons.send,
                          size: bs.md,
                          onPressed: _createPost,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20), // For safe area
                ],
              ),
            )
          : null,
    );
  }
}
