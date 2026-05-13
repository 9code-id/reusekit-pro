import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDiscover6View extends StatefulWidget {
  @override
  State<GrlDiscover6View> createState() => _GrlDiscover6ViewState();
}

class _GrlDiscover6ViewState extends State<GrlDiscover6View> {
  String searchQuery = "";
  String selectedFilter = "All";
  
  List<Map<String, dynamic>> discoverItems = [
    {
      "id": 1,
      "title": "Hidden Gems in Tokyo",
      "subtitle": "Discover secret spots locals love",
      "image": "https://picsum.photos/400/250?random=1&keyword=tokyo",
      "category": "Travel",
      "author": "Travel Guide Tokyo",
      "readTime": "8 min read",
      "likes": 245,
      "isBookmarked": false,
      "tags": ["Japan", "Culture", "Food", "Architecture"],
      "publishedDate": "2 days ago"
    },
    {
      "id": 2,
      "title": "Master Chef's Secret Recipes",
      "subtitle": "Professional cooking techniques revealed",
      "image": "https://picsum.photos/400/250?random=2&keyword=cooking",
      "category": "Cooking",
      "author": "Chef Maria Santos",
      "readTime": "12 min read",
      "likes": 189,
      "isBookmarked": true,
      "tags": ["Recipes", "Techniques", "Professional", "Tips"],
      "publishedDate": "1 week ago"
    },
    {
      "id": 3,
      "title": "Startup Success Stories",
      "subtitle": "How these companies built billion-dollar businesses",
      "image": "https://picsum.photos/400/250?random=3&keyword=business",
      "category": "Business",
      "author": "Entrepreneur Weekly",
      "readTime": "15 min read",
      "likes": 567,
      "isBookmarked": false,
      "tags": ["Startup", "Success", "Strategy", "Growth"],
      "publishedDate": "3 days ago"
    },
    {
      "id": 4,
      "title": "Future of Artificial Intelligence",
      "subtitle": "What to expect in the next decade",
      "image": "https://picsum.photos/400/250?random=4&keyword=technology",
      "category": "Technology",
      "author": "Tech Insights",
      "readTime": "20 min read",
      "likes": 892,
      "isBookmarked": true,
      "tags": ["AI", "Future", "Innovation", "Research"],
      "publishedDate": "5 days ago"
    },
    {
      "id": 5,
      "title": "Mindfulness in Daily Life",
      "subtitle": "Simple practices for better mental health",
      "image": "https://picsum.photos/400/250?random=5&keyword=meditation",
      "category": "Wellness",
      "author": "Wellness Coach",
      "readTime": "7 min read",
      "likes": 334,
      "isBookmarked": false,
      "tags": ["Mindfulness", "Health", "Meditation", "Lifestyle"],
      "publishedDate": "1 day ago"
    },
    {
      "id": 6,
      "title": "Photography Composition Tips",
      "subtitle": "Take stunning photos with these techniques",
      "image": "https://picsum.photos/400/250?random=6&keyword=photography",
      "category": "Art",
      "author": "Photo Masters",
      "readTime": "10 min read",
      "likes": 423,
      "isBookmarked": false,
      "tags": ["Photography", "Composition", "Tips", "Creative"],
      "publishedDate": "4 days ago"
    }
  ];

  List<String> categories = ["All", "Travel", "Cooking", "Business", "Technology", "Wellness", "Art"];

