import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPost7View extends StatefulWidget {
  @override
  State<GrlPost7View> createState() => _GrlPost7ViewState();
}

class _GrlPost7ViewState extends State<GrlPost7View> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedFilter = "All";

  List<String> filters = ["All", "Following", "Trending", "Recent", "Saved"];

  List<Map<String, dynamic>> posts = [
    {
      "id": "1",
      "title": "Building Scalable Microservices with Docker",
      "excerpt": "Learn how to architect and deploy microservices using containerization",
      "author": "Michael Chen",
      "avatar": "https://picsum.photos/50/50?random=1&keyword=portrait",
      "image": "https://picsum.photos/400/250?random=1&keyword=technology",
      "category": "Technology",
      "readTime": "12 min read",
      "publishedAt": "2024-03-15T10:30:00Z",
      "likes": 567,
      "comments": 89,
      "views": 2340,
      "isFollowing": false,
      "isLiked": false,
      "isSaved": true,
      "tags": ["docker", "microservices", "devops"]
    },
    {
      "id": "2",
      "title": "The Art of Minimalist Interior Design",
      "excerpt": "Creating beautiful, functional spaces with less clutter and more intention",
      "author": "Sofia Martinez",
      "avatar": "https://picsum.photos/50/50?random=2&keyword=portrait",
      "image": "https://picsum.photos/400/250?random=2&keyword=interior",
      "category": "Design",
      "readTime": "8 min read",
      "publishedAt": "2024-03-14T14:20:00Z",
      "likes": 423,
      "comments": 67,
      "views": 1890,
      "isFollowing": true,
      "isLiked": true,
      "isSaved": false,
      "tags": ["design", "minimalism", "interior"]
    },
    {
      "id": "3",
      "title": "Machine Learning in Healthcare: Current Applications",
      "excerpt": "Exploring how AI is revolutionizing medical diagnosis and treatment",
      "author": "Dr. James Wilson",
      "avatar": "https://picsum.photos/50/50?random=3&keyword=portrait",
      "image": "https://picsum.photos/400/250?random=3&keyword=medical",
      "category": "Health Tech",
      "readTime": "15 min read",
      "publishedAt": "2024-03-13T09:15:00Z",
      "likes": 789,
      "comments": 134,
      "views": 3456,
      "isFollowing": false,
      "isLiked": false,
      "isSaved": true,
      "tags": ["AI", "healthcare", "machine learning"]
    },
    {
      "id": "4",
      "title": "Sustainable Fashion: A Beginner's Guide",
      "excerpt": "How to build an eco-friendly wardrobe without breaking the bank",
      "author": "Emma Thompson",
      "avatar": "https://picsum.photos/50/50?random=4&keyword=portrait",
      "image": "https://picsum.photos/400/250?random=4&keyword=fashion",
      "category": "Lifestyle",
      "readTime": "6 min read",
      "publishedAt": "2024-03-12T16:45:00Z",
      "likes": 234,
      "comments": 45,
      "views": 1234,
      "isFollowing": true,
      "isLiked": true,
      "isSaved": false,
      "tags": ["fashion", "sustainability", "lifestyle"]
    },
    {
      "id": "5",
      "title": "Remote Team Management Best Practices",
      "excerpt": "Strategies for leading distributed teams effectively in the modern workplace",
      "author": "David Kim",
      "avatar": "https://picsum.photos/50/50?random=5&keyword=portrait",
      "image": "https://picsum.photos/400/250?random=5&keyword=business",
      "category": "Business",
      "readTime": "10 min read",
      "publishedAt": "2024-03-11T11:30:00Z",
      "likes": 345,
      "comments": 78,
      "views": 1876,
      "isFollowing": false,
      "isLiked": false,
      "isSaved": false,
      "tags": ["management", "remote work", "leadership"]
    }
  ];

  List<Map<String, dynamic>> trendingTopics = [
    {"name": "AI & Machine Learning", "posts": 1234, "growth": "+15%"},
    {"name": "Sustainable Living", "posts": 876, "growth": "+12%"},
    {"name": "Remote Work", "posts": 654, "growth": "+8%"},
    {"name": "Web Development", "posts": 543, "growth": "+20%"},
    {"name": "Photography", "posts": 432, "growth": "+5%"},
  ];

  List<Map<String, dynamic>> recommendedAuthors = [
    {
      "name": "Sarah Chen",
      "avatar": "https://picsum.photos/50/50?random=10&keyword=portrait",
      "bio": "Tech Writer & AI Researcher",
      "followers": "2.4k",
      "posts": 89,
      "isFollowing": false
    },
    {
      "name": "Marcus Johnson",
      "avatar": "https://picsum.photos/50/50?random=11&keyword=portrait", 
      "bio": "UX Designer & Creative Director",
      "followers": "1.8k",
      "posts": 67,
      "isFollowing": true
    },
    {
      "name": "Lisa Rodriguez",
      "avatar": "https://picsum.photos/50/50?random=12&keyword=portrait",
      "bio": "Entrepreneur & Startup Advisor",
      "followers": "3.1k",
      "posts": 123,
      "isFollowing": false
    },
  ];

  void _toggleLike(int index) {
    setState(() {
      posts[index]["isLiked"] = !(posts[index]["isLiked"] as bool);
      if (posts[index]["isLiked"] as bool) {
        posts[index]["likes"] = (posts[index]["likes"] as int) + 1;
      } else {
        posts[index]["likes"] = (posts[index]["likes"] as int) - 1;
      }
    });
  }

  void _toggleSave(int index) {
    setState(() {
      posts[index]["isSaved"] = !(posts[index]["isSaved"] as bool);
    });
  }

  void _toggleFollow(int index) {
    setState(() {
      posts[index]["isFollowing"] = !(posts[index]["isFollowing"] as bool);
    });
  }

  void _toggleAuthorFollow(int index) {
    setState(() {
      recommendedAuthors[index]["isFollowing"] = !(recommendedAuthors[index]["isFollowing"] as bool);
    });
  }

  List<Map<String, dynamic>> get filteredPosts {
    List<Map<String, dynamic>> filtered = posts;
    
    if (selectedFilter == "Following") {
      filtered = posts.where((post) => post["isFollowing"] as bool).toList();
    } else if (selectedFilter == "Saved") {
      filtered = posts.where((post) => post["isSaved"] as bool).toList();
    } else if (selectedFilter == "Trending") {
      filtered = posts..sort((a, b) => (b["views"] as int).compareTo(a["views"] as int));
    } else if (selectedFilter == "Recent") {
      filtered = posts..sort((a, b) => b["publishedAt"].compareTo(a["publishedAt"]));
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((post) => 
        (post["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (post["excerpt"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (post["author"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }

    return filtered;
  }

  String _formatPublishTime(String publishedAt) {
    final now = DateTime.now();
    final published = DateTime.parse(publishedAt);
    final difference = now.difference(published);

    if (difference.inDays > 0) {
      return "${difference.inDays}d ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours}h ago";
    } else {
      return "${difference.inMinutes}m ago";
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Discover",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Feed", icon: Icon(Icons.home)),
        Tab(text: "Trending", icon: Icon(Icons.trending_up)),
        Tab(text: "Authors", icon: Icon(Icons.people)),
      ],
      tabChildren: [
        _buildFeedTab(),
        _buildTrendingTab(),
        _buildAuthorsTab(),
      ],
    );
  }

  Widget _buildFeedTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
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
                icon: Icons.tune,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spMd),

          // Filter Options
          QCategoryPicker(
            items: filters.map((filter) => {
              "label": filter,
              "value": filter,
            }).toList(),
            value: selectedFilter,
            onChanged: (index, label, value, item) {
              selectedFilter = value;
              setState(() {});
            },
          ),
          SizedBox(height: spLg),

          // Posts List
          ...filteredPosts.map((post) {
            final index = posts.indexOf(post);
            return Container(
              margin: EdgeInsets.only(bottom: spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Author Header
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage("${post["avatar"]}"),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${post["author"]}",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                _formatPublishTime(post["publishedAt"]),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          label: (post["isFollowing"] as bool) ? "Following" : "Follow",
                          size: bs.sm,
                          onPressed: () => _toggleFollow(index),
                        ),
                      ],
                    ),
                  ),

                  // Post Image
                  Image.network(
                    "${post["image"]}",
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),

                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category and Read Time
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(26),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${post["category"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${post["readTime"]}",
                              style: TextStyle(
                                fontSize: 12,
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
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),

                        // Excerpt
                        Text(
                          "${post["excerpt"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: spMd),

                        // Tags
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (post["tags"] as List).map((tag) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(26),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "#$tag",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: successColor,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: spMd),

                        // Engagement Stats
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => _toggleLike(index),
                              child: Row(
                                children: [
                                  Icon(
                                    (post["isLiked"] as bool) ? Icons.favorite : Icons.favorite_border,
                                    size: 20,
                                    color: (post["isLiked"] as bool) ? dangerColor : disabledBoldColor,
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
                            Row(
                              children: [
                                Icon(
                                  Icons.comment_outlined,
                                  size: 20,
                                  color: disabledBoldColor,
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
                            SizedBox(width: spMd),
                            Row(
                              children: [
                                Icon(
                                  Icons.visibility_outlined,
                                  size: 20,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${(post["views"] as int) > 1000 ? '${((post["views"] as int) / 1000).toStringAsFixed(1)}k' : post["views"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () => _toggleSave(index),
                              child: Icon(
                                (post["isSaved"] as bool) ? Icons.bookmark : Icons.bookmark_border,
                                size: 20,
                                color: (post["isSaved"] as bool) ? primaryColor : disabledBoldColor,
                              ),
                            ),
                          ],
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

  Widget _buildTrendingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Trending Topics",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Discover what's popular right now",
            style: TextStyle(
              fontSize: 16,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spLg),

          ...trendingTopics.asMap().entries.map((entry) {
            final index = entry.key;
            final topic = entry.value;
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(26),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Center(
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${topic["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Text(
                              "${topic["posts"]} posts",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(26),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${topic["growth"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.trending_up,
                    color: successColor,
                    size: 24,
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildAuthorsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recommended Authors",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Follow these writers for quality content",
            style: TextStyle(
              fontSize: 16,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spLg),

          ...recommendedAuthors.asMap().entries.map((entry) {
            final index = entry.key;
            final author = entry.value;
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage("${author["avatar"]}"),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${author["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${author["bio"]}",
                          style: TextStyle(
                            fontSize: 13,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Text(
                              "${author["followers"]} followers",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Text(
                              "${author["posts"]} posts",
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
                  QButton(
                    label: (author["isFollowing"] as bool) ? "Following" : "Follow",
                    size: bs.sm,
                    onPressed: () => _toggleAuthorFollow(index),
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
