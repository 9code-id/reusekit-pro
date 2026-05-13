import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaPresetsView extends StatefulWidget {
  const PpaPresetsView({super.key});

  @override
  State<PpaPresetsView> createState() => _PpaPresetsViewState();
}

class _PpaPresetsViewState extends State<PpaPresetsView> {
  String selectedCategory = "all";
  String searchQuery = "";
  bool showFavorites = false;

  List<Map<String, dynamic>> presetCategories = [
    {"label": "All", "value": "all", "count": 48},
    {"label": "Portrait", "value": "portrait", "count": 12},
    {"label": "Landscape", "value": "landscape", "count": 15},
    {"label": "Vintage", "value": "vintage", "count": 8},
    {"label": "Modern", "value": "modern", "count": 10},
    {"label": "Black & White", "value": "bw", "count": 6},
    {"label": "Film", "value": "film", "count": 9},
  ];

  List<Map<String, dynamic>> presets = [
    {
      "id": 1,
      "name": "Golden Hour",
      "category": "portrait",
      "thumbnail": "https://picsum.photos/150/100?random=1&keyword=golden",
      "author": "Studio Pro",
      "downloads": 2850,
      "rating": 4.8,
      "favorite": true,
      "premium": false,
      "description": "Warm golden hour lighting effect for portraits"
    },
    {
      "id": 2,
      "name": "Cinematic Blue",
      "category": "modern",
      "thumbnail": "https://picsum.photos/150/100?random=2&keyword=blue",
      "author": "Color Master",
      "downloads": 1920,
      "rating": 4.6,
      "favorite": false,
      "premium": true,
      "description": "Cool cinematic color grading with blue tones"
    },
    {
      "id": 3,
      "name": "Vintage Film",
      "category": "vintage",
      "thumbnail": "https://picsum.photos/150/100?random=3&keyword=vintage",
      "author": "Retro Studio",
      "downloads": 3200,
      "rating": 4.9,
      "favorite": true,
      "premium": false,
      "description": "Classic film emulation with grain and color shift"
    },
    {
      "id": 4,
      "name": "Natural Landscape",
      "category": "landscape",
      "thumbnail": "https://picsum.photos/150/100?random=4&keyword=nature",
      "author": "Nature Photos",
      "downloads": 1650,
      "rating": 4.5,
      "favorite": false,
      "premium": false,
      "description": "Enhanced natural colors for landscape photography"
    },
    {
      "id": 5,
      "name": "Dramatic B&W",
      "category": "bw",
      "thumbnail": "https://picsum.photos/150/100?random=5&keyword=dramatic",
      "author": "Mono Art",
      "downloads": 2100,
      "rating": 4.7,
      "favorite": true,
      "premium": true,
      "description": "High contrast black and white with dramatic shadows"
    },
    {
      "id": 6,
      "name": "Soft Portrait",
      "category": "portrait",
      "thumbnail": "https://picsum.photos/150/100?random=6&keyword=soft",
      "author": "Portrait Pro",
      "downloads": 1890,
      "rating": 4.4,
      "favorite": false,
      "premium": false,
      "description": "Soft and dreamy portrait enhancement"
    },
    {
      "id": 7,
      "name": "Urban Night",
      "category": "modern",
      "thumbnail": "https://picsum.photos/150/100?random=7&keyword=urban",
      "author": "City Lights",
      "downloads": 1420,
      "rating": 4.3,
      "favorite": false,
      "premium": true,
      "description": "Enhanced urban night photography with neon colors"
    },
    {
      "id": 8,
      "name": "Film Noir",
      "category": "film",
      "thumbnail": "https://picsum.photos/150/100?random=8&keyword=noir",
      "author": "Classic Cinema",
      "downloads": 980,
      "rating": 4.6,
      "favorite": true,
      "premium": false,
      "description": "Classic film noir style with deep shadows"
    },
  ];

