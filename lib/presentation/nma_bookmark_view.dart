import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaBookmarkView extends StatefulWidget {
  const NmaBookmarkView({super.key});

  @override
  State<NmaBookmarkView> createState() => _NmaBookmarkViewState();
}

class _NmaBookmarkViewState extends State<NmaBookmarkView> {
  String selectedCategory = "All";
  List<String> categories = ["All", "Breaking News", "Politics", "Technology", "Sports", "Business", "Health"];
  
  String sortBy = "Recent";
  List<String> sortOptions = ["Recent", "Oldest", "Title A-Z", "Title Z-A", "Source"];
  
  bool isGridView = false;
  
  List<Map<String, dynamic>> bookmarkedArticles = [
    {
      "id": 1,
      "title": "Global Climate Summit Reaches Historic Agreement",
      "source": "Environmental News",
      "author": "Dr. Sarah Johnson",
      "publishDate": "2024-03-15",
      "bookmarkDate": "2024-03-15",
      "category": "Breaking News",
      "image": "https://picsum.photos/300/200?random=1&keyword=climate",
      "readTime": "5 min read",
      "isRead": true,
      "tags": ["Climate", "Environment", "Politics"],
      "summary": "World leaders unite in unprecedented climate action plan...",
    },
    {
      "id": 2,
      "title": "Revolutionary AI Technology Transforms Healthcare",
      "source": "Tech Today",
      "author": "Alex Chen",
      "publishDate": "2024-03-14",
      "bookmarkDate": "2024-03-14",
      "category": "Technology",
      "image": "https://picsum.photos/300/200?random=2&keyword=healthcare",
      "readTime": "7 min read",
      "isRead": false,
      "tags": ["AI", "Healthcare", "Innovation"],
      "summary": "New AI system achieves 97% accuracy in medical diagnosis...",
    },
    {
      "id": 3,
      "title": "Stock Market Hits All-Time High Amid Economic Recovery",
      "source": "Financial Times",
      "author": "Michael Rodriguez",
      "publishDate": "2024-03-13",
      "bookmarkDate": "2024-03-13",
      "category": "Business",
      "image": "https://picsum.photos/300/200?random=3&keyword=stocks",
      "readTime": "4 min read",
      "isRead": true,
      "tags": ["Stocks", "Economy", "Finance"],
      "summary": "Markets surge following positive economic indicators...",
    },
    {
      "id": 4,
      "title": "Olympic Games Preparation Enters Final Phase",
      "source": "Sports Weekly",
      "author": "Emma Wilson",
      "publishDate": "2024-03-12",
      "bookmarkDate": "2024-03-12",
      "category": "Sports",
      "image": "https://picsum.photos/300/200?random=4&keyword=olympics",
      "readTime": "6 min read",
      "isRead": false,
      "tags": ["Olympics", "Sports", "International"],
      "summary": "Athletes and organizers make final preparations...",
    },
    {
      "id": 5,
      "title": "Breakthrough in Cancer Research Shows Promise",
      "source": "Medical Journal",
      "author": "Dr. Lisa Park",
      "publishDate": "2024-03-11",
      "bookmarkDate": "2024-03-11",
      "category": "Health",
      "image": "https://picsum.photos/300/200?random=5&keyword=medical",
      "readTime": "8 min read",
      "isRead": true,
      "tags": ["Cancer", "Research", "Medicine"],
      "summary": "New treatment shows 85% success rate in trials...",
    },
    {
      "id": 6,
      "title": "Space Mission Discovers Potential Life Signs",
      "source": "Space News",
      "author": "Dr. James Miller",
      "publishDate": "2024-03-10",
      "bookmarkDate": "2024-03-10",
      "category": "Technology",
      "image": "https://picsum.photos/300/200?random=6&keyword=space",
      "readTime": "9 min read",
      "isRead": false,
      "tags": ["Space", "Discovery", "Science"],
      "summary": "Mars rover detects organic compounds suggesting...",
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredArticles = _getFilteredArticles();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookmarks"),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              isGridView = !isGridView;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              _showSortOptions();
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _showSearchDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: spSm),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                String category = categories[index];
                bool isSelected = selectedCategory == category;
                
                return GestureDetector(
                  onTap: () {
                    selectedCategory = category;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: spXs, top: spXs, bottom: spXs),
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : disabledColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : disabledBoldColor,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Stats Bar
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor,
            ),
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
                SizedBox(width: spSm),
                Text(
                  "•",
                  style: TextStyle(color: disabledBoldColor),
                ),
                SizedBox(width: spSm),
                Text(
                  "${filteredArticles.where((a) => !(a["isRead"] as bool)).length} unread",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  "Sort by: $sortBy",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          // Articles List/Grid
          Expanded(
            child: filteredArticles.isEmpty
                ? _buildEmptyState()
                : isGridView
                    ? _buildGridView(filteredArticles)
                    : _buildListView(filteredArticles),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showQuickActions();
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.bookmark_add, color: Colors.white),
      ),
    );
  }

  Widget _buildListView(List<Map<String, dynamic>> articles) {
    return ListView.builder(
      padding: EdgeInsets.all(spSm),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        bool isRead = article["isRead"] as bool;
        
        return Dismissible(
          key: Key("${article["id"]}"),
          background: Container(
            color: dangerColor,
            padding: EdgeInsets.symmetric(horizontal: spMd),
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.delete, color: Colors.white),
                SizedBox(width: spXs),
                Text(
                  "Remove",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            _removeBookmark(article["id"] as int);
          },
          child: Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border.all(
                color: isRead ? disabledOutlineBorderColor : primaryColor,
                width: isRead ? 1 : 2,
              ),
            ),
            child: Row(
              children: [
                // Article Image
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                    image: DecorationImage(
                      image: NetworkImage("${article["image"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: !isRead
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusSm),
                            color: primaryColor.withAlpha(128),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.fiber_new,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        )
                      : null,
                ),
                SizedBox(width: spSm),

                // Article Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category Badge
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${article["category"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: spXs),

                      // Title
                      Text(
                        "${article["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: spXs),

                      // Source and Date
                      Row(
                        children: [
                          Text(
                            "${article["source"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "•",
                            style: TextStyle(color: disabledBoldColor),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${article["readTime"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),

                      // Bookmark Date
                      Row(
                        children: [
                          Icon(
                            Icons.bookmark,
                            size: 12,
                            color: primaryColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Saved ${article["bookmarkDate"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Action Buttons
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.share),
                      color: disabledBoldColor,
                      onPressed: () {
                        ss("Article shared");
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.more_vert),
                      color: disabledBoldColor,
                      onPressed: () {
                        _showArticleOptions(article);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGridView(List<Map<String, dynamic>> articles) {
    return GridView.builder(
      padding: EdgeInsets.all(spSm),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: spSm,
        mainAxisSpacing: spSm,
      ),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        bool isRead = article["isRead"] as bool;
        
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
            border: Border.all(
              color: isRead ? disabledOutlineBorderColor : primaryColor,
              width: isRead ? 1 : 2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                    image: DecorationImage(
                      image: NetworkImage("${article["image"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      if (!isRead)
                        Positioned(
                          top: spXs,
                          right: spXs,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.fiber_new,
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
                        ),
                      Positioned(
                        top: spXs,
                        left: spXs,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(128),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${article["category"]}",
                            style: TextStyle(
                              fontSize: 9,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Content
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        "${article["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Spacer(),

                      // Source and Date
                      Text(
                        "${article["source"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
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
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bookmark_border,
            size: 64,
            color: disabledBoldColor,
          ),
          SizedBox(height: spMd),
          Text(
            "No Bookmarks Yet",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Start bookmarking articles to read them later",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
              height: 1.5,
            ),
          ),
          SizedBox(height: spMd),
          QButton(
            label: "Explore Articles",
            size: bs.sm,
            onPressed: () {
              // Navigate to explore
            },
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredArticles() {
    List<Map<String, dynamic>> filtered = bookmarkedArticles;
    
    // Filter by category
    if (selectedCategory != "All") {
      filtered = filtered.where((article) => article["category"] == selectedCategory).toList();
    }
    
    // Sort articles
    switch (sortBy) {
      case "Recent":
        filtered.sort((a, b) => b["bookmarkDate"].compareTo(a["bookmarkDate"]));
        break;
      case "Oldest":
        filtered.sort((a, b) => a["bookmarkDate"].compareTo(b["bookmarkDate"]));
        break;
      case "Title A-Z":
        filtered.sort((a, b) => a["title"].compareTo(b["title"]));
        break;
      case "Title Z-A":
        filtered.sort((a, b) => b["title"].compareTo(a["title"]));
        break;
      case "Source":
        filtered.sort((a, b) => a["source"].compareTo(b["source"]));
        break;
    }
    
    return filtered;
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sort Articles",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            
            Column(
              children: sortOptions.map((option) {
                bool isSelected = sortBy == option;
                return GestureDetector(
                  onTap: () {
                    sortBy = option;
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor.withAlpha(51) : null,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Text(
                          option,
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                        Spacer(),
                        if (isSelected)
                          Icon(Icons.check, color: primaryColor, size: 20),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _showSearchDialog() {
    // Show search dialog implementation
    ss("Search functionality");
  }

  void _showQuickActions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            
            Row(
              children: [
                Icon(Icons.download, color: primaryColor),
                SizedBox(width: spSm),
                Text("Download All for Offline", style: TextStyle(color: primaryColor)),
              ],
            ),
            SizedBox(height: spSm),
            
            Row(
              children: [
                Icon(Icons.mark_email_read, color: primaryColor),
                SizedBox(width: spSm),
                Text("Mark All as Read", style: TextStyle(color: primaryColor)),
              ],
            ),
            SizedBox(height: spSm),
            
            Row(
              children: [
                Icon(Icons.delete_sweep, color: dangerColor),
                SizedBox(width: spSm),
                Text("Clear All Bookmarks", style: TextStyle(color: dangerColor)),
              ],
            ),
            SizedBox(height: spSm),
            
            Row(
              children: [
                Icon(Icons.file_download, color: primaryColor),
                SizedBox(width: spSm),
                Text("Export Bookmarks", style: TextStyle(color: primaryColor)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showArticleOptions(Map<String, dynamic> article) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Article Options",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            
            Row(
              children: [
                Icon(Icons.visibility, color: primaryColor),
                SizedBox(width: spSm),
                Text("Mark as Read", style: TextStyle(color: primaryColor)),
              ],
            ),
            SizedBox(height: spSm),
            
            Row(
              children: [
                Icon(Icons.download, color: primaryColor),
                SizedBox(width: spSm),
                Text("Download for Offline", style: TextStyle(color: primaryColor)),
              ],
            ),
            SizedBox(height: spSm),
            
            Row(
              children: [
                Icon(Icons.share, color: primaryColor),
                SizedBox(width: spSm),
                Text("Share Article", style: TextStyle(color: primaryColor)),
              ],
            ),
            SizedBox(height: spSm),
            
            Row(
              children: [
                Icon(Icons.bookmark_remove, color: dangerColor),
                SizedBox(width: spSm),
                Text("Remove Bookmark", style: TextStyle(color: dangerColor)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _removeBookmark(int articleId) {
    bookmarkedArticles.removeWhere((article) => article["id"] == articleId);
    setState(() {});
    ss("Bookmark removed");
  }
}
