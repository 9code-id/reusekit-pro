import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsSortView extends StatefulWidget {
  const EcsSortView({super.key});

  @override
  State<EcsSortView> createState() => _EcsSortViewState();
}

class _EcsSortViewState extends State<EcsSortView> {
  String selectedSortOption = "relevance";
  
  List<Map<String, dynamic>> sortOptions = [
    {
      "value": "relevance",
      "title": "Relevance",
      "subtitle": "Most relevant to your search",
      "icon": Icons.search,
    },
    {
      "value": "popularity",
      "title": "Popularity",
      "subtitle": "Most popular items first",
      "icon": Icons.trending_up,
    },
    {
      "value": "rating",
      "title": "Customer Rating",
      "subtitle": "Highest rated items first",
      "icon": Icons.star,
    },
    {
      "value": "price_low_high",
      "title": "Price: Low to High",
      "subtitle": "Cheapest items first",
      "icon": Icons.keyboard_arrow_up,
    },
    {
      "value": "price_high_low",
      "title": "Price: High to Low",
      "subtitle": "Most expensive items first",
      "icon": Icons.keyboard_arrow_down,
    },
    {
      "value": "newest",
      "title": "Newest Arrivals",
      "subtitle": "Latest products first",
      "icon": Icons.new_releases,
    },
    {
      "value": "discount",
      "title": "Biggest Discount",
      "subtitle": "Highest discount percentage first",
      "icon": Icons.local_offer,
    },
    {
      "value": "reviews_count",
      "title": "Most Reviewed",
      "subtitle": "Items with most reviews first",
      "icon": Icons.rate_review,
    },
    {
      "value": "alphabetical_az",
      "title": "Name: A to Z",
      "subtitle": "Alphabetical order A-Z",
      "icon": Icons.sort_by_alpha,
    },
    {
      "value": "alphabetical_za",
      "title": "Name: Z to A",
      "subtitle": "Alphabetical order Z-A",
      "icon": Icons.sort_by_alpha,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sort Products"),
        actions: [
          GestureDetector(
            onTap: () => _resetToDefault(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Center(
                child: Text(
                  "Reset",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Info
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(26),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(51)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info,
                    color: infoColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Choose how you want to sort your search results. This will help you find exactly what you're looking for.",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Sort Options List
            Text(
              "Sort Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: sortOptions.map((option) {
                  final isSelected = selectedSortOption == option["value"];
                  final isFirst = sortOptions.first == option;
                  final isLast = sortOptions.last == option;
                  
                  return GestureDetector(
                    onTap: () {
                      selectedSortOption = "${option["value"]}";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor.withAlpha(26) : Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: isFirst ? Radius.circular(radiusMd) : Radius.zero,
                          bottom: isLast ? Radius.circular(radiusMd) : Radius.zero,
                        ),
                        border: !isLast ? Border(
                          bottom: BorderSide(
                            color: disabledOutlineBorderColor,
                            width: 0.5,
                          ),
                        ) : null,
                      ),
                      child: Row(
                        children: [
                          // Sort Icon
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : disabledColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              option["icon"] as IconData,
                              color: isSelected ? Colors.white : disabledBoldColor,
                              size: 20,
                            ),
                          ),
                          
                          SizedBox(width: spMd),
                          
                          // Sort Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${option["title"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected ? primaryColor : Colors.black,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${option["subtitle"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Selection Indicator
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : Colors.white,
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledOutlineBorderColor,
                                width: 2,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: isSelected
                                ? Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 16,
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Quick Sort Buttons
            Text(
              "Quick Sort",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 120,
              children: [
                _buildQuickSortButton(
                  "Lowest Price",
                  Icons.arrow_downward,
                  "price_low_high",
                ),
                _buildQuickSortButton(
                  "Highest Rating",
                  Icons.star,
                  "rating",
                ),
                _buildQuickSortButton(
                  "Best Discount",
                  Icons.local_offer,
                  "discount",
                ),
                _buildQuickSortButton(
                  "Most Popular",
                  Icons.trending_up,
                  "popularity",
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Current Selection Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(26),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(51)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: successColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current Sort:",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          _getCurrentSortTitle(),
                          style: TextStyle(
                            fontSize: 14,
                            color: successColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowSm],
        ),
        child: Row(
          children: [
            Expanded(
              child: QButton(
                label: "Cancel",
                size: bs.md,
                onPressed: () => back(),
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              flex: 2,
              child: QButton(
                label: "Apply Sort",
                size: bs.md,
                onPressed: () => _applySort(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickSortButton(String title, IconData icon, String value) {
    final isSelected = selectedSortOption == value;
    
    return GestureDetector(
      onTap: () {
        selectedSortOption = value;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : primaryColor,
              size: 24,
            ),
            SizedBox(height: spXs),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCurrentSortTitle() {
    final option = sortOptions.firstWhere(
      (option) => option["value"] == selectedSortOption,
      orElse: () => sortOptions.first,
    );
    return "${option["title"]}";
  }

  void _resetToDefault() {
    selectedSortOption = "relevance";
    setState(() {});
    ss("Sort reset to default (Relevance)");
  }

  void _applySort() {
    // Apply sort and navigate back
    back();
    ss("Sort applied: ${_getCurrentSortTitle()}");
  }
}
