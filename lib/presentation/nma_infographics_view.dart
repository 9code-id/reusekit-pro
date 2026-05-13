import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaInfographicsView extends StatefulWidget {
  const NmaInfographicsView({super.key});

  @override
  State<NmaInfographicsView> createState() => _NmaInfographicsViewState();
}

class _NmaInfographicsViewState extends State<NmaInfographicsView> {
  List<Map<String, dynamic>> infographics = [
    {
      "id": 1,
      "title": "City Budget Breakdown 2025",
      "description": "Visual breakdown of how city budget will be allocated across different departments",
      "image": "https://picsum.photos/600/800?random=1",
      "category": "Politics",
      "date": "2025-06-16",
      "author": "City Planning Department",
      "views": 2340,
      "likes": 156,
      "shares": 89,
      "tags": ["budget", "city council", "finance", "government"],
      "downloadable": true,
      "size": "2.3 MB",
      "format": "PNG",
    },
    {
      "id": 2,
      "title": "Local Sports Statistics 2024-2025",
      "description": "Championship results and player statistics from the local sports league season",
      "image": "https://picsum.photos/600/800?random=2",
      "category": "Sports",
      "date": "2025-06-15",
      "author": "Sports Analytics Team",
      "views": 1890,
      "likes": 234,
      "shares": 67,
      "tags": ["sports", "statistics", "championship", "local teams"],
      "downloadable": true,
      "size": "1.8 MB",
      "format": "PNG",
    },
    {
      "id": 3,
      "title": "Weather Pattern Analysis",
      "description": "Recent storm damage and weather patterns affecting our region",
      "image": "https://picsum.photos/600/800?random=3",
      "category": "Weather",
      "date": "2025-06-14",
      "author": "Meteorology Department",
      "views": 3450,
      "likes": 298,
      "shares": 145,
      "tags": ["weather", "storm", "climate", "analysis"],
      "downloadable": true,
      "size": "3.1 MB",
      "format": "PDF",
    },
    {
      "id": 4,
      "title": "Community Development Progress",
      "description": "Progress report on ongoing community projects and infrastructure development",
      "image": "https://picsum.photos/600/800?random=4",
      "category": "Community",
      "date": "2025-06-13",
      "author": "Community Development Office",
      "views": 980,
      "likes": 78,
      "shares": 34,
      "tags": ["community", "development", "infrastructure", "progress"],
      "downloadable": false,
      "size": "4.2 MB",
      "format": "PNG",
    },
    {
      "id": 5,
      "title": "Education System Overview",
      "description": "Student enrollment, graduation rates, and academic performance across local schools",
      "image": "https://picsum.photos/600/800?random=5",
      "category": "Education",
      "date": "2025-06-12",
      "author": "Department of Education",
      "views": 1567,
      "likes": 123,
      "shares": 56,
      "tags": ["education", "schools", "students", "performance"],
      "downloadable": true,
      "size": "2.7 MB",
      "format": "PDF",
    },
    {
      "id": 6,
      "title": "Business District Growth",
      "description": "Economic growth and business development in the downtown commercial area",
      "image": "https://picsum.photos/600/800?random=6",
      "category": "Business",
      "date": "2025-06-11",
      "author": "Economic Development Agency",
      "views": 1234,
      "likes": 89,
      "shares": 45,
      "tags": ["business", "economy", "growth", "commercial"],
      "downloadable": true,
      "size": "1.9 MB",
      "format": "PNG",
    },
  ];

  List<String> categories = ["All", "Politics", "Sports", "Weather", "Community", "Education", "Business"];
  String selectedCategory = "All";
  String searchQuery = "";
  String sortBy = "Newest";

