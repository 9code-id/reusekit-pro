import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaSearchView extends StatefulWidget {
  const FdaSearchView({super.key});

  @override
  State<FdaSearchView> createState() => _FdaSearchViewState();
}

class _FdaSearchViewState extends State<FdaSearchView> {
  String searchQuery = "";
  String selectedCategory = "All";
  List<Map<String, dynamic>> recentSearches = [
    {"query": "Pizza", "icon": Icons.local_pizza},
    {"query": "Burger", "icon": Icons.lunch_dining},
    {"query": "Sushi", "icon": Icons.ramen_dining},
    {"query": "Chinese Food", "icon": Icons.restaurant},
    {"query": "Italian", "icon": Icons.restaurant_menu},
  ];

  List<Map<String, dynamic>> popularSearches = [
    {"query": "McDonald's", "type": "Restaurant"},
    {"query": "KFC", "type": "Restaurant"},
    {"query": "Starbucks", "type": "Restaurant"},
    {"query": "Pizza Hut", "type": "Restaurant"},
    {"query": "Subway", "type": "Restaurant"},
    {"query": "Chicken Wings", "type": "Food"},
    {"query": "Ice Cream", "type": "Food"},
    {"query": "Tacos", "type": "Food"},
  ];

  List<Map<String, dynamic>> categories = [
    {"name": "All", "icon": Icons.apps},
    {"name": "Fast Food", "icon": Icons.fastfood},
    {"name": "Pizza", "icon": Icons.local_pizza},
    {"name": "Asian", "icon": Icons.ramen_dining},
    {"name": "Dessert", "icon": Icons.cake},
    {"name": "Coffee", "icon": Icons.local_cafe},
  ];

  void _performSearch() {
    if (searchQuery.trim().isNotEmpty) {
      // Add to recent searches if not already there
      bool exists = recentSearches.any((item) => item["query"].toLowerCase() == searchQuery.toLowerCase());
      if (!exists) {
        recentSearches.insert(0, {
          "query": searchQuery,
          "icon": Icons.search,
        });
        if (recentSearches.length > 5) {
          recentSearches.removeLast();
        }
      }
      setState(() {});
      ss("Searching for '$searchQuery'");
    }
  }

  void _clearRecentSearches() async {
    bool isConfirmed = await confirm("Clear all recent searches?");
    if (isConfirmed) {
      recentSearches.clear();
      setState(() {});
      ss("Recent searches cleared");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Input
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Search restaurants, food...",
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
                    onPressed: _performSearch,
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Category Filter
            Text(
              "Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            QHorizontalScroll(
              children: categories.map((category) {
                bool isSelected = selectedCategory == category["name"];
                return GestureDetector(
                  onTap: () {
                    selectedCategory = category["name"];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: 1,
                      ),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          category["icon"],
                          size: 20,
                          color: isSelected ? Colors.white : disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${category["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spLg),

            // Recent Searches
            if (recentSearches.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent Searches",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: _clearRecentSearches,
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
              ...recentSearches.map((search) {
                return Container(
                  margin: EdgeInsets.only(bottom: spXs),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    leading: Icon(
                      search["icon"],
                      color: disabledBoldColor,
                      size: 20,
                    ),
                    title: Text(
                      "${search["query"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        recentSearches.remove(search);
                        setState(() {});
                      },
                      child: Icon(
                        Icons.close,
                        color: disabledBoldColor,
                        size: 18,
                      ),
                    ),
                    onTap: () {
                      searchQuery = search["query"];
                      _performSearch();
                    },
                  ),
                );
              }).toList(),
              SizedBox(height: spLg),
            ],

            // Popular Searches
            Text(
              "Popular Searches",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: popularSearches.map((search) {
                return GestureDetector(
                  onTap: () {
                    searchQuery = search["query"];
                    _performSearch();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: disabledOutlineBorderColor,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          search["type"] == "Restaurant" ? Icons.restaurant : Icons.fastfood,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${search["query"]}",
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
            SizedBox(height: spLg),

            // Quick Actions
            Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: primaryColor.withAlpha(50),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: primaryColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Nearby",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Find restaurants near you",
                          textAlign: TextAlign.center,
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
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: successColor.withAlpha(50),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.local_offer,
                          color: successColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Deals",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Browse special offers",
                          textAlign: TextAlign.center,
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
          ],
        ),
      ),
    );
  }
}
