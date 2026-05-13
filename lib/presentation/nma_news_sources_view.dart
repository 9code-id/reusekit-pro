import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaNewsSourcesView extends StatefulWidget {
  const NmaNewsSourcesView({super.key});

  @override
  State<NmaNewsSourcesView> createState() => _NmaNewsSourcesViewState();
}

class _NmaNewsSourcesViewState extends State<NmaNewsSourcesView> {
  String searchQuery = "";
  String selectedCategory = "all";
  String selectedRegion = "all";
  List<String> followedSources = ["bbc", "cnn", "reuters"];

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Categories", "value": "all"},
    {"label": "General News", "value": "general"},
    {"label": "Business", "value": "business"},
    {"label": "Technology", "value": "technology"},
    {"label": "Sports", "value": "sports"},
    {"label": "Entertainment", "value": "entertainment"},
    {"label": "Health", "value": "health"},
    {"label": "Science", "value": "science"},
  ];

  List<Map<String, dynamic>> regionItems = [
    {"label": "All Regions", "value": "all"},
    {"label": "United States", "value": "us"},
    {"label": "United Kingdom", "value": "uk"},
    {"label": "Canada", "value": "ca"},
    {"label": "Australia", "value": "au"},
    {"label": "Germany", "value": "de"},
    {"label": "France", "value": "fr"},
  ];

  List<Map<String, dynamic>> newsSources = [
    {
      "id": "bbc",
      "name": "BBC News",
      "description": "Breaking news, world news, UK news, and analysis",
      "category": "general",
      "region": "uk",
      "logo": "https://picsum.photos/60/60?random=1&keyword=bbc",
      "url": "https://bbc.com/news",
      "verified": true,
      "followers": 15420000,
      "articlesPerDay": 120,
      "language": "English",
      "rating": 4.8,
    },
    {
      "id": "cnn",
      "name": "CNN",
      "description": "Breaking news and live coverage from CNN",
      "category": "general",
      "region": "us",
      "logo": "https://picsum.photos/60/60?random=2&keyword=news",
      "url": "https://cnn.com",
      "verified": true,
      "followers": 12800000,
      "articlesPerDay": 100,
      "language": "English",
      "rating": 4.5,
    },
    {
      "id": "reuters",
      "name": "Reuters",
      "description": "International breaking news and headlines",
      "category": "general",
      "region": "us",
      "logo": "https://picsum.photos/60/60?random=3&keyword=reuters",
      "url": "https://reuters.com",
      "verified": true,
      "followers": 8950000,
      "articlesPerDay": 85,
      "language": "English",
      "rating": 4.9,
    },
    {
      "id": "ap",
      "name": "Associated Press",
      "description": "The definitive source for independent journalism",
      "category": "general",
      "region": "us",
      "logo": "https://picsum.photos/60/60?random=4&keyword=press",
      "url": "https://apnews.com",
      "verified": true,
      "followers": 7200000,
      "articlesPerDay": 75,
      "language": "English",
      "rating": 4.7,
    },
    {
      "id": "guardian",
      "name": "The Guardian",
      "description": "Latest news, sport and comment from the Guardian",
      "category": "general",
      "region": "uk",
      "logo": "https://picsum.photos/60/60?random=5&keyword=guardian",
      "url": "https://theguardian.com",
      "verified": true,
      "followers": 6800000,
      "articlesPerDay": 90,
      "language": "English",
      "rating": 4.6,
    },
    {
      "id": "bloomberg",
      "name": "Bloomberg",
      "description": "Business and financial news",
      "category": "business",
      "region": "us",
      "logo": "https://picsum.photos/60/60?random=6&keyword=bloomberg",
      "url": "https://bloomberg.com",
      "verified": true,
      "followers": 5400000,
      "articlesPerDay": 60,
      "language": "English",
      "rating": 4.4,
    },
    {
      "id": "techcrunch",
      "name": "TechCrunch",
      "description": "Startup and technology news",
      "category": "technology",
      "region": "us",
      "logo": "https://picsum.photos/60/60?random=7&keyword=tech",
      "url": "https://techcrunch.com",
      "verified": true,
      "followers": 4200000,
      "articlesPerDay": 45,
      "language": "English",
      "rating": 4.3,
    },
    {
      "id": "espn",
      "name": "ESPN",
      "description": "Sports news, scores, and highlights",
      "category": "sports",
      "region": "us",
      "logo": "https://picsum.photos/60/60?random=8&keyword=sports",
      "url": "https://espn.com",
      "verified": true,
      "followers": 8100000,
      "articlesPerDay": 80,
      "language": "English",
      "rating": 4.2,
    },
  ];

  List<Map<String, dynamic>> get filteredSources {
    return newsSources.where((source) {
      bool matchesSearch = searchQuery.isEmpty ||
          (source["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (source["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "all" || source["category"] == selectedCategory;
      bool matchesRegion = selectedRegion == "all" || source["region"] == selectedRegion;
      
      return matchesSearch && matchesCategory && matchesRegion;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Sources"),
        actions: [
          GestureDetector(
            onTap: () {
              // Navigate to followed sources
              // ss('Next page'));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Icon(
                Icons.favorite,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search sources...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.tune,
                  size: bs.sm,
                  onPressed: () {
                    _showFilterOptions();
                  },
                ),
              ],
            ),

            // Filter Chips
            if (selectedCategory != "all" || selectedRegion != "all")
              Container(
                height: 40,
                child: QHorizontalScroll(
                  children: [
                    if (selectedCategory != "all")
                      _buildFilterChip(
                        "Category: ${_getCategoryLabel()}",
                        () {
                          selectedCategory = "all";
                          setState(() {});
                        },
                      ),
                    if (selectedRegion != "all")
                      _buildFilterChip(
                        "Region: ${_getRegionLabel()}",
                        () {
                          selectedRegion = "all";
                          setState(() {});
                        },
                      ),
                  ],
                ),
              ),

            // Sources Count
            Row(
              children: [
                Text(
                  "Showing ${filteredSources.length} sources",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Text(
                  "Following: ${followedSources.length}",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            // Sources List
            ...filteredSources.map((source) => _buildSourceItem(source)),
          ],
        ),
      ),
    );
  }

  Widget _buildSourceItem(Map<String, dynamic> source) {
    bool isFollowing = followedSources.contains(source["id"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              // Source Logo
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${source["logo"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spMd),
              
              // Source Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${source["name"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        if (source["verified"] as bool)
                          SizedBox(width: spXs),
                        if (source["verified"] as bool)
                          Icon(
                            Icons.verified,
                            color: primaryColor,
                            size: 16,
                          ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${source["description"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              
              // Follow Button
              QButton(
                label: isFollowing ? "Following" : "Follow",
                size: bs.sm,
                onPressed: () {
                  _toggleFollowSource(source["id"]);
                },
              ),
            ],
          ),
          
          // Source Stats
          Row(
            children: [
              _buildStatItem(Icons.people, "${((source["followers"] as int) / 1000000).toStringAsFixed(1)}M followers"),
              SizedBox(width: spMd),
              _buildStatItem(Icons.article, "${source["articlesPerDay"]} articles/day"),
              SizedBox(width: spMd),
              _buildStatItem(Icons.star, "${(source["rating"] as double).toStringAsFixed(1)}"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: disabledBoldColor,
        ),
        SizedBox(width: spXs),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, VoidCallback onRemove) {
    return Container(
      margin: EdgeInsets.only(right: spSm),
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: spXs),
          GestureDetector(
            onTap: onRemove,
            child: Icon(
              Icons.close,
              size: 14,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  String _getCategoryLabel() {
    return categoryItems.firstWhere((item) => item["value"] == selectedCategory)["label"];
  }

  String _getRegionLabel() {
    return regionItems.firstWhere((item) => item["value"] == selectedRegion)["label"];
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spMd,
          children: [
            Text(
              "Filter Sources",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            QDropdownField(
              label: "Category",
              items: categoryItems,
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
                Navigator.pop(context);
              },
            ),
            QDropdownField(
              label: "Region",
              items: regionItems,
              value: selectedRegion,
              onChanged: (value, label) {
                selectedRegion = value;
                setState(() {});
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _toggleFollowSource(String sourceId) {
    if (followedSources.contains(sourceId)) {
      followedSources.remove(sourceId);
      ss("Unfollowed source");
    } else {
      followedSources.add(sourceId);
      ss("Following source");
    }
    setState(() {});
  }
}
