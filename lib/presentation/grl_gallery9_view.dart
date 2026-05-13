import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlGallery9View extends StatefulWidget {
  @override
  State<GrlGallery9View> createState() => _GrlGallery9ViewState();
}

class _GrlGallery9ViewState extends State<GrlGallery9View> {
  String searchQuery = "";
  String selectedCategory = "All";
  bool loading = false;

  final List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Landscapes", "value": "Landscapes"},
    {"label": "Portraits", "value": "Portraits"},
    {"label": "Architecture", "value": "Architecture"},
    {"label": "Wildlife", "value": "Wildlife"},
    {"label": "Abstract", "value": "Abstract"},
  ];

  final List<Map<String, dynamic>> videos = [
    {
      "id": 1,
      "title": "Sunset Timelapse",
      "thumbnail": "https://picsum.photos/400/300?random=110&keyword=sunset",
      "duration": "2:34",
      "category": "Landscapes",
      "author": "Nature Films",
      "views": 12450,
      "likes": 892,
      "uploadDate": "2024-01-20",
      "description": "Beautiful sunset timelapse over mountain range",
      "quality": "4K"
    },
    {
      "id": 2,
      "title": "Portrait Photography Tips",
      "thumbnail": "https://picsum.photos/400/300?random=111&keyword=portrait",
      "duration": "8:15",
      "category": "Portraits",
      "author": "Photo Academy",
      "views": 45670,
      "likes": 3210,
      "uploadDate": "2024-01-19",
      "description": "Learn professional portrait photography techniques",
      "quality": "HD"
    },
    {
      "id": 3,
      "title": "Modern Architecture Tour",
      "thumbnail": "https://picsum.photos/400/300?random=112&keyword=architecture",
      "duration": "5:42",
      "category": "Architecture",
      "author": "City Explorer",
      "views": 28930,
      "likes": 1876,
      "uploadDate": "2024-01-18",
      "description": "Exploring contemporary architectural marvels",
      "quality": "4K"
    },
    {
      "id": 4,
      "title": "Wildlife Safari",
      "thumbnail": "https://picsum.photos/400/300?random=113&keyword=wildlife",
      "duration": "12:18",
      "category": "Wildlife",
      "author": "Safari Adventures",
      "views": 67890,
      "likes": 4523,
      "uploadDate": "2024-01-17",
      "description": "Amazing wildlife encounters in their natural habitat",
      "quality": "4K"
    },
    {
      "id": 5,
      "title": "Abstract Art Creation",
      "thumbnail": "https://picsum.photos/400/300?random=114&keyword=abstract",
      "duration": "6:28",
      "category": "Abstract",
      "author": "Digital Artist",
      "views": 19870,
      "likes": 1245,
      "uploadDate": "2024-01-16",
      "description": "Creating stunning abstract art with digital tools",
      "quality": "HD"
    },
    {
      "id": 6,
      "title": "Mountain Landscape",
      "thumbnail": "https://picsum.photos/400/300?random=115&keyword=mountain",
      "duration": "4:56",
      "category": "Landscapes",
      "author": "Mountain Views",
      "views": 34560,
      "likes": 2341,
      "uploadDate": "2024-01-15",
      "description": "Breathtaking mountain scenery from aerial perspective",
      "quality": "4K"
    },
  ];

  List<Map<String, dynamic>> get filteredVideos {
    var filtered = videos;

    // Filter by category
    if (selectedCategory != "All") {
      filtered = filtered.where((video) => video["category"] == selectedCategory).toList();
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((video) {
        final title = (video["title"] as String).toLowerCase();
        final author = (video["author"] as String).toLowerCase();
        final description = (video["description"] as String).toLowerCase();
        final query = searchQuery.toLowerCase();
        return title.contains(query) || author.contains(query) || description.contains(query);
      }).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Gallery"),
        actions: [
          IconButton(
            icon: Icon(Icons.video_library),
            onPressed: () {
              // navigateTo(MyVideosView());
            },
          ),
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () {
              si("Upload video feature coming soon!");
            },
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Video Gallery",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Discover amazing photography and art videos",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.play_circle_fill,
                          color: primaryColor,
                          size: 30,
                        ),
                      ),
                    ],
                  ),

                  // Search Bar
                  QTextField(
                    label: "Search videos...",
                    value: searchQuery,
                    hint: "Search by title, author, or description",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),

                  // Category Filter
                  QCategoryPicker(
                    label: "Select Category",
                    items: categories,
                    value: selectedCategory,
                    onChanged: (index, label, value, item) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),

                  // Stats Section
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${filteredVideos.length}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Videos",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(width: 1, height: 40, color: disabledColor),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${((filteredVideos.fold(0, (sum, video) => sum + (video["views"] as int))) / 1000).toStringAsFixed(0)}K",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "Total Views",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(width: 1, height: 40, color: disabledColor),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${((filteredVideos.fold(0, (sum, video) => sum + (video["likes"] as int))) / 1000).toStringAsFixed(1)}K",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                              Text(
                                "Total Likes",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Videos List
                  if (filteredVideos.isNotEmpty)
                    ...filteredVideos.map((video) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Video Thumbnail
                            Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(radiusLg),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(radiusLg),
                                ),
                                child: Stack(
                                  children: [
                                    Image.network(
                                      "${video["thumbnail"]}",
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),

                                    // Play Button Overlay
                                    Positioned.fill(
                                      child: Container(
                                        color: Colors.black.withAlpha(100),
                                        child: Center(
                                          child: GestureDetector(
                                            onTap: () {
                                              si("Video player feature coming soon!");
                                            },
                                            child: Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(radiusLg),
                                                boxShadow: [shadowMd],
                                              ),
                                              child: Icon(
                                                Icons.play_arrow,
                                                size: 30,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Duration Badge
                                    Positioned(
                                      bottom: spSm,
                                      right: spSm,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withAlpha(180),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "${video["duration"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Quality Badge
                                    Positioned(
                                      top: spSm,
                                      right: spSm,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: video["quality"] == "4K" ? dangerColor : successColor,
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "${video["quality"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Category Badge
                                    Positioned(
                                      top: spSm,
                                      left: spSm,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "${video["category"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Video Info
                            Padding(
                              padding: EdgeInsets.all(spMd),
                              child: Column(
                                spacing: spSm,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title and Author
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${video["title"]}",
                                              style: TextStyle(
                                                fontSize: fsH6,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                            Text(
                                              "by ${video["author"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "${video["uploadDate"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Description
                                  Text(
                                    "${video["description"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),

                                  // Stats
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.visibility,
                                        size: 16,
                                        color: infoColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${((video["views"] as int) / 1000).toStringAsFixed(1)}K views",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(width: spMd),
                                      Icon(
                                        Icons.favorite,
                                        size: 16,
                                        color: dangerColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${video["likes"]} likes",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Action Buttons
                                  Row(
                                    children: [
                                      Expanded(
                                        child: QButton(
                                          label: "Watch Now",
                                          icon: Icons.play_arrow,
                                          size: bs.sm,
                                          onPressed: () {
                                            si("Video player feature coming soon!");
                                          },
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      QButton(
                                        icon: Icons.favorite_border,
                                        size: bs.sm,
                                        onPressed: () {
                                          ss("Added to favorites!");
                                        },
                                      ),
                                      SizedBox(width: spXs),
                                      QButton(
                                        icon: Icons.share,
                                        size: bs.sm,
                                        onPressed: () {
                                          si("Share feature coming soon!");
                                        },
                                      ),
                                      SizedBox(width: spXs),
                                      QButton(
                                        icon: Icons.download,
                                        size: bs.sm,
                                        onPressed: () {
                                          sw("Download requires premium subscription!");
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

                  // No Results
                  if (filteredVideos.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spXl),
                      child: Column(
                        spacing: spMd,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.video_library_outlined,
                            size: 60,
                            color: disabledColor,
                          ),
                          Text(
                            "No videos found",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Try adjusting your search or category filter",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Load More
                  if (filteredVideos.isNotEmpty)
                    Center(
                      child: QButton(
                        label: "Load More Videos",
                        size: bs.md,
                        onPressed: () async {
                          loading = true;
                          setState(() {});
                          
                          await Future.delayed(Duration(seconds: 2));
                          
                          loading = false;
                          setState(() {});
                          
                          si("More videos loaded!");
                        },
                      ),
                    ),

                  // Premium Banner
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(color: warningColor.withAlpha(30)),
                    ),
                    child: Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 20,
                              color: warningColor,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "Upgrade to Premium",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                            ),
                            QButton(
                              label: "Upgrade Now",
                              size: bs.sm,
                              onPressed: () {
                                si("Premium upgrade feature coming soon!");
                              },
                            ),
                          ],
                        ),
                        Text(
                          "• Download videos in HD/4K quality\n• Access exclusive content\n• Ad-free viewing experience\n• Offline playback support",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
