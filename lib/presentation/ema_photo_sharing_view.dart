import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaPhotoSharingView extends StatefulWidget {
  const EmaPhotoSharingView({super.key});

  @override
  State<EmaPhotoSharingView> createState() => _EmaPhotoSharingViewState();
}

class _EmaPhotoSharingViewState extends State<EmaPhotoSharingView> {
  List<String> selectedPhotos = [];
  String selectedCategory = "All";
  List<String> categories = ["All", "Mood", "Activities", "Environment", "Food", "Progress"];
  
  List<Map<String, dynamic>> sharedPhotos = [
    {
      "id": 1,
      "url": "https://picsum.photos/300/300?random=1&keyword=nature",
      "title": "Morning Walk",
      "description": "Feeling refreshed after my morning walk in the park",
      "category": "Activities",
      "timestamp": "2025-06-18 08:30",
      "mood": "Happy",
      "tags": ["exercise", "nature", "morning"],
      "isShared": true,
      "reactions": {"likes": 5, "comments": 2},
    },
    {
      "id": 2,
      "url": "https://picsum.photos/300/300?random=2&keyword=food",
      "title": "Healthy Breakfast",
      "description": "Starting the day with a nutritious meal",
      "category": "Food",
      "timestamp": "2025-06-18 07:45",
      "mood": "Energetic",
      "tags": ["healthy", "breakfast", "nutrition"],
      "isShared": false,
      "reactions": {"likes": 0, "comments": 0},
    },
    {
      "id": 3,
      "url": "https://picsum.photos/300/300?random=3&keyword=workspace",
      "title": "Organized Workspace",
      "description": "Clean desk, clear mind - ready for a productive day",
      "category": "Environment",
      "timestamp": "2025-06-17 09:15",
      "mood": "Focused",
      "tags": ["workspace", "organization", "productivity"],
      "isShared": true,
      "reactions": {"likes": 8, "comments": 1},
    },
    {
      "id": 4,
      "url": "https://picsum.photos/300/300?random=4&keyword=sunset",
      "title": "Evening Reflection",
      "description": "Peaceful sunset moment for today's reflection",
      "category": "Mood",
      "timestamp": "2025-06-17 19:30",
      "mood": "Calm",
      "tags": ["sunset", "reflection", "peace"],
      "isShared": true,
      "reactions": {"likes": 12, "comments": 3},
    },
    {
      "id": 5,
      "url": "https://picsum.photos/300/300?random=5&keyword=exercise",
      "title": "Workout Session",
      "description": "30-minute yoga session completed",
      "category": "Activities",
      "timestamp": "2025-06-17 17:00",
      "mood": "Accomplished",
      "tags": ["yoga", "exercise", "wellness"],
      "isShared": false,
      "reactions": {"likes": 0, "comments": 0},
    },
    {
      "id": 6,
      "url": "https://picsum.photos/300/300?random=6&keyword=progress",
      "title": "Weekly Progress",
      "description": "Visual representation of my mood tracking progress",
      "category": "Progress",
      "timestamp": "2025-06-16 20:00",
      "mood": "Proud",
      "tags": ["progress", "achievement", "tracking"],
      "isShared": true,
      "reactions": {"likes": 15, "comments": 5},
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredPhotos = sharedPhotos.where((photo) {
      if (selectedCategory == "All") return true;
      return photo["category"] == selectedCategory;
    }).toList();

    int sharedCount = sharedPhotos.where((photo) => photo["isShared"] == true).length;
    int totalLikes = sharedPhotos.fold(0, (sum, photo) => sum + (photo["reactions"]["likes"] as int));

    return Scaffold(
      appBar: AppBar(
        title: Text("Photo Sharing"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: () {
              // navigateTo('CameraView')
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // navigateTo('PhotoSharingSettingsView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Summary Stats
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(15),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${sharedPhotos.length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Photos",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: disabledOutlineBorderColor,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${sharedCount}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Shared",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: disabledOutlineBorderColor,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${totalLikes}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Total Likes",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Category Filter
            QCategoryPicker(
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

            // Photo Upload Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(15),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.cloud_upload,
                        color: infoColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Share Your Moment",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Capture and share moments that reflect your mood and activities",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  QMultiImagePicker(
                    label: "Select Photos",
                    value: selectedPhotos,
                    maxImages: 5,
                    hint: "Choose up to 5 photos to share",
                    onChanged: (value) {
                      selectedPhotos = value;
                      setState(() {});
                    },
                  ),
                  if (selectedPhotos.isNotEmpty)
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Share Photos (${selectedPhotos.length})",
                        size: bs.sm,
                        onPressed: () {
                          _sharePhotos();
                        },
                      ),
                    ),
                ],
              ),
            ),

            // Photo Gallery
            Text(
              "Photo Gallery",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              minItemWidth: 200,
              children: filteredPhotos.map((photo) {
                Color moodColor = _getMoodColor(photo["mood"]);
                
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Photo Image
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusMd),
                            topRight: Radius.circular(radiusMd),
                          ),
                          image: DecorationImage(
                            image: NetworkImage("${photo["url"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(150),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${photo["category"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: moodColor.withAlpha(200),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.mood,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${photo["mood"]}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Photo Details
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Text(
                              "${photo["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${photo["description"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                            // Tags
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (photo["tags"] as List).map((tag) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(15),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "#${tag}",
                                    style: TextStyle(
                                      color: infoColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),

                            // Timestamp and Stats
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${photo["timestamp"].toString().split(' ')[1].substring(0, 5)}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.favorite,
                                      size: 14,
                                      color: dangerColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${photo["reactions"]["likes"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Icon(
                                      Icons.comment,
                                      size: 14,
                                      color: infoColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${photo["reactions"]["comments"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: photo["isShared"] ? "Shared" : "Share",
                                    size: bs.sm,
                                    onPressed: photo["isShared"] 
                                        ? null 
                                        : () {
                                            _toggleShare(photo);
                                          },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.more_vert,
                                  size: bs.sm,
                                  onPressed: () {
                                    // navigateTo('PhotoDetailsView')
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

            if (filteredPhotos.isEmpty)
              Container(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  children: [
                    Icon(
                      Icons.photo_library,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No photos found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Start sharing your moments with photos",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(15),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Take Photo",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('CameraView')
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "View Gallery",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('FullGalleryView')
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
      ),
    );
  }

  void _sharePhotos() {
    if (selectedPhotos.isEmpty) return;

    // Simulate sharing process
    ss("${selectedPhotos.length} phoss('Next page') shared successfully!");
    
    setState(() {
      selectedPhotos.clear();
    });
  }

  void _toggleShare(Map<String, dynamic> photo) {
    setState(() {
      photo["isShared"] = !photo["isShared"];
    });
    
    String message = photo["isShared"] 
        ? "Photo shared with your support team"
        : "Photo removed from shared gallery";
    ss(message);
  }

  Color _getMoodColor(String mood) {
    switch (mood.toLowerCase()) {
      case "happy":
        return successColor;
      case "energetic":
        return warningColor;
      case "focused":
        return primaryColor;
      case "calm":
        return infoColor;
      case "accomplished":
        return successColor;
      case "proud":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
