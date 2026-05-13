import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaLivePhotosView extends StatefulWidget {
  const PpaLivePhotosView({super.key});

  @override
  State<PpaLivePhotosView> createState() => _PpaLivePhotosViewState();
}

class _PpaLivePhotosViewState extends State<PpaLivePhotosView> {
  List<Map<String, dynamic>> livePhotos = [
    {
      "id": 1,
      "thumbnail": "https://picsum.photos/300/200?random=1&keyword=child",
      "title": "Baby's First Steps",
      "location": "Home",
      "date": "2024-03-15",
      "size": "8.2 MB",
      "duration": "3s",
      "resolution": "1080p",
      "type": "Portrait",
      "favorite": true,
      "motionIntensity": "High",
      "autoPlay": true
    },
    {
      "id": 2,
      "thumbnail": "https://picsum.photos/300/200?random=2&keyword=nature",
      "title": "Waterfall Mist",
      "location": "Yosemite National Park",
      "date": "2024-03-14",
      "size": "12.5 MB",
      "duration": "3s",
      "resolution": "4K",
      "type": "Landscape",
      "favorite": false,
      "motionIntensity": "Medium",
      "autoPlay": false
    },
    {
      "id": 3,
      "thumbnail": "https://picsum.photos/300/200?random=3&keyword=pet",
      "title": "Dog Playing Fetch",
      "location": "Central Park",
      "date": "2024-03-13",
      "size": "6.7 MB",
      "duration": "3s",
      "resolution": "1080p",
      "type": "Action",
      "favorite": true,
      "motionIntensity": "High",
      "autoPlay": true
    },
    {
      "id": 4,
      "thumbnail": "https://picsum.photos/300/200?random=4&keyword=food",
      "title": "Cooking Steam",
      "location": "Kitchen",
      "date": "2024-03-12",
      "size": "5.3 MB",
      "duration": "3s",
      "resolution": "720p",
      "type": "Macro",
      "favorite": false,
      "motionIntensity": "Low",
      "autoPlay": false
    },
    {
      "id": 5,
      "thumbnail": "https://picsum.photos/300/200?random=5&keyword=wedding",
      "title": "Wedding Dance",
      "location": "Wedding Venue",
      "date": "2024-03-11",
      "size": "15.8 MB",
      "duration": "3s",
      "resolution": "4K",
      "type": "Portrait",
      "favorite": true,
      "motionIntensity": "Medium",
      "autoPlay": true
    },
  ];

  List<Map<String, dynamic>> filteredPhotos = [];
  String selectedType = "All";
  String selectedResolution = "All";
  String searchQuery = "";
  bool showFavoritesOnly = false;
  bool autoPlayEnabled = true;

  @override
  void initState() {
    super.initState();
    filteredPhotos = livePhotos;
  }

  void _filterPhotos() {
    filteredPhotos = livePhotos.where((photo) {
      bool matchesType = selectedType == "All" || photo["type"] == selectedType;
      bool matchesResolution = selectedResolution == "All" || photo["resolution"] == selectedResolution;
      bool matchesFavorite = !showFavoritesOnly || (photo["favorite"] as bool);
      bool matchesSearch = searchQuery.isEmpty ||
          "${photo["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${photo["location"]}".toLowerCase().contains(searchQuery.toLowerCase());
      return matchesType && matchesResolution && matchesFavorite && matchesSearch;
    }).toList();
    setState(() {});
  }

