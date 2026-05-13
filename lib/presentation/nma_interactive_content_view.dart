import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaInteractiveContentView extends StatefulWidget {
  const NmaInteractiveContentView({super.key});

  @override
  State<NmaInteractiveContentView> createState() => _NmaInteractiveContentViewState();
}

class _NmaInteractiveContentViewState extends State<NmaInteractiveContentView> {
  List<Map<String, dynamic>> interactiveContent = [
    {
      "id": 1,
      "title": "City Budget Interactive Explorer",
      "description": "Explore how city budget is allocated across different departments with interactive charts",
      "type": "Interactive Chart",
      "thumbnail": "https://picsum.photos/400/300?random=1",
      "category": "Politics",
      "date": "2025-06-16",
      "author": "City Planning Department",
      "views": 2850,
      "interactions": 456,
      "duration": "5-10 min",
      "difficulty": "Easy",
      "isNew": true,
      "rating": 4.5,
      "ratingCount": 89,
    },
    {
      "id": 2,
      "title": "Election Results Dashboard",
      "description": "Real-time election results with interactive maps and voting statistics",
      "type": "Dashboard",
      "thumbnail": "https://picsum.photos/400/300?random=2",
      "category": "Politics",
      "date": "2025-06-15",
      "author": "Election Commission",
      "views": 5670,
      "interactions": 1234,
      "duration": "3-8 min",
      "difficulty": "Medium",
      "isNew": false,
      "rating": 4.8,
      "ratingCount": 156,
    },
    {
      "id": 3,
      "title": "Weather Pattern Simulator",
      "description": "Interactive weather simulation showing storm patterns and climate data",
      "type": "Simulator",
      "thumbnail": "https://picsum.photos/400/300?random=3",
      "category": "Weather",
      "date": "2025-06-14",
      "author": "Meteorology Department",
      "views": 3240,
      "interactions": 789,
      "duration": "10-15 min",
      "difficulty": "Medium",
      "isNew": true,
      "rating": 4.3,
      "ratingCount": 67,
    },
    {
      "id": 4,
      "title": "Community Development Timeline",
      "description": "Interactive timeline showing progress of local development projects",
      "type": "Timeline",
      "thumbnail": "https://picsum.photos/400/300?random=4",
      "category": "Community",
      "date": "2025-06-13",
      "author": "Development Office",
      "views": 1890,
      "interactions": 234,
      "duration": "5-12 min",
      "difficulty": "Easy",
      "isNew": false,
      "rating": 4.1,
      "ratingCount": 45,
    },
    {
      "id": 5,
      "title": "Sports Statistics Interactive",
      "description": "Dive deep into player statistics and team performance with interactive graphs",
      "type": "Statistics Tool",
      "thumbnail": "https://picsum.photos/400/300?random=5",
      "category": "Sports",
      "date": "2025-06-12",
      "author": "Sports Analytics Team",
      "views": 2340,
      "interactions": 567,
      "duration": "8-15 min",
      "difficulty": "Medium",
      "isNew": false,
      "rating": 4.6,
      "ratingCount": 123,
    },
    {
      "id": 6,
      "title": "School Performance Explorer",
      "description": "Interactive tool to explore school ratings, test scores, and graduation rates",
      "type": "Explorer Tool",
      "thumbnail": "https://picsum.photos/400/300?random=6",
      "category": "Education",
      "date": "2025-06-11",
      "author": "Department of Education",
      "views": 1670,
      "interactions": 345,
      "duration": "6-12 min",
      "difficulty": "Easy",
      "isNew": false,
      "rating": 4.2,
      "ratingCount": 78,
    },
  ];

  List<String> categories = ["All", "Politics", "Weather", "Community", "Sports", "Education", "Business"];
  List<String> types = ["All Types", "Interactive Chart", "Dashboard", "Simulator", "Timeline", "Statistics Tool", "Explorer Tool"];
  List<String> difficulties = ["All Levels", "Easy", "Medium", "Hard"];

