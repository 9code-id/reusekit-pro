import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaSavedPostsView extends StatefulWidget {
  const SmaSavedPostsView({super.key});

  @override
  State<SmaSavedPostsView> createState() => _SmaSavedPostsViewState();
}

class _SmaSavedPostsViewState extends State<SmaSavedPostsView> {
  String selectedFilter = "All";
  String searchQuery = "";
  bool isGridView = false;
  bool isEditMode = false;
  List<int> selectedPosts = [];

  List<Map<String, dynamic>> savedPosts = [
    {
      "id": 1,
      "title": "Best coffee shops in the city",
      "author": "Emma Johnson",
      "authorUsername": "emma_coffee",
      "authorImage": "https://picsum.photos/300/300?random=1&keyword=woman",
      "postImage": "https://picsum.photos/400/600?random=1&keyword=coffee",
      "savedDate": "2024-06-15",
      "originalDate": "2024-06-12",
      "likesCount": 234,
      "commentsCount": 45,
      "sharesCount": 12,
      "type": "image",
      "collection": "Food & Drink",
      "tags": ["coffee", "lifestyle", "city", "recommendations"],
      "description": "Discovered some amazing local coffee shops that serve the perfect brew. Check out my top 5 recommendations! ☕️",
      "isVerified": true,
    },
    {
      "id": 2,
      "title": "Morning workout routine",
      "author": "Mike Chen",
      "authorUsername": "mike_fitness",
      "authorImage": "https://picsum.photos/300/300?random=2&keyword=man",
      "postImage": "https://picsum.photos/400/600?random=2&keyword=workout",
      "savedDate": "2024-06-14",
      "originalDate": "2024-06-11",
      "likesCount": 456,
      "commentsCount": 78,
      "sharesCount": 23,
      "type": "video",
      "duration": "12:30",
      "collection": "Fitness",
      "tags": ["workout", "morning", "fitness", "health"],
      "description": "Start your day with this energizing 15-minute workout routine. No equipment needed! 💪",
      "isVerified": false,
    },
    {
      "id": 3,
      "title": "Easy pasta recipe for busy weeknights",
      "author": "Sarah Wilson",
      "authorUsername": "sarah_cooks",
      "authorImage": "https://picsum.photos/300/300?random=3&keyword=woman",
      "postImage": "https://picsum.photos/400/600?random=3&keyword=pasta",
      "savedDate": "2024-06-13",
      "originalDate": "2024-06-10",
      "likesCount": 189,
      "commentsCount": 32,
      "sharesCount": 8,
      "type": "carousel",
      "imageCount": 5,
      "collection": "Recipes",
      "tags": ["pasta", "cooking", "easy", "weeknight"],
      "description": "Quick and delicious pasta recipe that takes only 20 minutes. Perfect for busy weeknights! 🍝",
      "isVerified": true,
    },
    {
      "id": 4,
      "title": "Minimalist home office setup",
      "author": "Alex Rodriguez",
      "authorUsername": "alex_design",
      "authorImage": "https://picsum.photos/300/300?random=4&keyword=man",
      "postImage": "https://picsum.photos/400/600?random=4&keyword=office",
      "savedDate": "2024-06-12",
      "originalDate": "2024-06-09",
      "likesCount": 312,
      "commentsCount": 56,
      "sharesCount": 18,
      "type": "image",
      "collection": "Design",
      "tags": ["minimalist", "office", "workspace", "design"],
      "description": "Clean and productive workspace setup that boosts creativity and focus. Less is more! 🖥️",
      "isVerified": false,
    },
    {
      "id": 5,
      "title": "Weekend getaway destinations",
      "author": "Jenny Kim",
      "authorUsername": "jenny_travels",
      "authorImage": "https://picsum.photos/300/300?random=5&keyword=woman",
      "postImage": "https://picsum.photos/400/600?random=5&keyword=travel",
      "savedDate": "2024-06-11",
      "originalDate": "2024-06-08",
      "likesCount": 567,
      "commentsCount": 89,
      "sharesCount": 34,
      "type": "carousel",
      "imageCount": 8,
      "collection": "Travel",
      "tags": ["travel", "weekend", "getaway", "adventure"],
      "description": "Escape the city with these amazing weekend destinations within driving distance. Adventure awaits! 🏔️",
      "isVerified": true,
    },
    {
      "id": 6,
      "title": "DIY plant care tips",
      "author": "David Lee",
      "authorUsername": "david_plants",
      "authorImage": "https://picsum.photos/300/300?random=6&keyword=man",
      "postImage": "https://picsum.photos/400/600?random=6&keyword=plants",
      "savedDate": "2024-06-10",
      "originalDate": "2024-06-07",
      "likesCount": 198,
      "commentsCount": 41,
      "sharesCount": 15,
      "type": "video",
      "duration": "8:45",
      "collection": "Lifestyle",
      "tags": ["plants", "gardening", "diy", "care"],
      "description": "Keep your plants thriving with these simple care tips. Even beginners can have a green thumb! 🌱",
      "isVerified": false,
    },
  ];

