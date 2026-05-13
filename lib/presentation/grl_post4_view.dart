import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPost4View extends StatefulWidget {
  @override
  State<GrlPost4View> createState() => _GrlPost4ViewState();
}

class _GrlPost4ViewState extends State<GrlPost4View> {
  String searchQuery = "";
  String selectedCategory = "All";
  bool showLiked = false;
  bool showSaved = false;

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Design", "value": "Design"},
    {"label": "Business", "value": "Business"},
    {"label": "Health", "value": "Health"},
    {"label": "Lifestyle", "value": "Lifestyle"},
  ];

  List<Map<String, dynamic>> posts = [
    {
      "id": 1,
      "title": "The Future of Web Development",
      "excerpt": "Exploring the latest trends and technologies shaping the future of web development in 2025.",
      "author": "Sarah Johnson",
      "authorAvatar": "https://picsum.photos/100/100?random=1&keyword=portrait",
      "category": "Technology",
      "readTime": 8,
      "publishedAt": "2025-06-20",
      "image": "https://picsum.photos/400/250?random=1&keyword=technology",
      "likes": 245,
      "comments": 32,
      "isLiked": false,
      "isSaved": false,
      "tags": ["React", "Next.js", "Web3"]
    },
    {
      "id": 2,
      "title": "Minimalist Design Principles",
      "excerpt": "Learn how to create beautiful, functional designs with minimalist principles that focus on clarity and purpose.",
      "author": "Michael Chen",
      "authorAvatar": "https://picsum.photos/100/100?random=2&keyword=portrait",
      "category": "Design",
      "readTime": 6,
      "publishedAt": "2025-06-19",
      "image": "https://picsum.photos/400/250?random=2&keyword=design",
      "likes": 189,
      "comments": 24,
      "isLiked": true,
      "isSaved": false,
      "tags": ["UI/UX", "Minimalism", "Design"]
    },
    {
      "id": 3,
      "title": "Building a Successful Startup",
      "excerpt": "Key strategies and insights for entrepreneurs looking to build and scale successful technology startups.",
      "author": "Emma Davis",
      "authorAvatar": "https://picsum.photos/100/100?random=3&keyword=portrait",
      "category": "Business",
      "readTime": 12,
      "publishedAt": "2025-06-18",
      "image": "https://picsum.photos/400/250?random=3&keyword=business",
      "likes": 302,
      "comments": 45,
      "isLiked": false,
      "isSaved": true,
      "tags": ["Startup", "Entrepreneurship", "Business"]
    },
    {
      "id": 4,
      "title": "Mental Health in Tech",
      "excerpt": "Addressing mental health challenges in the technology industry and promoting workplace wellness.",
      "author": "Dr. James Wilson",
      "authorAvatar": "https://picsum.photos/100/100?random=4&keyword=portrait",
      "category": "Health",
      "readTime": 10,
      "publishedAt": "2025-06-17",
      "image": "https://picsum.photos/400/250?random=4&keyword=health",
      "likes": 156,
      "comments": 28,
      "isLiked": true,
      "isSaved": true,
      "tags": ["Mental Health", "Wellness", "Tech Industry"]
    },
    {
      "id": 5,
      "title": "Remote Work Best Practices",
      "excerpt": "Tips and strategies for maintaining productivity and work-life balance while working remotely.",
      "author": "Lisa Rodriguez",
      "authorAvatar": "https://picsum.photos/100/100?random=5&keyword=portrait",
      "category": "Lifestyle",
      "readTime": 7,
      "publishedAt": "2025-06-16",
      "image": "https://picsum.photos/400/250?random=5&keyword=remote",
      "likes": 198,
      "comments": 35,
      "isLiked": false,
      "isSaved": false,
      "tags": ["Remote Work", "Productivity", "Lifestyle"]
    },
    {
      "id": 6,
      "title": "AI and Machine Learning Trends",
      "excerpt": "Latest developments in artificial intelligence and machine learning that are transforming industries.",
      "author": "David Kim",
      "authorAvatar": "https://picsum.photos/100/100?random=6&keyword=portrait",
      "category": "Technology",
      "readTime": 15,
      "publishedAt": "2025-06-15",
      "image": "https://picsum.photos/400/250?random=6&keyword=ai",
      "likes": 421,
      "comments": 67,
      "isLiked": true,
      "isSaved": false,
      "tags": ["AI", "Machine Learning", "Technology"]
    },
  ];

  List<Map<String, dynamic>> get filteredPosts {
    return posts.where((post) {
      bool matchesSearch = searchQuery.isEmpty ||
          (post["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (post["excerpt"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || post["category"] == selectedCategory;
      
      bool matchesLiked = !showLiked || (post["isLiked"] as bool);
      bool matchesSaved = !showSaved || (post["isSaved"] as bool);
      
      return matchesSearch && matchesCategory && matchesLiked && matchesSaved;
    }).toList();
  }

  void _toggleLike(int postId) {
    int index = posts.indexWhere((post) => post["id"] == postId);
    if (index != -1) {
      posts[index]["isLiked"] = !(posts[index]["isLiked"] as bool);
      if (posts[index]["isLiked"] as bool) {
        posts[index]["likes"] = (posts[index]["likes"] as int) + 1;
      } else {
        posts[index]["likes"] = (posts[index]["likes"] as int) - 1;
      }
      setState(() {});
    }
  }

  void _toggleSave(int postId) {
    int index = posts.indexWhere((post) => post["id"] == postId);
    if (index != -1) {
      posts[index]["isSaved"] = !(posts[index]["isSaved"] as bool);
      setState(() {});
    }
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
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
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
            child: Image.network(
              "${post["image"]}",
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${post["category"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${(post["readTime"] as int)} min read",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "${post["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "${post["excerpt"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    height: 1.5,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage("${post["authorAvatar"]}"),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${post["author"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${post["publishedAt"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => _toggleLike(post["id"] as int),
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            child: Row(
                              children: [
                                Icon(
                                  (post["isLiked"] as bool) ? Icons.favorite : Icons.favorite_border,
                                  size: 18,
                                  color: (post["isLiked"] as bool) ? dangerColor : disabledBoldColor,
                                ),
                                SizedBox(width: 4),
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
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.all(spXs),
                          child: Row(
                            children: [
                              Icon(
                                Icons.comment_outlined,
                                size: 18,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${post["comments"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),
                        GestureDetector(
                          onTap: () => _toggleSave(post["id"] as int),
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            child: Icon(
                              (post["isSaved"] as bool) ? Icons.bookmark : Icons.bookmark_border,
                              size: 18,
                              color: (post["isSaved"] as bool) ? warningColor : disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Wrap(
                  spacing: spXs,
                  children: (post["tags"] as List<String>).map((tag) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "#$tag",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    );
                  }).toList(),
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Discover Posts"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search posts...",
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
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: () {
                    _showFilterBottomSheet();
                  },
                ),
              ],
            ),
            SizedBox(height: spMd),
            QCategoryPicker(
              label: "Categories",
              items: categories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Text(
                  "Posts",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredPosts.length} found",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            if (filteredPosts.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.article_outlined,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No posts found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
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
              Column(
                children: filteredPosts.map((post) => _buildPostCard(post)).toList(),
              ),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Filter Posts",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Clear",
                        size: bs.sm,
                        onPressed: () {
                          showLiked = false;
                          showSaved = false;
                          setModalState(() {});
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  QSwitch(
                    items: [
                      {
                        "label": "Show only liked posts",
                        "value": "liked",
                        "checked": showLiked,
                      }
                    ],
                    value: showLiked ? [{"label": "Show only liked posts", "value": "liked", "checked": true}] : [],
                    onChanged: (values, ids) {
                      showLiked = values.isNotEmpty;
                      setModalState(() {});
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QSwitch(
                    items: [
                      {
                        "label": "Show only saved posts",
                        "value": "saved",
                        "checked": showSaved,
                      }
                    ],
                    value: showSaved ? [{"label": "Show only saved posts", "value": "saved", "checked": true}] : [],
                    onChanged: (values, ids) {
                      showSaved = values.isNotEmpty;
                      setModalState(() {});
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Cancel",
                          size: bs.sm,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Apply",
                          size: bs.sm,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
