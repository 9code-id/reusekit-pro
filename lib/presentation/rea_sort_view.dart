import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaSortView extends StatefulWidget {
  const ReaSortView({super.key});

  @override
  State<ReaSortView> createState() => _ReaSortViewState();
}

class _ReaSortViewState extends State<ReaSortView> {
  String selectedSortOption = "Relevance";
  String sortOrder = "desc"; // asc or desc

  final List<Map<String, dynamic>> sortOptions = [
    {
      "value": "Relevance",
      "label": "Relevance",
      "description": "Best match for your search",
      "icon": Icons.auto_awesome,
      "hasOrder": false,
    },
    {
      "value": "Price",
      "label": "Price",
      "description": "Sort by property price",
      "icon": Icons.attach_money,
      "hasOrder": true,
    },
    {
      "value": "Date",
      "label": "Date Listed",
      "description": "Recently added properties first",
      "icon": Icons.schedule,
      "hasOrder": true,
    },
    {
      "value": "Size",
      "label": "Property Size",
      "description": "Sort by area/square footage",
      "icon": Icons.square_foot,
      "hasOrder": true,
    },
    {
      "value": "Bedrooms",
      "label": "Number of Bedrooms",
      "description": "Sort by bedroom count",
      "icon": Icons.bed,
      "hasOrder": true,
    },
    {
      "value": "Distance",
      "label": "Distance",
      "description": "Closest properties first",
      "icon": Icons.location_on,
      "hasOrder": false,
    },
    {
      "value": "Rating",
      "label": "Property Rating",
      "description": "Highest rated properties first",
      "icon": Icons.star,
      "hasOrder": true,
    },
    {
      "value": "Views",
      "label": "Popularity",
      "description": "Most viewed properties first",
      "icon": Icons.trending_up,
      "hasOrder": true,
    },
    {
      "value": "PricePerSqft",
      "label": "Price per Sq Ft",
      "description": "Best value properties first",
      "icon": Icons.calculate,
      "hasOrder": true,
    },
  ];

  final List<Map<String, dynamic>> quickSortPresets = [
    {
      "title": "Most Affordable",
      "description": "Price: Low to High",
      "sortBy": "Price",
      "order": "asc",
      "icon": Icons.trending_down,
      "color": successColor,
    },
    {
      "title": "Luxury Properties",
      "description": "Price: High to Low",
      "sortBy": "Price",
      "order": "desc",
      "icon": Icons.trending_up,
      "color": warningColor,
    },
    {
      "title": "Latest Listings",
      "description": "Newest properties first",
      "sortBy": "Date",
      "order": "desc",
      "icon": Icons.new_releases,
      "color": infoColor,
    },
    {
      "title": "Largest Properties",
      "description": "Biggest spaces first",
      "sortBy": "Size",
      "order": "desc",
      "icon": Icons.aspect_ratio,
      "color": primaryColor,
    },
  ];