  List<String> collections = ["All", "Food & Drink", "Fitness", "Recipes", "Design", "Travel", "Lifestyle"];
  List<String> postTypes = ["All", "Image", "Video", "Carousel"];

  List<Map<String, dynamic>> get filteredPosts {
    return savedPosts.where((post) {
      final matchesCollection = selectedFilter == "All" || post["collection"] == selectedFilter;
      final matchesSearch = searchQuery.isEmpty ||
          (post["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (post["author"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (post["tags"] as List).any((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()));
      return matchesCollection && matchesSearch;
    }).toList();
  }

  void _togglePostSelection(int postId) {
    setState(() {
      if (selectedPosts.contains(postId)) {
        selectedPosts.remove(postId);
      } else {
        selectedPosts.add(postId);
      }
    });
  }

  void _removeFromSaved(Map<String, dynamic> post) async {
    bool isConfirmed = await confirm("Remove '${post["title"]}' from saved posts?");
    if (isConfirmed) {
      setState(() {
        savedPosts.removeWhere((p) => p["id"] == post["id"]);
      });
      ss("Post removed from saved");
    }
  }

  void _removeSelectedPosts() async {
    if (selectedPosts.isEmpty) return;
    
    bool isConfirmed = await confirm("Remove ${selectedPosts.length} posts from saved?");
    if (isConfirmed) {
      setState(() {
        savedPosts.removeWhere((post) => selectedPosts.contains(post["id"]));
        selectedPosts.clear();
        isEditMode = false;
      });
      ss("Selected posts removed from saved");
    }
  }

  void _sharePost(Map<String, dynamic> post) {
    ss("Sharing '${post["title"]}'");
  }

  void _addToCollection(Map<String, dynamic> post) {
    // In a real app, this would open a dialog to add to collection
    ss("Add '${post["title"]}' to collection");
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'image':
        return infoColor;
      case 'video':
        return dangerColor;
      case 'carousel':
        return warningColor;
      default:
        return primaryColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'image':
        return Icons.image;
      case 'video':
        return Icons.play_circle;
      case 'carousel':
        return Icons.view_carousel;
      default:
        return Icons.post_add;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Posts"),
        actions: [
          QButton(
            icon: isGridView ? Icons.list : Icons.grid_view,
            size: bs.sm,
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
          ),
          if (isEditMode) ...[
            QButton(
              label: "Cancel",
              size: bs.sm,
              onPressed: () {
                setState(() {
                  isEditMode = false;
                  selectedPosts.clear();
                });
              },
            ),
          ] else ...[
            QButton(
              label: "Edit",
              size: bs.sm,
              onPressed: () {
                setState(() {
                  isEditMode = true;
                });
              },
            ),
          ],
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Statistics Overview
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${savedPosts.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Saved Posts",
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
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${collections.length - 1}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Collections",
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
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${savedPosts.where((post) => DateTime.parse(post["savedDate"]).isAfter(DateTime.now().subtract(Duration(days: 7)))).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "This Week",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Search and Filter
            if (!isEditMode) ...[
              QTextField(
                label: "Search saved posts...",
                value: searchQuery,
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
              
              QCategoryPicker(
                label: "Collection",
                items: collections.map((collection) => {
                  "label": collection,
                  "value": collection,
                }).toList(),
                value: selectedFilter,
                onChanged: (index, label, value, item) {
                  selectedFilter = value;
                  setState(() {});
                },
              ),
            ],

            // Bulk Actions (Edit Mode)
            if (isEditMode && selectedPosts.isNotEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: warningColor.withAlpha(50)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${selectedPosts.length} posts selected",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                    ),
                    QButton(
                      label: "Remove Selected",
                      size: bs.sm,
                      onPressed: _removeSelectedPosts,
                    ),
                  ],
                ),
              ),
            ],

            // Empty State
            if (filteredPosts.isEmpty) ...[
              Container(
                width: double.infinity,
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
                    SizedBox(height: spSm),
                    Text(
                      searchQuery.isEmpty && selectedFilter == "All"
                          ? "No Saved Posts"
                          : "No Results Found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      searchQuery.isEmpty && selectedFilter == "All"
                          ? "Save posts you want to revisit later"
                          : "Try adjusting your search or collection filter",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Posts Grid/List
            if (isGridView) ...[
              // Grid View
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredPosts.map((post) {
                  final bool isSelected = selectedPosts.contains(post["id"]);
                  final Color typeColor = _getTypeColor(post["type"]);
                  
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: isSelected ? Border.all(color: primaryColor.withAlpha(50), width: 2) : null,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(radiusMd),
                        onTap: isEditMode 
                            ? () => _togglePostSelection(post["id"])
                            : () {
                                // Navigate to post detail
                              },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(radiusMd),
                                    topRight: Radius.circular(radiusMd),
                                  ),
                                  child: Image.network(
                                    "${post["postImage"]}",
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                
                                // Selection overlay
                                if (isEditMode)
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: isSelected 
                                            ? primaryColor.withAlpha(100)
                                            : Colors.black.withAlpha(50),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(radiusMd),
                                          topRight: Radius.circular(radiusMd),
                                        ),
                                      ),
                                      child: Center(
                                        child: isSelected
                                            ? Icon(
                                                Icons.check_circle,
                                                color: Colors.white,
                                                size: 30,
                                              )
                                            : Icon(
                                                Icons.circle,
                                                color: Colors.white.withAlpha(150),
                                                size: 30,
                                              ),
                                      ),
                                    ),
                                  ),
                                
                                // Type badge
                                if (!isEditMode)
                                  Positioned(
                                    top: spXs,
                                    right: spXs,
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: typeColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Icon(
                                        _getTypeIcon(post["type"]),
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            
                            Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${post["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${post["author"]}",
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
                    ),
                  );
                }).toList(),
              ),
            ] else ...[
              // List View
              ...filteredPosts.map((post) {
                final bool isSelected = selectedPosts.contains(post["id"]);
                final Color typeColor = _getTypeColor(post["type"]);
                final IconData typeIcon = _getTypeIcon(post["type"]);
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: isSelected ? Border.all(color: primaryColor.withAlpha(50), width: 2) : null,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(radiusMd),
                      onTap: isEditMode 
                          ? () => _togglePostSelection(post["id"])
                          : () {
                              // Navigate to post detail
                            },
                      child: Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                if (isEditMode) ...[
                                  Checkbox(
                                    value: isSelected,
                                    onChanged: (value) => _togglePostSelection(post["id"]),
                                    activeColor: primaryColor,
                                  ),
                                  SizedBox(width: spSm),
                                ],
                                
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  child: Image.network(
                                    "${post["postImage"]}",
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${post["title"]}",
                                              style: TextStyle(
                                                fontSize: fsH6,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: typeColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  typeIcon,
                                                  color: typeColor,
                                                  size: 10,
                                                ),
                                                SizedBox(width: spXs),
                                                Text(
                                                  "${post["type"]}".toUpperCase(),
                                                  style: TextStyle(
                                                    fontSize: 9,
                                                    color: typeColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      
                                      Row(
                                        children: [
                                          Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: NetworkImage("${post["authorImage"]}"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${post["author"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                          ),
                                          if (post["isVerified"] as bool) ...[
                                            SizedBox(width: spXs),
                                            Icon(
                                              Icons.verified,
                                              color: primaryColor,
                                              size: 12,
                                            ),
                                          ],
                                        ],
                                      ),
                                      
                                      Text(
                                        "Saved on ${post["savedDate"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            
                            // Description
                            Text(
                              "${post["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            
                            // Stats
                            Row(
                              children: [
                                Icon(Icons.favorite, size: 14, color: dangerColor),
                                SizedBox(width: spXs),
                                Text("${post["likesCount"]}", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                                SizedBox(width: spSm),
                                
                                Icon(Icons.comment, size: 14, color: primaryColor),
                                SizedBox(width: spXs),
                                Text("${post["commentsCount"]}", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                                SizedBox(width: spSm),
                                
                                Icon(Icons.share, size: 14, color: infoColor),
                                SizedBox(width: spXs),
                                Text("${post["sharesCount"]}", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                                
                                if (post["duration"] != null) ...[
                                  SizedBox(width: spSm),
                                  Icon(Icons.play_arrow, size: 14, color: dangerColor),
                                  SizedBox(width: spXs),
                                  Text("${post["duration"]}", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                                ],
                                
                                Spacer(),
                                
                                if (!isEditMode) ...[
                                  QButton(
                                    icon: Icons.share,
                                    size: bs.sm,
                                    onPressed: () => _sharePost(post),
                                  ),
                                  SizedBox(width: spXs),
                                  QButton(
                                    icon: Icons.bookmark_remove,
                                    size: bs.sm,
                                    onPressed: () => _removeFromSaved(post),
                                  ),
                                ],
                              ],
                            ),
                            
                            // Tags
                            if ((post["tags"] as List).isNotEmpty) ...[
                              Wrap(
                                spacing: spXs,
                                runSpacing: spXs,
                                children: (post["tags"] as List<String>).take(3).map((tag) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "#$tag",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],

            // Quick Actions
            if (!isEditMode && savedPosts.isNotEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Quick Actions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Create Collection",
                        size: bs.sm,
                        onPressed: () {
                          ss("Create new collection");
                        },
                      ),
                    ),
                    
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Export Saved Posts",
                        size: bs.sm,
                        onPressed: () {
                          ss("Exporting saved posts");
                        },
                      ),
                    ),
                    
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Clear All Saved",
                        size: bs.sm,
                        onPressed: () async {
                          bool isConfirmed = await confirm("Are you sure you want to remove all saved posts? This action cannot be undone.");
                          if (isConfirmed) {
                            setState(() {
                              savedPosts.clear();
                            });
                            ss("All saved posts have been cleared");
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
