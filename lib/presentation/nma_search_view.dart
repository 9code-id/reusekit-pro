import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaSearchView extends StatefulWidget {
  const NmaSearchView({super.key});

  @override
  State<NmaSearchView> createState() => _NmaSearchViewState();
}

class _NmaSearchViewState extends State<NmaSearchView> {
  String searchQuery = "";
  String selectedCategory = "all";
  String selectedSort = "relevance";
  String selectedTime = "all";
  bool isLoading = false;

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Web", "value": "web"},
    {"label": "Images", "value": "images"},
    {"label": "Videos", "value": "videos"},
    {"label": "News", "value": "news"},
    {"label": "Shopping", "value": "shopping"},
    {"label": "Maps", "value": "maps"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Relevance", "value": "relevance"},
    {"label": "Date", "value": "date"},
    {"label": "Popularity", "value": "popularity"},
    {"label": "Rating", "value": "rating"},
  ];

  List<Map<String, dynamic>> timeOptions = [
    {"label": "Any time", "value": "all"},
    {"label": "Past hour", "value": "hour"},
    {"label": "Past 24 hours", "value": "day"},
    {"label": "Past week", "value": "week"},
    {"label": "Past month", "value": "month"},
    {"label": "Past year", "value": "year"},
  ];

  List<String> recentSearches = [
    "Flutter development",
    "Best restaurants near me",
    "Weather forecast",
    "Machine learning tutorial",
    "Stock market today",
    "Healthy recipes",
    "Travel destinations 2025",
    "Smartphone reviews",
  ];

  List<String> trendingSearches = [
    "Olympics 2025",
    "AI breakthrough",
    "Climate change summit",
    "New smartphone launch",
    "Cryptocurrency update",
    "Space mission",
    "Electric vehicles",
    "Renewable energy",
    "Virtual reality gaming",
    "Quantum computing",
  ];

  List<String> suggestedSearches = [
    "How to cook pasta",
    "Best movies 2025",
    "Learn programming",
    "Home workout routines",
    "Investment strategies",
    "Photography tips",
    "Gardening guide",
    "Online courses",
  ];

  Widget _buildSearchSuggestions() {
    if (searchQuery.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (recentSearches.isNotEmpty) ...[
            Text(
              "Recent Searches",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Wrap(
              spacing: spSm,
              runSpacing: spSm,
              children: recentSearches.take(6).map((search) {
                return GestureDetector(
                  onTap: () {
                    searchQuery = search;
                    setState(() {});
                    _performSearch();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.history,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          search,
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Clear Recent Searches",
                    size: bs.sm,
                    onPressed: () async {
                      bool isConfirmed = await confirm("Clear all recent searches?");
                      if (isConfirmed) {
                        recentSearches.clear();
                        setState(() {});
                        ss("Recent searches cleared");
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spXl),
          ],
          
          Text(
            "Trending Now",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            children: trendingSearches.take(8).map((search) {
              int index = trendingSearches.indexOf(search) + 1;
              return GestureDetector(
                onTap: () {
                  searchQuery = search;
                  setState(() {});
                  _performSearch();
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: index <= 3 ? primaryColor : disabledColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Center(
                          child: Text(
                            "$index",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Text(
                          search,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.trending_up,
                        color: successColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          
          SizedBox(height: spXl),
          Text(
            "Suggested for You",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: suggestedSearches.map((search) {
              return GestureDetector(
                onTap: () {
                  searchQuery = search;
                  setState(() {});
                  _performSearch();
                },
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: warningColor,
                        size: 24,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        search,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Suggested search",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      );
    }
    
    // Show search suggestions based on current query
    List<String> allSearches = [...recentSearches, ...trendingSearches, ...suggestedSearches];
    List<String> filteredSuggestions = allSearches
        .where((search) => search.toLowerCase().contains(searchQuery.toLowerCase()))
        .take(8)
        .toList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Search Suggestions",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        if (filteredSuggestions.isEmpty)
          Container(
            padding: EdgeInsets.all(spXl),
            child: Column(
              children: [
                Icon(
                  Icons.search_off,
                  size: 64,
                  color: disabledColor,
                ),
                SizedBox(height: spMd),
                Text(
                  "No suggestions found",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spMd),
                QButton(
                  label: "Search Anyway",
                  size: bs.sm,
                  onPressed: () {
                    _performSearch();
                  },
                ),
              ],
            ),
          )
        else
          Column(
            children: filteredSuggestions.map((suggestion) {
              return GestureDetector(
                onTap: () {
                  searchQuery = suggestion;
                  setState(() {});
                  _performSearch();
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              color: primaryColor,
                            ),
                            children: _highlightMatch(suggestion, searchQuery),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.north_west,
                        color: disabledBoldColor,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  List<TextSpan> _highlightMatch(String text, String query) {
    if (query.isEmpty) {
      return [TextSpan(text: text)];
    }
    
    List<TextSpan> spans = [];
    String lowerText = text.toLowerCase();
    String lowerQuery = query.toLowerCase();
    
    int start = 0;
    int index = lowerText.indexOf(lowerQuery);
    
    while (index != -1) {
      if (index > start) {
        spans.add(TextSpan(text: text.substring(start, index)));
      }
      
      spans.add(TextSpan(
        text: text.substring(index, index + query.length),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          backgroundColor: primaryColor.withAlpha(30),
        ),
      ));
      
      start = index + query.length;
      index = lowerText.indexOf(lowerQuery, start);
    }
    
    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start)));
    }
    
    return spans;
  }

  Widget _buildQuickFilters() {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QHorizontalScroll(
            children: [
              ...categoryOptions.where((cat) => cat["value"] != "all").map((category) {
                bool isSelected = selectedCategory == category["value"];
                return GestureDetector(
                  onTap: () {
                    selectedCategory = isSelected ? "all" : category["value"];
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getCategoryIcon(category["value"]),
                          size: 16,
                          color: isSelected ? Colors.white : primaryColor,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${category["label"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "web":
        return Icons.language;
      case "images":
        return Icons.image;
      case "videos":
        return Icons.video_library;
      case "news":
        return Icons.article;
      case "shopping":
        return Icons.shopping_bag;
      case "maps":
        return Icons.map;
      default:
        return Icons.search;
    }
  }

  void _performSearch() {
    if (searchQuery.trim().isEmpty) return;
    
    // Add to recent searches if not already there
    if (!recentSearches.contains(searchQuery)) {
      recentSearches.insert(0, searchQuery);
      if (recentSearches.length > 10) {
        recentSearches.removeLast();
      }
    } else {
      // Move to top if already exists
      recentSearches.remove(searchQuery);
      recentSearches.insert(0, searchQuery);
    }
    
    // Navigate to search results
    // Navigator.push(context, MaterialPageRoute(builder: (context) => NmaSearchResultsView()));
    ss("Searching for: $searchQuery");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
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
                    label: "Search anything...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spMd),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {
                    _performSearch();
                  },
                ),
              ],
            ),
            SizedBox(height: spMd),
            
            _buildQuickFilters(),
            
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Sort by",
                    items: sortOptions,
                    value: selectedSort,
                    onChanged: (value, label) {
                      selectedSort = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: QDropdownField(
                    label: "Time filter",
                    items: timeOptions,
                    value: selectedTime,
                    onChanged: (value, label) {
                      selectedTime = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.tips_and_updates,
                    color: infoColor,
                    size: 24,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Search Tips",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Use quotes for exact phrases, + for required words, - to exclude terms",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor.withAlpha(200),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),
            
            _buildSearchSuggestions(),
          ],
        ),
      ),
    );
  }
}
