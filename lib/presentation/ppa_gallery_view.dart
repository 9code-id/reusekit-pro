import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaGalleryView extends StatefulWidget {
  const PpaGalleryView({super.key});

  @override
  State<PpaGalleryView> createState() => _PpaGalleryViewState();
}

class _PpaGalleryViewState extends State<PpaGalleryView> {
  String selectedView = "grid";
  String selectedFilter = "all";
  bool isSelectionMode = false;
  Set<String> selectedImages = {};
  
  List<Map<String, dynamic>> filterOptions = [
    {"id": "all", "label": "All Photos", "count": 245},
    {"id": "recent", "label": "Recent", "count": 24},
    {"id": "favorites", "label": "Favorites", "count": 18},
    {"id": "videos", "label": "Videos", "count": 12},
    {"id": "panorama", "label": "Panorama", "count": 8},
    {"id": "hdr", "label": "HDR", "count": 15},
  ];

  List<Map<String, dynamic>> albums = [
    {
      "id": "1",
      "name": "Vacation 2024",
      "coverImage": "https://picsum.photos/200/200?random=1&keyword=vacation",
      "photoCount": 45,
      "created": "2024-03-15"
    },
    {
      "id": "2",
      "name": "Family Events",
      "coverImage": "https://picsum.photos/200/200?random=2&keyword=family",
      "photoCount": 32,
      "created": "2024-03-10"
    },
    {
      "id": "3",
      "name": "Nature Photography",
      "coverImage": "https://picsum.photos/200/200?random=3&keyword=nature",
      "photoCount": 67,
      "created": "2024-03-05"
    },
    {
      "id": "4",
      "name": "Urban Exploration",
      "coverImage": "https://picsum.photos/200/200?random=4&keyword=urban",
      "photoCount": 28,
      "created": "2024-02-28"
    },
  ];

  List<Map<String, dynamic>> photos = [
    {
      "id": "1",
      "url": "https://picsum.photos/300/300?random=1&keyword=landscape",
      "type": "photo",
      "date": "2024-03-15",
      "favorite": true,
      "size": "2.3 MB"
    },
    {
      "id": "2",
      "url": "https://picsum.photos/300/300?random=2&keyword=portrait",
      "type": "photo",
      "date": "2024-03-14",
      "favorite": false,
      "size": "1.8 MB"
    },
    {
      "id": "3",
      "url": "https://picsum.photos/300/300?random=3&keyword=nature",
      "type": "video",
      "date": "2024-03-13",
      "favorite": true,
      "size": "12.5 MB",
      "duration": "1:23"
    },
    {
      "id": "4",
      "url": "https://picsum.photos/300/300?random=4&keyword=city",
      "type": "photo",
      "date": "2024-03-12",
      "favorite": false,
      "size": "2.1 MB"
    },
    {
      "id": "5",
      "url": "https://picsum.photos/300/300?random=5&keyword=sunset",
      "type": "panorama",
      "date": "2024-03-11",
      "favorite": true,
      "size": "4.2 MB"
    },
    {
      "id": "6",
      "url": "https://picsum.photos/300/300?random=6&keyword=architecture",
      "type": "hdr",
      "date": "2024-03-10",
      "favorite": false,
      "size": "3.1 MB"
    },
    {
      "id": "7",
      "url": "https://picsum.photos/300/300?random=7&keyword=food",
      "type": "photo",
      "date": "2024-03-09",
      "favorite": true,
      "size": "1.9 MB"
    },
    {
      "id": "8",
      "url": "https://picsum.photos/300/300?random=8&keyword=travel",
      "type": "photo",
      "date": "2024-03-08",
      "favorite": false,
      "size": "2.5 MB"
    },
  ];