  List<Map<String, dynamic>> get filteredInfographics {
    List<Map<String, dynamic>> filtered = infographics;

    // Filter by category
    if (selectedCategory != "All") {
      filtered = filtered.where((item) => item["category"] == selectedCategory).toList();
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
      case "Most Liked":
        filtered.sort((a, b) => (b["likes"] as int).compareTo(a["likes"] as int));
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
        title: Text("Infographics"),
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: _showSortOptions,
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

          // Search Results Info
          if (searchQuery.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: spSm),
              child: Row(
                children: [
                  Icon(Icons.search, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text(
                    "Search results for \"$searchQuery\"",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      searchQuery = "";
                      setState(() {});
                    },
                    child: Icon(Icons.clear, size: 16, color: dangerColor),
                  ),
                ],
              ),
            ),

          // Infographics Grid
          Expanded(
            child: filteredInfographics.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.insert_chart_outlined,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "No infographics found",
                          style: TextStyle(
                            fontSize: fsH6,
                            color: disabledBoldColor,
                          ),
                        ),
                        if (searchQuery.isNotEmpty || selectedCategory != "All") ...[
                          SizedBox(height: spXs),
                          Text(
                            "Try adjusting your filters",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                  )
                : ResponsiveGridView(
                    padding: EdgeInsets.all(spSm),
                    minItemWidth: 200,
                    children: filteredInfographics.map((infographic) {
                      return _buildInfographicCard(infographic);
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfographicCard(Map<String, dynamic> infographic) {
    final isDownloadable = infographic["downloadable"] as bool;

    return GestureDetector(
      onTap: () => _viewInfographic(infographic),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Preview Image
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                    image: DecorationImage(
                      image: NetworkImage("${infographic["image"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Format badge
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
                      "${infographic["format"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                // Download badge
                if (isDownloadable)
                  Positioned(
                    top: spXs,
                    left: spXs,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.download,
                            size: 10,
                            color: Colors.white,
                          ),
                          SizedBox(width: 2),
                          Text(
                            "FREE",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),

            // Infographic Info
            Padding(
              padding: EdgeInsets.all(spSm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${infographic["title"]}",
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
                    "${infographic["description"]}",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: spSm),

                  // Category and Date
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${infographic["category"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${DateTime.parse(infographic["date"]).dMMMy}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),

                  // Author and Size
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 12,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "${infographic["author"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        Icons.file_download,
                        size: 12,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "${infographic["size"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),

                  // Stats and Action
                  Row(
                    children: [
                      Icon(Icons.visibility, size: 14, color: disabledBoldColor),
                      SizedBox(width: 4),
                      Text(
                        "${(infographic["views"] as int).toString()}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(Icons.favorite, size: 14, color: disabledBoldColor),
                      SizedBox(width: 4),
                      Text(
                        "${(infographic["likes"] as int).toString()}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: isDownloadable ? "Download" : "View",
                        icon: isDownloadable ? Icons.download : Icons.visibility,
                        size: bs.sm,
                        onPressed: () => isDownloadable 
                            ? _downloadInfographic(infographic)
                            : _viewInfographic(infographic),
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

  void _showSearchDialog() {
    String tempSearch = searchQuery;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Search Infographics"),
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

  void _showSortOptions() {
    List<String> sortOptions = ["Newest", "Oldest", "Most Viewed", "Most Liked"];
    
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sort by",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            ...sortOptions.map((option) => ListTile(
              title: Text(option),
              trailing: sortBy == option ? Icon(Icons.check, color: primaryColor) : null,
              onTap: () {
                sortBy = option;
                setState(() {});
                Navigator.pop(context);
              },
            )),
          ],
        ),
      ),
    );
  }

  void _viewInfographic(Map<String, dynamic> infographic) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${infographic["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
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
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("${infographic["image"]}"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Share",
                        icon: Icons.share,
                        size: bs.sm,
                        onPressed: () {
                          Navigator.pop(context);
                          _shareInfographic(infographic);
                        },
                      ),
                    ),
                    if (infographic["downloadable"] as bool) ...[
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Download",
                          icon: Icons.download,
                          size: bs.sm,
                          onPressed: () {
                            Navigator.pop(context);
                            _downloadInfographic(infographic);
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _downloadInfographic(Map<String, dynamic> infographic) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Download Infographic"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${infographic["title"]}"),
            SizedBox(height: spSm),
            Text("Format: ${infographic["format"]}"),
            Text("Size: ${infographic["size"]}"),
            SizedBox(height: spSm),
            Text(
              "This will download the high-resolution version.",
              style: TextStyle(
                fontSize: 13,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Download",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Downloading ${infographic["title"]}...");
            },
          ),
        ],
      ),
    );
  }

  void _shareInfographic(Map<String, dynamic> infographic) {
    // Update share count
    infographic["shares"] = (infographic["shares"] as int) + 1;
    setState(() {});
    ss("Sharing: ${infographic["title"]}");
  }
}
