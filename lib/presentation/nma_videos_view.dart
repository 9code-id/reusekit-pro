import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaVideosView extends StatefulWidget {
  const NmaVideosView({super.key});

  @override
  State<NmaVideosView> createState() => _NmaVideosViewState();
}

class _NmaVideosViewState extends State<NmaVideosView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String sortBy = "newest";
  bool isLoading = false;

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Tutorials", "value": "Tutorials"},
    {"label": "Webinars", "value": "Webinars"},
    {"label": "Product Demos", "value": "Product Demos"},
    {"label": "Case Studies", "value": "Case Studies"},
    {"label": "Live Sessions", "value": "Live Sessions"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Newest", "value": "newest"},
    {"label": "Most Viewed", "value": "views"},
    {"label": "Highest Rated", "value": "rating"},
    {"label": "Duration", "value": "duration"},
  ];

  List<Map<String, dynamic>> videosData = [
    {
      "id": "1",
      "title": "Advanced Social Media Marketing Strategies",
      "description": "Learn advanced techniques to boost your social media presence and engagement rates",
      "thumbnail": "https://picsum.photos/320/180?random=1&keyword=marketing",
      "duration": "25:34",
      "views": 15420,
      "rating": 4.8,
      "category": "Tutorials",
      "uploadDate": "2024-01-10",
      "instructor": "Sarah Johnson",
      "tags": ["social media", "marketing", "strategy"],
      "isLive": false,
      "isPremium": true,
    },
    {
      "id": "2",
      "title": "Keyword Research Masterclass",
      "description": "Complete guide to finding profitable keywords for your content marketing campaigns",
      "thumbnail": "https://picsum.photos/320/180?random=2&keyword=research",
      "duration": "42:15",
      "views": 8930,
      "rating": 4.9,
      "category": "Tutorials",
      "uploadDate": "2024-01-08",
      "instructor": "Mike Chen",
      "tags": ["keywords", "SEO", "research"],
      "isLive": false,
      "isPremium": false,
    },
    {
      "id": "3",
      "title": "Live: Content Creation Workshop",
      "description": "Join our live workshop to learn content creation best practices",
      "thumbnail": "https://picsum.photos/320/180?random=3&keyword=content",
      "duration": "LIVE",
      "views": 324,
      "rating": 4.6,
      "category": "Live Sessions",
      "uploadDate": "2024-01-13",
      "instructor": "Emma Rodriguez",
      "tags": ["content", "creation", "live"],
      "isLive": true,
      "isPremium": false,
    },
    {
      "id": "4",
      "title": "Analytics Dashboard Deep Dive",
      "description": "Comprehensive walkthrough of analytics features and reporting tools",
      "thumbnail": "https://picsum.photos/320/180?random=4&keyword=analytics",
      "duration": "18:42",
      "views": 6750,
      "rating": 4.7,
      "category": "Product Demos",
      "uploadDate": "2024-01-05",
      "instructor": "David Park",
      "tags": ["analytics", "dashboard", "reporting"],
      "isLive": false,
      "isPremium": true,
    },
    {
      "id": "5",
      "title": "Client Success Story: 300% ROI Increase",
      "description": "Real case study showing how our client achieved 300% ROI improvement",
      "thumbnail": "https://picsum.photos/320/180?random=5&keyword=success",
      "duration": "15:28",
      "views": 12850,
      "rating": 4.9,
      "category": "Case Studies",
      "uploadDate": "2024-01-03",
      "instructor": "Lisa Wang",
      "tags": ["case study", "ROI", "success"],
      "isLive": false,
      "isPremium": false,
    },
    {
      "id": "6",
      "title": "Monthly Marketing Trends Webinar",
      "description": "Latest marketing trends and predictions for the upcoming quarter",
      "thumbnail": "https://picsum.photos/320/180?random=6&keyword=trends",
      "duration": "60:00",
      "views": 4230,
      "rating": 4.5,
      "category": "Webinars",
      "uploadDate": "2024-01-01",
      "instructor": "Alex Thompson",
      "tags": ["trends", "webinar", "marketing"],
      "isLive": false,
      "isPremium": true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  void _loadVideos() {
    isLoading = true;
    setState(() {});

    // Simulate API call
    Future.delayed(Duration(seconds: 1), () {
      isLoading = false;
      setState(() {});
    });
  }

  List<Map<String, dynamic>> get filteredVideos {
    var filtered = videosData;
    
    if (selectedCategory != "All") {
      filtered = filtered.where((video) => video["category"] == selectedCategory).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((video) => 
        (video["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (video["description"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (video["instructor"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (video["tags"] as List<String>).any((tag) => 
          tag.toLowerCase().contains(searchQuery.toLowerCase()))
      ).toList();
    }
    
    // Sort results
    filtered.sort((a, b) {
      switch (sortBy) {
        case "views":
          return (b["views"] as int).compareTo(a["views"] as int);
        case "rating":
          return (b["rating"] as double).compareTo(a["rating"] as double);
        case "duration":
          return (a["duration"] as String).compareTo(b["duration"] as String);
        default: // newest
          return DateTime.parse(b["uploadDate"] as String)
              .compareTo(DateTime.parse(a["uploadDate"] as String));
      }
    });
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Library"),
        actions: [
          IconButton(
            icon: Icon(Icons.playlist_add),
            onPressed: () {
              // Navigate to playlists
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  // Search and Sort
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search videos...",
                          value: searchQuery,
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QDropdownField(
                        label: "Sort by",
                        items: sortOptions,
                        value: sortBy,
                        onChanged: (value, label) {
                          sortBy = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),

                  // Category Filter
                  QCategoryPicker(
                    label: "Filter by Category",
                    items: categoryOptions,
                    value: selectedCategory,
                    onChanged: (index, label, value, item) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),

                  // Stats Overview
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Total Videos",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${videosData.length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Live Now",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${videosData.where((v) => v["isLive"] == true).length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Total Views",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${((videosData.map((v) => v["views"] as int).reduce((a, b) => a + b)) / 1000).toStringAsFixed(0)}K",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Videos List
                  Text(
                    "Videos (${filteredVideos.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  ResponsiveGridView(
                    minItemWidth: 200,
                    children: filteredVideos.map((video) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Video Thumbnail
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(radiusSm),
                                    topRight: Radius.circular(radiusSm),
                                  ),
                                  child: Image.network(
                                    "${video["thumbnail"]}",
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                
                                // Duration/Live Badge
                                Positioned(
                                  bottom: spXs,
                                  right: spXs,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: video["isLive"] == true 
                                          ? dangerColor 
                                          : Colors.black.withAlpha(180),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${video["duration"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                
                                // Premium Badge
                                if (video["isPremium"] == true)
                                  Positioned(
                                    top: spXs,
                                    left: spXs,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: warningColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "PREMIUM",
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                
                                // Play Button Overlay
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withAlpha(30),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(radiusSm),
                                        topRight: Radius.circular(radiusSm),
                                      ),
                                    ),
                                    child: Center(
                                      child: Container(
                                        padding: EdgeInsets.all(spSm),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withAlpha(200),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.play_arrow,
                                          color: primaryColor,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            // Video Info
                            Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "${video["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  
                                  Text(
                                    "${video["description"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        size: 12,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: 2),
                                      Expanded(
                                        child: Text(
                                          "${video["instructor"]}",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: disabledBoldColor,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.visibility,
                                        size: 12,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        "${((video["views"] as int) / 1000).toStringAsFixed(1)}K",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Icon(
                                        Icons.star,
                                        size: 12,
                                        color: warningColor,
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        "${video["rating"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: infoColor.withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${video["category"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: infoColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  
                                  // Tags
                                  Wrap(
                                    spacing: 4,
                                    runSpacing: 4,
                                    children: (video["tags"] as List<String>).take(3).map((tag) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 4,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: secondaryColor.withAlpha(30),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "#$tag",
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: secondaryColor,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  
                                  // Action Buttons
                                  Row(
                                    children: [
                                      Expanded(
                                        child: QButton(
                                          label: video["isLive"] == true ? "Join Live" : "Watch",
                                          size: bs.sm,
                                          onPressed: () {
                                            // Navigate to video player
                                          },
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      QButton(
                                        icon: Icons.bookmark_border,
                                        size: bs.sm,
                                        onPressed: () {
                                          // Save to playlist
                                        },
                                      ),
                                      SizedBox(width: spXs),
                                      QButton(
                                        icon: Icons.share,
                                        size: bs.sm,
                                        onPressed: () {
                                          // Share video
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
                    }).toList(),
                  ),
                ],
              ),
            ),
    );
  }
}