  List<Map<String, dynamic>> get filteredItems {
    return discoverItems.where((item) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${item["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${item["subtitle"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          (item["tags"] as List).any((tag) => 
            "$tag".toLowerCase().contains(searchQuery.toLowerCase()));

      bool matchesFilter = selectedFilter == "All" ||
          item["category"] == selectedFilter;

      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discover"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () => _showBookmarks(),
          ),
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () => _showNotifications(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Discover Something New",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Explore curated content from experts around the world",
                    style: TextStyle(
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search articles, topics, authors...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {
                    // Perform search
                  },
                ),
              ],
            ),

            // Category Filter
            QCategoryPicker(
              label: "Categories",
              items: categories.map((category) => {
                "label": category,
                "value": category,
              }).toList(),
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),

            // Quick Stats
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${discoverItems.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Articles",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: disabledOutlineBorderColor,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${categories.length - 1}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: secondaryColor,
                          ),
                        ),
                        Text(
                          "Categories",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: disabledOutlineBorderColor,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${discoverItems.fold(0, (sum, item) => sum + (item["likes"] as int))}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Total Likes",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Results Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${filteredItems.length} articles found",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () => _showSortOptions(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.sort,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Sort",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Articles List
            ...filteredItems.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> item = entry.value;
              
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
                    // Image
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                      child: Stack(
                        children: [
                          Image.network(
                            "${item["image"]}",
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: _getCategoryColor("${item["category"]}"),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${item["category"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: GestureDetector(
                              onTap: () => _toggleBookmark(item["id"]),
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  boxShadow: [shadowSm],
                                ),
                                child: Icon(
                                  item["isBookmarked"] ? Icons.bookmark : Icons.bookmark_border,
                                  size: 18,
                                  color: item["isBookmarked"] ? primaryColor : disabledBoldColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Content
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          // Title and Subtitle
                          Text(
                            "${item["title"]}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "${item["subtitle"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),

                          // Author and Meta Info
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: primaryColor.withAlpha(20),
                                child: Text(
                                  "${item["author"]}".substring(0, 1).toUpperCase(),
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${item["author"]}",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${item["publishedDate"]} • ${item["readTime"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.favorite_border,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${item["likes"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // Tags
                          QHorizontalScroll(
                            children: (item["tags"] as List).map((tag) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "#$tag",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                          // Actions
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Read Article",
                                  onPressed: () {
                                    _openArticle(item);
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.share,
                                size: bs.sm,
                                color: secondaryColor,
                                onPressed: () {
                                  _shareArticle(item);
                                },
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

            // Load More Button
            if (filteredItems.isNotEmpty)
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Load More Articles",
                  color: secondaryColor,
                  onPressed: () {
                    si("Loading more articles...");
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Travel":
        return successColor;
      case "Cooking":
        return warningColor;
      case "Business":
        return primaryColor;
      case "Technology":
        return infoColor;
      case "Wellness":
        return successColor;
      case "Art":
        return secondaryColor;
      default:
        return disabledBoldColor;
    }
  }

  void _toggleBookmark(int itemId) {
    final itemIndex = discoverItems.indexWhere((item) => item["id"] == itemId);
    if (itemIndex != -1) {
      discoverItems[itemIndex]["isBookmarked"] = !discoverItems[itemIndex]["isBookmarked"];
      setState(() {});
      
      if (discoverItems[itemIndex]["isBookmarked"]) {
        ss("Article bookmarked!");
      } else {
        si("Bookmark removed");
      }
    }
  }

  void _openArticle(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "${item["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusLg),
                      child: Image.network(
                        "${item["image"]}",
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    
                    Text(
                      "${item["title"]}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Text(
                      "${item["subtitle"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        color: disabledBoldColor,
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.article,
                            size: 48,
                            color: primaryColor.withAlpha(100),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Article Content",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Full article content would be displayed here with proper formatting, images, and interactive elements.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
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
          ],
        ),
      ),
    );
  }

  void _shareArticle(Map<String, dynamic> item) {
    si("Sharing: ${item["title"]}");
  }

  void _showBookmarks() {
    final bookmarkedItems = discoverItems.where((item) => item["isBookmarked"]).toList();
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Bookmarked Articles",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: bookmarkedItems.isEmpty
                ? Center(
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
                          "No bookmarks yet",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Start bookmarking articles you love",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(spMd),
                    itemCount: bookmarkedItems.length,
                    itemBuilder: (context, index) {
                      final item = bookmarkedItems[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(radiusSm),
                              child: Image.network(
                                "${item["image"]}",
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${item["title"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "${item["author"]} • ${item["readTime"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _toggleBookmark(item["id"]),
                              child: Icon(
                                Icons.bookmark,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNotifications() {
    si("No new notifications");
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Text(
              "Sort by",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Icon(Icons.schedule, color: primaryColor),
                    SizedBox(width: spSm),
                    Text("Most Recent"),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Icon(Icons.trending_up, color: successColor),
                    SizedBox(width: spSm),
                    Text("Most Popular"),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Icon(Icons.favorite, color: dangerColor),
                    SizedBox(width: spSm),
                    Text("Most Liked"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
