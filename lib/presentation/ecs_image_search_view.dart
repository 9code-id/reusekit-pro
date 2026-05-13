import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsImageSearchView extends StatefulWidget {
  const EcsImageSearchView({super.key});

  @override
  State<EcsImageSearchView> createState() => _EcsImageSearchViewState();
}

class _EcsImageSearchViewState extends State<EcsImageSearchView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedImageType = "All";
  String selectedSize = "All";
  String selectedOrientation = "All";
  bool loading = false;

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Nature", "value": "Nature"},
    {"label": "Business", "value": "Business"},
    {"label": "Technology", "value": "Technology"},
    {"label": "People", "value": "People"},
    {"label": "Food", "value": "Food"},
    {"label": "Travel", "value": "Travel"},
    {"label": "Architecture", "value": "Architecture"},
    {"label": "Animals", "value": "Animals"},
  ];

  List<Map<String, dynamic>> imageTypes = [
    {"label": "All", "value": "All"},
    {"label": "Photo", "value": "Photo"},
    {"label": "Illustration", "value": "Illustration"},
    {"label": "Vector", "value": "Vector"},
  ];

  List<Map<String, dynamic>> sizeOptions = [
    {"label": "All", "value": "All"},
    {"label": "Small", "value": "Small"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Large", "value": "Large"},
    {"label": "Extra Large", "value": "Extra Large"},
  ];

  List<Map<String, dynamic>> orientationOptions = [
    {"label": "All", "value": "All"},
    {"label": "Horizontal", "value": "Horizontal"},
    {"label": "Vertical", "value": "Vertical"},
    {"label": "Square", "value": "Square"},
  ];

  List<Map<String, dynamic>> searchResults = [
    {
      "id": 1,
      "title": "Mountain Landscape",
      "url": "https://picsum.photos/300/200?random=1&keyword=mountain",
      "category": "Nature",
      "type": "Photo",
      "size": "1920x1080",
      "orientation": "Horizontal",
      "downloads": 1234,
      "likes": 567,
      "tags": ["mountain", "landscape", "nature", "sky"],
      "author": "John Smith",
      "license": "Free",
    },
    {
      "id": 2,
      "title": "Business Meeting",
      "url": "https://picsum.photos/300/400?random=2&keyword=business",
      "category": "Business",
      "type": "Photo",
      "size": "1080x1920",
      "orientation": "Vertical",
      "downloads": 890,
      "likes": 234,
      "tags": ["business", "meeting", "office", "people"],
      "author": "Sarah Johnson",
      "license": "Premium",
    },
    {
      "id": 3,
      "title": "Technology Icons",
      "url": "https://picsum.photos/300/300?random=3&keyword=tech",
      "category": "Technology",
      "type": "Vector",
      "size": "512x512",
      "orientation": "Square",
      "downloads": 2456,
      "likes": 789,
      "tags": ["technology", "icons", "digital", "vector"],
      "author": "Mike Davis",
      "license": "Free",
    },
    {
      "id": 4,
      "title": "Portrait Photography",
      "url": "https://picsum.photos/300/400?random=4&keyword=portrait",
      "category": "People",
      "type": "Photo",
      "size": "1080x1350",
      "orientation": "Vertical",
      "downloads": 1567,
      "likes": 456,
      "tags": ["portrait", "people", "photography", "model"],
      "author": "Emma Wilson",
      "license": "Premium",
    },
    {
      "id": 5,
      "title": "Food Illustration",
      "url": "https://picsum.photos/300/200?random=5&keyword=food",
      "category": "Food",
      "type": "Illustration",
      "size": "1600x900",
      "orientation": "Horizontal",
      "downloads": 678,
      "likes": 123,
      "tags": ["food", "illustration", "cooking", "restaurant"],
      "author": "Chef Alex",
      "license": "Free",
    },
    {
      "id": 6,
      "title": "Travel Adventure",
      "url": "https://picsum.photos/300/200?random=6&keyword=travel",
      "category": "Travel",
      "type": "Photo",
      "size": "1920x1080",
      "orientation": "Horizontal",
      "downloads": 3456,
      "likes": 1234,
      "tags": ["travel", "adventure", "vacation", "explore"],
      "author": "Travel Pro",
      "license": "Premium",
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  void _loadImages() async {
    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 1));

    loading = false;
    setState(() {});
  }

  void _performSearch() {
    _loadImages();
  }

  void _downloadImage(Map<String, dynamic> image) {
    if (image["license"] == "Premium") {
      se("Premium license required for download");
      return;
    }
    ss("Image downloaded successfully");
  }

  void _likeImage(Map<String, dynamic> image) {
    ss("Image added to favorites");
  }

  Widget _buildSearchFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Search Filters",
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
                child: QDropdownField(
                  label: "Category",
                  items: categories,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Type",
                  items: imageTypes,
                  value: selectedImageType,
                  onChanged: (value, label) {
                    selectedImageType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Size",
                  items: sizeOptions,
                  value: selectedSize,
                  onChanged: (value, label) {
                    selectedSize = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Orientation",
                  items: orientationOptions,
                  value: selectedOrientation,
                  onChanged: (value, label) {
                    selectedOrientation = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageCard(Map<String, dynamic> image) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Preview
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
            child: AspectRatio(
              aspectRatio: image["orientation"] == "Square" ? 1.0 :
                          image["orientation"] == "Vertical" ? 0.75 : 1.5,
              child: Image.network(
                "${image["url"]}",
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          
          // Image Details
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${image["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: image["license"] == "Premium" ? warningColor : successColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${image["license"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "By ${image["author"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.category, size: 14, color: disabledBoldColor),
                    SizedBox(width: 4),
                    Text(
                      "${image["category"]} • ${image["type"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${image["size"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
                // Stats
                Row(
                  children: [
                    Icon(Icons.download, size: 16, color: disabledBoldColor),
                    SizedBox(width: 4),
                    Text(
                      "${(image["downloads"] as int) >= 1000 ? '${((image["downloads"] as int) / 1000).toStringAsFixed(1)}K' : '${image["downloads"]}'}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.favorite, size: 16, color: dangerColor),
                    SizedBox(width: 4),
                    Text(
                      "${image["likes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
                // Tags
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (image["tags"] as List).map((tag) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "$tag",
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: spSm),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Download",
                        icon: Icons.download,
                        size: bs.sm,
                        onPressed: () => _downloadImage(image),
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.favorite_border,
                      size: bs.sm,
                      onPressed: () => _likeImage(image),
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.share,
                      size: bs.sm,
                      onPressed: () {
                        ss("Image link copied to clipboard");
                      },
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Search"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              si("Advanced filters coming soon");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search images...",
                    value: searchQuery,
                    hint: "Enter keywords, tags, or description",
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
            SizedBox(height: spMd),
            
            // Search Filters
            _buildSearchFilters(),
            
            // Results Header
            Row(
              children: [
                Text(
                  "Search Results",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${searchResults.length} images found",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            
            // Loading or Results
            if (loading)
              Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: spSm),
                    Text(
                      "Searching images...",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              Column(
                children: searchResults.map((image) => _buildImageCard(image)).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
