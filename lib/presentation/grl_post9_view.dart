import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPost9View extends StatefulWidget {
  @override
  State<GrlPost9View> createState() => _GrlPost9ViewState();
}

class _GrlPost9ViewState extends State<GrlPost9View> {
  String searchQuery = "";
  String selectedCategory = "All";
  String sortBy = "Recent";

  List<String> categories = ["All", "Technology", "Design", "Business", "Lifestyle", "Health"];
  List<String> sortOptions = ["Recent", "Popular", "Most Liked", "Most Commented"];

  List<Map<String, dynamic>> bookmarkedPosts = [
    {
      "id": "1",
      "title": "Advanced Flutter State Management Techniques",
      "excerpt": "Deep dive into Provider, Bloc, and Riverpod for scalable app architecture",
      "author": "Michael Chen",
      "avatar": "https://picsum.photos/50/50?random=1&keyword=portrait",
      "image": "https://picsum.photos/400/250?random=1&keyword=coding",
      "category": "Technology",
      "readTime": "12 min read",
      "savedAt": "2024-03-15T10:30:00Z",
      "publishedAt": "2024-03-10T14:20:00Z",
      "likes": 567,
      "comments": 89,
      "source": "Medium",
      "tags": ["flutter", "state management", "mobile dev"]
    },
    {
      "id": "2",
      "title": "Creating Compelling User Interfaces",
      "excerpt": "Design principles and practical tips for modern UI/UX development",
      "author": "Sarah Kim",
      "avatar": "https://picsum.photos/50/50?random=2&keyword=portrait",
      "image": "https://picsum.photos/400/250?random=2&keyword=design",
      "category": "Design",
      "readTime": "8 min read",
      "savedAt": "2024-03-14T16:45:00Z",
      "publishedAt": "2024-03-08T11:15:00Z",
      "likes": 423,
      "comments": 67,
      "source": "Design Weekly",
      "tags": ["ui", "ux", "design"]
    },
    {
      "id": "3",
      "title": "Building High-Performance Teams",
      "excerpt": "Leadership strategies for remote and distributed team management",
      "author": "David Rodriguez",
      "avatar": "https://picsum.photos/50/50?random=3&keyword=portrait",
      "image": "https://picsum.photos/400/250?random=3&keyword=team",
      "category": "Business",
      "readTime": "10 min read",
      "savedAt": "2024-03-13T14:20:00Z",
      "publishedAt": "2024-03-05T09:30:00Z",
      "likes": 345,
      "comments": 56,
      "source": "Harvard Business Review",
      "tags": ["leadership", "management", "teams"]
    },
    {
      "id": "4",
      "title": "The Science of Habit Formation",
      "excerpt": "Understanding how habits work and how to build positive routines",
      "author": "Dr. Emma Wilson",
      "avatar": "https://picsum.photos/50/50?random=4&keyword=portrait",
      "image": "https://picsum.photos/400/250?random=4&keyword=health",
      "category": "Health",
      "readTime": "15 min read",
      "savedAt": "2024-03-12T12:10:00Z",
      "publishedAt": "2024-03-02T10:45:00Z",
      "likes": 789,
      "comments": 134,
      "source": "Psychology Today",
      "tags": ["psychology", "habits", "wellness"]
    },
    {
      "id": "5",
      "title": "Minimalist Living: A Complete Guide",
      "excerpt": "How to simplify your life and focus on what truly matters",
      "author": "Lisa Thompson",
      "avatar": "https://picsum.photos/50/50?random=5&keyword=portrait",
      "image": "https://picsum.photos/400/250?random=5&keyword=minimal",
      "category": "Lifestyle",
      "readTime": "7 min read",
      "savedAt": "2024-03-11T18:30:00Z",
      "publishedAt": "2024-02-28T15:20:00Z",
      "likes": 234,
      "comments": 45,
      "source": "Zen Habits",
      "tags": ["minimalism", "lifestyle", "simplicity"]
    },
    {
      "id": "6",
      "title": "Machine Learning Fundamentals",
      "excerpt": "A comprehensive introduction to AI and machine learning concepts",
      "author": "Alex Park",
      "avatar": "https://picsum.photos/50/50?random=6&keyword=portrait",
      "image": "https://picsum.photos/400/250?random=6&keyword=ai",
      "category": "Technology",
      "readTime": "20 min read",
      "savedAt": "2024-03-10T20:15:00Z",
      "publishedAt": "2024-02-25T13:00:00Z",
      "likes": 1234,
      "comments": 267,
      "source": "Towards Data Science",
      "tags": ["machine learning", "AI", "data science"]
    }
  ];

