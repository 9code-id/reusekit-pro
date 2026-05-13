import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaFavoritesView extends StatefulWidget {
  const SmaFavoritesView({super.key});

  @override
  State<SmaFavoritesView> createState() => _SmaFavoritesViewState();
}

class _SmaFavoritesViewState extends State<SmaFavoritesView> {
  String selectedCategory = "All";
  String searchQuery = "";
  bool isEditMode = false;
  List<int> selectedItems = [];

  List<Map<String, dynamic>> favoriteItems = [
    {
      "id": 1,
      "type": "post",
      "title": "Amazing sunset at the beach",
      "author": "Emma Johnson",
      "authorUsername": "emma_j",
      "authorImage": "https://picsum.photos/300/300?random=1&keyword=woman",
      "image": "https://picsum.photos/400/300?random=1&keyword=sunset",
      "savedDate": "2024-06-15",
      "likesCount": 245,
      "commentsCount": 32,
      "category": "Photos",
      "tags": ["sunset", "beach", "nature"],
      "description": "Captured this beautiful moment during my evening walk. Nature never fails to amaze me! 🌅",
    },
    {
      "id": 2,
      "type": "story",
      "title": "Coffee brewing tutorial",
      "author": "Mike Chen",
      "authorUsername": "mike_coffee",
      "authorImage": "https://picsum.photos/300/300?random=2&keyword=man",
      "image": "https://picsum.photos/400/300?random=2&keyword=coffee",
      "savedDate": "2024-06-14",
      "viewsCount": 1520,
      "duration": "45s",
      "category": "Videos",
      "tags": ["coffee", "tutorial", "lifestyle"],
      "description": "Learn how to brew the perfect cup of coffee at home with simple techniques.",
    },
    {
      "id": 3,
      "type": "post",
      "title": "Homemade pasta recipe",
      "author": "Sarah Wilson",
      "authorUsername": "sarah_cooks",
      "authorImage": "https://picsum.photos/300/300?random=3&keyword=woman",
      "image": "https://picsum.photos/400/300?random=3&keyword=pasta",
      "savedDate": "2024-06-13",
      "likesCount": 189,
      "commentsCount": 28,
      "category": "Recipes",
      "tags": ["pasta", "cooking", "italian", "homemade"],
      "description": "Simple and delicious homemade pasta recipe that anyone can master. Perfect for weekend cooking!",
    },
    {
      "id": 4,
      "type": "article",
      "title": "10 Tips for Better Photography",
      "author": "Alex Rodriguez",
      "authorUsername": "alex_photo",
      "authorImage": "https://picsum.photos/300/300?random=4&keyword=man",
      "image": "https://picsum.photos/400/300?random=4&keyword=camera",
      "savedDate": "2024-06-12",
      "readTime": "5 min read",
      "sharesCount": 67,
      "category": "Articles",
      "tags": ["photography", "tips", "tutorial"],
      "description": "Essential photography tips for beginners and intermediate photographers to improve their skills.",
    },
    {
      "id": 5,
      "type": "video",
      "title": "Yoga morning routine",
      "author": "Jenny Kim",
      "authorUsername": "jenny_yoga",
      "authorImage": "https://picsum.photos/300/300?random=5&keyword=woman",
      "image": "https://picsum.photos/400/300?random=5&keyword=yoga",
      "savedDate": "2024-06-11",
      "likesCount": 342,
      "duration": "15:30",
      "category": "Fitness",
      "tags": ["yoga", "morning", "wellness", "fitness"],
      "description": "Start your day with this energizing 15-minute yoga routine. Perfect for beginners and experienced practitioners.",
    },
    {
      "id": 6,
      "type": "post",
      "title": "Minimalist room design",
      "author": "David Lee",
      "authorUsername": "david_design",
      "authorImage": "https://picsum.photos/300/300?random=6&keyword=man",
      "image": "https://picsum.photos/400/300?random=6&keyword=room",
      "savedDate": "2024-06-10",
      "likesCount": 156,
      "commentsCount": 19,
      "category": "Design",
      "tags": ["minimalist", "interior", "design", "home"],
      "description": "Clean lines and thoughtful design create this peaceful minimalist bedroom sanctuary.",
    },
  ];

  List<String> categories = ["All", "Photos", "Videos", "Recipes", "Articles", "Fitness", "Design"];

