import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDiscover10View extends StatefulWidget {
  @override
  State<GrlDiscover10View> createState() => _GrlDiscover10ViewState();
}

class _GrlDiscover10ViewState extends State<GrlDiscover10View> {
  String searchQuery = "";
  String selectedFilter = "All";
  String sortBy = "Relevance";
  
  List<Map<String, dynamic>> discoverResults = [
    {
      "id": 1,
      "title": "AI Revolution in Healthcare",
      "type": "Research Paper",
      "description": "Comprehensive study on how artificial intelligence is transforming medical diagnosis and treatment protocols",
      "image": "https://picsum.photos/400/300?random=1&keyword=medical",
      "source": "Medical Journal",
      "publishedDate": "March 15, 2024",
      "readTime": "25 min",
      "downloads": 1250,
      "citations": 89,
      "rating": 4.8,
      "tags": ["AI", "Healthcare", "Research", "Medicine"],
      "category": "Research",
      "isPremium": false,
      "isBookmarked": false
    },
    {
      "id": 2,
      "title": "Sustainable Architecture Innovations",
      "type": "Case Study",
      "description": "Exploring cutting-edge sustainable building techniques and their environmental impact in modern construction",
      "image": "https://picsum.photos/400/300?random=2&keyword=architecture",
      "source": "Architecture Today",
      "publishedDate": "March 12, 2024",
      "readTime": "18 min",
      "downloads": 890,
      "citations": 45,
      "rating": 4.6,
      "tags": ["Architecture", "Sustainability", "Environment", "Design"],
      "category": "Design",
      "isPremium": true,
      "isBookmarked": true
    },
    {
      "id": 3,
      "title": "Quantum Computing Breakthrough",
      "type": "News Article",
      "description": "Latest developments in quantum computing technology and its potential applications in cryptography and data processing",
      "image": "https://picsum.photos/400/300?random=3&keyword=quantum",
      "source": "Tech News Network",
      "publishedDate": "March 18, 2024",
      "readTime": "12 min",
      "downloads": 2100,
      "citations": 156,
      "rating": 4.9,
      "tags": ["Quantum", "Computing", "Technology", "Innovation"],
      "category": "Technology",
      "isPremium": false,
      "isBookmarked": false
    },
    {
      "id": 4,
      "title": "Climate Change Mitigation Strategies",
      "type": "Policy Document",
      "description": "Government initiatives and international policies aimed at reducing global carbon emissions and environmental impact",
      "image": "https://picsum.photos/400/300?random=4&keyword=climate",
      "source": "Environmental Policy Institute",
      "publishedDate": "March 10, 2024",
      "readTime": "35 min",
      "downloads": 756,
      "citations": 234,
      "rating": 4.7,
      "tags": ["Climate", "Policy", "Environment", "Sustainability"],
      "category": "Environment",
      "isPremium": true,
      "isBookmarked": true
    },
    {
      "id": 5,
      "title": "Blockchain in Financial Services",
      "type": "Industry Report",
      "description": "Comprehensive analysis of blockchain technology adoption in banking and financial institutions worldwide",
      "image": "https://picsum.photos/400/300?random=5&keyword=blockchain",
      "source": "Financial Innovation Lab",
      "publishedDate": "March 8, 2024",
      "readTime": "28 min",
      "downloads": 1456,
      "citations": 123,
      "rating": 4.5,
      "tags": ["Blockchain", "Finance", "Banking", "Innovation"],
      "category": "Finance",
      "isPremium": false,
      "isBookmarked": false
    },
    {
      "id": 6,
      "title": "Future of Remote Education",
      "type": "Educational Study",
      "description": "Analysis of remote learning effectiveness and technological solutions for improved online education delivery",
      "image": "https://picsum.photos/400/300?random=6&keyword=education",
      "source": "Education Research Foundation",
      "publishedDate": "March 5, 2024",
      "readTime": "22 min",
      "downloads": 1123,
      "citations": 67,
      "rating": 4.4,
      "tags": ["Education", "Remote Learning", "Technology", "Online"],
      "category": "Education",
      "isPremium": true,
      "isBookmarked": false
    }
  ];

