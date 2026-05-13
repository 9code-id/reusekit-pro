import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaSortView extends StatefulWidget {
  const EmaSortView({super.key});

  @override
  State<EmaSortView> createState() => _EmaSortViewState();
}

class _EmaSortViewState extends State<EmaSortView> {
  String selectedSortOption = "relevance";
  String sortDirection = "desc";
  bool groupByCategory = false;
  bool showFeaturedFirst = true;
  
  List<Map<String, dynamic>> sortOptions = [
    {
      "id": "relevance",
      "title": "Relevance",
      "description": "Most relevant to your search",
      "icon": Icons.search,
      "directions": ["desc"],
    },
    {
      "id": "date",
      "title": "Date",
      "description": "Event start date",
      "icon": Icons.calendar_today,
      "directions": ["asc", "desc"],
    },
    {
      "id": "price",
      "title": "Price",
      "description": "Event ticket price",
      "icon": Icons.attach_money,
      "directions": ["asc", "desc"],
    },
    {
      "id": "rating",
      "title": "Rating",
      "description": "User ratings and reviews",
      "icon": Icons.star,
      "directions": ["desc", "asc"],
    },
    {
      "id": "popularity",
      "title": "Popularity",
      "description": "Number of attendees",
      "icon": Icons.people,
      "directions": ["desc", "asc"],
    },
    {
      "id": "distance",
      "title": "Distance",
      "description": "Distance from your location",
      "icon": Icons.location_on,
      "directions": ["asc", "desc"],
    },
    {
      "id": "alphabetical",
      "title": "Event Name",
      "description": "Alphabetical order",
      "icon": Icons.sort_by_alpha,
      "directions": ["asc", "desc"],
    },
    {
      "id": "created",
      "title": "Recently Added",
      "description": "When event was posted",
      "icon": Icons.access_time,
      "directions": ["desc", "asc"],
    },
  ];

  List<Map<String, dynamic>> quickSortPresets = [
    {
      "title": "Popular Events",
      "description": "Most attended events",
      "sortBy": "popularity",
      "direction": "desc",
      "icon": Icons.trending_up,
    },
    {
      "title": "Nearest First",
      "description": "Closest to your location",
      "sortBy": "distance",
      "direction": "asc",
      "icon": Icons.near_me,
    },
    {
      "title": "Budget Friendly",
      "description": "Cheapest events first",
      "sortBy": "price",
      "direction": "asc",
      "icon": Icons.savings,
    },
    {
      "title": "Highly Rated",
      "description": "Best reviewed events",
      "sortBy": "rating",
      "direction": "desc",
      "icon": Icons.star_rate,
    },
    {
      "title": "This Week",
      "description": "Events happening soon",
      "sortBy": "date",
      "direction": "asc",
      "icon": Icons.today,
    },
    {
      "title": "Latest Added",
      "description": "Recently posted events",
      "sortBy": "created",
      "direction": "desc",
      "icon": Icons.new_releases,
    },
  ];

  Map<String, dynamic> get selectedSort {
    return sortOptions.firstWhere((option) => option["id"] == selectedSortOption);
  }

  String get sortDirectionLabel {
    switch (sortDirection) {
      case "asc":
        switch (selectedSortOption) {
          case "date":
            return "Earliest First";
          case "price":
            return "Lowest Price";
          case "rating":
            return "Lowest Rating";
          case "popularity":
            return "Least Popular";
          case "distance":
            return "Nearest";
          case "alphabetical":
            return "A to Z";
          case "created":
            return "Oldest First";
          default:
            return "Ascending";
        }
      case "desc":
        switch (selectedSortOption) {
          case "relevance":
            return "Most Relevant";
          case "date":
            return "Latest First";
          case "price":
            return "Highest Price";
          case "rating":
            return "Highest Rating";
          case "popularity":
            return "Most Popular";
          case "distance":
            return "Furthest";
          case "alphabetical":
            return "Z to A";
          case "created":
            return "Newest First";
          default:
            return "Descending";
        }
      default:
        return "Default";
    }
  }

  void _applySort() {
    Map<String, dynamic> sortSettings = {
      "sortBy": selectedSortOption,
      "direction": sortDirection,
      "groupByCategory": groupByCategory,
      "showFeaturedFirst": showFeaturedFirst,
    };
    
    ss("Sort settings applied");
    //navigateTo previous screen with sort settings
  }

  void _resetSort() {
    selectedSortOption = "relevance";
    sortDirection = "desc";
    groupByCategory = false;
    showFeaturedFirst = true;
    setState(() {});
  }