  List<Map<String, dynamic>> collections = [
    {
      "id": "1",
      "name": "Flutter Development",
      "description": "Best practices and advanced techniques for Flutter apps",
      "postsCount": 15,
      "color": "#4285F4",
      "icon": Icons.phone_android,
      "createdAt": "2024-03-01T10:00:00Z"
    },
    {
      "id": "2", 
      "name": "Design Inspiration",
      "description": "UI/UX design trends and creative inspiration",
      "postsCount": 12,
      "color": "#FF6B6B",
      "icon": Icons.palette,
      "createdAt": "2024-02-28T14:00:00Z"
    },
    {
      "id": "3",
      "name": "Business Strategy",
      "description": "Leadership and business growth insights",
      "postsCount": 8,
      "color": "#4ECDC4",
      "icon": Icons.business,
      "createdAt": "2024-02-25T16:00:00Z"
    },
    {
      "id": "4",
      "name": "Health & Wellness",
      "description": "Physical and mental health resources",
      "postsCount": 6,
      "color": "#45B7D1",
      "icon": Icons.favorite,
      "createdAt": "2024-02-20T12:00:00Z"
    }
  ];

  void _removeBookmark(int index) {
    setState(() {
      bookmarkedPosts.removeAt(index);
    });
    ss("Removed from bookmarks");
  }

  List<Map<String, dynamic>> get filteredPosts {
    List<Map<String, dynamic>> filtered = bookmarkedPosts;

    // Filter by category
    if (selectedCategory != "All") {
      filtered = filtered.where((post) => post["category"] == selectedCategory).toList();
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((post) =>
        (post["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (post["excerpt"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (post["author"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }

    // Sort posts
    switch (sortBy) {
      case "Popular":
        filtered.sort((a, b) => (b["likes"] as int).compareTo(a["likes"] as int));
        break;
      case "Most Liked":
        filtered.sort((a, b) => (b["likes"] as int).compareTo(a["likes"] as int));
        break;
      case "Most Commented":
        filtered.sort((a, b) => (b["comments"] as int).compareTo(a["comments"] as int));
        break;
      default: // Recent
        filtered.sort((a, b) => b["savedAt"].compareTo(a["savedAt"]));
    }

    return filtered;
  }

  String _formatSavedTime(String savedAt) {
    final now = DateTime.now();
    final saved = DateTime.parse(savedAt);
    final difference = now.difference(saved);

    if (difference.inDays > 0) {
      return "Saved ${difference.inDays}d ago";
    } else if (difference.inHours > 0) {
      return "Saved ${difference.inHours}h ago";
    } else {
      return "Saved ${difference.inMinutes}m ago";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Posts"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              "Your Reading List",
              style: TextStyle(
                fontSize: fsH2,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "${bookmarkedPosts.length} articles saved across ${collections.length} collections",
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spLg),

            // Collections Section
            Text(
              "Collections",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            QHorizontalScroll(
              children: collections.map((collection) {
                final color = Color(int.parse("0xFF${collection["color"].substring(1)}"));
                return Container(
                  width: 200,
                  margin: EdgeInsets.only(right: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: color.withAlpha(26),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: color.withAlpha(51),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              collection["icon"],
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${collection["postsCount"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "${collection["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${collection["description"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spLg),

            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search saved posts...",
                    value: searchQuery,
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
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Category Filter
            QCategoryPicker(
              items: categories.map((category) => {
                "label": category,
                "value": category,
              }).toList(),
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),

            // Sort Options
            Row(
              children: [
                Text(
                  "Sort by:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "",
                    items: sortOptions.map((option) => {
                      "label": option,
                      "value": option,
                    }).toList(),
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

            // Saved Posts List
            Text(
              "Saved Articles (${filteredPosts.length})",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            if (filteredPosts.isEmpty) ...[
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
                      Icons.bookmark_border,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No saved posts found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your search or filter criteria",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              ...filteredPosts.asMap().entries.map((entry) {
                final index = entry.key;
                final post = entry.value;
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Post Image
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(radiusMd),
                        ),
                        child: Image.network(
                          "${post["image"]}",
                          width: double.infinity,
                          height: 180,
                          fit: BoxFit.cover,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Category and Source
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
                                SizedBox(width: spSm),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(26),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${post["source"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: infoColor,
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
                            SizedBox(height: spMd),

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

                            // Author and Stats
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
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
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        _formatSavedTime(post["savedAt"]),
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
                                    Icon(
                                      Icons.favorite_border,
                                      size: 16,
                                      color: disabledBoldColor,
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
                                SizedBox(width: spMd),
                                Row(
                                  children: [
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
                                    label: "Read",
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.share,
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.bookmark_remove,
                                  size: bs.sm,
                                  onPressed: () => _removeBookmark(bookmarkedPosts.indexOf(post)),
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
          ],
        ),
      ),
    );
  }
}