  List<String> filters = ["All", "Research", "Technology", "Design", "Environment", "Finance", "Education"];
  List<String> sortOptions = ["Relevance", "Most Recent", "Most Downloaded", "Highest Rated", "Most Cited"];

  List<Map<String, dynamic>> get filteredResults {
    var filtered = discoverResults.where((result) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${result["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${result["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${result["source"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          (result["tags"] as List).any((tag) => 
            "$tag".toLowerCase().contains(searchQuery.toLowerCase()));

      bool matchesFilter = selectedFilter == "All" ||
          result["category"] == selectedFilter;

      return matchesSearch && matchesFilter;
    }).toList();

    // Sort results
    switch (sortBy) {
      case "Most Recent":
        filtered.sort((a, b) => DateTime.parse("2024-03-${20 - (a["id"] as int)}")
            .compareTo(DateTime.parse("2024-03-${20 - (b["id"] as int)}")));
        break;
      case "Most Downloaded":
        filtered.sort((a, b) => (b["downloads"] as int).compareTo(a["downloads"] as int));
        break;
      case "Highest Rated":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "Most Cited":
        filtered.sort((a, b) => (b["citations"] as int).compareTo(a["citations"] as int));
        break;
      default:
        // Keep original order for "Relevance"
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discover Library"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () => _showBookmarks(),
          ),
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () => _showSearchHistory(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Search Section
            Container(
              margin: EdgeInsets.all(spMd),
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
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Discover Knowledge",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Explore research papers, articles, and industry reports",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  // Search Statistics
                  Row(
                    children: [
                      _buildSearchStat("${discoverResults.length}M", "Documents"),
                      SizedBox(width: spMd),
                      _buildSearchStat("${filters.length - 1}", "Categories"),
                      SizedBox(width: spMd),
                      _buildSearchStat("24/7", "Access"),
                    ],
                  ),
                ],
              ),
            ),

            // Advanced Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Search papers, articles, reports...",
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
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.tune,
                          size: bs.sm,
                          color: secondaryColor,
                          onPressed: () => _showAdvancedSearch(),
                        ),
                      ],
                    ),
                    
