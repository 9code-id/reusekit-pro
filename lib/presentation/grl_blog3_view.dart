import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBlog3View extends StatefulWidget {
  @override
  State<GrlBlog3View> createState() => _GrlBlog3ViewState();
}

class _GrlBlog3ViewState extends State<GrlBlog3View> {
  String selectedCategory = "All";
  String searchQuery = "";
  bool showBookmarked = false;
  String sortBy = "latest";

  List<Map<String, dynamic>> blogPosts = [
    {
      "id": 1,
      "title": "The Future of Artificial Intelligence in Healthcare",
      "excerpt": "Exploring how AI is revolutionizing medical diagnosis, treatment planning, and patient care in modern healthcare systems.",
      "content": "Long form content about AI in healthcare...",
      "author": {
        "name": "Dr. Sarah Chen",
        "avatar": "https://picsum.photos/40/40?random=1&keyword=doctor",
        "bio": "AI Healthcare Researcher",
        "followers": 15420,
        "isVerified": true
      },
      "category": "Technology",
      "tags": ["AI", "Healthcare", "Innovation", "Future"],
      "publishedAt": DateTime.now().subtract(Duration(hours: 2)),
      "readTime": 8,
      "likes": 342,
      "comments": 89,
      "shares": 156,
      "bookmarks": 278,
      "isBookmarked": false,
      "isLiked": false,
      "featured": true,
      "image": "https://picsum.photos/400/220?random=1&keyword=healthcare",
      "views": 12540
    },
    {
      "id": 2,
      "title": "Sustainable Living: Small Changes, Big Impact",
      "excerpt": "Discover practical ways to reduce your environmental footprint through simple daily habits and conscious choices.",
      "content": "Content about sustainable living practices...",
      "author": {
        "name": "Emma Rodriguez",
        "avatar": "https://picsum.photos/40/40?random=2&keyword=woman",
        "bio": "Environmental Advocate",
        "followers": 8750,
        "isVerified": false
      },
      "category": "Lifestyle",
      "tags": ["Sustainability", "Environment", "Green Living"],
      "publishedAt": DateTime.now().subtract(Duration(hours: 6)),
      "readTime": 5,
      "likes": 198,
      "comments": 45,
      "shares": 87,
      "bookmarks": 156,
      "isBookmarked": true,
      "isLiked": true,
      "featured": false,
      "image": "https://picsum.photos/400/220?random=2&keyword=nature",
      "views": 6780
    },
    {
      "id": 3,
      "title": "Mastering Remote Work: Productivity Tips for 2024",
      "excerpt": "Essential strategies and tools to maximize productivity while working from home in the modern digital workspace.",
      "content": "Remote work productivity strategies...",
      "author": {
        "name": "Marcus Johnson",
        "avatar": "https://picsum.photos/40/40?random=3&keyword=man",
        "bio": "Productivity Coach",
        "followers": 12300,
        "isVerified": true
      },
      "category": "Business",
      "tags": ["Remote Work", "Productivity", "Business", "2024"],
      "publishedAt": DateTime.now().subtract(Duration(days: 1)),
      "readTime": 6,
      "likes": 275,
      "comments": 67,
      "shares": 134,
      "bookmarks": 203,
      "isBookmarked": false,
      "isLiked": false,
      "featured": true,
      "image": "https://picsum.photos/400/220?random=3&keyword=office",
      "views": 9840
    },
    {
      "id": 4,
      "title": "The Art of Digital Minimalism",
      "excerpt": "How to reclaim your focus and reduce digital overwhelm in an increasingly connected world.",
      "content": "Digital minimalism strategies and tips...",
      "author": {
        "name": "Lily Zhang",
        "avatar": "https://picsum.photos/40/40?random=4&keyword=asian",
        "bio": "Digital Wellness Expert",
        "followers": 7890,
        "isVerified": false
      },
      "category": "Lifestyle",
      "tags": ["Digital Detox", "Minimalism", "Wellness", "Focus"],
      "publishedAt": DateTime.now().subtract(Duration(days: 2)),
      "readTime": 7,
      "likes": 167,
      "comments": 34,
      "shares": 89,
      "bookmarks": 145,
      "isBookmarked": true,
      "isLiked": false,
      "featured": false,
      "image": "https://picsum.photos/400/220?random=4&keyword=minimal",
      "views": 5620
    },
    {
      "id": 5,
      "title": "Blockchain Beyond Cryptocurrency",
      "excerpt": "exploring real-world applications of blockchain technology in supply chain, healthcare, and identity management.",
      "content": "Blockchain applications beyond crypto...",
      "author": {
        "name": "Alex Thompson",
        "avatar": "https://picsum.photos/40/40?random=5&keyword=tech",
        "bio": "Blockchain Developer",
        "followers": 18650,
        "isVerified": true
      },
      "category": "Technology",
      "tags": ["Blockchain", "Innovation", "Web3", "Future"],
      "publishedAt": DateTime.now().subtract(Duration(days: 3)),
      "readTime": 9,
      "likes": 423,
      "comments": 112,
      "shares": 278,
      "bookmarks": 356,
      "isBookmarked": false,
      "isLiked": true,
      "featured": true,
      "image": "https://picsum.photos/400/220?random=5&keyword=blockchain",
      "views": 18750
    },
    {
      "id": 6,
      "title": "Mental Health in the Digital Age",
      "excerpt": "Understanding the impact of social media and technology on mental wellbeing and strategies for digital wellness.",
      "content": "Mental health and digital wellness...",
      "author": {
        "name": "Dr. Rachel Williams",
        "avatar": "https://picsum.photos/40/40?random=6&keyword=therapist",
        "bio": "Clinical Psychologist",
        "followers": 23400,
        "isVerified": true
      },
      "category": "Health",
      "tags": ["Mental Health", "Digital Wellness", "Psychology"],
      "publishedAt": DateTime.now().subtract(Duration(days: 4)),
      "readTime": 10,
      "likes": 567,
      "comments": 189,
      "shares": 345,
      "bookmarks": 478,
      "isBookmarked": true,
      "isLiked": true,
      "featured": false,
      "image": "https://picsum.photos/400/220?random=6&keyword=mental",
      "views": 25670
    }
  ];