  Color _getMotionIntensityColor(String intensity) {
    switch (intensity) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Photos"),
        actions: [
          IconButton(
            icon: Icon(autoPlayEnabled ? Icons.pause_circle : Icons.play_circle),
            onPressed: () {
              autoPlayEnabled = !autoPlayEnabled;
              setState(() {});
              ss(autoPlayEnabled ? "Auto-play enabled" : "Auto-play disabled");
            },
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              ss("Live Photo capture mode activated");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Live Photo Info Banner
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.live_help,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Live Photos",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Photos that come alive with motion and sound. Press and hold to view the 3-second moment.",
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

            SizedBox(height: spMd),

            // Search and Filter Section
            Container(
              padding: EdgeInsets.all(spSm),
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
                        child: QTextField(
                          label: "Search live photos...",
                          value: searchQuery,
                          onChanged: (value) {
                            searchQuery = value;
                            _filterPhotos();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.search,
                        size: bs.sm,
                        onPressed: _filterPhotos,
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Filter by Type",
                          items: [
                            {"label": "All Types", "value": "All"},
                            {"label": "Portrait", "value": "Portrait"},
                            {"label": "Landscape", "value": "Landscape"},
                            {"label": "Action", "value": "Action"},
                            {"label": "Macro", "value": "Macro"},
                          ],
                          value: selectedType,
                          onChanged: (value, label) {
                            selectedType = value;
                            _filterPhotos();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Filter by Resolution",
                          items: [
                            {"label": "All Resolutions", "value": "All"},
                            {"label": "4K", "value": "4K"},
                            {"label": "1080p", "value": "1080p"},
                            {"label": "720p", "value": "720p"},
                          ],
                          value: selectedResolution,
                          onChanged: (value, label) {
                            selectedResolution = value;
                            _filterPhotos();
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Show Favorites Only",
                              "value": true,
                              "checked": showFavoritesOnly,
                            }
                          ],
                          value: [
                            if (showFavoritesOnly)
                              {
                                "label": "Show Favorites Only",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            showFavoritesOnly = values.isNotEmpty;
                            _filterPhotos();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Statistics Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Live Photos Collection",
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
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.photo_camera,
                                color: primaryColor,
                                size: 32,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${filteredPhotos.length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Live Photos",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
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
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.favorite,
                                color: dangerColor,
                                size: 32,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${livePhotos.where((photo) => photo["favorite"] as bool).length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                              Text(
                                "Favorites",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
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
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.storage,
                                color: warningColor,
                                size: 32,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${((livePhotos.fold(0.0, (sum, item) => sum + (double.tryParse("${item["size"]}".replaceAll(" MB", "")) ?? 0.0)))).toStringAsFixed(1)} MB",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Total Size",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Live Photos Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredPhotos.map((photo) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(radiusMd),
                        ),
                        child: Stack(
                          children: [
                            Image.network(
                              "${photo["thumbnail"]}",
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            // Live Photo Indicator
                            Positioned(
                              top: spXs,
                              left: spXs,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(200),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.album,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "LIVE",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Duration
                            Positioned(
                              bottom: spXs,
                              right: spXs,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(200),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${photo["duration"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            // Motion Intensity
                            Positioned(
                              top: spXs,
                              right: spXs,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getMotionIntensityColor("${photo["motionIntensity"]}").withAlpha(200),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${photo["motionIntensity"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            // Favorite Icon
                            if (photo["favorite"] as bool)
                              Positioned(
                                bottom: spXs,
                                left: spXs,
                                child: Icon(
                                  Icons.favorite,
                                  color: dangerColor,
                                  size: 20,
                                ),
                              ),
                            // Play overlay
                            if (autoPlayEnabled && (photo["autoPlay"] as bool))
                              Center(
                                child: Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(150),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${photo["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 12,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    "${photo["location"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${photo["type"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${photo["resolution"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "${photo["size"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${DateTime.parse(photo["date"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "View",
                                    size: bs.sm,
                                    onPressed: () {
                                      ss("Viewing Live Photo: ${photo["title"]}");
                                    },
                                  ),
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: photo["favorite"] as bool ? Icons.favorite : Icons.favorite_border,
                                  size: bs.sm,
                                  onPressed: () {
                                    photo["favorite"] = !(photo["favorite"] as bool);
                                    setState(() {});
                                    ss(photo["favorite"] as bool ? "Added to favorites" : "Removed from favorites");
                                  },
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.share,
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Sharing Live Photo: ${photo["title"]}");
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

            SizedBox(height: spMd),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Actions",
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
                        child: QButton(
                          label: "Capture Live Photo",
                          icon: Icons.camera_alt,
                          size: bs.md,
                          onPressed: () {
                            ss("Live Photo capture mode activated");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Import Live Photos",
                          icon: Icons.photo_library,
                          size: bs.md,
                          onPressed: () {
                            ss("Live Photo import started");
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
}