                    // Quick Filters
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Category",
                            items: filters.map((filter) => {
                              "label": filter,
                              "value": filter,
                            }).toList(),
                            value: selectedFilter,
                            onChanged: (value, label) {
                              selectedFilter = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Sort by",
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
                  ],
                ),
              ),
            ),

            SizedBox(height: spMd),

            // Search Results Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${filteredResults.length} results found",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      if (searchQuery.isNotEmpty || selectedFilter != "All")
                        Text(
                          "for '${_getSearchDescription()}'",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => _showViewOptions(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.view_list,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "List View",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Search Results
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredResults.length,
              itemBuilder: (context, index) {
                final result = filteredResults[index];
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
                      // Image and Premium Badge
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                        child: Stack(
                          children: [
                            Image.network(
                              "${result["image"]}",
                              height: 140,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            if (result["isPremium"])
                              Positioned(
                                top: spSm,
                                left: spSm,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: warningColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "PREMIUM",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
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
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getTypeColor("${result["type"]}"),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${result["type"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
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
                            // Title and Bookmark
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${result["title"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => _toggleBookmark(result["id"]),
                                  child: Icon(
                                    result["isBookmarked"] ? Icons.bookmark : Icons.bookmark_border,
                                    color: result["isBookmarked"] ? primaryColor : disabledBoldColor,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),

                            // Description
                            Text(
                              "${result["description"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                            // Source and Date
                            Row(
                              children: [
                                Icon(
                                  Icons.source,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${result["source"]} • ${result["publishedDate"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),

                            // Stats Row
                            Row(
                              children: [
                                _buildStatChip(Icons.download, "${result["downloads"]}", successColor),
                                SizedBox(width: spSm),
                                _buildStatChip(Icons.format_quote, "${result["citations"]}", infoColor),
                                SizedBox(width: spSm),
                                _buildStatChip(Icons.star, "${result["rating"]}", warningColor),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(10),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${result["readTime"]}",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Tags
                            QHorizontalScroll(
                              children: (result["tags"] as List).take(4).map((tag) {
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

                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: result["isPremium"] ? "Premium Access" : "View Document",
                                    color: result["isPremium"] ? warningColor : primaryColor,
                                    onPressed: () {
                                      _viewDocument(result);
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.share,
                                  size: bs.sm,
                                  color: secondaryColor,
                                  onPressed: () {
                                    _shareDocument(result);
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
              },
            ),

            // Load More Results
            if (filteredResults.isNotEmpty)
              Container(
                margin: EdgeInsets.all(spMd),
                width: double.infinity,
                child: QButton(
                  label: "Load More Results",
                  color: secondaryColor,
                  onPressed: () {
                    si("Loading more results...");
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchStat(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withAlpha(200),
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildStatChip(IconData icon, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: color,
          ),
          SizedBox(width: spXs),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Research Paper":
        return primaryColor;
      case "Case Study":
        return successColor;
      case "News Article":
        return infoColor;
      case "Policy Document":
        return warningColor;
      case "Industry Report":
        return secondaryColor;
      case "Educational Study":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getSearchDescription() {
    List<String> parts = [];
    if (searchQuery.isNotEmpty) parts.add(searchQuery);
    if (selectedFilter != "All") parts.add(selectedFilter);
    return parts.join(" in ");
  }

  void _toggleBookmark(int resultId) {
    final resultIndex = discoverResults.indexWhere((result) => result["id"] == resultId);
    if (resultIndex != -1) {
      discoverResults[resultIndex]["isBookmarked"] = !discoverResults[resultIndex]["isBookmarked"];
      setState(() {});
      
      if (discoverResults[resultIndex]["isBookmarked"]) {
        ss("Document bookmarked!");
      } else {
        si("Bookmark removed");
      }
    }
  }

  void _viewDocument(Map<String, dynamic> result) {
    if (result["isPremium"]) {
      _showPremiumModal(result);
    } else {
      si("Opening: ${result["title"]}");
    }
  }

  void _shareDocument(Map<String, dynamic> result) {
    si("Sharing: ${result["title"]}");
  }

  void _showPremiumModal(Map<String, dynamic> result) {
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
          spacing: spMd,
          children: [
            Icon(
              Icons.star,
              size: 48,
              color: warningColor,
            ),
            Text(
              "Premium Content",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              "This document requires a premium subscription to access. Upgrade to unlock all premium content.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Cancel",
                    color: disabledBoldColor,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Upgrade Now",
                    color: warningColor,
                    onPressed: () {
                      Navigator.pop(context);
                      si("Redirecting to premium subscription...");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showBookmarks() {
    final bookmarkedResults = discoverResults.where((result) => result["isBookmarked"]).toList();
    
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
                      "Bookmarked Documents",
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
              child: bookmarkedResults.isEmpty
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
                          "Start bookmarking documents you want to read later",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(spMd),
                    itemCount: bookmarkedResults.length,
                    itemBuilder: (context, index) {
                      final result = bookmarkedResults[index];
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
                                "${result["image"]}",
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
                                    "${result["title"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "${result["source"]} • ${result["readTime"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _toggleBookmark(result["id"]),
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

  void _showSearchHistory() {
    si("Search history feature coming soon");
  }

  void _showAdvancedSearch() {
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
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Advanced Search",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
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
            SizedBox(height: spMd),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      size: 64,
                      color: primaryColor.withAlpha(100),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Advanced Search Options",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Date range, author filters, keyword matching, and more advanced search features would be available here",
                      textAlign: TextAlign.center,
                      style: TextStyle(
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

  void _showViewOptions() {
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
              "View Options",
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
                    Icon(Icons.view_list, color: primaryColor),
                    SizedBox(width: spSm),
                    Text("List View"),
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
                    Icon(Icons.grid_view, color: disabledBoldColor),
                    SizedBox(width: spSm),
                    Text("Grid View"),
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
                    Icon(Icons.view_comfortable, color: disabledBoldColor),
                    SizedBox(width: spSm),
                    Text("Compact View"),
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