  List<Map<String, dynamic>> categories = [
    {"name": "All", "count": 125, "icon": Icons.dashboard},
    {"name": "Technology", "count": 45, "icon": Icons.computer},
    {"name": "Lifestyle", "count": 32, "icon": Icons.favorite},
    {"name": "Business", "count": 28, "icon": Icons.business},
    {"name": "Health", "count": 20, "icon": Icons.health_and_safety}
  ];

  List<Map<String, dynamic>> featuredAuthors = [
    {
      "name": "Dr. Sarah Chen",
      "avatar": "https://picsum.photos/60/60?random=7&keyword=doctor",
      "bio": "AI Healthcare Researcher",
      "followers": 15420,
      "posts": 48,
      "expertise": "Healthcare AI",
      "isFollowing": false
    },
    {
      "name": "Alex Thompson",
      "avatar": "https://picsum.photos/60/60?random=8&keyword=tech",
      "bio": "Blockchain Developer",
      "followers": 18650,
      "posts": 62,
      "expertise": "Web3 Technology",
      "isFollowing": true
    },
    {
      "name": "Dr. Rachel Williams",
      "avatar": "https://picsum.photos/60/60?random=9&keyword=therapist",
      "bio": "Clinical Psychologist",
      "followers": 23400,
      "posts": 75,
      "expertise": "Mental Health",
      "isFollowing": false
    }
  ];