  List<Map<String, dynamic>> get filteredPresets {
    var filtered = presets.where((preset) {
      bool matchesCategory = selectedCategory == "all" || preset["category"] == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty || 
                          (preset["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
                          (preset["author"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesFavorites = !showFavorites || preset["favorite"] == true;
      
      return matchesCategory && matchesSearch && matchesFavorites;
    }).toList();

    // Sort by rating and downloads
    filtered.sort((a, b) {
      double ratingDiff = (b["rating"] as double) - (a["rating"] as double);
      if (ratingDiff != 0) return ratingDiff.round();
      return (b["downloads"] as int) - (a["downloads"] as int);
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Presets"),
        actions: [
          IconButton(
            icon: Icon(showFavorites ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              showFavorites = !showFavorites;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.cloud_download),
            onPressed: () {
              _showDownloadMore();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: disabledBoldColor),
                        SizedBox(width: spSm),
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              searchQuery = value;
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              hintText: "Search presets...",
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: disabledBoldColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(Icons.tune, color: Colors.white),
                ),
              ],
            ),
          ),

          // Category Filter
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(vertical: spXs),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: presetCategories.length,
              itemBuilder: (context, index) {
                final category = presetCategories[index];
                bool isSelected = selectedCategory == category["value"];
                
                return Container(
                  margin: EdgeInsets.only(right: spSm),
                  child: GestureDetector(
                    onTap: () {
                      selectedCategory = category["value"];
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${category["label"]}",
                            style: TextStyle(
                              color: isSelected ? Colors.white : primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.white.withAlpha(50) : disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${category["count"]}",
                              style: TextStyle(
                                color: isSelected ? Colors.white : disabledBoldColor,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Results Info
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spXs),
            child: Row(
              children: [
                Text(
                  "${filteredPresets.length} presets found",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                Spacer(),
                if (showFavorites)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "Favorites Only",
                      style: TextStyle(
                        color: dangerColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Presets Grid
          Expanded(
            child: ResponsiveGridView(
              padding: EdgeInsets.all(spMd),
              minItemWidth: 180,
              children: filteredPresets.map((preset) {
                return _buildPresetCard(preset);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPresetCard(Map<String, dynamic> preset) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusSm),
                    topRight: Radius.circular(radiusSm),
                  ),
                  image: DecorationImage(
                    image: NetworkImage("${preset["thumbnail"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              // Premium badge
              if (preset["premium"])
                Positioned(
                  top: spXs,
                  left: spXs,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: warningColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "PRO",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              // Favorite button
              Positioned(
                top: spXs,
                right: spXs,
                child: GestureDetector(
                  onTap: () {
                    _toggleFavorite(preset["id"]);
                  },
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(100),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      preset["favorite"] ? Icons.favorite : Icons.favorite_border,
                      color: preset["favorite"] ? dangerColor : Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${preset["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                
                Text(
                  "${preset["description"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                Row(
                  children: [
                    Icon(Icons.person, size: 12, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${preset["author"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star, size: 12, color: warningColor),
                        SizedBox(width: spXs),
                        Text(
                          "${preset["rating"]}",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: spSm),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.download, size: 12, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${_formatDownloadCount(preset["downloads"] as int)}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: spXs),
                
                Row(
                  spacing: spXs,
                  children: [
                    Expanded(
                      flex: 2,
                      child: QButton(
                        label: "Apply",
                        size: bs.sm,
                        onPressed: () {
                          _applyPreset(preset);
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        icon: Icons.visibility,
                        size: bs.sm,
                        onPressed: () {
                          _previewPreset(preset);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDownloadCount(int count) {
    if (count >= 1000) {
      return "${(count / 1000).toStringAsFixed(1)}K";
    }
    return count.toString();
  }

  void _toggleFavorite(int presetId) {
    final presetIndex = presets.indexWhere((preset) => preset["id"] == presetId);
    if (presetIndex != -1) {
      presets[presetIndex]["favorite"] = !presets[presetIndex]["favorite"];
      setState(() {});
      
      String message = presets[presetIndex]["favorite"]
        ? "Added to favorites"
        : "Removed from favorites";
      si(message);
    }
  }

  void _applyPreset(Map<String, dynamic> preset) {
    if (preset["premium"] && !_isPremiumUser()) {
      _showPremiumDialog(preset);
      return;
    }
    
    ss("Applied preset: ${preset["name"]}");
    
    // Increment download count
    final presetIndex = presets.indexWhere((p) => p["id"] == preset["id"]);
    if (presetIndex != -1) {
      presets[presetIndex]["downloads"] = (presets[presetIndex]["downloads"] as int) + 1;
      setState(() {});
    }
  }

  void _previewPreset(Map<String, dynamic> preset) {
    si("Previewing preset: ${preset["name"]}");
  }

  bool _isPremiumUser() {
    // In real app, check user's premium status
    return false;
  }

  void _showPremiumDialog(Map<String, dynamic> preset) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.star, color: warningColor),
            SizedBox(width: spSm),
            Text("Premium Preset"),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${preset["name"]} is a premium preset."),
            SizedBox(height: spSm),
            Text(
              "Upgrade to Pro to access:",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: spXs),
            Text("• 500+ premium presets"),
            Text("• Advanced editing tools"),
            Text("• Priority support"),
            Text("• No watermarks"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              back();
              si("Redirecting to premium upgrade...");
            },
            child: Text("Upgrade Now"),
          ),
        ],
      ),
    );
  }

  void _showDownloadMore() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Download More Presets"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.cloud_download),
              title: Text("Browse Online Store"),
              subtitle: Text("1000+ professional presets"),
              onTap: () {
                back();
                si("Opening online preset store...");
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Community Presets"),
              subtitle: Text("User-generated content"),
              onTap: () {
                back();
                si("Opening community presets...");
              },
            ),
            ListTile(
              leading: Icon(Icons.file_upload),
              title: Text("Import Preset"),
              subtitle: Text("Load from file"),
              onTap: () {
                back();
                si("Opening file picker for preset import...");
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}
