import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaSavedArticlesView extends StatefulWidget {
  const NmaSavedArticlesView({super.key});

  @override
  State<NmaSavedArticlesView> createState() => _NmaSavedArticlesViewState();
}

class _NmaSavedArticlesViewState extends State<NmaSavedArticlesView> {
  String selectedCategory = "All";
  String selectedSortBy = "Date Saved";
  bool isGridView = false;
  String searchQuery = "";
  bool isSelectionMode = false;
  List<String> selectedArticles = [];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All", "count": 156},
    {"label": "Technology", "value": "Technology", "count": 34},
    {"label": "Business", "value": "Business", "count": 28},
    {"label": "Science", "value": "Science", "count": 22},
    {"label": "Politics", "value": "Politics", "count": 19},
    {"label": "Sports", "value": "Sports", "count": 15},
    {"label": "Entertainment", "value": "Entertainment", "count": 12},
    {"label": "Health", "value": "Health", "count": 10},
    {"label": "Travel", "value": "Travel", "count": 8},
    {"label": "Food", "value": "Food", "count": 5},
    {"label": "Lifestyle", "value": "Lifestyle", "count": 3},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Date Saved", "value": "Date Saved"},
    {"label": "Date Published", "value": "Date Published"},
    {"label": "Title (A-Z)", "value": "Title (A-Z)"},
    {"label": "Title (Z-A)", "value": "Title (Z-A)"},
    {"label": "Read Time", "value": "Read Time"},
    {"label": "Source", "value": "Source"},
  ];

  List<Map<String, dynamic>> savedArticles = [
    {
      "id": "1",
      "title": "The Future of Artificial Intelligence in Healthcare",
      "source": "TechCrunch",
      "author": "Sarah Johnson",
      "readTime": "8 min read",
      "savedDate": "2024-01-15",
      "publishDate": "2024-01-10",
      "category": "Technology",
      "image": "https://picsum.photos/400/250?random=1&keyword=ai",
      "isRead": false,
      "tags": ["AI", "Healthcare", "Innovation"],
      "summary": "Exploring how AI is revolutionizing medical diagnosis and treatment",
    },
    {
      "id": "2",
      "title": "Global Economic Outlook: Markets in 2024",
      "source": "Financial Times",
      "author": "Michael Chen",
      "readTime": "12 min read",
      "savedDate": "2024-01-14",
      "publishDate": "2024-01-12",
      "category": "Business",
      "image": "https://picsum.photos/400/250?random=2&keyword=economy",
      "isRead": true,
      "tags": ["Economy", "Markets", "Finance"],
      "summary": "Analysis of economic trends and market predictions for the year ahead",
    },
    {
      "id": "3",
      "title": "Climate Change: New Research Findings",
      "source": "Nature",
      "author": "Dr. Emma Williams",
      "readTime": "15 min read",
      "savedDate": "2024-01-13",
      "publishDate": "2024-01-08",
      "category": "Science",
      "image": "https://picsum.photos/400/250?random=3&keyword=climate",
      "isRead": false,
      "tags": ["Climate", "Research", "Environment"],
      "summary": "Latest scientific discoveries about climate change impacts",
    },
    {
      "id": "4",
      "title": "2024 Election Analysis: Key Battleground States",
      "source": "CNN Politics",
      "author": "Robert Davis",
      "readTime": "10 min read",
      "savedDate": "2024-01-12",
      "publishDate": "2024-01-11",
      "category": "Politics",
      "image": "https://picsum.photos/400/250?random=4&keyword=election",
      "isRead": true,
      "tags": ["Election", "Politics", "Analysis"],
      "summary": "Comprehensive analysis of the upcoming election landscape",
    },
    {
      "id": "5",
      "title": "Champions League Quarter-Finals Preview",
      "source": "ESPN",
      "author": "Alex Martinez",
      "readTime": "6 min read",
      "savedDate": "2024-01-11",
      "publishDate": "2024-01-09",
      "category": "Sports",
      "image": "https://picsum.photos/400/250?random=5&keyword=football",
      "isRead": false,
      "tags": ["Football", "Champions League", "Sports"],
      "summary": "Preview of the upcoming Champions League matches",
    },
    {
      "id": "6",
      "title": "Hollywood's Digital Revolution",
      "source": "Variety",
      "author": "Jessica Lee",
      "readTime": "9 min read",
      "savedDate": "2024-01-10",
      "publishDate": "2024-01-07",
      "category": "Entertainment",
      "image": "https://picsum.photos/400/250?random=6&keyword=hollywood",
      "isRead": false,
      "tags": ["Entertainment", "Technology", "Movies"],
      "summary": "How digital technology is transforming the entertainment industry",
    },
  ];

  List<Map<String, dynamic>> get filteredArticles {
    List<Map<String, dynamic>> filtered = savedArticles;

    if (selectedCategory != "All") {
      filtered = filtered.where((article) => article["category"] == selectedCategory).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((article) =>
          (article["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (article["author"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (article["source"] as String).toLowerCase().contains(searchQuery.toLowerCase())
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
                        selectedSortBy = "Date Saved";
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
                    icon: Icons.favorite,
                    title: "Add to Favorites",
                    onTap: () {
                      Navigator.pop(context);
                      ss("${selectedArticles.length} articles added to favorites");
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
                    icon: Icons.archive,
                    title: "Archive",
                    onTap: () {
                      Navigator.pop(context);
                      ss("${selectedArticles.length} articles archived");
                      _exitSelectionMode();
                    },
                  ),
                  _buildBulkActionItem(
                    icon: Icons.delete,
                    title: "Remove from Saved",
                    color: dangerColor,
                    onTap: () async {
                      Navigator.pop(context);
                      bool isConfirmed = await confirm("Remove ${selectedArticles.length} articles from saved?");
                      if (isConfirmed) {
                        ss("${selectedArticles.length} articles removed from saved");
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
                    right: spXs,
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
                        "Saved ${article["savedDate"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Wrap(
                    spacing: spXs,
                    children: (article["tags"] as List).map((tag) {
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
                if (article["isRead"] == true)
                  Positioned(
                    bottom: spXs,
                    right: spXs,
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
                    Text(
                      "${article["readTime"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
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
        title: Text(isSelectionMode ? "${selectedArticles.length} Selected" : "Saved Articles"),
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
                    label: "Search saved articles...",
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
                Text(
                  "${filteredArticles.length} articles",
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