  List<Map<String, dynamic>> get filteredPhotos {
    if (selectedFilter == "all") return photos;
    if (selectedFilter == "recent") return photos.take(4).toList();
    if (selectedFilter == "favorites") return photos.where((p) => p["favorite"] == true).toList();
    return photos.where((p) => p["type"] == selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isSelectionMode ? "${selectedImages.length} Selected" : "Gallery"),
        actions: [
          if (isSelectionMode) ...[
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.all(spSm),
                child: Icon(Icons.share),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.all(spSm),
                child: Icon(Icons.delete),
              ),
            ),
            GestureDetector(
              onTap: () {
                isSelectionMode = false;
                selectedImages.clear();
                setState(() {});
              },
              child: Padding(
                padding: EdgeInsets.all(spSm),
                child: Icon(Icons.close),
              ),
            ),
          ] else ...[
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.all(spSm),
                child: Icon(Icons.search),
              ),
            ),
            GestureDetector(
              onTap: () {
                isSelectionMode = true;
                setState(() {});
              },
              child: Padding(
                padding: EdgeInsets.all(spSm),
                child: Icon(Icons.select_all),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.all(spSm),
                child: Icon(Icons.more_vert),
              ),
            ),
          ],
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Tabs
            Container(
              height: 50,
              child: QHorizontalScroll(
                children: filterOptions.map((filter) {
                  final isSelected = selectedFilter == filter["id"];
                  return GestureDetector(
                    onTap: () {
                      selectedFilter = filter["id"];
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      margin: EdgeInsets.only(
                        left: spSm,
                        right: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${filter["label"]}",
                            style: TextStyle(
                              color: isSelected ? Colors.white : disabledBoldColor,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.white.withAlpha(50) : disabledColor.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${filter["count"]}",
                              style: TextStyle(
                                color: isSelected ? Colors.white : disabledBoldColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            
            // Albums Section
            if (selectedFilter == "all") ...[
              Padding(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Albums",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "View All",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              Container(
                height: 120,
                child: QHorizontalScroll(
                  children: albums.map((album) {
                    return Container(
                      width: 100,
                      margin: EdgeInsets.only(
                        left: spMd,
                        right: spXs,
                      ),
                      child: GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusMd),
                                boxShadow: [shadowSm],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(radiusMd),
                                child: Image.network(
                                  "${album["coverImage"]}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${album["name"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "${album["photoCount"]} photos",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              
              SizedBox(height: spMd),
            ],
            
            // View Toggle
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedFilter == "all" ? "All Photos" : filterOptions.firstWhere((f) => f["id"] == selectedFilter)["label"],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          selectedView = "grid";
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: selectedView == "grid" ? primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            Icons.grid_view,
                            color: selectedView == "grid" ? Colors.white : disabledBoldColor,
                            size: 20,
                          ),
                        ),
                      ),
                      SizedBox(width: spXs),
                      GestureDetector(
                        onTap: () {
                          selectedView = "list";
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: selectedView == "list" ? primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            Icons.list,
                            color: selectedView == "list" ? Colors.white : disabledBoldColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spSm),
            
            // Photos Grid/List
            if (selectedView == "grid")
              Padding(
                padding: EdgeInsets.symmetric(horizontal: spMd),
                child: ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: filteredPhotos.map((photo) {
                    final isSelected = selectedImages.contains(photo["id"]);
                    return GestureDetector(
                      onTap: () {
                        if (isSelectionMode) {
                          if (isSelected) {
                            selectedImages.remove(photo["id"]);
                          } else {
                            selectedImages.add(photo["id"]);
                          }
                          setState(() {});
                        } else {
                          // Open photo viewer
                        }
                      },
                      onLongPress: () {
                        if (!isSelectionMode) {
                          isSelectionMode = true;
                          selectedImages.add(photo["id"]);
                          setState(() {});
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusMd),
                                boxShadow: [shadowSm],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(radiusMd),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.network(
                                    "${photo["url"]}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            
                            // Type Indicator
                            Positioned(
                              top: spXs,
                              right: spXs,
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(150),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: _getTypeIcon(photo["type"]),
                              ),
                            ),
                            
                            // Favorite Indicator
                            if (photo["favorite"] == true)
                              Positioned(
                                top: spXs,
                                left: spXs,
                                child: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(150),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 16,
                                  ),
                                ),
                              ),
                            
                            // Selection Indicator
                            if (isSelectionMode)
                              Positioned(
                                bottom: spXs,
                                right: spXs,
                                child: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: isSelected ? primaryColor : Colors.black.withAlpha(150),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    isSelected ? Icons.check : Icons.circle,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              )
            else
              // List View
              Column(
                children: filteredPhotos.map((photo) {
                  final isSelected = selectedImages.contains(photo["id"]);
                  return GestureDetector(
                    onTap: () {
                      if (isSelectionMode) {
                        if (isSelected) {
                          selectedImages.remove(photo["id"]);
                        } else {
                          selectedImages.add(photo["id"]);
                        }
                        setState(() {});
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spXs,
                      ),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        ),
                        boxShadow: [shadowSm],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(radiusSm),
                              child: Image.network(
                                "${photo["url"]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    _getTypeIcon(photo["type"]),
                                    SizedBox(width: spXs),
                                    Text(
                                      photo["type"].toString().toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    if (photo["favorite"] == true) ...[
                                      Spacer(),
                                      Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 16,
                                      ),
                                    ],
                                  ],
                                ),
                                Text(
                                  "${photo["date"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${photo["size"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isSelectionMode)
                            Icon(
                              isSelected ? Icons.check_circle : Icons.circle,
                              color: isSelected ? primaryColor : disabledBoldColor,
                              size: 24,
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            
            SizedBox(height: spMd),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(
          Icons.camera_alt,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _getTypeIcon(String type) {
    switch (type) {
      case "video":
        return Icon(Icons.play_circle_filled, color: Colors.white, size: 16);
      case "panorama":
        return Icon(Icons.panorama, color: Colors.white, size: 16);
      case "hdr":
        return Icon(Icons.hdr_on, color: Colors.white, size: 16);
      default:
        return Icon(Icons.photo, color: Colors.white, size: 16);
    }
  }
}