  List<Map<String, dynamic>> get filteredFavorites {
    return favoriteItems.where((item) {
      final matchesCategory = selectedCategory == "All" || item["category"] == selectedCategory;
      final matchesSearch = searchQuery.isEmpty ||
          (item["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (item["author"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (item["tags"] as List).any((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()));
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _toggleItemSelection(int itemId) {
    setState(() {
      if (selectedItems.contains(itemId)) {
        selectedItems.remove(itemId);
      } else {
        selectedItems.add(itemId);
      }
    });
  }

  void _removeFromFavorites(Map<String, dynamic> item) async {
    bool isConfirmed = await confirm("Remove '${item["title"]}' from favorites?");
    if (isConfirmed) {
      setState(() {
        favoriteItems.removeWhere((f) => f["id"] == item["id"]);
      });
      ss("Removed from favorites");
    }
  }

  void _removeSelectedItems() async {
    if (selectedItems.isEmpty) return;
    
    bool isConfirmed = await confirm("Remove ${selectedItems.length} items from favorites?");
    if (isConfirmed) {
      setState(() {
        favoriteItems.removeWhere((item) => selectedItems.contains(item["id"]));
        selectedItems.clear();
        isEditMode = false;
      });
      ss("Selected items removed from favorites");
    }
  }

  void _shareItem(Map<String, dynamic> item) {
    ss("Sharing '${item["title"]}'");
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'photos':
        return infoColor;
      case 'videos':
        return dangerColor;
      case 'recipes':
        return warningColor;
      case 'articles':
        return primaryColor;
      case 'fitness':
        return successColor;
      case 'design':
        return Colors.purple;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'post':
        return Icons.image;
      case 'story':
        return Icons.play_circle;
      case 'article':
        return Icons.article;
      case 'video':
        return Icons.video_library;
      default:
        return Icons.bookmark;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
        actions: [
          if (isEditMode) ...[
            QButton(
              label: "Cancel",
              size: bs.sm,
              onPressed: () {
                setState(() {
                  isEditMode = false;
                  selectedItems.clear();
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
                          "${favoriteItems.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Favorites",
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
                          "${categories.length - 1}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Categories",
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
                          "${favoriteItems.where((item) => DateTime.parse(item["savedDate"]).isAfter(DateTime.now().subtract(Duration(days: 7)))).length}",
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

            // Search and Category Filter
            if (!isEditMode) ...[
              QTextField(
                label: "Search favorites...",
                value: searchQuery,
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
              
              QCategoryPicker(
                label: "Category",
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
            ],

            // Bulk Actions (Edit Mode)
            if (isEditMode && selectedItems.isNotEmpty) ...[
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
                        "${selectedItems.length} items selected",
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
                      onPressed: _removeSelectedItems,
                    ),
                  ],
                ),
              ),
            ],

            // Empty State
            if (filteredFavorites.isEmpty) ...[
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
                      searchQuery.isEmpty && selectedCategory == "All"
                          ? "No Favorites Yet"
                          : "No Results Found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      searchQuery.isEmpty && selectedCategory == "All"
                          ? "Start saving posts, articles, and media you love"
                          : "Try adjusting your search or category filter",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Favorites Grid
            ...filteredFavorites.map((item) {
              final bool isSelected = selectedItems.contains(item["id"]);
              final Color categoryColor = _getCategoryColor(item["category"]);
              final IconData typeIcon = _getTypeIcon(item["type"]);
              
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
                        ? () => _toggleItemSelection(item["id"])
                        : () {
                            // Navigate to item detail
                          },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image Header
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusMd),
                                topRight: Radius.circular(radiusMd),
                              ),
                              child: Image.network(
                                "${item["image"]}",
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            
                            // Selection overlay (Edit Mode)
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
                                            size: 48,
                                          )
                                        : Icon(
                                            Icons.circle,
                                            color: Colors.white.withAlpha(150),
                                            size: 48,
                                          ),
                                  ),
                                ),
                              ),
                            
                            // Type and Category badges
                            if (!isEditMode) ...[
                              Positioned(
                                top: spSm,
                                left: spSm,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: categoryColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        typeIcon,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${item["category"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              
                              Positioned(
                                top: spSm,
                                right: spSm,
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(100),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.bookmark,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),

                        // Content
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spSm,
                            children: [
                              // Title
                              Text(
                                "${item["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              
                              // Description
                              Text(
                                "${item["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              // Author Info
                              Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage("${item["authorImage"]}"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${item["author"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "Saved on ${item["savedDate"]}",
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

                              // Stats and Actions
                              if (!isEditMode) ...[
                                Row(
                                  children: [
                                    // Stats
                                    if (item["likesCount"] != null) ...[
                                      Icon(
                                        Icons.favorite,
                                        size: 14,
                                        color: dangerColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${item["likesCount"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                    ],
                                    
                                    if (item["commentsCount"] != null) ...[
                                      Icon(
                                        Icons.comment,
                                        size: 14,
                                        color: primaryColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${item["commentsCount"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                    ],
                                    
                                    if (item["duration"] != null) ...[
                                      Icon(
                                        Icons.play_arrow,
                                        size: 14,
                                        color: primaryColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${item["duration"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                    ],
                                    
                                    Spacer(),
                                    
                                    // Action Buttons
                                    QButton(
                                      icon: Icons.share,
                                      size: bs.sm,
                                      onPressed: () => _shareItem(item),
                                    ),
                                    SizedBox(width: spXs),
                                    QButton(
                                      icon: Icons.delete,
                                      size: bs.sm,
                                      onPressed: () => _removeFromFavorites(item),
                                    ),
                                  ],
                                ),
                              ],

                              // Tags
                              if ((item["tags"] as List).isNotEmpty) ...[
                                Wrap(
                                  spacing: spXs,
                                  runSpacing: spXs,
                                  children: (item["tags"] as List<String>).take(3).map((tag) {
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
                      ],
                    ),
                  ),
                ),
              );
            }),

            // Quick Actions
            if (!isEditMode && favoriteItems.isNotEmpty) ...[
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
                        label: "Share All Favorites",
                        size: bs.sm,
                        onPressed: () {
                          ss("Sharing favorites collection");
                        },
                      ),
                    ),
                    
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Export Favorites",
                        size: bs.sm,
                        onPressed: () {
                          ss("Exporting favorites list");
                        },
                      ),
                    ),
                    
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Clear All Favorites",
                        size: bs.sm,
                        onPressed: () async {
                          bool isConfirmed = await confirm("Are you sure you want to remove all favorites? This action cannot be undone.");
                          if (isConfirmed) {
                            setState(() {
                              favoriteItems.clear();
                            });
                            ss("All favorites have been cleared");
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