  String selectedCategory = "All";
  String selectedType = "All Types";
  String selectedDifficulty = "All Levels";
  String searchQuery = "";
  String sortBy = "Newest";

  List<Map<String, dynamic>> get filteredContent {
    List<Map<String, dynamic>> filtered = interactiveContent;

    // Filter by category
    if (selectedCategory != "All") {
      filtered = filtered.where((item) => item["category"] == selectedCategory).toList();
    }

    // Filter by type
    if (selectedType != "All Types") {
      filtered = filtered.where((item) => item["type"] == selectedType).toList();
    }

    // Filter by difficulty
    if (selectedDifficulty != "All Levels") {
      filtered = filtered.where((item) => item["difficulty"] == selectedDifficulty).toList();
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((item) {
        final title = (item["title"] as String).toLowerCase();
        final description = (item["description"] as String).toLowerCase();
        final query = searchQuery.toLowerCase();
        return title.contains(query) || description.contains(query);
      }).toList();
    }

    // Sort
    switch (sortBy) {
      case "Most Viewed":
        filtered.sort((a, b) => (b["views"] as int).compareTo(a["views"] as int));
        break;
      case "Most Interactive":
        filtered.sort((a, b) => (b["interactions"] as int).compareTo(a["interactions"] as int));
        break;
      case "Highest Rated":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "Oldest":
        filtered.sort((a, b) => a["date"].compareTo(b["date"]));
        break;
      default: // Newest
        filtered.sort((a, b) => b["date"].compareTo(a["date"]));
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Interactive Content"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilters,
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _showSearchDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter
          Container(
            padding: EdgeInsets.all(spSm),
            child: QCategoryPicker(
              items: categories.map((category) => {
                "label": category,
                "value": category,
              }).toList(),
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),
          ),

          // Active Filters Info
          if (selectedType != "All Types" || selectedDifficulty != "All Levels" || searchQuery.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: spSm),
              child: Wrap(
                spacing: spXs,
                children: [
                  if (selectedType != "All Types")
                    Chip(
                      label: Text(selectedType),
                      deleteIcon: Icon(Icons.close, size: 16),
                      onDeleted: () {
                        selectedType = "All Types";
                        setState(() {});
                      },
                    ),
                  if (selectedDifficulty != "All Levels")
                    Chip(
                      label: Text(selectedDifficulty),
                      deleteIcon: Icon(Icons.close, size: 16),
                      onDeleted: () {
                        selectedDifficulty = "All Levels";
                        setState(() {});
                      },
                    ),
                  if (searchQuery.isNotEmpty)
                    Chip(
                      label: Text("\"$searchQuery\""),
                      deleteIcon: Icon(Icons.close, size: 16),
                      onDeleted: () {
                        searchQuery = "";
                        setState(() {});
                      },
                    ),
                ],
              ),
            ),

          // Content Grid
          Expanded(
            child: filteredContent.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.touch_app,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "No interactive content found",
                          style: TextStyle(
                            fontSize: fsH6,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Try adjusting your filters",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : ResponsiveGridView(
                    padding: EdgeInsets.all(spSm),
                    minItemWidth: 200,
                    children: filteredContent.map((content) {
                      return _buildContentCard(content);
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentCard(Map<String, dynamic> content) {
    final isNew = content["isNew"] as bool;
    final rating = content["rating"] as double;

    return GestureDetector(
      onTap: () => _launchInteractiveContent(content),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            Stack(
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                    image: DecorationImage(
                      image: NetworkImage("${content["thumbnail"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // New badge
                if (isNew)
                  Positioned(
                    top: spXs,
                    left: spXs,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "NEW",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                // Type badge
                Positioned(
                  top: spXs,
                  right: spXs,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${content["type"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                // Play overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                      color: Colors.black.withAlpha(64),
                    ),
                    child: Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(200),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.play_arrow,
                          color: primaryColor,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Content Info
            Padding(
              padding: EdgeInsets.all(spSm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${content["title"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${content["description"]}",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: spSm),

                  // Rating and Duration
                  Row(
                    children: [
                      Icon(Icons.star, color: warningColor, size: 14),
                      SizedBox(width: 4),
                      Text(
                        "${rating.toStringAsFixed(1)}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        "(${content["ratingCount"]})",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${content["duration"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),

                  // Category and Difficulty
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${content["category"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getDifficultyColor(content["difficulty"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${content["difficulty"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: _getDifficultyColor(content["difficulty"]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),

                  // Stats
                  Row(
                    children: [
                      Icon(Icons.visibility, size: 14, color: disabledBoldColor),
                      SizedBox(width: 4),
                      Text(
                        "${(content["views"] as int).toString()}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(Icons.touch_app, size: 14, color: disabledBoldColor),
                      SizedBox(width: 4),
                      Text(
                        "${(content["interactions"] as int).toString()}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Launch",
                        icon: Icons.launch,
                        size: bs.sm,
                        onPressed: () => _launchInteractiveContent(content),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Easy":
        return successColor;
      case "Medium":
        return warningColor;
      case "Hard":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showSearchDialog() {
    String tempSearch = searchQuery;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Search Interactive Content"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QTextField(
              label: "Search term",
              value: tempSearch,
              hint: "Enter title, description, or keyword",
              onChanged: (value) {
                tempSearch = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Search",
            size: bs.sm,
            onPressed: () {
              searchQuery = tempSearch;
              setState(() {});
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Filters & Sort",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: spSm),
            
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Content Type Filter
                    QDropdownField(
                      label: "Content Type",
                      items: types.map((type) => {
                        "label": type,
                        "value": type,
                      }).toList(),
                      value: selectedType,
                      onChanged: (value, label) {
                        selectedType = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),

                    // Difficulty Filter
                    QDropdownField(
                      label: "Difficulty Level",
                      items: difficulties.map((difficulty) => {
                        "label": difficulty,
                        "value": difficulty,
                      }).toList(),
                      value: selectedDifficulty,
                      onChanged: (value, label) {
                        selectedDifficulty = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),

                    // Sort Options
                    QDropdownField(
                      label: "Sort by",
                      items: [
                        {"label": "Newest", "value": "Newest"},
                        {"label": "Oldest", "value": "Oldest"},
                        {"label": "Most Viewed", "value": "Most Viewed"},
                        {"label": "Most Interactive", "value": "Most Interactive"},
                        {"label": "Highest Rated", "value": "Highest Rated"},
                      ],
                      value: sortBy,
                      onChanged: (value, label) {
                        sortBy = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spLg),

                    // Clear Filters
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Clear All Filters",
                        icon: Icons.clear_all,
                        size: bs.sm,
                        onPressed: () {
                          selectedType = "All Types";
                          selectedDifficulty = "All Levels";
                          selectedCategory = "All";
                          searchQuery = "";
                          sortBy = "Newest";
                          setState(() {});
                          Navigator.pop(context);
                        },
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

  void _launchInteractiveContent(Map<String, dynamic> content) {
    // Update view count
    content["views"] = (content["views"] as int) + 1;
    setState(() {});

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Launch Interactive Content"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusSm),
                image: DecorationImage(
                  image: NetworkImage("${content["thumbnail"]}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "${content["title"]}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spXs),
            Text("${content["description"]}"),
            SizedBox(height: spSm),
            Row(
              children: [
                Text("Type: ${content["type"]}"),
                Spacer(),
                Text("Duration: ${content["duration"]}"),
              ],
            ),
            Row(
              children: [
                Text("Level: ${content["difficulty"]}"),
                Spacer(),
                Icon(Icons.star, color: warningColor, size: 16),
                Text(" ${(content["rating"] as double).toStringAsFixed(1)}"),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Launch",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              content["interactions"] = (content["interactions"] as int) + 1;
              setState(() {});
              ss("Launching: ${content["title"]}");
            },
          ),
        ],
      ),
    );
  }
}