  final List<Map<String, dynamic>> recentSorts = [
    {
      "title": "Price: High to Low",
      "subtitle": "Used 2 hours ago",
      "sortBy": "Price",
      "order": "desc",
    },
    {
      "title": "Distance",
      "subtitle": "Used yesterday",
      "sortBy": "Distance",
      "order": "asc",
    },
    {
      "title": "Property Size: Large to Small",
      "subtitle": "Used 3 days ago",
      "sortBy": "Size",
      "order": "desc",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sort Results"),
        actions: [
          TextButton(
            onPressed: _resetToDefault,
            child: Text(
              "Reset",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
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
            // Current sort info
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.sort,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current Sort",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          _getCurrentSortDescription(),
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
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

            // Quick sort presets
            Text(
              "Quick Sort Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 160,
              children: quickSortPresets.map((preset) {
                final isSelected = selectedSortOption == preset["sortBy"] && 
                                  sortOrder == preset["order"];
                
                return GestureDetector(
                  onTap: () => _selectQuickSort(preset),
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? (preset["color"] as Color).withAlpha(20)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isSelected
                            ? preset["color"] as Color
                            : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: isSelected ? [shadowSm] : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: (preset["color"] as Color).withAlpha(20),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            preset["icon"] as IconData,
                            color: preset["color"] as Color,
                            size: 24,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${preset["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${preset["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spMd),

            // Detailed sort options
            Text(
              "All Sort Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
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
                  final index = sortOptions.indexOf(option);
                  final isSelected = selectedSortOption == option["value"];
                  final hasOrder = option["hasOrder"] as bool;
                  
                  return GestureDetector(
                    onTap: () => _selectSortOption(option["value"] as String),
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor.withAlpha(10) : null,
                        border: index < sortOptions.length - 1
                            ? Border(
                                bottom: BorderSide(
                                  color: disabledOutlineBorderColor,
                                  width: 1,
                                ),
                              )
                            : null,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? primaryColor.withAlpha(20)
                                  : disabledColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              option["icon"] as IconData,
                              color: isSelected ? primaryColor : disabledBoldColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${option["label"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected ? primaryColor : primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${option["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isSelected) ...[
                            if (hasOrder) ...[
                              GestureDetector(
                                onTap: () => _toggleSortOrder(),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        sortOrder == "asc"
                                            ? Icons.arrow_upward
                                            : Icons.arrow_downward,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        sortOrder == "asc" ? "Low-High" : "High-Low",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ] else ...[
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ],
                          ],
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: spMd),

            // Recent sorts
            if (recentSorts.isNotEmpty) ...[
              Text(
                "Recent Sorts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
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
                  children: recentSorts.map((sort) {
                    final index = recentSorts.indexOf(sort);
                    return GestureDetector(
                      onTap: () => _selectRecentSort(sort),
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: index < recentSorts.length - 1
                              ? Border(
                                  bottom: BorderSide(
                                    color: disabledOutlineBorderColor,
                                    width: 1,
                                  ),
                                )
                              : null,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.history,
                              color: disabledBoldColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${sort["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${sort["subtitle"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: disabledBoldColor,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: spMd),
            ],

            // Sort tips
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Sort Tips",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Use 'Relevance' for best matches to your search criteria\n"
                    "• Sort by 'Distance' when location is most important\n"
                    "• Use 'Date Listed' to find the newest properties\n"
                    "• Sort by 'Price per Sq Ft' to find the best value",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      height: 1.4,
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
          boxShadow: [shadowMd],
        ),
        child: Row(
          children: [
            Expanded(
              child: QButton(
                label: "Reset to Default",
                onPressed: _resetToDefault,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              flex: 2,
              child: QButton(
                label: "Apply Sort",
                onPressed: _applySort,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCurrentSortDescription() {
    final option = sortOptions.firstWhere(
      (opt) => opt["value"] == selectedSortOption,
      orElse: () => sortOptions[0],
    );
    
    String description = option["label"] as String;
    if (option["hasOrder"] as bool) {
      description += sortOrder == "asc" ? ": Low to High" : ": High to Low";
    }
    
    return description;
  }

  void _selectQuickSort(Map<String, dynamic> preset) {
    setState(() {
      selectedSortOption = preset["sortBy"] as String;
      sortOrder = preset["order"] as String;
    });
    ss("Quick sort applied: ${preset["title"]}");
  }

  void _selectSortOption(String option) {
    setState(() {
      selectedSortOption = option;
      // Reset to default order when changing sort option
      final optionData = sortOptions.firstWhere((opt) => opt["value"] == option);
      if (optionData["hasOrder"] as bool) {
        sortOrder = "desc"; // Default to descending for most options
        if (option == "Price" || option == "Distance") {
          sortOrder = "asc"; // But ascending for price and distance makes more sense
        }
      }
    });
  }

  void _toggleSortOrder() {
    setState(() {
      sortOrder = sortOrder == "asc" ? "desc" : "asc";
    });
  }

  void _selectRecentSort(Map<String, dynamic> sort) {
    setState(() {
      selectedSortOption = sort["sortBy"] as String;
      sortOrder = sort["order"] as String;
    });
    ss("Recent sort applied: ${sort["title"]}");
  }

  void _resetToDefault() {
    setState(() {
      selectedSortOption = "Relevance";
      sortOrder = "desc";
    });
    ss("Sort reset to default (Relevance)");
  }

  void _applySort() {
    ss("Sort applied: ${_getCurrentSortDescription()}");
    back();
  }
}
