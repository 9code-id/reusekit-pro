import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaFavoritesView extends StatefulWidget {
  const NmaFavoritesView({super.key});

  @override
  State<NmaFavoritesView> createState() => _NmaFavoritesViewState();
}

class _NmaFavoritesViewState extends State<NmaFavoritesView> {
  String selectedCategory = "All";
  String selectedSortBy = "Date Added";
  String searchQuery = "";
  bool isGridView = false;
  bool isSelectionMode = false;
  List<String> selectedArticles = [];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All", "count": 28},
    {"label": "Technology", "value": "Technology", "count": 8},
    {"label": "Business", "value": "Business", "count": 6},
    {"label": "Science", "value": "Science", "count": 5},
    {"label": "Sports", "value": "Sports", "count": 4},
    {"label": "Entertainment", "value": "Entertainment", "count": 3},
    {"label": "Health", "value": "Health", "count": 2},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Date Added", "value": "Date Added"},
    {"label": "Most Recent", "value": "Most Recent"},
    {"label": "Title (A-Z)", "value": "Title (A-Z)"},
    {"label": "Title (Z-A)", "value": "Title (Z-A)"},
    {"label": "Source", "value": "Source"},
    {"label": "Read Status", "value": "Read Status"},
  ];

  List<Map<String, dynamic>> favoriteArticles = [
    {
      "id": "1",
      "title": "The Psychology of Decision Making",
      "source": "Harvard Business Review",
      "author": "Dr. Sarah Johnson",
      "readTime": "12 min read",
      "favoriteDate": "2024-01-15",
      "publishDate": "2024-01-10",
      "category": "Business",
      "image": "https://picsum.photos/400/250?random=1&keyword=psychology",
      "isRead": true,
      "rating": 5,
      "tags": ["Psychology", "Decision Making", "Business"],
      "summary": "Understanding the cognitive processes behind effective decision making",
      "notes": "Excellent insights on behavioral economics and decision frameworks",
    },
    {
      "id": "2",
      "title": "Quantum Computing Breakthrough",
      "source": "MIT Technology Review",
      "author": "Prof. Michael Chen",
      "readTime": "15 min read",
      "favoriteDate": "2024-01-14",
      "publishDate": "2024-01-12",
      "category": "Technology",
      "image": "https://picsum.photos/400/250?random=2&keyword=quantum",
      "isRead": false,
      "rating": 5,
      "tags": ["Quantum", "Computing", "Innovation"],
      "summary": "Revolutionary advancement in quantum computing capabilities",
      "notes": "Must read for understanding future tech trends",
    },
    {
      "id": "3",
      "title": "Climate Solutions That Actually Work",
      "source": "National Geographic",
      "author": "Dr. Emma Wilson",
      "readTime": "18 min read",
      "favoriteDate": "2024-01-13",
      "publishDate": "2024-01-08",
      "category": "Science",
      "image": "https://picsum.photos/400/250?random=3&keyword=climate",
      "isRead": true,
      "rating": 4,
      "tags": ["Climate", "Environment", "Solutions"],
      "summary": "Practical approaches to addressing climate change challenges",
      "notes": "Great examples of successful climate initiatives",
    },
    {
      "id": "4",
      "title": "The Future of Remote Work",
      "source": "Forbes",
      "author": "Lisa Park",
      "readTime": "8 min read",
      "favoriteDate": "2024-01-12",
      "publishDate": "2024-01-11",
      "category": "Business",
      "image": "https://picsum.photos/400/250?random=4&keyword=remote",
      "isRead": false,
      "rating": 4,
      "tags": ["Remote Work", "Future", "Productivity"],
      "summary": "How remote work is reshaping the modern workplace",
      "notes": "Good predictions about workplace evolution",
    },
    {
      "id": "5",
      "title": "Olympic Training Innovations",
      "source": "ESPN",
      "author": "Alex Rodriguez",
      "readTime": "10 min read",
      "favoriteDate": "2024-01-11",
      "publishDate": "2024-01-09",
      "category": "Sports",
      "image": "https://picsum.photos/400/250?random=5&keyword=olympics",
      "isRead": true,
      "rating": 4,
      "tags": ["Olympics", "Training", "Sports Science"],
      "summary": "Cutting-edge training methods used by Olympic athletes",
      "notes": "Fascinating insights into sports performance optimization",
    },
    {
      "id": "6",
      "title": "Mindfulness in the Digital Age",
      "source": "Psychology Today",
      "author": "Dr. Anna Kim",
      "readTime": "6 min read",
      "favoriteDate": "2024-01-10",
      "publishDate": "2024-01-07",
      "category": "Health",
      "image": "https://picsum.photos/400/250?random=6&keyword=mindfulness",
      "isRead": true,
      "rating": 5,
      "tags": ["Mindfulness", "Mental Health", "Digital"],
      "summary": "Maintaining mental wellness in our connected world",
      "notes": "Practical tips that I want to implement",
    },
    {
      "id": "7",
      "title": "The Art of Storytelling in Cinema",
      "source": "The Guardian",
      "author": "James Miller",
      "readTime": "14 min read",
      "favoriteDate": "2024-01-09",
      "publishDate": "2024-01-05",
      "category": "Entertainment",
      "image": "https://picsum.photos/400/250?random=7&keyword=cinema",
      "isRead": false,
      "rating": 4,
      "tags": ["Cinema", "Storytelling", "Art"],
      "summary": "How master filmmakers craft compelling narratives",
      "notes": "Want to study these techniques for my own projects",
    },
    {
      "id": "8",
      "title": "Breakthrough in Gene Therapy",
      "source": "Nature Medicine",
      "author": "Dr. Robert Davis",
      "readTime": "20 min read",
      "favoriteDate": "2024-01-08",
      "publishDate": "2024-01-06",
      "category": "Science",
      "image": "https://picsum.photos/400/250?random=8&keyword=gene",
      "isRead": false,
      "rating": 5,
      "tags": ["Gene Therapy", "Medicine", "Research"],
      "summary": "Revolutionary gene therapy shows promising results in trials",
      "notes": "Important developments in medical science",
    },
  ];

  List<Map<String, dynamic>> get filteredArticles {
    List<Map<String, dynamic>> filtered = favoriteArticles;

    if (selectedCategory != "All") {
      filtered = filtered.where((article) => article["category"] == selectedCategory).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((article) =>
          (article["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (article["author"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (article["source"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (article["notes"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }

    return filtered;
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: disabledColor)),
              ),
              child: Row(
                children: [
                  Text(
                    "Filter & Sort",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, color: disabledBoldColor),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sort By",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QDropdownField(
                      label: "Sort Options",
                      items: sortOptions,
                      value: selectedSortBy,
                      onChanged: (value, label) {
                        selectedSortBy = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spLg),
                    Text(
                      "Filter by Category",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...categories.map((category) {
                      bool isSelected = selectedCategory == category["value"];
                      return Container(
                        margin: EdgeInsets.only(bottom: spXs),
                        child: GestureDetector(
                          onTap: () {
                            selectedCategory = category["value"];
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spSm),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor.withAlpha(20) : Colors.transparent,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledColor,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                                  color: isSelected ? primaryColor : disabledBoldColor,
                                  size: 20,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${category["label"]}",
                                  style: TextStyle(
                                    color: isSelected ? primaryColor : disabledBoldColor,
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: isSelected ? primaryColor : disabledColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${category["count"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: disabledColor)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Reset",
                      color: disabledColor,
                      size: bs.md,
                      onPressed: () {
                        selectedCategory = "All";
                        selectedSortBy = "Date Added";
                        setState(() {});
                        Navigator.pop(context);
                        ss("Filters reset successfully");
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Apply",
                      size: bs.md,
                      onPressed: () {
                        Navigator.pop(context);
                        ss("Filters applied successfully");
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBulkActions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: disabledColor)),
              ),
              child: Row(
                children: [
                  Text(
                    "Bulk Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${selectedArticles.length} selected",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  _buildBulkActionItem(
                    icon: Icons.add_to_photos,
                    title: "Add to Reading List",
                    onTap: () {
                      Navigator.pop(context);
                      ss("${selectedArticles.length} articles added to reading list");
                      _exitSelectionMode();
                    },
                  ),
                  _buildBulkActionItem(
                    icon: Icons.bookmark,
                    title: "Save Articles",
                    onTap: () {
                      Navigator.pop(context);
                      ss("${selectedArticles.length} articles saved");
                      _exitSelectionMode();
                    },
                  ),
                  _buildBulkActionItem(
                    icon: Icons.share,
                    title: "Share Articles",
                    onTap: () {
                      Navigator.pop(context);
                      si("Sharing ${selectedArticles.length} articles");
                      _exitSelectionMode();
                    },
                  ),
                  _buildBulkActionItem(
                    icon: Icons.download,
                    title: "Download for Offline",
                    onTap: () {
                      Navigator.pop(context);
                      ss("${selectedArticles.length} articles downloading");
                      _exitSelectionMode();
                    },
                  ),
                  _buildBulkActionItem(
                    icon: Icons.favorite_border,
                    title: "Remove from Favorites",
                    color: dangerColor,
                    onTap: () async {
                      Navigator.pop(context);
                      bool isConfirmed = await confirm("Remove ${selectedArticles.length} articles from favorites?");
                      if (isConfirmed) {
                        ss("${selectedArticles.length} articles removed from favorites");
                        _exitSelectionMode();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBulkActionItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: spSm),
        child: Row(
          children: [
            Icon(
              icon,
              color: color ?? primaryColor,
              size: 24,
            ),
            SizedBox(width: spMd),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: color ?? Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleSelection(String articleId) {
    if (selectedArticles.contains(articleId)) {
      selectedArticles.remove(articleId);
    } else {
      selectedArticles.add(articleId);
    }
    
    if (selectedArticles.isEmpty) {
      isSelectionMode = false;
    }
    
    setState(() {});
  }

  void _exitSelectionMode() {
    isSelectionMode = false;
    selectedArticles.clear();
    setState(() {});
  }

  void _showNotesDialog(Map<String, dynamic> article) {
    String notes = article["notes"] ?? "";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Personal Notes"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${article["title"]}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "Your notes about this article",
              value: notes,
              onChanged: (value) {
                notes = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Notes saved successfully");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRatingStars(int rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: warningColor,
          size: 16,
        );
      }),
    );
  }

  Widget _buildArticleCard(Map<String, dynamic> article) {
    bool isSelected = selectedArticles.contains(article["id"]);
    
    return GestureDetector(
      onTap: () {
        if (isSelectionMode) {
          _toggleSelection(article["id"]);
        } else {
          // Navigate to article detail
        }
      },
      onLongPress: () {
        if (!isSelectionMode) {
          isSelectionMode = true;
          _toggleSelection(article["id"]);
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : disabledColor,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [shadowSm],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                  child: Image.network(
                    "${article["image"]}",
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                if (isSelectionMode)
                  Positioned(
                    top: spXs,
                    right: spXs,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledColor,
                          width: 2,
                        ),
                      ),
                      child: isSelected
                          ? Icon(Icons.check, color: Colors.white, size: 16)
                          : null,
                    ),
                  ),
                Positioned(
                  top: spXs,
                  left: spXs,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(150),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${article["category"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                if (article["isRead"] == true)
                  Positioned(
                    bottom: spXs,
                    left: spXs,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                Positioned(
                  bottom: spXs,
                  right: spXs,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(150),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: _buildRatingStars(article["rating"] as int),
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
                    "${article["title"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: article["isRead"] == true ? disabledBoldColor : Colors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${article["summary"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (article["notes"] != null && (article["notes"] as String).isNotEmpty) ...[
                    SizedBox(height: spXs),
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.note,
                            color: warningColor,
                            size: 14,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${article["notes"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                                fontStyle: FontStyle.italic,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Text(
                        "${article["source"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${article["readTime"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Added ${article["favoriteDate"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: spXs,
                          children: (article["tags"] as List).take(2).map((tag) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "$tag",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showNotesDialog(article),
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            Icons.note_add,
                            color: warningColor,
                            size: 16,
                          ),
                        ),
                      ),
                      SizedBox(width: spXs),
                      GestureDetector(
                        onTap: () async {
                          bool isConfirmed = await confirm("Remove '${article["title"]}' from favorites?");
                          if (isConfirmed) {
                            ss("Article removed from favorites");
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            Icons.favorite,
                            color: dangerColor,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridArticleCard(Map<String, dynamic> article) {
    bool isSelected = selectedArticles.contains(article["id"]);
    
    return GestureDetector(
      onTap: () {
        if (isSelectionMode) {
          _toggleSelection(article["id"]);
        } else {
          // Navigate to article detail
        }
      },
      onLongPress: () {
        if (!isSelectionMode) {
          isSelectionMode = true;
          _toggleSelection(article["id"]);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : disabledColor,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [shadowSm],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                  child: Image.network(
                    "${article["image"]}",
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                if (isSelectionMode)
                  Positioned(
                    top: spXs,
                    right: spXs,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledColor,
                          width: 2,
                        ),
                      ),
                      child: isSelected
                          ? Icon(Icons.check, color: Colors.white, size: 12)
                          : null,
                    ),
                  ),
                Positioned(
                  bottom: spXs,
                  right: spXs,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(150),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: _buildRatingStars(article["rating"] as int),
                  ),
                ),
                if (article["isRead"] == true)
                  Positioned(
                    bottom: spXs,
                    left: spXs,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 10,
                      ),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(spXs),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${article["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: article["isRead"] == true ? disabledBoldColor : Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${article["source"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${article["readTime"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.favorite,
                          color: dangerColor,
                          size: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isSelectionMode ? "${selectedArticles.length} Selected" : "Favorite Articles"),
        leading: isSelectionMode
            ? GestureDetector(
                onTap: _exitSelectionMode,
                child: Icon(Icons.close),
              )
            : null,
        actions: isSelectionMode
            ? [
                GestureDetector(
                  onTap: () {
                    if (selectedArticles.length == filteredArticles.length) {
                      selectedArticles.clear();
                    } else {
                      selectedArticles = filteredArticles.map((article) => article["id"] as String).toList();
                    }
                    setState(() {});
                  },
                  child: Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Icon(
                      selectedArticles.length == filteredArticles.length
                          ? Icons.deselect
                          : Icons.select_all,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _showBulkActions,
                  child: Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Icon(Icons.more_vert),
                  ),
                ),
              ]
            : [
                GestureDetector(
                  onTap: () {
                    isGridView = !isGridView;
                    setState(() {});
                  },
                  child: Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Icon(isGridView ? Icons.view_list : Icons.view_module),
                  ),
                ),
                GestureDetector(
                  onTap: _showFilterOptions,
                  child: Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Icon(Icons.filter_list),
                  ),
                ),
              ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search favorites...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                if (searchQuery.isNotEmpty) ...[
                  SizedBox(width: spSm),
                  GestureDetector(
                    onTap: () {
                      searchQuery = "";
                      setState(() {});
                    },
                    child: Icon(
                      Icons.clear,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            color: Colors.grey[50],
            child: Row(
              children: [
                Icon(
                  Icons.favorite,
                  color: dangerColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Text(
                  "${filteredArticles.length} favorite articles",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (selectedCategory != "All") ...[
                  SizedBox(width: spXs),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: disabledColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Category: $selectedCategory",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            child: isGridView
                ? ResponsiveGridView(
                    padding: EdgeInsets.all(spMd),
                    minItemWidth: 200,
                    children: filteredArticles.map((article) {
                      return _buildGridArticleCard(article);
                    }).toList(),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(spMd),
                    itemCount: filteredArticles.length,
                    itemBuilder: (context, index) {
                      final article = filteredArticles[index];
                      return _buildArticleCard(article);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
