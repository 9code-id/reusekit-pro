import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsSearchView extends StatefulWidget {
  const EcsSearchView({super.key});

  @override
  State<EcsSearchView> createState() => _EcsSearchViewState();
}

class _EcsSearchViewState extends State<EcsSearchView> {
  String searchQuery = "";
  List<String> searchHistory = [
    "Bluetooth headphones",
    "Running shoes",
    "Laptop backpack",
    "Wireless charger",
    "Gaming mouse",
  ];
  
  List<String> trendingSearches = [
    "iPhone 15",
    "Samsung Galaxy",
    "MacBook Pro",
    "AirPods Pro",
    "iPad Air",
    "Apple Watch",
    "PlayStation 5",
    "Nintendo Switch",
  ];
  
  List<String> popularCategories = [
    "Electronics",
    "Fashion",
    "Home & Garden",
    "Sports",
    "Books",
    "Beauty",
    "Automotive",
    "Toys",
  ];

  List<Map<String, dynamic>> quickSuggestions = [
    {
      "text": "Best sellers",
      "icon": Icons.trending_up,
    },
    {
      "text": "New arrivals",
      "icon": Icons.new_releases,
    },
    {
      "text": "On sale",
      "icon": Icons.local_offer,
    },
    {
      "text": "Free shipping",
      "icon": Icons.local_shipping,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Products"),
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search for products...",
                    value: searchQuery,
                    hint: "Enter product name, brand, or category",
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
                  onPressed: () => _performSearch(),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Suggestions
            Text(
              "Quick Suggestions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: quickSuggestions.map((suggestion) {
                return GestureDetector(
                  onTap: () => _searchSuggestion("${suggestion["text"]}"),
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          suggestion["icon"] as IconData,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${suggestion["text"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Popular Categories
            Text(
              "Popular Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            QHorizontalScroll(
              children: popularCategories.map((category) {
                return GestureDetector(
                  onTap: () => _searchCategory(category),
                  child: Container(
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.symmetric(
                      horizontal: spMd,
                      vertical: spSm,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Trending Searches
            Text(
              "Trending Searches",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            Column(
              children: trendingSearches.map((search) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  child: Row(
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _searchTrending(search),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spMd,
                              vertical: spSm,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                              boxShadow: [shadowSm],
                            ),
                            child: Text(
                              search,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: disabledBoldColor,
                        size: 16,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Search History
            if (searchHistory.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent Searches",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _clearSearchHistory(),
                    child: Text(
                      "Clear All",
                      style: TextStyle(
                        fontSize: 14,
                        color: dangerColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              
              Column(
                children: searchHistory.map((search) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Row(
                      children: [
                        Icon(
                          Icons.history,
                          color: disabledBoldColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _searchFromHistory(search),
                            child: Text(
                              search,
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _removeFromHistory(search),
                          child: Icon(
                            Icons.close,
                            color: disabledBoldColor,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
            
            SizedBox(height: spMd),
            
            // Search Tips
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(26),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(51)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Search Tips",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  ...[
                    "Use specific product names for better results",
                    "Try brand names like 'Apple iPhone' or 'Samsung Galaxy'",
                    "Search by category like 'Electronics' or 'Fashion'",
                    "Use filters to narrow down your search results",
                  ].map((tip) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: spXs),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 6),
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: infoColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              tip,
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _performSearch() {
    if (searchQuery.trim().isNotEmpty) {
      _addToSearchHistory(searchQuery);
      // Navigate to search results
      ss("Searching for: $searchQuery");
    }
  }

  void _searchSuggestion(String suggestion) {
    searchQuery = suggestion;
    _addToSearchHistory(suggestion);
    setState(() {});
    _performSearch();
  }

  void _searchCategory(String category) {
    searchQuery = category;
    _addToSearchHistory(category);
    setState(() {});
    _performSearch();
  }

  void _searchTrending(String trending) {
    searchQuery = trending;
    _addToSearchHistory(trending);
    setState(() {});
    _performSearch();
  }

  void _searchFromHistory(String search) {
    searchQuery = search;
    setState(() {});
    _performSearch();
  }

  void _addToSearchHistory(String search) {
    if (!searchHistory.contains(search)) {
      searchHistory.insert(0, search);
      if (searchHistory.length > 10) {
        searchHistory.removeLast();
      }
      setState(() {});
    }
  }

  void _removeFromHistory(String search) {
    searchHistory.remove(search);
    setState(() {});
  }

  void _clearSearchHistory() {
    searchHistory.clear();
    setState(() {});
    ss("Search history cleared");
  }
}