  List<Map<String, dynamic>> get filteredPosts {
    List<Map<String, dynamic>> filtered = blogPosts;

    if (showBookmarked) {
      filtered = filtered.where((post) => post["isBookmarked"] == true).toList();
    }

    if (selectedCategory != "All") {
      filtered = filtered.where((post) => post["category"] == selectedCategory).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((post) {
        return post["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               post["excerpt"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               (post["tags"] as List).any((tag) => tag.toString().toLowerCase().contains(searchQuery.toLowerCase()));
      }).toList();
    }

    // Sort posts
    switch (sortBy) {
      case "popular":
        filtered.sort((a, b) => (b["likes"] as int).compareTo(a["likes"] as int));
        break;
      case "views":
        filtered.sort((a, b) => (b["views"] as int).compareTo(a["views"] as int));
        break;
      case "latest":
      default:
        filtered.sort((a, b) => (b["publishedAt"] as DateTime).compareTo(a["publishedAt"] as DateTime));
        break;
    }

    return filtered;
  }

  void _toggleBookmark(int postId) {
    setState(() {
      int index = blogPosts.indexWhere((post) => post["id"] == postId);
      if (index != -1) {
        blogPosts[index]["isBookmarked"] = !blogPosts[index]["isBookmarked"];
        if (blogPosts[index]["isBookmarked"]) {
          blogPosts[index]["bookmarks"] = (blogPosts[index]["bookmarks"] as int) + 1;
        } else {
          blogPosts[index]["bookmarks"] = (blogPosts[index]["bookmarks"] as int) - 1;
        }
      }
    });
  }

  void _toggleLike(int postId) {
    setState(() {
      int index = blogPosts.indexWhere((post) => post["id"] == postId);
      if (index != -1) {
        blogPosts[index]["isLiked"] = !blogPosts[index]["isLiked"];
        if (blogPosts[index]["isLiked"]) {
          blogPosts[index]["likes"] = (blogPosts[index]["likes"] as int) + 1;
        } else {
          blogPosts[index]["likes"] = (blogPosts[index]["likes"] as int) - 1;
        }
      }
    });
  }

  void _toggleFollow(String authorName) {
    setState(() {
      int index = featuredAuthors.indexWhere((author) => author["name"] == authorName);
      if (index != -1) {
        featuredAuthors[index]["isFollowing"] = !featuredAuthors[index]["isFollowing"];
        if (featuredAuthors[index]["isFollowing"]) {
          featuredAuthors[index]["followers"] = (featuredAuthors[index]["followers"] as int) + 1;
        } else {
          featuredAuthors[index]["followers"] = (featuredAuthors[index]["followers"] as int) - 1;
        }
      }
    });
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: QTextField(
              label: "Search articles, authors, topics...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterRow() {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showBookmarked = !showBookmarked;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      margin: EdgeInsets.only(right: spXs),
                      decoration: BoxDecoration(
                        color: showBookmarked ? primaryColor : Colors.grey[100],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: showBookmarked ? primaryColor : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.bookmark,
                            size: 16,
                            color: showBookmarked ? Colors.white : disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Bookmarked",
                            style: TextStyle(
                              fontSize: 12,
                              color: showBookmarked ? Colors.white : disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ...categories.map((category) {
                    bool isSelected = selectedCategory == category["name"];
                    return GestureDetector(
                      onTap: () {
                        selectedCategory = category["name"];
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        margin: EdgeInsets.only(right: spXs),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              category["icon"],
                              size: 16,
                              color: isSelected ? Colors.white : disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${category["name"]} (${category["count"]})",
                              style: TextStyle(
                                fontSize: 12,
                                color: isSelected ? Colors.white : disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
          SizedBox(width: spSm),
          PopupMenuButton<String>(
            onSelected: (value) {
              sortBy = value;
              setState(() {});
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: "latest", child: Text("Latest First")),
              PopupMenuItem(value: "popular", child: Text("Most Popular")),
              PopupMenuItem(value: "views", child: Text("Most Viewed")),
            ],
            child: Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Icon(
                Icons.sort,
                color: disabledBoldColor,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedAuthors() {
    return Container(
      margin: EdgeInsets.only(bottom: spLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: spSm),
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: warningColor,
                  size: 20,
                ),
                SizedBox(width: spXs),
                Text(
                  "Featured Authors",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          QHorizontalScroll(
            children: featuredAuthors.map((author) {
              return Container(
                width: 200,
                margin: EdgeInsets.only(right: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage("${author["avatar"]}"),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${author["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${author["bio"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: spXs),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              "${(author["followers"] as int).toString()}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Followers",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "${author["posts"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Posts",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: author["isFollowing"] ? "Following" : "Follow",
                        size: bs.sm,
                        color: author["isFollowing"] ? disabledBoldColor : primaryColor,
                        onPressed: () => _toggleFollow(author["name"]),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBlogPostCard(Map<String, dynamic> post) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Featured Badge
          if (post["featured"])
            Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              margin: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star,
                    size: 12,
                    color: Colors.white,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Featured",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          
          // Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
            child: Image.network(
              "${post["image"]}",
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category and Read Time
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${post["category"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.access_time,
                      size: 12,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${post["readTime"]} min read",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Title
                Text(
                  "${post["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                SizedBox(height: spXs),
                
                // Excerpt
                Text(
                  "${post["excerpt"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                
                SizedBox(height: spSm),
                
                // Tags
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (post["tags"] as List).map((tag) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "#$tag",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                
                SizedBox(height: spSm),
                
                // Author Info
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage("${post["author"]["avatar"]}"),
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${post["author"]["name"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              if (post["author"]["isVerified"])
                                Padding(
                                  padding: EdgeInsets.only(left: spXs),
                                  child: Icon(
                                    Icons.verified,
                                    size: 12,
                                    color: successColor,
                                  ),
                                ),
                            ],
                          ),
                          Text(
                            "${(post["publishedAt"] as DateTime).dMMMy}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(child: Text("Share")),
                        PopupMenuItem(child: Text("Report")),
                        PopupMenuItem(child: Text("Not Interested")),
                      ],
                      child: Icon(
                        Icons.more_vert,
                        color: disabledBoldColor,
                        size: 16,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Stats and Actions
                Row(
                  children: [
                    // Views
                    Icon(
                      Icons.visibility,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${(post["views"] as int).toString()}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    
                    SizedBox(width: spSm),
                    
                    // Like Button
                    GestureDetector(
                      onTap: () => _toggleLike(post["id"]),
                      child: Row(
                        children: [
                          Icon(
                            post["isLiked"] ? Icons.favorite : Icons.favorite_border,
                            size: 16,
                            color: post["isLiked"] ? dangerColor : disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${post["likes"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(width: spSm),
                    
                    // Comments
                    Icon(
                      Icons.comment_outlined,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${post["comments"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    
                    Spacer(),
                    
                    // Bookmark Button
                    GestureDetector(
                      onTap: () => _toggleBookmark(post["id"]),
                      child: Icon(
                        post["isBookmarked"] ? Icons.bookmark : Icons.bookmark_border,
                        size: 18,
                        color: post["isBookmarked"] ? primaryColor : disabledBoldColor,
                      ),
                    ),
                    
                    SizedBox(width: spSm),
                    
                    // Share Button
                    Icon(
                      Icons.share,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> displayedPosts = filteredPosts;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Blog Explorer"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            _buildSearchBar(),
            
            // Filter Row
            _buildFilterRow(),
            
            // Featured Authors
            _buildFeaturedAuthors(),
            
            // Results Header
            Row(
              children: [
                Text(
                  "${displayedPosts.length} Articles Found",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                if (searchQuery.isNotEmpty) ...[
                  SizedBox(width: spXs),
                  Text(
                    "for \"$searchQuery\"",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Blog Posts
            if (displayedPosts.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.article_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No articles found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search or filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            else
              ...displayedPosts.map((post) => _buildBlogPostCard(post)).toList(),
            
            // Load More Button
            if (displayedPosts.isNotEmpty)
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: spMd),
                child: QButton(
                  label: "Load More Articles",
                  size: bs.md,
                  onPressed: () {
                    ss("Loading more articles...");
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