  void _applyQuickSort(Map<String, dynamic> preset) {
    selectedSortOption = preset["sortBy"];
    sortDirection = preset["direction"];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sort Events"),
        actions: [
          GestureDetector(
            onTap: _resetSort,
            child: Icon(
              Icons.refresh,
              color: primaryColor,
            ),
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [dangerColor, dangerColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.sort,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spMd),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sort Events",
                            style: TextStyle(
                              fontSize: fsH3,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Organize results by your preference",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withAlpha(220),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          selectedSort["icon"],
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${selectedSort["title"]} • $sortDirectionLabel",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Quick Sort Presets
            Text(
              "Quick Sort Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            QHorizontalScroll(
              children: quickSortPresets.map((preset) => _buildQuickSortCard(preset)).toList(),
            ),

            SizedBox(height: spLg),

            // Sort Options
            Text(
              "Sort Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: sortOptions.map((option) => _buildSortOption(option)).toList(),
              ),
            ),

            SizedBox(height: spLg),

            // Sort Direction
            if ((selectedSort["directions"] as List).length > 1) ...[
              Text(
                "Sort Direction",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),

              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if ((selectedSort["directions"] as List).contains("asc")) {
                                sortDirection = "asc";
                                setState(() {});
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(spMd),
                              decoration: BoxDecoration(
                                color: sortDirection == "asc" ? primaryColor.withAlpha(25) : Colors.transparent,
                                borderRadius: BorderRadius.circular(radiusMd),
                                border: Border.all(
                                  color: sortDirection == "asc" ? primaryColor : disabledOutlineBorderColor,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.arrow_upward,
                                    color: sortDirection == "asc" ? primaryColor : disabledBoldColor,
                                    size: 24,
                                  ),
                                  SizedBox(height: spSm),
                                  Text(
                                    _getDirectionLabel("asc"),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: sortDirection == "asc" ? primaryColor : disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if ((selectedSort["directions"] as List).contains("desc")) {
                                sortDirection = "desc";
                                setState(() {});
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(spMd),
                              decoration: BoxDecoration(
                                color: sortDirection == "desc" ? primaryColor.withAlpha(25) : Colors.transparent,
                                borderRadius: BorderRadius.circular(radiusMd),
                                border: Border.all(
                                  color: sortDirection == "desc" ? primaryColor : disabledOutlineBorderColor,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.arrow_downward,
                                    color: sortDirection == "desc" ? primaryColor : disabledBoldColor,
                                    size: 24,
                                  ),
                                  SizedBox(height: spSm),
                                  Text(
                                    _getDirectionLabel("desc"),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: sortDirection == "desc" ? primaryColor : disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: spLg),
            ],

            // Additional Options
            Text(
              "Additional Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  QSwitch(
                    items: [
                      {
                        "label": "Show featured events first",
                        "value": true,
                        "checked": showFeaturedFirst,
                      }
                    ],
                    value: [if (showFeaturedFirst) {"label": "Show featured events first", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      showFeaturedFirst = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Group by category",
                        "value": true,
                        "checked": groupByCategory,
                      }
                    ],
                    value: [if (groupByCategory) {"label": "Group by category", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      groupByCategory = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Current Sort Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spMd),
                      Text(
                        "Current Sort Settings",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Events will be sorted by ${selectedSort["title"]} • $sortDirectionLabel",
                    style: TextStyle(
                      fontSize: 14,
                      color: infoColor,
                    ),
                  ),
                  if (showFeaturedFirst || groupByCategory) ...[
                    SizedBox(height: spSm),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (showFeaturedFirst)
                          Text(
                            "• Featured events will appear first",
                            style: TextStyle(
                              fontSize: 14,
                              color: infoColor,
                            ),
                          ),
                        if (groupByCategory)
                          Text(
                            "• Results will be grouped by category",
                            style: TextStyle(
                              fontSize: 14,
                              color: infoColor,
                            ),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            SizedBox(height: spXl),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Reset",
                    size: bs.md,
                    onPressed: _resetSort,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: "Apply Sort",
                    size: bs.md,
                    onPressed: _applySort,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickSortCard(Map<String, dynamic> preset) {
    bool isSelected = selectedSortOption == preset["sortBy"] && sortDirection == preset["direction"];
    
    return GestureDetector(
      onTap: () => _applyQuickSort(preset),
      child: Container(
        width: 140,
        margin: EdgeInsets.only(right: spMd),
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(25) : Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : primaryColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Icon(
                preset["icon"],
                color: isSelected ? Colors.white : primaryColor,
                size: 24,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              preset["title"],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: isSelected ? primaryColor : disabledBoldColor,
              ),
            ),
            SizedBox(height: 4),
            Text(
              preset["description"],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: disabledBoldColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSortOption(Map<String, dynamic> option) {
    bool isSelected = selectedSortOption == option["id"];
    
    return GestureDetector(
      onTap: () {
        selectedSortOption = option["id"];
        // Set default direction for the selected option
        List<String> directions = List<String>.from(option["directions"]);
        if (!directions.contains(sortDirection)) {
          sortDirection = directions.first;
        }
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(25) : Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: disabledOutlineBorderColor,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : primaryColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Icon(
                option["icon"],
                color: isSelected ? Colors.white : primaryColor,
                size: 20,
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option["title"],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? primaryColor : disabledBoldColor,
                    ),
                  ),
                  Text(
                    option["description"],
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: primaryColor,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  String _getDirectionLabel(String direction) {
    switch (direction) {
      case "asc":
        switch (selectedSortOption) {
          case "date":
            return "Earliest First";
          case "price":
            return "Lowest Price";
          case "rating":
            return "Lowest Rating";
          case "popularity":
            return "Least Popular";
          case "distance":
            return "Nearest";
          case "alphabetical":
            return "A to Z";
          case "created":
            return "Oldest First";
          default:
            return "Ascending";
        }
      case "desc":
        switch (selectedSortOption) {
          case "relevance":
            return "Most Relevant";
          case "date":
            return "Latest First";
          case "price":
            return "Highest Price";
          case "rating":
            return "Highest Rating";
          case "popularity":
            return "Most Popular";
          case "distance":
            return "Furthest";
          case "alphabetical":
            return "Z to A";
          case "created":
            return "Newest First";
          default:
            return "Descending";
        }
      default:
        return "Default";
    }
  }
}
